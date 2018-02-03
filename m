Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683274-2-16772047419862377892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683274; b=CG82nxGXU/ZBnnegZ2N6xLB3dF/EZxLqdljMQ5D1TTsYWJc
    WftoPeOerzMloWRzJpr9YnMw+Vy6ECG1p2coYwMNHtaSHCRBwZy3+J20qjCtKoDA
    7F6b9yugB3jKL1tPH9xZIVyI+PENXWsZbdD4YaRBB7H8/zHUd7uc6w3h6U2ZUTcZ
    0tGVv27Hre8Er1rB//Eqej/VpjYycZvCaCQ1whXYv2FUSgRV+Xe7q8cEj3ALt+Gr
    440IqQJtFMPppwiOw/2kKXzgB5wn5rVr5bfbgh5BxuY74syYghVnq5XsxNIvkAeO
    npK0j92Pmm/1OimhcupVAYHXvodLCpj2rI523pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683274; bh=bhgs00
    KDmlibodSWOvEcVSOaZdgHFWjcmgpcy6oP6xo=; b=eMz8E6/i7+Vq6KvN/haw3r
    /i9yMtGpPEI+OQmoKv9BydfvDJHRXCYFCPMvfC3O9OPYBi8uOBhCrImRynakOu1o
    5CJvrjqQ6q0m/t+/+m5nwCXbj3ffQ1I/1us0YhNdoXBYWo29YE9XFlDALI/qMykM
    Ut7bkqY9Ekmv+xFpj0N3q9UU3+uaufTpId9LlESEZo4ZldX8S5v6R+tv/bDPE/I4
    zLzOfXlIMjqDPCMPpcflXlIsKeSQ6l14oZDqhpvPZGVLPS5DZZ6fdmtBrWiaNnLZ
    wlh8IzxDHMK67p5E0DQokcgxykjiAxaqxuySQ36MlPXmMuj5dFaV07EIFpcdqypQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b7BlSDhC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b7BlSDhC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeBCSDV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:03:21 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:1354
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752538AbeBCSCG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tommi Rantala <tommi.t.rantala@nokia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 060/110] tipc: fix tipc_mon_delete() oops in
 tipc_enable_bearer() error path
Thread-Topic: [PATCH AUTOSEL for 4.14 060/110] tipc: fix tipc_mon_delete()
 oops in tipc_enable_bearer() error path
Thread-Index: AQHTnRjx0Z8LVjw9Qky6y03P+tKyvQ==
Date: Sat, 3 Feb 2018 18:00:57 +0000
Message-ID: <20180203180015.29073-60-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:J1MnC6rQFx2b3SkRsAPEskcNfFEOm9s/xAEln/pXPxaravkldWfHK1pLvu7z6CfQ1vtCYGn6W87DpT00v2JafS1DpWqKw4ePQXjx8SqCi7jTpehfr4SGZ6ZwJF9VdwjHXvYWiNIvX488kTz0ZwWQUYtfAdJ3w4wjCWJqNzSFV3UeG8UEPcpMb3yAHMVxxW04sgtqOggmh5r3UQVccrc9HnrxkaT0vtsw+kHR59D8zzhL5x6004Ey3A5AL1VA9Ak/
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29b9fa2a-ff7d-4969-295d-08d56b302855
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB11059FAED381BAE969AA68AFFBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(28532068793085)(89211679590171)(82608151540597);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8656006)(8676002)(110136005)(575784001)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: bvZBQ+LnxNuhtk/3Z8ZSIS75VOQeAhNevtUcYsG71DIXPmh2jgrYm0X85PRpIEsl1FtVv5m8TCqgZmUKgaikLw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b9fa2a-ff7d-4969-295d-08d56b302855
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:57.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tommi Rantala <tommi.t.rantala@nokia.com>

[ Upstream commit 642a8439ddd8423b92f2e71960afe21ee1f66bb6 ]

Calling tipc_mon_delete() before the monitor has been created will oops.
This can happen in tipc_enable_bearer() error path if tipc_disc_create()
fails.

