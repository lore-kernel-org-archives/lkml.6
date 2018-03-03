Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeCCId7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 03:33:59 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32906 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbeCCId5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 03:33:57 -0500
X-Google-Smtp-Source: AG47ELs1k1VcltROPAENsIYO9Vyuj/HgbHfu5LWLEJDKFmqqZOMG53TW1Pc/xZ9Ly/kfwSojtDoPmQ==
Subject: Re: [PATCH v4 4/6] MIPS: mscc: add ocelot PCB123 device tree
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
 <20180302224811.26840-5-alexandre.belloni@bootlin.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <39189775-0c56-93b6-21e5-ac4d814d1879@cogentembedded.com>
Date: Sat, 3 Mar 2018 11:33:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302224811.26840-5-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/3/2018 1:48 AM, Alexandre Belloni wrote:

> Add a device tree for the Microsemi Ocelot PCB123 evaluation board.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[...]
> diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb123.dts b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> new file mode 100644
> index 000000000000..42bd404471f6
> --- /dev/null
> +++ b/arch/mips/boot/dts/mscc/ocelot_pcb123.dts
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/* Copyright (c) 2017 Microsemi Corporation */
> +
> +/dts-v1/;
> +
> +#include "ocelot.dtsi"
> +
> +/ {
> +	compatible = "mscc,ocelot-pcb123", "mscc,ocelot";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory {

    Needs to be "memory@0" as you have the "regs" prop.

> +		device_type = "memory";
> +		reg = <0x0 0x0e000000>;
> +	};
> +};
[...]

MBR, Sergei
