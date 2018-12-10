Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1B1C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734E620870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GoRVToB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734E620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeLJLR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:17:26 -0500
Received: from mail-eopbgr50081.outbound.protection.outlook.com ([40.107.5.81]:40768
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbeLJLRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM5B95w7GKXj1d10rDMVbTczzkefx5FCh4M8MFTQTuY=;
 b=GoRVToB/y7zRgIzDZczVLmuiW8Svt4Smiy9mdgQvm0GdqX1FejkZ/lv3ZRCuEjN4XnQKO/R7SKD7+P9fhHEddTGq5vk3bk6qlM/uXJ3VIdi4LXKRk5BPLInyk8aUuINdbo5DdvTTcuONDnq75rP3JJ9cg+PcgtoWIbj01BdPBX0=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5342.eurprd04.prod.outlook.com (52.134.123.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 11:17:20 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 11:17:20 +0000
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
Thread-Index: AQHUiuOuxIvwGhR/Ik2nR/UOeUIxtaV32HOAgAABygA=
Date:   Mon, 10 Dec 2018 11:17:20 +0000
Message-ID: <VI1PR04MB5726164D7E52B013FF2F135B99A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1543826226-30898-4-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181210115717.01ad2e60@bbrezillon>
In-Reply-To: <20181210115717.01ad2e60@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5342;6:58RXZ8iN03CQLdK6WtIH1HWFExV048QsYySu4l2A/YJhaccj/OZoqigBb2OQ692uSt1abRv+R2k9uNZuY3KghO0BSTXMy5eQKfSEpapT97DyEfsceCz3yNzSPnDeAqUMRxnhjHxhsGr8OVa5la1SqrPdJSECAg9C+tZl/NLkNZS/vGluegQSyauqoDt0+zr6xc3jtupL6LqXp7WXtu89gvAZ2rrzsvsAVeP072MfHDz8RIGg87/eFsMJlHY6R8Hy4yLYNUFqD/v62pAYNQ2WWxOqFIjV08kRzZOes46QBvEgModz7URviCHheH+nXjN5K/I4dRlA4/4kM6P4jRrHqz/xUdaHUl4F7EQFu9w9ba5UcjFGl9+AQmPM0k3k+WHx7VqLwF4Bo52+lEBHKe+tnZeHDRPHPOQp+b+iQ5EAZA3LS2bOXtgR7HH3BGGsPoaD+jLpJjQ/jmZ/XHnG0jPdJQ==;5:RajNmsTEryi49BYkuxNTAgG1l+x2LdRtJxNQvfaoc+L7kcogEAtiEbLcj8MIH+BwfDuZanv+LUjxii3wsx5MvyNEPA1QJZkDnFJqLtLCahgM0QPJDNrv/yFqVZ7lIq/lID00lxN4J2kDmUXtS+hNA4pksMGerb4jS1iohSNzMDM=;7:81UUCBO4NQiEPdcJiHuptv7ZOp8WK2iyqLTXEu/XudBNyyem8CNsL8SvAi4rlhxW2vLMEbrNFQuBoa6KzNiWdHdqQCwswMD0vzm7CWOWds9HBdp2Y+wzUzzQtOzm6PcQAosaQQgu9TWLidUCKDKjxQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 839787aa-42de-45d2-5614-08d65e910d59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5342;
x-ms-traffictypediagnostic: VI1PR04MB5342:
x-microsoft-antispam-prvs: <VI1PR04MB53423429CA7A29E9A5D9992499A50@VI1PR04MB5342.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231472)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5342;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(13464003)(78486014)(55236004)(7696005)(256004)(53936002)(53546011)(6506007)(7416002)(99286004)(6916009)(8676002)(14454004)(76176011)(8936002)(229853002)(55016002)(9686003)(7736002)(4326008)(2906002)(39060400002)(33656002)(26005)(81156014)(186003)(6246003)(81166006)(102836004)(25786009)(54906003)(478600001)(305945005)(6116002)(5660300001)(86362001)(3846002)(68736007)(74316002)(71190400001)(71200400001)(97736004)(486006)(11346002)(446003)(105586002)(66066001)(476003)(316002)(106356001)(6436002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5342;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W1PbnmVbFI6Xy8nBkY7O26aTfGWDc1SFStgS/cK8OyadUqxfb92+CHolX53LhjOVj6ZPGE+P7ly5PobhmrA7fYl5Y6snLhVAKkpUnkOQywFugK8cvqOUayoZx/fTMX9ysSs4xH9Cd4x9m+1x50cJrS8poKZ+kIwpUtN8n3NrQ/SwMLEnNw13K0ck/4Sqlhc+eolD6otR3MM39Zg1fmqcesur6Fdo1JXb6p1gNL0KdbEPsW5qUJw3mTv01VzlQZbKtbiOT2PFvfMpliQabc1AvyTa7kbBABKToQhg8v4+hHvYLrEZect+jeGJu+RdZL5D
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839787aa-42de-45d2-5614-08d65e910d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 11:17:20.5440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Monday, December 10, 2018 4:27 PM
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
> On Mon, 3 Dec 2018 08:39:18 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > - Add opcodes for octal I/O commands
> >   * Read  : 1-1-8 and 1-8-8 protocol
> >   * Write : 1-1-8 and 1-8-8 protocol
> >   * opcodes for 4-byte address mode command
> >
> > - Entry of macros in _convert_3to4_xxx function
> >
> > - Add flag specifying flash support octal read commands.
> >
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>=20
> Looks like the SoB and Author lines do not match
>=20
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> vs Yogesh Gaur
> <yogeshnarayan.gaur@nxp.com>
>=20
> Can you find a way to make them match?
I am sending the patches with my smtp server of OutlookOffice and in that m=
y user name is "Yogesh Narayan Gaur" and in gitconfig of my Linux machine I=
 set user name as "Yogesh Gaur".
Is it mandatory to have same Author name in SoB and Author lines, if yes I =
would change the settings in gitconfig file.

>=20
> Thanks,
>=20
> Boris
