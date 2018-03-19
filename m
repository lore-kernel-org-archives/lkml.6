Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480039-2-8187965004958158326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480039; b=OJf8s5QfAd9gjRXXXhyzTMX/rVanLt0nuuHC3NJt/Yjzs/F
    O5nXjml/6Jso1q0tVu9onvLHM+humuYemOdQ+VHKiBiqu7DeOOWSTcffkOeDxjnl
    UdDDBWLntktnd2m7JLFNVGlvLxIz+wRnsV9gClHa6zMMBELqRQRxO0AE+IByCHF4
    q3w7dNrL4AzXf89F5MUn+PyMn7yrA/J0+AzsXhQvOvnjkUsgTDhXXZBn/SnZkdcL
    Zdc2/8WFD5GQw6TEy6lIq1gcWlGBXh8ljNXYP8o8Z61kbYTvqVvDFileBQAh30fS
    DoAZUFvGa1zvxdlVgz+U2vNVkeaHjSaKbOFgKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480039; bh=NDEJwy
    TEql0/KnNwc4B7PNgG9aWD1HiGt14LpR1HLEU=; b=XDsme4SWl7N57MGr4KcNMZ
    l+bhAYZXMlIX7858UepMi+Ge/XanENkn807ALdvhDV4GIPzdsOZ0EOhy9LASyFnh
    1pDcCJdXmBIWMHYabnkOmHK91m/vqRWAbjYThya2mAoQMPSrECBresxd/XNJIsEp
    6aqMn5ggdi6x2KHgMb/aq3M1LUyrCClsYS1gusdkRNIsj69sYoScGKLNyMyW8fHW
    5bCti0pBU7T/yi3WEGRtcJQOiLQvAEZcrJbkrfijf0+ib3RXzSq4iAhVubj8JUxg
    6xSM/gr0X85ENiWUSk1C9VN9KEsu6dajMcpyoi8V1aCTSHr4XcujiftFwHXyF1PQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jHvKDNuk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefjedtnecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jHvKDNuk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefjedtnecuvehluhhsthgvrhfuihiivgepvdel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966422AbeCSRT1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:19:27 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:46817
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966112AbeCSQJO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:09:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 076/167] tcp: better validation of received
 ack sequences
Thread-Topic: [PATCH AUTOSEL for 4.4 076/167] tcp: better validation of
 received ack sequences
Thread-Index: AQHTv5xO3KJ4Eu9U0kqS7FVgwFQQKQ==
Date: Mon, 19 Mar 2018 16:06:57 +0000
Message-ID: <20180319160513.16384-76-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0965;7:+2AgIJ8ERNqCM+K77sCu5Y7JTKvRR4NAm3k/ZLyBses5vM2vXGgy/gbfIXpfzifHnQpp5Jdtnq0RVm1W3/pzOO6WgOPLcswExX5v3JsKAOeEl82LNzZTixSeqfOGSOzLEv0rOYU4XTD5WQbsVLuSSQCITo2J69U+EkzcHB4OEtY2A63+7hXSy78eeldVkhh2G6/D+hiyJ7/ap/CKsBuas7/IjOwBYLbSmufDmteTCzzCH+xJyG1XTDZg0ir/+h0E;20:tNSPE33p8p1zcv/rdFjfjWwkX5RKhOpK8oj3FV85VhiYms+/+qymQp5YD62xMNqD+GU1JgNzFryuPtOi5/ldcAmUB72ecdM0bmiP9/+hPipZ+5L6aryp+iF/cGBW9qXjoDOkdYcPnCzrMNWhzjhRqBiOGta++bWJXdzJ1TecX64=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21c182a3-01c4-4627-922a-08d58db3bb24
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0965;
x-ms-traffictypediagnostic: DM5PR2101MB0965:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09653DA192B5577F92EA8EC7FBD40@DM5PR2101MB0965.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0965;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0965;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(376002)(39380400002)(189003)(199004)(25786009)(7736002)(6506007)(86362001)(575784001)(86612001)(10090500001)(478600001)(53936002)(6666003)(6512007)(36756003)(2950100002)(8936002)(110136005)(54906003)(105586002)(14454004)(107886003)(72206003)(10290500003)(316002)(102836004)(2501003)(59450400001)(5250100002)(99286004)(22452003)(305945005)(6436002)(6486002)(1076002)(76176011)(26005)(4326008)(186003)(97736004)(106356001)(3660700001)(3846002)(6116002)(5660300001)(68736007)(2900100001)(8676002)(81166006)(81156014)(3280700002)(2906002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0965;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RIY1IyW3Fm4+AQYe1voA9hTw+j28mAjeYodFwIb230f7pWad4gE+6ph8vSvoH2AXopgSsCbaA/AgyqVIUpjYpFnSmvvJsU6I0ezvz40f6hqF1d+eGOHhUJ2DSu+bBZkjgqkhutu5n+dmsePXgce6XpYDoF8eZSbVylULQIlFZWSXGRvI6XnC1hNuv2IB/GmLJ09s0ug3sa8oPpt3H/NP21cSifDaktbseTqmUV6bfpXoqpbCDeZD8rX80Hov+svJuckyNJy8ENOERrbdovrk3O48+DlmP91pld1GiqkwmSOfgboJolftXHuV+ESRXVW5WhaOuvX0zb6oPi1GEqKrVw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c182a3-01c4-4627-922a-08d58db3bb24
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:57.6459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0965
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d0e1a1b5a833b625c93d3d49847609350ebd79db ]

