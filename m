Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EEC00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8061420840
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN2yG6j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfBXDU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 22:20:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42793 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfBXDU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 22:20:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so2896283pgl.9;
        Sat, 23 Feb 2019 19:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yiEhL0DGWWum/tuGZwjPTbXUSmgMoh8TiLPmsv85WSw=;
        b=bN2yG6j4ZAgHA0RKnJA1/KiYbgp2tIcvSiJAh/tRE2byCafAFshloQTv5u74uwO2vF
         +2PzIn2wCXbo2hx6UynbB8bMMhQfMyHES+4uol2MtrQRxtGtOEWklumSik7YYjuKXZtc
         EeKou036QEjedNaOH8k4p26kBDMA/nwVRBrFTQN2Ft13Bm5X9A/aZAnM5gkh146VZkW7
         Ori9ea/+BWiYRgt7M7QXAHW2NrtUSOvDRBZIFwikw7Sbxr9COy0orYAZ+1lB2Y3PBTQ1
         /j34DjE+4uJtRf/1LJmhmE8C3FZQ/S0UMbGPhLkqY8uDJ9OVYiUUQZnPwo+zJfeASGWG
         Scbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yiEhL0DGWWum/tuGZwjPTbXUSmgMoh8TiLPmsv85WSw=;
        b=DfhYcH5tizK+sSH6MzJZ1mcl9w8rOmAZUm+mrJQ7R+LRxdIdduaAucAYK5xUf69pE2
         kvwbuBiNOfGGIp6p5FO2hGd3R27XW6ZT5+W5gYV5rZ5euhVMJCNb0o+kwzbNn0F8XMbn
         ZXi2bE9MYB1hUtGkQJz0mG10Zm+EOr316w/df+NONG0HEijGd2tUyaza0XqsRjXzlGV1
         8KnDMyvvm2P/MBABA3zeGNSNJH3dkUNh9/F5ybORGO6QCm+ftG2OwLE/czs1CToi8yU2
         YL3MgiPJYmcee9hn0tf2n2z0CLwT80BPUMSnDysXxNg4bTOpzbnqEhezh6NHvtxeRWg5
         pcgg==
X-Gm-Message-State: AHQUAuYgtTrBqTyX/WCNvJfMEBlqjkRNnWq+5NcLLQIxsZ3/wYWp0dFl
        sQaeUczJGKw0B+Pud9vC7MqaHC55
X-Google-Smtp-Source: AHgI3IbiOQqXR+RZh8mTx3E1ae/YnWqBttKtFDpsey9lZvn/HvlENxDb/VSTHAj+2q4kNtp9c5wLcQ==
X-Received: by 2002:a63:aa46:: with SMTP id x6mr11416392pgo.452.1550978425602;
        Sat, 23 Feb 2019 19:20:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d131sm9830977pfd.108.2019.02.23.19.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 19:20:24 -0800 (PST)
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
To:     Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>
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
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
Date:   Sat, 23 Feb 2019 19:20:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/19 7:04 PM, Anson Huang wrote:
> Hi, Guenter/Rob
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
>> Roeck
>> Sent: 2019年2月24日 1:08
>> To: Rob Herring <robh@kernel.org>; Anson Huang <anson.huang@nxp.com>
>> Cc: mark.rutland@arm.com; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
>> catalin.marinas@arm.com; will.deacon@arm.com; wim@linux-watchdog.org;
>> Aisheng Dong <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel
>> Baluta <daniel.baluta@nxp.com>; Andy Gross <andy.gross@linaro.org>;
>> horms+renesas@verge.net.au; heiko@sntech.de; arnd@arndb.de;
>> bjorn.andersson@linaro.org; jagan@amarulasolutions.com;
>> enric.balletbo@collabora.com; marc.w.gonzalez@free.fr; olof@lixom.net;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-watchdog@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>
>> Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog
>> binding
>>
>> On 2/22/19 11:52 AM, Rob Herring wrote:
>>> On Mon, Feb 18, 2019 at 06:53:48AM +0000, Anson Huang wrote:
>>>> Add i.MX8QXP system controller watchdog binding.
>>>>
>>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>>> ---
>>>> Changes since V1:
>>>> 	- update dts node name to "watchdog";
>>>> ---
>>>>    Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10
>> ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>>>> b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>>>> index 4b79751..f388ec6 100644
>>>> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>>>> @@ -136,6 +136,12 @@ Required properties:
>>>>    			   resource id for thermal driver to get temperature
>> via
>>>>    			   SCU IPC.
>>>>
>>>> +Watchdog bindings based on SCU Message Protocol
>>>> +------------------------------------------------------------
>>>> +
>>>> +Required properties:
>>>> +- compatible: should be "fsl,imx8qxp-sc-wdt";
>>>> +
>>>>    Example (imx8qxp):
>>>>    -------------
>>>>    lsio_mu1: mailbox@5d1c0000 {
>>>> @@ -188,6 +194,10 @@ firmware {
>>>>    			tsens-num = <1>;
>>>>    			#thermal-sensor-cells = <1>;
>>>>    		};
>>>> +
>>>> +		watchdog: watchdog {
>>>> +			compatible = "fsl,imx8qxp-sc-wdt";
>>>
>>> As-is, there's no reason for this to be in DT. The parent node's
>>> driver can instantiate the wdog.
>>>
>>
>> As the driver is currently written, you are correct, since it doesn't accept
>> watchdog timeout configuration through devicetree.
>>
>> Question is if that is intended. Is it ?
> 
> I am a little confused, do you mean we no need to have "watchdog" node in side "scu"
> node? Or we need to modify the watchdog node's compatible string to " fsl,imx-sc-wdt" to make
> it more generic for other platforms? If yes, I can resend the patch series to modify it.
>   

I think Rob suggested that the SCU parent driver should instantiate the watchdog
without explicit watchdog node. That would be possible, but it currently uses
devm_of_platform_populate() to do the instantiation, and changing that would
be a mess. Besides, it does sem to me that your suggested node would describe
the hardware, so I am not sure I understand the reasoning.

For my part I referred to
	watchdog_init_timeout(imx_sc_wdd, DEFAULT_TIMEOUT, &pdev->dev);
in the driver, which guarantees that the timeout property will not be used
to set the timeout. A more common implementation would have been

	imx_sc_wdd->timeout = DEFAULT_TIMEOUT;
	ret = watchdog_init_timeout(imx_sc_wdd, timeout, &pdev->dev);

where 'timeout' is the module parameter. Which is actually not used in your driver.
Hmm ... I wasn't careful enough with my review. The timeout initialization as-is
doesn't make sense. I'll comment on that in the patch.

Guenter

> Anson.
> 
>>
>> Thanks,
>> Guenter

