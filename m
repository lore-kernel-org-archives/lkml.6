Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A84C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82A520880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K17nuKsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82A520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeIYTtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:49:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38857 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:49:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so21779643ljc.5;
        Tue, 25 Sep 2018 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e4EnJUZt4PcsuI0RkCxnc/T2R/e6LXuD486RYhyGkm4=;
        b=K17nuKsz6hNqjB5QtIYkrkem+m5zaw8cRTcDu9J3HFF7Vq8+5U5Mi6yzX72F/+eWjx
         dtpgbFm13Q0PQibN1Z2dlQxkils5orX3U5qlJJ27Dy+Mjy+nKUFs6WKRvY5YAgEscCoG
         PZjM1NsV1eq8iFmyYHaS3UF40cV+R71LEAV2zKc14/VJkh1nntYrK2jaSOx8NfAakH/+
         6I7wvp/FG3ulZSXcKw/Ty2DHwbMTMeB6khJaxyHpBF2ud3reodldbSEi8JclWvGn3/7E
         YvPs6NPTd5GROMcv2fklHoluceor8maJcFyL5s3q22s5yIQL/Y9F/iTi8n0UAFRkgtbT
         Y3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e4EnJUZt4PcsuI0RkCxnc/T2R/e6LXuD486RYhyGkm4=;
        b=NvaNh7gGL46qokYwguHTxIEEm4m+F63Dt+cfJh4ymjZVTuKQ1h79e5YtmUgCRSKlCx
         8ON+yKCjyxaGKXlKiq+IYlafWkVLO39BGAtUVXgUzNG1q9XJSd/Mb6wrhNtk4JFLWcrH
         SXcnln1b+Ks8UdOGY7MkLMxgn1RnTCMqFxRbsNDgyHE0D+BGIhda0Q02jULfc6JtLhW5
         zhc2pW29qxqm7jxnr8XqHZHStYDw7K/tZVrUox+D+umrvCbsn9tX3SAerjH4ey1+Sov3
         sy/ptKCLLb6NdK3gD2ywkrf9gHwQK3/EOywGqMUZq+nGA47TEPrqihDr3El76tonftkz
         aurg==
X-Gm-Message-State: ABuFfojaKC3aTxLUhIfRzVi+s2+26TCU5JAWWJzGDCxfvoqRSinBtYyX
        wN1ZVv4EgtkOtEJzUIRQCTH6uJSZ
X-Google-Smtp-Source: ACcGV60LPTO2dpSWXNs5X2Dl08ef8qNxZ95JiDNmTYwhnoTgz0bHu1OxVvTIe0hmJJE1+oRNDNU35A==
X-Received: by 2002:a2e:2096:: with SMTP id g22-v6mr963998lji.37.1537882922349;
        Tue, 25 Sep 2018 06:42:02 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm427749ljk.20.2018.09.25.06.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 06:42:01 -0700 (PDT)
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
 <8be80297-3b13-ece6-a5bf-873cc7877989@gmail.com> <20180925100424.GG7097@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <57704439-66f3-2548-093c-b5a2fc04ee14@gmail.com>
Date:   Tue, 25 Sep 2018 16:41:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925100424.GG7097@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 1:04 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 09:05:48PM +0300, Dmitry Osipenko wrote:
>> On 9/24/18 2:00 PM, Thierry Reding wrote:
>>> On Mon, Sep 24, 2018 at 03:41:51AM +0300, Dmitry Osipenko wrote:
>>>> There could be unlimited number of allocated domains, but only one domain
>>>> can be active at a time. Hence devices must be detached only from the
>>>> active domain.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/iommu/tegra-gart.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> Do we have a mechanism of switching out different domains? I don't think
>>> we do, so I'm wondering if perhaps a better solution to this would be to
>>> just refuse to create more than one domain in the first place. That
>>> would also allow us to get rid of the global variable gart_handle.
>>
>> That's what was done in v1, Robin Murphy suggested that it will be
>> better not to restrict allocation of unpopulated domains. It is
>> mentioned in the changelog, see comment to v2 changes.
> 
> Okay, fine.

Thanks, taking as ACK.
