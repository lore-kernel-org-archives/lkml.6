Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494356-2-6565916930767942151
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
    t=1521494355; b=YqV6d61DB4gt9ZeeVBu3dzw11ECr710FPprl2k7s5z8hyhE
    fHB76/HuRNAxsN4dRf04woGekI/QPcAmHyi1/FNOSwO+/b0xLOe6LOXX1/znxpgy
    m1flmOXCM3/svNaTX4WjpI77ND3hDGhQU9hqDK3wdw+jxiAmZppeMUWpY4Y6NBGu
    0/XgtNWa3nZ5YcCCHrzx1uoUcHCHaHJUa0/wo1IE/4aKCFIfdayMFvOVxwy7QQau
    a6PURn26XZCfcH57rR5Yh5SMlcJDSPH9lOxoHTQzJTaPTm5np0Whh8gB0Lhbq0zr
    gFQx9dlkHQYyeNI4NESCxtM74uXFhHtJq6hsjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494355; bh=c3Iqo4
    AmgKbYiX4m7D6uaYWV+Npay6nOl3fSglsAU/k=; b=OTlty7tfzaDpbgK8v0KkOh
    AtpHCseSMQpoyyj7g75yJQI+8wdmdjtP6jtEYiLSH11sE+C5Rtv3bFGKqBDCdsic
    dbBJuwxIPe68FtuyqGS2VU54v/fvM6yxxqfsFA67hOBaAZ+BAzRVGtcPl0kY9qbe
    spuv+jx6dlY9oE23X284PGiNgWRVY/Q5MMANXpyrS08tZ242Lwdl2O08biVH1dmU
    871oPjt1ypIlEU/I6SfEF0e+IuERbZAuklBHh3nUw0KxgA5mJxU8oxyCB1Z7/S+4
    r3IVKZH+dW5jzjUB+QwjtxAVHjg1kximc7H2r/SDGVgF2veedopq+fpFjXTnImaQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NR478GbP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefjedunecuvehluhhsthgvrhfuihiivgepje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NR478GbP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefjedunecuvehluhhsthgvrhfuihiivgepje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969464AbeCSVSg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:18:36 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:39043
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965267AbeCSQA7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 110/281] tcp: better validation of received
 ack sequences
Thread-Topic: [PATCH AUTOSEL for 4.9 110/281] tcp: better validation of
 received ack sequences
Thread-Index: AQHTv5tXCpucKpYLJkau0sXcR2hGpw==
Date: Mon, 19 Mar 2018 16:00:03 +0000
Message-ID: <20180319155742.13731-110-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:Ta3pLxXIZsRv8PvNwv6xNObYpDbsFkbD2tRTed4akWU8G6KY5uFhDKZ/7wiob2q5XbiDo/IsxxIGTLC+ubOoGmnhccqPubtl1hurAm/lGrrbd8YeCYkRAmJOh5iZ84JEiUv6e94AQRu+NasqK/rjs+dbpM94ZYAD1OANdA6nFwEhOeAirkQECnnILWgZcpdly9db3fLtuolNe8LSnV0mV+2Mj7bn9lrg0BiObEVPRyMeZKt6TV58JdxEQwUu9cuG;20:jObly7xWV1MKE2XRuO+kzTPdzA/E6yZqqVs4efYO3u3f+kBjri/YY/tuyP3JJOGwU8pes2xwOmEPxV56Z7U5yf+jut2Ow4kYrule6/y7jjg1RLaCBXhHubm6oKZ1Lbe9tZbwJJodwMp4Ic67jiiCmpd7plW1dIUSuWBQQT/rjFg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 222f06ef-6c48-48f7-c1fb-08d58db29605
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015E985751B17973FF1F0AAFBD40@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(97736004)(72206003)(4326008)(99286004)(2900100001)(1076002)(186003)(10290500003)(36756003)(25786009)(66066001)(86612001)(102836004)(54906003)(110136005)(575784001)(26005)(86362001)(53936002)(5660300001)(6512007)(14454004)(478600001)(106356001)(107886003)(316002)(2950100002)(6666003)(22452003)(6506007)(7736002)(3280700002)(3660700001)(305945005)(8936002)(2906002)(6116002)(3846002)(6436002)(68736007)(2501003)(5250100002)(6486002)(10090500001)(76176011)(8676002)(81156014)(105586002)(81166006)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Y3/CIizTqEQ9uRXoBibSeYUlWTiz3CyptLKFSRTO+4wOtlxdlFPQo/Jh1rz//QzmHZVdr+MyENP8kHkRdQJvn5EA6T1zGjBQlFtlLKCAqEcYCZN6i1LU0pDxaSgcnxvfRJdiFBUJhInMb1Mot55/Lbt7HGz/gl9W5WoPw0iamnmZ6sAa24K4ADuR+deqca1s9IUlLjc1Tz1KgYZhMTk/B6Xi0LFeAuNxSwejzD9EHb7ebaYx7Crs3VWojoI1Ut4CQ7Z1YA3pP1BP+BhK0uOZWpitI3q2yIDg7F/L5JjHuXrMAaxLKZCCTyUyFkCVZw58baQ8JNb7fSKjqv51IVIhFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222f06ef-6c48-48f7-c1fb-08d58db29605
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:03.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 2f107e46355c..0c30f8fca07d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -115,6 +115,7 @@ int sysctl_tcp_invalid_ratelimit __read_mostly =3D HZ/2=
;
 #define FLAG_DSACKING_ACK	0x800 /* SACK blocks contained D-SACK info */
 #define FLAG_SACK_RENEGING	0x2000 /* snd_una advanced to a sacked seq */
 #define FLAG_UPDATE_TS_RECENT	0x4000 /* tcp_replace_ts_recent() */
+#define FLAG_NO_CHALLENGE_ACK	0x8000 /* do not call tcp_send_challenge_ack=
()	*/
=20
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
 #define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
@@ -3618,7 +3619,8 @@ static int tcp_ack(struct sock *sk, const struct sk_b=
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
@@ -5967,13 +5969,17 @@ int tcp_rcv_state_process(struct sock *sk, struct s=
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
@@ -6043,14 +6049,6 @@ int tcp_rcv_state_process(struct sock *sk, struct sk=
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
