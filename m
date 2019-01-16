Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2000C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1B920675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjfZjRt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393236AbfAPNl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:41:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42647 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfAPNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:41:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so4890952lfh.9;
        Wed, 16 Jan 2019 05:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNeOrhpxA3cn37HlVU79MbUA2cFrVM+B0iaxk6AREuY=;
        b=fjfZjRt25svWBo7NBOawWLmeDKr49ZN1jgHDuZc2m3cZVK6T7l4VlTFBhrK/6Qyr10
         LINFPOD8SDT03delxNPNFWxJ7CvX85HuWI2s0iDgbJvm4Ed+ncM0JpzrRfTfKi9NnCIB
         O17Y82NIX8CCOBMS9r5flce5sAKzmgpx9WDzFPKeVaEPw0c3I6nd6nCWScPmkaeIEhcU
         G65u1EVBjCtUnK/SfYjmoSLiMtCmMrGlGg7ebsLs4M87kArZ2J2tfchqnj35wSRnungj
         M/T6arLCVjL2ukRXaWxsvt6HsnKoVEoaR4/OQsxeIik5rtLDbajfLL8ulmFXMekD/TS9
         kvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNeOrhpxA3cn37HlVU79MbUA2cFrVM+B0iaxk6AREuY=;
        b=qRGCWE5qZxnWeTfNSGpjofNj/AT4jE/trabPrRst+z9qmer+bRs97pz4klt8ky0d9s
         7y3OQvazdrlwM8/B/zrcW+YAFN2BLw2MxMD/9qHxwfOn13r9LlEmxlXtGDBwcYDdcWtl
         lsL3jEu+rvA4Yvq6ut0xU00wX2Ncj9LZdCF23gfjDMGMUqs4YgrXthPL/vg+iUPMgkJT
         3w9a93kwBuz5wQD4gYigNww3IOi8QZfbudvhp6g19KVRpNqJHkrl18vmBo2BP7Dl8FJ2
         n5yL3vPumW1uEr5QdniVFsUcszDOW3rcQa5VYgfQWz1wqcrb13iP8FG1x5s1b5EFVDCi
         5dmQ==
X-Gm-Message-State: AJcUukeM/rwW74E9WVQ+Tm+YjoxEFhWfnFOtqKPcdlRRO/zvlC9i8uYq
        OtL9QPeFTkp1+I0udbgQf/TMJ8lB
X-Google-Smtp-Source: ALg8bN4BqITNiboAX9ueLA2hVckCaSLMthFt8TOwCWsc2YCSFSrvqMQq30HmazLqIhlzQrj7o9mykg==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr6833636lfg.89.1547646083890;
        Wed, 16 Jan 2019 05:41:23 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-58-198.pppoe.mtu-net.ru. [91.76.58.198])
        by smtp.googlemail.com with ESMTPSA id g3-v6sm1059593lje.50.2019.01.16.05.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:41:23 -0800 (PST)
Subject: Re: [PATCH v7 00/24] Tegra GART driver clean up and optimization
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181212203907.23461-1-digetx@gmail.com>
 <20181217091455.kkxpyojp4r4fyhrw@8bytes.org>
 <bbefe330-d3e8-3eea-0f9e-a2b0b7915120@gmail.com>
 <20190116125534.354irioqwfu36ajj@8bytes.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0254cf29-6fb3-4389-1cb8-e4add71f98d4@gmail.com>
Date:   Wed, 16 Jan 2019 16:41:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116125534.354irioqwfu36ajj@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.01.2019 15:55, Joerg Roedel пишет:
> On Tue, Jan 15, 2019 at 07:33:54PM +0300, Dmitry Osipenko wrote:
>> Should I expect that the patches will appear in the IOMMU git and in
>> -next consequently? Please let me know if there is any problem with
>> the applying of the patches.
> 
> Hmm, I thought I applied these patches already, but obviously they
> didn't show up in the iommu-tree. I have no idea how that happened, but
> they are now applied.
> 
> Thanks for the reminder,
> 
>        Joerg
> 

Thanks!
