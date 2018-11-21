Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0801C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7C920989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pqcC/eHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7C920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeKUTVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:21:40 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:34765 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeKUTVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:21:39 -0500
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="23532959"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Nov 2018 01:48:02 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 21 Nov 2018 01:48:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwGp4Z8bOTW8ru372fqXuhchlOTthJkUapK2UISZEjM=;
 b=pqcC/eHJKSlZ6MBaBipBihg3NsX6nLV4gQUK6z/uUlhCPDQ5lkzYMWO19rLvZYaHPF8ggrQeu8Sl7NkFxljGEGwulgwPjBfgW5oLKSiwS0vIVd2/fIsiXC+sy4sBqhm6pIhZIk6eeUrCqv4Ex4/hz8IG04Ht5FWgxlMfNnTCi9I=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB0073.namprd11.prod.outlook.com (10.164.155.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Wed, 21 Nov 2018 08:48:00 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::f46d:c17e:bb65:5e0f]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::f46d:c17e:bb65:5e0f%3]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 08:48:00 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <Cristian.Birsan@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 2/3] dt-bindings: drm/panel: simple: add support for PDA
 91-00156-A0
Thread-Topic: [PATCH 2/3] dt-bindings: drm/panel: simple: add support for PDA
 91-00156-A0
Thread-Index: AQHUgXboIaHyf2LgIkOFXNCRmENi2g==
Date:   Wed, 21 Nov 2018 08:48:00 +0000
Message-ID: <1542789804-4584-3-git-send-email-eugen.hristev@microchip.com>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::31) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB0073;6:hLwZOzKbw+e1i9Gr8pNwTbHxXLVLWNAxwrCJqpGeMQKH4wWRStqkDzmHpWmFcVN6nF8taVz48sNcQboUUqa+EvLeiTTD3tr3PqVs0FFZXwM80n5hlkf4v5ZyxXSPHYfC4+AXmKz8c8hpDh9sh/fSBRigtWe1p2qgvlC27e0m46Zo5vDlUddKoJtUwVx94GdMpmMRRphF0SgvHG126u0WYzsfG1LA9A/CFw/naIlxbe8AV0NB3QmS7ZOMaVCKEOB3e6ESOwvjAHTnjC5+1YYGItld36fZtQ1vJqbw9lbyK2dUm8e5Mrlorh89pf6vA8epaftUjCK8HCZHXI41p684m1FtXMvBa+V542WD0imARpsIZTnN9LO+dt1BG6MX9lOmHtyn0Vx8E3XFElzWAgCRZnLdfiKfZWwk7whcEU4CCmWy7+SRUvkLRvAIp2+ulEsqWj7LyPk6bBOi/ZGHU4Fd3g==;5:Au/r7OlQEaT2dXR/7QpXxYtUEgrCL+ogtW7n3VsbjzmCqcMuluIJR2NZOqmd8qQzS5deS4agcuOwrWDIoim0KEmmUfgX67iiv6YKd8eeitjPdGXwVxJ99F5LNzj0cAJkYetDeFosPbsdRtK/oXzA10NmD4dxO3yAiHjyqdM/eDg=;7:BqQCS1GvlBoeFkRD0MsEFJ0gzGM/yBPKpD9dpBhuqbsmTBAPPWLoQuL1uHr9GCFqIFckpKSsk5mDaih9n/wSvvGDSpSTusq4pPOJiRvrkyK+pFFDuA8or8UutP2Fq3qEwGsoLJOaCR2GWRQXiX6f3g==
x-ms-office365-filtering-correlation-id: bb1fe304-facc-4f11-e5d5-08d64f8e0a5c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0073;
x-ms-traffictypediagnostic: DM5PR11MB0073:
x-microsoft-antispam-prvs: <DM5PR11MB0073DF40213A9DD72B30915FE8DA0@DM5PR11MB0073.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR11MB0073;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB0073;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(52116002)(106356001)(186003)(99286004)(5660300001)(2906002)(26005)(14454004)(7736002)(2501003)(105586002)(102836004)(386003)(6506007)(81156014)(305945005)(76176011)(8936002)(8676002)(71190400001)(71200400001)(68736007)(3846002)(256004)(66066001)(36756003)(72206003)(6116002)(2616005)(81166006)(478600001)(476003)(6512007)(2201001)(6486002)(446003)(11346002)(486006)(6436002)(107886003)(97736004)(39060400002)(4326008)(53936002)(6636002)(2900100001)(316002)(25786009)(110136005)(54906003)(86362001)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB0073;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GXsIaiPFc0ibGvM6pWOU1VQ0235N7hgDC0X7/CCWpWuqnComCwWOQ4EHQf5HqHcgQmn6F0LbH6q9eIkTqqxcXxTgBpyBSFALfEWi3oGyW4GhZQMa6YhblZiT/FgoYgM4LIoVLZdsCSEZE9BKNBejttmhvjZu1/JqjuKXTtFb3OU85Sdpxdqkf2cVDeSsvHkKWmvaje+eOEVwU0Pigy3MmbvJ90U5Q53aWcvMDjlQfEPcSpAWLiYD68uETB6AqtsfqH6JMqoVSNItosNa4/XdQAyC0Jd+StB6Rv3Mm7fz5HfiX5SwzxTL7wGZ31M5+D3o7sSbNp7YimuhF8d+2bhdEf7ZubAASAlSpAdPAbJ2OJI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1fe304-facc-4f11-e5d5-08d64f8e0a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 08:48:00.0266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0073
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
AC320005-5).
Adding Device Tree bindings for this panel.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 .../devicetree/bindings/display/panel/pda,91-00156-a0.txt          | 7 +++=
++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-=
00156-a0.txt

diff --git a/Documentation/devicetree/bindings/display/panel/pda,91-00156-a=
0.txt b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
new file mode 100644
index 0000000..52f0da9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
@@ -0,0 +1,7 @@
+PDA 91-00156-A0 5.0" WVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "pda,91-00156-a0"
+
+This binding is compatible with the simple-panel binding, which is specifi=
ed
+in simple-panel.txt in this directory.
--=20
2.7.4

