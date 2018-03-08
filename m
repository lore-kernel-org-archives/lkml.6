Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492916-2-6968032732486899915
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
    t=1520492915; b=BXVMZKMsOwUACY7gKg0HZTiHLXO8/aJhjGkyeeTN12OvckW
    1yRTAob2IAVcKTWF0JLWWkdTe99mW2M5zmIm+Lxmn8RL0FxvWmFMQOjVjsl47iS1
    ozfZg1Ezk3eFK8HeXehOL/qwqulFZuUAmxJyNmnuc3R6QrbhyKH0lvWNcJAc6HuG
    HDEfyrma09Ss5mJk9YcF0stJtguCJsMt/Xvm3Di0VSRJJT8u54e2bbIqsr1gLP26
    VsCQ/eSEuhfaneqSBN5bE+wcNrmJGUGmMi0NVPdea9yL11GFkMrDNZgs+cZcCn4D
    zycXBopHVvXgWTlL9/1B2MCnoZi9OXIZZbDa7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492915; bh=u2wbA1
    sPxOCF+hwc4bw6MIvLFwRQYFqdrD2nS6CqTw8=; b=Sc+6kdeWKqqRk0+je4Ewx2
    tKpyeZti+nNThfEDQ5azt4CzaHQWRcHbcaidDJTeHvcolXYKbPXbMs1bLXc+l5uw
    VJdDNek/Qv4CU6ehuPtCLBWQig3nqcKmgqqMld8g21y/vSvFVMX7/EQmbAWSPx/r
    cM2PHTIQg6qaSZXET2LwHHpDQnBTytPxg9Ce15KZa9lF5x3BK8teYfdRQ4Yv6a6T
    g279zpk03J7Tyo2n+pIIeIUmqxJLkhbDtRbi37BevMWlx5LlRKblMR9KsIXslBY0
    EJueueE4wk8bLkD+0YECfdgb0hwoCmX6JfsCKDQ/3IHuHWXPaCwblSNRQhqK9sCw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BVuH5L37 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BVuH5L37 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755222AbeCHE4T (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:56:19 -0500
Received: from mail-bn3nam01on0130.outbound.protection.outlook.com ([104.47.33.130]:45246
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755187AbeCHE4Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 15/78] tcp: allow TLP in ECN CWR
Thread-Topic: [PATCH AUTOSEL for 4.15 15/78] tcp: allow TLP in ECN CWR
Thread-Index: AQHTtpnF5mq/CCUogEiiX4QO+dmIpQ==
Date: Thu, 8 Mar 2018 04:56:07 +0000
Message-ID: <20180308045525.7662-15-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;20:3j0Db+28Pmb60bwtdeXtHb8zkbLXceyOVKRNg5BmfKw4KTLEjuWNLz0T2LMGTqbFeZD7TPhamtHseK5hERuIsaf1n/ZwSCd0f3g0KjtTt7Sj0Vy/vPT031chAyYhjzk8ab1DODGkFBZgZUuMDk4JXCksqqa0c1xlBlINbd2uxos=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b0094bd-32c9-4800-d6d1-08d584b0e7af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11115B0640721792834CDA40FBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: H2IFADi8P+vKzXJZBCrr1XnCiTpnuf1XMkMe/WpGz+1+rDI4sAoqRVShV4xESo0wn72H/mL30aIMCuqRCF75wxcjImPSgq6tON8D1BzCN12Ar+kx6/BmtZPpl4psdqtw+rgvpyO13h6XpLGSzuGezQvbHDJgYexWjq1jkfHfmaNbJNtrnbB8df2HBaRc0e+696bkKF4hPKPGl+AV7U/8QruPoP/NbSvAg442DkI2OmIqZhdjRcB7flgpetGUy5ien7tVMC/ITPUAgPybPlep3ewtVMY+nJsf1CQVRhU1/GzduB2BNFaf8OyFLlBck9f2U+xMmFnQgPQoLStvXc8XEA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0094bd-32c9-4800-d6d1-08d584b0e7af
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:07.6152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit b4f70c3d4ec32a2ff4c62e1e2da0da5f55fe12bd ]

This patch enables tail loss probe in cwnd reduction (CWR) state
to detect potential losses. Prior to this patch, since the sender
uses PRR to determine the cwnd in CWR state, the combination of
CWR+PRR plus tcp_tso_should_defer() could cause unnecessary stalls
upon losses: PRR makes cwnd so gentle that tcp_tso_should_defer()
defers sending wait for more ACKs. The ACKs may not come due to
packet losses.

Disallowing TLP when there is unused cwnd had the primary effect
of disallowing TLP when there is TSO deferral, Nagle deferral,
or we hit the rwin limit. Because basically every application
write() or incoming ACK will cause us to run tcp_write_xmit()
to see if we can send more, and then if we sent something we call
tcp_schedule_loss_probe() to see if we should schedule a TLP. At
that point, there are a few common reasons why some cwnd budget
could still be unused:

(a) rwin limit
(b) nagle check
(c) TSO deferral
(d) TSQ

For (d), after the next packet tx completion the TSQ mechanism
will allow us to send more packets, so we don't really need a
TLP (in practice it shouldn't matter whether we schedule one
or not). But for (a), (b), (c) the sender won't send any more
packets until it gets another ACK. But if the whole flight was
lost, or all the ACKs were lost, then we won't get any more ACKs,
and ideally we should schedule and send a TLP to get more feedback.
In particular for a long time we have wanted some kind of timer for
TSO deferral, and at least this would give us some kind of timer

Reported-by: Steve Ibanez <sibanez@stanford.edu>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Nandita Dukkipati <nanditad@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv4/tcp_output.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a4d214c7b506..04be9f833927 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2414,15 +2414,12 @@ bool tcp_schedule_loss_probe(struct sock *sk, bool =
advancing_rto)
=20
 	early_retrans =3D sock_net(sk)->ipv4.sysctl_tcp_early_retrans;
 	/* Schedule a loss probe in 2*RTT for SACK capable connections
-	 * in Open state, that are either limited by cwnd or application.
+	 * not in loss recovery, that are either limited by cwnd or application.
 	 */
 	if ((early_retrans !=3D 3 && early_retrans !=3D 4) ||
 	    !tp->packets_out || !tcp_is_sack(tp) ||
-	    icsk->icsk_ca_state !=3D TCP_CA_Open)
-		return false;
-
-	if ((tp->snd_cwnd > tcp_packets_in_flight(tp)) &&
-	     !tcp_write_queue_empty(sk))
+	    (icsk->icsk_ca_state !=3D TCP_CA_Open &&
+	     icsk->icsk_ca_state !=3D TCP_CA_CWR))
 		return false;
=20
 	/* Probe timeout is 2*rtt. Add minimum RTO to account
--=20
2.14.1
