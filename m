Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0F2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA5E240E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLJBxzas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA5E240E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeGEL3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:29:51 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37340 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753634AbeGEL3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:29:49 -0400
Received: by mail-it0-f43.google.com with SMTP id p17-v6so11835387itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 04:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DKHnT0ve43eMbzTr1PbSB/1kRrYg1Y9KmrOVDlBXjm8=;
        b=dLJBxzas1aOE8E4PokKRq86WB0IyhALnQl9wIVtM/Sygd/ztBQKb7ki5sfrYTvZLgb
         iZ3fuDz74ocQF+xfQrJCd4CbF5maEGvyC1F6sTXqlJhXM/e0yuS9bdfNszkhehR5+zv6
         TiuryjG5HIPfIBap9npbBLMOUt5MZqGdhIoJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DKHnT0ve43eMbzTr1PbSB/1kRrYg1Y9KmrOVDlBXjm8=;
        b=jfw5GjnhuPCn/uZhJZCQvA6vXkmOamoUpunfNsHwVwD6CYrqV2y8q8F6s54zUwIzPR
         dZ16ETLK3di/pmhrR/cy7cgfC373Os88rqjfUJrO2Dor58cmpyIZma7BUEqvz/Uo/jWa
         S3PZuRKzCkAMZWTcjK4RwDjANNKxGcFt6+iZKV1gZVcxcWKDJQouMm6jxkoGQKJUqbaO
         +KS2bKkQb+86AO30+Zp68z0r9PlWC2hzzYM5sHhNAk/WNsKOPKz6bgTOGpoD3l5dJEez
         74AOCC/OtqVG033EqxL0fUkIShnMJsuqTGdsRKve7Jpz2GV64ZYLmO5qSr8HKGorV3YL
         Txgg==
X-Gm-Message-State: APt69E3+k9wWeaY3OmNuGWULT76he3n95YmlP7zjPCsxw0grmagY01go
        mHuIpTcOfHymlJcxfpS7PCa6c7hHUzjliPKl9bEf1g==
X-Google-Smtp-Source: AAOMgpfecmyPrwG2mN6G8ETJpT0Uey73dYe2TcbSY6z/KzX4oHQvLOJO4Eh9OKS0UxUAFuFXVgFGAcEkjYw4Yo/d0jY=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr4862093itc.102.1530790188984;
 Thu, 05 Jul 2018 04:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 04:29:48 -0700 (PDT)
In-Reply-To: <69f6122b8a69f1ab41d2ef8274321689@agner.ch>
References: <20180704150745.21003-1-stefan@agner.ch> <b2cc30701b1c38cd0c40736d04407424@agner.ch>
 <CAPDyKFqhUBteUNwE4aice5kxNkTX-0mHiJELhA57hwEmPH6v6A@mail.gmail.com> <69f6122b8a69f1ab41d2ef8274321689@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 13:29:48 +0200
Message-ID: <CAPDyKFpWzWeXxDfHXpFBboCtJKH97pPotTcmuFigZhET7zA26g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>> Btw, I still get the switching error once during boot-up:
>>>   mmc1: Switching to 3.3V signalling voltage failed
>>
>> I guess the this happens then also at system resume?
>>
>> The core tries first with 3.3 then if it fails, it continues with 1.8V, etc.
>>
>>>
>>> This is due to the call from mmc_set_initial_signal_voltage. It is a bit
>>> unfortunate since this is printed as a warning. Not sure if that could
>>> be prevented somehow?
>>
>> Seems like SDHCI_SIGNALING_330 should not be set, unless 3.3V I/O is
>> supported. That should avoid SDHCI from trying and instead just
>> returning an error code immediately.
>>
>> This seems like a generic issues for all SDHCI variant drivers.
>
> Hm, can we resolve this in a generic fashion?
>
> E.g something like this in sdhci_setup_host():
>
> if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 3200000,
> 3450000))
>         host->flags &= ~SDHCI_SIGNALING_330;

Something like that seems right, but a wider range should be allowed.
2.7V to 3.6V is allowed according to the specs.

Also, vqmmc is optional, so in case it doesn't exist we must not clear
the SDHCI_SIGNALING_330 bit.

Kind regards
Uffe
