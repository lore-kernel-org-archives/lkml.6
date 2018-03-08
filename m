Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485223-2-18085614210405468395
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
    t=1520485222; b=q6sCkgINQCZvshwSXmfo4GrK4ZLcX6dVSi+Rz/fEMEQT65Q
    Yd5eIrNLxdw1eb60vfOGRJRAawV/PcOrRww841HLiIDk2k9Ma/Y5uwJmmc0MoPnf
    aNPqIwIs7WjcuvdOtB1a4A2EvJ9v9M1lUe1869dd64C8EIHgoAklASNBmy7pDG34
    vYxrJgNq9wzCY7vBblz6XXSw0mLxJ2AmPy9s32yc4Dg7LLBX+U6e3r0nWnsJ7JTt
    8iQsgKCHsC1fxuQnAV8T5Fjh/BviFmQHVtH9V1caMvCtMb/SZW/sj0VzdOH3YBl3
    INONgWz++LsLzdmwn1hw1h8kv7lA6lZF6Wh+82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485222; bh=V9naZE
    txZ+UKMnn4wjm8AV0sfA8tJouQzFeDbRbUenM=; b=phV7+D0vZQfmUMiStKV4lW
    oqOzUGLlH9mTvgDhFWQzLR7SiSaoCkh6JA9rBA61sytRkhbQPot6mIFU3t7RhWm9
    lRzrcRkVClneaFhOIoTOYq9WlzCaB4sIu0QXIj/FjPtrnp4ykkbk/r6Z+o/tu8JO
    VVnA8MlrGhZN25hfO8keCHBsY3F2gfC37Eot+8U+9CSC7yKCCGJdzI+Auq+Y1y2j
    qzhbZEjhvHDyCBRt+Non1dCNxHDr0Pcpa6sU2q17HkTD/2RBsDbSLOanw3g20Tos
    r08lbw8ZaVRZi+2TCFJqsZMJyb9JCvoTiv4JZnE15QpRheT+a94owlIrAscU+y6Q
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RZ/rLVDy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RZ/rLVDy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCHFAT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:19 -0500
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:47332
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751271AbeCHFAK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 030/190] rtc: cmos: Do not assume irq 8 for
 rtc when there are no legacy irqs
Thread-Topic: [PATCH AUTOSEL for 4.9 030/190] rtc: cmos: Do not assume irq 8
 for rtc when there are no legacy irqs
Thread-Index: AQHTtpot6W/6MCFNckyjpv7PB9TPVA==
Date: Thu, 8 Mar 2018 04:59:03 +0000
Message-ID: <20180308045810.8041-30-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:L31UKrqo2GrAPneRISYbH/He5XAaxbwxvssiMqfKtbk2HAcHckbu6efczrjn9w4r8mcjpDVFeb/UgulHJ7fa41EB3ad+JZz+qAwVlic9uUHmRZMpYxZ4XGv2VnblMGnEmqYwmxDFS0qi9T7b+fbbTe01XpHSLFQY4Y0fR/svZgFcdVH2TmRWF2DjLT2n0zPSl+gQnqK3VCqO9hoh8fsIrJ6ZGXRUmlF/2gzu/hBzMbg53OrdMabzXH2A3OBQFDKr;20:53V53e7FjcA2fACOI42HjamjiNSxEYldoWXmCS4UUDaSKJpM7M+q+jiprwThMObnvRvReS2KSoNnuMGTl4ryZzHNnHuyXYteUBYWv/3z094tHYF1iEV19hvmi2zyl/6JGTUXGNpQySFnN01M8ykkNC6MqHGuOZZ1j8YHKjqjBrI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4f19591-d5d7-46f1-2457-08d584b1751e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11126EC68F895395C96E2D21FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 6OMchcBqCbZa41pUcf7Lno70j8wdWulIYrIfKwDw5Hz1gp3NghWyxYGjm06xUSWWRcGVFhyXD+qGqlZgVwPiaywQTrQb3zPBS3tE5GciVv9HvFdywCOmgReH0qBVH8b52ZmdM9uO2xX5R+9U9azPlConRUv6tWYA13D+tRbGkr+K52a7sjB4DwORc/1ZjPHuGoGuJor45Xu9DaiOYYv3XzewD2Hj4/t2lbDXl7ICefUtt1AU02EG49BC4DwkUritPQHs9QNrSDuuJrSD1svF0KFTuKaJxrIXRrXP/fSZHvtnhOVyOEzhGfNKwzRcryrnOy1kxp3q0gQ7m6ykUnfFoA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f19591-d5d7-46f1-2457-08d584b1751e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:03.5634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
index 7030d7cd3861..c554e529fc4e 100644
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
 #include <linux/mc146818rtc.h>
@@ -1117,17 +1120,23 @@ static int cmos_pnp_probe(struct pnp_dev *pnp, cons=
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
 static void cmos_pnp_remove(struct pnp_dev *pnp)
--=20
2.14.1
