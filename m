Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682210-2-14409783827600677167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682210; b=H6vE4qsgZcXKcAGZivxqD6T/EP3e+vZ0dkKoXcz9lDw03fo
    524hWx/7ninUdEJ5ptKTfBgf+85LZcq1/xGftyhm7LAVPpU8Ec1xvuODtFDblz6r
    NYbndLXBEjrm0NfBRWlKMmsV3aVIh6N34S/sPumMasAUmUpivqzH69FkZRIzYit9
    tC6xpvmI0hx0PNreHkXDC79uHfpoiGne5VatZ5fs8kFJzQW3Zt7g+Z/Js7dYVJzJ
    6ozYuc9lxqtZvZJiqiKwIcKJ8ljNCmvLa8ta5ayRw6AYAR9hHZ+PQ7fg1oURm34K
    +jjEFEZSxD3rpiwcrsBv/n+kQu0BTIKjNjEjZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682210; bh=/vWGuQ
    aHwNPoh/VDEzXtP+O0RlyAK58LC5AeISii3So=; b=TBMPedhwAH58qgvPUjoLG+
    DKg4uscDqIsASlnxDk6dAkGglDyj2afclc0YLr+nGPvyynd5FUG1eRHNN+m3+gD4
    vowwmo4ArSUywadmx7L+WDW0mkYILTuf3rwFRUrj9NNAJmQW0h7WrX/5Cwku7Vfa
    a1hvfQXUuW0ZDbLBbywWaXMbZ5ZyPerFC0lv4TJr8yTSBB2uOwnQSFAgMQ8CRoER
    SktRZ1KyKlVii/07NeJa0HRjqkwoCxKDLYcDoMp+w9h7NXZ/eU9ytMTNWZ0MxcUQ
    MP2BsJJ78vt7sAFRUwCDnAzyeoY3wK6F/uRlvsYqQ/4FuRQ+bK2kMvtCLZTtJMUg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A4wgXX+w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A4wgXX+w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeBCSXW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:23:22 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753458AbeBCSG2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        Glauber Costa <glauber@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 03/24] mm,vmscan: Make unregister_shrinker()
 no-op if register_shrinker() failed.
Thread-Topic: [PATCH AUTOSEL for 3.18 03/24] mm,vmscan: Make
 unregister_shrinker() no-op if register_shrinker() failed.
Thread-Index: AQHTnRmAg+TATo75CE2U9F02oe3Q5Q==
Date: Sat, 3 Feb 2018 18:04:58 +0000
Message-ID: <20180203180444.10801-3-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;6:hfQ2pTZU20k3abGWYsCQ5Ezj14oRuFsXaPNzZWOcbRwOfifPZP/tTJigc6nMIcAdew/JukG5F/FJKtcD+lu2+F3BWtY0Syleu3COQoBp9Ck97a+YGTWEIXX8g4DAZpG0Dh2AVMKhIYhLTAWJY3pJZd6EFFEjNivLsvXPlw4WYMo4wnsmddNWj4HzN3MY+rhUfHW8ANQs2o7IyrK18kwMydhC9+H4GQOjMqBcnMkPcdQxWOwEg1ITtiyLwq83QmVgL+LgY5cq0g1vPvIqgkNM9v0/F72Ma6t6SwDste+Fybyi0BYanekAwYPNn5QtzTJQ9Sm0NDUMzGaTyYh+A5mOZDRzhBXobm4EV1MLMG3kQseWlqo5ECWQUFfhiWCaWZQK;5:szGY4kctiMPpFYhAXhHrH3ooFvhU5HaDjsRIBYRPvM0fwi2lcvgRvDUEVuIrhrppYePJJyEJ4N6V5+DVfp/QxWzgw7RdkpGNr7DfchS6Y/VEvPCUl9VJACYCk7PZU3SzSYA31NjMBsQgPFc2JjNVf5T3G61NDcgC7z/EzekBwSM=;24:a2f/Jgrfv6Weka9Ha/qVx8d4Olq9QhVAGvZnpq4RMzRarsRZdYqKezcgBnpqJnNJCk16bLQ3hZIRQEQ12J6ewyKi+DKwhkI/pPX9Z9OibeU=;7:Q6Sk7hq6uOZzZX2/+dW1h7idBDx9DB02F9imzqC9ahSKd/ijx6onb6/+0M3vlDpDB+hocb49wF+RSO+RGYsDa4Ikjf/YmnhtkfuYC3gaFz1peBUf9Nd1YvqSS+xiI742wfaYnfWkr1UiBPKTsZZuI97pL/UT31Apsfd8J71XdX5uQcJaDXMKeGLmMf1WUaBmeS6KI3JdGWeVL99lz66wmrlUaVit1R4WlJTI712OBGmDFJw5cqc4ZopMMmCqwm5r
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24ec440c-9548-46c6-f64b-08d56b30cad1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993C01EC267DFD59140854CFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(215639381216008)(274141268393343)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: x4VkcvIn6Z4uPwHp15RY/0qLHrMplrGq/w292qd8fcvmV30C38wvDQm1LiFFuW5+PixUVuavP3lnlma5URFvQw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ec440c-9548-46c6-f64b-08d56b30cad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:58.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit bb422a738f6566f7439cd347d54e321e4fe92a9f ]