[   48.589074] BUG: unable to handle kernel paging request at 0000000000001=
008
[   48.590266] IP: tipc_mon_delete+0xea/0x270 [tipc]
[   48.591223] PGD 1e60c5067 P4D 1e60c5067 PUD 1eb0cf067 PMD 0
[   48.592230] Oops: 0000 [#1] SMP KASAN
[   48.595610] CPU: 5 PID: 1199 Comm: tipc Tainted: G    B            4.15.=
0-rc4-pc64-dirty #5
[   48.597176] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-2.fc27 04/01/2014
[   48.598489] RIP: 0010:tipc_mon_delete+0xea/0x270 [tipc]
[   48.599347] RSP: 0018:ffff8801d827f668 EFLAGS: 00010282
[   48.600705] RAX: ffff8801ee813f00 RBX: 0000000000000204 RCX: 00000000000=
00000
[   48.602183] RDX: 1ffffffff1de6a75 RSI: 0000000000000297 RDI: 00000000000=
00297
[   48.604373] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d=
d1533
[   48.605607] R10: ffffffff8eafbb05 R11: fffffbfff1dd1534 R12: 00000000000=
00050
[   48.607082] R13: dead000000000200 R14: ffffffff8e73f310 R15: 00000000000=
01020
[   48.608228] FS:  00007fc686484800(0000) GS:ffff8801f5540000(0000) knlGS:=
0000000000000000
[   48.610189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.611459] CR2: 0000000000001008 CR3: 00000001dda70002 CR4: 00000000003=
606e0
[   48.612759] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   48.613831] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   48.615038] Call Trace:
[   48.615635]  tipc_enable_bearer+0x415/0x5e0 [tipc]
[   48.620623]  tipc_nl_bearer_enable+0x1ab/0x200 [tipc]
[   48.625118]  genl_family_rcv_msg+0x36b/0x570
[   48.631233]  genl_rcv_msg+0x5a/0xa0
[   48.631867]  netlink_rcv_skb+0x1cc/0x220
[   48.636373]  genl_rcv+0x24/0x40
[   48.637306]  netlink_unicast+0x29c/0x350
[   48.639664]  netlink_sendmsg+0x439/0x590
[   48.642014]  SYSC_sendto+0x199/0x250
[   48.649912]  do_syscall_64+0xfd/0x2c0
[   48.650651]  entry_SYSCALL64_slow_path+0x25/0x25
[   48.651843] RIP: 0033:0x7fc6859848e3
[   48.652539] RSP: 002b:00007ffd25dff938 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[   48.654003] RAX: ffffffffffffffda RBX: 00007ffd25dff990 RCX: 00007fc6859=
848e3
[   48.655303] RDX: 0000000000000054 RSI: 00007ffd25dff990 RDI: 00000000000=
00003
[   48.656512] RBP: 00007ffd25dff980 R08: 00007fc685c35fc0 R09: 00000000000=
0000c
[   48.657697] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000d=
13010
[   48.658840] R13: 00007ffd25e009c0 R14: 0000000000000000 R15: 00000000000=
00000
[   48.662972] RIP: tipc_mon_delete+0xea/0x270 [tipc] RSP: ffff8801d827f668
[   48.664073] CR2: 0000000000001008
[   48.664576] ---[ end trace e811818d54d5ce88 ]---

Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/tipc/monitor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 9e109bb1a207..0fcfb3916dcf 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -633,9 +633,13 @@ void tipc_mon_delete(struct net *net, int bearer_id)
 {
 	struct tipc_net *tn =3D tipc_net(net);
 	struct tipc_monitor *mon =3D tipc_monitor(net, bearer_id);
-	struct tipc_peer *self =3D get_self(net, bearer_id);
+	struct tipc_peer *self;
 	struct tipc_peer *peer, *tmp;
=20
+	if (!mon)
+		return;
+
+	self =3D get_self(net, bearer_id);
 	write_lock_bh(&mon->lock);
 	tn->monitors[bearer_id] =3D NULL;
 	list_for_each_entry_safe(peer, tmp, &self->list, list) {
--=20
2.11.0
