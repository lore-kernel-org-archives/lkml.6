Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D27C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2020E20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p/xXJ6Kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2020E20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJWSXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:23:41 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:51917
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728823AbeJWSXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09qPxXNDt52dV+34m0hu0F7Zu+IXl7qEUG0V6bMY8jM=;
 b=p/xXJ6KzQmj5VppdQ8QnxwOrW5GerT5iNePK1tN+aM1EmebpRm6ri/1aihKXSOWX8aQA+0AFZhUAhOJmvP2ibRIlpvwH12uC4+pg1gtKujd9ZlLE1gOxh4Q4LVcZrpPh719taRwDF21SMgxTsC7ANflLvXoy7sOmv9ua2/C/nqU=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1630.eurprd04.prod.outlook.com (10.164.84.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 10:00:53 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 10:00:53 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Thread-Index: AQHUYdKDjlmkWwN6/UiXD412Qj9EqaUbIC2AgAAAseCAEXYtAIAAEqwAgAAAajA=
Date:   Tue, 23 Oct 2018 10:00:53 +0000
Message-ID: <VI1PR04MB1038EB05135EF88B10FA1D3B99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181012080753.2a59b75c@bbrezillon>
        <VI1PR04MB1038A3680E02FC107367E5FF99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <VI1PR04MB1038969FFFCC16DD6094031599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181023115634.00dd6d23@bbrezillon>
In-Reply-To: <20181023115634.00dd6d23@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1630;6:LQbJGt6VheZebbzZbW72KrXHfteUcPFoMUnCyPE9fwLkpzkQHcOFSfn8EAlOtQ0nXbO1ZIw6fehK38B+FsRnX2JKhiO4+YmAC6NWHIR998jaMYTUwDd1jCAmvDxTha/afeILY8z2tUIQPP8mbGxWKL2EetXp5wbq5LWM+fcNZQUhd9LnjuFxpqZ3Q+Ex9mSktQ28QBWAoGVtTlLOHAk9vFgzttDX84vLGZfNxUZCquoDkGjOKQb+0hafPFp7MGrQWNn7obUifIZVFPTWC62tKc5cBTlr6S8Xp65IO4oM8u3oqyLvuS77CQjdFeFFmaHP1VjdhzQDOi9rqkL7jHcPMG92B3fGJsthswpSGYJqxRcAHa7CbDp8kfMU7vbWxnHKpgnKj/jgTUqrA8upxHYuevf7IqJfGzElVc6NjkJcaC7CF1aOfbARXYV5IFyu1+oEHW+HcUgQ5UWpfBMhmUMBYSwjUK31ilGo/5muodfWWVw=;5:nwRuWgrCLzemaj+MXpAkfPW46V6erUo5GN57rWVhthLTz1TuKYn48DAdXa6ulGnwGLAZ8lpqmLXicc/st1n+x4Mu7LKde4yf51ezZ4EGRF2q5sFb9YEADdVo5xWXqcTgh/lmeGTOHTHwc2aEy7J1jneOf6PAO/y9+qudt/XKBMA=;7:t3ekhynV9sF8Tu6P6qlhWk1o0c+N5nROTPEaI4pXUuypzKd0//tUAMcztu2UBjiDuT+Rncw9zKApjxeMdPnyHhO/T++SbqQLokrNjvLWvHpnjUyvKorlCiE/whNpuvi6sHtwvfUpaseckF8j7MgxWWs+N4znzDmWwoihYyEICsq6+K5ng14jOkImyBNXD0lIKWDg7UuNperS/KxR3XgB7+D561iHrKbXgVZ5+diN+LvBXcRrpX2JIilg6K15ETg+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 388c67a2-7cb0-4239-878e-08d638ce6b8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1630;
x-ms-traffictypediagnostic: VI1PR04MB1630:
x-microsoft-antispam-prvs: <VI1PR04MB16301B2A8F893FD0D20BDCE399F50@VI1PR04MB1630.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1630;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1630;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(13464003)(189003)(199004)(4326008)(14454004)(106356001)(102836004)(54906003)(316002)(39060400002)(66066001)(105586002)(7696005)(2900100001)(6436002)(256004)(71200400001)(55016002)(3846002)(6116002)(93886005)(99286004)(53936002)(229853002)(76176011)(71190400001)(5660300001)(68736007)(9686003)(305945005)(33656002)(86362001)(25786009)(7736002)(478600001)(6506007)(186003)(53546011)(2906002)(5250100002)(55236004)(26005)(81166006)(97736004)(6246003)(6916009)(81156014)(74316002)(486006)(78486010)(476003)(8936002)(8676002)(7416002)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1630;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 84WQY/jsPcya2jx5FYBQ7Sc9u4NrYiB+MJ1VlNvrB+8phixGBa1tLVSfDhNNgbH9k4zA5GHePN4cngVOS0iXuHw7XWP1XEx1Ut0EqbPI0aY3VV+R5WuNQUqqcPoiimTYu+87fdpZKFnALtKbiegLC1MiPBImNzNUl0ojVkwevF8u5xoKYMD+1vT47qQmpj3ne98eB0E/v/g0BQsJhmuK/3PLe0vmQ8eIiobv8d9Oc7h1kxIsXGFkHyO0iiatC5DdfpxBbbnYHK6OpVBXdj0AnQ4XrsjLvcyZjTOHhpMhZKlGluWCJR3kZVfEituGlohlvmPlX273ssfU5o+0hkyS8+j93mtjOqFqbchpkOVcccA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388c67a2-7cb0-4239-878e-08d638ce6b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 10:00:53.6762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, October 23, 2018 3:27 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>; Tudor Ambarus
> <tudor.ambarus@microchip.com>; linux-mtd@lists.infradead.org; linux-
> spi@vger.kernel.org; marek.vasut@gmail.com; cyrille.pitchen@wedev4u.fr;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON fl=
ash
>=20
> Hi Yogesh,
>=20
> On Tue, 23 Oct 2018 09:39:25 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi,
> >
> > Did we have have any comments or remarks about this patch-series,  if n=
ot
> please apply.
>=20
> Sorry, but it was already too late for this release, and the merge window=
 just
> started, so it will have to wait at least 2 more weeks.
Ok.

>=20
> We've been lagging with SPI NOR patches for the last couple releases beca=
use I
> clearly don't have time to review those contributions, and it seems Marek=
 does
> not have time either.
>=20
> >
> > Both patches in the series been reviewed by Tudor.
>=20
> Things are improving a bit thanks to Tudor's involvement in the review pr=
ocess,
> but I'd like to remember you that you, as a regular contributor to the sp=
i-nor
> subsystem, can help us with that too. That is, help review patches coming=
 from
> others instead of only focusing on your own contributions.
>=20
Sure, I would start doing the review of other contributor patches.

--
Regards
Yogesh Gaur.

> Regards,
>=20
> Boris