Syzbot caught an oops at unregister_shrinker() because combination of
commit 1d3d4437eae1bb29 ("vmscan: per-node deferred work") and fault
injection made register_shrinker() fail and the caller of
register_shrinker() did not check for failure.

----------
[  554.881422] FAULT_INJECTION: forcing a failure.
[  554.881422] name failslab, interval 1, probability 0, space 0, times 0
[  554.881438] CPU: 1 PID: 13231 Comm: syz-executor1 Not tainted 4.14.0-rc8=
+ #82
[  554.881443] Hardware name: Google Google Compute Engine/Google Compute E=
ngine, BIOS Google 01/01/2011
[  554.881445] Call Trace:
[  554.881459]  dump_stack+0x194/0x257
[  554.881474]  ? arch_local_irq_restore+0x53/0x53
[  554.881486]  ? find_held_lock+0x35/0x1d0
[  554.881507]  should_fail+0x8c0/0xa40
[  554.881522]  ? fault_create_debugfs_attr+0x1f0/0x1f0
[  554.881537]  ? check_noncircular+0x20/0x20
[  554.881546]  ? find_next_zero_bit+0x2c/0x40
[  554.881560]  ? ida_get_new_above+0x421/0x9d0
[  554.881577]  ? find_held_lock+0x35/0x1d0
[  554.881594]  ? __lock_is_held+0xb6/0x140
[  554.881628]  ? check_same_owner+0x320/0x320
[  554.881634]  ? lock_downgrade+0x990/0x990
[  554.881649]  ? find_held_lock+0x35/0x1d0
[  554.881672]  should_failslab+0xec/0x120
[  554.881684]  __kmalloc+0x63/0x760
[  554.881692]  ? lock_downgrade+0x990/0x990
[  554.881712]  ? register_shrinker+0x10e/0x2d0
[  554.881721]  ? trace_event_raw_event_module_request+0x320/0x320
[  554.881737]  register_shrinker+0x10e/0x2d0
[  554.881747]  ? prepare_kswapd_sleep+0x1f0/0x1f0
[  554.881755]  ? _down_write_nest_lock+0x120/0x120
[  554.881765]  ? memcpy+0x45/0x50
[  554.881785]  sget_userns+0xbcd/0xe20
(...snipped...)
[  554.898693] kasan: CONFIG_KASAN_INLINE enabled
[  554.898724] kasan: GPF could be caused by NULL-ptr deref or user memory =
access
[  554.898732] general protection fault: 0000 [#1] SMP KASAN
[  554.898737] Dumping ftrace buffer:
[  554.898741]    (ftrace buffer empty)
[  554.898743] Modules linked in:
[  554.898752] CPU: 1 PID: 13231 Comm: syz-executor1 Not tainted 4.14.0-rc8=
+ #82
[  554.898755] Hardware name: Google Google Compute Engine/Google Compute E=
ngine, BIOS Google 01/01/2011
[  554.898760] task: ffff8801d1dbe5c0 task.stack: ffff8801c9e38000
[  554.898772] RIP: 0010:__list_del_entry_valid+0x7e/0x150
[  554.898775] RSP: 0018:ffff8801c9e3f108 EFLAGS: 00010246
[  554.898780] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  554.898784] RDX: 0000000000000000 RSI: ffff8801c53c6f98 RDI: ffff8801c53=
c6fa0
[  554.898788] RBP: ffff8801c9e3f120 R08: 1ffff100393c7d55 R09: 00000000000=
00004
[  554.898791] R10: ffff8801c9e3ef70 R11: 0000000000000000 R12: 00000000000=
00000
[  554.898795] R13: dffffc0000000000 R14: 1ffff100393c7e45 R15: ffff8801c53=
c6f98
[  554.898800] FS:  0000000000000000(0000) GS:ffff8801db300000(0000) knlGS:=
0000000000000000
[  554.898804] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  554.898807] CR2: 00000000dbc23000 CR3: 00000001c7269000 CR4: 00000000001=
406e0
[  554.898813] DR0: 0000000020000000 DR1: 0000000020000000 DR2: 00000000000=
00000
[  554.898816] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00600
[  554.898818] Call Trace:
[  554.898828]  unregister_shrinker+0x79/0x300
[  554.898837]  ? perf_trace_mm_vmscan_writepage+0x750/0x750
[  554.898844]  ? down_write+0x87/0x120
[  554.898851]  ? deactivate_super+0x139/0x1b0
[  554.898857]  ? down_read+0x150/0x150
[  554.898864]  ? check_same_owner+0x320/0x320
[  554.898875]  deactivate_locked_super+0x64/0xd0
[  554.898883]  deactivate_super+0x141/0x1b0
----------

Since allowing register_shrinker() callers to call unregister_shrinker()
when register_shrinker() failed can simplify error recovery path, this
patch makes unregister_shrinker() no-op when register_shrinker() failed.
Also, reset shrinker->nr_deferred in case unregister_shrinker() was
by error called twice.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Glauber Costa <glauber@scylladb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 mm/vmscan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d48b28219edf..6d652990433a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -220,10 +220,13 @@ EXPORT_SYMBOL(register_shrinker);
  */
 void unregister_shrinker(struct shrinker *shrinker)
 {
+	if (!shrinker->nr_deferred)
+		return;
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
 	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred =3D NULL;
 }
 EXPORT_SYMBOL(unregister_shrinker);
=20
--=20
2.11.0
