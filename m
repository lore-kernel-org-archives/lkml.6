Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485268-2-2752822992071070272
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
    t=1520485267; b=VpI0Kcmbrch0H98FxKyjtiX+ZMFfr9czlvdw1ak7SnKY1O5
    pSg3KrKkmpf4IRy3qSsLm43DOpfVdPrtbk51GwLXWXrvaM01hOQxZeFVrL3gNpf6
    UYTcwgbz2im4lmATNvEVf+mVzgMKbuQpdB+NxC2u0/lfDbNu25s0XoV1prBq3ukq
    BwrKSgRyLInBfbtSJ373kyElUK0TP+BzF/SVWtaQjyTT9ym+Ga2HFGeWx753wKVM
    nDSCQFFc2vjpIMzuVGVJAhGZtWt7VwDSh/GE1ow9eCT5e10kLtqRZmA/sGHfzMZM
    KexQjZNp6bt6oB7rp/G+Y+zA3r6y9S7jZlK208A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485267; bh=4lSK4O
    spyCwor3vZT0CLN+/E2g5g3BI4ryya4yQW+8Q=; b=RzwAlcMgdRJY8DDSjG8CH1
    b/Ud9HfnNXFYDa8dt6jQfNUsMEWb0NwhN6T+BfK0mwP2LCTPj28bD2SpH2k461zS
    b7O1qP8EBTEXwlTPE4Zbmg2PMGjlMwGfMehTK31oswsUaEWouAnn0JDhY2cPZ/JX
    SZPiY/PC+JDQDf7qkiwuE91rfnGq5jABepcYtTbWMWPdO1Cj9gcl2DmMb3NhxV62
    FB3mEugXnyzmlUvgmQMKBgu013r2GcvX0DUoLn0r68qZgyh4ycBtHFl/pWuffEvX
    DEUeuO6mAzzTzTQTUnahCi9IBNlvfJiNxvwRBwmfH0SNv5GaWwvP9opikoBu0MZA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IUvbtvdk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IUvbtvdk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965631AbeCHFBF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:01:05 -0500
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:45238
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965601AbeCHFBA (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:01:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 058/190] tcp: remove poll() flakes with
 FastOpen
Thread-Topic: [PATCH AUTOSEL for 4.9 058/190] tcp: remove poll() flakes with
 FastOpen
Thread-Index: AQHTtpo28PE32iJUyES6TampkLY/0w==
Date: Thu, 8 Mar 2018 04:59:17 +0000
Message-ID: <20180308045810.8041-58-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:qGZvEgrtFdipVzS3OzhS9JQkY5M8G17MkRVRMzj+8pDDGSBFND8f1mwI8FkF+nm/roBewmzhwHeggVmk7MQ8HP0gPd90pvhzPTav+o3oRYRkifuPzolj+rrbaDWu/fsxJ7zGSW64cVNQ4+5h7KyIC5vRAjvUX8B7B/kxd0tCNDTBmOS6/W/vuEaEir6o72xu30lssarWIFU/AnxCLqqnpKodV1iGT9wPcrkc3/8bWhZtqcXzslSqHI6cBR6K/zRu;20:dBTiEqSfANCNTRTSpFOJknkEBTzxj0Jdd3EdyxuRK7FsgjRQjsyx/35CrQX61H164/y2WrCwaq8TA61fbsUKnKe/W4b7bC8HmVbnW71Uj8TIQpxpOchI4aFj9H6XlkkYQvJoqlUiU9VpvPoftuuCWorUmyTV5H7YE+Z0ptaQbkc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f96db19b-cf25-4f8a-733e-08d584b18ece
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109CFCF148468357E29D1BEFBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PFqtXfOUwGqVUV6QCwOxd581T0C/MFILoRl1KQIj+UQNwFdwYMsuNbWkdFLydf12Azp/pvf/K5gfJyYtU8WEaVl4cbXf2Ll7I3JlmMMfZXOE+r1fmXVtQsw7WD2bDgAATIBFv0xXAusA7bwugdc7pmxScXwYbL1Z+BdGm5hTsYhVg10lnVGE9SJ/iQlOs7/rtJEH7gGRnsRqj/pPVWEzA2xGBYzrYbyxiIbyS90sdvbe1UGL+Gw3384IBLOy6EZHQrSVpNtaEnlt34gwX9BoG8n66cEbzUbCRAl6V7ED1j5cZwXsqsgaafZUDsW+n+0NuuAgHqGedhjDJDKGPbEpQg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96db19b-cf25-4f8a-733e-08d584b18ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:17.4372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index 2f107e46355c..b5f264ae3bff 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5606,10 +5606,6 @@ void tcp_finish_connect(struct sock *sk, struct sk_b=
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
@@ -5678,6 +5674,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_fastopen_cookie foc =3D { .len =3D -1 };
 	int saved_clamp =3D tp->rx_opt.mss_clamp;
+	bool fastopen_fail;
=20
 	tcp_parse_options(skb, &tp->rx_opt, 0, &foc);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
@@ -5781,10 +5778,15 @@ static int tcp_rcv_synsent_state_process(struct soc=
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
