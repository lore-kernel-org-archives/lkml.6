Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D78ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A92098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mct8FZfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155A92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbeIYAJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:09:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38678 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeIYAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:09:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so19119030ljc.5;
        Mon, 24 Sep 2018 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nUkO3oN2psofd495zhdgNG0k7CH8KswwaYCaY4we4CU=;
        b=Mct8FZfYGPRKpLodfkE408tjj8ZAxRsrWhebGRKdYM2uLQ11NSpRYnBMEX+kwHP13b
         FGcQF2lltWqI3LRBDFBfpv4TF89U35kWiQLtbaaxEH28f/z9nUe6/FZCUk5Ctb3/Hkxz
         J/Wq3utjjqfagMuvN0GUOLJwiTREFYLEvAg3IG25bjb1ZuhrJ/P5rScoXHXTUSJEHGQ4
         axFzmMA2U5j4K2mGTW2XVwnXZEW5BU3EvKfaMVc+b0XAyYewkJ5/Gq0JRzW6wF3G45Cx
         VNNomW4kIxLSCw5DQQbF4WYlIUkGYAYdZSNJQH07aF47IGW+9xE/g+/OQQAtRJo0U1c3
         VP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUkO3oN2psofd495zhdgNG0k7CH8KswwaYCaY4we4CU=;
        b=mrb5R66d2tCGFBa/kKDLhi9gqV1QmDoj2lUSGZ9SYLaMa7r4D9a6Dqt+h+S1gCbFQ1
         ltX6tY3LEJRWx1gqfX4a67sTza1aq3edAuJLj9wwUT8JG6L0mZKahFMevLoN2hA+jVeX
         EhLDfiZ9vcTzYkgoyhIE4fqB2LY8KTZJQ5SnG+tcmRV7E5J+ufm8xaZqzTl3OI8ZMNIK
         Xlt/iHwW6zU/O91PpK+twjf1MlCzqjkAKZ7cUeWn/+UrsjM+oOMzZc3qf/Y561MB16L9
         67Rsbnka8FTI76xyCsIDTctCISLeVA5SxU70VVzVrHDWZvaTgBdjYxNk4bswmoXhkgtk
         OCKg==
X-Gm-Message-State: ABuFfogsNJx04vrT+Cw6aUrhDoUgXbntgEp8zK8L2Wj4vOwXGjUUtWEj
        ZPJZEwxUDZspw25L+T7x3xIRvWn1
X-Google-Smtp-Source: ACcGV63hBCuBjxEnLj00g6Q7FX9jsYfcvOT0Am8WBdnA39QVM6f483gGFJaY2dAZIu+3R4CCj+FRpg==
X-Received: by 2002:a2e:8346:: with SMTP id l6-v6mr7921ljh.72.1537812350398;
        Mon, 24 Sep 2018 11:05:50 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id u2-v6sm6692858ljg.55.2018.09.24.11.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:05:49 -0700 (PDT)
Subject: Re: [PATCH v4 18/20] iommu/tegra: gart: Don't detach devices from
 inactive domains
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-19-digetx@gmail.com> <20180924110047.GO21032@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8be80297-3b13-ece6-a5bf-873cc7877989@gmail.com>
Date:   Mon, 24 Sep 2018 21:05:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924110047.GO21032@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 2:00 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:51AM +0300, Dmitry Osipenko wrote:
>> There could be unlimited number of allocated domains, but only one domain
>> can be active at a time. Hence devices must be detached only from the
>> active domain.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Do we have a mechanism of switching out different domains? I don't think
> we do, so I'm wondering if perhaps a better solution to this would be to
> just refuse to create more than one domain in the first place. That
> would also allow us to get rid of the global variable gart_handle.

That's what was done in v1, Robin Murphy suggested that it will be
better not to restrict allocation of unpopulated domains. It is
mentioned in the changelog, see comment to v2 changes.
