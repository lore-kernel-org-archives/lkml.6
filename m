Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A095C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE282085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 03:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kxGYsdiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE282085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeJHKUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:20:38 -0400
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:63383
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725760AbeJHKUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 06:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdxfVMQAUKuB5HYhSzPtUisjFODzr1BNOJSzi5OOWIw=;
 b=kxGYsdiFZqLBZ3isOFyRqumnlrf2RfH26CGa/SehD2dyZ8NN2rQsvaTregy4iyoQzyBaGPLrmf8Dt8n5u//fVeKCZyj+FK5fpfxg7teSHDheS4vQy2BuFeZV6DHf5SYAWCyf8phZ3yLjYK3VQV0FAEXAQahZabCuHV4UylZR7eI=
Received: from DB6PR0401MB2232.eurprd04.prod.outlook.com (10.168.54.22) by
 DB6PR0401MB2582.eurprd04.prod.outlook.com (10.169.225.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 03:11:06 +0000
Received: from DB6PR0401MB2232.eurprd04.prod.outlook.com
 ([fe80::2988:b6e2:44fe:4311]) by DB6PR0401MB2232.eurprd04.prod.outlook.com
 ([fe80::2988:b6e2:44fe:4311%8]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 03:11:06 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Topic: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Index: AQHUV8ZPKu1tHExVGkqxDRFy68gG36UHqp4AgA0Nd0A=
Date:   Mon, 8 Oct 2018 03:11:05 +0000
Message-ID: <DB6PR0401MB2232FA836E1C9139309D43D1F8E60@DB6PR0401MB2232.eurprd04.prod.outlook.com>
References: <20180929072645.20027-1-yangbo.lu@nxp.com>
 <20180929194616.GA11532@lunn.ch>
In-Reply-To: <20180929194616.GA11532@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2582;6:SW7ExkrS5a+n4ayuRSaW18csoide/n/OHssJ7Awr+6cbjlHtJMy3cDc5H0+tZT24/ZGV8izeEq5/quMDqaV1olRWlRHo8ZQ+fk/JM4x8QD7sdLMOaAp+JBnY4ECqPt/40F1XytL9tJWp3jCY+Itgk11XyV/zROGFyxFPPjyy9odDnnCE3mXjJtE4NvqWpeq4D0wJF5yHKRF2LoN0JI6OFFo/ee6NRs0K3Jw0C1h3+5zEJm8rs8bBtPKN9MlHStyj1/DGcMPX+1WJCB0UHjN7IOVAAy/NyystQo+3EffTYtOMX+pCP1hri5CCe1HXGqfzQ6Vp16mbjEfqlhdPSYQc+eHV6fZZgqvb/WZ8HTqgZUSxGhy1Y/q9jEZ7ZC3QRE+HIXNPbkBeoMaSIAZpFqHXchcUOPq6WBNquHzpI6tgQcl6MpR52LJeGQRicJgblfZ4vHMhSsDiSrnlIaDO4G+kQw==;5:2A8KylNklUJeT+XblZTzDeY6I5J6H1ARDuEs19F6QSl+AY0HZPSWpgMxz0Eqizpu1QHwNZ2GZXAgmQj2/0U1Vjo2B3NuPmzvjwD098m7OdIJxFbpuwqn01o/2mme0dx0kQkQORiJn/zREFLr3nPzXVGkzG+ju5KJEyoDpw4lxEc=;7:b61yEGLzklAxqhkReNHGg92dmsUi1WoMuSRP1oB1KCHMQ+iXJAVae/S2Eg74ue+1OK2dcNDkGUlrARlS8VJAFP2uaiUQaaT5RWyOaDHGWyMV2Cl+6fPnbqjdSy26V0L0Rar8q+Gc2bPyg/3BX8y9y1QQHO3iQ9FqkFHbIWuoaEQZFaBCZHNTdv02W7XjKf01htNBuOczpWUKW17/l1S5Sa8/PbxBq+vbJan6i9GyeecaDvfhCKOT9RNEQrcBkrUQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a15b76bf-121e-43de-e0f0-08d62ccbafef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2582;
x-ms-traffictypediagnostic: DB6PR0401MB2582:
x-microsoft-antispam-prvs: <DB6PR0401MB25824D54B615FEFEF185BAFCF8E60@DB6PR0401MB2582.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:DB6PR0401MB2582;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2582;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39860400002)(136003)(13464003)(199004)(189003)(14454004)(305945005)(54906003)(2900100001)(74316002)(66066001)(81156014)(81166006)(110136005)(99286004)(8676002)(68736007)(7696005)(478600001)(6116002)(6506007)(3846002)(5250100002)(53546011)(7736002)(8936002)(76176011)(71190400001)(71200400001)(256004)(14444005)(6636002)(39060400002)(106356001)(316002)(5660300001)(6246003)(4326008)(86362001)(26005)(105586002)(33656002)(97736004)(102836004)(486006)(55016002)(25786009)(9686003)(53936002)(476003)(446003)(11346002)(2906002)(186003)(6436002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2582;H:DB6PR0401MB2232.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kAPdUmkkiOfFptEkViw84O9YV7q/Mcl3jauatEYQqohb6sQ62AYaLoXdepSVNfit8bSgJ1kRwHR1Ta4qvJv1JPEDfD2Efc/FRzVtzFp4OuBVXf3u1iGzYBN1vCyI1u16yOb5C1xaMioB8bU/w37X9vsBB1ZqFXWjQfOEii48EGCV2hKQNlnDf/aJrMhnoMBb7CEDHMEqqRw/eOkSVAw0JzSVngLyR4YUVnv9pLbVCp+oIiduZzMkHnRw0PvwJU0E2G55+gTKK0hNkH9KDCdby61u5oARJMq8xGEAIAEzox2ODOADJDYDcylZIOYlHBtl/LBI4PXdE8aaH92NdFUp3q9zjrF1LDuJGRwFezeOepI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b76bf-121e-43de-e0f0-08d62ccbafef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 03:11:05.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Sorry for late. Just come back from holiday.

Hi Ioana,

Could you generate an additional patch for dpaa2_eth to address Andrew's co=
mments?
There was also a warning when checked patch. FSL_DPAA2_ETH needed more desc=
ription.

WARNING: please write a paragraph that describes the config symbol fully
#66: FILE: drivers/net/ethernet/freescale/dpaa2/Kconfig:1:
+config FSL_DPAA2_ETH

Thanks a lot.

Best regards,
Yangbo Lu

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Sunday, September 30, 2018 3:46 AM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: Re: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of staging/
>=20
> > +++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> > @@ -0,0 +1,15 @@
> > +config FSL_DPAA2_ETH
> > +	tristate "Freescale DPAA2 Ethernet"
> > +	depends on FSL_MC_BUS && FSL_MC_DPIO
>=20
> Could you add in here COMPILE_TEST?
>=20
> > +	depends on NETDEVICES && ETHERNET
>=20
> With the move out of staging, i don't think these two are required.
>=20
>      Andrew
