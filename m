Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241622-2-9943060794301127415
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241621; b=oDqN3S3SkgOXMaIGVrculFO/7eUoFcE+9X+sBo7pFm1HC34vmd
    lRIgaQOgF2301T8vgsV4CwGvAXrI4jdv/fZq4U4+q+Y3lgGgGvAxM3kDUm6R3UPR
    sRX9t2Ir/3MPeG+5KYVc6aPlqH5Eb7RhA3KjhKWrpHzfT8oU+dz/TgvIVaFm71rI
    po9/TZIiFOeDs/ROYuLwxHaV4zDKhVnx4hzZ3eA7ex6mE1RKwpofef+mmJmWZdU3
    qrBS9sP7qaWP2fP1adccw5bolBnaTrEvSMH4oMLj5VEeZ1FO0VlVQO8rVs7h9Okm
    n9FnzWplrl6rScqefr8xSM7WzEGS2dPusDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241621; bh=ry+OsOt2X1
    Q/StxqLWDfGIrr0JtLHcmRaaOOZyJr2co=; b=kKP3q7wUTELNl1ucdKjo8duu3b
    Ephx7aUAACguhe7Rkyx66ygCYnL/F4XLfpgqZQh+qabSm5eHVsncI4vFs5n6+iV4
    Mi1I/UWBCIxuoDuRvuu3yOEBSb6ctCPNrGL5o4RWa2V3SS8wrdDfUtzRwFfoTy90
    MbmqPwZSM/XFmFI3dQFYKSgBy7HIE4Dt2d9iB/GJGL4BFUstJIPySQ4qibPU1fDN
    JSJcmoiKtuNwrIR5Yc75RRdSwpsgSfT0IFn0EoGxVWu+uGq3fU6ByG0GYaXWjZTK
    gE2ZLfBg6/MItDgIdTCyq+CMjaFcXfts7KChVzwtKezArg20NwIhzMkvgwlQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HshoYKlf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HshoYKlf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH0J5zNzUOpH5JwdNRcsl7Sinc8SoSaxPcgL4oaZ44erupyUOteZri7Au38CNPd2MUYZYJPVmjepiP8engqF++/1BZd7B51EM7mo21ckyLnZLjVxEgYI
    rcX4t3sDJgBqAz+NxVDNvINX64yWFRGSlOIiJtDYx5L2fqqY5FfNjAhNfoVAo+pu3cXnJF7R7zDLIxTpJ+n9xhprY6x7sqZKZXVrm/4A/4fXjEwmwACuNRx6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mK_AVkanAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
    a=yMhMjlubAAAA:8 a=EqdPLkY1AAAA:8 a=dU-uMnHTiOHK1eXWDvgA:9
    a=cVG-l9syHwPs017d:21 a=HVMS3MqiRTArqfm4:21 a=wPNLvfGTeEIA:10
    a=3gWm3jAn84ENXaBijsEo:22 a=AjGcO6oz07-iQ99wixmX:22 a=IawgGOuG5U0WyFbmm1f5:22
    a=dfeKg4RqpEhWThG6bP4-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756047AbeDICkI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:40:08 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755546AbeDIA1Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 037/293] clk: meson: meson8b: add compatibles
 for Meson8 and Meson8m2
Thread-Topic: [PATCH AUTOSEL for 4.9 037/293] clk: meson: meson8b: add
 compatibles for Meson8 and Meson8m2
Thread-Index: AQHTz5j1hf/qtLDxK0CbJFB6jdaGtA==
Date: Mon, 9 Apr 2018 00:23:18 +0000
Message-ID: <20180409002239.163177-37-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:sBoEtJVfhxvv+gYUGpzzqJDtjvSR0IVhz6q1gpl2exG/WX04pWTl7A5isZyA5B+HtFmmnRGhCgZxxpYkalNpfjQiIwvGtcrDwG1K6c5EGXF1eLKm3VBZKtnivBcQ0bgfJ0hsjmfRpqWzWyrwl8j8tySKIIzjOY3oUkYzsG6/nwpCQsR5+eNTbyh8FkdhPINTJ8lImAdXJXAGo052kfCScPTXaEIEYoOU1SV4LpHjFLbb65LVtCmQ0i6KhpS/0R3T;20:/u9w9HjioC5IDQaE6q8yzhfs6NAPge00cpvIuOx2nAe6taIEecNeJrZtR51/STidX0wJJ2kQVXX130uM4UwdF++K1EwH51Z69VRSS03QQB+XT1m0vzTIb2xBUdhsAkmEI1y14XXt9zmZzu0/Qinq66Wrq83LvLLBMuIyjYoNaUg=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 175adb8e-8832-441e-52f9-08d59db0a8b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB103107457A248A78E4D5F7CBFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: FH+bllJcmlyY+5VbYc4nAADrVv6VVIWPPbdR953fvnArqX4ABioMvXVCSfxwcjiXufuGbGBKT4aPRfAcUde3KeXzEi44M4D/eyDKvhqjQacaXMp13M367ML99Rggi+tGZW7FvKXaxyNTtBK9m9q7oqJcTSGtVEGxjLgKzve18CQvkV+1zHE3qJgTftDMN1veNtmkpFUI+T+WoBRAZbN/uiXhbCFFvlFTiUw0op5nbCNU3d/e82/yyPGIAbj41U4MIdX7BbkND6Qgw5Qa+omECuZpFmHeFTqDjJ61SpCsMCK8BehLHBMIlHWkjU5EmEuF5rkh7ilzOr5fyDHsb9P7xPNaEZhO49nxnvKsfl309QDWchEavvVRZh9NU5IBPJp+1B/qTeNXm3M3q9qsGdanHPcHYCdxyJ3TtPnMH3SSIFs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175adb8e-8832-441e-52f9-08d59db0a8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:18.8467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 855f06a1009faabb0c6a3e9b49d115496d325856 ]

