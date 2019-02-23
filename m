Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46C7C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ABB20657
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUID6WCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfBWRIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:08:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42289 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBWRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:08:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so2512282plp.9;
        Sat, 23 Feb 2019 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P9zrcJ5ZVjiahSM/zDa8W1CZlUjkwmjyOeaNOp58rtA=;
        b=RUID6WCQvqT7YEb3Z3huI+Ac/gFHoNsWLepWDXdTvYyXGa3R2i/ZDZyeATz3zHE3fo
         M9iZCc3sWeERV27+sc/zgbvTVrxvuqTEKE3faZTIw62ZC4lm9hPwEICgzPlPcGsS8Vga
         hPspYRVIOMoeHbQLvzBnlIKhO1ZTziTPOTrF4gWRRAgJiJOkpLAWLyHsaVV1Fy34nucd
         +D6vRp5C2jzjBU58rlyY7cZnguqS7uJzNp9+AoMZftVe4yz95we8WqHEsjjLZwDnbo6I
         e4FloBI/UF7egCxqJEban8kTTM8knnhChWybCb1mnF7OOK1E/VFfawQrlFFMLIQrn7S7
         PKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P9zrcJ5ZVjiahSM/zDa8W1CZlUjkwmjyOeaNOp58rtA=;
        b=kunCGxKNpqmU4kf956s30Ywhpi9+Dn82kRvXwsY5XF/mOxrJ0Cgs5TEDS/Rq7ptR6z
         5wOrqDTFJsrEkJf/yOHcRkvONrz5eKxKcWm2m90LccNtoTZHfGzk7qwpjJ8v6cW9jWVm
         iZn1lW7kdPyJPxE16AZLX+tAZUEnji0yeTwq5bcAr5a+NqPhi04WYsgglwC4RblBihjD
         BZkcTdcmKN4nqareG76UqOUlHCOjFl4Syq2vRt5E33KVFmlbvqZj1ADvV/i0Z99bhhRB
         isrKKueRgun9o1j+XnkC3C4pjYaWX1CcL7eRQYDvgt/b1cg+80v5rasfIL0252cJbbcp
         WHEg==
X-Gm-Message-State: AHQUAuZ+iFfv0gjRssQJFSfF0mn0QsEArODJMqVS9vJHJDg0/Wyy+Xn2
        CNrAtwPdwbsInLOo1xjspOXu2fKf
X-Google-Smtp-Source: AHgI3IZHgbp9uHcUuzMyBu17th+hht94AVajiXej7g2jrqtrJfnUr7Pfw+r2+DDKiHZ3wpWtfb/4Pw==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr10451224plo.30.1550941693427;
        Sat, 23 Feb 2019 09:08:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u66sm17146417pfi.115.2019.02.23.09.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 09:08:12 -0800 (PST)
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
To:     Rob Herring <robh@kernel.org>, Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
Date:   Sat, 23 Feb 2019 09:08:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222195217.GA22194@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 11:52 AM, Rob Herring wrote:
> On Mon, Feb 18, 2019 at 06:53:48AM +0000, Anson Huang wrote:
>> Add i.MX8QXP system controller watchdog binding.
>>
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> ---
>> Changes since V1:
>> 	- update dts node name to "watchdog";
>> ---
>>   Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>> index 4b79751..f388ec6 100644
>> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>> @@ -136,6 +136,12 @@ Required properties:
>>   			   resource id for thermal driver to get temperature via
>>   			   SCU IPC.
>>   
>> +Watchdog bindings based on SCU Message Protocol
>> +------------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible: should be "fsl,imx8qxp-sc-wdt";
>> +
>>   Example (imx8qxp):
>>   -------------
>>   lsio_mu1: mailbox@5d1c0000 {
>> @@ -188,6 +194,10 @@ firmware {
>>   			tsens-num = <1>;
>>   			#thermal-sensor-cells = <1>;
>>   		};
>> +
>> +		watchdog: watchdog {
>> +			compatible = "fsl,imx8qxp-sc-wdt";
> 
> As-is, there's no reason for this to be in DT. The parent node's driver
> can instantiate the wdog.
> 

As the driver is currently written, you are correct, since it doesn't accept
watchdog timeout configuration through devicetree.

Question is if that is intended. Is it ?

Thanks,
Guenter
