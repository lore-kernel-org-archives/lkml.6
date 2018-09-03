Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F2B2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lDkj7Nbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F2B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeICM3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:29:03 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:60376 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeICM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:29:03 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 64D6724E1400;
        Mon,  3 Sep 2018 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535962202; bh=JpGWuJo3u+arXErx3qFEMN2JIjIkolXllHhfK2ydrNw=;
        h=From:To:CC:Subject:Date:References:From;
        b=lDkj7Nbcrh6Z9fKUII+JRn8OLthWBVVqdXIRuB5Y2xFCz1z/eZWPQ6ZLrD1l7ItI1
         uDfpi+TvTNWgj1InMfz2l3iQ9f5yhdZRDEB+jvI1wPTldRWcXLOMc0+VvWimU7+9MS
         mqTJ7XfpBZZYOiVEelH93x7cmZVVjip3qXWqYDQGw1bSIqh9kQmftPsCez2mfr5pJt
         qLaYYE1I1JwKyKhY/FKly8XH+LQqVPAvCYf4mxMqHeqGtMe+vG+d77jhfsO+gzU9cK
         Q6kmkn9YYbNBICgfUisGvXk3BIWVc4ut/ZIgmLW2bVOFUqSQtm0paH+JW4EgBAX7pu
         6YOeJVcoRyfDA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 626D95A1E;
        Mon,  3 Sep 2018 01:10:01 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 3 Sep 2018 01:10:01 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 3 Sep 2018 12:09:58 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Bruno Meirelles Herrera <bmh@certi.org.br>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "John.Youn@synopsys.com" <John.Youn@synopsys.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>
Subject: Re: [PATCH] usb: dwc2: Fix call location of
 dwc2_check_core_endianness
Thread-Topic: [PATCH] usb: dwc2: Fix call location of
 dwc2_check_core_endianness
Thread-Index: AQHUPk4l2Nhk1HAakEaEIFmk2vBwVQ==
Date:   Mon, 3 Sep 2018 08:09:57 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A75F881@am04wembxa.internal.synopsys.com>
References: <20180827213638.18890-1-bmh@certi.org.br>
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

On 8/28/2018 1:37 AM, Bruno Meirelles Herrera wrote:=0A=
> Some SoC/IP as STM32F469, the snpsid can only be read after clock is=0A=
> enabled, otherwise it will read as 0, and the dwc2_check_core_endianness=
=0A=
> will assume the core and AHB have opposite endianness, leading to the=0A=
> following error:=0A=
> =0A=
> [    1.976339] dwc2 50000000.usb: 50000000.usb supply vusb_d not found, u=
sing dummy regulator=0A=
> [    1.986124] dwc2 50000000.usb: Linked as a consumer to regulator.0=0A=
> [    1.992711] dwc2 50000000.usb: 50000000.usb supply vusb_a not found, u=
sing dummy regulator=0A=
> [    2.003672] dwc2 50000000.usb: dwc2_core_reset: HANG! AHB Idle timeout=
 GRSTCTL GRSTCTL_AHBIDLE=0A=
> [    2.015176] dwc2: probe of 50000000.usb failed with error -16=0A=
> =0A=
> The proposed patch changes the location where dwc2_check_core_endianness=
=0A=
> is called, allowing the clock peripheral to be enabled first.=0A=
> =0A=
> Signed-off-by: Bruno Meirelles Herrera <bmh@certi.org.br>=0A=
=0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
> ---=0A=
>   drivers/usb/dwc2/platform.c | 4 ++--=0A=
>   1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c=0A=
> index 9a53a58e676e..577642895b57 100644=0A=
> --- a/drivers/usb/dwc2/platform.c=0A=
> +++ b/drivers/usb/dwc2/platform.c=0A=
> @@ -412,8 +412,6 @@ static int dwc2_driver_probe(struct platform_device *=
dev)=0A=
>   	dev_dbg(&dev->dev, "mapped PA %08lx to VA %p\n",=0A=
>   		(unsigned long)res->start, hsotg->regs);=0A=
>   =0A=
> -	hsotg->needs_byte_swap =3D dwc2_check_core_endianness(hsotg);=0A=
> -=0A=
>   	retval =3D dwc2_lowlevel_hw_init(hsotg);=0A=
>   	if (retval)=0A=
>   		return retval;=0A=
> @@ -438,6 +436,8 @@ static int dwc2_driver_probe(struct platform_device *=
dev)=0A=
>   	if (retval)=0A=
>   		return retval;=0A=
>   =0A=
> +	hsotg->needs_byte_swap =3D dwc2_check_core_endianness(hsotg);=0A=
> +=0A=
>   	retval =3D dwc2_get_dr_mode(hsotg);=0A=
>   	if (retval)=0A=
>   		goto error;=0A=
> =0A=
=0A=
