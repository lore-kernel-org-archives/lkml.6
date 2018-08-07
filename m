Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1D7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7999C21477
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCD/QH1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7999C21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733251AbeHGLfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731171AbeHGLfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:35:09 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E28214EE;
        Tue,  7 Aug 2018 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533633703;
        bh=uToHvAFH1IKS+3spuYWJTpIdRwbceljD8L4/PTaiONc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=TCD/QH1w2JuTAHwAWZ98a6Fn+SdQzzygai28gut5LFcO3Q1Z8gK3WWmCPZ9CRg/T8
         gHkLB5SErzC++isXqH06AF8LyuGkstTFLlYBEcbRarID3hCfxuoxFJO79eTf5vL5pp
         9Bc4nqMQZBNLUHUDaCelgjAkU9pZviMFmw3bnYyw=
Received: by mail-wm0-f51.google.com with SMTP id q8-v6so17362633wmq.4;
        Tue, 07 Aug 2018 02:21:43 -0700 (PDT)
X-Gm-Message-State: AOUpUlEazE03s+ENEkYzd4Hq1Zb/At3GCu0k9zZmOvLXqk3wAkwBThwD
        PGw4A5X9coivTqv6o+C6qJ6yA7N0y4AU/4i9X7k=
X-Google-Smtp-Source: AA+uWPxMFF3Hf6K7si0jM+EowfG3hRinHtZ6h6g1tGa83WMxtbRuHQP4SxrnT9/1etdOYK7grtSnQOxi2PyxnZ2x8HU=
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr1040830wme.135.1533633701977;
 Tue, 07 Aug 2018 02:21:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 02:21:41 -0700 (PDT)
In-Reply-To: <CABxcv=k-BS04gZKGQqE1=CLhNk79yOHC9_CcrB6=UJ9xYNqGMg@mail.gmail.com>
References: <20180725155302.4718-1-krzk@kernel.org> <CABxcv=k-BS04gZKGQqE1=CLhNk79yOHC9_CcrB6=UJ9xYNqGMg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 7 Aug 2018 11:21:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfiM0dEOMmV0a9h+QYu8bEkYhT_Wozq24Fo_91ssxofUA@mail.gmail.com>
Message-ID: <CAJKOXPfiM0dEOMmV0a9h+QYu8bEkYhT_Wozq24Fo_91ssxofUA@mail.gmail.com>
Subject: Re: [PATCH] mfd: sec: Export OF module alias table
To:     Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 August 2018 at 01:30, Javier Martinez Canillas <javier@dowhile0.org> wrote:
> Hi Krzysztof,
>
> On Wed, Jul 25, 2018 at 5:53 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> In case of Device Tree platforms, even though the Samsung PMIC sec
>> device is instantiated from DT, the driver is still matched through I2C
>> module alias.  That is because I2C core always reports an I2C module
>> alias instead of DT one.
>>
>
> Just a heads up that this already changed in v4.17 since commit
> af503716ac1 ("i2c: core: report OF style module alias for devices
> registered via OF").

True, I missed that part and blindly followed the old principle.

>
>> This could change in the future so export DT module alias.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  drivers/mfd/sec-core.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>> index ca6b80d08ffc..9613b4257302 100644
>> --- a/drivers/mfd/sec-core.c
>> +++ b/drivers/mfd/sec-core.c
>> @@ -146,6 +146,7 @@ static const struct of_device_id sec_dt_match[] = {
>>                 /* Sentinel */
>>         },
>>  };
>> +MODULE_DEVICE_TABLE(of, sec_dt_match);
>
> This driver can't be built as a module since its config symbol is
> bool, so technically this macro isn't needed. But it's a no-op when
> the driver is built-in so it's harmless to have it.

Indeed. I tried converting it to module but that does not work in all
configurations (regulators are needed early).

Anyway my patch even though not that correct, it should not bring any issues.

Thanks for valuable feedback!

Best regards,
Krzysztof
