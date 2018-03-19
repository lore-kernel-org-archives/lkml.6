Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482309-2-11528854455731258329
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
    t=1521482309; b=p2aHAX6oobNTs6XYVxW9tCvvGfOELbapiaLrP4f6NltNh1s
    pYpGBBvDP88lE8Lpti818GV15COvXpANbKn/0P2vd1newNxPjs0WcbPhCPgqPNcx
    gDO1mvEUIVH24ZSGLyFi5ohmfMmzMm/KTTqMuEIlTDezewnSTFGEXsyZfc9zod+k
    jzUUKfTyfV2JWmPexLWCFRKc2GsHHxLki7J1LF3/UZoZ+GhUeMkz3ph/CAwRrLfe
    exBx6MoN9AFMVoNjbii7SVs4eW8ndfIFAx327G1aXI7znaRYFDf2sKFN7nQE2Ikd
    jiamLleloDLnuXPWBd7rlR28JKZcvruNwQGebEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482309; bh=7gXwgp
    W7T0NUlqkTNXUJpzvFirLbwEDEjmjiUBe4tV8=; b=pbaiOtflGBj14B6FuYv4GA
    k68JUptjrvJymO4urFlX4J/oS3UiPr57pooU5HglauURdRXGYt087Ad0rEfDUuQ2
    K1sIai+81USlGV1mtsI5lJzpTObS0R2/MBH/NB1vDHll75RSXQfcgXrmSztA4VPS
    5T8ZZ//cWtSIs0DCKS8tfoEu29YBS+C2ipWmxRpkuczjYW8CJmA+qLSPBpIXpnFm
    v8dsmJSRu2TVH85glkvlAvt/dFdmdpaQXb3RSGC8j37J9Ri2O4gjjd9glZdE9H1w
    O2kJvdlM9PKoBa5kVGeBoS0rN1CBpcrq4VJgMJIat2Bct2gE/xBKFUirZiGct4fw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aar1PeKx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltdejfeenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aar1PeKx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeltdejfeenucevlhhushhtvghrufhiiigvpedvvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965895AbeCSR5k (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:57:40 -0400
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:9760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965676AbeCSQEm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 213/281] [media] cx25840: fix unchecked return
 values
Thread-Topic: [PATCH AUTOSEL for 4.9 213/281] [media] cx25840: fix unchecked
 return values
Thread-Index: AQHTv5ug35WnOgKc8EyFFRfsyo16tQ==
Date: Mon, 19 Mar 2018 16:02:05 +0000
Message-ID: <20180319155742.13731-213-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:PAMu85mDA6gDgdsz1W+I3q8TzLbK//h0Qdo1CGCvY/QPCwSB/t/3qsBr5Z7FqK4YcAUn8PnK6LZrj3vjNumvNW0ufxHwL1u32b3Z6aW5l1vz66Pfk9Evw/Hg0zmGNU3z7JGQbDaBYs+xJ84TfwAH+qwbK68hz7zR+UcsuS5457z2rXP8ixnal62lEc6ZYm0NB4yYUqDTBEaSTQuxDD3KQuNt+NKz+mfh5nJa4iqsCy2nDDIF5J6ffbkirbGGbqh8;20:Mkzf352c4HjZZK4VsG/CEwtZlmBsC3CjoErv+5ASbJyL8HVhMDCk3TUjJozZoSK6Ss/w7Op2LfhQUwm+v2bYj3WQjtsRraPw0dwxlBlsYnHFqDdUzBV6dKwUw54YA0WFdL+gMuiDi8S/XWzrNIkOBt+JGf5tSGwtP10DQrpXzjg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5e1d08c-449e-41d7-ac92-08d58db31c1b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10775ABCCFE052C44BF5C3C5FBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bIjk8YPcLR/NEFT5GSaBGY/gkP54k+6YrhWhz0UvE/qmeaa3Slmnxmj5uXG7UCb/D3PqjewKJliFRTSH7HBBuMvz8GYHU9MkfT+sOArqIdqHEHeNu1zOCn7De5r4KgLrW+lvEQg2w3/qQxv0vQ3uYQtD3/QM6aLSaWo0PUw4k2c8YQuJRsy4teRGLKNZx2s9ikPHoasEVohNR/dFeplzJW0LziyBMYqywUOJbXHxmiywnwPpyPJeWlPwHQu6uoP39W+dZaYP3mfRs+2Cl/hjRSQZ+HAyqCon9y0oHqbUgPnKh0bC0Y7pN/mOK+2lq8zQdOOC2XUEGm1sEBASOwhs8A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e1d08c-449e-41d7-ac92-08d58db31c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:05.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
index 142ae28803bb..d558ed3e59c6 100644
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
@@ -634,11 +636,13 @@ static void cx23885_initialize(struct i2c_client *cli=
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
@@ -752,11 +756,13 @@ static void cx231xx_initialize(struct i2c_client *cli=
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
