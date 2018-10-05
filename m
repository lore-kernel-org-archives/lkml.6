Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81770C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F2C2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BkjeDxOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F2C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeJEXq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:46:28 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com ([104.47.0.57]:37568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbeJEXq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVLrzyGSuk7r9IIfrtC/6GWFFAw6qyCupY2h5/SpUzA=;
 b=BkjeDxOBjs8I5EiHizU3t5KPw3ViYkY9wcPBTDwsw9MCg/qWOYFtjf+QrY/7IdsBhfttKq6X+OBQISnZQmqOlh6GYj8wmiumasJTX/xhUgDImRJuaC+3/5pNFsmSyfL6K17dormWkNo8OnGnnXIZeHrMrC6qpy+mXOkWhtZGN0E=
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com (10.165.45.135) by
 AM4PR0401MB1940.eurprd04.prod.outlook.com (10.166.130.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Fri, 5 Oct 2018 16:46:52 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72%7]) with mapi id 15.20.1207.018; Fri, 5 Oct 2018
 16:46:52 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/4] bus: fsl-mc: enhance Management Complex userspace support
Thread-Topic: [PATCH 0/4] bus: fsl-mc: enhance Management Complex userspace
 support
Thread-Index: AQHUXMsEn8A3tyXxUU6NrEPvZxfk4g==
Date:   Fri, 5 Oct 2018 16:46:52 +0000
Message-ID: <cover.1538757337.git.ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0049.eurprd09.prod.outlook.com
 (2603:10a6:802:28::17) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:51::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1940;6:qdX36+p2c5DyDyWry46VI5S3laaK9U4UPMZ426bLAmSubNkDlWLliLXlOqGwnj76A8My+Q1urVkyMItSHUC8wUqOwQEzJ7mxbKo0ognbhzwvFVDa9roRIeYxLmadAQQrvXWpApStwI+blkdg7EKzU5aX/r2qWIhHSgSsrK3fS76XFSNZEcEIBXIVJ1aF3QzemmSLYQHWQgeiWMUqp8bVv+vSy2EFfR7/i9FutMChpjwxo18bPCIkHU8R/fsaAmJ9KmEXhHtAjlyMHwuMhUfIifTadVwxBNiBr2EW2pY2NN8YRPxkR6c4M05aoUaZe4tnmu2fkWsLmmykTWRmGFBCOkRD/ffYV13bFqN9McL3pygxifapve4OV5jYBxHVRxvyXh0Fj5gnFGSWxVf9Ss8tFjYHw0BGt7mJcPZOqq5xOUEGjTKfullgNlSOLuhHXHu666QW/V28NIqVAKNxEdni7Q==;5:rWFee2WPK/kohZkr7kHNTOgrfZoWZIAakr/xzrBkS98yCUi3HAf5ZqxuHmhh6ll3EZ8aHrLgG8UnbeayHgrkI19WGQzQ9rkSxFEFuAoO9x8eIhxERw7jIDZxPK1T9eTSYE6Jo1DZuqUoFtY9GFvljaCWnakGuSHC33iempfjfFc=;7:0BxdDsxJa5IUGfTViLdBFAldktTLc+ouX1SlBMQ5zE8xJOEp932aePWY4bBGayDfNqUlbMb2u/VuGvIwbn5G8JAQgiPIJMiXxuklre6naRLz4p77yxLKDP3tFVJekh6+7eIG23u2ZBCzXi6GQGr8MAyON3wWqD0MjC3e1UoJvUzGrOYeJv90PHYWfyGX633SRG5tU3bfr4+dd/wKNnNWyYpfWNkCGO4ai8VQWsMJc6VgEoyIIPMwTpzBTGmhEyet