The clock controller on Meson8, Meson8b and Meson8m2 is very similar
based on the code from the Amlogic GPL kernel sources. Add separate
compatibles for each SoC to make sure that we can easily implement
all the small differences for each SoC later on.

In general the Meson8 and Meson8m2 seem to be almost identical as they
even share the same mach-meson8 directory in Amlogic's GPL kernel
sources.
The main clocks on Meson8, Meson8b and Meson8m2 are very similar,
because they are all using the same PLL values, 90% of the clock gates
are the same (the actual diffstat of the mach-meson8/clock.c and
mach-meson8b/clock.c files is around 30 to 40 lines, when excluding
all commented out code).
The difference between the Meson8 and Meson8b clock gates seem to be:
- Meson8 has AIU_PCLK, HDMI_RX, VCLK2_ENCT, VCLK2_ENCL, UART3,
  CSI_DIG_CLKIN gates which don't seem to be available on Meson8b
- the gate on Meson8 for bit 7 seems to be named "_1200XXX" instead
  of "PERIPHS_TOP" (on Meson8b)
- Meson8b has a SANA gate which doesn't seem to exist on Meson8 (or
  on Meson8 the same bit is used by the UART3 gate in Amlogic's GPL
  kernel sources)
None of these gates is added for now, since it's unclear whether these
definitions are actually correct (the VCLK2_ENCT gate for example is
defined, but only used in some commented block).

The main difference between all three SoCs seem to be the video (VPU)
clocks. Apart from different supported clock rates (according to vpu.c
in mach-meson8 and mach-meson8b from Amlogic's GPL kernel sources) the
most notable difference is that Meson8m2 has a GP_PLL clock and a mux
(probably the same as on the Meson GX SoCs) to support glitch-free
(clock rate) switching.
None of these VPU clocks are not supported by our mainline meson8b
clock driver yet though.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../devicetree/bindings/clock/amlogic,meson8b-clkc.txt        | 11 +++++++=
----
 drivers/clk/meson/Kconfig                                     |  6 +++---
 drivers/clk/meson/meson8b.c                                   |  5 ++++-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.t=
xt b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
index 2b7b3fa588d7..606da38c0959 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
@@ -1,11 +1,14 @@
-* Amlogic Meson8b Clock and Reset Unit
+* Amlogic Meson8, Meson8b and Meson8m2 Clock and Reset Unit
=20
-The Amlogic Meson8b clock controller generates and supplies clock to vario=
us
-controllers within the SoC.
+The Amlogic Meson8 / Meson8b / Meson8m2 clock controller generates and
+supplies clock to various controllers within the SoC.
=20
 Required Properties:
=20
-- compatible: should be "amlogic,meson8b-clkc"
+- compatible: must be one of:
+	- "amlogic,meson8-clkc" for Meson8 (S802) SoCs
+	- "amlogic,meson8b-clkc" for Meson8 (S805) SoCs
+	- "amlogic,meson8m2-clkc" for Meson8m2 (S812) SoCs
 - reg: it must be composed by two tuples:
 	0) physical base address of the xtal register and length of memory
 	   mapped region.
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 2f29ee1a4d00..5588f75a8414 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -7,9 +7,9 @@ config COMMON_CLK_MESON8B
 	bool
 	depends on COMMON_CLK_AMLOGIC
 	help
-	  Support for the clock controller on AmLogic S805 devices, aka
-	  meson8b. Say Y if you want peripherals and CPU frequency scaling to
-	  work.
+	  Support for the clock controller on AmLogic S802 (Meson8),
+	  S805 (Meson8b) and S812 (Meson8m2) devices. Say Y if you
+	  want peripherals and CPU frequency scaling to work.
=20
 config COMMON_CLK_GXBB
 	bool
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 3f1be46cbb33..70567958b86a 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1,5 +1,6 @@
 /*
- * AmLogic S805 / Meson8b Clock Controller Driver
+ * AmLogic S802 (Meson8) / S805 (Meson8b) / S812 (Meson8m2) Clock Controll=
er
+ * Driver
  *
  * Copyright (c) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
@@ -661,7 +662,9 @@ iounmap:
 }
=20
 static const struct of_device_id meson8b_clkc_match_table[] =3D {
+	{ .compatible =3D "amlogic,meson8-clkc" },
 	{ .compatible =3D "amlogic,meson8b-clkc" },
+	{ .compatible =3D "amlogic,meson8m2-clkc" },
 	{ }
 };
=20
--=20
2.15.1
