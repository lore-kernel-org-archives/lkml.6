Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F85C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F072098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlrg1QHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F072098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbeIYAoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:44:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33823 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbeIYAoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:44:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id y10-v6so3427527lfj.1;
        Mon, 24 Sep 2018 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sgEU0lMUDnTpbyLnfg8wBEun2v33WoHRbpZG7p+Gqbo=;
        b=Qlrg1QHMM7xTh+9xwP2HvnhtkRFbABisc8CfuYovKQTVNN3/pMqflLs07cZgjWs9Ep
         XVB5gu8Y96NQ8BtILtr/27JpyHmg/yByknujX5214eBDd7eEXKc88SBHMtcFKtXSz8ML
         I5Y54pVKitVz95GeaNH5Wdc3z60vIjQkr4dsywJsjbur226SuSBa59A25iKz/q99pLSQ
         ugC2kB8CPvEW1DK0QXJXpfCs+Uv8xCibY50DmVVAD/Et5VXpmMSVAa9fRLpIaQucCxw8
         rAhcoYYIP11FdjbzCXz4JsK9zoGwk9yiY8A3Om8o5aM3lUvpzdcHE53Gtw9731TyIqC2
         c7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sgEU0lMUDnTpbyLnfg8wBEun2v33WoHRbpZG7p+Gqbo=;
        b=DzrtMEFGtDIMenzBkEeq04yDzzpmNk04+e37kOTAzcS7GaYfQbSyL6tyne4sC2NUmC
         ulmNtl/D1t4JZpnq10OdPZYN3WHeSVYtW4JZRWgsbofkCmkq/BzGYlDfDVfBT2e4thBd
         jA3H2/QBZS/sxjroIGFBBjstraqTw5VJbCcaizOS8arKbh6Tzb1nkLS9ggrgK1f3X5Yx
         oqpHp3kpzHuvPRH5aUJim0ewtN5TKK4Va8itgIujQl+PNcJLdwGoHkyaKHZn8HJRcD+9
         FxiiVboAG2ol5P7bmlv4fZGfcPyA5eAbIVbo0R5AdcirwMZIJGf0v1ZdmVYl7K3wwCoE
         zWsQ==
X-Gm-Message-State: ABuFfog7TowSlxbKcJVkZiUW49Wyl/pc9QSQR0GUy6b8oaOiK11P85yn
        2Mp+aslMimt7qhe/K59L8C4t+R4e
X-Google-Smtp-Source: ACcGV61feGYSOZmmiGJPIY6bcM/MGRRv1XeU38NOZSQkoXULHooKt4hpVzb4WEzFZsx1RnP2IXG+8A==
X-Received: by 2002:a19:ae15:: with SMTP id f21-v6mr90935lfc.86.1537814483525;
        Mon, 24 Sep 2018 11:41:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id m88-v6sm11740lje.14.2018.09.24.11.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 11:41:22 -0700 (PDT)
Subject: Re: [PATCH v4 03/20] iommu/tegra: gart: Ignore devices without IOMMU
 phandle in DT
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-4-digetx@gmail.com> <20180924100525.GE21032@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8b3ece56-fda6-4e74-f69f-1e68b138e973@gmail.com>
Date:   Mon, 24 Sep 2018 21:41:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924100525.GE21032@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 1:05 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:36AM +0300, Dmitry Osipenko wrote:
>> GART can't handle all devices, hence ignore devices that aren't related
>> to GART. IOMMU phandle must be explicitly assign to devices in the device
>> tree.
> 
> I think technically the GART can indeed handle all devices since it is
> just a physical address region that can be used to remap other physical
> addresses. That's not to say that doing so would be a good idea. So the
> commit message here is slightly confusing, but other than that the idea
> is good, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 

It shouldn't be able to serve something like SDHCI, though I haven't
tried to verify that.
