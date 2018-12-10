Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F09BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7D82084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Spcc40ww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7D82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeLJL3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:29:30 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:44920
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbeLJL3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI/VXdWs2PwYnxRX20Rp+oA7PutSl0TqMLdcpN1jTRc=;
 b=Spcc40wwUmI5UwMsYegnMovN7iOItv+eQJ//NWHLF2y1LBWoZwi34VV37F15MzC3TrhBId+eY2PSx/vYFXGZ/WdqQXhDWMteGZVUE8McCHhTdKt06JIF8RUEllzkMMrsG/+5c5Meo076wVY2ZxEqQ0mvttL/rwZP/XLguryJr50=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4077.eurprd04.prod.outlook.com (10.171.183.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 11:28:45 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 11:28:45 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
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
Subject: RE: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Topic: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Thread-Index: AQHUiuOuxIvwGhR/Ik2nR/UOeUIxtaV32HOAgAABygCAAAaMgIAAAEBQ
Date:   Mon, 10 Dec 2018 11:28:45 +0000
Message-ID: <VI1PR04MB5726B7F4D7B25843144EA04299A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181210115717.01ad2e60@bbrezillon>
        <VI1PR04MB5726164D7E52B013FF2F135B99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181210122707.3416095c@bbrezillon>
In-Reply-To: <20181210122707.3416095c@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4077;6:MuJZKbwm/wE9VBMkWCIuO7dMgvbaIiQ+fLVm5TuF5HxdvwGjFBi0u8ryPaTW1Kqda9aB1rsQ8djC51Jne6moe1Prtjg6YMYO7XHmNXwQLOkYuq4THu0NhwQ/9obpbuyRZiDiqz9FIgvUtSf6p5i+pE89IBeIkp92FqQhzGk9iuDRpwtK8iMNaLNZeWP+we4lvMZ+omL64ThKzYxuBxKGSUyRoj3hwNG9bmITEQIYlnrTceTtEMTsz1Db9ddPML2PGOm449ZUO9f/gGK7Ir7mtDde0FjNdAFb/qPAEXcEY+xSsDeKPswKkuymAwfGffoyEejIFDiYkgmwmU7COcaLq+y3M5ioc/lzdXsx3CTZ500njv47hXpYAOqsMGaaG1zZaD7lqIZw6tD47063RRli6noCs4j1Kz3f3V9F63WsimVKc+ktFoII8kcA1wJB1UKOAJxkNtLIxFabjFjM659L3Q==;5:GkwgJUyC3XhG7iZX0ghEpF35Ng6ScV4gOrqbAsSmAPnWUoOYf5cOH7H2buLCW12zQjnSiYF96uFRkM/umYFSsMtaekE9LaGIixQZ4iIwsTofsMkrdBVppQXjFhrdzzh0eSOz6PotrUJRNKG0H6GLP7WcnpFIAXXRHz2WXIxy/6E=;7:iZpXvcIi7Oc0KF4hxex9J7jxrQmAhfUMvN+vF0GdmG4B83K0lijbppGc5ETVHB4EtlFy29QDTXqVSJAwICA6ruwEkej2nGTVj9/WsSoPM+7WKNbM0m8ugeRrTyS68ySQJtGLb6ZkzDmXLf9TXPKYEA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 78f9d430-972b-420e-676e-08d65e92a5ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4077;
x-ms-traffictypediagnostic: VI1PR04MB4077:
x-microsoft-antispam-prvs: <VI1PR04MB40777FCE77EB650BD77EDDC499A50@VI1PR04MB4077.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4077;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4077;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(13464003)(189003)(199004)(54906003)(97736004)(99286004)(7416002)(8936002)(305945005)(106356001)(229853002)(105586002)(7736002)(6436002)(66066001)(486006)(81166006)(71190400001)(6916009)(25786009)(74316002)(33656002)(71200400001)(102836004)(8676002)(55236004)(11346002)(476003)(93886005)(53936002)(6116002)(6506007)(316002)(9686003)(3846002)(53546011)(26005)(78486014)(55016002)(446003)(5660300001)(2906002)(186003)(68736007)(39060400002)(81156014)(478600001)(4326008)(86362001)(14454004)(256004)(76176011)(7696005)(6246003)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4077;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3Myx6eSB0W7DICxg79sOZsKKMZgaT6CkHivHDoD3Qu03akErPwRr3vXl5Z1nKiHfjSjVo8LYt91hOHICyJNIaWRMrIFehg3jBzi0/S0KLV5LfANcAZoBZyJ7OxRgfYInQAoXnzdgPvWZV1YsCHquV6J6klH/IvZ+cz7hoKcVqFJqFDRpKb1XHcSIthzbpRhnvYWhi6slSKY/z9dJBKDsyQvGuzubeyP9akRYpsLlfyyQQBoiEWmB48aHaT4je8xeQRBmlvbqgg7KSS0zBNTi0O1+lwQOiYZV1Lrz2NmuJuT1+m3jFvaawAcakxGb2QTj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f9d430-972b-420e-676e-08d65e92a5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 11:28:45.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 10, 2018 4:57 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; broonie@kernel.org;
> marek.vasut@gmail.com; vigneshr@ti.com; linux-spi@vger.kernel.org;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal Read/Writ=
e
> commands
>=20
> On Mon, 10 Dec 2018 11:17:20 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Boris,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Monday, December 10, 2018 4:27 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: linux-mtd@lists.infradead.org; broonie@kernel.org;
> > > marek.vasut@gmail.com; vigneshr@ti.com; linux-spi@vger.kernel.org;
> > > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > > shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> > > computersforpeace@gmail.com; frieder.schrempf@exceet.de; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v5 3/7] mtd: spi-nor: add opcodes for octal
> > > Read/Write commands
> > >
> > > On Mon, 3 Dec 2018 08:39:18 +0000
> > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> > >
> > > > - Add opcodes for octal I/O commands
> > > >   * Read  : 1-1-8 and 1-8-8 protocol
> > > >   * Write : 1-1-8 and 1-8-8 protocol
> > > >   * opcodes for 4-byte address mode command
> > > >
> > > > - Entry of macros in _convert_3to4_xxx function
> > > >
> > > > - Add flag specifying flash support octal read commands.
> > > >
> > > > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > >
> > > Looks like the SoB and Author lines do not match
> > >
> > > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> vs Yogesh Gaur
> > > <yogeshnarayan.gaur@nxp.com>
> > >
> > > Can you find a way to make them match?
> > I am sending the patches with my smtp server of OutlookOffice and in th=
at my
> user name is "Yogesh Narayan Gaur" and in gitconfig of my Linux machine I=
 set
> user name as "Yogesh Gaur".
> > Is it mandatory to have same Author name in SoB and Author lines, if ye=
s I
> would change the settings in gitconfig file.
>=20
> We have scripts that check that the author/committer has its SoB, dependi=
ng on
> how strict the check is, it might complaint that SoB an author/committer =
do not
> match, so yes, please change gitconfig to make them match.
>=20
Ok, sure. In all other future patches would modify my Author name.

> Thanks,
>=20
> Boris
