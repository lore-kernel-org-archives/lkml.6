Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94604C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A241208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ypFWEdwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A241208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJSDBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:01:23 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:44167 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeJSDBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:01:23 -0400
Received: by mail-io1-f50.google.com with SMTP id s6-v6so11004388ioa.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w4xm8zOz4Oyk1NBASxZcvDS6FOFotxMqvgzG+GTdcYU=;
        b=ypFWEdwycDX/XaNkIrNHFytBpyID9wqAGJCNfOlOLwB+Vap/hvtz/D3TU3CA0wQith
         ydwAH6mmOVOxRXgOMub5Kct0lvZq3Xsjme0M8wBLFsCy5rJM/kEO1dbPUGGcpaKM3Iba
         H3337skfkJdy/Q/nbXirLIdotIjv99BC61koUCsgBhx8aTATfhS5jbytctTmHTM/AuST
         44/WwhXRSW9hafiJF/lknUyGlAK/8vkMdmTDCCPYxWiLhSSvDE6iDhu2XgVZst0hTIsB
         WewDk/NI4bZN5HSWG/HsSaUdAt4Ab2/w5udxdA2CpffwYP/UtyYhxv9sioxYm6NkYoBV
         IIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w4xm8zOz4Oyk1NBASxZcvDS6FOFotxMqvgzG+GTdcYU=;
        b=ozv8z7c47P0vtsunvHTpeZqu0P3IUPH3vbROqZOYW0UpzKCfgzv9NwFAIw1c0WBrk/
         H5QMH4cd+4kLfLktn8fHADjpKvVar4RrGBu2EkD3WGxKzr+0oZyig91QM01XTr5+s3WZ
         ldbRCYHMd0q9XPtfVWbkBRsSVkQY1wBIt+LjblnjfLEGWzPxz6VyXoFPV52tTa6kW4EU
         LqwriH1JTBIkUalItNemeDfofVCHWyVmXpzqx/j2zZXU13sz1fVwdnsBmYhQGh9MBrph
         Q/Bade0ce1umxzBA1DjXQ8+4z0mZqKyqsNvcHr7OHI6jOw/3WjdsWCTuNQtGsEvHvewt
         9hiw==
X-Gm-Message-State: AGRZ1gJf6awWararfGSGjToPlOkBAy69vSADyP6VvZ+EG02NYMGvh9gI
        H/Vy544jqNitfoDuDH8bCyAg74us/OE=
X-Google-Smtp-Source: AJdET5cTgBk9OEcopaJ+l7ZeYRlf3MkaFEoCLeui4AN/nwomHBmxR7XjhGQ0XbmrS24Y4u62svHsVw==
X-Received: by 2002:a6b:d307:: with SMTP id s7-v6mr836127iob.190.1539889140105;
        Thu, 18 Oct 2018 11:59:00 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n187-v6sm366405itb.17.2018.10.18.11.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:58:58 -0700 (PDT)
Subject: Re: bioset changes in 4.18 broke aha1542
To:     Ondrej Zary <linux@rainbow-software.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201810182034.51724.linux@rainbow-software.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ee572ca2-8bbe-cd7d-5c41-8bb2fb5b204d@kernel.dk>
Date:   Thu, 18 Oct 2018 12:58:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201810182034.51724.linux@rainbow-software.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 12:34 PM, Ondrej Zary wrote:
> Hello,
> aha1542 works fine in 4.17 but crashes in 4.18. It's hard to bisect because
> of many commits that don't compile.
> # only skipped commits left to test
> # possible first bad commit: [52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b] fs: convert block_dev.c to bioset_init()
> # possible first bad commit: [a47a28b74a5c7c27bf621276b85ad6c124651236] target: convert to bioset_init()/mempool_init()
> # possible first bad commit: [6f1c819c219f7841079f0f43ab62727a55b0d849] dm: convert to bioset_init()/mempool_init()
> # possible first bad commit: [afeee514ce7f4cab605beedd03be71ebaf0c5fc8] md: convert to bioset_init()/mempool_init()
> # possible first bad commit: [d19936a26658a7a53edd5619d631ee2c2c3151a2] bcache: convert to bioset_init()/mempool_init()
> # possible first bad commit: [b906bbb6997785d9ea0bd3f5585537afa6257c43] lightnvm: convert to bioset_init()/mempool_init()
> 
> Testing manually, a47a28b74a5c7c27bf621276b85ad6c124651236 works.
> 52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b does not compile
> 8ac9f7c1fd1d342e82ddf078425423b050652ba0 does not compile
> e292d7bc63c8f2adb3dfda27910e805f1b6557f9 does not compile
> dad08527525f9a8ac9c7f278864c65f94bc5e9b3 does not compile
> 943cf9f3ca16133dbd00f9a4cbfea46512fcb0e8 works
> ..
> fedc3abe7bd2dcc4c80bcf3cff8708a3908d8219 works
> 04c4950d5b373ba712d928592e05e73510785bca crashes

It looks like the ISA bioset pool isn't being initialized. You should
have messages like this in your dmesg:

isa pool size: 16 pages

(which you do), but also something on the bioset section. Do you have
this one:

pool size: 64 pages

as well?

-- 
Jens Axboe

