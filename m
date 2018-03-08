Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520489623-2-13712340113194282764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520489623; b=wF7/EKJ3mBRhnwDzWeoyKEMWObRWUbo9NdZkn3xFJLV4j6f
    VVZSDAgI8bXKaOWXJbZHX4zJiOCLrA1BAso18Ts5sUxnDSWxzB+jXxfnDQWh6yLp
    8/DrVJ3PXP6wU5cVjq5Dz6cN55SyfZt7WlGBDdVjOV/ccDqUGA7ijhpoRHOBLflk
    p/Vo0ssF3zJ5o5vnwAdUJogUznxl+lyPzNLoY/b2HxI2Hn6jOKIUgPbOy4TQcI+7
    X4CnDnMZAJ8ho4+1vMXwQGDa3i5lmsMw8NzTISvuvyq3mg0hOXOzCec3KXzJYx3T
    rUB5cn84x4FCnLm/Y5HSbH580zsXMxUQeswi0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489623; bh=bZRFgZ
    30IqCsn1/OwFE9A+3X5ndcYQUG1Qb7VirFuOI=; b=eU8TZKqFW2hW7cqNL+V/W2
    52mAGLSA78F7siEyZw50SOMlbsmhy8XpJ54rX1R3yB63JaqBL0FXlzYq+zs81QhR
    Vp9MAS/5zcbMi4MmTQydW343RSMezDLI5b/wHhfxAEN08AVETIwRlh81VLi+LrNy
    ZWAYkhcMlXE2roIOlDFabKmOuU1NgXoLyrdx2QwtDAV+rqjZtFhiING+/O1OUded
    S0yYY8husOMeT58oCn76OY7g+kubybw8+u2YQjyWn4HLSmtSbFbDbgE1gb6hxnt8
    BDCfz0aZwihpSdizj40fuUZBkNJkd7G+qnMViL7bqrqjCb/QQE9AeR27zsjt2Xhw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hidWXAzE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hidWXAzE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965145AbeCHGLw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:11:52 -0500
Received: from mail-by2nam01on0096.outbound.protection.outlook.com ([104.47.34.96]:14896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965392AbeCHFBh (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:37 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Finn Thain <fthain@telegraphics.com.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 084/190] scsi: mac_esp: Replace bogus memory
 barrier with spinlock
Thread-Topic: [PATCH AUTOSEL for 4.9 084/190] scsi: mac_esp: Replace bogus
 memory barrier with spinlock
Thread-Index: AQHTtpo88jWV53hzjUucl9msAN1BoQ==
Date: Thu, 8 Mar 2018 04:59:28 +0000
Message-ID: <20180308045810.8041-84-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:xk3zS7y0qY3kxUiLk1LrkuQ5afTT0xtGiVIR/y4jcUhXe47XqKZWuk7vIVOdyq1gAZkjjp6j7/jEVIugzTlqf1A+lRBKuTQY4aiX4W0YvAy5Xm7jz1ioiYqcglKTnqsbAspR4sKNxkIOZFbpGBZQJvp1iA8/G2rDI8Kwh8H/ef1XF3ghhe7rC8hyOF6Ur6TRLTH6oNscU67Ys8ueLijE/vcLVXgkrf3c0WBtdwduD8UElBWNx9db0lwq+AMCvhQG;20:Zm8XcxKxzVXDBnbnEOS0sC4RQk7mZtGMpeNUiQE0BUbQSCGGGPl9We9vKdhjMNvTVb/FddsMOJetGPn7MR6YZRtBSZYsSiCRu43ecW9BhDb/iUEP9NfhiUMN09k8EiQ/ildfRjGmRolgufY1BU0BBUTe2Cn6LuogTru+HsenQQQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04bd858c-2ef5-48ed-e3ae-08d584b1a976
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09998B8AB659F6523DF6EF28FBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089)(46150409022019)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: o2ZVdGKMhiTB+3hiS9bdH4OKTNGrQiGDPRuoPrupdiHwpxgGOFHXqAPsA94DuW4z8idUJQ/DZ7cDOUOaY6+KmmZkoLZBkcN37ZjDDlFmUknvjC4dJAc2yKby1kJC8CxCTBjNV1CRS2aDnjUaxGQBxCjfWZRMh6f40yz0kjRe5QoKeeKs70GvsL4fLCFTwNYRlkDexFhGRihrysTf2P0qTTq3W4HnLwVLxXtONtBGVdh1ZJjnYaElo8vdVrHHM2sKzR30l4O8qjOMbRjpnUsweRMEKQNXCMDxXi+UzPtVQpSROo9CA0KMQo1yNvUlBvnMHsvtvpeli8efB2mR2Tzr9w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd858c-2ef5-48ed-e3ae-08d584b1a976
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:28.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 4da2b1eb230ba4ad19b58984dc52e05b1073df5f ]

