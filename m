Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D376C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508B7206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I0PwGJ9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508B7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeLDO2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:28:49 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:42522 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbeLDO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:28:49 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8BC1424E104F;
        Tue,  4 Dec 2018 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543933728; bh=tZQt9CXx+6w+UKSwhRcd45KQABds4yyV77OALhppgS8=;
        h=From:To:CC:Subject:Date:References:From;
        b=I0PwGJ9oSgmzrgZVRVmvzvtIWoeiJOauB6kolJ5bWUq9aOOlBbDjCW6C8jSBqmd+H
         X2Y0kG/DfWpeMCAMUwPLFZ2qIARwc6fDWl4fbA95jxkCCEVxm6d+oxoxz+J8idDpy2
         HPVWWWljA7xiEf88oszLcMpjbqRmauXiRmPSAT3x/zbcqlGke0+p6fjMUYth1qkAC0
         MEP8y4oCXXTgUqZ8hKHGt3qQnh70mfGmp19ihgoWewl/v8shDcth+MKXV5bO3pstWZ
         PaegnKULLZ4tul+L+3ReeeClVtZstlA3KQjAwumr5/A/+GR6TGs2RtNbL4vrf1+sNt
         zdXT9YMWZ4Ocw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 536013F05;
        Tue,  4 Dec 2018 06:28:48 -0800 (PST)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Dec 2018 06:28:48 -0800
Received: from AM04WEMBXB.internal.synopsys.com ([fe80::1006:bcdd:1b7:579b])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 4 Dec 2018 18:28:45 +0400
From:   Artur Petrosyan <arthur.petrosyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] usb: dwc2: Disable power down feature on Samsung SoCs
Thread-Topic: [PATCH] usb: dwc2: Disable power down feature on Samsung SoCs
Thread-Index: AQHUgOcejqdk/wCle0CvR7QZbzdrlQ==
Date:   Tue, 4 Dec 2018 14:28:44 +0000
Message-ID: <3AD91E696667BF4BA728303C178E8A63532C68EA@am04wembxb.internal.synopsys.com>
References: <CGME20181120153828eucas1p206d442b12c16588662c0e3f731ba58c3@eucas1p2.samsung.com>
 <20181120153815.31897-1-m.szyprowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.104.58]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,=0A=
=0A=
On 11/20/2018 19:38, Marek Szyprowski wrote:=0A=
> Power down feature of DWC2 module integrated in Samsung SoCs doesn't work=
=0A=
> properly or needs some additional handling in PHY or SoC glue layer, so=
=0A=
> disable it for now. Without disabling power down, DWC2 causes random memo=
ry=0A=
> trashes and fails enumeration if there is no USB link to host on driver=
=0A=
> probe.=0A=
> =0A=
> Fixes: 03ea6d6e9e1ff1 ("usb: dwc2: Enable power down")=0A=
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>=0A=
> ---=0A=
>   drivers/usb/dwc2/params.c | 10 +++++++++-=0A=
>   1 file changed, 9 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index 7c1b6938f212..266157ae179a 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -71,6 +71,13 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hso=
tg)=0A=
>   	p->power_down =3D false;=0A=
>   }=0A=
>   =0A=
> +static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)=0A=
> +{=0A=
> +	struct dwc2_core_params *p =3D &hsotg->params;=0A=
> +=0A=
> +	p->power_down =3D 0;=0A=
> +}=0A=
> +=0A=
>   static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)=0A=
>   {=0A=
>   	struct dwc2_core_params *p =3D &hsotg->params;=0A=
> @@ -151,7 +158,8 @@ const struct of_device_id dwc2_of_match_table[] =3D {=
=0A=
>   	{ .compatible =3D "lantiq,arx100-usb", .data =3D dwc2_set_ltq_params }=
,=0A=
>   	{ .compatible =3D "lantiq,xrx200-usb", .data =3D dwc2_set_ltq_params }=
,=0A=
>   	{ .compatible =3D "snps,dwc2" },=0A=
> -	{ .compatible =3D "samsung,s3c6400-hsotg" },=0A=
> +	{ .compatible =3D "samsung,s3c6400-hsotg",=0A=
> +	  .data =3D dwc2_set_s3c6400_params },=0A=
>   	{ .compatible =3D "amlogic,meson8-usb",=0A=
>   	  .data =3D dwc2_set_amlogic_params },=0A=
>   	{ .compatible =3D "amlogic,meson8b-usb",=0A=
> =0A=
=0A=
Could you please provide dmesg logs with verbose Debug enabled =0A=
configuration and the register dump.=0A=
So that we can see what the issue is related to.=0A=
=0A=
Regards,=0A=
Artur=0A=
