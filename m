Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486246-2-15355604099002039380
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
    t=1520486246; b=D4GJxNuiQ+8R6ZO0KcUQOwxdSL3ZpNbLSbb1H4kQh5HaRbX
    9jLjF0KojAPq69D/1woQll2fINy3N5UciA8MbRttxpTDRFAvwJMvUEBYnadtPmkN
    G24juVta/8F1tGCV7a+Jsm0YUK6R9nyxgiF0qsjwT5kxEsan02DnNJfjQhbL6wsM
    4Z3CvWyxP7AwG2etvQ5ez5zNB8hp1ID3/a5nH4lHWzRKZ5AfGsXAhn7owQLGOrJQ
    qm+SIpafARrQWJcAj8XNDKcXgtDESXKEYn7Z2YR8QkGkBnPLCp3Pyy6F0o/xPi/3
    DGg0kKV6Wa6K2C+fj3N/Pc9ycqei2rOZvSvd0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486246; bh=NLYQpb
    qv4FCMLjyN5B9r8NSipSb6fCgmhRs/3yVKlyA=; b=mnYLt2sxcQrapJrjgTBnIm
    py7SRX94EJfOsy3ziFgTLezrUlR3OzrnJSd24HSlj8AwhX8fOFcaxhWLaa1thQyy
    9pgvR9668N4l08sW0QR/F4bP+jZg0011GOcPW15fOpWhCg3M635/IWOsLHn+TWly
    sSldCei0r54Dt+JDnXGYymyaG0nb+RpOlpz5Q1NBPD2ChILwhZKRMMBBc/yceQaC
    8XSdkQtCsl3j4FmcJX285InGhRP6F0bmSgEd0kesg14eikHTm4jQRxhbQVqqOa9n
    NoqaGFm7Znuz3SU3QB56y1cgRbalEHAs5MgCCIJA6V+7+5+abYb+6b1lVTjwvLhQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SZUmmGpK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SZUmmGpK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966547AbeCHFRK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:17:10 -0500
Received: from mail-bn3nam01on0121.outbound.protection.outlook.com ([104.47.33.121]:48048
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966782AbeCHFIt (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:49 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 21/53] tcp: remove poll() flakes with
 FastOpen
Thread-Topic: [PATCH AUTOSEL for 3.18 21/53] tcp: remove poll() flakes with
 FastOpen
Thread-Index: AQHTtprEW1btRittnk2WK+EHb4pjxw==
Date: Thu, 8 Mar 2018 05:03:15 +0000
Message-ID: <20180308050230.8876-21-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:rowN5XdsuSUP+hbZWZg9TmKulVTPtwLALE53GgeEE4KaD+QtYBlT1jE2C4sOTLPLp22IEo07TELWAPwJnAMwX9/hZ7s0VcWT8dTSwHhHYTS6UdyAdbEczRGJFYmBGLxVRnYcliZqk/7WWifIy31gvDUc7N6JyyxZ2UUhGpf7pABLpbomt8X7PW7y3k0d/Cdx9oBsT1XfeNGlR+BHHCvFkHn1ev5UOLbiDpRSIPZCnbGVqlYYKlDXl5XT6CImwQZU;20:kzENC2DO69sz1ViF3n307frsdGDxiMYnz/IIRU4xNRsELwwiEZnikSCdsmBDlKtKgs4dC+zc7hVsRav7DbF+loKoadThEIJ+Fkm+UewHZuZFMt7kfC4a6mCcphmsT6M8wNfg7VRnyh/rtMTC3NT/yc4Jf/haWk/GIfXfKInCN0A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49e25d84-3765-46c4-6eee-08d584b2a96d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08711366D8AA22BE9111DFB4FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ToT6RVHGCKP9ixEVIteyTjBUGeb1hclVkg3QJLTZJcPXb5Rc28OgbqE7CBJlIwunZVXh9r6FYuad31THO3EMtqILvmp+g4sgMALpcQ2zrQ7R6DtQ68cUBsc71rpxObHvbIFd1KiZYNqXqOSdYywiWp6Vhv/fGsgunD3YQFtrNqG4ZdMhkQK8/9zh9uPKROpr6McLpgEhOfzxv+OPwBC6jajKEBBzw/e++qfjuyhpNmLznqHvgo4Nrg1Y9d91nhb2ZxxQBw3OrpQbcRUBWin3CAg/GWZjKLI9jcVJ/RblvG879JuK8tWB/ltIuzKx6+tVP05ew+JFMM/xyAu1vv3nhw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e25d84-3765-46c4-6eee-08d584b2a96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:16.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index f705356f538b..8d61c870643e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5322,10 +5322,6 @@ void tcp_finish_connect(struct sock *sk, struct sk_b=
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
@@ -5380,6 +5376,7 @@ static int tcp_rcv_synsent_state_process(struct sock =
*sk, struct sk_buff *skb,
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	struct tcp_fastopen_cookie foc =3D { .len =3D -1 };
 	int saved_clamp =3D tp->rx_opt.mss_clamp;
+	bool fastopen_fail;
=20
 	tcp_parse_options(skb, &tp->rx_opt, 0, &foc);
 	if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
@@ -5482,10 +5479,15 @@ static int tcp_rcv_synsent_state_process(struct soc=
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
