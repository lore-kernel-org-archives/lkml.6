Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493697-2-3154089965699195384
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493696; b=RGBgh3PStLET8WqsZ62R5J34fuW2fPH4jkNE4Ba+OEagQOb
    3gY2X8Herqmcxx+Bs726PJxIrHGLXRLtBmHlBSgvyHmhjmeLObMn1QSrjaydwEX1
    zKrKXE46RzQigD2BhA8gz8y/tabU4sUF4PDJnMZvnPabxDmjwNfUYzumBQQIHf0c
    nyibdyUYPxA3LMh0Bju2rQGlPL+s6FxicrDPqxVauGiTG8p1jBuQy3inZ2ulIt5w
    g2xnYgZzSdfDh+UPHVvQmiJxkfc8JfeSNyODGv4KrYzFvl/S4oy61L/z1phs2cD3
    OicBPWxb1o84YROhjx0IFGgrc5gWiEmNt+4VDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493696; bh=bPI3LR
    iEuqxDjHRKOeQPZSFOeZwvfaXIlclWHPKcvfk=; b=Ym3IMBnDanuBVVEAszxrhL
    0KUBwiX/vzoaD8vjMdAuP7VBcsQsGYIQrqG++Qop+hbUK+LSQxA6PrjXFKsBc7zm
    Z9B+9xQoZyQbkGjwF0f4alOOH7HV3vBQKRzXcReP01vM/+qIEwCoZiRKpIFD9MtK
    SPNOKcWWKjopErHbdsTqF2VehImDfFRYPBcjB5SNS1mCaMHueuEHqtvw6NPi5SVe
    gjopi4gTpaX2P5HgKJsjQHcBbXWG8j67A3ttBhQehfyd51ibtEEJ+h8Qh0bau09V
    0Qt4ls//55eZzEGxMi+TVnMrw5ZYG/f0AtJvLpyF9dU6gSdkzFhE9et0b9w20arw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B1X9jCVZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedttdenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B1X9jCVZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedttdenucevlhhushhtvghrufhiiigvpedule;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbeCSVHo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:07:44 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:15805
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965365AbeCSQCD (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 139/281] ACPI: EC: Fix debugfs_create_*()
 usage
Thread-Topic: [PATCH AUTOSEL for 4.9 139/281] ACPI: EC: Fix debugfs_create_*()
 usage
Thread-Index: AQHTv5ts729y/lKaFEK1czSLcpJEeg==
Date: Mon, 19 Mar 2018 16:00:37 +0000
Message-ID: <20180319155742.13731-139-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:5sx6n9xtv/7EmHFgYJmzOv3I17m8Da+59eRZppDvzJS29N1pEsHib2sOh7rSAj52SMpZ5pKIR4tD3dKnIAUqVEijcRVgNE+Q+TZdRl2HQLDHoPmdOeQJYQI1xjIR5DMk9u1s3Ie5+LccSxBLCNBs7dxgGefeVpqWxjj1lkeP/aRABRgAQSHmE+nBf/iXoUSteDcgGMnS6kZPWgQi2jl/QDdvG4XagkWxaVzdRmMcWT+5fTGhJlTxfIc3qFwrxFTw;20:XBuyOVR+p5qO9Gl8TzEKtHW4DIKclBSaXUT59cjrULvSZrlJwsvLjLLwDGKh3NNC9ZTTb1y0D4Obusv71bRr8t9e/NHBUViavhikj9gkbA1vyrJ45cT/W+b0OH7mqOQXvPVAbrWQ2REliG0QZHSfjtSv/aTp0/eRtGwiEwDcgdw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84ec8052-83dd-40ad-427d-08d58db2bb45
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09198E722137A771D52F7E33FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: v83nD+UVa7d3KzLNIdvQw1lFD+uOh/whe+iHn2ax/k68L4fbflfLFMsz18iqycTSPvyTrZaI+if2WT5h/44eO7wPqzJ5e1FPpDXBdy0SVfqCX6ayCo3/tZj07569FSq1a6Xpno6lXgVoxuFqrbv4rZDgCR78yaUfERjIQJg2RjEBR1/eom40fnIaBBsCMk3FS5HNks7mbbYk1/jD0VOh3eRfS1O7rhksubUC6tZ4pkJG9yoUdlMaIUPoxqaHMXFQ8IxMptRvyS1h1PMtT2uGzNL2d2RqTGQwwnGQEPVZHi+chNGD0nDSKJgoM92LeZgvInElRkO+8qTzimSzKbDtKw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ec8052-83dd-40ad-427d-08d58db2bb45
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:37.7737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3522f867c13b63cf62acdf1b8ca5664c549a716a ]

acpi_ec.gpe is "unsigned long", hence treating it as "u32" would expose
the wrong half on big-endian 64-bit systems.  Fix this by changing its
type to "u32" and removing the cast, as all other code already uses u32
or sometimes even only u8.

Fixes: 1195a098168fcacf (ACPI: Provide /sys/kernel/debug/ec/...)
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/acpi/ec.c       | 2 +-
 drivers/acpi/ec_sys.c   | 2 +-
 drivers/acpi/internal.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c3bcb7f5986e..307b3e28f34c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1518,7 +1518,7 @@ static int acpi_ec_setup(struct acpi_ec *ec, bool han=
dle_events)
 	}
=20
 	acpi_handle_info(ec->handle,
-			 "GPE=3D0x%lx, EC_CMD/EC_SC=3D0x%lx, EC_DATA=3D0x%lx\n",
+			 "GPE=3D0x%x, EC_CMD/EC_SC=3D0x%lx, EC_DATA=3D0x%lx\n",
 			 ec->gpe, ec->command_addr, ec->data_addr);
 	return ret;
 }
diff --git a/drivers/acpi/ec_sys.c b/drivers/acpi/ec_sys.c
index 6c7dd7af789e..dd70d6c2bca0 100644
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -128,7 +128,7 @@ static int acpi_ec_add_debugfs(struct acpi_ec *ec, unsi=
gned int ec_device_count)
 		return -ENOMEM;
 	}
=20
-	if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
+	if (!debugfs_create_x32("gpe", 0444, dev_dir, &first_ec->gpe))
 		goto error;
 	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
 				 &first_ec->global_lock))
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 08b3ca0ead69..b012e94b7d9f 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -158,7 +158,7 @@ static inline void acpi_early_processor_osc(void) {}
    -----------------------------------------------------------------------=
--- */
 struct acpi_ec {
 	acpi_handle handle;
-	unsigned long gpe;
+	u32 gpe;
 	unsigned long command_addr;
 	unsigned long data_addr;
 	bool global_lock;
--=20
2.14.1
