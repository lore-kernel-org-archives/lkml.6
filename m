Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032855AbeCAQTe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:19:34 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38962 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032539AbeCAQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:19:31 -0500
X-Google-Smtp-Source: AG47ELuX8Nx+vJR/HfKvNlfyPYjVPjza8H/723GO+8rKPNTEPxwBWdKjffsQBJo20ghrmikczU+fmth+oNk+mIPcp6I=
MIME-Version: 1.0
In-Reply-To: <20180228063132.GI3217@dragon>
References: <20180226144943.9835-1-andrew.smirnov@gmail.com> <20180228063132.GI3217@dragon>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 1 Mar 2018 08:19:30 -0800
Message-ID: <CAHQ1cqEFMa1dwJ+C-3Zo+KEPmPY5Y9Fm5+7UBwfQKkn6Y_RcYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6: RDU2: Add RAVE SP device
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 10:31 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, Feb 26, 2018 at 06:49:41AM -0800, Andrey Smirnov wrote:
>> With MFD and watchdog drivers for RAVE SP device support added by
>> 538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
>> c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
>> corresponding DT node for RDU2.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Chris Healy <cphealy@gmail.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
>> index 72f52fcecee1..460931089509 100644
>> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
>> @@ -305,6 +305,17 @@
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&pinctrl_uart4>;
>>       status = "okay";
>> +
>> +     rave-sp {
>> +             compatible = "zii,rave-sp-rdu2";
>> +             current-speed = <1000000>;
>> +             status = "okay";
>
> The okay status is to flip the state of devices that are initially
> disabled.  I think it's unnecessary for the case here.

Good point, will respin v2 without that bit shortly.

Thanks,
Andrey Smirnov