x-ms-office365-filtering-correlation-id: 4f04066a-7ca6-4c09-31a8-08d62ae226ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1940;
x-ms-traffictypediagnostic: AM4PR0401MB1940:
x-microsoft-antispam-prvs: <AM4PR0401MB1940C13D690FD95DC85BBFE2E0EB0@AM4PR0401MB1940.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM4PR0401MB1940;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1940;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(97736004)(316002)(6512007)(6306002)(68736007)(53936002)(81166006)(86362001)(8676002)(186003)(476003)(486006)(2616005)(44832011)(102836004)(5250100002)(8936002)(6436002)(81156014)(26005)(7736002)(305945005)(256004)(6486002)(2900100001)(2501003)(105586002)(966005)(106356001)(52116002)(6506007)(2906002)(99286004)(71200400001)(71190400001)(54906003)(110136005)(14454004)(6116002)(3846002)(386003)(4326008)(25786009)(5660300001)(66066001)(6636002)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1940;H:AM4PR0401MB2354.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DVA3lFk5yPq19DxuPLVk2wyK8T3KolSRZqSQZbVsKMCP33WcnbocRYew1RkpWKqzJUB7keugOAPL0fOyURT/pDlca4RIRbpgDMZMVLgBYCfeQaHQUtdyRViLx0zBmDHdiGa2k239hW1NpUbWm1zysaJVIiMmfIqR3a2DgAtyIW2NNU2d3WHMKYs7WT3rGZvmqidWCtLVk7bRBKtHT0Sad6GgwrLyNdAlKTLW64ejto8gzA4MTHucYIJxpTB7jpxe2qUHt1qIcSa5Gqca+DR7HKTuSEwtIck26lJA+pMPDI/uS1qPCYx3vXVOSFv/GlnNjRQFRTgPg3IOtG/dBk1ipaWyEMsLRC/+mEeUA9t4ZuU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f04066a-7ca6-4c09-31a8-08d62ae226ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 16:46:52.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1940
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds userspace support in the fsl-mc bus along with a rescan
attribute to the root DPRC container.  Also, the patches here depend on 2 o=
ther
patches submitted but not yet accepted:
 - https://lkml.org/lkml/2018/10/2/593
 - https://lkml.org/lkml/2018/10/1/747

An earlier discussion on this functionality can be found here:
https://lkml.org/lkml/2018/3/23/941

The FSL_MC_SEND_MC_COMMAND ioctl acts as a direct passthrough to the Manage=
ment
Complex (or MC) by passing fixed-length command/response pairs. Keeping in =
mind
that the MC manages DPAA2 hardware resources and provides and object-based
abstraction for sofware drivers, the proposed ioctl interface enables users=
pace
tools to do the following:
 - create and destroy DPAA2 objects
 - manage the DPRC container that objects live in (by moving objects betwee=
n
   containers)
 - establish connections between different objects as needed

The ioctl interface is intended for dynamic usecases where DPAA2 objects ne=
ed
to be created on demand or destroyed so that the underlying hardware resour=
ces
can be further repurposed. In static usecases, depending on the requirement=
s, a
firmware configuration file can be used to describe the needed DPAA2 object=
s,
their attributes or any link between them.

Some examples of device drivers that probe on said DPAA2 objects are listed
below:
 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
drivers/soc/fsl/dpio
 - https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/=
drivers/net/ethernet/freescale/dpaa2
 - https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.gi=
t/tree/drivers/crypto/caam/

Having a low-level ioctl interface where the command is passed through to t=
he
MC without any intervention from the fsl-mc bus reduces the complexity adde=
d in
the kernel while also making the command structure, in turn the ioctl, very
stable.

Ioana Ciornei (4):
  bus: fsl-mc: move fsl_mc_command struct in a uapi header
  bus: fsl-mc: add fsl-mc userspace support
  bus: fsl-mc: add root dprc rescan attribute
  bus: fsl-mc: add bus rescan attribute

 Documentation/ABI/stable/sysfs-bus-fsl-mc |  19 ++++
 Documentation/ioctl/ioctl-number.txt      |   1 +
 MAINTAINERS                               |   2 +
 drivers/bus/fsl-mc/Kconfig                |   7 ++
 drivers/bus/fsl-mc/Makefile               |   3 +
 drivers/bus/fsl-mc/dprc-driver.c          |  38 ++++++-
 drivers/bus/fsl-mc/fsl-mc-bus.c           |  53 +++++++++
 drivers/bus/fsl-mc/fsl-mc-private.h       |  43 ++++++++
 drivers/bus/fsl-mc/fsl-mc-uapi.c          | 175 ++++++++++++++++++++++++++=
++++
 include/linux/fsl/mc.h                    |   8 +-
 include/uapi/linux/fsl_mc.h               |  34 ++++++
 11 files changed, 374 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c
 create mode 100644 include/uapi/linux/fsl_mc.h

--=20
1.9.1