Commit da244654c66e ("[SCSI] mac_esp: fix for quadras with two esp
chips") added mac_scsi_esp_intr() to handle the IRQ lines from a pair of
on-board ESP chips (a normal shared IRQ did not work).

Proper mutual exclusion was missing from that patch. This patch fixes
race conditions between comparison and assignment of esp_chips[]
pointers.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/mac_esp.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mac_esp.c b/drivers/scsi/mac_esp.c
index 14c0334f41e4..26c67c42985c 100644
--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -55,6 +55,7 @@ struct mac_esp_priv {
 	int error;
 };
 static struct esp *esp_chips[2];
+static DEFINE_SPINLOCK(esp_chips_lock);
=20
 #define MAC_ESP_GET_PRIV(esp) ((struct mac_esp_priv *) \
 			       platform_get_drvdata((struct platform_device *) \
@@ -562,15 +563,18 @@ static int esp_mac_probe(struct platform_device *dev)
 	}
=20
 	host->irq =3D IRQ_MAC_SCSI;
-	esp_chips[dev->id] =3D esp;
-	mb();
-	if (esp_chips[!dev->id] =3D=3D NULL) {
-		err =3D request_irq(host->irq, mac_scsi_esp_intr, 0, "ESP", NULL);
-		if (err < 0) {
-			esp_chips[dev->id] =3D NULL;
-			goto fail_free_priv;
-		}
+
+	/* The request_irq() call is intended to succeed for the first device
+	 * and fail for the second device.
+	 */
+	err =3D request_irq(host->irq, mac_scsi_esp_intr, 0, "ESP", NULL);
+	spin_lock(&esp_chips_lock);
+	if (err < 0 && esp_chips[!dev->id] =3D=3D NULL) {
+		spin_unlock(&esp_chips_lock);
+		goto fail_free_priv;
 	}
+	esp_chips[dev->id] =3D esp;
+	spin_unlock(&esp_chips_lock);
=20
 	err =3D scsi_esp_register(esp, &dev->dev);
 	if (err)
@@ -579,8 +583,13 @@ static int esp_mac_probe(struct platform_device *dev)
 	return 0;
=20
 fail_free_irq:
-	if (esp_chips[!dev->id] =3D=3D NULL)
+	spin_lock(&esp_chips_lock);
+	esp_chips[dev->id] =3D NULL;
+	if (esp_chips[!dev->id] =3D=3D NULL) {
+		spin_unlock(&esp_chips_lock);
 		free_irq(host->irq, esp);
+	} else
+		spin_unlock(&esp_chips_lock);
 fail_free_priv:
 	kfree(mep);
 fail_free_command_block:
@@ -599,9 +608,13 @@ static int esp_mac_remove(struct platform_device *dev)
=20
 	scsi_esp_unregister(esp);
=20
+	spin_lock(&esp_chips_lock);
 	esp_chips[dev->id] =3D NULL;
-	if (!(esp_chips[0] || esp_chips[1]))
+	if (esp_chips[!dev->id] =3D=3D NULL) {
+		spin_unlock(&esp_chips_lock);
 		free_irq(irq, NULL);
+	} else
+		spin_unlock(&esp_chips_lock);
=20
 	kfree(mep);
=20
--=20
2.14.1
