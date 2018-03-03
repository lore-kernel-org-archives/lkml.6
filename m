Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120239-2-2854151772473966064
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120239; b=bh8gjE/n6kgeuwpu5XJaxuBxoqL+bfLY8juu50l3oatvTLu
    OKXGhCDpW8tXRf4R0qqVf4dP4kgk2s3Fuq4HJuznIDTUY/Olg+vS9FGszjRXtqev
    zrT4wi289TV7N/4aqEHU5GBaO8G7G1AB8y1ch7v7sQ6hub5ssZPi5wknsQlbnazU
    LGw06sBViXoNllc/VdY/xQ0/lWJOpWTx4GMaTwSorCgbdNxSNmod6q39P8ozJ3ja
    IoGAO2c07qxMmZddChEDaG4C2HSY9ncRZGFbymux17wBF4Gtnf14dbI0dBsznHqG
    aC5oGl3t9SNwwq14/DUrcsLcfx6SmQ5tnSAUqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120239; bh=x9L7R/
    lzN+FtipQqr7oc2INxk/F9ikPjMGNXDR0U6hc=; b=XibhuG9E+Z04jqWqrNR8In
    JJ9S8UArZsw32IPcyV21eTATl3z7PIcC2AFKj+MKdwEVEvMCmwoYSighlJz4aXtL
    wFnoM9Rzfp8e8UhsV+J7eWc9dB4LDbxgIk4Wtyv/ItCc0DCzLg/PBq1ZthmuyG1u
    /nNIjOCeQOC1AHhgplvwfnE4MDrrN4GbsZ9nglCe3Indal3heZJFXIsOBeFdzmgQ
    70w/NuEQnAHswamdadz+sds0Y1n+aa6vXEJJznifK8g9Sen8WJdMK+FCgB8W3Vvz
    m0HKCnC+y3lV9WfdC0ptq1ZNqYQzFDhRcDIWSO7fgKVRwlacAgRvDw5NhqBHgYog
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JPlohJJj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JPlohJJj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeCCXhD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:37:03 -0500
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:20800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934372AbeCCWfP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 150/219] drivers/perf: arm_pmu: handle no
 platform_device
Thread-Topic: [PATCH AUTOSEL for 4.9 150/219] drivers/perf: arm_pmu: handle no
 platform_device
Thread-Index: AQHTsz8U0bwTP+t26EiRpRvQbdIClw==
Date: Sat, 3 Mar 2018 22:29:23 +0000
Message-ID: <20180303222716.26640-150-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:eJB65wa738BH3s9QrQp9zyRUaSrP8myLT6st8HBv7Fp32pHOlB5zXam2aXyYPqMkdDwEArDjwqcya1SwJSiB/+zhI3EqII8pFXjAr3MCkyjiXodDJn/2WXEE0jJC+onIa3HDVy6HNetFzp5+miMf4LEsJEnwyb6WMJP7JBApIc5xZeVBRienWTeDNRuo2k5G/clNeV3ls0VwcuQf4hSuiw7f+FrcXB6zas1VuRikkoy1naiKjotSYHU2kmAaF2g/bHKnQ+tkur5c0NvS76eawaoPjPeWJNQKHndkT4UY2CeSzNYLWVvZizbC0HYbBHlPb0U7OTI/1hqa8vAIOUrKyMsCnXaquCNOxGsW6gGZKAY=;5:ONpOM6GUuYtxa+8DL8pWvFKCu/rY66tUdEn/ivTptOwkojinSfXhJoD/DCEogI6B3A8SFfGNbBwm+BYxlYsZXCIsRkwmVqSM7pBMUWRjITcIH5h+YZtPPRr9a6iLMbOM/xCUQJ2IroB0SdDxNsjNdasUhNYaPs59ZwvV6PzwGWs=;24:/N6qeRZ5Liv0zZO1pMGsfUXn7B4en13Y54uWMIFa1Xqy3bZQxZnJe0a4qHDQHsqN3q7csyVbTdybVaKu2PeqcKnpQ4F/5g8isQm8En2lcSA=;7:0IjWoURpNTEw1OBlCFbkJWW+RPoE/6Yv0Wl4dRECdml9lPBgSXHFzReztL5sE8eFhF3gJWEBE2IIyF6vfhV2O0l0KTQJo1zYelID8KT/61KM8uRvUlkaF56MrROjYuTsVRizXcthww2q7aGzDOtEgnKTWkijklidGXGFTE9CAqCD3Hc9zHixwZYGgK71IDMKMlZXkkkMhOUvux7LQJOcg7AXXSW5ZsjTc+KIVYMemgMH/IIap/d4wLWZNLUht9Uc
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad33ae7d-b78f-457f-d29d-08d58157033e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09242C15B5AA720EABBDC4E2FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad33ae7d-b78f-457f-d29d-08d58157033e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:23.6663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
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
