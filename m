Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476060-2-17836245125755014717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476060; b=AEGY6vkrjh6f9usjJAig4gPumgz8zd7iosajkzS+NXpw6rY
    zNLjRa9vDd3PLNv4x6s0FfO3zj+fuMEWdpqdB8us1L45a1dIDMAXcyIAaqOgkkkd
    PFlGUe0alW0bsGgUhHdhM4fBFbzHB7PyocfsEFR1+4avAYLeE2Cc85FMCL4pFFaM
    FzCilEKSTRpa+rxstIqfT7ZLqzo44n9dcibOH/zLUQvekLen1dSL7o2goICO4jk4
    yJVf9aJOJrOVQjft3q8HKBl8rDzyW0grPsMTRFa3KVyquUqK3u2Er0xuUq23gEcq
    W4bjaAIRPaQC3NnwRlMNT41oJ0VriwlYKlu8DOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476060; bh=tdpAEt
    CdGp8qxlYP8Ft/UwgybIkLPsB7j69HwgdT+6g=; b=jj3HQP1wo8dBvxceTzshNP
    6utnRvYVZ+RXqX0CfTNAvXDuVe8+PYC5hKG36zBKqmLRitruA0imvbM2oDlMTsIe
    Knj08PFxODzwhMd9zYoomBHsCvoVArwE0hutAUJnDipcUIZ+Icp+1eX0A4t0uUm7
    Rcpyjac2AMXjncmvRMqdQrPFuskR73h41Z7wvAeSjP4wYFzEZTN5luZsAO5w1hdD
    7xdhMvm2jEkBaX+CEZrbo9P54fiieQtBY8nvOHNgUpxsqW49tUnVMvl9024uvPy5
    bn3UHJ82EEZeSLx1JqCtFVXD0IIejhe2ariAxw9T4RS5IK1u6yzgn2DSInmeYj/A
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y75RVfSp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtieeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y75RVfSp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtieeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966937AbeCSQOQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:14:16 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:50448
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966913AbeCSQOK (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 074/102] [media] cx25840: fix unchecked
 return values
Thread-Topic: [PATCH AUTOSEL for 3.18 074/102] [media] cx25840: fix unchecked
 return values
Thread-Index: AQHTv50nN+rhFo/z90KEaaESACKR0w==
Date: Mon, 19 Mar 2018 16:13:02 +0000
Message-ID: <20180319161117.17833-74-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:VRwzGwL5hDaFuDRIb7wZjfKnfuO1AuLfG46b82oG0uEwR5Us44IHy7emTp0Y04iZ2cXKKFuLBusIvJdXCKoVzLYD+5w57oxz51l1DpmAXCD16zGNT/7CamZVZTi+eDTohq8Vh8rbzYKO2E4b+q+PpaaOFBVDJme9PP/vLjJEEDIBSlydjOSdUxdDABpRJx10B4twRJhmJBeAxni0op2d+26j5HGAU4u4haxOaqn9fFMz75Dd0CaUN3eFXG/xSKD7;20:iSzj/VMmroLzV/VwFBnctAc7Z0VhdkMUR0k9P5BK5Qxi0my/Lj2uFe24GFPIzAKREQGE3o2jrxgwIsZxQENvhMoiyBqfOEX0ytuka47ycJA4oLMxNEJ56/gqDYN69vU8+0yJvzUhRazs/v6CclFCXxf00jHtvvR9Dqp1Ys3oNvE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d09947d6-ab70-4eb8-6110-08d58db46e2c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063EE3CFE7F7E47C6EFE1A6FBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: geQdurWAMJ6zs18rlxR7ToGo89j+lMeFxHaUMFQYkPaN9OGcA8isVWJSlVKB0Cs1V01tRAlHZ6HXTmjI+EaVpJJu/J83p1x9I7kw8+mYAhs958WPdmseHzViybKurmolKiAP5FS8LCOVg5hVAuyKf9RrfZdvXjpDMvZRz39ou5MBVjsZTbI33Jzh2n/ZmMbK0Tdp0mkh6bco3Wl//LBqa2DvKZbm0usSji+UYApvQoYE5qNG7vSUkjfQ/52IAWLaOhNNZjYneh9AvR3V2bFvUGFsoTE1RIGa29yXxF2TgDau/ZudrQ+39Iv1mWLLPsnf7jV0hDh/uyGJZRfxDmFL+Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09947d6-ab70-4eb8-6110-08d58db46e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:02.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 35378ce143071c2a6bad4b59a000e9b9f8f6ea67 ]

In functions cx25840_initialize(), cx231xx_initialize(), and
cx23885_initialize(), the return value of create_singlethread_workqueue()
is used without validation. This may result in NULL dereference and cause
kernel crash. This patch fixes it.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/cx25840/cx25840-core.c | 36 +++++++++++++++++++---------=
----
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/cx25840/cx25840-core.c b/drivers/media/i2c/c=
x25840/cx25840-core.c
index e453a3ffe7d1..50255128ec33 100644
--- a/drivers/media/i2c/cx25840/cx25840-core.c
+++ b/drivers/media/i2c/cx25840/cx25840-core.c
@@ -420,11 +420,13 @@ static void cx25840_initialize(struct i2c_client *cli=
ent)
 	INIT_WORK(&state->fw_work, cx25840_work_handler);
 	init_waitqueue_head(&state->fw_wait);
 	q =3D create_singlethread_workqueue("cx25840_fw");
-	prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
-	queue_work(q, &state->fw_work);
-	schedule();
-	finish_wait(&state->fw_wait, &wait);
-	destroy_workqueue(q);
+	if (q) {
+		prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
+		queue_work(q, &state->fw_work);
+		schedule();
+		finish_wait(&state->fw_wait, &wait);
+		destroy_workqueue(q);
+	}
=20
 	/* 6. */
 	cx25840_write(client, 0x115, 0x8c);
@@ -631,11 +633,13 @@ static void cx23885_initialize(struct i2c_client *cli=
ent)
 	INIT_WORK(&state->fw_work, cx25840_work_handler);
 	init_waitqueue_head(&state->fw_wait);
 	q =3D create_singlethread_workqueue("cx25840_fw");
-	prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
-	queue_work(q, &state->fw_work);
-	schedule();
-	finish_wait(&state->fw_wait, &wait);
-	destroy_workqueue(q);
+	if (q) {
+		prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
+		queue_work(q, &state->fw_work);
+		schedule();
+		finish_wait(&state->fw_wait, &wait);
+		destroy_workqueue(q);
+	}
=20
 	/* Call the cx23888 specific std setup func, we no longer rely on
 	 * the generic cx24840 func.
@@ -746,11 +750,13 @@ static void cx231xx_initialize(struct i2c_client *cli=
ent)
 	INIT_WORK(&state->fw_work, cx25840_work_handler);
 	init_waitqueue_head(&state->fw_wait);
 	q =3D create_singlethread_workqueue("cx25840_fw");
-	prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
-	queue_work(q, &state->fw_work);
-	schedule();
-	finish_wait(&state->fw_wait, &wait);
-	destroy_workqueue(q);
+	if (q) {
+		prepare_to_wait(&state->fw_wait, &wait, TASK_UNINTERRUPTIBLE);
+		queue_work(q, &state->fw_work);
+		schedule();
+		finish_wait(&state->fw_wait, &wait);
+		destroy_workqueue(q);
+	}
=20
 	cx25840_std_setup(client);
=20
--=20
2.14.1
