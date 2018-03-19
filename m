Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521481179-2-16993658201538717661
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
    t=1521481178; b=XXGfaLSKRjIbIEUw40S8lHafy+rzTxDGz4b+p0iNLkbAK2H
    y+G2IMcS2itQNTDY9KQRsJK/7thoxWbnABou8dvtY4jFaeYvn0yvDb15PqkcyA25
    YbUzd9BGC2IExSrDIyjfaZuBiV7bt2+SE+X87n1TguyOCAL//j0Sj8UEHXKVi3MC
    +uLuSyssj6netBgmrXRVwm2BVTP8urOKoC8/ZJRUL0qGOIbE9paPTTRrVOlBWiBu
    zNUfBG/oca2swVThtq1inPWAwHe/aUZhEXynfpsHeRsdGBFPQVfFWkBcMc8med8L
    kexUwQx19bOMJtaQ2V3OGjBx+npFsTQJXKwt3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481178; bh=tpdgCx
    mtAceIB26kXtXHPhWL4H4JmCSzMclPi4qKeJk=; b=bBzy+VYlunYFaTgA6TM3MN
    YLvjWcmOZFdrkc8nxU2CO1s09b0IP1iHQqf9gdghtPcg6WtFr0DLX46dfT18hfny
    B4AgdSeQKAMF8XSKZrhvuFeKbvkrLx6vaC87g7keesHOWFZOnbwKoEJuNZukVS8N
    d9KaJCVnCnK7JjmPFas9w6IG+ieQeKK06lMkdjwz/KZypwsi5/FsT3ud4GSBVE0R
    mE7l8m3eE8mICLK/blVUgCU1Edbg3eCUC2siUqATECJ9WsBCfY8INzCnh+Xkr9Fj
    /8EBBTRJ0KoSj4JaPjr1MK3Gd5EHB3hNqiXvpfKp0AjbNrE8l7JsL2F14xdJJ7ZQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RAJ9X/uJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfeeivdenucevlhhushhtvghrufhiiigvpeduge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RAJ9X/uJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfeeivdenucevlhhushhtvghrufhiiigvpeduge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966016AbeCSRix (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:38:53 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:28800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965963AbeCSQGl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Julia Cartwright <julia@ni.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 002/167] md/raid5: make use of spin_lock_irq
 over local_irq_disable + spin_lock
Thread-Topic: [PATCH AUTOSEL for 4.4 002/167] md/raid5: make use of
 spin_lock_irq over local_irq_disable + spin_lock
Thread-Index: AQHTv5wUA5j6AUp/bEimVjMaS8LAAg==
Date: Mon, 19 Mar 2018 16:05:21 +0000
Message-ID: <20180319160513.16384-2-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:51iVXe5e6qrY6s2M4ET34pIvyKGuCA6Eoete0em9Mkx6AfeJOTM5PLuwEEQ7i1mn3LibPKXDLUdbeXV9Pf1/pvoj6RY2WMHtB8bN01moeRfGmNcVIVJkOTWKzyavKMll1AAZr3PIe5upGiExZJX4Tt2K7YCYZMw75gTvyXWXrX1vOekBdzCzmKR/GrnYNNglgFrkU+aHMizvnFVipmqSz1ciM8uKIBn7fix3hfe+I4CzBvJNauTC7An5D9ezXJl7;20:vq1FCuSDzbrWwOXPOSG2LCgjR39Rc05cmM6J9enc2LnFautn6gcm38dtJ8Mzq6ScBVgPjOMxCB5ejMFYv8lNAF9QrEXdyBkNedQpMPLVdZDygkOxOC5JoMlphKoa/I6n0uGqIUyeYYTGYXmoXMfXpypsp4+PmhSVOD1Q1Uc/MPE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9517fe7-82f3-496f-8302-08d58db36632
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920376BC678EC83BB095990FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(145744241990776);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(51234002)(189003)(199004)(5890100001)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(4477795004)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: lWMnlA0AADFuFIzOS6rdhCd+RWM8MDwme528rAjjzAejyH7hFGU3psKiNhZ5CL2CDbQLZUa1iTxm3ESOLRVk50hGDeNv3RrVwhPZ3uW/EInZaBmF06jNn64dyd8mRCLPCgkWwbXoWgALldOk3blIfb2r2hsRIueM9ZHrkDMQahjSXKEAFCggw/fiQXRi3IP05tvoy0X+IVz93tSQCyqeKeVneYYUwAoTrK0zyr9bTxWixntBj0uLlJAZDd/qc9TVDARXr2lM6K55pxdcB0h7kfaAHlxeTc8SSusZS5SbvQ5imEKlJQc9MqcWTOx5zMAKK/EWKiA7Vju3j7z2yfOEuA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9517fe7-82f3-496f-8302-08d58db36632
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:21.2646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Julia Cartwright <julia@ni.com>

