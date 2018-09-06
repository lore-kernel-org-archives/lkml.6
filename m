Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CFBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B17B206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="a/imZQjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B17B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIFNLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:11:10 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:35766 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeIFNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:11:10 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0551224E1260;
        Thu,  6 Sep 2018 01:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536223010; bh=2nkhUQvns7Ng8YqgUPMeLsHrW59aZKESHhy5KXU2/aM=;
        h=From:To:CC:Subject:Date:References:From;
        b=a/imZQjgY9sCrFG/C5U16AxvASkme3KC1ixaSOtMW06MF8/j68VlJRD6DKG52akPK
         9c8BAUwSGEBCJS29l+QRKG+xuAebssllpYvqkk3vrW9TRjKJpQ/COwcfmpL2oOL/ZM
         fjgRfFUn7rLZ/k0NX6rZX+EZA7n2zO1dPVZLryxqet1rAIJasxhDjWnnzFVpbMe/F0
         jZICJGOiKuAipAZyrqmeL1FWAtQLDo4rAMLHckYbrmU957UckrzHjWYu1UawD+fidC
         +R06JLbFMg0JNszYw3NFyKAeyxUGxUFMyPsIkWiQFAiyS5cyJv+I8iW525pCRNK3SG
         wnxhOTs1WZO4g==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id B271C33D2;
        Thu,  6 Sep 2018 01:36:49 -0700 (PDT)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 6 Sep 2018 01:36:49 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 6 Sep 2018 12:36:46 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Christian Hewitt <christianshewitt@gmail.com>
CC:     "hal@halemmerich.com" <hal@halemmerich.com>,
        "arthur.petrosyan@synopsys.com" <arthur.petrosyan@synopsys.com>,
        "Minas Harutyunyan" <Minas.Harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: disable power_down on Amlogic devices
Thread-Topic: [PATCH] usb: dwc2: disable power_down on Amlogic devices
Thread-Index: AQHURSiVYaSFec6xrEKrPacylT6A6w==
Date:   Thu, 6 Sep 2018 08:36:46 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A764835@am04wembxa.internal.synopsys.com>
References: <1536159314-35831-1-git-send-email-christianshewitt@gmail.com>
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

On 9/5/2018 6:56 PM, Christian Hewitt wrote:=0A=
> USB devices work when connected to Amlogic GXBB hardware before power=0A=
> on, but not when connected after boot (hotplugged). With this patch=0A=
> hotplugging works again. This change was copied from the Rockchip=0A=
> patch here: (https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.=
info_-3Fl-3Dlinux-2Dusb-26m-3D153205711616460-26w-3D2&d=3DDwIBAg&c=3DDPL6_X=
_6JkXFx7AXWqB0tg&r=3DcQBKt4q-qzNVC53rNAwuwplH23V61rHQhhULvdLA0U8&m=3Dm5T_Ss=
LG-_isQDyjrHuiVqJWdEqZ21Lcr70lObiPwrg&s=3DD26wJzWeREBz6_XcmdTqo8k69mPRqGaIb=
RWl_77Ns3c&e=3D)=0A=
> =0A=
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>=0A=
=0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
> ---=0A=
>   drivers/usb/dwc2/params.c | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index bf7052e..93561a2 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -110,6 +110,7 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg=
 *hsotg)=0A=
>   	p->phy_type =3D DWC2_PHY_TYPE_PARAM_UTMI;=0A=
>   	p->ahbcfg =3D GAHBCFG_HBSTLEN_INCR8 <<=0A=
>   		GAHBCFG_HBSTLEN_SHIFT;=0A=
> +	p->power_down =3D false;=0A=
>   }=0A=
>   =0A=
>   static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)=0A=
> =0A=
=0A=
