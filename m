Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117755-2-1118028978169317171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117755; b=dARHMMEfzWC2fYhRkgBf2rgp3DUNfggcCbtsG+RybmBeyOy
    allf39L9Uesc3gekeawtbu7ad9EPP+NOEdg1U+/lg0zGvHH/Norb2t7/p5OzpFU8
    DvZuEbJkdqEmTM9nVkJomb4Nc/WZLKFO9RG8VNoOSmyUohbEQ3wqesKGwFe+RW8g
    InNTxlGm/CWXoEuCZN7x0ws/T59zoa2tSzKz9VvGxjEbjmu8F+gB4e/L4eD4KV5T
    2TtzX0CZQzhpIekLiHfCYRk5BH1QBYuqnIfVOQJBEnL0HEbCkDkb+h1KK4Q3tifB
    EkmHdcnAAp/Wh22nuliTDjG9w355a26hc3AzUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117755; bh=x7ckiX
    URAmsgvv3UD+MMexR5HfI3/X5U/pFtopSLO6E=; b=KZ6AoIGsWhGe8L7bOU1xRE
    XnbUlW5gbh54lEpPDSrP+dOBmxTxYm+b6PtimMHl4kf+jXcIztMDrD0Dl1gAr/R5
    RkgcHCK5upX1v8e9AcJknoamA0ucW0bZfVbZTIWXbK2pKAyGPeZA1/ol5VoRu6Fv
    si1mB/rOmh3m59tPeE63Y+OEPMG5a7B6oQIbGMkzfx7a/96504FoZ52GTGRK28by
    wO5PLJI30aa4kXP5F5O7GhOewcj04F+xwKA89NZTq6Uxx0LABk9wcTzfVEoCTjQJ
    pmNXKP/3eZpYdMykcRi5RXPo/WN7djrzxC0IS5kAVJnxu13X7VPuK3o4O7EWkQXA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HFUfA5Zo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HFUfA5Zo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934010AbeCCWzv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:55:51 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935361AbeCCWk7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexander Potapenko <glider@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 06/63] selinux: check for address length in
 selinux_socket_bind()
Thread-Topic: [PATCH AUTOSEL for 3.18 06/63] selinux: check for address length
 in selinux_socket_bind()
Thread-Index: AQHTsz+cVdCDNA2NZEmRalp3avdfwg==
Date: Sat, 3 Mar 2018 22:33:12 +0000
Message-ID: <20180303223228.27323-6-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;7:A6OSrEYPjWBtWoGHen1+nhcEe2YLzfXLrk7GYnXP2a0+PXDPvYPEtBnmrnw3JLX1gyV/f6zODxpOGr7f1+NpfZL28tMd2jTTiHZDvvH2sfQtjobGuS+245pvgaVy7rLo50MuoMDE6S+WwHaFDYDoaKdwR2SShsPL2oZHfJI/yWJTESosn8bkOJMpyTj2rIUJBUQu0la9IUPG6rRLZ/FfM0nJQSGc30S/cMX4M5W0lQM4aqKBc32ffrqYP75wDJxq
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 804aa832-1973-4d96-e525-08d58157d462
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB34418AC3F8F8F7EFF70D4C5FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(192374486261705)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(6666003)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 9BKwVpCHKlaSm0VXRbkFsuqO1pwd+PvhDFDMQmCy91eSUV4vbdClFR41jeKmqmft9jD4DoEuuFDl8U/JprAmcDgGWNhxZWzD4hpTCFS69h6nKCe1qz/dtu4I6B2Sja/uNjqBjyYBQBCtexCapUa0hS1C7byishQP4pkpEFKSGcY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804aa832-1973-4d96-e525-08d58157d462
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:12.2941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Potapenko <glider@google.com>

[ Upstream commit e2f586bd83177d22072b275edd4b8b872daba924 ]

