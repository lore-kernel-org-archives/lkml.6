Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E5C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3F2577C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="d+chIf3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3F2577C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbeFYKhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:37:25 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:22832 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755094AbeFYKhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:37:22 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 25 Jun 2018 19:37:20 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id C411B72C27;
        Mon, 25 Jun 2018 19:37:20 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,270,1526310000"; 
   d="scan'208";a="283517763"
Received: from mail-os2jpn01lp0146.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.146])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 25 Jun 2018 19:37:20 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIv0VjfbeeDoTq7BDQU2QfUj7inDTNdw/FWM/UvemIQ=;
 b=d+chIf3Fm1k/Y95bBNWjUP2o7i92nV9A0C5+2aWm3qaZ19POc/SD+WoBQQVp44/2iikLtiQzFx3lKh9jCVW4ZsnUW8B6fyfflQG9rNvveY0A7i7Usm9L+HGpCk1vnPK1ayE1psMhtIOECQKUT7MNQzsYOlDbvNWnMfDEFZNA0mI=
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com (52.134.240.151) by
 OSBPR01MB2390.jpnprd01.prod.outlook.com (52.134.254.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.20; Mon, 25 Jun 2018 10:37:16 +0000
Received: from OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::447e:f47f:acec:ce03]) by OSBPR01MB2054.jpnprd01.prod.outlook.com
 ([fe80::447e:f47f:acec:ce03%4]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 10:37:16 +0000
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Carlo Caione <carlo@endlessm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v6 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Topic: [PATCH v6 2/3] arm: shmobile: Add the R9A06G032 SMP enabler
 driver
Thread-Index: AQHUDF7RL1Lhq029rkWX30yESIOF1qRws/sAgAAFCgCAAAN7kA==
Date:   Mon, 25 Jun 2018 10:37:15 +0000
Message-ID: <OSBPR01MB20545582133969454236476AD24A0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com>
 <1529915110-5867-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdVarwq26Jr=YN+zBDrHjQf-Q+u3L6oRNiSKh-hxuwOsrA@mail.gmail.com>
 <20180625094249.b6dwnraqruicmo2u@verge.net.au>
In-Reply-To: <20180625094249.b6dwnraqruicmo2u@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michel.pollet@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB2390;7:whLL8cRa9Zxcn6SakjKrez69mK9un5EEA60MGyWHWF15RkNa2HIh9WuL7z6BuqVoQ/UQsgvEWY5WZbLItE/n4k7+moI8BAMB/8bFJS4G5LJDp8iJfapht5M6iUogo2IZC7K4tPRwXIrveTypl8Ob2lfhQ/ljP5M8f2DvXyxsdyZWL4O7M8V+E1DCmqjsa6S/cq+Le6QozruygyfWVc9sPD/8Ulnvi1BbonfW7qh4pxiteYmZedp2G5apr/1CLF0X;20:Fqhk7A7sTE/9MGohK3zlEVRbbzrTB9wN6gYVmEbvJnyNMPD0gaFVuHDoE6zM4gpsLfDoCKxETD80nSdZ48joQojBS/t7kW+U+EVWoPZuXZ1WjeO7nHSLoBiAKHML4FOE65vd1fPl0l59yOduiizDSjrK8pgW8aJSxbb7YQgaeCM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 3d5c1cab-2c6c-407e-2327-08d5da879ea8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2390;
x-ms-traffictypediagnostic: OSBPR01MB2390:
x-microsoft-antispam-prvs: <OSBPR01MB2390C117D03866969A3458D8D24A0@OSBPR01MB2390.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:OSBPR01MB2390;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2390;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(51444003)(6506007)(229853002)(74316002)(53936002)(66066001)(7736002)(81166006)(81156014)(305945005)(6436002)(8936002)(476003)(9686003)(55016002)(44832011)(5660300001)(7696005)(486006)(86362001)(26005)(106356001)(186003)(53546011)(102836004)(7416002)(39060400002)(3846002)(11346002)(6116002)(76176011)(446003)(316002)(478600001)(5250100002)(97736004)(54906003)(2906002)(33656002)(2900100001)(105586002)(6246003)(4326008)(110136005)(8676002)(99286004)(14454004)(3660700001)(3280700002)(25786009)(93886005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2390;H:OSBPR01MB2054.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JPK0sGsy6rHA/g0u+qLpI7+Fb3YDwhl18qOsCsc28xcHyMlHdLptxi6ctRC/aPfMriJchtkXnuUzYxj+tNhowvIh33Yjokr1F5OPSvpd1mPCkdPzPPLmtzz69514Ymjok81+SvdnFNuZZ7Il1hV5vpaqVNoEEmtLJSEjLm3YKHxNPfm0nrGqUOytmVwAQWJJxxkImLhXkYTlwYRR7O/4Ih0D71ZoLIFOmLsvf1YREb6sSIknvpmBxJmHP6GjAQPSN5jZ4Hi+QK++V/3oOjcS8CwLcXChOPKoCq7/huUeAEWYOhjFmr3Gek0+Vb0pox9eAMBZZEcd1pENA6a9n0T+gz/9YiLQj44R/JnhIluKDIk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5c1cab-2c6c-407e-2327-08d5da879ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 10:37:15.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2390
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 June 2018 10:43, Simon wrote:
>
> On Mon, Jun 25, 2018 at 11:24:48AM +0200, Geert Uytterhoeven wrote:
> > Hi Michel,
> >
> > On Mon, Jun 25, 2018 at 10:31 AM Michel Pollet
> > <michel.pollet@bp.renesas.com> wrote:
> > > The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot
> > > time, it requires a special enable method to get it started.
> > >
> > > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  arch/arm/mach-shmobile/Makefile        |  1 +
> > >  arch/arm/mach-shmobile/smp-r9a06g032.c | 96
> > > ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 97 insertions(+)
> > >  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
> >
> > Given this doesn't depend on anything under arch/arm/mach-shmobile/,
> > perhaps this should be moved to drivers/soc/renesas/ (and renamed to
> > r9a06g032-smp.c for consistency) instead?
> >
> > Simon: what do you think?
>
> Yes, I think that would be nice.

So, do you guys want me to try to integrate this with the subsystem there, =
with
The renesas-soc bits, or should I just plonk the driver in and change the m=
akefile?

Secondary question: is it to for me to repost with these changes ASAP?

Cheers
Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
