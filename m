Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A58C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DDB20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PgpATUnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfAVJBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:01:01 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:2657
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbfAVJA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qYIIYTOOznDQ4/3HghsaBaj0pY9Qq5+Lw31HEGnjMg=;
 b=PgpATUnxxQ1lfx0BtFBoYaP0ZUXqh+gNQyAelhwBXLuwpf9avu/0HJLuWuvdFpzXfzBU7YMleANnhM21tgCjsPFPzveAh8ivHhMTDdLsQmAsXa4ZWmof+9etZcaancl2s8cNwYrMe8qYmunHVq1nOrJHRqO8xTv6lsvOOlMZMgk=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5597.eurprd04.prod.outlook.com (20.178.125.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Tue, 22 Jan 2019 09:00:15 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%5]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 09:00:15 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP FlexSPI
 controller
Thread-Topic: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP
 FlexSPI controller
Thread-Index: AQHUrMnj2HaRDCPgY0i5ihL9RBjnkaW7Bz/Q
Date:   Tue, 22 Jan 2019 09:00:14 +0000
Message-ID: <VI1PR04MB57266D861937B99899F3C1C699980@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547553487-9936-3-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547553487-9936-3-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.120.0.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5597;6:R0LWJS49JyXQtBN4Immo8TGvYoR+7eijCH/5L1iuhIXmKfoLS00IFfocPhArSHq8l84bwOAMXlptaNTapCB1545zkv4vv8WOGU8I8zGkgIY5TCtZSmqTUKZ91Q62aE3ZmnUS5Ww6KYw+knXD3gUc0CLytNWRF7cI/UBcug/qRuO9m4wnHFNcx5V99WdYVv69HSBi9HlKufWi/qclY92Tm0PtG5zLo/X4eX41Tv3cYUwwqsSEkz5LOZhVADzml7yf9NBKC+t7C6jxISk+kMOefWVnm4O1YRnFKDLcy3MRTx+nNYHR/LqxT9K1sSK3wJ3j+IQymh7VP2hGjEkJ7JVP1+KxFXHzcXdNvq8QFoGnDgRpJwH/DjO5bGOHtJSobEV6/At/iSOtVFf4HXIj/M+YIk27mt6XaiyR5DZY2naQ44u2SU0Zb5L+cFpCVH485qfDdcq2u73vsMXXOQ8fW5ZUtg==;5:U0Zqb2P4ej/c7PT/Xv8AkXoyBcy029rCjRkreU3Hmori3nzEEh41tzZ9CxxfbqwYh1m7T5w6n4En4H3sgigasIlZ1OFbo9PfZC8hZ8cqT2S8xTo7C9E+CqUrdCDcrwCn8zAlrj0zn4M+H4eOuAyffssAlYI1485md1clZGcazg+6edfM+kiPhTmF4ag4MScGN2IcVW7Y/O2imMadbMar0A==;7:Zt7KJdCTAYCiiUkp5n6WTlohkem7D07sAn4pMndDvIzY0+vMTrxTsFmAjU4DkkZxNiq/G5btrVNJFZQoCL8ooBSbcbmEGb5BO3NuPZ1B/SYJPac4No8pSMRc/q86XD3n1EeYgrnF6CA10gzpsY8gLg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a579b8b5-3618-406c-910e-08d68048064e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5597;
x-ms-traffictypediagnostic: VI1PR04MB5597:
x-microsoft-antispam-prvs: <VI1PR04MB55972372CEDAD8CEFB5881AD99980@VI1PR04MB5597.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(396003)(136003)(346002)(13464003)(189003)(199004)(26005)(68736007)(97736004)(186003)(476003)(102836004)(4326008)(39060400002)(6246003)(53936002)(7416002)(74316002)(71200400001)(71190400001)(25786009)(256004)(229853002)(76176011)(11346002)(86362001)(2501003)(446003)(6436002)(53546011)(6506007)(7696005)(2906002)(55016002)(81156014)(81166006)(7736002)(305945005)(66066001)(8936002)(105586002)(33656002)(3846002)(99286004)(478600001)(486006)(8676002)(316002)(110136005)(54906003)(14454004)(966005)(106356001)(6116002)(6306002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5597;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +LiDDg5r7Cf5vIEkfsKD0fqHYxGRnAimV37SF6owSiJnxGYkEDet5eRVbCU9B8QQe8tHANLkwENmlzwRtJ0CProisl5nxssjA73FWGnemdlkduj2z2V2ath1D9K0nkRGphn7gpsTVOZv1l2Bi7fC0V1IpdXXrvZ6wblbtEd1i7l0Q1wuNCQU1xxCyYWwiIff2GPkiNhD4w33/jcadSSh7Q3dArDheNwnGJsHr9DtsjA4Odel/+E2a75w+ey7CePnJGp7vzFOW6T3HzLImFemOCtd9dNXI8BdcR+TiXXqr8bgd7zPLO+dV9WqWsJGuKrYkQ9wRzCxox7iuu8ReA0Fz+RaMe8M14gnVbTzuepbUigMzF8jRcnpuqXpp2VEWoPP54eG6EBMwYgA3wM3EvioZHU/NGqyXne1bsx9GuRxUE8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a579b8b5-3618-406c-910e-08d68048064e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 09:00:14.9755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob / Shawn,

Can you please apply patches [1] [2].

--
Regards,
Yogesh Gaur

[1] https://patchwork.ozlabs.org/patch/1025136/
[2] https://patchwork.ozlabs.org/patch/1025137/



> -----Original Message-----
> From: Yogesh Narayan Gaur
> Sent: Tuesday, January 15, 2019 5:30 PM
> To: linux-mtd@lists.infradead.org; bbrezillon@kernel.org;
> marek.vasut@gmail.com; broonie@kernel.org; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@kontron.de; linux-kernel@vger.kernel.org; Yogesh Narayan
> Gaur <yogeshnarayan.gaur@nxp.com>
> Subject: [PATCH v8 2/5] dt-bindings: spi: add binding file for NXP FlexSP=
I
> controller
>=20
> Add binding file for NXP FlexSPI controller
>=20
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v8:
> - None
> Changes for v7:
> - None
> Changes for v6:
> - None
> Changes for v5:
> - None
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - Removed node property 'big-endian'.
> Changes for v2:
> - Incorporated Rob review comments.
>=20
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt  | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.tx=
t
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> new file mode 100644
> index 000000000000..2cd67eb727d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -0,0 +1,39 @@
> +* NXP Flex Serial Peripheral Interface (FSPI)
> +
> +Required properties:
> +  - compatible : Should be "nxp,lx2160a-fspi"
> +  - reg :        First contains the register location and length,
> +                 Second contains the memory mapping address and length
> +  - reg-names :  Should contain the resource reg names:
> +	         - fspi_base: configuration register address space
> +                 - fspi_mmap: memory mapped address space
> +  - interrupts : Should contain the interrupt for the device
> +
> +Required SPI slave node properties:
> +  - reg :        There are two buses (A and B) with two chip selects eac=
h.
> +                 This encodes to which bus and CS the flash is connected=
:
> +                 - <0>: Bus A, CS 0
> +                 - <1>: Bus A, CS 1
> +                 - <2>: Bus B, CS 0
> +                 - <3>: Bus B, CS 1
> +
> +Example showing the usage of two SPI NOR slave devices on bus A:
> +
> +fspi0: spi@20c0000 {
> +	compatible =3D "nxp,lx2160a-fspi";
> +	reg =3D <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0
> 0x10000000>;
> +	reg-names =3D "fspi_base", "fspi_mmap";
> +	interrupts =3D <0 25 0x4>; /* Level high type */
> +	clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
> +	clock-names =3D "fspi_en", "fspi";
> +
> +	mt35xu512aba0: flash@0 {
> +		reg =3D <0>;
> +		....
> +	};
> +
> +	mt35xu512aba1: flash@1 {
> +		reg =3D <1>;
> +		....
> +	};
> +};
> --
> 2.17.1

