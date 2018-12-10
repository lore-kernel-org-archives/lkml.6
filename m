Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72749C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2975B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ms1vq/Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2975B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeLJIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:39:27 -0500
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:2656
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbeLJIj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsLVtTxUpVSl5rRZKCHlqODROhV+UKxNSwZj+pFn00M=;
 b=Ms1vq/RnSgC+yk8fqnYjkIPHrFXDigLXLx9yQI7cJvP3jFbklMOKk3MURA3EQvdt4hOgXObbDDNSMqpMB2brRrLnjAd8dEo0T/e2LZSXnrFQ4VcBM7JlK1a9IZoxQvJ/suhQUR1tkyWaLpcBDsCVdYIEPKYqwntvUme9yGy6868=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5824.eurprd04.prod.outlook.com (20.178.204.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 08:39:20 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 08:39:20 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v5 0/7] spi: add support for octal mode
Thread-Index: AQHUiuOjeSgB/5zRPUqi536teiWNPKVsvNiAgANQIQCAAA5HAIABBArQgAApmQCAAABNcIAA5e8AgAU4I4CAAEXYAIAAAELw
Date:   Mon, 10 Dec 2018 08:39:20 +0000
Message-ID: <VI1PR04MB572609DBC52F7496A656915E99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181203101937.7b01a0ad@bbrezillon>
        <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
        <20181205134618.56223758@bbrezillon>
        <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181206074554.0ec0aecb@bbrezillon>
        <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
        <20181206202956.GG3084@sirena.org.uk>
        <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210092208.0971c3be@bbrezillon>
In-Reply-To: <20181210092208.0971c3be@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5824;6:bv0j2lF0ofGLcS8qRy5Fxq1rsshZS4fMA+1CGdh7QNDlgwpho6AzRnUfjOUAh8el3lBUiXKVPMYT2Dn806nsgqWYCunInegrrdrhzfshvFqXfF+p0jmqgtJlhh0jMIm8sn8aHm06suyZfA2KsjJ0R+ARjVoSGQ3NMbcmVN57bwCyf8QSuI9IepzqMQVWHA7O/o8BhvRITy2XY6JGq0NLAKQ/XYAnzQAqULJo0ZoklmpO2nYkMlYeRPkEb+JbJekjrDPjmjCRfzG7qjrboniBbP6c0feGbf1d7A0GZh6qXvDuyWYVy7V4aNGim74hNf0vaRvq/PtLoDmw2l8PrqZMTEldFMeFg7SNQjdZvxQSDgMcJwmgzHFnAg/w0wqX5AlnJYq4maB1lPpCAnJ632g95HnAj0bvdA29UD7J9j2G0VMlNcdyVD46/N+QygOG6XoQcqppll5wD6HtQROtykPe7Q==;5:t3orbg8NxcIVwbbIWopRdeB1NxfNetaDs5OVgkx99I3JGBRPqne52iesqnQnoR9IJL2IQLeGSbMzUhGUsdkzenEEnm1nyfta0JYosZbdf4s4uWoX/IEoGmMKpJ0kdGxqMSlo9tIbIY1aymdWOBKOOSXjlvEExKnFXYRhlmJB2+Q=;7:Jcgupdc/sRyPV5Yx3fajTzYvDOzzSDxrHcY0xyZizXN40A669YLYFvqGhYhDtluNi7PA+XuQKa6Pwvw34C4Og03s2+x7bA6uyzU+dZ1mS1qeGgWYjwDppeHZtej9nlcVR658bHqWA+MkoTpdDKNDjQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0b2b4df8-ecb2-4057-38bd-08d65e7afaa0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5824;
x-ms-traffictypediagnostic: VI1PR04MB5824:
x-microsoft-antispam-prvs: <VI1PR04MB582417E930EA6C44F1E6DA6599A50@VI1PR04MB5824.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5824;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5824;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(13464003)(189003)(199004)(71200400001)(71190400001)(53936002)(99286004)(7416002)(2906002)(6506007)(53546011)(6116002)(6436002)(55236004)(3846002)(97736004)(7696005)(55016002)(14454004)(6306002)(76176011)(9686003)(68736007)(316002)(78486014)(478600001)(86362001)(93886005)(6246003)(39060400002)(54906003)(4326008)(966005)(66066001)(7736002)(33656002)(305945005)(8676002)(81166006)(74316002)(5660300001)(8936002)(81156014)(229853002)(446003)(11346002)(26005)(106356001)(256004)(102836004)(105586002)(486006)(6916009)(476003)(25786009)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5824;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KUKoNFhLaTovnE+ogNOysOrmvcAiWuTcoov/b+JJuuRC75CCIHngZln6gNukeTf4BA/TNFXV/OCWwQ1mKTheJ4pbTPT/ynXMz7RIvpsCX+UEtIn65rt4qcCQWvA7SFLDs/eogLNWKmNPMvnAz29STGjtepbSlmU1NIX/Mv/DjLt3SVLj7ZfEDyRpSQcotGMsC4DrRoqWYqgth5PWQJaEOqg0/U7kt3eZFM050SlTj4P+Zwx9rvrlYRFRWdzJ+2yPZs/t8pvELGWqzFoXDgHirZbk+miZG0Qw0svdmv+51EFdPgTedCQNlVuz19R1r12i
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2b4df8-ecb2-4057-38bd-08d65e7afaa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 08:39:20.1958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Sorry for confusion.

My intention was just to point to the correct patch number only. Earlier yo=
u have asked Mark to pick the patch [1] but that patch number was not corre=
ct.

[1] https://lkml.org/lkml/2018/12/5/758

--
Regards
Yogesh Gaur

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 10, 2018 1:52 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>; Vignesh R <vigneshr@ti.com>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org=
;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
>=20
> Hi Yogesh,
>=20
> On Mon, 10 Dec 2018 04:13:28 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Mark,
> >
> > Patch has been resend [1], this patch is depends on the series of patch=
[2] and
> this series has been applied by Boris already.
>=20
> You're still not asking the right person. Every patches touching things i=
n
> drivers/mtd/ should be taken by me (or another MTD maintainer), and patch=
es
> touching things in drivers/spi/ should be taken by Mark. So, the patch yo=
u're
> pointing to should be applied by me. Plus, I told you I would apply it af=
ter 4.21-
> rc1 because I don't want to deal with the mtd -> spi dependency.
>=20
> Please be patient.
>=20
> Regards,
>=20
> Boris
