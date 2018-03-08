Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485785-2-1371688127498100627
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
    t=1520485784; b=NU8qJqqZxjFh/MMV5mTwlTMtHCUjQc7nCOPkl8bZXSAg3dg
    +PgFkbHoeTIZOQ5KaoC4t+jtRdxApMDS/CzTI3Y+9jjvaoLQN+Df84zpYPvN86LD
    vPlpGqwrJZfsSTKJ1TIKMzqPsMdoDrUFaEhkx9+9E+yu+LzTbEDHstUcMTtVpKZK
    DBvmz95XNKl48wyjpAMf16FNZr4VV3/jUJnzm186kvvAAXsvV3/c7MYuON76taNc
    K89ZoSSIgpMHwbEk8sESj1ug+SkZczSkew5zy8WwH0PFUN0AMj8VXH0FXoZTXiBL
    tnpnPSpSr46GkVkfOms3N6LLwrJFg1D7XGiaANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485784; bh=idBac6
    vXxC6o+IFALpT22tOjnQZCWyJ5ZJZ8vjsgdtQ=; b=kWSRf1UIc8dUrxfCccGDyU
    SquCLlfvovZY5u23cxAQSj3zilWkOC3rmvhLLyAWJTxYkdNNIZwhoYhdIdhINuw7
    bAUgMR1gXWK5nFXxB9OPOGE4+SP2CCF68G9mUrCb60XdsEtbyyppYrbwb2IGn61M
    IY4o7BDBglFjfVRQ0JskoQU4nzveSrp38i3OM1kEIQ7+CgKqE9T2Dk5VeeQ0Isi/
    OX+gGfRUhcgQM/+eXIm4DJ1VT5ik/7NGcFG+1Uz3QfciyHtTwQ4ukI4tP4GTOFoy
    yZx3cNokWxsqC0DXDIkH/mH5rfupoo/E9XriNHA0ONPtUlED91eycHaUl5mG6b7w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DXpPitYR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DXpPitYR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965610AbeCHFJ0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:09:26 -0500
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:7248
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966849AbeCHFJH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:09:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Finn Thain <fthain@telegraphics.com.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 30/53] scsi: mac_esp: Replace bogus memory
 barrier with spinlock
Thread-Topic: [PATCH AUTOSEL for 3.18 30/53] scsi: mac_esp: Replace bogus
 memory barrier with spinlock
Thread-Index: AQHTtprGZ4tNdetmckeEIrMQBY5q7g==
Date: Thu, 8 Mar 2018 05:03:20 +0000
Message-ID: <20180308050230.8876-30-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:8lXFM5mPLAG4oEvfwp4nHeg2PjE1F3nxux1v8Yp60N0kCWmo40hPTNtgYDU9SD/q2nnGip8dKskrvvBOm2PGNEX+mGZqZ07ZgkHLD1MFgGcHR0Tt3u6cy1darLjMKhTr5PZpDEwLlR2gLcoZQRIeH7Tl78JqPJnzjUqxabnxRdyJ517bgkwDWCbokwNNXgMiXDlPRUC1L3Dse5EgjZ6apb59eLprcw++0p40V7S0zUudNFYr0TlWjlvkC+ob6US4;20:ZWH1H6MIS+TlZCOcztWQ6UpGQXb7mGdes1sUDIvn/N4uoKGjRT1+UcOh2lw5eomJldOAN/cZNE1M/K1XWVzIxhiOuenIplZjgaEEFC9Wp9FtbvQaEKN2H7ZxqHC/5qHUw8j1t9ZLWxXvftdPuIlId7bM34cppBMdrZptZkDUkes=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6de6d3bd-885d-46f3-da2d-08d584b2b6c1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10308D6D4404A40C67BD7585FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089)(46150409022019)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(59450400001)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Ru62k+u6YhNLQMQ9kBw7m/ULPIDZ32nHvifsFAR/6K1iB99KcHWsrjdnDOCY52OdnROGx51mioTWlSP/9Qe3uh5yKjWcC14hjbPWAPOhbJM0dHVZgMU5ttOaYc24Wxv2lt+dKn4lmmKk7Y5kvJf2mObMlnI9+q1BTKl8jxdCngZzEDHO+YLB9nXgs8uZGUJRtC20HjjYupBNTn3+EgD5BzeR4591NicS5zwQBjH/jhg4OsqqFKGKiUCzuP+qUH+JL1HkWLuwbtNGN+rHgjmJq53MDIgJS2ffim4mIlw01KGK7ckMbVlF/djbakROApDSHdrUHpbY5qR9vWSRj4rFjg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de6d3bd-885d-46f3-da2d-08d584b2b6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:20.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index 994fc5caf036..79fb6a4f661f 100644
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
