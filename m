Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490864-2-6428780659480747564
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520490864; b=qMX/WUYIi2j8W9POvpScaRQKyx0i+PQi7Qb8mSyDSAXJD9M
    Ch3DIFFuVXHtge4zjkBVXSqcWBgBisVtA/ZpLwfV+BZRgzdDiQzEqesc3IQu5o3I
    XzgUFnudJUorjNMMMgJ4VsWKPTVpXYr7R3Zq3Tgx87rYwJTx/BbXgkIo0euMGOl9
    CSawMLtYlWZ4bjuEvjh50elT7c5DDSb/FD1ozBnUeuQqNM4t3HXDoMyds1mTW2G5
    IzI+Fh+c08G0e25Kx9Gvw9E1MYxaeiw5AMRz4fWjR1mV+j0PN6uNQBk39MBZwO8p
    oGYqNizQZNWWofdNWo5b4I18w9QFcXzaiPRrfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490864; bh=x9L7R/
    lzN+FtipQqr7oc2INxk/F9ikPjMGNXDR0U6hc=; b=WHR77laZFSvIN9KD1QkG9G
    o4I7aGGlE2FhxwMKoL1RyQ8J+VsbiOamZZ5Utuu9uocMS55IN9RkZ3ZVrV+ejH/8
    mvfT7FfsUrXVrj2+YJb/xAcic0Cguo3m+vXupbx/Oz2OMVRe1meeDwZiJYbL53MW
    dWLtBF+BGkEa9AiLi7sXSIcQQtHBOV5WNUT6zEY6aqJAoKC4mwx+8zTWZM3PoNi4
    qnOaAf9g4lvojdwfqCDKOa1i2EHkjyI6RRfNIC2URzj+NgSLFOQ10oG80AARVNKc
    kjh3pa5czkiJHdAIMYZmGFGSgq3TiGu916aM47SH5neUyktYeT9RoLZZoOtYiKmg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=crKMFcRj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=crKMFcRj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeCHGdu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:33:50 -0500
Received: from mail-bl2nam02on0092.outbound.protection.outlook.com ([104.47.38.92]:59552
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965532AbeCHE77 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 006/190] drivers/perf: arm_pmu: handle no
 platform_device
Thread-Topic: [PATCH AUTOSEL for 4.9 006/190] drivers/perf: arm_pmu: handle no
 platform_device
Thread-Index: AQHTtpolizEVqqXCsUOq/0VMan29vg==
Date: Thu, 8 Mar 2018 04:58:49 +0000
Message-ID: <20180308045810.8041-6-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:zTHHoAj3skFySz7Qk5E+UDzZPfYTlqZSIOVaLlfUh+lvBPex25E+qTPJ7FLY6zgLcS4oJ7jZpBitJSJcWgbIMkYQamtEoKyDy8GXoFDPCFELs5iGNjpEmpDpz7Xwa7mF3NTsan6mS2SQ71CIvBza/h8Zdg3P71r4EfNWPccsfEsK/NCEnXiIeoK0/X68aj6QC22Af2yOx7RDAsaPnyn+bHzGqWB9G1nvdIuzRlPqV7NKBdFV/NgSkgIaqGLy0XL9;20:La9uqmvfrnK1hP2HA0TjhSzsZ8FIsNnjbQisCH41wT79Jgg5ltTu7YT2YwI/vK7YrJawMY1LPV1kFbZrtXFWWZYzotbhV5NloBHBJwvRjNdnYvsJEerT0IJmGYRas2NTcOaAFSKjgLbMdpm66fCY9k9t5zlx92lF99/xjymU5z0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8097ca71-b256-47e4-1b0c-08d584b16e32
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092054E2FEA8C79616A89123FBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: efnI4R5n9LYy5nC8KrTjlW7TDvO+7R2L6HQsYtBy78dkF3wcQd1Gk7MbC6VIuYowLX6d0RGuZHW8Fzu4QTFvVle7rCIKWKc990FlO8LLBunw1wXrxPoNgEVrsTEpfoXDylo2YR5nGggW4PgnQqzX1+RT7LRENUqH/HDF4IrCui+qkw4B/kRLlkcxcFYMqMrody3vLzaMCiIxoZA54bGH9YDngN1q0xbnD+q0i05ARcgIh4VJiRWpG4OWNwkJt9LP8hX/CW6eO5HSJZOfy4OdZTKKfmXmTTh2cvYlBBH7Hi1+Jduv/uz7U24wm1AtGRphGLg2EiNGCdE9HXoFFJ17ug==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8097ca71-b256-47e4-1b0c-08d584b16e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:49.0732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 7654137071fa706e5c91f4f27bc2a5cd7e435a9b ]

In armpmu_dispatch_irq() we look at arm_pmu::plat_device to acquire
platdata, so that we can defer to platform-specific IRQ handling,
required on some 32-bit parts. With the advent of ACPI we won't always
have a platform_device, and so we must avoid trying to dereference
fields from it.

This patch fixes up armpmu_dispatch_irq() to avoid doing so, introducing
a new armpmu_get_platdata() helper.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/perf/arm_pmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index b37b57294566..af82edc7fa5c 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -322,10 +322,16 @@ validate_group(struct perf_event *event)
 	return 0;
 }
=20
+static struct arm_pmu_platdata *armpmu_get_platdata(struct arm_pmu *armpmu=
)
+{
+	struct platform_device *pdev =3D armpmu->plat_device;
+
+	return pdev ? dev_get_platdata(&pdev->dev) : NULL;
+}
+
 static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 {
 	struct arm_pmu *armpmu;
-	struct platform_device *plat_device;
 	struct arm_pmu_platdata *plat;
 	int ret;
 	u64 start_clock, finish_clock;
@@ -337,8 +343,8 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *d=
ev)
 	 * dereference.
 	 */
 	armpmu =3D *(void **)dev;
-	plat_device =3D armpmu->plat_device;
-	plat =3D dev_get_platdata(&plat_device->dev);
+
+	plat =3D armpmu_get_platdata(armpmu);
=20
 	start_clock =3D sched_clock();
 	if (plat && plat->handle_irq)
--=20
2.14.1
