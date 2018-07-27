Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4FBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B18208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eRVPk3rD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B18208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbeG0MbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:31:11 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:53354 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbeG0MbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:31:11 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9895A24E2126;
        Fri, 27 Jul 2018 04:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532689784; bh=DKR/blZ4DBjVoWpoQ2GYaRONUKgedSVM+ZWCCo+F/S4=;
        h=From:To:CC:Subject:Date:References:From;
        b=eRVPk3rDBdjXn2Ai+6578URtgvLIJw8aHBTzcWrUgaGLB6mOa1oUarDtnoGHPk0Yd
         LrVBXusD5e+pEX8bb02FO+g0eWPDx6M6zoh474WAi1xbcvoevNqnwb73UHHdS59aw8
         HztdW/WHxhHiBNokYTuvvB5LQO0uXUw0cux1V4jGChk07gDmdjq/g2dMteBmIOd/D5
         bTnPnWF9Pqbalqs7XjmB7TUS0FVxGcc1bBr6oHuY0sG9a6aZ4XAG2DLWwrIIB0Y7ks
         TIDsIdf1oHziwPm1FgFVgYIIPVNAlz6QZPfbM+6BSqfdgKPj4LuPrlZppIkzXTwXjv
         /wMsubeMDe3jA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2ECFE37AB;
        Fri, 27 Jul 2018 04:09:44 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 27 Jul 2018 04:09:43 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 27 Jul 2018 15:09:41 +0400
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
Subject: Re: [REPOST PATCH 1/4] usb: dwc2: Turn on uframe_sched on "bcm"
 platforms
Thread-Topic: [REPOST PATCH 1/4] usb: dwc2: Turn on uframe_sched on "bcm"
 platforms
Thread-Index: AQHUJRxdKPuevOS9UEymG/oseDHvnA==
Date:   Fri, 27 Jul 2018 11:09:39 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A5CBE23@am04wembxa.internal.synopsys.com>
References: <20180726200730.18290-1-dianders@chromium.org>
 <20180726200730.18290-2-dianders@chromium.org>
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
> The uframe scheduler has been off on Broadcom since commit=0A=
> 58b179dcf28c ("staging: dwc2: disable uframe_sched on the bcm2835").=0A=
> Since then there have been many many improvements, notably the commit=0A=
> 9f9f09b048f5 ("usb: dwc2: host: Totally redo the microframe=0A=
> scheduler")=0A=
> =0A=
> Presumably if everyone is good w/ the uframe_sched turned back on we=0A=
> can kill all the old and crufty non-uframe sched code.=0A=
> =0A=
> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>=0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
> ---=0A=
> =0A=
>   drivers/usb/dwc2/params.c | 1 -=0A=
>   1 file changed, 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index af075d4da895..14b8742e62fa 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -47,7 +47,6 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hsot=
g)=0A=
>   	p->max_transfer_size =3D 65535;=0A=
>   	p->max_packet_count =3D 511;=0A=
>   	p->ahbcfg =3D 0x10;=0A=
> -	p->uframe_sched =3D false;=0A=
>   }=0A=
>   =0A=
>   static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)=0A=
> =0A=
=0A=