KMSAN (KernelMemorySanitizer, a new error detection tool) reports use of
uninitialized memory in selinux_socket_bind():

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KMSAN: use of unitialized memory
inter: 0
CPU: 3 PID: 1074 Comm: packet2 Tainted: G    B           4.8.0-rc6+ #1916
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/201=
1
 0000000000000000 ffff8800882ffb08 ffffffff825759c8 ffff8800882ffa48
 ffffffff818bf551 ffffffff85bab870 0000000000000092 ffffffff85bab550
 0000000000000000 0000000000000092 00000000bb0009bb 0000000000000002
Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:15
 [<ffffffff825759c8>] dump_stack+0x238/0x290 lib/dump_stack.c:51
 [<ffffffff818bdee6>] kmsan_report+0x276/0x2e0 mm/kmsan/kmsan.c:1008
 [<ffffffff818bf0fb>] __msan_warning+0x5b/0xb0 mm/kmsan/kmsan_instr.c:424
 [<ffffffff822dae71>] selinux_socket_bind+0xf41/0x1080 security/selinux/hoo=
ks.c:4288
 [<ffffffff8229357c>] security_socket_bind+0x1ec/0x240 security/security.c:=
1240
 [<ffffffff84265d98>] SYSC_bind+0x358/0x5f0 net/socket.c:1366
 [<ffffffff84265a22>] SyS_bind+0x82/0xa0 net/socket.c:1356
 [<ffffffff81005678>] do_syscall_64+0x58/0x70 arch/x86/entry/common.c:292
 [<ffffffff8518217c>] entry_SYSCALL64_slow_path+0x25/0x25 arch/x86/entry/en=
try_64.o:?
chained origin: 00000000ba6009bb
 [<ffffffff810bb7a7>] save_stack_trace+0x27/0x50 arch/x86/kernel/stacktrace=
.c:67
 [<     inline     >] kmsan_save_stack_with_flags mm/kmsan/kmsan.c:322
 [<     inline     >] kmsan_save_stack mm/kmsan/kmsan.c:337
 [<ffffffff818bd2b8>] kmsan_internal_chain_origin+0x118/0x1e0 mm/kmsan/kmsa=
n.c:530
 [<ffffffff818bf033>] __msan_set_alloca_origin4+0xc3/0x130 mm/kmsan/kmsan_i=
nstr.c:380
 [<ffffffff84265b69>] SYSC_bind+0x129/0x5f0 net/socket.c:1356
 [<ffffffff84265a22>] SyS_bind+0x82/0xa0 net/socket.c:1356
 [<ffffffff81005678>] do_syscall_64+0x58/0x70 arch/x86/entry/common.c:292
 [<ffffffff8518217c>] return_from_SYSCALL_64+0x0/0x6a arch/x86/entry/entry_=
64.o:?
origin description: ----address@SYSC_bind (origin=3D00000000b8c00900)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

(the line numbers are relative to 4.8-rc6, but the bug persists upstream)

, when I run the following program as root:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
  #include <string.h>
  #include <sys/socket.h>
  #include <netinet/in.h>

  int main(int argc, char *argv[]) {
    struct sockaddr addr;
    int size =3D 0;
    if (argc > 1) {
      size =3D atoi(argv[1]);
    }
    memset(&addr, 0, sizeof(addr));
    int fd =3D socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP);
    bind(fd, &addr, size);
    return 0;
  }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

(for different values of |size| other error reports are printed).

This happens because bind() unconditionally copies |size| bytes of
|addr| to the kernel, leaving the rest uninitialized. Then
security_socket_bind() reads the IP address bytes, including the
uninitialized ones, to determine the port, or e.g. pass them further to
sel_netnode_find(), which uses them to calculate a hash.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Eric Dumazet <edumazet@google.com>
[PM: fixed some whitespace damage]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 security/selinux/hooks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8223fe463fa3..98370d019e6c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4061,10 +4061,18 @@ static int selinux_socket_bind(struct socket *sock,=
 struct sockaddr *address, in
 		u32 sid, node_perm;
=20
 		if (family =3D=3D PF_INET) {
+			if (addrlen < sizeof(struct sockaddr_in)) {
+				err =3D -EINVAL;
+				goto out;
+			}
 			addr4 =3D (struct sockaddr_in *)address;
 			snum =3D ntohs(addr4->sin_port);
 			addrp =3D (char *)&addr4->sin_addr.s_addr;
 		} else {
+			if (addrlen < SIN6_LEN_RFC2133) {
+				err =3D -EINVAL;
+				goto out;
+			}
 			addr6 =3D (struct sockaddr_in6 *)address;
 			snum =3D ntohs(addr6->sin6_port);
 			addrp =3D (char *)&addr6->sin6_addr.s6_addr;
--=20
2.14.1
