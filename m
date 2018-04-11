Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479585-2-1434667662144018260
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479584; b=FSrqLRLRVlLBs47gBolR9gOHLn3YOAfGZ7FkBEtKhnHOfnNSR1
    eNPALc/xogqu3z5pdGOWUmlxtWOUeHHDgzSy9xDKQx9pLXAn0P2P0TRnBJd7ki3b
    wfayHhc7b5PkgwFqrRIqd6l9yz4Wx+Uph1TaUZf3WyXGGwuc+Fa3Fks3y3nU4a5X
    di5yrIfdCe/ZfWOl2IX5ai/xy4Yhm+NrxCv5l0vKU2IZBtVUIDs/RE0/YtlSRKMD
    AmqvroQeBLbL9DsY1Bz+D156aoPgehqZB/A2yWJk+K2ttwbHw0EUGdrt6/INiqBe
    sRl9BdCFzB8VX0U0h0J6lLUn51aeU/OnnZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479584; bh=DMjpnfKsSB6hJVu2Bu+7Rdmn36YzCr
    cPPWsXGA2XNE4=; b=TRDmS/xq4ZFGXj+C+BTxjcURUe0vGR6n5MrMn6hN50Bc91
    N9DTuKip54v4wE/Kon2AgRsRHkRbMa+8sfT1F1mA/MBepZd7O71weiTd1nudRi6b
    ywobifPuCp5hCioJtt4NQEitw6a4i30jQXlt4GBI3yOqAaIIJW1xxIUo3L06sX/g
    dpituQAC6wwY+Epgmd816sFzqGXnl4cMGzhOiovy3QLW8gspIniom9CpgbgChLlw
    O7stCyiYL6QO5TCKJhaOiX2MqrmYJuRQVxOBH6oQlTibhrgBYsw4qhmxD1o+/LL5
    RD4+ILpIkxbTpbM4ONbI+Qz99JezC0GapIaM2JKA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNZ9eSiOCHa2xwsJ8NJWUiJA0x2+Kof/agM/ZmunlT+pNlAGMB2W9DO+zjN82DcqASHyblTnWSPWmFpNcH9gQ/1xHpvyUrS8Cx3HM+ZhmjUPiCtZwPPH
    SrN1C8veMnmobNdMdHeQy2qN/vCWAljY3DeJITfmyoMuyyvNe7F0ejkYQoEJeOljhaN3JXwWthTKc4/EXnOBzbBNN8vfj5iWrEN2UOleMJT6nfIiVAeq4e5G
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=buCa4L3iAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=_5g8oyc6Hk8A3yuXiVAA:9 a=XQ05QUOBKMVDWQT4:21
    a=5y6qJeGN1XDxJ6y5:21 a=QEXdDO2ut3YA:10 a=IMuoOq4hwIHYq4UcDgsZ:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755759AbeDKSqo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:46:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755740AbeDKSqm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Paul Fiterau Brostean <p.fiterau-brostean@science.ru.nl>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 075/190] tcp: better validation of received ack sequences
Date: Wed, 11 Apr 2018 20:35:21 +0200
Message-Id: <20180411183554.811361884@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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

   2.  - --> <SEQ=100><CTL=SYN>               --> SYN-RECEIVED

   3.  - <-- <SEQ=300><ACK=101><CTL=SYN,ACK>  <-- SYN-RECEIVED

   4.  - --> <SEQ=101><ACK=301><CTL=ACK>      --> ESTABLISHED

   5.  - <-- <SEQ=301><ACK=101><CTL=FIN,ACK>  <-- FIN WAIT-1 (server
opts to close the data connection calling "close" on the connection
socket)

   6.  - --> <SEQ=101><ACK=99999><CTL=FIN,ACK> --> CLOSING (client sends
FIN,ACK with not yet sent acknowledgement number)

   7.  - <-- <SEQ=302><ACK=102><CTL=ACK>      <-- CLOSING (ACK is 102
instead of 101, why?)

... (silence from CLIENT)

   8.  - <-- <SEQ=301><ACK=102><CTL=FIN,ACK>  <-- CLOSING
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -117,6 +117,7 @@ int sysctl_tcp_invalid_ratelimit __read_
 #define FLAG_DSACKING_ACK	0x800 /* SACK blocks contained D-SACK info */
 #define FLAG_SACK_RENEGING	0x2000 /* snd_una advanced to a sacked seq */
 #define FLAG_UPDATE_TS_RECENT	0x4000 /* tcp_replace_ts_recent() */
+#define FLAG_NO_CHALLENGE_ACK	0x8000 /* do not call tcp_send_challenge_ack()	*/
 
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
 #define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
@@ -3543,7 +3544,8 @@ static int tcp_ack(struct sock *sk, cons
 	if (before(ack, prior_snd_una)) {
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
 		if (before(ack, prior_snd_una - tp->max_window)) {
-			tcp_send_challenge_ack(sk, skb);
+			if (!(flag & FLAG_NO_CHALLENGE_ACK))
+				tcp_send_challenge_ack(sk, skb);
 			return -1;
 		}
 		goto old_ack;
@@ -5832,13 +5834,17 @@ int tcp_rcv_state_process(struct sock *s
 
 	/* step 5: check the ACK field */
 	acceptable = tcp_ack(sk, skb, FLAG_SLOWPATH |
-				      FLAG_UPDATE_TS_RECENT) > 0;
+				      FLAG_UPDATE_TS_RECENT |
+				      FLAG_NO_CHALLENGE_ACK) > 0;
 
+	if (!acceptable) {
+		if (sk->sk_state == TCP_SYN_RECV)
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
 
@@ -5907,14 +5913,6 @@ int tcp_rcv_state_process(struct sock *s
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
