Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A2ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D4F20685
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="pQFdEi1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D4F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeIQWjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:39:17 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:26803 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728204AbeIQWjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:39:16 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 18 Sep 2018 02:10:58 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id A137F41416;
        Tue, 18 Sep 2018 02:10:58 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,386,1531753200"; 
   d="scan'208";a="292718017"
Received: from mail-os2jpn01lp0145.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.145])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 18 Sep 2018 02:10:58 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPA9R/6M0J0eP3YQKoF5KP8dwl4IueoeZj2N9ewdcF0=;
 b=pQFdEi1HPprEPx0No32rxLL7ZSbjNnF5Gs0oIGJlZ73ahK2vyfUn3HevBeb5Zr+bn1B6ilDsdQD7e1tnslRx7YEhrwCpTCmNVG8mR21BIpNOplxR3NtVGvkW0xIY/LUzOYCH1jmemxYayYDQSt7zt9gMqOebfzZfKmnzs9IqCY4=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) by
 TY1PR01MB0128.jpnprd01.prod.outlook.com (10.161.134.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 17 Sep 2018 17:10:52 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::ddef:a4c2:976a:66d1]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::ddef:a4c2:976a:66d1%2]) with mapi id 15.20.1143.017; Mon, 17 Sep 2018
 17:10:52 +0000
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
Subject: RE: [PATCH 1/2] Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
Thread-Topic: [PATCH 1/2] Revert "serial: sh-sci: Remove
 SCIx_RZ_SCIFA_REGTYPE"
Thread-Index: AQHUQGCOf7VITz73w0OwrsQhaK4aiKT00RpA
Date:   Mon, 17 Sep 2018 17:10:51 +0000
Message-ID: <TY1PR01MB1562D098E006C2BE93EB6E648A1E0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180830125404.21192-1-geert+renesas@glider.be>
 <20180830125404.21192-2-geert+renesas@glider.be>
In-Reply-To: <20180830125404.21192-2-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0128;20:5YvjkdK8Ygz4UEg0zoITMJECzebBO+hsfnHRG/bo8PU7yPocMiq9/Z4N1I2/7GzUWQkk/vOG/P5nwf6vA4e3HIh8Yp2U113jOY0mau3BH3HjaODdw/DsruwQ2y8AU0jGNONrCn5nrTEgXZPFfJAANV7tMbhbQOOMkdGbpcY2/Vk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cd99d02b-3035-4273-30da-08d61cc085ad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0128;
x-ms-traffictypediagnostic: TY1PR01MB0128:
x-microsoft-antispam-prvs: <TY1PR01MB012873669DF33BBC0C1E85E28A1E0@TY1PR01MB0128.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:TY1PR01MB0128;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0128;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(366004)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(478600001)(4326008)(33656002)(25786009)(110136005)(74316002)(6436002)(54906003)(316002)(102836004)(76176011)(2906002)(7696005)(66066001)(8936002)(6116002)(3846002)(6506007)(5660300001)(229853002)(6246003)(7736002)(446003)(11346002)(97736004)(81166006)(486006)(81156014)(105586002)(186003)(99286004)(575784001)(2900100001)(8676002)(26005)(256004)(68736007)(55016002)(305945005)(476003)(9686003)(86362001)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0128;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fOuim9O2kby7O4R347r/OfgZem5l+NzVbgO0cTg6poXxHW1wBKChkzAuHI1ahph5qIfMJjpk5HbJPqcwQIRtw0LZZqYZV85r+wQqaxUV8E9JoS1M4XU7H4UKd2gSWX9GlGr/KGgZmpKPOQ46CBdvr7S+RQr2W+I0ancB6B0SHU4WaCuJdHB3DilfZ/mYAancAg29V+l0vftb+RPSw5GbnPfWIlj0Cfu38O+OcCgZP1G54m3hdOZiHzI6QjNcsaMcpkrr7IqWMY0Ug4mWiv/5ikDfr6eXaRGmkdyJ8+OapKmXoTzddJ5jCDnplZi0rLPD4lqNEv9Ra+PXeuOYdHuyFGFNTiz5y/QZhs3TQcxS6oQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd99d02b-3035-4273-30da-08d61cc085ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 17:10:51.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 30, 2018, Geert Uytterhoeven wrote:
> This reverts commit 7acece71a517cad83a0842a94d94c13f271b680c.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Acked-by: Chris Brandt <chris.brandt@renesas.com>



> ---
>  drivers/tty/serial/sh-sci.c | 31 +++++++++++++++++++++++++++++++
>  include/linux/serial_sci.h  |  1 +
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index ac4424bf6b136cc4..5d42c9a63001575a 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -291,6 +291,33 @@ static const struct sci_port_params
> sci_port_params[SCIx_NR_REGTYPES] =3D {
>  		.error_clear =3D SCIF_ERROR_CLEAR,
>  	},
>=20
> +	/*
> +	 * The "SCIFA" that is in RZ/T and RZ/A2.
> +	 * It looks like a normal SCIF with FIFO data, but with a
> +	 * compressed address space. Also, the break out of interrupts
> +	 * are different: ERI/BRI, RXI, TXI, TEI, DRI.
> +	 */
> +	[SCIx_RZ_SCIFA_REGTYPE] =3D {
> +		.regs =3D {
> +			[SCSMR]		=3D { 0x00, 16 },
> +			[SCBRR]		=3D { 0x02,  8 },
> +			[SCSCR]		=3D { 0x04, 16 },
> +			[SCxTDR]	=3D { 0x06,  8 },
> +			[SCxSR]		=3D { 0x08, 16 },
> +			[SCxRDR]	=3D { 0x0A,  8 },
> +			[SCFCR]		=3D { 0x0C, 16 },
> +			[SCFDR]		=3D { 0x0E, 16 },
> +			[SCSPTR]	=3D { 0x10, 16 },
> +			[SCLSR]		=3D { 0x12, 16 },
> +		},
> +		.fifosize =3D 16,
> +		.overrun_reg =3D SCLSR,
> +		.overrun_mask =3D SCLSR_ORER,
> +		.sampling_rate_mask =3D SCI_SR(32),
> +		.error_mask =3D SCIF_DEFAULT_ERROR_MASK,
> +		.error_clear =3D SCIF_ERROR_CLEAR,
> +	},
> +
>  	/*
>  	 * Common SH-3 SCIF definitions.
>  	 */
> @@ -3110,6 +3137,10 @@ static const struct of_device_id of_sci_match[] =
=3D
> {
>  		.compatible =3D "renesas,scif-r7s72100",
>  		.data =3D SCI_OF_DATA(PORT_SCIF,
> SCIx_SH2_SCIF_FIFODATA_REGTYPE),
>  	},
> +	{
> +		.compatible =3D "renesas,scif-r7s9210",
> +		.data =3D SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
> +	},
>  	/* Family-specific types */
>  	{
>  		.compatible =3D "renesas,rcar-gen1-scif",
> diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
> index c0e795d95477daea..1c89611e0e0634ae 100644
> --- a/include/linux/serial_sci.h
> +++ b/include/linux/serial_sci.h
> @@ -36,6 +36,7 @@ enum {
>  	SCIx_SH4_SCIF_FIFODATA_REGTYPE,
>  	SCIx_SH7705_SCIF_REGTYPE,
>  	SCIx_HSCIF_REGTYPE,
> +	SCIx_RZ_SCIFA_REGTYPE,
>=20
>  	SCIx_NR_REGTYPES,
>  };
> --
> 2.17.1

