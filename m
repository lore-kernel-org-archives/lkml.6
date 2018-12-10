Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6812082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZIxbebdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6812082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLJGEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:04:31 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:56222 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJGEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:04:31 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A69D724E1190;
        Sun,  9 Dec 2018 22:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544421870; bh=bHg4C6rLRi7UwLFIFdr5ggrF/iNEN7K6aK8xjr0TKdE=;
        h=From:To:CC:Subject:Date:References:From;
        b=ZIxbebdyzbIvpog9Py06ulgtI8UZPLlYyua3DknB+YfdcOWyiUjModVZwJd+OXP4A
         b37iyNowU/EoSa9RCyI+1eRcjzkECWq05gAwrPm7DKLUHK6BP1J3PSMJNmrR6vV4B7
         pNGACAw4hhW6ecNi4j3xy2YqT3zoUOaRWcVp9fM0faz27BmG1BLCedZxtv++R21FfI
         ZX8jZIlr/vL+L2pca6HLIX3Tr4Ze1UZIRBr/7bgoenNMJbbNqtY9BUNt4LVGgCMBgV
         ynqeTAKz3FwerrIvvq17C/fTr01fj52H0qmshgOOhesRctGc+9P7GSIYGhPnZGefKv
         7oHl7ADN60nOQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5175A53F1;
        Sun,  9 Dec 2018 22:04:30 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 9 Dec 2018 22:04:30 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 10 Dec 2018 10:04:27 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "minas.harutyunyan@synopsys.com" <minas.harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "Arthur.Petrosyan@synopsys.com" <Arthur.Petrosyan@synopsys.com>,
        "christianshewitt@gmail.com" <christianshewitt@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: dwc2: disable power_down on Amlogic devices
Thread-Topic: [PATCH 1/1] usb: dwc2: disable power_down on Amlogic devices
Thread-Index: AQHUj/GlZFUzpz34P0WIm4puEQupSw==
Date:   Mon, 10 Dec 2018 06:04:26 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7B631D@am04wembxa.internal.synopsys.com>
References: <20181209190129.11870-1-martin.blumenstingl@googlemail.com>
 <20181209190129.11870-2-martin.blumenstingl@googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/2018 11:01 PM, Martin Blumenstingl wrote:=0A=
> Disable power_down by setting the parameter to=0A=
> DWC2_POWER_DOWN_PARAM_NONE. This fixes a problem on various Amlogic=0A=
> Meson SoCs where USB devices are only recognized when plugged in before=
=0A=
> booting Linux. A hot-plugged USB device was not detected even though the=
=0A=
> device got power (my USB thumb drive for example has an LED which lit=0A=
> up).=0A=
> =0A=
> A similar fix was implemented for Rockchip SoCs in commit c216765d3a1def=
=0A=
> ("usb: dwc2: disable power_down on rockchip devices"). That commit=0A=
> suggests that a change in the dwc2 driver is the cause because the=0A=
> default value for the "hibernate" parameter (which then got renamed to=0A=
> "power_down" to support other modes) was changed in the v4.17 merge=0A=
> window with:=0A=
> commit 6d23ee9caa6790 ("Merge tag 'usb-for-v4.17' of git://git.kernel.org=
/pub/scm/linux/kernel/git/balbi/usb into usb-testing").=0A=
> =0A=
> Cc: <stable@vger.kernel.org> # 4.19=0A=
> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>=0A=
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>=
=0A=
=0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
> ---=0A=
>   drivers/usb/dwc2/params.c | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index 7c1b6938f212..38c813b1d203 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -111,6 +111,7 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg=
 *hsotg)=0A=
>   	p->phy_type =3D DWC2_PHY_TYPE_PARAM_UTMI;=0A=
>   	p->ahbcfg =3D GAHBCFG_HBSTLEN_INCR8 <<=0A=
>   		GAHBCFG_HBSTLEN_SHIFT;=0A=
> +	p->power_down =3D DWC2_POWER_DOWN_PARAM_NONE;=0A=
>   }=0A=
>   =0A=
>   static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)=0A=
> =0A=
=0A=
