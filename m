Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B2BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C295A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tgahOrUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C295A2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJDTAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:00:23 -0400
Received: from mail-he1eur01on0067.outbound.protection.outlook.com ([104.47.0.67]:49664
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727375AbeJDTAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfo4UImGAt9f7M3MIt/yp+L9CP/UDfMl4DWzECy675c=;
 b=tgahOrUIPOqaBx1hQF8i0baHVbldLlo6mI1I9qAh7yshM3Hu3IiSnlekoM5T610/T08+bsCoha+nw5rpGY2FPHmz0GGH80iOQ0z/Y9a4vklGSwlfZYyMo2dmU07Nt9ZnjM3BjMBY+Qe8SOtF6nuY/MEg35A1BSqOaxWgO7RS17o=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB3054.eurprd04.prod.outlook.com (10.170.228.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Thu, 4 Oct 2018 12:07:17 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::644c:d070:c632:d3eb%4]) with mapi id 15.20.1185.027; Thu, 4 Oct 2018
 12:07:17 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
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
Subject: RE: [PATCH 1/4] spi: add support for octal I/O data transfer
Thread-Topic: [PATCH 1/4] spi: add support for octal I/O data transfer
Thread-Index: AQHUW79Pt2f0aPifqU6iS7lMxP3ev6UOyxkAgAAA6rCAAANBgIAAAEdggAAr0DA=
Date:   Thu, 4 Oct 2018 12:07:17 +0000
Message-ID: <VI1PR04MB10384B74E6E27435313CC73099EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20181004110446.5e1bb255@bbrezillon>
        <VI1PR04MB10380FD9CE99E34BA27E55B699EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181004111941.0da33ec0@bbrezillon>
 <VI1PR04MB1038E23CBFE9CFD5C2ECCD3299EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB1038E23CBFE9CFD5C2ECCD3299EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3054;6:Ga2t9k5SwN7b6Ojd3FT4tf+rCYtO1tNqKgWcmVQEDi2tT6YEkLoS5OYq3JqZF5iM9kZ3+n3Sq6JtyvnBCdzEBhxIAMoRMG5e4QH4aa+GMFgkuu0z3NMPnK0lr28Va+AuNlwHqrX55GkGJm+gHi9Y7XzRclAjlChyc/P+0PqLMznvVSDIyuCsU6EYpSBrR3kh4j2uu5cCeAI0HvwMqN6OXGGTO/LAyMUYjGYZKrwc6Liy9qgQqPeSb28bnP+QRi813zoVGdquEBFbS+2MS4phH/0QoEGziXBqK5IXdhEqhi0KqMs/J41mUUKus5OUdWrkbL0hCYKS8yVlev9TEu+2utE91nreHKZZcdJ15LSkTurL95jhCzQPCDpBGr6aP5B/kBgIvz1A6r8EsLw9ejFMjtsf4CTjEQUr4908dtpuNVNxejcDdQ6y0+1gKEQis5CWYTDgtLkUoPll8iAOgcdpcQ==;5:EpXzT74ROe6Tn8Hlyu5DgtI3z5BlxnHpvmF14fnMaOeegRRnXfQ9yiXx+0tko/dt1gS/e000jYpNmzp2paP++Me1ji7glgVal28XXB80/GnHyc1d3chFyN8sEjKiO6yTvV7ac1uzspRTRGUDVb+jCDM5j/jaWkUTuPduhYpivao=;7:XT4FUz+AH+cpsb4z/tr6DyNyamFno0zqooOum1aFso0hOyaMViCwnWNOOOBwBEXSmReYi1XRIEG7AjOp2MB0TSAp7v2vkAy9C1eJbEdsJ/vqDx++Yh6MfDXNdIeLkYNnc2+Iz6eduGCWecZ0DnKrqON4tzCT1EPpWxuLuBaEFT96ipK9cyqj0PWhJmqEv38tiehDt+VBUjatdvwFM7fM9oHNF9qMd/3C7gBbuTVLGxd30vD+dGQ5azwJaaxBYQnu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0fd0d771-c0cf-4bb7-e5ee-08d629f1ee21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3054;
