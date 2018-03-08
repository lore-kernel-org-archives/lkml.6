Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485527-2-7772343420865279923
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
    t=1520485526; b=T6yKmFk6kSp6cz30JSfZ8DeSgvZ2UEN17GGFMnSx1o6tzSB
    nraVfph1v+CnC5QQg9KFXZehQZs91NlfF8HnAKIZjjjgjBvtpAgkW00ox8Lgm8+a
    YoTFcjVHYYotVUV3x+GFcfg5W68/msKMVxjRNug97t3kC7Y1WHSu0efxuSBg2x6n
    UdrWFRPMBy3FAfh7fIrMRSGNzfTdwerhrsuTCklgoUYxX5GW9zWIdho9fQpeY0CS
    rxn9hfNrRRUG+9IHuV+nDtikNPDc8Qcyu6/3yZPtmq52HLULB+EH8HQiDhgBJTn+
    slkUiVwi1+7uiwTRwl6uUxh0luiHK4g83ZreAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485526; bh=cSQsD0
    8RseX22pOwfe66XF3+SFtLk0blr6l2+60qUp0=; b=IodgCTL59Pf4i6fZkkK2X4
    pujdTYQO4+Sq/lDEBD+r5mVwriM4cUrmfZypQkW7hiFlwXCZRpTtNrT+518CuSTp
    0Zj8P9iB3BKLQdpuW7EqXfgW5249qNJoP0XbB/v89T3vcDPVjGTfpiFdcn1mUg1Q
    fouR7acs+AIQ1LXvTsa2sQ2sh/jZYw996NwD0j77WJHopmv25YVm07MLMKngV+ZM
    iG/tKurk/jT8VKsxcILoqJUPF25HR23e+MdYZL2Qj/0Wy7tS+9kmgC3P/JvwoRkF
    BnGdsl811k9GqxFRTA/cGxrv1hzsMA7q3yQFp1e236eNDHh2O6+kzIyG0qSFHzgw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cXxymLxV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cXxymLxV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966189AbeCHFFX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:23 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:10302
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965790AbeCHFFR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:17 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 014/101] rtc: cmos: Do not assume irq 8 for
 rtc when there are no legacy irqs
Thread-Topic: [PATCH AUTOSEL for 4.4 014/101] rtc: cmos: Do not assume irq 8
 for rtc when there are no legacy irqs
Thread-Index: AQHTtpqEmcC1X1XcqUaba1hMKCQq9w==
Date: Thu, 8 Mar 2018 05:01:28 +0000
Message-ID: <20180308050023.8548-14-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:irGE7GR4YFLs9+nvfCsRNHerA0CddbGcyjVZDb7fVBk4a7e7VgIOYBySsx3jUAAlq9CMlbyJ1z2ciczQ/XPJZoQS/LdrGB+2PEc5oATJx5xE/3aKjPyGR/P8c6wJT9Df4604MHk9OUPeTj87ACR3xiLIEPF0H89Ne0Ykx0w5bqrnWsr1F1sQm1wN3j7Ap2JaiJ4u52wfNDxb2wlgSC4Jbt9KDNoDG43l0C6dewiPU0udzTHRiRKTaV3WUybW9m3U;20:Atv05HBZ2w1leQAFzgVSsGCqjmW52K8T/4xUQvf9VMZ4xV4P/N/uC90wcBK+u3LjMcwuggk/DDchD8jbYzHp3vLktL2CKBbqnoZ6fFh+f42bdGI6GJ/aIJvCQ7Y5pkcDWZg3pQ4LUBBxTUzCFNpxfMKrBz/rbCN0UFVo/9S47Mg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44e87168-d919-49d6-a27c-08d584b22a85
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07270159F4C64CD5F2E91E82FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0fxnz0jZaiSw4xVOsROCIzx0X/Uf2o7F6s+cB6PkIzJsJakx7wq6+QJO3/Z24Dbc2QvDNW4QLQIch5+gfhcBqPyFPGNzRa8QEb5eCQkLjW6mN1f9YxOx2a02PUmoXQ+4SuFaul58VLQ8jjpp7ftXzPp0qXEZxcjx+26Rx6LdDbH9biV+nobxNmWX2AKkCNOM9QwOJzlRDhIcuNIKjSCuCn6ctJxKsoojsjvtbUyrYq3ZZLBYlv/2RkzjlW3QHRxBSVfM44KzuCw9VYApJ6MJmfTe+jQ9LOp/0CdnJwMA81pfiavHFZhUFsMfyiNoafuO4xTbsSGcT0VD/VGPqITAKg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e87168-d919-49d6-a27c-08d584b22a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:28.6281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit a1e23a42f1bdc00e32fc4869caef12e4e6272f26 ]

On some systems (e.g. Intel Bay Trail systems) the legacy PIC is not
used, in this case virq 8 will be a random irq, rather then hw_irq 8
from the PIC.

Requesting virq 8 in this case will not help us to get alarm irqs and
may cause problems for other drivers which actually do need virq 8,
for example on an Asus Transformer T100TA this leads to:

[ 28.745155] genirq: Flags mismatch irq 8. 00000088 (mmc0) vs. 00000080 (rt=
c0)
<snip oops>
[ 28.753700] mmc0: Failed to request IRQ 8: -16
[ 28.975934] sdhci-acpi: probe of 80860F14:01 failed with error -16

This commit fixes this by making the rtc-cmos driver continue
without using an irq rather then claiming irq 8 when no irq is
specified in the pnp-info and there are no legacy-irqs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-cmos.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 8f7034ba7d9e..86015b393dd5 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -41,6 +41,9 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#ifdef CONFIG_X86
+#include <asm/i8259.h>
+#endif
=20
 /* this is for "generic access to PC-style RTC" using CMOS_READ/CMOS_WRITE=
 */
 #include <asm-generic/rtc.h>
@@ -1058,17 +1061,23 @@ static int cmos_pnp_probe(struct pnp_dev *pnp, cons=
t struct pnp_device_id *id)
 {
 	cmos_wake_setup(&pnp->dev);
=20
-	if (pnp_port_start(pnp, 0) =3D=3D 0x70 && !pnp_irq_valid(pnp, 0))
+	if (pnp_port_start(pnp, 0) =3D=3D 0x70 && !pnp_irq_valid(pnp, 0)) {
+		unsigned int irq =3D 0;
+#ifdef CONFIG_X86
 		/* Some machines contain a PNP entry for the RTC, but
 		 * don't define the IRQ. It should always be safe to
-		 * hardcode it in these cases
+		 * hardcode it on systems with a legacy PIC.
 		 */
+		if (nr_legacy_irqs())
+			irq =3D 8;
+#endif
 		return cmos_do_probe(&pnp->dev,
-				pnp_get_resource(pnp, IORESOURCE_IO, 0), 8);
-	else
+				pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
+	} else {
 		return cmos_do_probe(&pnp->dev,
 				pnp_get_resource(pnp, IORESOURCE_IO, 0),
 				pnp_irq(pnp, 0));
+	}
 }
=20
 static void __exit cmos_pnp_remove(struct pnp_dev *pnp)
--=20
2.14.1
