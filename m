Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C343DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EB52083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OCpy1fOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EB52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeIGFPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:22 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729261AbeIGFPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVTHh4bKwe0mFrMFnYXebTHMvYG2FyptkEtlIiS0VXw=;
 b=OCpy1fOWSDlmkcCDnvBhdDnU5cJAQBZ3kO8uYp7IjPHnTA5NEcmNkpnL5MV5x/tLAF7lMgz9SdX9yhRWmkycjOajAB7bMqEYhDuJXHB/4K+cuUobTttfB6YDm1m4qiurCEGrzeNLpUMuhmpKM9jHLE93suYX2AoqIgBDPJHD9a4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 49/88] omapfb: rename omap2 module to omap2fb.ko
Thread-Topic: [PATCH AUTOSEL 4.18 49/88] omapfb: rename omap2 module to
 omap2fb.ko
Thread-Index: AQHURkLQZhwRaaFQ5EOvyjNMl7xWsA==
Date:   Fri, 7 Sep 2018 00:36:28 +0000
Message-ID: <20180907003547.57567-49-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:4Ko34xsj1nXv8CUAkem+8GTCm1MxEWQaMn9Pw3phoLZRKdvK9PfZoKnsO099bK/x10dsx2UNrCpWsiQEW7Og+ggOJAKTySG2pa2s7QMP+1NTOL1uqswheTzkKhdX6E3dSfJu8arMkM5Puey/dQs44r0bTXuWehz5na+KMArAkvD3FpNSm9gsehQBSipYuEyY2fV7CSoO5ryEHHXb5kRaJMDqw8uIAdV8xgkbSaL7zn9oSU5Va1oSBdT/DKPgqncvl9ZMEMfofJfsYGOY3lWCaW5qI0c3meuRvL4rah/bBAvGTR1NU426dFJlheqPgVvU8QmgwOLFGKfq3kV6/ojwvZgp2+p6u6+z/3ci506yMjT64h37gqf9ENsEHYX3rSLT2jrkrfiXjSa8yUx4JuwGXSmMdrIBsPF0vnvKEAdD6ewJUOGzfdQFg+KD3mboJm3HnHs+CzmfHNtvrUIPotKVkg==;5:t24sPJ6wZG2zT5GIgTVGHY2NkSWnwAkG+T7aBwSdQMB48ILmA2KKNr8q8Z3ZBPQ3LBcXnenIvYLabylbtPfOawmB9zeTkSx+YSh2AcZpMPeeIKTCSVo3o157AOWtQh4QL9NbJXX5p+BLXFzM3Io08N1tSwounzXrhUAkh0py3B8=;7:5StPTAjFxEGU7TE3kLHdThlps1gOgOh5fMustQsQ88zBr3XPx4YqBAM6/R3PvJN2sQ9YYWmZoU3FkxVIVMwDwFfrTVeVS7rBPWRGE4VgzEUEiNO9tTZXy2LjvWlxBJRDWhpzMoff3haB+dQK4t0cyJMm3wacZznqOZhEkm6JyS+rgy/qQf0nT1RYUGuWiH88MIX3fL7iigGDxTyONIpJqGw39CnFM9uvJxfaL/JF7xFtJotLI1c8v7dVLSlwzsQ0
x-ms-office365-filtering-correlation-id: 3c7dcb81-68a4-46ac-9c7a-08d6145a024b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773C20A8CC90E82E1C2AFA3FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(6666003)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H2PX1P3OtdXm7Mr0jz4oBRlAVGcib8iYsdEsTaqWh9vMREOqfdvyDVIdT9Vh0/ayaeIvOJrt147baxn8S23PrfYXdrFdHXpO58PRWHlXXeUO7bck5KHy7M60mk6X+y/jpbLCQ/BwvCqxdEFVYf7P5xN3JOSsouBv/HcyaUyzAo+744ADLLpWxdokXMXlX87A0VN0+XhJf6nIV0EZTeVzrRSm60nvcn3D6ZSDkkvRSBQ6u4fdhxw/52bOT30aBeO9Eypx1KCoG1Fn/TDj2c8evCoftklCd9zg/0aPCOGu6ufQ405oEW1CNVZOiYji5qJRID8lQ6DXeEti5Gw8sIb2bBZA+18SinsVYsDTHszpp/g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7dcb81-68a4-46ac-9c7a-08d6145a024b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:28.6839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4bcd8c90ac0f27d3d76fcfc50582ff3685059de9 ]

In a kernel configuration with both CONFIG_FB_OMAP=3Dm and CONFIG_FB_OMAP2=
=3Dm,
Kbuild fails to point out that we have two modules with the same name (omap=
fb.ko),
but instead fails with a cryptic error message like:

ERROR: "omapfb_register_panel" [drivers/video/fbdev/omap/lcd_osk.ko] undefi=
ned!

This can now happen when building a randconfig kernel with CONFIG_ARCH_OMAP=
1,
as the omap1 fbdev driver depends on that, whiel the omap2 fbdev driver can
now be built anywhere with CONFIG_COMPILE_TEST.

The solution is to rename one of the two modules, so for consistency with
the directory naming I decided to rename the omap2 version to omap2fb.ko.

Fixes: 7378f1149884 ("media: omap2: omapfb: allow building it with COMPILE_=
TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/omap2/omapfb/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/Makefile b/drivers/video/fbde=
v/omap2/omapfb/Makefile
index 602edfed09df..f54c3f56b641 100644
--- a/drivers/video/fbdev/omap2/omapfb/Makefile
+++ b/drivers/video/fbdev/omap2/omapfb/Makefile
@@ -2,5 +2,5 @@
 obj-$(CONFIG_OMAP2_VRFB) +=3D vrfb.o
 obj-y +=3D dss/
 obj-y +=3D displays/
-obj-$(CONFIG_FB_OMAP2) +=3D omapfb.o
-omapfb-y :=3D omapfb-main.o omapfb-sysfs.o omapfb-ioctl.o
+obj-$(CONFIG_FB_OMAP2) +=3D omap2fb.o
+omap2fb-y :=3D omapfb-main.o omapfb-sysfs.o omapfb-ioctl.o
--=20
2.17.1
