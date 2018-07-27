Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F02C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11D92089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="glsoox0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11D92089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbeG0Mcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:32:45 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50034 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbeG0Mcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:32:45 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7D4C910C0F9E;
        Fri, 27 Jul 2018 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532689878; bh=69rGn+FADR5C6E9IiFHn1tcxUELc7Z3Ze+eWrcG6Foc=;
        h=From:To:CC:Subject:Date:References:From;
        b=glsoox0v3t96ABcQOZtxLJ6cAr/a5ujJSEaAjkTkd81lWMcVh8ih07zl7cH/oUP8t
         K3/Ctd3wdkybpTJlVKFUtclAqBhQ9qwisJlXMqp08b0eqJB3RjPyQnIYnn19vD9+7t
         Xi0twAHQ0SPegWna77QoLXS86N31LFSmpy4sPzh/Us1pFtVfyGkuiBgldkPGXRyy0H
         U/F27hkuPs47oHkhtL/Dau8dXG3BBj9NaIFY9C89n07W491cQawvXiZeKXEg3U93ey
         UVLu4mnYDu8jUNKVvPeHB3kKB+PPb65mp2bWhHg4aW9JXY3WR5DLzkJQ0iRpzQrIiw
         2ldb+Wg/alemQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5A2733B78;
        Fri, 27 Jul 2018 04:11:18 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 27 Jul 2018 04:11:17 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 27 Jul 2018 15:11:15 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Douglas Anderson <dianders@chromium.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "Minas.Harutyunyan@synopsys.com" <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "grigor.tovmasyan@synopsys.com" <grigor.tovmasyan@synopsys.com>,
        "Bruno Herrera" <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST PATCH 4/4] usb: dwc2: Turn on uframe_sched on
 "stm32f4x9_fsotg" platforms
Thread-Topic: [REPOST PATCH 4/4] usb: dwc2: Turn on uframe_sched on
 "stm32f4x9_fsotg" platforms
Thread-Index: AQHUJRxfzn89egir8kiZnHbl16+nLA==
Date:   Fri, 27 Jul 2018 11:11:15 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A5CBE67@am04wembxa.internal.synopsys.com>
References: <20180726200730.18290-1-dianders@chromium.org>
 <20180726200730.18290-5-dianders@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.151]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2018 12:08 AM, Douglas Anderson wrote:=0A=
> There's no reason to have the uframe scheduler off on dwc2.  Running=0A=
> with uframe_sched =3D False is equivalent to saying "I don't want to run=
=0A=
> the correct code, I want to run the old and incorrect code".=0A=
> =0A=
> The uframe scheduler has been off on stm32f4x9_fsotg since commit=0A=
> e35b135055e2 ("usb: dwc2: Add support for STM32F429/439/469 USB OTG=0A=
> HS/FS in FS mode (internal PHY)").  That commit is pretty recent, so=0A=
> it's unclear to me why the uframe scheduler was left off.  Hopefully=0A=
> it's because someone copied it from other parameters and didn't think=0A=
> to try it?=0A=
> =0A=
> Presumably if everyone is good w/ the uframe_sched turned back on we=0A=
> can kill all the old and crufty non-uframe sched code.=0A=
> =0A=
> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
=0A=
Reviewed-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
> ---=0A=
> =0A=
>   drivers/usb/dwc2/params.c | 1 -=0A=
>   1 file changed, 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index 93380f7c32b4..7be35bcde713 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -131,7 +131,6 @@ static void dwc2_set_stm32f4x9_fsotg_params(struct dw=
c2_hsotg *hsotg)=0A=
>   	p->max_packet_count =3D 256;=0A=
>   	p->phy_type =3D DWC2_PHY_TYPE_PARAM_FS;=0A=
>   	p->i2c_enable =3D false;=0A=
> -	p->uframe_sched =3D false;=0A=
>   	p->activate_stm_fs_transceiver =3D true;=0A=
>   }=0A=
>   =0A=
> =0A=
=0A=
