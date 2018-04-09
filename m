Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241743-2-3759511352107864243
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
    1523241742; b=pML0izSDGt6rZ66HRWkwRTUE51CM1q9uet4SMJyttgtXGjMnZQ
    DFaGR1ckYUTtz0oAso4mrlJNye0OCzjsYwl62T1iJXwHJFqUJVWNPK2QGcilxc2g
    ezlJ0qFSYtPJ9iiAtdibfKB0LJg18HZASnWDK6aHZkfpITbxBp3x4r7md/L8xr4w
    FO/RO2iw9Vdnvse9CaGT4fJKKbWodWBuuFjdLKE+aPZNeQZzamfJqpA/O6mq2E79
    eXPqNuACSso9MDDznoLGBEw5NhmdvdWBVbgHxAQES3O/6TLMZSANm5lTI/ntyEPN
    y5h6k3RnT5iVGiNS4s9uYyMYGaD6/7u3wlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241742; bh=KV8lIiqYhT
    8YCDqR0QwBz5jhMQ/H5xOlCbVkpznJBFI=; b=vf7QAWFdwaVF1QteE+gwPp/RWE
    oJWXkLnSMBb6qTuA+MVfXG4a6S2n4WAZysPS3pX9rMjJsTqarulrH0mhYm6IwtPu
    otnITsYkhvdsMMxguhjTfwTdHo29N1GfGQUXqUCal7JDx7kuefF0KiEgO82IU9gr
    yoCqCDXFS30mBGKF6YjeFU4biSvc2tilZu3JyICajzu8HjbpHyhOKtjCwWbaXG1M
    xD5bSd69tS2I63Isj/UMjNcGMWuWKyJDy+MsmgFo6NSG+6SPZVvp4JPqUrQN4KbO
    Rhz4GSSoxIKsimWTjRJV4ZftNl3c2wj7RmxNbLfJCB/q21G33WmtGBJBlLsg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RNcjcwq3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RNcjcwq3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMST5Hl+cHkULc2s5QrASbC7VmjfKZo9YNnqo+bURf0/IFONKF5RebbZl7jdDAAw1aOGvvWVuQnA6xwrTRK8CkYc8iiODsNUfDH7LXvJZArmHTT+oKZO
    btKpbKgACv6xNviGuySBJWEItOLWnKd2UHAk5CvwrtEu25jZn/0kdNaN579eIR965VMgqNqTjp/WmMrXZyog0BthUBNZVbcdi159W/uAzEfQnVUft4xjVKNQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=sqRfqqWQWp9EPTTr0gEA:9 a=thLZaq5qWEgcn6tk:21
    a=0XOJjRQ1eUBVNQLo:21 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbeDICmQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:42:16 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755428AbeDIA0z (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 028/293] sctp: fix recursive locking warning
 in sctp_do_peeloff
Thread-Topic: [PATCH AUTOSEL for 4.9 028/293] sctp: fix recursive locking
 warning in sctp_do_peeloff
Thread-Index: AQHTz5jxpaYe6gjSe0mhk2C0RI1dBw==
Date: Mon, 9 Apr 2018 00:23:12 +0000
Message-ID: <20180409002239.163177-28-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:wADFzuj1vxsofUaCFESqzN5sRSuq10kAZOVjjmHWOSMhsx9gv8UP4DPtIDKioU2nXPWwwm38jxQq96TE49KYd9m7NsV3sXb7oEgosTadd8dFwElX1O/sD8f51ERltYrafJY5npCNWFAUH4556iOztKsmB77bwNXzk//rEug6/YyROGHD2S+CjluEMcWaNFfn/YuiiET3JQQbsmS1+wZU0fT0ZK0bWOFTd1EujXyACDTcQ/j68AFzOcfoxqtMB0Ew;20:HXOlld4c55SpltS0zPAEypc1vZFA55qiToXqQntGEbx7yiPP1eCZaUFnf5CmsyVhq0K59t+DwmuZNk+eewYYcLgVtp7LiONG6Mb/EQoQ1gEwM5xW/2E12SZP1Qe0uCGEjO6eJKpLKMvCXE2a479OgNdcauwjT3IIEuIMsyjZOBA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4637d861-8bd9-444b-9d08-08d59db09400
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885E975A95DBB298AF8C5B0FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(59450400001)(66066001)(39060400002)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Rj7OFScT3YAdsw1jUhUkAYuhn9oaaAhzqar7gKPybBLvXGhvQMCPIZVfrdzcoWvyzlL77CW40SOqU7QBBWt6zuNBRHvE4vd72F7gnmNwEiR5R4Txmi9v8g3H3k2bsBpf1KX5CKxqyM9LIPtrMCgEB+dGG7tsg6t2h9OcVdmiGmIeQIQ1nt96nsWOUAnw/eXjqWiQUW93wNk1WDvi4Btkga4sdp4S8Rgw5InM8mLFdZg48q7Nze6wnHqq1BNpRPCqhKWoTsPSd0Sk0edL3R97UDwNQwJ6Qfp3n62ogaI7UkG54pxxJWvO5Urm32Oh96S3aNJoYLD4uZD1aXZbakqKJwRPps4tSKY2JIUPm/id0nB/kaSYH9YrWfh+rysPJE+PcIdtUBkP9gJ6iwukM33aExy+OBWdT6L1gTS4ZfzR7Fw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4637d861-8bd9-444b-9d08-08d59db09400
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:12.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
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
index 8cdd6bbe2efa..172465b7c0f4 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1519,7 +1519,7 @@ static void sctp_close(struct sock *sk, long timeout)
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
