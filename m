Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839528-2-3694150143384089054
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
    1524839527; b=QNrh06sljjazSqWhFNkVppJCj9mndD8UiFzjsOvOOcw5Wy8srz
    pDcJ3nsE0cZEDwlgaULgxp1zMEM+nJQkh+91X+U32GU8t3HMlX57ZtlOU2kfJUMn
    PysvTNtexVtvsefIAV+WGDUTQwdKEv7IwACsNCLIfsmPDAah09+om+yjmJLwn9Cu
    ULu679EF6Q4r60Z5n8sxWtw5/4D2vPrFvyJcz3F4NOp7AXc366zgqsPOMg4skExi
    JVd1VOMR+BSikTHruJDTrbvk8Mi3rdcHKq2W6a7pHnaqyGuC8BFUFsJhuIVXXE2J
    +c3iUy6w6o+l52iS5GvSW5dvgOMsRue5om+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839527; bh=4r0ULE0gHzScBRotC8nnCc+Zub5ut6
    B1bY2eMMC26bk=; b=K06f/RdFcUe+ej4TzuMYE0opm++gg54bNBwl/ZhQUTN/O0
    CIqBq8sqEw53iA3NYWIJGQIOyWi30PJPjZ3vo0IkHOPvrdMxciWNI+2/qdxyQL7f
    kurpxb1GZoOT88zvepRJX/mseOOFqrPmjWz4U8XVlZqMfD0Fb+fR0+ccUmNPlD6p
    qOVtwA2O4N/SRtYSSySobe9dw9/ke6NhH/EXDVbEcmGQ+0DYPRSI6X7RFnDl/dH7
    cCptM/OePUFJ5WPMH6fgRXLZqeA24X/kLW7TgQUcgfziH4ZL44KtmNYBU2bZkDfZ
    nwRCfdCzMV4UxIMn7opYZZBBfgvCaLETC8ZYGmzg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfMY8mC6Ka4T/qgL4WaEn3cerAU2OhNZQP3AFDAUKsPkv8Wc6cou0XglQrcEZBZSS6o+2R7GPKERKwmdVaFcHACFxrv3SDKNgr4zX8MH/I9cHc85tru+L
    nRErG4CcFZGgUu54yX0ZELRKEdgY1Tbn1UxplbDUJfiQ7BbwOEzqBjE+Qf8JOX5vbV12MFJp2dNIanXW4x6xj58x/rLW7hx8GHdwmKb45b5F8dFw7Kybs3Tc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=LpQP-O61AAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=3VAYN3PgkM0li9fC21QA:9 a=QEXdDO2ut3YA:10
    a=pioyyrs4ZptJ924tMmac:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934849AbeD0OKb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OK0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B7B21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Sami Farin <hvtaifwkbgefbaei@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 27/81] tcp: clear tp->packets_out when purging write queue
Date: Fri, 27 Apr 2018 15:58:29 +0200
Message-Id: <20180427135744.708942422@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Soheil Hassas Yeganeh <soheil@google.com>


[ Upstream commit bffd168c3fc5cc7d2bad4c668fa90e7a9010db4b ]

Clear tp->packets_out when purging the write queue, otherwise
tcp_rearm_rto() mistakenly assumes TCP write queue is not empty.
This results in NULL pointer dereference.

Also, remove the redundant `tp->packets_out = 0` from
tcp_disconnect(), since tcp_disconnect() calls
tcp_write_queue_purge().

Fixes: a27fd7a8ed38 (tcp: purge write queue upon RST)
Reported-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Reported-by: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Tested-by: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2385,6 +2385,7 @@ void tcp_write_queue_purge(struct sock *
 	INIT_LIST_HEAD(&tcp_sk(sk)->tsorted_sent_queue);
 	sk_mem_reclaim(sk);
 	tcp_clear_all_retrans_hints(tcp_sk(sk));
+	tcp_sk(sk)->packets_out = 0;
 }
 
 int tcp_disconnect(struct sock *sk, int flags)
@@ -2434,7 +2435,6 @@ int tcp_disconnect(struct sock *sk, int
 	icsk->icsk_backoff = 0;
 	tp->snd_cwnd = 2;
 	icsk->icsk_probes_out = 0;
-	tp->packets_out = 0;
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tp->snd_cwnd_cnt = 0;
 	tp->window_clamp = 0;
