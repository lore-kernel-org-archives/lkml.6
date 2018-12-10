Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB9AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8004520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 04:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KQXurlTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8004520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeLJENc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 23:13:32 -0500
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:39392
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbeLJENb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 23:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiRh2iVZjHFhL2ddrIwlWrhFyqzvlEywqcr0KLWIq9k=;
 b=KQXurlTdCTP6Ayo+PvWf2O73gn1l43KRcrsnPkDsYAgnrsR8y/PKANQeqUwbwUFFJgieMn+i0TyFrVdOVTZiti+2kREAX3QMjNJgLhwfVKLWUxG1R6OaznKViZbuTmHjWg1fn7tKzPPFxkIyjbXolMpOBBlln4v5fojGxWVGHRk=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3999.eurprd04.prod.outlook.com (10.171.182.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 04:13:28 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 04:13:28 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Vignesh R <vigneshr@ti.com>,
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
Thread-Index: AQHUiuOjeSgB/5zRPUqi536teiWNPKVsvNiAgANQIQCAAA5HAIABBArQgAApmQCAAABNcIAA5e8AgAU4I4A=
Date:   Mon, 10 Dec 2018 04:13:28 +0000
Message-ID: <VI1PR04MB572641541BB83E587541BBD099A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206074554.0ec0aecb@bbrezillon>
 <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206202956.GG3084@sirena.org.uk>
In-Reply-To: <20181206202956.GG3084@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3999;6:RYUk4Kh871726mQvCfH0LgpjM6nVTk6EIoRD8uRFnurnbRaawRSu/YGBZnG3FqWSqeDDIm5mGmR+Qff4c2jpnGtq3WV3KCeF0EGexUmlK53FHdC8ZcdH+a0632PG0/OECeJCG2gP4Hht5ZwGIr7Bc7hCWZJqj47vMdQValjTvYrd8S7SwGR2ukGjxImZLLYyaXmxAGqfnqsX8oEn0Oj7ujQj6gnQinpraAHF90wlHQ+nMa6P2USk1ztAakXrPEpjTyMgSN8bgwhCyXGqQ/cDJAhV+jXrv/zBy4ve22C3lMptq9A/iJyNkLSUiAbERSzmlVCNtXEdWHSNuIwD0WumOXe9y3dJvelj2VdqxcBbR+AlPQgcI8q5mPNKCNswLyQlQKIswUBIRbWXn15vuZPmhpcQY01VqOgTWfiDKiO/0rj+qYvsXrD/YrlzxtUuS+A9i70KtKEvEQ9tVvMGxfFSmg==;5:nup1tO1mo2NxOVQdQLMuQXJOZopu6k4EwkZAI3NYy3qYOQurPe8gz5sELNMKOEUDPc84td9U4QGV6ljkReTwGOS+ViNnrTTvpt6mSNQQL6FBPlmPMkd4KBrGYhNdK91Rhximc5wvLAIBbWpAjf4XlW0DVsPxY2u8WCEhpzUFRW4=;7:GWkWYF6GZyw+JzqQ+w7OIUZunRlO8dOiP67RHxAsNOdTzU9hmG8OpeSlTLvauWwdk2x3a2tOkeJzwoBIZqPGqOybqRxRpp4p5ti88lCmCpLD+mII8+B9Bd6l+80M1RAJFVLvvBMutneAHd+SOlCn5g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 522f279f-83ce-4f7a-15e2-08d65e55d668
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3999;
x-ms-traffictypediagnostic: VI1PR04MB3999:
x-microsoft-antispam-prvs: <VI1PR04MB39999958B98117128B9C895C99A50@VI1PR04MB3999.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3999;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3999;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(376002)(396003)(189003)(199004)(13464003)(6306002)(53936002)(6506007)(186003)(53546011)(9686003)(26005)(229853002)(86362001)(102836004)(7416002)(7736002)(55016002)(68736007)(305945005)(81156014)(81166006)(8676002)(8936002)(6436002)(66066001)(76176011)(7696005)(106356001)(105586002)(74316002)(446003)(99286004)(2906002)(478600001)(6116002)(966005)(256004)(97736004)(3846002)(54906003)(6916009)(25786009)(93886005)(5660300001)(316002)(71200400001)(39060400002)(11346002)(14454004)(71190400001)(486006)(33656002)(476003)(4326008)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3999;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GFsAZY2BuWglAPK5o1OEuUZLW6OM65Wv67fOmV4B4wS2eBIZMEV+smCCsHE94+OWHDdI6WcSiTUBtsW22PGhsKtmzgnQYgIVMm6mRNjmWkePmPr+d2Y594891CWaX79ERu5NlhIxhGXB8nEwoGPWYrH9+TD6xXpdddRZURtufzNXOIxucy3OgoENVoKQzX+VH9TRonT3d/xZ2304hNeeWSusiRa7W33DJd/Z6Bs0gXn3yFlO6N7nPjoo4Kj3ybAfO2DuIREWR8IK8aeEK2+A81cLsA0mYMHQOan8R9OLLcCs/OZ2RlZX2kLDym80kUEx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522f279f-83ce-4f7a-15e2-08d65e55d668
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 04:13:28.0429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3999
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Patch has been resend [1], this patch is depends on the series of patch[2] =
and this series has been applied by Boris already.

[1] https://patchwork.ozlabs.org/patch/1010253/
[2] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D70384&sta=
te=3D*

--
Regards
Yogesh Gaur

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, December 7, 2018 2:00 AM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Boris Brezillon <boris.brezillon@bootlin.com>; Vignesh R <vigneshr@ti=
.com>;
> linux-mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
>=20
> On Thu, Dec 06, 2018 at 06:49:08AM +0000, Yogesh Narayan Gaur wrote:
>=20
> > Sorry for ignorance. Did patches needs to be applied by Mark Brown, sho=
uld I
> resend the patch series again?
> > Also can you please review the series [1] and add your Reviewed-by tag.
>=20
> As I said in my reply earlier today in the same thread:
>=20
> | I don't have this any more, it looked like this was stuck behind the
> | otehr MTD changes which seemed to have problems.  If someone could
> | resend?
>=20
> so please resend.