x-ms-traffictypediagnostic: VI1PR04MB3054:
x-microsoft-antispam-prvs: <VI1PR04MB3054BE17B74D5EA9C01B8F4599EA0@VI1PR04MB3054.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(85827821059158)(31051911155226)(9452136761055)(180628864354917)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991048);SRVR:VI1PR04MB3054;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3054;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(136003)(346002)(13464003)(189003)(199004)(486006)(476003)(446003)(11346002)(478600001)(102836004)(14454004)(26005)(186003)(55236004)(5660300001)(6916009)(5250100002)(68736007)(6506007)(2906002)(25786009)(4326008)(6246003)(53546011)(97736004)(39060400002)(2900100001)(71200400001)(8676002)(76176011)(305945005)(33656002)(7736002)(81166006)(71190400001)(53936002)(99286004)(105586002)(106356001)(8936002)(575784001)(86362001)(7696005)(81156014)(93156006)(66066001)(55016002)(9686003)(6116002)(3846002)(14444005)(256004)(2940100002)(54906003)(6436002)(229853002)(7416002)(74316002)(316002)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3054;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8tpz1uhgq2MjPCg0MQepyH2WGg5ErGIW61ER0bgz+TTelewbJKAW+RfSYcrNW8Ldhv2UWnJdEpAnjptoANBJt9DY70gQ4SGH1CM6dfh33ODPNOD5wcAoNcdC3bGo1y5Hl6rMCN1Nk15cUsk+5WgV6/vdB6QLgx4YpYgm3WLprVC5XGJHYaXl66yJQTCfjm8CNQ807VbYlBLf+yXL3IxyiHSe+jh8ABCHXlbLQUtVe4Xk1THYUkBjzNRNno0f/t3fDxb4+vhndsRUIyv27/CTFKHrKTreaeuJ8Z9QnmLMXdXsmS34FnSbEhO+e2JaKuOmtmxevqaLnLSVUnz8D1qJ+DIVeKCjDA8HnFlzEkjW1yA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd0d771-c0cf-4bb7-e5ee-08d629f1ee21
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 12:07:17.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Yogesh Narayan Gaur
> Sent: Thursday, October 4, 2018 2:56 PM
> To: 'Boris Brezillon' <boris.brezillon@bootlin.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com=
;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 1/4] spi: add support for octal I/O data transfer
>=20
> Hi Boris,
>=20
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Thursday, October 4, 2018 2:50 PM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> > vigneshr@ti.com; linux-spi@vger.kernel.org;
> > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; linux-arm- kernel@lists.infradead.org;
> > computersforpeace@gmail.com; frieder.schrempf@exceet.de;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/4] spi: add support for octal I/O data transfer
> >
> > On Thu, 4 Oct 2018 09:14:36 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >
> > > Hi Boris,
> > >
> > > > -----Original Message-----
> > > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > > Sent: Thursday, October 4, 2018 2:35 PM
> > > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com;
> > > > vigneshr@ti.com; linux-spi@vger.kernel.org;
> > > > devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> > > > shawnguo@kernel.org; linux-arm- kernel@lists.infradead.org;
> > > > computersforpeace@gmail.com; frieder.schrempf@exceet.de;
> > > > linux-kernel@vger.kernel.org Subject: Re: [PATCH 1/4] spi: add
> > > > support for octal I/O data transfer
> > > >
> > > > Hi Yogesh,
> > > >
[...]
> > > > > +#define	SPI_RX_OCTAL
> > > > > 0x2000			/* receive with 8 wires
> > > > */
> > > > >  	int			irq;
> > > > >  	void			*controller_state;
> > > > >  	void			*controller_data;
> > > >
> > > > You're still not updating spi-mem.c to check those flags and
> > > > SPI_MEM_MAX_BUSWIDTH is not updated to match the new limit (8
> > > > instead of 4).
> > > >
> > > Yes and its strange that my octal mode communication is working fine
> > > without adding support in spi-mem.c and that's why this has been
> > > missed from me.
> >
> > Are you based on top of spi-next?
>=20
> Ok, that might be the reason. I have rebased few days back.
> Would rebase with current tip and add support in spi-mem interface too.

I have rebased spi-next and currently on top but still my octal command sup=
port is working fine without any issue with current shared patch series, pe=
rformed data sanity.

=3D>  git log  --pretty=3Doneline -3
	496c415717b8bb7d37181127fcfad0ba450eb10d mtd: spi-nor: fsl-quadspi: Don't =
let -EINVAL on the bus
	2336d3a7b125683c9e8b25d6efa6064310d19dbe mtd: devices: m25p80: Make sure W=
RITE_EN is issued before each write
	e55841874471282d32eec595997afce43a5f55c0 mtd: spi-nor: Support controllers=
 with limited TX FIFO size

GIT Repo - 	git://git.infradead.org/linux-mtd.git
Branch -	remotes/origin/spi-nor/next

Also, I am not able to find string SPI_MEM_MAX_BUSWIDTH in current source c=
ode, can you share the GIT details where these changes are pushed.
--
Regards
Yogesh Gaur.
