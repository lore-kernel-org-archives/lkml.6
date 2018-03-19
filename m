Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497179-5-8868919037158352448
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
    t=1521497179; b=eig/BRRmMVKCQlE3FOI1wb5va3CjRNkP92A1XYMwMXAnFzO
    UJ7qpUQfotN0oyIfHDMI/c47h68kyXlt0GXlZ5caOIh3z9GSgQieq2x8mRAc3Z1i
    J7oxo4QnkIJl62LhJeepgv4yw3mYxyyC77FVD9EsfRZ3jpcRo7ZxUjE9laTUgxwF
    QDwLCNLku797Mq2ZxtXa+2jIKcZwjHEnYwzpomFB6hTu3COhBL7jj6iYbv3rRphH
    HE78hGtYIAsfNBMchAKnclVm7n+sR/TnoLbbbY4c4lPHYXJgM+1lJQf4/pe1bE6x
    stiYp2R/5yUSpPZOohoFH3XDBVdufKXyfIMFACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497179; bh=AsaPC5
    gp+4/nIF1cXqy/loGXPiDCuMMfBrAvvUEXyB0=; b=a70MB6xA4SbfGQnRVJA8e3
    ZWYbopdldBbvY9lSLGw8LH4HmNMF+5F5qsw91qkXHhDotYaGS8SOYyk3AOkr9WwU
    xxvltilChlx9kABwcosKT8YsbIUaRNmRLa/MXxeylKeaCRdCjZqt0rlXDOHmUoEt
    95h+agkul7FqZNQ6Hi+ofoVYRToTkA0MaCHXWAxZPhzaU+a2OWpsdBX2nrUJfz+Q
    wkZWtz7cjKrpD9yCkEnII0FfScInfKNpXHRhx6MnSFQaUQaTOvHIeLZGehVu3hwj
    Fk2bPiDJZUZ22z3N/B4/vf5uOijQEhLX73T49xpO85lQgiUohuRdAlGVPWt+2b5Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LuuhMFaS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdekheenucevlhhushhtvghrufhiiigvpeefie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LuuhMFaS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekvdekheenucevlhhushhtvghrufhiiigvpeefie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032333AbeCSWF2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:05:28 -0400
Received: from mail-bl2nam02on0108.outbound.protection.outlook.com ([104.47.38.108]:23880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933993AbeCSPzn (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:43 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 35/97] ACPI: EC: Fix debugfs_create_*() usage
Thread-Topic: [PATCH AUTOSEL for 4.14 35/97] ACPI: EC: Fix debugfs_create_*()
 usage
Thread-Index: AQHTv5qo99e8ikDg4E6h8SyjeamWtQ==
Date: Mon, 19 Mar 2018 15:55:10 +0000
Message-ID: <20180319155411.12348-35-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:Bd6KLilfBgbQ/l2hza0oKSimwFpbDCV6MW3Vu4OQFAC8mIXM66gYJhaa0+lndB1sxWmjery3mu8adI1UpsQgwWZf1Bq+Ad4SUqqxrKzqh+xoffzC7UpOmpqvWdWS0+uEwqWNle6ppz6xl+09vT+EvDkiJ3D56vxTT3cVCbOiMZOVzepM4Pn01Dv1PmUD31Fn+rFF3CdWrZfNHgjWZbX3T+2LDmwP7nzPc1ydKKXE7mcA2N+tKHTyjUcWLqTvgGIk;20:BqCHoV3wgzRQm4T9b9ZWv5Ua1W+weTfAfhr4v7TKKXxGnCLFF6xPjlLCiBilP4YG4JBLrIADHy8dpTpW3aR1+4M5OaxBKCSAVFlbwWPJEEFvnzkp+KXAitxDPGxLY0F/r6lgQ6vbBYe83bAaHE7Zzf7YmvScOK0aviPfaZSsJl0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ccceee5-fe64-4f5b-f918-08d58db1ddea
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0982A93089CA000A3F311ECEFBD40@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(1076002)(106356001)(316002)(36756003)(76176011)(8936002)(81156014)(81166006)(22452003)(8676002)(3660700001)(59450400001)(2906002)(2900100001)(97736004)(305945005)(7736002)(53936002)(3280700002)(5660300001)(99286004)(107886003)(2501003)(5250100002)(6666003)(2950100002)(10290500003)(25786009)(72206003)(3846002)(478600001)(54906003)(6116002)(4326008)(105586002)(14454004)(110136005)(6512007)(6506007)(10090500001)(102836004)(66066001)(68736007)(186003)(86612001)(6486002)(26005)(6436002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: TouKsRTpboz/jZLEghBOXDXYDV25bZo2qpczsiFG9yhBNTnvNRC5JVfDw8jeh/9LoIHyRURjq5yjpKLlA4eI2wDwbzjUMP9CAEDWpU5Fp4v7bo2nE9MsZtbl2Hx6kbj9Z0n8fzJwQhFl1KGYzmmmBha/Uvg/7lM3XNCAJ2XLmLwtKb21jmMiR2qkD/V21J2P3IBxgHWcQG4xANrTLZCPZHl/kw5CccP9emNymuoWznwv1nYK30yYnIa/kXQ8oKpB40889K04E5GowlaboUziHrwauNDnnlJNTvm2JMv2Tiyce2nOMU3XnwVZQ/ppZDe1v1ZrVkyj3WRMiDl3ohztIQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccceee5-fe64-4f5b-f918-08d58db1ddea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:10.2763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
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
index df842465634a..6adcda057b36 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1516,7 +1516,7 @@ static int acpi_ec_setup(struct acpi_ec *ec, bool han=
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
index ede83d38beed..2cd2ae152ab7 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -159,7 +159,7 @@ static inline void acpi_early_processor_osc(void) {}
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
