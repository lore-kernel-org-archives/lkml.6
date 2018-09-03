Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F47C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315C920868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tfVuggHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315C920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeICONg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:13:36 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:2912
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbeICONg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPZXkOJXMV/bhd/UzgJv1ts/oy51VTmDXezSHoCFWRY=;
 b=tfVuggHyA0FiH+N3LBY30UZ2pqpF0yYqI68cAsJ5/DFML4DaXDJGB/zV9+vjsNMyrKkRClGVTsNVLExloiXKusAgQKV4KPlOVAh8s8EAor2gthdujnAWJxsQhzc+VbMm4s/imjFZfqztF8prk3F7Fz643SXgI9nTz8u/6J4KDx8=
Received: from VI1PR0402MB3854.eurprd04.prod.outlook.com (52.134.16.150) by
 VI1PR0402MB3453.eurprd04.prod.outlook.com (52.134.3.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.18; Mon, 3 Sep 2018 09:54:09 +0000
Received: from VI1PR0402MB3854.eurprd04.prod.outlook.com
 ([fe80::897:f79:30db:fffb]) by VI1PR0402MB3854.eurprd04.prod.outlook.com
 ([fe80::897:f79:30db:fffb%3]) with mapi id 15.20.1101.016; Mon, 3 Sep 2018
 09:54:09 +0000
From:   Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Thread-Topic: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI
 driver
Thread-Index: AQHUQRXqXHufO5GR/k6Z3bXrn70xkqTeVVkw
Date:   Mon, 3 Sep 2018 09:54:08 +0000
Message-ID: <VI1PR0402MB385465BEDBFC9CB6A89BEFF4970C0@VI1PR0402MB3854.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prabhakar.kushwaha@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3453;6:tvkA7LeFQp0oAZINI1izhaIu5dBT8YumbeSaFqYOW4VhJsrRsRQa0Y8oSM4rNYTaI4qb0crBW0KaCmq7Q1T0h1Dmasp7NzrBBN9VaeNyTlTSucQwyJ41qWL+WCEKlkubObpEh6DQinRmdLaeLNKSIKHNaqALZjlm6iBYpTGi0SnMIztEqCzg5DtNizeXu8qKNhJDMgCNnNVJ4Id3CczSq1T5TIdp7wfzF8w2GJxgU6z2cACbkUILds5Yaqz8qvblMjFQrbs2baq6SlkI18qqEdQQJILrlJ6ZoAeb5DYBo0vghWBZKQ5gbbMobIhvaH/5ZPHh5zMca1drr1xSfdKdnjc/3T+ci9HiL1O+SvGhH+q8SB4WNMU0ZfTzmsx/Id3E8IGluzjIsFmpnVgrRDZkbLS/3eoLlJMl1HFcgS7zOX7p2Jt1PzpuooeSD/754LwweduF5r++pM90XcMtgttI9g==;5:3T/pXlekUbOn2jTNy2U0Ua21wRxveGM5eNMwJqXV7cvpHufZd4cJFGW2F9s2kdJn7qLek+AthAiwE9z/u284kEWp4pyAnbN7TCEOOVWmm7F+y3J6kx2BbOpycz9p+ax5k9/n2/f9eKZLB7HAQJ7MTPCyD/Xk0o/04LUUMOEaADc=;7:ssE60hfPWwJn4FaWY12SKU23N9r1PejkzRsN4X9RLcStwCKrg9jQOrrrmB5E9vfYWlgemhFyvrlXuHjnD4D73H+kxhRk4YM/UdR+7yeZIr8feb7nso4/cJ9Z+z0o/i6Bzzh+fNLgF25ivZDHzKc4z3F2BvkBz0GUnIC13TQ6ThskfdbAeflyp6MQzw7egtmqwNTRMS9Y0KAfn4N2e/aH//zL9HRcPAc2O2cDVs7Q7xn1XX+6Hlebt2Y2byykDLIV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9b740554-25cd-49cf-07cf-08d6118331a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3453;
x-ms-traffictypediagnostic: VI1PR0402MB3453:
x-microsoft-antispam-prvs: <VI1PR0402MB34536791BDD358F042F17AF2970C0@VI1PR0402MB3453.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:VI1PR0402MB3453;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3453;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(13464003)(189003)(199004)(316002)(6246003)(3846002)(110136005)(14454004)(33656002)(6116002)(8676002)(54906003)(68736007)(7416002)(7736002)(8936002)(5660300001)(2906002)(2501003)(305945005)(74316002)(97736004)(2900100001)(81166006)(81156014)(26005)(413944005)(76176011)(7696005)(2201001)(86362001)(106356001)(102836004)(6506007)(6436002)(53546011)(256004)(44832011)(478600001)(476003)(66066001)(11346002)(446003)(229853002)(486006)(9686003)(53936002)(39060400002)(5250100002)(4326008)(105586002)(25786009)(99286004)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3453;H:VI1PR0402MB3854.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xqUEPBLTb5kVF0MwPtqTpxVs97rzW+a8eESW5bg9+uwvzRy7uJ4rPThvkgMOXElzCMCS7sgSApEVMCLB3+9K9LSl7V4JcPmu5E95ZzB/VSBg4oVZp+XxpfwSy8ptrj8PHTorwsGSmuFvcQqLd2q95jvuVZKbbU33LmtX6Y8N21EnpAG296/urRKNYckUIVTk6izQxILfRhrFvwtx1JzYj3D3V6qnhWg3OM2QXrZKEj7nnSlzH8J18VmIuCLQlOXqMXeU0b8EHAZSVEiLvdpefmeBfp5/3a3IJwOLT4TugNVE5OrdN709gjDW1TEEe41nDRW5ibFZQ1+ui1Gy9KNb+mNJS9xwP3aJJp8SjFseAa4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b740554-25cd-49cf-07cf-08d6118331a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 09:54:09.0049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yogesh,

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Yogesh Gaur
> Sent: Friday, August 31, 2018 4:00 PM
> To: linux-mtd@lists.infradead.org; boris.brezillon@bootlin.com;
> marek.vasut@gmail.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org
> Cc: robh@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; linux-
> arm-kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org; Yogesh
> Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI d=
river
>=20
> Add binding file for NXP FlexSPI driver.
>=20
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42
> ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-
> fspi.txt
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> new file mode 100644
> index 0000000..9f07116
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -0,0 +1,42 @@
> +* NXP Flex Serial Peripheral Interface (FSPI)
> +
> +Required properties:
> +  - compatible : Should be "nxp,lx2160a-fspi"
> +  - reg :        First contains the register location and length,
> +                 Second contains the memory mapping address and length

Why are we overriding reg property.  Is there any special requirement.=20

Can we use "reg" and "ranges" property in device tree.
Here "reg" represents controller registers and "ranges" represent the memor=
y address of flash.

--pk


