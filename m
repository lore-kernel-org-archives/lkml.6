Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235765-2-16405315871456864405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235764; b=R3xbzXQP2vdQ1OQ9c3MyTTY74wLqitY67m6aPzxvAxCRDQMxAz
    CgkGBAMVN6mtX1MAYhyhxydvHAtxUPdlbczEewDgxZNWUj1l48PBl3KD1Lc4zD3V
    xlUTTz4bvIK7qm0QZFvNk1O/6c7qk8tpo1xcXY14rR4xogxtHw3W0RPIzfD3Z8to
    6SkjN8hhsJVgy2FpneE3AZWOsy7heO0Jy9001RT9BgpeEUXv+leWm3Y847Yb5Sn3
    aAiN32bnmk9AgxkermNfc2EQ7sWDLQHmqENRzC0PL5ueOPYJ+8ilSjxV6bnTPXhz
    39wypqxKN1BM4h3CTMWsoW1t/mPCpvv8mExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235764; bh=X+QCEEfasI
    64Vq0TA/FWigEPrM9JMIbhWPzLzMHWH7A=; b=HSycZmv0nctbz9BCr/QfBzKbKi
    yHCxnJ8h8gnkEj59DknJq/KO2FKwq1XLZRi9UHq1Xl0ruO10x7GF+gk2hgqJMMN4
    Aql0kLChcuVVG+0wAhv+NncAiPGsMa8IFgxmUEWITexq7NfE58og5AtGqtEkWUt2
    LfnTqNRaJhgTIi/wzka49cgsw1EpSvLbgirYn08NcYd49RmRYaoc/rqbCQu7DDBY
    8uK/Ytkft4HCqzA0oOja3cMGl5xofb4/anXsiLvzBfkcXvtOje2b6vZAhUp9Hprn
    zxA0ss52lZ0z1LDGBfJdoKIoygh3oVioX5GXlY2aCQKBgY2dw6bTK2yqdFlg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O7O6jmNa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O7O6jmNa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPK7FYB4V8Y0wgdWUz0mqrfYOnbVbLYtlDbNrs4gdx4miFWcSRelLOLAJCNk4DX0+m5keXZswp1HUVOXKfAo9vY+qHYcRsigQycdL0j0B6W0/0pbwTvF
    Lz+nMoY7QZat5mAjf52ePqwn344ZbA/lMvrGiDUkj5EQOOqqpSVAcGo4t/jdIbuWtp9N2odZMQgGeGD7jOz6VC2+NXRsNt+h3xIx1dc97N95yFDevGLfADhM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=sqRfqqWQWp9EPTTr0gEA:9 a=thLZaq5qWEgcn6tk:21
    a=0XOJjRQ1eUBVNQLo:21 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeDIBCm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:02:42 -0400
Received: from mail-co1nam03on0132.outbound.protection.outlook.com ([104.47.40.132]:50200
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933165AbeDIAjh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 011/101] sctp: fix recursive locking warning
 in sctp_do_peeloff
Thread-Topic: [PATCH AUTOSEL for 3.18 011/101] sctp: fix recursive locking
 warning in sctp_do_peeloff
