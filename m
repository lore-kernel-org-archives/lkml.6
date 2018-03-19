Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479334-2-1727064585878863205
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
    t=1521479333; b=P9X4ZVzb9uJQf9Y8d0oYDQkwwTkexD6TVRH6YuLE8rDs7y8
    Q//W0YpsKB1gM1Fh8KgODoLxhA9iks1+v69rH+xRiLHjA0wzycBkcLk4OO58HKGR
    lQvF6gE5XpMXkfJk6itARH0u9wpavobjmPk5pI1880kEbdHhkmjmw/EcCQS2z1H0
    qzhVDxfpZjUzjytrQoM99slB97h/j/tdT7rep0tuFlL4meVJZO++p18C+oePwAgc
    RuWUOk3k8Hg1BDOQJ6wkAuX5yklHUgGvcuLT8r8CGKnn/gVNbgEWW8/2WB1P4cMN
    +qT1cvcvubGz4sySzwZo+7hj2geEwhxK+X1M/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479333; bh=5CMSZi
    FkhOsgGi0+CglZ+Uwy/vspFIssocwjmZo+Ae0=; b=ZNup7X4+V1vk6mhNBfiaDy
    xz6YDpBorXg23nTIQPOAqCZaBnT1syN451AJfPz0w7niVd1LlFpJj5wnuz7CWmVB
    eP02mOtsTIIUAHj+WdCoNChtzm5kxMfeFyUNh+7XfaJHnEkXsWCFEXKpMQ3hDMCZ
    cW0dwqJAZ+1m6sk/dhUY6eJFhNDH22Au/Ms93tzndww/wms1reg8K4bf2i0oiq8X
    seDN8I8gBMi8oaJEoWwZ1VAPFebu/dZYd7bHv1DMXeJsftn+Tdkuv5stfSeSgUOC
    agf9Fzl5x1cH8C84a0r1FOfnc+AFSAR7ai+fZsrsYnyEmE0szUvfWZfys/PPZ87A
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jar8loZB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtjeegnecuvehluhhsthgvrhfuihiivgepgedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Jar8loZB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledtjeegnecuvehluhhsthgvrhfuihiivgepgedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964999AbeCSRIs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:08:48 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:62326
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966441AbeCSQKp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 129/167] [media] cx25840: fix unchecked return
 values
Thread-Topic: [PATCH AUTOSEL for 4.4 129/167] [media] cx25840: fix unchecked
 return values
Thread-Index: AQHTv5x2aaz2LDmAO0q22XWefdorFQ==
Date: Mon, 19 Mar 2018 16:08:04 +0000
Message-ID: <20180319160513.16384-129-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:6MHsFTJy9ZjXUml8kMur3SEd0hd+wEfbOi7yQ+DTsZrGE7coyEGAPCNBcDJfDiK4+zQbwIPIUw4f/x24t/ySNQGmonXul5OZRqjfl+ZkxVBa9GlgYEpEDd+xokOJ9g+yXMwv4/BSZ5RKZnEdJaB5KesTMW+EIjXjNKLSWy/RlKqQtnGO1YHlRck7YpubMv8Nz2vp0P/htMS8TCCC9MRX4Ph8agbBwR6SNy5+boV6VR7Nk6RVoRFzLP8n/ofLSGDM;20:NjQtuz40+d/LejTBoxX6H+PxIJP05ej2cZcPd803Z8TkHdEPZHEjqLUye8GjPSs+PtE1lwdw6d9pl0AFWZsOk6gMe0L2B/HQcyk1EbfOkq0hzF6LJy7/I16GX4AUjJksAJhEXZIY2WlLvuQgpl/Jfw11AAb5xQDoR7TnktA+WzI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d95b2c7-9234-4e85-2f39-08d58db3f450
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045733DC4431F2CDA7F66AEFBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(102836004)(8936002)(6512007)(7736002)(3280700002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(2906002)(14454004)(81166006)(316002)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: mev/pa3dGdL70R3i2/PTKftJtzy60S6PwbElR/i4oPck9oS+JDX7pDOboJOUxW4W5wIV2n8GXhv6/ZM25aW7CMtj8Ha3zA7E56/HMkGSvNXyfyO7TnqbngAZcMV5ApQOwUAaspWXcxzSrOKP0cc/uCWDxGO7NChMU/P8ZWV5j45JnTqxuiPkxUiqSqDbdzNEImGk3BHUmROLSHjtFfh094UBmSCGl5v6mxtlKxkuqPaL5UKpnXab277WctBrOyG4U00tY0qUs0jmQSPSAHhADo5HhwwXOkKCua04l+l356t/MVm+2rESBMcCd4UG2xRvoycgMer/QQ5lC7SpF+LwtA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d95b2c7-9234-4e85-2f39-08d58db3f450
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:04.1751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
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
index fe6eb78b6914..a47ab1947cc4 100644
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
