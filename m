Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520487410-2-7706279721085882381
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
    t=1520487409; b=wXtKZy7WkD7BcUUeZBoy/92+PxLsM1lu4HWK7XNuDtc7RvZ
    BM26nMoRtr8dl5a1RvGJzBA428K1/IXST8pgMEHr4S1jbxrttASa2NWXFwx1LJSJ
    1edRQwj9j/QiWl2Jngr615XJ5YP4JwNRLybLPuDGRwvOYKjCl7uYIZquNUm8u2B5
    +S1gFqn1OJx0dpgj348UgvST5jKEKV3wZReuPc+Xij9OjjzqCm3DVbqjrtQXisj9
    xQMRQMSLkWLk3oWNJwY9Tkllh9fT//1zSZXokTRaHslyz8xsOP9qvCH3XkHayfMS
    j3IWxWXlAsZ3RIanMqha+Z0TdMV4CHjZd4N3Ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487409; bh=M7iq+a
    hpDBpFCph5WuFaUy2BVgOzEWK8/ruwtFg1D9w=; b=PIAknGP4uTrTGrI+rEZtn/
    8NmH0ffR0TCYxrONwg2wyhjsb8W4kl3ACyYTdpOPdCEwnfE6Fw3RuJaGUCQGbwPn
    fQj7VQjBMmucBHcxj87FfBRwsQ7w6WWBsApoOJZ/t4NULJm/FCsdnRxZjUu7Iig6
    kpyQ/79bBznfq8achQef4zfO4exiqZPsPqBOgn9vrWi9TnKaWgftCkJjFhd7rnRL
    H6ruU92TKwJspMSU2WHlV2qr64hInG9uATJb/cWLPSrS31Pr1g5eOIBCXnEQFKiW
    O7CnlRKM1Jww+f595lLawO0TPffKc5bpiteK6X2M4NgnCAPNZ/x8CxkmwdRY5PeQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sarj0i/m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Sarj0i/m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935211AbeCHFF4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:56 -0500
Received: from mail-cys01nam02on0093.outbound.protection.outlook.com ([104.47.37.93]:7384
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965995AbeCHFFv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 033/101] tcp: remove poll() flakes with
 FastOpen
Thread-Topic: [PATCH AUTOSEL for 4.4 033/101] tcp: remove poll() flakes with
 FastOpen
Thread-Index: AQHTtpqKjLi43huFCkOggLPRwLtwzg==
Date: Thu, 8 Mar 2018 05:01:38 +0000
Message-ID: <20180308050023.8548-33-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:E/YEHBani8c1C/XOhY2r3+BoFkB0MlPW3mmpEQjEoInpTjYG7x/5pr4eYzXR8TBPi4O9m9mSHKGh5rpXZjWPofp6pHhQxIvS1q8cid3vS0YsJnHV8Lwse3RTZ5O5Erima8RaDkr47U9sMv4gXtkooZ8YdY5Tbzn4Y7IKbujygm1sAH1Cq4dR4X7z8e25EGTzlmrg77ilCRuBUC+m970X4tOTeC8DRt9OKTCx2xBkHHRk7Tb2gqtXEDT2tCj42vvN;20:Rf++4Be02nShFd5WyNyHR0vps2zqUWIA6XDb/AIiw+cn1DRJOS9UFbmckx7QQG7YQe8XwG+0dZDGUdshn+8ypfoakDs+tYBZc0oJY38B42yAdfq/DHe5SvCKWcbDJ1HzPkwgW8dxPLtnL+wwK1Hk36oR5optDuhUPePhf5f5OJ4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 078b3063-e520-4707-386f-08d584b241e2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046F48AC1A09C3048782C56FBDF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(53936002)(3660700001)(5660300001)(6436002)(6512007)(36756003)(3846002)(478600001)(105586002)(305945005)(6116002)(1076002)(2900100001)(72206003)(3280700002)(68736007)(7736002)(97736004)(22452003)(14454004)(6666003)(2501003)(106356001)(10090500001)(10290500003)(2950100002)(81156014)(25786009)(54906003)(107886003)(59450400001)(76176011)(6506007)(2906002)(110136005)(99286004)(26005)(186003)(86362001)(102836004)(81166006)(5250100002)(4326008)(8676002)(86612001)(316002)(8936002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YlLsf5ghD3a9KTT84hOeFoCJDoiaFK5Ge7jD5y6lKgoMhJoZnYehnNZKRXkLCYNHC+wmu2hQvUrSrsZLcE28tRJi8G2FtSQwLsCre94197yXcmnJeUpYfeDnAUHpjS//SkI5ErG4HREWGLIaWCycGjzk4TDWj4av9xeR3Hn46xXRJPPMdI3GiowXmm9QaEhBynnAeRwZU/EiuPEq0jDXg9v0HFAskQTH+WioOA1oGm2LDyPQJW7TPEBFJHt6eCR3V9XSFBh2OGw6ecrE09kDL+7MKfMrFMM41QLB8AdXz0aZrMjJEkfqOvftWTlX06Wp28Z7dp81lFHJwhRf1T8BLw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078b3063-e520-4707-386f-08d584b241e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:38.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0f9fa831aecfc297b7b45d4f046759bcefcf87f0 ]

When using TCP FastOpen for an active session, we send one wakeup event
from tcp_finish_connect(), right before the data eventually contained in
the received SYNACK is queued to sk->sk_receive_queue.

This means that depending on machine load or luck, poll() users
might receive POLLOUT events instead of POLLIN|POLLOUT

To fix this, we need to move the call to sk->sk_state_change()
after the (optional) call to tcp_rcv_fastopen_synack()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_input.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 71290fb7d500..75433ed6714b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5464,10 +5464,6 @@ void tcp_finish_connect(struct sock *sk, struct sk_b=
uff *skb)
 	else
 		tp->pred_flags =3D 0;
=20
-	if (!sock_flag(sk, SOCK_DEAD)) {
-		sk->sk_state_change(sk);
-		sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
-	}
 }
=20
 static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synac=
k,
@@ -5531,6 +5527,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_fastopen_cookie foc =3D { .len =3D -1 };
 	int saved_clamp =3D tp->rx_opt.mss_clamp;
+	bool fastopen_fail;
=20
 	tcp_parse_options(skb, &tp->rx_opt, 0, &foc);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
@@ -5633,10 +5630,15 @@ static int tcp_rcv_synsent_state_process(struct soc=
k *sk, struct sk_buff *skb,
=20
 		tcp_finish_connect(sk, skb);
=20
-		if ((tp->syn_fastopen || tp->syn_data) &&
-		    tcp_rcv_fastopen_synack(sk, skb, &foc))
-			return -1;
+		fastopen_fail =3D (tp->syn_fastopen || tp->syn_data) &&
+				tcp_rcv_fastopen_synack(sk, skb, &foc);
=20
+		if (!sock_flag(sk, SOCK_DEAD)) {
+			sk->sk_state_change(sk);
+			sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
+		}
+		if (fastopen_fail)
+			return -1;
 		if (sk->sk_write_pending ||
 		    icsk->icsk_accept_queue.rskq_defer_accept ||
 		    icsk->icsk_ack.pingpong) {
--=20
2.14.1
