Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0061C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7491E20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kY/RDKk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfB0QYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:24:32 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:46760 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0QYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:24:30 -0500
X-IronPort-AV: E=Sophos;i="5.58,420,1544511600"; 
   d="scan'208";a="26973649"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Feb 2019 09:24:28 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 27 Feb 2019 09:24:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DCYhMwJcYpP1s+mG1n8Bq9kKtKO49eT9uS2+vU2zuo=;
 b=kY/RDKk3SfkePGU1cuWFAZDKomV7I1zrDXplcvf5/sNbKT0/XqVicjAuQ2BDgVq2RHVi7s3IqvJj3KBIQsjgQ1B/RwS2BLFQzixlL6om1liC2QhbPWKBIFfw3AYj8DUoT2muzGSHPijhLmAzC8brpERhOOe0LXv9PQNWGSpRL08=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1806.namprd11.prod.outlook.com (10.175.53.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Wed, 27 Feb 2019 16:24:25 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%8]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 16:24:25 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-pwm@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/7] dt-bindings: mfd: add bindings for SAM9X60 HLCD
 controller
Thread-Topic: [PATCH 3/7] dt-bindings: mfd: add bindings for SAM9X60 HLCD
 controller
Thread-Index: AQHUzrjnqtB6JnKSKUOGyiIBgoF6SA==
Date:   Wed, 27 Feb 2019 16:24:25 +0000
Message-ID: <1551284609-14594-4-git-send-email-claudiu.beznea@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0112.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::14) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 967fcb82-ed67-4437-290c-08d69cd009e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1806;
x-ms-traffictypediagnostic: MWHPR11MB1806:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1806;23:7MzyqcleuauvrXRtb00LcFIenbw7Cbdhg7dR4Nu?=
 =?iso-8859-1?Q?yRwnBSGlih73EowWQlcudGEY7esSdcuBpQQK1nJYj1Jg7TAXxw6PRjmnLc?=
 =?iso-8859-1?Q?3Zqm4aXTSlyLS16e69FByKUyX4ksD1HGH7AfaNwmTDxFSUhabZE2d2G6uc?=
 =?iso-8859-1?Q?SV71aIDYng39K3P5V9iA2wxJzBHOq5qpDQqH6Z8pi33GvjDtEiM4Apnx4S?=
 =?iso-8859-1?Q?8+FqvYFicEXxFWyW3d7eQint07swAfK7Cvhmjf/tULUPPRXrh9SVRVodu+?=
 =?iso-8859-1?Q?wG+6MWgHzEOFN9Y+ViIRgWQ3yUGhK6WyceqyrDiqhxUJmiCYByoqG4Ft6/?=
 =?iso-8859-1?Q?8nkccmOs7auGLVKXARK4ai0wNjMPWG12CFZc0yuo9LgbNoKtvtTW2dnmd9?=
 =?iso-8859-1?Q?QWNWZUJsXjfbsWtEHVqmI742ZJSEmIAJlf6u1o4FhKfJZNfvQtVKte0h4A?=
 =?iso-8859-1?Q?dhKVLWk/YfdTFRLP8sqQvGEpJKhBEBPrqvBnIwhVBB7NG3fecC2MhM6puw?=
 =?iso-8859-1?Q?YKwtt09i6Yq5twL6RCrISiTmwHgn1JjomT2cYMPGioPQ7iRfRqXk9p0gJl?=
 =?iso-8859-1?Q?IGnYb1dgoKeIS6RjZs3/YUH2aWR4oBtkF9Ms3p3LPVt2EiYGLERok7qIpz?=
 =?iso-8859-1?Q?WYC/ZIElXSSzGQYmkA/l0FTQ/MXazkt3bBcQioB11ABGY0HWmT3uqDNJQa?=
 =?iso-8859-1?Q?Yg9NCaF5WR6MlXkI4+UElTATbov0J31AYfPUKwqRi0T/vm8w+tQxD5E1QN?=
 =?iso-8859-1?Q?NZE2l7Bjlzge+VSrMZ69M8yBGjxT0VqG7+Q+ET+h3iK4CeFFoJCVZ5tyqU?=
 =?iso-8859-1?Q?qgWK6cwGHnMkELP+7/Wje2e/XMOMUx0joNMWEphzCtqhh5cWMHyy6Ilu4d?=
 =?iso-8859-1?Q?Up2XsfQsKQCL+aofxTNeSRM4WQ56d4UqQVQGQCGVK0MoUPpsEkgwk9J1q7?=
 =?iso-8859-1?Q?cOWvlUOcCypl6SepTiB6VWacbA3erJbhF1lwY5DKAUGx+FAUW7q5bnLgAK?=
 =?iso-8859-1?Q?Nq8qZoSUPO4S3C5MD6ZePBaBweUwZ4Ri0dwmnXBzFsfE5uyGBX1i3vXVPX?=
 =?iso-8859-1?Q?QwMHc4EAO1SM0Hsc3bYI5deBojtN7+JIbH73hYhgUCMNQjIhu/GNHZcbY3?=
 =?iso-8859-1?Q?8dKO4jVBM9gc4IqfsFcR5dk01Gw+nOK21MZJzIUnEVVJ+RaKnCB6i9Hm3f?=
 =?iso-8859-1?Q?6mWXbb+e2EoAAns/lXrJpy1UvWyADyT5knVkI5N/n0O1zOnezISr6+rI4g?=
 =?iso-8859-1?Q?sGohvA9pBjZOGB9YtPRhzZNiFS8+4iKgdPLmK+Qls93p+eE/cjhPFdlwmb?=
 =?iso-8859-1?Q?povLBs6xxvcBj0DVM4Vp6C+tTOzXeXWrMmvvZRyD+/g7vEVmjtiSn3PdW0?=
 =?iso-8859-1?Q?8HL/181y+hWyKeZkk9DUGM+hOkCBE?=
