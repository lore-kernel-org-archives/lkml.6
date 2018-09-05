Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607A3C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79412064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IXcnuG+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79412064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeIENGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:06:17 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:41684 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeIENGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:06:17 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 606BE24E0F33;
        Wed,  5 Sep 2018 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536136629; bh=QjTKifEaDupr5m7A2b1QDO8t6pxxdbnahqgqXSK1zTA=;
        h=From:To:CC:Subject:Date:References:From;
        b=IXcnuG+Um1vX7K2eWjEJGn2I+3cs/BkXeRDXOO8TSw90uC4l/unvwMllnXW2MNkf2
         cn4+s0xwJ+bZbN7gnt2378g75PQoZ/25YH2eCFmldWO/JOnEGXiW3eLZXVnkZ8HnEU
         vc3mOfU+lOPDBIeOMR9OH844s6War6z2SCdh6erkwMhI6yfvQamAyko/aIExQ5JRxt
         hBVpG4BmZcCSqmgW+xqOO6F8ymxN2RylCu2WHUSGcoXuU5mOnhulW6Fc5LZeKkwb9n
         103+xCSHql15DPo6kR9vt7WVVY0hjh0YRMqMcPLBixY27rwlL0KgJc/L0f0ZcnnVPg
         kGidKMOwh0eyg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 165C13A38;
        Wed,  5 Sep 2018 01:37:09 -0700 (PDT)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 5 Sep 2018 01:37:07 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed,
 5 Sep 2018 12:37:05 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>,
        Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] usb: dwc2: power off during shutdown
Thread-Topic: [PATCH RFC] usb: dwc2: power off during shutdown
Thread-Index: AQHUQdnrerw4ENQnyUeZCj/DHLE7ag==
Date:   Wed, 5 Sep 2018 08:37:03 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A761B2B@am04wembxa.internal.synopsys.com>
References: <1535795683-3788-1-git-send-email-stefan.wahren@i2se.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.57]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,=0A=
=0A=
On 9/1/2018 1:55 PM, Stefan Wahren wrote:=0A=
> Currently USB consumes a lot of power after shutting down a Raspberry Pi =
3=0A=
> (example setup with Ethernet and a keyboard connected). So power off=0A=
> USB on shutdown.=0A=
> =0A=
> Measured on Raspberry Pi 3B with 4.19rc1/multi_v7_defconfig (HDMI, Ethern=
et=0A=
> and a keyboard connected)=0A=
> =0A=
> Before patch: 2.450 W=0A=
> After patch:  2.090 W=0A=
> =0A=
=0A=
Could you please elaborate. Power measurements done after shutdown? Why =0A=
your setup continue consume power after shutdown? Maybe its =0A=
sleep/hibernation mode?=0A=
=0A=
dwc2 core in your platform which type of power optimization supports: =0A=
partial power down, hibernation or extended hibernation? Please provide =0A=
me GHWCFG4 register value of your core.=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>=0A=
> ---=0A=
>   drivers/usb/dwc2/platform.c | 31 +++++++++++--------------------=0A=
>   1 file changed, 11 insertions(+), 20 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c=0A=
> index 9a53a58..eeba40a 100644=0A=
> --- a/drivers/usb/dwc2/platform.c=0A=
> +++ b/drivers/usb/dwc2/platform.c=0A=
> @@ -304,17 +304,11 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg =
*hsotg)=0A=
>   }=0A=
>   =0A=
>   /**=0A=
> - * dwc2_driver_remove() - Called when the DWC_otg core is unregistered w=
ith the=0A=
> - * DWC_otg driver=0A=
> + * dwc2_driver_shutdown() - Called on device shutdown=0A=
>    *=0A=
>    * @dev: Platform device=0A=
> - *=0A=
> - * This routine is called, for example, when the rmmod command is execut=
ed. The=0A=
> - * device may or may not be electrically present. If it is present, the =
driver=0A=
> - * stops device processing. Any resources used on behalf of this device =
are=0A=
> - * freed.=0A=
>    */=0A=
> -static int dwc2_driver_remove(struct platform_device *dev)=0A=
> +static void dwc2_driver_shutdown(struct platform_device *dev)=0A=
>   {=0A=
>   	struct dwc2_hsotg *hsotg =3D platform_get_drvdata(dev);=0A=
>   =0A=
> @@ -329,27 +323,24 @@ static int dwc2_driver_remove(struct platform_devic=
e *dev)=0A=
>   =0A=
>   	reset_control_assert(hsotg->reset);=0A=
>   	reset_control_assert(hsotg->reset_ecc);=0A=
> -=0A=
> -	return 0;=0A=
>   }=0A=
>   =0A=
>   /**=0A=
> - * dwc2_driver_shutdown() - Called on device shutdown=0A=
> + * dwc2_driver_remove() - Called when the DWC_otg core is unregistered w=
ith the=0A=
> + * DWC_otg driver=0A=
>    *=0A=
>    * @dev: Platform device=0A=
>    *=0A=
> - * In specific conditions (involving usb hubs) dwc2 devices can create a=
=0A=
> - * lot of interrupts, even to the point of overwhelming devices running=
=0A=
> - * at low frequencies. Some devices need to do special clock handling=0A=
> - * at shutdown-time which may bring the system clock below the threshold=
=0A=
> - * of being able to handle the dwc2 interrupts. Disabling dwc2-irqs=0A=
> - * prevents reboots/poweroffs from getting stuck in such cases.=0A=
> + * This routine is called, for example, when the rmmod command is execut=
ed. The=0A=
> + * device may or may not be electrically present. If it is present, the =
driver=0A=
> + * stops device processing. Any resources used on behalf of this device =
are=0A=
> + * freed.=0A=
>    */=0A=
> -static void dwc2_driver_shutdown(struct platform_device *dev)=0A=
> +static int dwc2_driver_remove(struct platform_device *dev)=0A=
>   {=0A=
> -	struct dwc2_hsotg *hsotg =3D platform_get_drvdata(dev);=0A=
> +	dwc2_driver_shutdown(dev);=0A=
>   =0A=
> -	disable_irq(hsotg->irq);=0A=
> +	return 0;=0A=
>   }=0A=
>   =0A=
>   /**=0A=
> =0A=
=0A=
