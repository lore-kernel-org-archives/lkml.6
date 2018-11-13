Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5925C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540F42243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ulr7OEzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540F42243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbeKMQ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:26:55 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:53898
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbeKMQ0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooJwk241NlVLbSSOoA5DeN+O5Wz2e0dk0CsC0pBUY0A=;
 b=Ulr7OEzg1P9959bYvqia4GP55tKlF7YPcSYpr7vZIROTTqw80VBIZjrfgrS+T7wK1xIHH+G5lpu1rNk24SWBF1MkDZLU6RfNQn+AS97O7Sc/jl14Casze62XTH2ii3FMjMEeSiBBSTEr+PUMmQFgSDM/MwZGexUqWo04Gb8ec4Q=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4974.eurprd04.prod.outlook.com (20.177.49.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Tue, 13 Nov 2018 06:29:31 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::297b:bb50:9b83:48e1%4]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 06:29:31 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>
Subject: RE: [PATCH v2 1/5] mtd: spi-nor: don't drop sfdp data if optional
 parsers fail
Thread-Topic: [PATCH v2 1/5] mtd: spi-nor: don't drop sfdp data if optional
 parsers fail
Thread-Index: AQHUeE053IjYhflw0UCjtbAlbTD0PKVNQ5gw
Date:   Tue, 13 Nov 2018 06:29:31 +0000
Message-ID: <VI1PR04MB5726CD772469F352B316CF6799C20@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <20181109165644.30534-1-tudor.ambarus@microchip.com>
 <20181109165644.30534-2-tudor.ambarus@microchip.com>
