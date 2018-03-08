Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488007-2-14102724628121861931
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
    t=1520488006; b=HH4JfDd22KPdhUNgG9EQkL1jmdLlLRrPqU3CVgvg6BANq6+
    w6NeuA8TGhWn95sctnPXMa6HBAEzswhixAOASSyNEaauhfYL+IBgSiZfvh4EcipW
    71YEJRBQpa2IxuQll7SyYmbhwIYzlMDp3CsVmMCueUjiZv4G8ArckIGqm7NfKbwg
    dGMobZZVDgALN8kcc/lxySba4JE/GCvnSLzry+S+NVptzWguez/DUuq3gInwUMQs
    GT9zoAmgrJy0dBvbUP6ApkutUiidu0rYNWIpj9LhGSNS+zCDcFNwe3XC9sIgJkge
    VwYC2/kw7TkXsOFQV2oWgfhXmpMUMMiNyo5xQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488006; bh=mbpM3b
    Tu/E1T2SDyZlVur64ZGk5CAplt/nA+w10opyo=; b=r1ojea0UtIzgeGmyS3fwdu
    OzLpfnfCB9//8A8cUguBIq7iPvMwQ4fJlg2MWeLcYONyKFFLMWP9RtdUcSHaBI1t
    pPJfsslPRWHbOI7CYHuTbraOaJKeof9Ut/ra6eAQg7cb1/xVDAITMLLjz7oL/4rb
    okhYyXkJ8EPC0qDZtwuVECxCzMq7SwcSPZd5pAico77hdsOTil66Ult/pbVTQN9j
    YI2uqcJbZ1dLRvvRsrTF4ObMEeRZqNU4/aHdLrbtH8BoWzDlgfcg+5njzDdRA7Gh
    ukyPln+xaK9vJYrA8hvRoR+Ek5Tpdg1KyqMKCIeYFRgBGX20oG6aNysdkr5+oGzQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LT4PZtMm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LT4PZtMm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755399AbeCHFqb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:46:31 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965997AbeCHFFK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 003/101] drivers/perf: arm_pmu: handle no
 platform_device
Thread-Topic: [PATCH AUTOSEL for 4.4 003/101] drivers/perf: arm_pmu: handle no
 platform_device
Thread-Index: AQHTtpp41YPk/YUCoUOXlmWEWl2Tfw==
Date: Thu, 8 Mar 2018 05:01:08 +0000
Message-ID: <20180308050023.8548-3-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:CleHxz7VwzXYmdRyCdj3WSiONJj34Xp3nq+BlAGscAEuQZul6G7rdz/eF4n62BNLRBIeIxQBo1PHveuQjlVn7P9j5EhiCe8OLFdZKcxC16r6ECUrDZYnmJ7QZ7TFxpU3XfDxvUYYwXXQinDbc6UxCEy9JbLTafcj9+Sq2k6rPZsJXk8tLtSQZFHl3IgY0iyOaLJmjJeqO3waN6lO96JP9/1zebsjBGXOLKAHfqvHAC+KCyNN/LQPnSV9Dtxdwzk2;20:SdV++a48svm3tNKim/TCIHo/gaOvoESbFX04Lq+4rrL83wneRnAPj+B542N80Dn1A573L9jkoI4Bd63T5MkVe5OZP8kAC+5/8l8EPomZuNtyhFIA5Vbh0/s6Rpn008MrYpT4dpYy3KyizQ1j0jJL9NKNGelvGS0gtwAo0s0FgdU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 717cec56-8c29-4c5a-68f4-08d584b22733
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981A687B33D147672528A6BFBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Mo1sXKRlqpHTqmnrz7sc33ua/pLTNpxF9Ddg07oic6WzWnbhexKJ6eR5W9s/WtxBISNA6RXrU6WLYkAMvaNXeIrrmkgq55RSceqqoClJAyQDoUABpw4w9iq1EAwNcFQPZBvQ4V2VVCYrJoeffSMMdduTtO+vKSJT/p2ToryLNs1YOyOqUjWJrgRHMa4chXVOpOyNupFcUiDv3KaMRm3gH7QoyTQeds5bK9pF1J8PapePNZMiejvBPDX8BygM+qH1EZ1aFmiOy10wiPxHwUYC2nvpZ7DogLKxSEF+LYTMSeHARg14WjGwNs1RNbn0HnvXSXuiRn6s8XWiKzQinmCMPQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717cec56-8c29-4c5a-68f4-08d584b22733
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:08.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
