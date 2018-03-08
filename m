Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487245-2-6188605371656385594
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
    t=1520487244; b=D8V4NM+UIpNzAT306v+OawE4f/werKXGhg2tq5Cc+6qvc1I
    z9sL1U/jLjtAkj/7U4DXbzbyDKHVwIcyH6Rw+rCA8sJKK4JjpahyX7sqCOboXvep
    GfTSXzRbeW5fs7lpAgMfX0uwGVxnlDhHHuOUVjY/C0cAu46R+sQHqzdtpqtBfDJJ
    gpky3OWmw+dmSFfyeHqXwx+oPfPO57l8GhZMvqvCe+0I8g4q59burl3kiTGlZuMH
    QQT2LTwWHZV5DBA1b8RxJF3+B4ZhUCjy7TLcdbfTD7XGBsxEoR4koGe17usH7KqT
    BtXQmjilcHZoDnSTbJiHIiavIi++PdqyvE8SkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487244; bh=bZRFgZ
    30IqCsn1/OwFE9A+3X5ndcYQUG1Qb7VirFuOI=; b=lglwV83wXaReDchnPIWAKc
    rGzGJxfPpEr98GngAiHsED2uL9lyGfzj4/1SFuf37RORE7Mmi4bd0xPRBwEjL4SS
    tcXlv+awLwKr8nAetyINxzEBIVZ1VruUhXcNRNHyPgdzf4n1gJEh6rrCwztO/fk6
    RdRmge1+/SCE1S33SI+mzZhnQ4Vew93qW2jzcErCldEvoFeywoGfwcWeHk8ahqeq
    nXW4g3QPBVhXo8q2CKJZMtlk+bPzyJOUv7Lgr1MRR61hMNKDNEvROLLtRgxJM63r
    rYry/6eEF0w93G9/wJRj5CKtXALr71S/1dzGXPLa7y33ckbupTI0rLyKIuHf58ag
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WAZPeH/O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WAZPeH/O x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966375AbeCHFGP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:06:15 -0500
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:12788
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965958AbeCHFGM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Finn Thain <fthain@telegraphics.com.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 048/101] scsi: mac_esp: Replace bogus memory
 barrier with spinlock
Thread-Topic: [PATCH AUTOSEL for 4.4 048/101] scsi: mac_esp: Replace bogus
 memory barrier with spinlock
Thread-Index: AQHTtpqNxVk89jeDV0isxXkIn432pg==
Date: Thu, 8 Mar 2018 05:01:44 +0000
Message-ID: <20180308050023.8548-48-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:JsCKwAdNv/q73ynVXh4iAnp/foCmNKCcCu57Hz5hccfmsjzXTkDAGwx+p5qFyfU9dB14osGlOXSSeMEraqZ0EOoMAk6e1Hi3LS13OLisIVo6EOREYhicqVj8X4jC6Ijk1Tmc+fUUMYRFRtbVu7IAztdIa6WFpOgQh2GmJUKaCu/8PkWyTJXFaYNhsD1gv/wJQ1ed/7957W2mKK9O5g16gqjitCgzqHLfFis8Y4gpg1SvDAxYdkX4ftMq47VYQ/sw;20:D/6M9pCONniVjx9dkBO1/VDmdwk/5H+c/bhKNTdq9kDa8Jeg7g8qGwXB66rHn6zs9o9qieSyv3iFKpnoxDCRLKnED/WG9dZRJedeIsYZucrKPTca65FsWC4MnJ6swA3NSiAeKYbGLNUQLdHAZqJqcdGzMf2E8fYYXwW/oHoLXh0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50974d37-05a6-41e1-1317-08d584b24d1b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09177751C72F2DEB0F9C9138FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089)(46150409022019)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(59450400001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: a+LdiGCazGa10hQuyXA9VGgqc9sNlLX2qUd9bi0AIqQj+R6J4ngXPftwXTZJrW2+pPWpf79YrNbJZwgxFb7gvREAI04UCUljKNUTPSY7mmE+i37czK/onQngAgLKt5CzTEpBhz3BeSAIHFVd2+9x/VQSGnLwrgA+2PU7oTQx/8ICimJoPRdTUyeh8QbHp+CDJ9fcNH5k8hhfGCV7QHqr7BbLpiwbhEvLLYOIv7eSbRnTTC3lzSpuCVmmE5Sx6TQB9R1KdMCzeSp+iRvF8Ojn3HV23HepiDi+V+oERu3CX4S4qL8Bx1N8DmxTRJERUFSNCagCOv9oWo94c5RfsL38EA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50974d37-05a6-41e1-1317-08d584b24d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:44.7955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
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
