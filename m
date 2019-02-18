Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520B2218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsXI8gY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfBRFQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 00:16:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39579 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfBRFQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 00:16:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so8153708pld.6;
        Sun, 17 Feb 2019 21:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PKFECZ5umUjSMFwIhtRIzVOdsQXCiPiFeK7HIxsdO6k=;
        b=MsXI8gY+iTZ3qCuJ/nuqpcZOdxp2PCJu16sooVcW/D/krbvTMeurpqvoxu2Kdt9Mv1
         qdNTzwJjROOV0fErfPrEe/R/KW3d+NQ3uC5MAc+I0OFu0Z2yOnzsH2pdNB8YT8m2hIJ2
         MtxRzXX6Rxnv8VkXSovZaYOpOqut+YcGNWVN1UGf0bA9qtDPC2fl6MegqvzjuBxfddns
         ZJRhBYvStQfbTM82jZi/Cj6XINbwF1ZStDKHj8OHaFp7Q29+Gs6/9oSuSyN541b9uBW4
         S0m8zQrZx0Ub8qM2gZB3RhqrrY+J9CNfzk1tSLI5hvoxvLMc60FruKes+/k+3myomGbM
         Olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PKFECZ5umUjSMFwIhtRIzVOdsQXCiPiFeK7HIxsdO6k=;
        b=WFXkhOs6cwfghEQsPrNfVa0ga9qmlknq/yHoavGc2SmT1zpdmwREXRGRPrkYJ9U7Ay
         TaJKHN/bRvmPLHekhNhnaq3RDB6rc4RLW8N5Tj85ufA4bX5CXnYvAxHsj/ZBvIKXf+Iz
         F5Q1jzf9MnUUsAUGSQ2WYTtGFPlyurd/JQajzEpLmfQcxEHdmXUtn2Y4US5ChUAsJ5H1
         mOBVtLGSQOLhuLc+ybyoWB9x+cioqy8mjt749OwS97FXXaoTb4huKxZFTNkCSusfORvh
         lnviKlKid4IpvZusJP0bkrxrmw5x2ELEiDizBd/VYcK+wzzSp+1IXSbxqjlwuBh4PMpN
         3Fxw==
X-Gm-Message-State: AHQUAuZ3fjCU0+SdqF6rOkUt2vTKQq/rg66kLevsZrwAJ5ZOuDfwDqSv
        aqhawavRMZBtmuS1XOIds3s=
X-Google-Smtp-Source: AHgI3IZa5g0R8s8ePeEkeeZhbgbIEELaMO+L2D9JgIb4Pf658PwM9TXCuj9dau+3137ZkVwxGg5cig==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr23586735plp.38.1550466986589;
        Sun, 17 Feb 2019 21:16:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e7sm13447966pgv.6.2019.02.17.21.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 21:16:25 -0800 (PST)
Subject: Re: [PATCH V2 0/4] Add i.MX8QXP system controller watchdog support
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <02ea476f-d055-ac12-d1b6-c6caffb14614@roeck-us.net>
Date:   Sun, 17 Feb 2019 21:16:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550454997-4398-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/19 6:01 PM, Anson Huang wrote:
> i.MX8QXP is an ARMv8 Cortex-A35 SoC with a Cortex-M4 system controller inside,
> the system controller manages overall power, clock, secure RTC and watchdog
> etc., so Linux kernel running on A35 needs to communicate with system
> controller for watchdog operation, this system controller watchdog will
> call SMC to trap to EL3 secure world ARM-Trusted-Firmware and then it will
> request system controller to do the watchdog operation via IPC.
> 
> 
And you expect I'll spend the time comparing this version of the patch
series against version 1 and figure out myself what exactly changed ?

Guenter

Below are the patch dependency:
> 
> The dt-binding and imx8qxp.dtsi patch are based on my thermal patch series as below:
> https://patchwork.kernel.org/patch/10800699/
> 
> Anson Huang (4):
>    dt-bindings: fsl: scu: add watchdog binding
>    watchdog: imx_sc: Add i.MX system controller watchdog support
>    arm64: defconfig: add support for i.MX system controller watchdog
>    arm64: dts: freescale: imx8qxp: add watchdog support
> 
>   .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  10 +
>   arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
>   arch/arm64/configs/defconfig                       |   1 +
>   drivers/watchdog/Kconfig                           |  13 ++
>   drivers/watchdog/Makefile                          |   1 +
>   drivers/watchdog/imx_sc_wdt.c                      | 210 +++++++++++++++++++++
>   6 files changed, 239 insertions(+)
>   create mode 100644 drivers/watchdog/imx_sc_wdt.c
> 