[ Upstream commit 3d05f3aed5d721c2c77d20288c29ab26c6193ed5 ]

On mainline, there is no functional difference, just less code, and
symmetric lock/unlock paths.

On PREEMPT_RT builds, this fixes the following warning, seen by
Alexander GQ Gerasiov, due to the sleeping nature of spinlocks.

   BUG: sleeping function called from invalid context at kernel/locking/rtm=
utex.c:993
   in_atomic(): 0, irqs_disabled(): 1, pid: 58, name: kworker/u12:1
   CPU: 5 PID: 58 Comm: kworker/u12:1 Tainted: G        W       4.9.20-rt16=
-stand6-686 #1
   Hardware name: Supermicro SYS-5027R-WRF/X9SRW-F, BIOS 3.2a 10/28/2015
   Workqueue: writeback wb_workfn (flush-253:0)
   Call Trace:
    dump_stack+0x47/0x68
    ? migrate_enable+0x4a/0xf0
    ___might_sleep+0x101/0x180
    rt_spin_lock+0x17/0x40
    add_stripe_bio+0x4e3/0x6c0 [raid456]
    ? preempt_count_add+0x42/0xb0
    raid5_make_request+0x737/0xdd0 [raid456]

Reported-by: Alexander GQ Gerasiov <gq@redlab-i.ru>
Tested-by: Alexander GQ Gerasiov <gq@redlab-i.ru>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/raid5.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 86ab6d14d782..0feffd3e29e7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -110,8 +110,7 @@ static inline void unlock_device_hash_lock(struct r5con=
f *conf, int hash)
 static inline void lock_all_device_hash_locks_irq(struct r5conf *conf)
 {
 	int i;
-	local_irq_disable();
-	spin_lock(conf->hash_locks);
+	spin_lock_irq(conf->hash_locks);
 	for (i =3D 1; i < NR_STRIPE_HASH_LOCKS; i++)
 		spin_lock_nest_lock(conf->hash_locks + i, conf->hash_locks);
 	spin_lock(&conf->device_lock);
@@ -121,9 +120,9 @@ static inline void unlock_all_device_hash_locks_irq(str=
uct r5conf *conf)
 {
 	int i;
 	spin_unlock(&conf->device_lock);
-	for (i =3D NR_STRIPE_HASH_LOCKS; i; i--)
-		spin_unlock(conf->hash_locks + i - 1);
-	local_irq_enable();
+	for (i =3D NR_STRIPE_HASH_LOCKS - 1; i; i--)
+		spin_unlock(conf->hash_locks + i);
+	spin_unlock_irq(conf->hash_locks);
 }
=20
 /* bio's attached to a stripe+device for I/O are linked together in bi_sec=
tor
@@ -726,12 +725,11 @@ static bool is_full_stripe_write(struct stripe_head *=
sh)
=20
 static void lock_two_stripes(struct stripe_head *sh1, struct stripe_head *=
sh2)
 {
-	local_irq_disable();
 	if (sh1 > sh2) {
-		spin_lock(&sh2->stripe_lock);
+		spin_lock_irq(&sh2->stripe_lock);
 		spin_lock_nested(&sh1->stripe_lock, 1);
 	} else {
-		spin_lock(&sh1->stripe_lock);
+		spin_lock_irq(&sh1->stripe_lock);
 		spin_lock_nested(&sh2->stripe_lock, 1);
 	}
 }
@@ -739,8 +737,7 @@ static void lock_two_stripes(struct stripe_head *sh1, s=
truct stripe_head *sh2)
 static void unlock_two_stripes(struct stripe_head *sh1, struct stripe_head=
 *sh2)
 {
 	spin_unlock(&sh1->stripe_lock);
-	spin_unlock(&sh2->stripe_lock);
-	local_irq_enable();
+	spin_unlock_irq(&sh2->stripe_lock);
 }
=20
 /* Only freshly new full stripe normal write stripe can be added to a batc=
h list */
--=20
2.14.1
