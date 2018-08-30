Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F219FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D80D20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="QfoS6x3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D80D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeH3W4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:56:18 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:43645 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727337AbeH3W4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:56:17 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 31 Aug 2018 03:52:42 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 67A8B4C406;
        Fri, 31 Aug 2018 03:52:42 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,307,1531753200"; 
   d="scan'208";a="291097010"
Received: from mail-os2jpn01lp0148.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.148])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2018 03:52:42 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y8DSADi5NKyKlJ8D/uT6CaR5T1qDr1YST60clVwqfg=;
 b=QfoS6x3RalRr7M2/2NuFuii6G/rA0lB20W9uTZxT9NeRLeq6h9obI8QEQg4lcasUqdr2qYpdXgxAsCQRvqctEOIne7BQWZAgtkniD5G1a7L/16FA1P5vHlCUa4e1Lt5G3abtSQhoe6IBUgUmT9bubGhWi34vsVbNyNQlj5jD8kQ=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) by
 TY1PR01MB0304.jpnprd01.prod.outlook.com (10.161.136.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 30 Aug 2018 18:52:38 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::c6c:fe7d:de0a:c681]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::c6c:fe7d:de0a:c681%4]) with mapi id 15.20.1080.019; Thu, 30 Aug 2018
 18:52:37 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] serial: sh-sci: Fix earlycon on Renesas ARM platforms
Thread-Topic: [PATCH 0/2] serial: sh-sci: Fix earlycon on Renesas ARM
 platforms
Thread-Index: AQHUQGCOSg91s/0E00GS4Ir2iFfTsKTYoyuQ
Date:   Thu, 30 Aug 2018 18:52:37 +0000
Message-ID: <TY1PR01MB1562E58C07A892AC7CF7438B8A080@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180830125404.21192-1-geert+renesas@glider.be>
In-Reply-To: <20180830125404.21192-1-geert+renesas@glider.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0304;20:SD4JUpu5SD+OnQCFCyKQnKN/7TYJ3xfGOKMAParK/h1s9mPu1ge2nA4BbrB4irjbtL+N012+kxgb1c6jmUratHmNZAOQqv/920azWMLoSv9DwmDnYRQm32aSky/pNpui0LUwZe7vBO5o4AVdwF893oEEKctUsLt8ebGVhKxrf4g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 058a0014-e70d-4d98-0e0c-08d60ea9c198
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0304;
x-ms-traffictypediagnostic: TY1PR01MB0304:
x-microsoft-antispam-prvs: <TY1PR01MB030401F59E3E5EFAA1A8E00B8A080@TY1PR01MB0304.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:TY1PR01MB0304;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0304;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(486006)(68736007)(102836004)(6506007)(97736004)(14454004)(55016002)(53936002)(9686003)(2900100001)(86362001)(54906003)(26005)(186003)(476003)(316002)(110136005)(446003)(11346002)(99286004)(2906002)(72206003)(478600001)(5250100002)(5660300001)(7736002)(7696005)(81156014)(105586002)(3846002)(74316002)(6116002)(256004)(8676002)(66066001)(4326008)(106356001)(76176011)(229853002)(25786009)(6436002)(8936002)(33656002)(305945005)(6246003)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0304;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: klzr7WCLq9bN4ZEzIF2WSd0tSzcw12uDzcGxzlbZBZcqvY4IzUwYUiTLOmDUrR9AfHaPNJt4532bfZq//iOhulAUEyFgPh160rVLa3bZwHXhSd9H28LXab3Ng1Jn2OPsiQPlXE8svNHLt71N7w75uxMo8bAI34LT55b0cosz4g3dRzQFZKKiktRs/g5wG05zRkNluIoR5PszGCXooHxLFbsB2Cf8ZOAIKQTRLbh4P5NlVvGqJDX5RzVQ2qkoBedqqak8amGBYqIygQ+3yxJDeSPuqJPF5Vt7yJX6QyRgi1eyrfBvs6kgcMqr6+P8kflB08K+JONX3NuIvJfVH6wx1Es+SUQlEMl9oxntHr7dYx0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058a0014-e70d-4d98-0e0c-08d60ea9c198
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 18:52:37.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thursday, August 30, 2018, Geert Uytterhoeven wrote:
> Earlycon for RZ/A2 (which is a new platform) will be fixed later in a
> separate patch.

I assume something like this:
(which works for me)


diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ab3f6e91853d..426241da2e44 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3414,6 +3414,12 @@ static int __init scif_early_console_setup(struct ea=
rlycon_device *device,
 {
        return early_console_setup(device, PORT_SCIF);
 }
+static int __init rzscifa_early_console_setup(struct earlycon_device *devi=
ce,
+                                         const char *opt)
+{
+       port_cfg.regtype =3D SCIx_RZ_SCIFA_REGTYPE;
+       return early_console_setup(device, PORT_SCIF);
+}
 static int __init scifa_early_console_setup(struct earlycon_device *device=
,
                                          const char *opt)
 {
@@ -3432,6 +3438,7 @@ static int __init hscif_early_console_setup(struct ea=
rlycon_device *device,
=20
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
+OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_se=
tup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);


Chris

