Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7961ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC6E214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Fl2Q94ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC6E214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeIQWjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:39:33 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:38952 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727660AbeIQWjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:39:32 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie3.idc.renesas.com with ESMTP; 18 Sep 2018 02:11:14 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 66A7A49B47;
        Tue, 18 Sep 2018 02:11:14 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,386,1531753200"; 
   d="scan'208";a="291154630"
Received: from mail-os2jpn01lp0151.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.151])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 18 Sep 2018 02:11:14 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFe6orpG33ZLCyaZbuW092SS1ic5moTWoq8kIXr82ZI=;
 b=Fl2Q94ianYDhVsExxCCcAfwvlnpfiZtRVtVajHIUb1rbvL+n9aIKr8BVwtNiEoqH903w/bJSBDddaY7JdMIpEFpgS25fcKsBYDrla/wuqlp4cQ8/fIbqIDQ7wlJrHG3rT2Cj4GxEpQWI85NOYQaONOhNOyUG66WDlGgJ+tiSzrw=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) by
 TY1PR01MB0128.jpnprd01.prod.outlook.com (10.161.134.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 17:11:12 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::ddef:a4c2:976a:66d1]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::ddef:a4c2:976a:66d1%2]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 17:11:12 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] Revert "serial: sh-sci: Allow for compressed SCIF
 address"
Thread-Topic: [PATCH 2/2] Revert "serial: sh-sci: Allow for compressed SCIF
 address"
Thread-Index: AQHUQGCOWb2MRsqluE+kCBvKIJM9I6T00Zdg
Date:   Mon, 17 Sep 2018 17:11:11 +0000
Message-ID: <TY1PR01MB1562A5E7FA583A7B3AE16FC68A1E0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180830125404.21192-1-geert+renesas@glider.be>
 <20180830125404.21192-3-geert+renesas@glider.be>
In-Reply-To: <20180830125404.21192-3-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0128;20:rc5pBRou+PVJfid+eBHGnWLel4Q0Nm3ehJZU5XCuxIFDEyvH7r1cbcR9NXti1fFdDJLy5aCxc0KIC/XGTDyV50Bpv9ZchWeDtzH9hZWLbRMKEFClYLBkNhCFN6LSASy8DZDOvI2TSBfaukEWlXjn+Zkqrsgq1y7duRgLSOjAj5g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fbef8f3b-6e25-457b-2727-08d61cc09188
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0128;
x-ms-traffictypediagnostic: TY1PR01MB0128:
x-microsoft-antispam-prvs: <TY1PR01MB0128B19C3BEAD616A27E21148A1E0@TY1PR01MB0128.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:TY1PR01MB0128;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0128;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(478600001)(4326008)(33656002)(25786009)(110136005)(74316002)(6436002)(54906003)(316002)(102836004)(76176011)(2906002)(7696005)(66066001)(8936002)(6116002)(3846002)(6506007)(5660300001)(229853002)(6246003)(7736002)(446003)(11346002)(97736004)(81166006)(486006)(81156014)(105586002)(186003)(99286004)(575784001)(2900100001)(8676002)(26005)(256004)(68736007)(55016002)(305945005)(476003)(9686003)(86362001)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0128;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t8vn8zyOvivsQIQ2Oz3ZJi+zUh8IWM7scAYs+HJpkGQZ/+xglPgaKsSfTl59esJ6lIvGaLIccEcdZLuIsGdnfKf9+vkN+6k/WMvSkmWyHsPu8TXlDDHtCa6zcIJTXfHkXi8xcIA1247oWqIZAjyzlOs/MhE/Y5TogcefYAu4p8BGAiR7Q9YMfNr5bcYRMyMUmcS2Y4k3SgEZ8hzSDpVScSpF9/RnfFDK6RNVO78es8jD9r0esFe0oz0fQ20VeiqO2ok167jR0kK+XVXMDYiPaH52L6WoyHBblRdRG8+tzmtFvP7WCmcBz08X9Y9VwAYEpM0FTQHywuCiOF1kASOikYOKfijed8WtHhWYOcRXfA0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbef8f3b-6e25-457b-2727-08d61cc09188
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 17:11:11.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 30, 2018, Geert Uytterhoeven wrote:
> This reverts commit 2d4dd0da45401c7ae7332b4d1eb7bbb1348edde9.
>=20
> This broke earlycon on all Renesas ARM platforms using a SCIF port for
> the
> serial console (R-Car, RZ/A1, RZ/G1, RZ/G2 SoCs), due to an incorrect
> value
> of port->regshift.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Chris Brandt <chris.brandt@renesas.com>


> ---
>  drivers/tty/serial/sh-sci.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 5d42c9a63001575a..ab3f6e91853da3c2 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -346,15 +346,15 @@ static const struct sci_port_params
> sci_port_params[SCIx_NR_REGTYPES] =3D {
>  	[SCIx_SH4_SCIF_REGTYPE] =3D {
>  		.regs =3D {
>  			[SCSMR]		=3D { 0x00, 16 },
> -			[SCBRR]		=3D { 0x02,  8 },
> -			[SCSCR]		=3D { 0x04, 16 },
> -			[SCxTDR]	=3D { 0x06,  8 },
> -			[SCxSR]		=3D { 0x08, 16 },
> -			[SCxRDR]	=3D { 0x0a,  8 },
> -			[SCFCR]		=3D { 0x0c, 16 },
> -			[SCFDR]		=3D { 0x0e, 16 },
> -			[SCSPTR]	=3D { 0x10, 16 },
> -			[SCLSR]		=3D { 0x12, 16 },
> +			[SCBRR]		=3D { 0x04,  8 },
> +			[SCSCR]		=3D { 0x08, 16 },
> +			[SCxTDR]	=3D { 0x0c,  8 },
> +			[SCxSR]		=3D { 0x10, 16 },
> +			[SCxRDR]	=3D { 0x14,  8 },
> +			[SCFCR]		=3D { 0x18, 16 },
> +			[SCFDR]		=3D { 0x1c, 16 },
> +			[SCSPTR]	=3D { 0x20, 16 },
> +			[SCLSR]		=3D { 0x24, 16 },
>  		},
>  		.fifosize =3D 16,
>  		.overrun_reg =3D SCLSR,
> @@ -2837,7 +2837,7 @@ static int sci_init_single(struct platform_device
> *dev,
>  {
>  	struct uart_port *port =3D &sci_port->port;
>  	const struct resource *res;
> -	unsigned int i, regtype;
> +	unsigned int i;
>  	int ret;
>=20
>  	sci_port->cfg	=3D p;
> @@ -2874,7 +2874,6 @@ static int sci_init_single(struct platform_device
> *dev,
>  	if (unlikely(sci_port->params =3D=3D NULL))
>  		return -EINVAL;
>=20
> -	regtype =3D sci_port->params - sci_port_params;
>  	switch (p->type) {
>  	case PORT_SCIFB:
>  		sci_port->rx_trigger =3D 48;
> @@ -2929,10 +2928,6 @@ static int sci_init_single(struct platform_device
> *dev,
>  			port->regshift =3D 1;
>  	}
>=20
> -	if (regtype =3D=3D SCIx_SH4_SCIF_REGTYPE)
> -		if (sci_port->reg_size >=3D 0x20)
> -			port->regshift =3D 1;
> -
>  	/*
>  	 * The UART port needs an IRQ value, so we peg this to the RX IRQ
>  	 * for the multi-IRQ ports, which is where we are primarily
> --
> 2.17.1