In-Reply-To: <20181109165644.30534-2-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4974;6:VH4jnAQVUaMojNch8xBET46PLm8fC03WEyohDBT1xEq0RhTPXUKY4IXzPawU10wIIRlSPPY7K8xaPYEVjThH7CHSBHU9qSWRcGpO1rTg6WkyZXH0a2j5MdPqQlnxIMLpbwIGfNiaypHAmkSXKnAaKMsiyYKd//+sY35WYOhzP8QlNSTPAVcOe5bHu3VCYYbRs4T8d5d5sSwt9U+67E0GKh+IlQf4mIYk6dEtsjEQ/BZlBHrmFNh5zZcVrSj5XIT+Y+x0YCTje7r6d7uUZE6+yZerTLqJf9sVYvTh6Xj75gVvZl4BPA2lD6OEgcBHrGwqDyiYgKLHRgT5r6Ye5F+43ue8QFWfpTvyjyM0RDQ+w8cKVicn+1VT12uxUVFie+EESs9dLsUlf5wCaxObSIXtRUMMhkQJAWyTe446CxJ4ts1L7/gb22CqNTfOeG5ciKrJnLx9RGHNz6AjnecfGAdP8A==;5:rIPMGjdwM/c0FM2jhSg1uR9qS/9r3ViwUzHpmJ+dJeQHldcscty1ppkR0xPkGlRk3fgDOFVFoLC9F5tpZdEkLGtDM7xJ0/aIusU2uNPd8WiassX5n+dayg5wjwkqVyQwkHqCeZxQ55bQLyYkxB+egN5wC0jVpL2UCfDfbcq9vWs=;7:qquuyVBZXTwuZoncx2iwl8ciT+ZWWWqO2TnZ4jz3r9sItKXNqpvM3daqbS8ZELC2FB9PCv/RYUGlVXpK3Zuuz/tcTPe1c/FkfeObsn8JrMBVM4HOpZTLKeGS1vavep5HupmQJnCmds+ABCvQKgxQiQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 40800b92-c738-46d3-ae6c-08d649315f11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4974;
x-ms-traffictypediagnostic: VI1PR04MB4974:
x-microsoft-antispam-prvs: <VI1PR04MB4974CB1400A40855D3D4F56599C20@VI1PR04MB4974.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(258649278758335)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231406)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4974;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4974;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(346002)(366004)(376002)(39860400002)(136003)(13464003)(199004)(189003)(3846002)(6116002)(6436002)(8936002)(316002)(14454004)(2906002)(186003)(14444005)(486006)(256004)(446003)(229853002)(476003)(2501003)(2201001)(86362001)(11346002)(97736004)(78486014)(5660300001)(55016002)(9686003)(39060400002)(305945005)(74316002)(26005)(2900100001)(99286004)(68736007)(106356001)(33656002)(105586002)(53936002)(81156014)(478600001)(8676002)(81166006)(71200400001)(76176011)(71190400001)(25786009)(6246003)(54906003)(7696005)(4326008)(55236004)(110136005)(6506007)(53546011)(7736002)(102836004)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4974;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qA06umfYgQq8eZvZFZuDNKcwMeU9KGfY/EY3nfvGNDf8Xnjzj5+EW8QCwx9Dhom9h9EPrU3DxmWvWFFlUbQhf35Xh8IG9zs9qu4E/fUoMzVt/oUDofxL/nUK69TjE3DLB2W8pEOWXdk8AlZvQ9rGWZaIXAUDKZRU84rTJ9GGm1lU5794GZwoHB5NB8+SNNti4+j2sBRMp/kARhdHIfPbOzCA6MYGYqEVmKTYFXu6SfFAJavwNWvBcVrytv5H5e4SQJGqSo9hn/YkYiBCVIwrxaaMY188fSsWmOuODBfA31EgT5j+oKYPx7/JQMfsGJTgkibeirwLRirSm6Sz5Cq/Ox51+qp9M2hOfkseAcNOD08=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40800b92-c738-46d3-ae6c-08d649315f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 06:29:31.4711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4974
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Tudor.Ambarus@microchip.com [mailto:Tudor.Ambarus@microchip.com]
> Sent: Friday, November 9, 2018 10:27 PM
> To: boris.brezillon@bootlin.com; marek.vasut@gmail.com;
> dwmw2@infradead.org; computersforpeace@gmail.com; richard@nod.at
> Cc: linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Yogesh
> Narayan Gaur <yogeshnarayan.gaur@nxp.com>; cyrille.pitchen@wedev4u.fr;
> Tudor.Ambarus@microchip.com
> Subject: [PATCH v2 1/5] mtd: spi-nor: don't drop sfdp data if optional pa=
rsers fail
>=20
> JESD216C states that just the Basic Flash Parameter Table is mandatory.
> Already defined (or future) additional parameter headers and tables are o=
ptional.
>=20
> Don't drop already collected sfdp data in case an optional table parser f=
ails. In
> case of failing, each optional parser is responsible to roll back to the =
previously
> known spi_nor data.
>=20
> Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table=
")
> Reported-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Tested-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v2: update Fixes tag to point to correct commit
>=20
>  drivers/mtd/spi-nor/spi-nor.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.=
c index
> 4a96ee719e5a..2cdf96013689 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -3130,7 +3130,7 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	if (err)
>  		goto exit;
>=20
> -	/* Parse other parameter headers. */
> +	/* Parse optional parameter tables. */
>  	for (i =3D 0; i < header.nph; i++) {
>  		param_header =3D &param_headers[i];
>=20
> @@ -3143,8 +3143,17 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
>  			break;
>  		}
>=20
> -		if (err)
> -			goto exit;
> +		if (err) {
> +			dev_warn(dev, "Failed to parse optional parameter
> table: %04x\n",
> +				 SFDP_PARAM_HEADER_ID(param_header));
> +			/*
> +			 * Let's not drop all information we extracted so far
> +			 * if optional table parsers fail. In case of failing,
> +			 * each optional parser is responsible to roll back to
> +			 * the previously known spi_nor data.
> +			 */
> +			err =3D 0;
> +		}
>  	}
>=20
>  exit:
> --
> 2.9.4

