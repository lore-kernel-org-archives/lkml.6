Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF63EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8120921917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lb1nuT+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbeLUPbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:31:19 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:56925
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbeLUPbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81h2cMsCBY2h2iuWH1X4RfhsOnpIPlqnz+l+kE9IEYI=;
 b=lb1nuT+hqz4iQXp2lEPJMe9YhgLBcLCLvNx6RBRDdeEJXZwov7+2EEh5aSOG0i8iOsMC2d6Xj5zbrv4hWIW0MpkC0muQlnDpb5iZFIgjubKyjn0hT96s696kkhRmB3qpK+s2mujaa92xhqqmUEPZmfdxiQa+EyZWSdAv/Sksr+Q=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3488.eurprd04.prod.outlook.com (52.134.4.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 21 Dec 2018 15:31:11 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9%6]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 15:31:11 +0000
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
Subject: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Thread-Topic: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Thread-Index: AQHUmUIzLDDB55qxuECeWDzF4+LHLA==
Date:   Fri, 21 Dec 2018 15:31:11 +0000
Message-ID: <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3488;6:POxdqlUplTmz8766PFxntSlH3lzRV/7LaMg6agtR4UhZGpNGS3O1wRLzbMIy+nCcGh9QADdZV/QR9J7YRBFcO2bGfVodCnQgoCvC6PO3P2RmNau0iYVt5BXPEzPEnUD8SvQeHxbPMcAvQF5zCv2uR03Ati/WmlZdgDG1tiPtpsoA2H1eVMW8zGpsljMBL8E8FvgVI+q/1Et5lUaCZfJ+FdRJopAe5zgFwimXWzDp3RKwOy5rp9OCCXALUaOaMGblHaO0UJ0V7yjA5lKXJHvFXIkiKaalyyPwQP/nVaw+nzsCg6Z7jomDlIuerI0ZYTV5oixA031/PA4fUVN5ecxAO5729zG9tTYqRQ5ss+bAR1n/KgvC/l7UtXpPK8nWdXmWDJXV4Xl/LwI9Ie11f4/LKoPpzmBDtDy+IzHWkoCQRYppNppq8l/QLYSA/RJK/poS92O7jxOgkCqiQCRrelNDcA==;5:QevsTvBuhRTmjb6N8ki/2IpjtreMbCTtbkHGcy07mshV0FOJu6Ci6arNQF2Mrjp03LYtxmdto3G4nI6wXp1i9HJeChjAnYdFLlWA/RFOi1ILovOW38Iz4SpF+yN1Q/cOms65nsoawv7faqflKKLzKniw4caeEWydi+E9cv531Gs=;7:1UXyyQVacT4cVTbl31rVZQC1jPc/4GgZPk1sUpQt5ElAqJLAcGDIwminzikLUyv2CP4DOTBfgL018h5KAYkE31RRFiHMYyPfskpT1Z0ngpBZpH4nWg+1RDc2xXZXuomGZhy3SqwqwMAABlXT/ceWbg==
x-ms-office365-filtering-correlation-id: aa78f0c2-9626-4802-af5d-08d667595635
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3488;
x-ms-traffictypediagnostic: VI1PR0402MB3488:
x-microsoft-antispam-prvs: <VI1PR0402MB3488BBE27CCB2D912D920B64E0B80@VI1PR0402MB3488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3488;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3488;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(6512007)(53936002)(2906002)(71200400001)(71190400001)(86362001)(2201001)(26005)(97736004)(256004)(102836004)(6486002)(110136005)(186003)(386003)(68736007)(99286004)(316002)(52116002)(305945005)(446003)(76176011)(36756003)(6116002)(25786009)(11346002)(66066001)(8936002)(105586002)(6436002)(106356001)(2616005)(476003)(54906003)(81166006)(81156014)(14454004)(44832011)(3846002)(6506007)(8676002)(478600001)(5660300001)(486006)(2501003)(4326008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3488;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9BYQCVVW7LV10Rc8crgdBLsW6jllZLyVVfprcFUrpTSJ4mZNfwT1eKeeM/DM7aE/Xo3SUXylanrAFjkycLtDtu4QrSxrHN3zOJ55zlW9jE4DPo9KiGW4iUfTXapajEncwztgiVsA9WO7VK3HYfpc9inTRvNsKSPK1HjZjUfsyle9qt84cA4kmsuWYCErDpOmLnCeGPRn/dOEZRyTSUGOALstdw/MjTc+unSiai6Qwrwkk0+Wcrv2ofWCNl2vwj/GKOCeQGD4rmwl03f/d/oUM8v53LC46trqadaV6K7vWIYaIrbIsQlhD5260VAeB8G8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa78f0c2-9626-4802-af5d-08d667595635
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 15:31:11.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a devicetree binding documentation for
FSL's DPAA2 console.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 Documentation/devicetree/bindings/misc/dpaa2-console.txt | 11 +++++++++++
 MAINTAINERS                                              |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/dpaa2-console.tx=
t

diff --git a/Documentation/devicetree/bindings/misc/dpaa2-console.txt b/Doc=
umentation/devicetree/bindings/misc/dpaa2-console.txt
new file mode 100644
index 0000000..f4e16b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
@@ -0,0 +1,11 @@
+DPAA2 console support
+
+Required properties:
+
+    - compatible
+        Value type: <string>
+        Definition: Must be "dpaa2-console".
+    - reg
+        Value type: <prop-encoded-array>
+        Definition: A standard property.  Specifies the region where the M=
CFBA
+                    (MC firmware base address) register can be found.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b76a80..229d4fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5969,6 +5969,7 @@ M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/misc/dpaa2-console.txt
 F:	Documentation/devicetree/bindings/soc/fsl/
 F:	drivers/soc/fsl/
 F:	include/linux/fsl/
--=20
1.9.1

