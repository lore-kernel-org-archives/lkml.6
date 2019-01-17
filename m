Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDDA20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wxD6aOa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfAQTuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:50:02 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59194 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfAQTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:50:01 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 918F18365A;
        Fri, 18 Jan 2019 08:49:58 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1547754598;
        bh=MwP8t9x/FDq8/YP9i1LjHbN1VAAlS8YjbCVfGNccqY4=;
        h=From:To:Subject:Date:References;
        b=wxD6aOa4U08qEAFnPEe0yTKfAYNjrWeg2AaZuNAspCmm3EBgv+yW1hxImMDWBHtOX
         UjelhWmpJlckaP/R/2n2+Z0OXBsjs9BrFnx916XaojE3ti7aJHn+JwRkR3MmMSrTXh
         zqR89OWjV4XPIvpku9aSTtwp/b2l/8cqfJNgLZoTIgL8gbLyHrITf93iiHLHdXHE5i
         4rqS2+W4A8glDd1riZlkicN6xpf1msPdwaFKBe0hcXPCgt6GcQX6jHCQl7Tq/MUaI6
         j2F1m31HGdcA38gCjaGvkQzFJkuTCfa/u8K/vOzZIX0l58gdz08d/5PIndD/HfLs3E
         36OstTE2AOYLA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c40dc650000>; Fri, 18 Jan 2019 08:49:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Fri, 18 Jan 2019 08:49:53 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 18 Jan 2019 08:49:53 +1300
From:   Darwin Dingel <Darwin.Dingel@alliedtelesis.co.nz>
To:     "zhe.he@windriver.com" <zhe.he@windriver.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Jisheng.Zhang@synaptics.com" <Jisheng.Zhang@synaptics.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix serial8250 initialization crash
Thread-Topic: [PATCH] serial: 8250: Fix serial8250 initialization crash
Thread-Index: AQHUrkMcXKnwLVY2dEaW/IjGFnxJ8w==
Date:   Thu, 17 Jan 2019 19:49:53 +0000
Message-ID: <41c574bfdce7490597079dae8f328661@svr-chch-ex1.atlnz.lc>
References: <1547715619-181299-1-git-send-email-zhe.he@windriver.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:23:c9cc:a3c:eb68:bca4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/19 10:00 PM, zhe.he@windriver.com wrote:=0A=
> From: He Zhe <zhe.he@windriver.com>=0A=
> =0A=
> The initialization code of interrupt backoff work might reference NULL=0A=
> pointer and cause the following crash, if no port was found.=0A=
> =0A=
> [   10.017727] CPU 0 Unable to handle kernel paging request at virtual ad=
dress 000001b0, epc =3D=3D 807088e0, ra =3D=3D 8070863c=0A=
> ---- snip ----=0A=
> [   11.704470] [<807088e0>] serial8250_register_8250_port+0x318/0x4ac=0A=
> [   11.747251] [<80708d74>] serial8250_probe+0x148/0x1c0=0A=
> [   11.789301] [<80728450>] platform_drv_probe+0x40/0x94=0A=
> [   11.830515] [<807264f8>] really_probe+0xf8/0x318=0A=
> [   11.870876] [<80726b7c>] __driver_attach+0x110/0x12c=0A=
> [   11.910960] [<80724374>] bus_for_each_dev+0x78/0xcc=0A=
> [   11.951134] [<80725958>] bus_add_driver+0x200/0x234=0A=
> [   11.989756] [<807273d8>] driver_register+0x84/0x148=0A=
> [   12.029832] [<80d72f84>] serial8250_init+0x138/0x198=0A=
> [   12.070447] [<80100e6c>] do_one_initcall+0x5c/0x2a0=0A=
> [   12.110104] [<80d3a208>] kernel_init_freeable+0x370/0x484=0A=
> [   12.150722] [<80a49420>] kernel_init+0x10/0xf8=0A=
> [   12.191517] [<8010756c>] ret_from_kernel_thread+0x14/0x1c=0A=
> =0A=
> This patch makes sure the initialization code can be reached only if a po=
rt=0A=
> is found.=0A=
> =0A=
> Fixes: commit 6d7f677a2afa ("serial: 8250: Rate limit serial port rx inte=
rrupts during input overruns")=0A=
> Signed-off-by: He Zhe <zhe.he@windriver.com>=0A=
> ---=0A=
>   drivers/tty/serial/8250/8250_core.c | 17 +++++++++--------=0A=
>   1 file changed, 9 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c=0A=
> index 189ab12..e441221 100644=0A=
> --- a/drivers/tty/serial/8250/8250_core.c=0A=
> +++ b/drivers/tty/serial/8250/8250_core.c=0A=
> @@ -1070,15 +1070,16 @@ int serial8250_register_8250_port(struct uart_825=
0_port *up)=0A=
>   =0A=
>   			ret =3D 0;=0A=
>   		}=0A=
> -	}=0A=
>   =0A=
> -	/* Initialise interrupt backoff work if required */=0A=
> -	if (up->overrun_backoff_time_ms > 0) {=0A=
> -		uart->overrun_backoff_time_ms =3D up->overrun_backoff_time_ms;=0A=
> -		INIT_DELAYED_WORK(&uart->overrun_backoff,=0A=
> -				  serial_8250_overrun_backoff_work);=0A=
> -	} else {=0A=
> -		uart->overrun_backoff_time_ms =3D 0;=0A=
> +		/* Initialise interrupt backoff work if required */=0A=
> +		if (up->overrun_backoff_time_ms > 0) {=0A=
> +			uart->overrun_backoff_time_ms =3D=0A=
> +				up->overrun_backoff_time_ms;=0A=
> +			INIT_DELAYED_WORK(&uart->overrun_backoff,=0A=
> +					serial_8250_overrun_backoff_work);=0A=
> +		} else {=0A=
> +			uart->overrun_backoff_time_ms =3D 0;=0A=
> +		}=0A=
>   	}=0A=
>   =0A=
>   	mutex_unlock(&serial_mutex);=0A=
> =0A=
=0A=
Reviewed-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>=0A=
=0A=
I presume this is the same issue reported here:=0A=
=0A=
https://www.spinics.net/lists/linux-serial/msg33114.html=0A=
https://lkml.org/lkml/2018/12/22/171=0A=
=0A=
=0A=
=0A=
Thanks!=0A=
Regards,=0A=
=0A=
Darwin=0A=
