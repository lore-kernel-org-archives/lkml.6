Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B0DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EA520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EA520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeIJVsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:48:07 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:49332 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbeIJVsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:48:07 -0400
Received: from [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46] (unknown [IPv6:2a01:cb1d:1a3:2a00:dacb:8aff:fef1:ed46])
        (Authenticated sender: sed)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id DC5C320040B;
        Mon, 10 Sep 2018 18:52:55 +0200 (CEST)
Subject: Re: [PATCH v3 2/2] ARM: s3c24xx: Correct SD card write protect
 detection on Mini2440
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20180907215446.15160-1-sed@free.fr>
 <20180907215446.15160-2-sed@free.fr>
 <CAJKOXPeYO3VR5LABP3zKYnKckqUBahKPt7MCjzuo3j6oe+d87w@mail.gmail.com>
From:   Cedric Roux <sed@free.fr>
Message-ID: <ba9d81bf-f000-f6ae-30b1-3e922985f655@free.fr>
Date:   Mon, 10 Sep 2018 18:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeYO3VR5LABP3zKYnKckqUBahKPt7MCjzuo3j6oe+d87w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 12:23 PM, Krzysztof Kozlowski wrote:
>>  static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
>> -       .gpio_detect   = S3C2410_GPG(8),
>> -       .gpio_wprotect = S3C2410_GPH(8),
>> -       .set_power     = NULL,
>> -       .ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
>> +       .gpio_detect     = S3C2410_GPG(8),
>> +       .gpio_wprotect   = S3C2410_GPH(8),
>> +       .wprotect_invert = 1,
>> +       .set_power       = NULL,
>> +       .ocr_avail       = MMC_VDD_32_33|MMC_VDD_33_34,
> 
> This looks unexpected... after patch 1 there should be only one change
> - one new line added. What happened here?

This is to align all the '='.

These were spaces before the '=' so I also used spaces.
Should I put TABs instead? I looked in the coding style
and didn't find anything about this specific thing
(maybe I read too fast though).

And if this ends up unaligned because 'wprotect_invert'
requires a second TAB for the others, should I do a separate
commit?

Thanks.

Regards,
Cédric.
