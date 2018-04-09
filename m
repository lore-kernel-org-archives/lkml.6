Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237967-2-7871115114308097972
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
    1523237966; b=BPUAZVmMiP1uoOIM2Fw7XvFmLc1ItP0yBwTqzhwBCSvODYsnh1
    vPvlTav+xitTv3lbbnU2DKxdcjbIkMqjnHyi1OGtKQFayyTASp2z/XWlBBPUUehv
    WNcB1+8/aTMt/rSt6oCuL6zvGEQnOE+dEJe6XpLtMIwJR+WIOHjJyCGU3brDB795
    tYPpODAkUJ2+qepEmjZF7VhXOKCvOC1GWvI50Q4AHupNsOsQg8Xe/MR2OPc8kf3f
    x+YarofAH1ThzD9Efu12R7btIz9ZjTitSz6qcch2/9Peqtq6MTOSDi8G2cKfNJhM
    X5aIdjF+Fm9m/EGalimK340UMwcvmRrXICuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237966; bh=V66LDonhCV
    6pO8fMe3jFdF+j46t6/MFcC3/yRBa3bOA=; b=ovTaMz0tCktFd6n0moyxiFsmS7
    I6ObVV75JNyA+cMxx+l8MTctsSUSqr6yWX9twW58fr2zwCPpMeJf0db1t0qdCnHN
    I8TW7LfTVJqI2/opCbXX2JBeyEVm6PqS7SRrMz7t2x7gKYBAyjfwtnGFSO2/iJN7
    ZfQXhOnsNAlFm5g7ubi6N5tnzEtit+0qs5Bs9wFxnkQd9Qc9eESHdELvzMwCupTa
    T/oshSALvpgjphLgDq7ZgogyznctQAl3t4KjF47qyTVVAApm1BE7MSsE8SD+t9q5
    Gc/ssWZlp1jDjGZK5zeEa0nS49LRbaaRhz6MIztvAiFL6p4t745XShcPDMBA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fR9YcYI2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fR9YcYI2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwqk66zZ0fyoW2KPephwBkk5ibmH43VfPBS9Vm89c20lyZF8oRxZlgp4mgMxUYl1DXG8Mf9ob56fuzT+vHfmzUuOHsgob2JwsFZHa6X6r/lU0UtoNOR
    qMEE7iT4gKDlL43BgB+vtIibyFXI+0+TeF2DuQ0gp9iGXl2WUZBkGxoEZ6d5F3xROYT0i4ulkT8S2D8kZaETOAdDArozbIfZJkvzyzItl3lC6rFMITx/A9YW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=sqRfqqWQWp9EPTTr0gEA:9 a=thLZaq5qWEgcn6tk:21
    a=0XOJjRQ1eUBVNQLo:21 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757245AbeDIBiZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:38:25 -0400
Received: from mail-sn1nam02on0094.outbound.protection.outlook.com ([104.47.36.94]:35040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755726AbeDIAfC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 013/162] sctp: fix recursive locking warning
 in sctp_do_peeloff
Thread-Topic: [PATCH AUTOSEL for 4.4 013/162] sctp: fix recursive locking
 warning in sctp_do_peeloff
Thread-Index: AQHTz5mYWxdwa5Ssn02K5A3aZGNRug==
Date: Mon, 9 Apr 2018 00:27:52 +0000
Message-ID: <20180409002738.163941-13-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:XNM3FBxIprP9kiSI+FoaxsxK9YfxYEin+foCEYa5YJJwPFo6wKh8LqEPj7IKsGbJ8LQKyrGQqO/JRUmew8evPBC02yyrUeb/r0U9OPAhpXf/YYGpHSMF1wag6JOblgQDMMg2TSccfAH198nZdewCJ8nLJrYlZn2CvwXxS9XOlgLNib0A/RwXeZ7Zjlutype8PDO36HOXuLpmhStkDWjx6roNnk69aiUE0ZgLpAhXoqe7jXFpWmxtpNqFp5llngFm;20:iC6mL2/sC7KlvJ3BG05bNhc6fNFBI4YsylRenJFXOyOUwEgR81ugxAYduSHOM6ryXWwO3IIf4MnB5KfAVrfmgHd5zMNQanJRRw7qjFLhhgCLBnck990xA1A3Yw8DyhLNhKVkJHrDyX26WuQAYDpRlg0BxVPSKG/mvhqo3+j2JR8=
X-MS-Office365-Filtering-Correlation-Id: 6a3e7e84-4e54-44f4-2351-08d59db1b8e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013D801E6201DDFCA5C7B8BFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(39060400002)(316002)(110136005)(575784001)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: fPwYR2KVLXTGPMNk5wHnuVQlNCm2Ho7gYDTF/yeJskLO/SAn4E+m99VjGTVovNZsyviHGOoSrRheLdRcQz3FLRqDc284osa2Mueb9V5FThS+TMeCDlbHzQsYiS60WGewzbDwwdGjX/0scMgfNvAt1eCSlkbsa7A8c0HLfzAiaau9z0POy7vJ8H//LVGcGsuGywQR752r/0dejK5W5p6cjPiLVhP0NonSjnbManorz4lZGN8s2EaaaW8y2vox1FRtV7WySK1wJlmswUwVM4jF8n7OdUAaprqbSnuyKUx6csQCW6c6v7Awcr2jt0GMWQRX9Cfm444YDFW2JtTHz8CcmtkiVH4Ey/Iqd9y+NPNvm07OBzr71bLd2XD+RYMOfn8OhNhpkVnIr0dTYrIe0W0FHJj4583JfsmwpBXo0wPRgGQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3e7e84-4e54-44f4-2351-08d59db1b8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:52.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
index df6a4b2d0728..8efdf7fc1044 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1518,7 +1518,7 @@ static void sctp_close(struct sock *sk, long timeout)
=20
 	pr_debug("%s: sk:%p, timeout:%ld\n", __func__, sk, timeout);
=20
-	lock_sock(sk);
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	sk->sk_shutdown =3D SHUTDOWN_MASK;
 	sk->sk_state =3D SCTP_SS_CLOSING;
=20
@@ -1569,7 +1569,7 @@ static void sctp_close(struct sock *sk, long timeout)
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
