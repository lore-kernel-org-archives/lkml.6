Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C640AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8374A21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OjN314kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeLUPbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:31:12 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:56925
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbeLUPbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQE+rSTsEOYYnmOCwQTZLf5Q/t9buhZ76I5qKgn+U2g=;
 b=OjN314kz7Nq+V6jp/pxXcgRvuOkqgVXp4LFW9djFz0reIwBNPVeH32fpyl4VxgptIOqE/jJCnF6BCvVHiFkB6uUzoW3BVZDFdtlzDUPKoHdPM9dE+PpuYqbb1E1CKbpoV24lOdm8Lat8A9T0dXWoX/O7BHOLQhIbXcxyowkQ9vw=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3488.eurprd04.prod.outlook.com (52.134.4.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 21 Dec 2018 15:31:07 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9%6]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 15:31:07 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] soc: fsl: add DPAA2 log console support
Thread-Topic: [PATCH 0/3] soc: fsl: add DPAA2 log console support
Thread-Index: AQHUmUIx/NHo/hQT3EWASVsQKa2/4w==
Date:   Fri, 21 Dec 2018 15:31:07 +0000
Message-ID: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0082.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::26) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3488;6:exXNo1jUb6h0Ahmt/gMQFM+kuaf/fyLnzZHrKyuDEF72PjNwGJ0BZfewRnLbpOG7VCf6XAeAuL9wzUkD9eUmA21q/ALOmIlZhwjpq9QmE8eL1PwNu6AzmF7es42TuK8ATokP2PZFJ9THv8sgCS03pq1qs92aaU1jmQHQRrvUh+uU8/P+VqeAVupIJMG7WK+m6CHFLEFJPgsMRTiWTldfuxvCBLfBzKugS6NXwijpX/b9PX0ss8maDGrHa4WNvJzXSrMt6zcUnWFSH1WHKY8s5NrouCc1eJpAizXY13OfDW9krGHye/hq/Nhnrljn1nxx9Fy3obMdgkmSgI1bdRl2mBkLBAMSSlBmGczTdPkdzmqcEZ66LP9HMyi/Y6uWeNrMVogbNCX6zgxkX6R7X8yPDi7lWw1P2/W95qmBKB96as7ZOweLiGxsHfxpBypgJCZV3IAy6taFZ+C9q4cV7/vfGQ==;5:snKljzK4uf5x8U/8wuRqHOzF2oJEF37W+HA7lN80VQ4o2E6ODzSlau1COJ1SN/vR60N3/MfKhIcspmo9XanizZ2iDM3RJUL8bcqn8bR8PPgwlVgFtyFwuNHa5aupZdqTrAt9d5vJBYhfNNZtT2P4Ex3kHTXPypvOoa8fWoZeV48=;7:P/rq0/y3B1ugzstXJrnFWKD3CWcbyz8rq7Sj+jVVG+nKq7nfhlkUlI1XSDzcNWCZFENBD295ON3RTYVZps8c7/0/J7zOSfyXtxCi540SM6CKzIgYcy5Ly5OrgYFYuhnvHC89hhzxeMAlSvYFpk+qJQ==
x-ms-office365-filtering-correlation-id: 4f0dd865-dae6-4c5b-67c0-08d6675953a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3488;
x-ms-traffictypediagnostic: VI1PR0402MB3488:
x-microsoft-antispam-prvs: <VI1PR0402MB34882E8CD2E3B864C04BA0F2E0B80@VI1PR0402MB3488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3488;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3488;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(6512007)(53936002)(2906002)(71200400001)(71190400001)(86362001)(2201001)(26005)(97736004)(256004)(102836004)(6486002)(110136005)(186003)(386003)(68736007)(99286004)(316002)(52116002)(305945005)(36756003)(6116002)(25786009)(66066001)(8936002)(105586002)(6436002)(106356001)(2616005)(476003)(54906003)(81166006)(81156014)(14454004)(44832011)(3846002)(6506007)(8676002)(478600001)(5660300001)(486006)(2501003)(4326008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3488;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 62/vy68TMDgGUtePKBggwXcrXI1in37BL8i+2Cj9glc7YucQKd2mdFZfbUIQsfjgUi7KpvK50vfGPL4gRj2bfuDnBi+e3ods9peciqXc396PO6JzGjAml3+TdCgfUw5Nebz+rA9DG9sQrJCMQmH1vjGNaO2pE+VTzj+Wvr7QyRmu0rS61kIlPkhScc3Ab2VWCL3UmbVnqtwp86evy1Js57Tl7sgwIjn0aKlIuAEV4RSXR8ZY4ySLUz3QKT2zLTX2UWGabVuQOHbr8Ql/4z4CD5fgpsBMc+PeOwjpPq6etVW4MzJNQxL3PSjC50iaoRJP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0dd865-dae6-4c5b-67c0-08d6675953a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 15:31:07.5612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds support for exporting DPAA2 firmware console
logs to userspace.

The first two patches add the needed device tree node and its documentation
while the third one adds the actual platform driver.

Ioana Ciornei (3):
  arm64: dts: add dpaa2-console node for DPAA2 platforms
  Documentation: DT: Add entry for DPAA2 console
  soc: fsl: add DPAA2 console support

 .../devicetree/bindings/misc/dpaa2-console.txt     |  11 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   5 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   5 +
 drivers/soc/fsl/Kconfig                            |  10 +
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/dpaa2-console.c                    | 306 +++++++++++++++++=
++++
 7 files changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/dpaa2-console.tx=
t
 create mode 100644 drivers/soc/fsl/dpaa2-console.c

--=20
1.9.1

