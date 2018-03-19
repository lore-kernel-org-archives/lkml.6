Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481380-2-8603171334488901462
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481379; b=fiRGE4TPnbx+zQ1SUMM5dvoJYUMnlzLBWvMNSRfaKVJ+UQ4
    IO3qycGNBJLhqL9cK5NhSBLIqvpHvjQnwTbDRVSj3H1fpAh9BNVY6tTY+IM1kg2J
    zYfwbQLxC2p1yJSb+v9viEUdw6ShgEfn3pmlQhS6czo6lb3u+NYBRrsrnXP1UKIE
    bZHV4Fj0A9bm0/Gdc4qmylKSPRspIi9xLJAatyiWr/nyivwtgqiq2zP62oiPyars
    Srl9MpzIqFa8IYeOL+4t7/oqU6Lg8V11ETZ1hwu6ERM4E2BIArbHrHzNjk7OWphI
    wv5hL+BGwcxkXTDXQoaN7e4RXQerDm79IOQKXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481379; bh=iVQwAu
    rAnUHVKWP9BtMV8Ea+5nphATuHityCjMprugk=; b=D79BsCQxZ1wml55WGy/F3v
    5L8Ul4mF+psibJvQ2sWCMwlTqXyv7zv66VBqmKToQbQwrNx1jkMziksn8e/Rksze
    Ctv26eEGOZO6Fst4XG+LaQdAQUB4L23X63qSm9vgTOe5fpLCVWkL9NJuGKZJqGvm
    uMruvMQxHR7uDWlLxWpCrQod+9wxx9KfPvqwpzgmWuW0k/TAw+E8RC1CM5Eg/BGy
    IL0ThDiSUrK2VswLCSta1SSsVrXncght33x320PcYvUqoK8Ee2faI8/3ndhXpSDt
    iuFQZK/Vr3fPz/TzMfdo7u1TrvvY00KGggQNikkrnomHbJfzMgcVW8+a+g4uGB+w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nXw5MR/q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddugeeinecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nXw5MR/q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddugeeinecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965847AbeCSRm0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:42:26 -0400
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:2671
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965845AbeCSQFs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 251/281] clk: meson: meson8b: add compatibles
 for Meson8 and Meson8m2
Thread-Topic: [PATCH AUTOSEL for 4.9 251/281] clk: meson: meson8b: add
 compatibles for Meson8 and Meson8m2
Thread-Index: AQHTv5u741F72SrtBEOKyUzVNwKAyg==
Date: Mon, 19 Mar 2018 16:02:51 +0000
Message-ID: <20180319155742.13731-251-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:12WTEgR7bt+4r62G/f5PCt5kV7Z4mhcYG3SJe1DdSTIUD8V11t5y2QSF1SHw7c7F6+2iPBFCHFF2FChvn7MqGg+TkwBhGNg/fqM52jwVb/0hAxX3gRpVAxswIBt2dTGyjNRGV6/kOAluUhPTTLV5tVHztqIshCz4KeC2iAuJsTU7eUlqxRo5MZe3anXdPAxGdeydrCJZZDHD4Kl4yQlefLV2BuRK7ZHXhm1EsQq1Tgan9xlM2EQWMQ3go7U2rRRy;20:ivfObwgcb+PbdmNwLX0TxfcO2YDNN2US2NzJsLEIUqJNQSwAgelmxmjIpCU1UOgnOoxiHe9N6X3v4YdqHuX0nJtxuY8+mB/9la8pjfOKEeKRarLuzWjoU4Qk/JpCobnx/f+27MTplnN+JvwDfvCb4gykryub1QNAwElBiQL6IqI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2059a12-2dc0-480e-1eb5-08d58db33e11
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727AD0062867FE6B5D05A1CFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(8415204561270);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dv+IHCc1od67lxVyeilxKelrGAXivTXg0sWYDrRfkL4HtRUl1YNFGLxUeEyu3eUitg/V+Hurb+EeWkliLM0oLO6uKuSwSW7w8UylZZoQbIuORzclqqSiC9obvEdAocbLy70enAGW2QFSc31Xs/WDwrFkvX2nIrOOGwkMkjvyN2bxqBQvUeRWPh1QXbYX70DQ8hLyWdryllzwv4EWXWvCbRu/bE73Osdiu3aLMV/kyIOL2ZiGQqQrwpGgeXFarhBYkqAMOjEvpBEICGT4a55CtNQSjqiZ4kKqY7FOMEZ/b2c6n0C9GoiuP/Ob/aVITuocFIy7uYA52DRkrs9T/NRnpg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2059a12-2dc0-480e-1eb5-08d58db33e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:51.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
@@ -661,7 +662,9 @@ static int meson8b_clkc_probe(struct platform_device *p=
dev)
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
2.14.1