Paul Fiterau Brostean reported :

<quote>
Linux TCP stack we analyze exhibits behavior that seems odd to me.
The scenario is as follows (all packets have empty payloads, no window
scaling, rcv/snd window size should not be a factor):

       TEST HARNESS (CLIENT)                        LINUX SERVER

   1.  -                                          LISTEN (server listen,
then accepts)

   2.  - --> <SEQ=3D100><CTL=3DSYN>               --> SYN-RECEIVED

   3.  - <-- <SEQ=3D300><ACK=3D101><CTL=3DSYN,ACK>  <-- SYN-RECEIVED

   4.  - --> <SEQ=3D101><ACK=3D301><CTL=3DACK>      --> ESTABLISHED

   5.  - <-- <SEQ=3D301><ACK=3D101><CTL=3DFIN,ACK>  <-- FIN WAIT-1 (server
opts to close the data connection calling "close" on the connection
socket)

   6.  - --> <SEQ=3D101><ACK=3D99999><CTL=3DFIN,ACK> --> CLOSING (client se=
nds
FIN,ACK with not yet sent acknowledgement number)

   7.  - <-- <SEQ=3D302><ACK=3D102><CTL=3DACK>      <-- CLOSING (ACK is 102
instead of 101, why?)

... (silence from CLIENT)

   8.  - <-- <SEQ=3D301><ACK=3D102><CTL=3DFIN,ACK>  <-- CLOSING
(retransmission, again ACK is 102)

Now, note that packet 6 while having the expected sequence number,
acknowledges something that wasn't sent by the server. So I would
expect
the packet to maybe prompt an ACK response from the server, and then be
ignored. Yet it is not ignored and actually leads to an increase of the
acknowledgement number in the server's retransmission of the FIN,ACK
packet. The explanation I found is that the FIN  in packet 6 was
processed, despite the acknowledgement number being unacceptable.
Further experiments indeed show that the server processes this FIN,
transitioning to CLOSING, then on receiving an ACK for the FIN it had
send in packet 5, the server (or better said connection) transitions
from CLOSING to TIME_WAIT (as signaled by netstat).

</quote>

Indeed, tcp_rcv_state_process() calls tcp_ack() but
does not exploit the @acceptable status but for TCP_SYN_RECV
state.

What we want here is to send a challenge ACK, if not in TCP_SYN_RECV
state. TCP_FIN_WAIT1 state is not the only state we should fix.

Add a FLAG_NO_CHALLENGE_ACK so that tcp_rcv_state_process()
can choose to send a challenge ACK and discard the packet instead
of wrongly change socket state.

With help from Neal Cardwell.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Paul Fiterau Brostean <p.fiterau-brostean@science.ru.nl>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_input.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 71290fb7d500..5720d8155225 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -117,6 +117,7 @@ int sysctl_tcp_invalid_ratelimit __read_mostly =3D HZ/2=
;
 #define FLAG_DSACKING_ACK	0x800 /* SACK blocks contained D-SACK info */
 #define FLAG_SACK_RENEGING	0x2000 /* snd_una advanced to a sacked seq */
 #define FLAG_UPDATE_TS_RECENT	0x4000 /* tcp_replace_ts_recent() */
+#define FLAG_NO_CHALLENGE_ACK	0x8000 /* do not call tcp_send_challenge_ack=
()	*/
=20
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
 #define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
@@ -3543,7 +3544,8 @@ static int tcp_ack(struct sock *sk, const struct sk_b=
uff *skb, int flag)
 	if (before(ack, prior_snd_una)) {
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
 		if (before(ack, prior_snd_una - tp->max_window)) {
-			tcp_send_challenge_ack(sk, skb);
+			if (!(flag & FLAG_NO_CHALLENGE_ACK))
+				tcp_send_challenge_ack(sk, skb);
 			return -1;
 		}
 		goto old_ack;
@@ -5830,13 +5832,17 @@ int tcp_rcv_state_process(struct sock *sk, struct s=
k_buff *skb)
=20
 	/* step 5: check the ACK field */
 	acceptable =3D tcp_ack(sk, skb, FLAG_SLOWPATH |
-				      FLAG_UPDATE_TS_RECENT) > 0;
+				      FLAG_UPDATE_TS_RECENT |
+				      FLAG_NO_CHALLENGE_ACK) > 0;
=20
+	if (!acceptable) {
+		if (sk->sk_state =3D=3D TCP_SYN_RECV)
+			return 1;	/* send one RST */
+		tcp_send_challenge_ack(sk, skb);
+		goto discard;
+	}
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
-		if (!acceptable)
-			return 1;
-
 		if (!tp->srtt_us)
 			tcp_synack_rtt_meas(sk, req);
=20
@@ -5905,14 +5911,6 @@ int tcp_rcv_state_process(struct sock *sk, struct sk=
_buff *skb)
 		 * our SYNACK so stop the SYNACK timer.
 		 */
 		if (req) {
-			/* Return RST if ack_seq is invalid.
-			 * Note that RFC793 only says to generate a
-			 * DUPACK for it but for TCP Fast Open it seems
-			 * better to treat this case like TCP_SYN_RECV
-			 * above.
-			 */
-			if (!acceptable)
-				return 1;
 			/* We no longer need the request sock. */
 			reqsk_fastopen_remove(sk, req, false);
 			tcp_rearm_rto(sk);
--=20
2.14.1
