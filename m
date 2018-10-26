Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36F4C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597B82085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RLqKlds7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597B82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJ0A53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:57:29 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:62748 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeJ0A53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:57:29 -0400
X-IronPort-AV: E=Sophos;i="5.54,428,1534834800"; 
   d="scan'208";a="23129320"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Oct 2018 09:19:48 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 26 Oct 2018 09:19:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrvWMgcUoyP9+qxD9Vu6R0AOz3pn6vSTGUVCFI4kAbE=;
 b=RLqKlds7eZEnKcEHEtPAiq/RA/rffmouCZV0Smbn5fzGKYWaWjdUeBeNBeiE39VmXbIlEBidDv/q4cgEbbLFUuQsGNtTILdr9BnjyoJRyezuj8kKWzuH2ffWCGP6E2EgGS6zladpu6b9qZmXjdNTgrp6hAGo3cwQdWBkdYFSiv0=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0792.namprd11.prod.outlook.com (10.163.112.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Fri, 26 Oct 2018 16:19:45 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::d0a5:29e0:506a:76a8%7]) with mapi id 15.20.1273.021; Fri, 26 Oct 2018
 16:19:45 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/2] add PM functionality for act8945
Thread-Topic: [PATCH 0/2] add PM functionality for act8945
Thread-Index: AQHUbUe155Fv81yN7USxq+vOi6BvvA==
Date:   Fri, 26 Oct 2018 16:19:45 +0000
Message-ID: <1540570753-16370-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0095.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::48) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0792;6:PuX1UN6X0AtzLvMWc38qkTYRTio8PBVhuvXA7U1Lh8ohKE2hpKEmBrIzFuvmywH9uoCtnh0sLlSm1T9oql2oPaZwB4l+X3A75DadYPDIDvx6qmpStySk4s415+vH6utYm1/aGf6/+T77NUlo0ayvN9GbwKtC7+URCoujuFz+mQJD4p4w+dw/NiCNTGnz41wt2UFCJDbXmP6Kxhj/x9/MmmCLieRoCn58CjZT+Y1g+ih7sHYydVildT6wFvMe8khmOLij9Qqh6icS9fwSHexUvaSFkPgKOIg+rPIEoifWKCxGOTJENLcHzgMkqyPnWwLf4TVSOL0k1l6DBe41mckX3XiNUvipyj79PS76r8qifHLDjvnSZm4wlZTQILpi+1Qyt5uqz2YDnP8+V5TFy5OpuZjTbfkDu1/T7gfAya/YDq3Bw73adBYNvAgYs7aHxAJ3kHCgQ7+fYFCg0o0zBnOShg==;5:hi1ZLcVK1A2jp9ItI2Zu5/4Ur416SUJabUXPtjx1lYWEXQiSr8uR/4bvqjZxSczxu+Ql356DG7m3ETkaKR9wSTgwL0CzrJ7Zj3zlbcLWKfv2kZ6IQ9Y+HVtEOT83+/ghyyw9ZxTCYL/r9Mph5k+bo3Jcu+GKnDmvMv2UsJTfqVg=;7:cDBCSUtxeN6wpRkZr1PyBQpMjgrU1i8PEiY6EBiNrFmnaItAjGFwFmruqGWGO9VtClUS5zElOF+NdWo2a3udX89TdbhqNqRreG4qrMuvPC/DtU3bZxnOUDbNNRP93TVBG40eypovzsEHDqGhbCwFNA==
x-ms-office365-filtering-correlation-id: 7da08b1a-833d-488f-fecd-08d63b5ed77a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0792;
x-ms-traffictypediagnostic: BY2PR11MB0792:
x-microsoft-antispam-prvs: <BY2PR11MB0792F933698C34085C25799387F00@BY2PR11MB0792.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0792;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0792;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39840400004)(199004)(189003)(52116002)(256004)(2501003)(6486002)(99286004)(66066001)(3846002)(105586002)(81156014)(6116002)(71190400001)(25786009)(107886003)(8676002)(39060400002)(7736002)(305945005)(2616005)(476003)(68736007)(4326008)(5660300001)(36756003)(478600001)(2906002)(5250100002)(110136005)(54906003)(2900100001)(53936002)(14454004)(72206003)(316002)(26005)(81166006)(6512007)(386003)(6506007)(86362001)(106356001)(186003)(71200400001)(14444005)(486006)(8936002)(6436002)(102836004)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0792;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4/txIqMrE77P1HhQmq4yvuaZnwZTmS7DyBLus0+oKh1ByK++47VHcm2lry4OuY/FATYBFsMhD/VaTjymRWqWLtYRD2t2a2ZG6eCALQUE7n2I6r45ypjFegBoI+rRkYiDSmmS+yc4m2Rg+fERrxzR+BqfVtdqdXfXxbs0AL6doshZ3lVDTxozZIv8+Es2XmanxenT6N/rZvnH1J67LcDPPuBunNO/tYtrd12g3ZhhBaz29IMwdchw9XPG2iX0m+CjnrJhkrBJEPQJ6SKThwtMVFoBvNQwWfBuZPaodI/Ix5YAYLP8pV/uHymukwHv7Rskmp/cqWLl8jIBGN6EwngwFAhID9/2U6uC/QttZ+bERB4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da08b1a-833d-488f-fecd-08d63b5ed77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 16:19:45.1904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0792
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements PM functionality for act8945 and use that support
on sama5d2_xplained board.

Boris Brezillon (2):
  regulator: act8945: Implement PM functionalities
  ARM: dts: at91: sama5d2_xplained: Add proper regulator states for
    suspend-to-mem

 arch/arm/boot/dts/at91-sama5d2_xplained.dts |  33 +++++
 drivers/regulator/act8945a-regulator.c      | 195 ++++++++++++++++++++++++=
+++-
 2 files changed, 226 insertions(+), 2 deletions(-)

--=20
2.7.4