Thread-Index: AQHTz5qiOBRkFzHmEUWWw256ZQ3qEQ==
Date: Mon, 9 Apr 2018 00:35:18 +0000
Message-ID: <20180409003505.164715-11-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:pXVmBdwNOU+lT/1zYjWAqS9K7eHl4BcV13hv3h3eCdugaao9CC/2/jkg0EJzFZYmhoQHt31VvV+4h1BG8vMc+qV+3CyfF80lMsC7OIkeSvhwbJ1SQmDFP8s4If1FqAaW0nXedzVMVawdkP2PqD/6nv/Tc2L07nBrSZy0ZkFjOv2dC0ng8ZUui88ldaZT26BKA152OennVo8cgUdv44oXpsrGDch1PABGmjOOMUijRlFv0Hg+g8AEwVNJG8h2LsTV;20:FKdPZIOHU8DTVbdTgoLBL177kczEfsik/V4ZRvaDOvp7PY3n5zJEUnvXFxGwiI47uivKL980Fy1I3otVrhV5gyU6hDwMw8zadLWIm2cDfkhqZ/Gp4ouWNtAVBvvdF8tO5uEEc6es3IhIAYenaBaikUG2wWKua4IiBfaeN8BT1WY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: df8a6620-8e5d-4bd4-e1a9-08d59db25cfd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10476BF238D500B8CCBB9EE9FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(39060400002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(59450400001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: NlaaB06hvFnguA3Uzph1ZIZcSwagIyXK88EXB1EbTo3M+x74tv7cCeOlCMHARkV6yOM3Ww0IkOyy5BwvQwcwXwZmxdV9lyvBGVWETBw8kpfvQKDVSHfyUeLdcFDsc4qwRUTIw55k6tuCpAcUypdnRffVKSBD1fAhd0GlXLB4tmK7afL5nFZ/ifMsX+QT/Zj64YQFRlTMBbe1msMjHA1ywR8+wOBhCxaOvMA7DpNT4okMzxfI8hTcxsZhv4Zw/WjdLgFz0IMy1PBwLYnSzDtB1th4s0VskfOIq5vRwNYWWYONg4KQzEFHZpbp1awgD+Es1NUXzn5JkdomlrzHz2kdAWx9+2eRKwBp0x2evvw91TpLtZzdtGem+OWZV5R0oAu5BW3Suv5ZwpCZZb/jneWDTeD6clQLkk7zUf6LNDrpaEQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8a6620-8e5d-4bd4-e1a9-08d59db25cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:18.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 6dfe4b97e08ec3d1a593fdaca099f0ef0a3a19e6 ]

Dmitry got the following recursive locking report while running syzkaller
fuzzer, the Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x2ee/0x3ef lib/dump_stack.c:52
 print_deadlock_bug kernel/locking/lockdep.c:1729 [inline]
 check_deadlock kernel/locking/lockdep.c:1773 [inline]
 validate_chain kernel/locking/lockdep.c:2251 [inline]
 __lock_acquire+0xef2/0x3430 kernel/locking/lockdep.c:3340
 lock_acquire+0x2a1/0x630 kernel/locking/lockdep.c:3755
 lock_sock_nested+0xcb/0x120 net/core/sock.c:2536
 lock_sock include/net/sock.h:1460 [inline]
 sctp_close+0xcd/0x9d0 net/sctp/socket.c:1497
 inet_release+0xed/0x1c0 net/ipv4/af_inet.c:425
 inet6_release+0x50/0x70 net/ipv6/af_inet6.c:432
 sock_release+0x8d/0x1e0 net/socket.c:597
 __sock_create+0x38b/0x870 net/socket.c:1226
 sock_create+0x7f/0xa0 net/socket.c:1237
 sctp_do_peeloff+0x1a2/0x440 net/sctp/socket.c:4879
 sctp_getsockopt_peeloff net/sctp/socket.c:4914 [inline]
 sctp_getsockopt+0x111a/0x67e0 net/sctp/socket.c:6628
 sock_common_getsockopt+0x95/0xd0 net/core/sock.c:2690
 SYSC_getsockopt net/socket.c:1817 [inline]
 SyS_getsockopt+0x240/0x380 net/socket.c:1799
 entry_SYSCALL_64_fastpath+0x1f/0xc2

This warning is caused by the lock held by sctp_getsockopt() is on one
socket, while the other lock that sctp_close() is getting later is on
the newly created (which failed) socket during peeloff operation.

This patch is to avoid this warning by use lock_sock with subclass
SINGLE_DEPTH_NESTING as Wang Cong and Marcelo's suggestion.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sctp/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 225019397bc6..f389cd2425df 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1513,7 +1513,7 @@ static void sctp_close(struct sock *sk, long timeout)
=20
 	pr_debug("%s: sk:%p, timeout:%ld\n", __func__, sk, timeout);
=20
-	lock_sock(sk);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
 	sk->sk_state =3D SCTP_SS_CLOSING;
=20
@@ -1564,7 +1564,7 @@ static void sctp_close(struct sock *sk, long timeout)
 	 * held and that should be grabbed before socket lock.
 	 */
 	spin_lock_bh(&net->sctp.addr_wq_lock);
-	bh_lock_sock(sk);
+	bh_lock_sock_nested(sk);
=20
 	/* Hold the sock, since sk_common_release() will put sock_put()
 	 * and we have just a little more cleanup.
--=20
2.15.1
