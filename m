Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118456-5-10635825042795750121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118455; b=XO8UEnCip6Kswds4frtFJgX4Cs2QIACgCjXMbcD30kq1sTB
    bjQwNfNZZ5YwPA9D2LA0blmN2y8mMFc5x859MS8x6XDJq83t9/eIE1Ig1n/5yzJI
    w0QB/z7BUAnZtOE09r1SFjeMe/0srJ8nhoVabCXIIm/Nc88gjFhxYxQ+yIu5DHPf
    d4FWxfpWvi6Zcyj3tD9L/wJhslg3z8SD10f1MeAwmqayc+6go4lYgik5EwZUxyNR
    y4EsK05yK0yJIy6MiHa0iBcXLaue9zBRgj2f4oY/vRroFSzTaoFb96aYtgNMKXbB
    VFs0mouCCDwV7dCbxIvSOG5WXviuRQgLM5GoH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118455; bh=mbpM3b
    Tu/E1T2SDyZlVur64ZGk5CAplt/nA+w10opyo=; b=Teiv7N+4J+oe/11V5fZ+A4
    lDLYbU88ZoNzH5SIX8P43oU3L5j0J9cufEVCuxpn70WnZ1zPQsrmzg38CmSaeXuJ
    tn/XSmrzP9jRn7ldeWOuzujzjgUfArs/QQY/EekBlDEJxlztrwuhpK0NDauJ3YiO
    xoUAx992v0xhCDV47a14wl0uH9MwQz43hHPVyz0BpiRTPAosLUCISRpwkivOwSjG
    nETSmT4AcHubGerMTfaxsD1l4s+sXkmwmvGfml7dAP1F2uznt6s34lo8vbZ3GEj4
    1Dn/ULk+QzVMaBau/Sdu4Yj2+4VHAIrilZnA67OBZ3oVXIZin8WxykIWQNLXkC9Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ov6kT6/h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ov6kT6/h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933793AbeCCXHI (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:07:08 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:62880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935171AbeCCWkI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 075/115] drivers/perf: arm_pmu: handle no
 platform_device
Thread-Topic: [PATCH AUTOSEL for 4.4 075/115] drivers/perf: arm_pmu: handle no
 platform_device
Thread-Index: AQHTsz9hgv7Lsv/P206Nc0Mv9bUwRg==
Date: Sat, 3 Mar 2018 22:31:33 +0000
Message-ID: <20180303223010.27106-75-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:2hdoKSsTalwLebkookNV8B3oaViKcj3eA76d+ydOlJQO2OxQSpOxmWpz0b6v7b1gca3NGhv6VPZL64AoK3AmTUiNuZ8lIIG6XGVee8wlRczFD9C3OS32jB/kiMvzPHJa2vK1Nt6uu/kOS5z1B7PVcrvg69tog4owWlP9ByOSZJALyw+g3CftW7uY5lhmtA+HbrFHFYEYu6L9XL/e6DpnWYqG7USdWt6HKzA+lzGREMD4GfcAc1EEjfRl+gxb9mtV
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0d1d12e-61d4-4e00-4ab9-08d58157b2c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10336F2EDCB55E7550CADD6BFBC40@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(346002)(396003)(189003)(199004)(3280700002)(3846002)(316002)(6666003)(99286004)(110136005)(2900100001)(54906003)(2501003)(10090500001)(53936002)(5250100002)(106356001)(76176011)(36756003)(107886003)(2950100002)(6486002)(22452003)(6512007)(6436002)(86362001)(6116002)(1076002)(6506007)(2906002)(68736007)(102836004)(4326008)(59450400001)(97736004)(186003)(478600001)(72206003)(26005)(3660700001)(8676002)(25786009)(66066001)(14454004)(5660300001)(305945005)(86612001)(81166006)(8936002)(10290500003)(105586002)(7736002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: WcirbWLeXrqDNbpdIXM50WZMQJ1oWaLpnpS3Y+D0ni7kAz4Pog75axDa/9t5yZHeI7ksSITxi6Z8Q3ugxduzOZok7DFky8GRnreHylIyAttEAIKmW2UKeWx2jl7H/kAvXindx+aJ7Zl/VpRJ8e5OPcDjVk0m7sNV+jOyprqRCwY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d1d12e-61d4-4e00-4ab9-08d58157b2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:33.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
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
index 8af1f900ea65..1ba58fb6f796 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -321,10 +321,16 @@ validate_group(struct perf_event *event)
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
@@ -336,8 +342,8 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *d=
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
