Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB321ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423B320874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S73tNIE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423B320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbeGXO6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:58:41 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:6560
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388398AbeGXO6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GFcaAhDEc5ad3obvrk/30fKS2HaFe6gZHSjseYEhhI=;
 b=S73tNIE4BdFBaa2c3cyc4kXnkpaY4blxqLuOFKsailgSjC2F3pJHrPExOdv8fguEw0fx35edaEZrY27zjiRwtRXA8/S9YFKNC6C4620mH8RH7p8leb1irzApZU1LNSApVYM3jCChKicnOnLbvfU9EqjVgVn7QHK0lxuBybLHh1M=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3645.eurprd04.prod.outlook.com (52.134.14.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 13:52:01 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::197e:c4f9:bb4d:e560]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::197e:c4f9:bb4d:e560%2]) with mapi id 15.20.0973.018; Tue, 24 Jul 2018
 13:52:01 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/4] drivers/soc/fsl/dpio: Convert DPIO documentation
 to .rst
Thread-Topic: [PATCH v2 4/4] drivers/soc/fsl/dpio: Convert DPIO documentation
 to .rst
Thread-Index: AQHUIqa5Ytv0ysE7Fkmbd0N98zfL3A==
Date:   Tue, 24 Jul 2018 13:52:01 +0000
Message-ID: <VI1PR0402MB348590E265D062CFC83F7FDF98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20180723170025.2259-1-roy.pledge@nxp.com>
 <20180723170025.2259-5-roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3645;6:fBQDnlypPGn9KzF2E7e6U2YAx8bW8TJ1z50K3I/AQiXNGTiG+h1xz8BBu9Hkwa9gba6LrTw/P+r1DoN77/pSGq1JjTqGMHNclkOQzk2ZBAdDaI8eR7YmuMbTluxAZZMneQBRA3OZW29qUAADiklEardNLKYQLXB2R9q0LHRGq7qeX5Zpo7BQu0VB9iBpWNVz436EfFvlSUGgk+KdThWCdjEKUmm4NrYzhA8GDsaJn+X7/uct4GuDLt0OW3WabHDqaWH9Ql5zpBxSH9SbsQH9wz4W18TAs3MUt0s/b9fHkCl/JfuB9+pnSL7+tGSgu0IJPWjF+KMbxv9v0qBE6N3SFZFi0X2pa3yYny26qEj/nXs5nAdFUVK48DbI+qoCh2Pnf2oTjXaZgf095H9Yy+TEWinEKV2HlMQCWRGKKnjPUqxfkccmuR4+oSWVymgU0qpsBpUsMAO8mej1Qdb2kytQ6A==;5:NoEjocCg8oe4TejoqzPhrZyeveUWMdcKyKN/LYxVRqsqZMtpolSd1AlIVmyg166G+zCGYonLK5SxAzCLL9F1obwobVZbYfbC4QqASzweZaYzhdIJ+1AyA3q7PSPlEC2TKHmoWwHFPPa/MQaZ6pl8XujKkifbvLhqxtRevn+Ijjg=;7:gK46nqwfy6Qc+Rcm1U/qeO1wmYbk17iC+0N3zGeyqXQyUJWmHuo6Vgqf6QKYFvSIhn5rZx9IotRnKuwUH77z8WUQNwiZhuKYVX8PxXQAsBSg/Tmtgwdz7ZvhUbcmcQcgXlnMhsYG1TtfzX+bSZM9Vunx7fcTvKkT2bZfPybVHJs42ZvOmk6cSQo/xx7F7eYVjX+9j5pAUNKhkThTfA7OdPfzXt57buQnC084VRlQ8SqZj929FbayJZ2dmF/yn8ls
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f576f915-47a7-4d54-85cc-08d5f16ca1b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3645;
x-ms-traffictypediagnostic: VI1PR0402MB3645:
x-microsoft-antispam-prvs: <VI1PR0402MB3645CDCBC778CF598381352298550@VI1PR0402MB3645.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0402MB3645;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3645;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(346002)(366004)(396003)(136003)(376002)(199004)(189003)(53936002)(6246003)(478600001)(6636002)(4326008)(44832011)(5250100002)(66066001)(476003)(486006)(106356001)(2501003)(2900100001)(97736004)(54906003)(2906002)(5660300001)(110136005)(7696005)(316002)(6506007)(25786009)(99286004)(229853002)(102836004)(6436002)(14454004)(3846002)(8936002)(68736007)(8676002)(7736002)(33656002)(81166006)(305945005)(256004)(2201001)(6116002)(81156014)(9686003)(55016002)(86362001)(446003)(105586002)(76176011)(26005)(53546011)(74316002)(142923001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3645;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g6INmu50G6ZlN1IW0teBiaDy76Tjp0Z9WaoL1tpAhWLeh3IAxHbtnUgLGos7VQo7iErBu/n1qEz7Dodm0sjBWENSkBEBaRbWewZFB1OmXgXelVVXBZDh0kOz1HiTAaNnOliHxdYIc/Bv5g+cw9hFhccoa3J6SZQP9hJfuhjEA1f6GACUb6y4xsg7TGIM+y57EsXDeZIYXWnJXEV4+2+68AfTkYotDQJh3B4Ep9EGRWj53SPz2Iomy5VanvcTk1LdVKU/8c5owwFa/2epVD8C+B3+U3drr3p8hC1TeUQKGqDZnwiKbAT9chDNlPSL6vwFm/onO+fCBguum/Njh5nvlYWbnrK40ELPF/913BmyC4c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f576f915-47a7-4d54-85cc-08d5f16ca1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 13:52:01.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/2018 8:00 PM, Roy Pledge wrote:=0A=
> Convert the Datapath I/O documentation to .rst format=0A=
> and move to the Documation/networking/dpaa2 directory=0A=
typo:             ^^^ Documentation=0A=
=0A=
> =0A=
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
> ---=0A=
>  .../networking/dpaa2/dpio-driver.rst               | 30 ++++++++++++++++=
+++---=0A=
>  Documentation/networking/dpaa2/index.rst           |  1 +=0A=
>  2 files changed, 28 insertions(+), 3 deletions(-)=0A=
>  rename drivers/soc/fsl/dpio/dpio-driver.txt =3D> Documentation/networkin=
g/dpaa2/dpio-driver.rst (94%)=0A=
> =0A=
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.txt b/Documentation/network=
ing/dpaa2/dpio-driver.rst=0A=
> similarity index 94%=0A=
> rename from drivers/soc/fsl/dpio/dpio-driver.txt=0A=
> rename to Documentation/networking/dpaa2/dpio-driver.rst=0A=
> index 72ba9da..3a33a33 100644=0A=
> --- a/drivers/soc/fsl/dpio/dpio-driver.txt=0A=
> +++ b/Documentation/networking/dpaa2/dpio-driver.rst=0A=
> @@ -1,7 +1,16 @@=0A=
> -Copyright 2016 NXP=0A=
> +.. include:: <isonum.txt>=0A=
> +=0A=
> +DPAA2 DPIO (Data Path I/O) Overview=0A=
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> +=0A=
> +:Copyright: |copy| 2015 Freescale Semiconductor Inc.=0A=
> +:Copyright: |copy| 2018 NXP=0A=
> +=0A=
Existing copyright should be kept.=0A=
2018 could be appended if needed.=0A=
=0A=
Regards,=0A=
Horia=0A=