x-microsoft-antispam-prvs: <MWHPR11MB18060E3F277BAEDB904F50FA87740@MWHPR11MB1806.namprd11.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(11346002)(105586002)(4744005)(25786009)(6436002)(8936002)(36756003)(4326008)(66066001)(6486002)(486006)(476003)(76176011)(50226002)(52116002)(186003)(107886003)(72206003)(99286004)(478600001)(2616005)(7416002)(68736007)(110136005)(14454004)(2201001)(71190400001)(6116002)(6506007)(86362001)(446003)(71200400001)(386003)(97736004)(8676002)(3846002)(53936002)(81156014)(54906003)(81166006)(256004)(2501003)(316002)(305945005)(6512007)(7736002)(26005)(102836004)(2906002)(106356001)(5660300002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1806;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kyFuUcEY5aDc1XzHFns9hVa8dVMQwPb18xdFB7rfNGdf6k494BRh0rgtuPzHC/lvbYIQFfuyiPcjsuul2qSD3+0jr06Lh1fzL9CVK11B2djib1YbzuxYO4CJmiNDxAkVICDnwEZP02J52YcYriGi4QQNC9dKDbx7gO2veJxzz85yHqMwTXUp8otfCNnqf1i4guNxQCfOH8/KoKHO9YV5/WWjW6XmAii0Z8VB2+JbyNUWoaTReG5LfVQyo+Hy7eXo6Xptbu/nNm/TED76yerm96bIO4w7wLWBZsxeKDci/Nk68zP/e1p64LHHULTFYGp4pWjXfDW7msLBPAVUx7fkQ8jDlTVm1xvpfskttScJ+ZEnGBzVTCdbPoEIueLPYo2C38j/RYshHVuWr2AiFErQGMS9NTXvxEn9ZihsF4Sg7oU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 967fcb82-ed67-4437-290c-08d69cd009e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 16:24:21.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1806
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add new compatible string for the HLCD controller on SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Docume=
ntation/devicetree/bindings/mfd/atmel-hlcdc.txt
index 3f643ef121ff..5f8880cc757e 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
@@ -7,6 +7,7 @@ Required properties:
    "atmel,sama5d2-hlcdc"
    "atmel,sama5d3-hlcdc"
    "atmel,sama5d4-hlcdc"
+   "microchip,sam9x60-hlcdc"
  - reg: base address and size of the HLCDC device registers.
  - clock-names: the name of the 3 clocks requested by the HLCDC device.
    Should contain "periph_clk", "sys_clk" and "slow_clk".
--=20
2.7.4

