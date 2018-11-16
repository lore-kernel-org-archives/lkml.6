Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0151FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954D02086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QcnJd+e0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954D02086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbeKQEJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:09:07 -0500
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:27157
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbeKQEJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhwqffqxAY9JFhcCzVDPW3gfHV2azoitA6awbpXmjVI=;
 b=QcnJd+e0RqaNgEVEvShTQsbHlmfIqqf8WpMSBp2KTtf5nbthZPjj7nCo3JsyEaSLFsa6QFVildVzST8zSU1Kav9XzaBxOBi49aA1fSMoADMHsYZ3NLtI6Ctg3MJcKvpWTC3tKfgBcKCAif+zV9TDLln6Yf8tjpFbzK6RPxU4NoI=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3712.eurprd04.prod.outlook.com (52.134.15.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Fri, 16 Nov 2018 17:55:40 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 17:55:40 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 0/4] bus: fsl-mc: enhance Management Complex userspace
 support
Thread-Topic: [PATCH v2 0/4] bus: fsl-mc: enhance Management Complex userspace
 support
Thread-Index: AQHUfdWWg4rMkySBYEWyKDkUzGwZ0A==
Date:   Fri, 16 Nov 2018 17:55:40 +0000
Message-ID: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::49) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3712;6:2/eFKRipWnGmZ1hhgoRiUM7qgXYpMmKTvDpDlAuqC29RzNh+37A7fQzVIyIaTAkPlkvEPlq7YqPDN17xhLwV1LBe3KUbNgH1IALO2rdrAtSc8I+aqWREEr3Z9N2P6U9iK1hEMH07FA7XjaWgroxCFqB3WIyblXMJY6i7BT5wXvOkG/6fWOzx4pD0MwSJnRjyEhNh4OxQ+y0SK4GOFZ2P9MjqJY9L7V1TG22pwlcdPbZ4nXExy5JStnEEPv4+SIgNu09d48b2Xi2U5WLyh0cjF4UIQBxABN2Di9bJD9YUZ5PP84puO4SKFZeJ9bF/hiXKjr44v+PTw+NuBWlXwyTNAVEBjStloDBehZO3TomJfldFuJj6qqQZi05SoFPZ4Q61ZYkOx7q4ZV5EqnGlZ/jgBwKYuQk0F79pNScc+zhSbBUWIvHEyPJo/FMtgpy+DB1kWfLXZ0gVDloBkjXGa5t0GQ==;5:ReYS7hiLS4BM45Jw+Ca+S8ZBpHK5uT/0DNn8Kl1skmsGz4Co1GFG5MeteB4ewAjTsw3IsUw7H4MseL/fuvZetw+0UD4xNvsfV5HpQBsCkwOpSSkbXdxL0SGOR7bXK8nEULfgxZGcKDDDTmllDkyYBV3b2aFFHUEklF8reMNGjzE=;7:gmRNCQcmVSXRV7f9b/djYkYCJCpqtupqFNJxk0QrE5DgX/svg/6cUpEwuI1Sjtfn6pkaTA3R4gPAhyUFA+z0DC8Ft4SV6XPYuyupQ7Uu2vF06r0+l538/y/RoOFl1trD5QfHl1b/DiFIIRZPUjA53w==
x-ms-office365-filtering-correlation-id: a12ae63f-4fc1-47ef-309e-08d64becb86f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3712;
x-ms-traffictypediagnostic: VI1PR0402MB3712:
x-microsoft-antispam-prvs: <VI1PR0402MB3712A96EADBD9D1B898EEE12E0DD0@VI1PR0402MB3712.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3712;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3712;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(966005)(6486002)(6306002)(71190400001)(71200400001)(25786009)(14454004)(6436002)(44832011)(6512007)(36756003)(2616005)(105586002)(99286004)(2906002)(68736007)(106356001)(478600001)(256004)(86362001)(3846002)(54906003)(2501003)(8936002)(316002)(102836004)(26005)(5660300001)(52116002)(6116002)(386003)(97736004)(110136005)(6506007)(305945005)(8676002)(6636002)(7736002)(81166006)(4326008)(81156014)(53936002)(2900100001)(476003)(486006)(186003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3712;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5Zg4jyNsKmgxpD7aiC9DlrpO7t3KHWjGr3kdUXTW8gWshE8SxEksUj/ZUxPgenlRu1eQzzAkZXp3plPxqlaS/8nGw/25LhoB5ih2Xbfpm3tOrl3rHItlLNK+A/n6IUx3DN654UiTuZ5FSAZPqPxsIbh/kU+/M2JsdYxbUiPvsTLEg+3mwqAO62+ChdYGAiRh1NxlDcfoCoOrXbNOFNEa7ASPSTpUDkwuI7Na/JiiwLFnirWnVy56LPTBhICVgPWPdv71jhMRPGhnqm3GGWbFDO6aaK7z34S0E7bMPWLxW1/XpK4CsI/zKbIWRWbzfJY01oedWhLHV3o/f5RNWMsWgh89M88BGkbPPknxJPvQ7zc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12ae63f-4fc1-47ef-309e-08d64becb86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 17:55:40.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds userspace support in the fsl-mc bus along with a rescan
attribute to the root DPRC container.  Also, the patches here depend on one
other patch submitted but not yet accepted:
 - https://lkml.org/lkml/2018/11/15/776

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

Changes in v2:
   - use root dprc MC portal by default
   - create the uapi misc device from the root dprc probe function
   - remove the rescan dev_attr on the remove path

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
 drivers/bus/fsl-mc/dprc-driver.c          |  54 ++++++++-
 drivers/bus/fsl-mc/fsl-mc-bus.c           |  41 +++++++
 drivers/bus/fsl-mc/fsl-mc-private.h       |  43 +++++++
 drivers/bus/fsl-mc/fsl-mc-uapi.c          | 179 ++++++++++++++++++++++++++=
++++
 include/linux/fsl/mc.h                    |   8 +-
 include/uapi/linux/fsl_mc.h               |  34 ++++++
 11 files changed, 381 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c
 create mode 100644 include/uapi/linux/fsl_mc.h

--=20
1.9.1

