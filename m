Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521496327-2-6389485085763709852
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
    t=1521496326; b=TJgkBpHTYraYSWr69uQgZhPbvwRjL8UmsC747HEmbpmj2/7
    WBoGB3lSo0tXLvd7jcOI+cbJdVTQ5/LzN2TMGNdBh55vrrcfnkfsaaDCkTUgfmr4
    jwj/UDv6Fai0BIHd5rIlj2KyMjdyV1D7pdtigQ71Syn9rViPtpSBeoyu40MRG8w3
    bUR1gtdBywEosm9kMoZaBZB1zWmt57GTHGTQ12SEwlTUNWi580yp5mr9fDoNb14p
    FTBnN09YDeHNabeuBdY/bHMKgqMhRctvPhUWdBJCSMxilrUjKT2R7M1EhgpaEe6S
    rFI71bHDNjQW4TqXa4peYbMShCjlZQsZbJDybYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496326; bh=W2u7mL
    Fr6T0Ix5/8qdcNCIyzzdxXm4f+BDYdwxzpeE4=; b=w/vK2l0tP5Oz98k8MTdxhR
    7yPyykt8vig1st28ttbLI9JydEGRZlNL5spb2N93IVN4R9C85etGv1ib0NaQvaQW
    fXlxZMXcNFdRybt4mda/jcU4ZJKgTFtdfEBNBN1uEgcgwo66FYVT52/CviKzojYh
    rNsp6tEtH/XewTpwWI0mgzOa0rfrej5Kt/xqfStMpW9XCzv7zRTNI0FEjGMpTIwu
    HJvgbRw6TERryo4Vm/Fo378+FrCqP+KnNzCFfbwBcrjHMK2cgFb9Y9gBPPYHUTwc
    pGJc0hgn/KiFoAoYASRhvZkT5CWGpIoJGx4jpjTc74bcQsQmvnRPgTAq0q0sTLew
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L6tF7E6c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfeehgeenucevlhhushhtvghrufhiiigvpedutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L6tF7E6c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelfeehgeenucevlhhushhtvghrufhiiigvpedutd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934150AbeCSVwC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:52:02 -0400
Received: from mail-cys01nam02on0133.outbound.protection.outlook.com ([104.47.37.133]:20864
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934735AbeCSP5x (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:57:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Julia Cartwright <julia@ni.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 003/281] md/raid5: make use of spin_lock_irq
 over local_irq_disable + spin_lock
Thread-Topic: [PATCH AUTOSEL for 4.9 003/281] md/raid5: make use of
 spin_lock_irq over local_irq_disable + spin_lock
Thread-Index: AQHTv5sIwF6EWhsavEasuXAX7E4PJA==
Date: Mon, 19 Mar 2018 15:57:51 +0000
Message-ID: <20180319155742.13731-3-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:xxOteRG6kTL/jNm51d0w4EYBMeJp6a1MFz91KjQUp2/Z45og/Qo9xy3qGu5u2ZEJSM9Z0AV76Rk632dXluPX2IRxnN5tg2PJApSTB3EpC49p5LLr+OwPeySU7fKCvGUBs+maCOhl7r+b9oCPEGCob5HZfuKo+FCsAOe+B9N5lVm68tpZ2VhB21ZPyiJdcCZtoERyLP40R5PdwvjxEwtoFritoUYTZLJ/DYVRZYaCBLRoBCnM4aTPqCV8kX/ZU4UZ;20:XpGmOKQwEe4gNtHeTqxfO9umfS1hribA5zyNY6dBuZWCoDnK9n8Awwfg8IkfmWjJzdQFzKZC3RCX8K1K0EdzHC+IEbQGJBU2e8FU2CFVZ5tnSbNOes1h9hK2pnEZ1BAVjA+MJmG/0955LSt4B3+pvyCXvv9GvAHhgg+5GuGu0LY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6857327-305b-45f1-d301-08d58db22b67
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1096FBE4D42AB7D96F0CDD3FFBD40@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484)(145744241990776);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(39380400002)(189003)(51234002)(199004)(86612001)(316002)(26005)(72206003)(4326008)(25786009)(110136005)(10290500003)(86362001)(54906003)(59450400001)(14454004)(53936002)(36756003)(107886003)(3280700002)(22452003)(6506007)(5660300001)(68736007)(186003)(99286004)(478600001)(76176011)(10090500001)(102836004)(2950100002)(6116002)(5250100002)(2501003)(5890100001)(97736004)(3660700001)(106356001)(4477795004)(81156014)(81166006)(8936002)(8676002)(7736002)(305945005)(2900100001)(105586002)(3846002)(1076002)(2906002)(6436002)(66066001)(6512007)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uZ+rjW5lZf7VZrZnl1Bo5lkGElO+HKjloCr8gkEZXzRQVOLMVol9rSXFir3WoXcOHuE0ZcrEQ22YwU/h/VU3AUE7ZGDCewwjc3xGhP9WqFOD7m5d1C9AkaQgvvrIRq0bXi486a2RJId9W59Rhi0qwW/qqi6IUtzvIrv0qrVv2elecEMdgam+M41pb/Rn5MQiFbjgCzOdTCVJyjvMvIF/hCxMnh55kQTXAo3GhovS6jRjeEun5RE190sMgxo7jWgrdhA6MipjAk2rAFQNKvb9Vl1TIxDld/zkXUUDCi3mVd4pig+LPRiBbtykpVoMdrGB/5FjFGqY4pQsl4LAzmwfZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6857327-305b-45f1-d301-08d58db22b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:57:51.3441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
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
index 475a7a1bcfe0..d4f82854207b 100644
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
@@ -732,12 +731,11 @@ static bool is_full_stripe_write(struct stripe_head *=
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
@@ -745,8 +743,7 @@ static void lock_two_stripes(struct stripe_head *sh1, s=
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
