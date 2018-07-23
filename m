Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DD1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58620881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="US4xiQfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C58620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbeGWQQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:16:16 -0400
Received: from mail-db5eur01on0056.outbound.protection.outlook.com ([104.47.2.56]:35269
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388100AbeGWQQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzZNnB+BxaKpgGL/jWnuY1+KlRZQKJPNqJpgLWV+/LY=;
 b=US4xiQfQEaUTqYQzY1q9SXX53er+Mk4bQ2NIxRuozXkl599Ht3DFDeGgF8vHKEmQ8prorrJ+i/68aQuiGfi4DvugGqmq1M1noKb9hyJgHknLetzB5LkB3o9QdFb4Z4KPf0M+yeJZ8WIT3ws/RaWnBgOxS9s6o/L4X2+/B0N0Zig=
Received: from VI1PR04MB4799.eurprd04.prod.outlook.com (20.177.48.220) by
 VI1PR04MB3054.eurprd04.prod.outlook.com (10.170.228.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 15:14:31 +0000
Received: from VI1PR04MB4799.eurprd04.prod.outlook.com
 ([fe80::3880:d3b8:c118:ba5a]) by VI1PR04MB4799.eurprd04.prod.outlook.com
 ([fe80::3880:d3b8:c118:ba5a%5]) with mapi id 15.20.0973.022; Mon, 23 Jul 2018
 15:14:31 +0000
From:   Camelia Alexandra Groza <camelia.groza@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: phy: use generic clause 45 autonegotiation done
Thread-Topic: [PATCH] net: phy: use generic clause 45 autonegotiation done
Thread-Index: AQHUHpkhRppx3uTn+EqPQRQZK8PlPqSVDQWAgAFxzNCABnHsYA==
Date:   Mon, 23 Jul 2018 15:14:31 +0000
Message-ID: <VI1PR04MB4799222839701D318B3483FBF2560@VI1PR04MB4799.eurprd04.prod.outlook.com>
References: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
 <20180718143919.GA10856@lunn.ch>
 <VI1PR04MB4799F126865F4A5C115D1B16F2520@VI1PR04MB4799.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4799F126865F4A5C115D1B16F2520@VI1PR04MB4799.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=camelia.groza@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3054;6:tMd3x0As9LTcxUIUhpSZ9XkPCtHO+3fCboRN6v5CAr1MD3/GnN9x0uMr+fQ3MWG07+kal06yIgu9Knv3qLHQ//5oXw0PbVIHj4PJDW5fHPtzP+hsyeiLo9zC+QWNeI98bsxKFp77JrGJ9RmFBPNsqOrOCwqLgujNyTbvMQlJXrRnABGQ19N3vIUSVtNMBnzEgF0rvxSwMgj6dxwBe/1B/xsizC+dlOimU6DHc2AhkOJWltwDKC/CIUzraOK0c4CqhdMcsZUyQBV8+LltAXUzh1DjefMAqFYg/74fX+5fW1H2djwWa1paRJZ2bwRJAbjGMDLB5HDy9VPfVMRadXopjE2Mvz4krWM9YApZrBkinrmxISgk9Mvxkk8bfYQ2YJOWVTPqE4RYsp12SWAWZbG2sfVzrcTVxAg/ZuuYEQNtFRSBZ5zN/wpjkX+WR8EpWeH4mxcwYnZgi3nCZ+gtH/15Ww==;5:YUfQFMc5g/RPzutaUuXb4nLDz8VAm0RWDWvFDRg+VT8R6jooesHItWkiX4xzgVpHfzpl8m2g/HcVK+hhMlQ3tnIbDajNTeMd++HTDgTHT1D9EdaEVYNLUsolV8+wXXjFhnvuR2OB1KB4LDyMKi+aaY2uGazIG5AyM24MLq5WThE=;7:9tqwOfBcwuRQhj2VYim/maSYhWuVE31RDB5sDo1gg1+LPYlMgsDobvD7kNTDh2eTa4Jy3cVJ2FToYNrQ2n1Za7UD68RWbcK9q92iTEJ2UsmaWc8kT/fjPGvQJXCkzIYEDAbtw5UqkKDMqDi2TMsIL3UYgkkw4jLxAj8UOT1vw7fXtLe2CRthPZwHGx0LWVHzj9PvQ5QMsrqrCCpIWtcOxNxfzglLwwcjSPFnWMCHP68GJTWQeHh/CJYfdotVR7ea
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9d54351a-d8dd-4bf0-b80d-08d5f0aefdda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3054;
x-ms-traffictypediagnostic: VI1PR04MB3054:
x-microsoft-antispam-prvs: <VI1PR04MB305442E7A8A78773250092C4F2560@VI1PR04MB3054.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3054;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3054;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(13464003)(9686003)(6246003)(53936002)(97736004)(476003)(229853002)(2900100001)(99286004)(14454004)(66066001)(446003)(486006)(86362001)(2906002)(2501003)(5250100002)(478600001)(54906003)(110136005)(966005)(316002)(256004)(7736002)(102836004)(53546011)(6506007)(26005)(106356001)(105586002)(25786009)(6116002)(186003)(3846002)(4326008)(81156014)(81166006)(74316002)(8676002)(11346002)(76176011)(7696005)(5660300001)(6436002)(55016002)(6306002)(39060400002)(68736007)(8936002)(305945005)(33656002)(41533002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3054;H:VI1PR04MB4799.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zQzPM+mKxbTr1f380cTtnAaSWIdYoP+wqwmqI/xPrEWvW8D2IdkBArRAck/jZKZh9uD47cqoCuprVrtN3OPZLC8lmaVOK9lrf60xvqpB91cOqN1BfgEEwtFqVaCF0LVYbxpWbjsHFzE+SyqOkdqAMIkl17XRdw3ljAIxCedhugXlZ5ml0SeIt5wPEUIVh54mOPqk9weCda1LnRmnWhhs9wOKcVjl0vjjJHLdOXUfxS1zf1jA6Gh0GaCRx6OG+kho+hxoJVSgVGML1cGszQKjwfPthRkkrikwWicFKdj4uYjv2PA1XcrGym+9sEqeimd0waJg+q+FJbcMx9s/AduuG0YMUzdEhhLpuj7LKIL8L3Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d54351a-d8dd-4bf0-b80d-08d5f0aefdda
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 15:14:31.5357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: netdev-owner@vger.kernel.org [mailto:netdev-
> owner@vger.kernel.org] On Behalf Of Camelia Alexandra Groza
> Sent: Thursday, July 19, 2018 15:47
> To: Andrew Lunn <andrew@lunn.ch>
> Cc: rmk+kernel@armlinux.org.uk; f.fainelli@gmail.com;
> davem@davemloft.net; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH] net: phy: use generic clause 45 autonegotiation done
>=20
> > -----Original Message-----
> > From: Andrew Lunn [mailto:andrew@lunn.ch]
> > Sent: Wednesday, July 18, 2018 17:39
> > To: Camelia Alexandra Groza <camelia.groza@nxp.com>
> > Cc: f.fainelli@gmail.com; davem@davemloft.net; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] net: phy: use generic clause 45 autonegotiation
> > done
> >
> > On Wed, Jul 18, 2018 at 04:12:15PM +0300, Camelia Groza wrote:
> > > Only Clause 22 PHYs can use genphy_aneg_done(). Use
> > > genphy_c45_aneg_done() for PHYs that implement Clause 45 without
> the
> > > Clause 22 register set.
> > >
> > > This change follows the model of phy_restart_aneg() which
> > > differentiates between the two implementations in a similar way.
> >
> > Hi Camelia
> >
> > What about phy_config_aneg()? I would assume any sort of auto-neg
> > action needs to check for c45 without c22, before calling a genphy_
> > function. Do you think it is possible to write a
> > genphy_c45_config_aneg()? If not, we might want to return -
> EOPNOTSUPP.
>=20
> Hi Andrew,
>=20
> Adding Russell to the thread as well, since he wrote the c45 helpers.
>=20
> Sure, I'll send a v2 with an additional generic phy_config_aneg(). I'll s=
tick to
> returning -EOPNOTSUPP for c22-less PHYs for now.

Since the phy_config_aneg() call isn't synced on the net tree yet, I sent t=
he second patch independently on net-next [1]. Please review this patch sep=
arately if it's ok.

[1] https://patchwork.ozlabs.org/patch/947831/

Thank you,
Camelia
