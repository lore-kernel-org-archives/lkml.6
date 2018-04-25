Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653124-2-15000353599459570655
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
    1524653123; b=JPw8v0RGdxzpF9KnBjiqIZWqOcgiit9AV+Yy5BUWNCzrPjSsaE
    LeMaKcpH1ggtUmlyaRe9Vc/zZrqWkfEgLZjdmIlqpEj8zp5aafj+XNN9Xc2vn06a
    Dnc3w6kPbDSNZtdtf5RpLidwuyqll0piUqlt/JOkloXWd3HQf+UXegmSMdPWALs9
    pN7LgpjzjZVBC9ztjGru5xZ50K6TAX257WQxkb1XwUyCRPFtQ/de9raGITP/Mq8C
    JOKj8G+cV2tYwsapSOjplHt7SiRjEKxytb7Mbd2+jjC4qgjlQTDrlibnhRSPaKAi
    el6UlcQum+k9sxQuS8mz7qRPEcCmnvfVv2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653123; bh=JrSM6ggs0ZdrrkN1VMhuTuzYSNpR3K
    U9/J1ULHYHjmU=; b=Ju2VNZQBr2WHg1hlUF39VSGq59IkDj0wmeHjZw2TScV99D
    L2450DYHGaTDIdCitYJFMnmoRHqUP77YYQNFHL9VqaE8U2BLXGlikDXsw2KqBcDQ
    95NGACyPoBDrm4NXucodomtwOKdrx5+rKiwSuMMU2WfOdPPvBfTdvahFJWlIbnO4
    aTdOkIKnvDfitBPK9qiOmV9cCUNixCQQhJGHq+a7HE0qFtmO28PNR5LGO+3S2CPP
    ZrPkfH8XVeMTzB7Cw5+DQ5qPqsfIjMx7j+HMdPOqS7YOcmg2Ca0KbJfSBi9RRPz3
    KYd0hez11hjI2A0gF9L9Gbd2VwrCxSEnTcY5QL/w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNS811w9gXRsd65/HHwS0CF8W1WMy2tFFiJuZkOqhfc+YJO76MC3GU9j/e1iRtXlG2thGo6h/vXR4YHfYXtE6q1jccc27RjKfUNUP6NjU4xO8rbBdYJD
    UMaQfUuKiD2WZDBYAhl8bHHu4k32GJ1zG5zWwOfxQeJd747zaoY0pzKBFNC8dZH75hH6BTXCUU7srflxSkRHCUlM3xjHITFSAlIH1GzGb6Q4bVNTG5GJozak
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=Q8eMNLGMAAAA:8 a=BS-Bl4eDAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=fRbur1geQbNQeGRPq20A:9 a=QEXdDO2ut3YA:10
    a=raiHlmlptQsBXkgpqFpg:22 a=Mz5RY1mrK68yK6INR7tS:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754095AbeDYKpS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:45:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754069AbeDYKpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:45:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jonathan Billings <jsbillings@jsbillings.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 153/183] rxrpc: Dont put crypto buffers on the stack
Date: Wed, 25 Apr 2018 12:36:13 +0200
Message-Id: <20180425103248.689790582@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>


[ Upstream commit 8c2f826dc36314059ac146c78d3bf8056b626446 ]

Don't put buffers of data to be handed to crypto on the stack as this may
cause an assertion failure in the kernel (see below).  Fix this by using an
kmalloc'd buffer instead.

kernel BUG at ./include/linux/scatterlist.h:147!
...
RIP: 0010:rxkad_encrypt_response.isra.6+0x191/0x1b0 [rxrpc]
RSP: 0018:ffffbe2fc06cfca8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff989277d59900 RCX: 0000000000000028
RDX: 0000259dc06cfd88 RSI: 0000000000000025 RDI: ffffbe30406cfd88
RBP: ffffbe2fc06cfd60 R08: ffffbe2fc06cfd08 R09: ffffbe2fc06cfd08
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff7c5f80d9f95
R13: ffffbe2fc06cfd88 R14: ffff98927a3f7aa0 R15: ffffbe2fc06cfd08
FS:  0000000000000000(0000) GS:ffff98927fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b1ff28f0f8 CR3: 000000001b412003 CR4: 00000000003606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rxkad_respond_to_challenge+0x297/0x330 [rxrpc]
 rxrpc_process_connection+0xd1/0x690 [rxrpc]
 ? process_one_work+0x1c3/0x680
 ? __lock_is_held+0x59/0xa0
 process_one_work+0x249/0x680
 worker_thread+0x3a/0x390
 ? process_one_work+0x680/0x680
 kthread+0x121/0x140
 ? kthread_create_worker_on_cpu+0x70/0x70
 ret_from_fork+0x3a/0x50

Reported-by: Jonathan Billings <jsbillings@jsbillings.org>
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Jonathan Billings <jsbillings@jsbillings.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/conn_event.c |    1 
 net/rxrpc/rxkad.c      |   92 +++++++++++++++++++++++++++----------------------
 2 files changed, 52 insertions(+), 41 deletions(-)

--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -404,6 +404,7 @@ void rxrpc_process_connection(struct wor
 		case -EKEYEXPIRED:
 		case -EKEYREJECTED:
 			goto protocol_error;
+		case -ENOMEM:
 		case -EAGAIN:
 			goto requeue_and_leave;
 		case -ECONNABORTED:
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -773,8 +773,7 @@ static int rxkad_respond_to_challenge(st
 {
 	const struct rxrpc_key_token *token;
 	struct rxkad_challenge challenge;
-	struct rxkad_response resp
-		__attribute__((aligned(8))); /* must be aligned for crypto */
+	struct rxkad_response *resp;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	const char *eproto;
 	u32 version, nonce, min_level, abort_code;
@@ -818,26 +817,29 @@ static int rxkad_respond_to_challenge(st
 	token = conn->params.key->payload.data[0];
 
 	/* build the response packet */
-	memset(&resp, 0, sizeof(resp));
-
-	resp.version			= htonl(RXKAD_VERSION);
-	resp.encrypted.epoch		= htonl(conn->proto.epoch);
-	resp.encrypted.cid		= htonl(conn->proto.cid);
-	resp.encrypted.securityIndex	= htonl(conn->security_ix);
-	resp.encrypted.inc_nonce	= htonl(nonce + 1);
-	resp.encrypted.level		= htonl(conn->params.security_level);
-	resp.kvno			= htonl(token->kad->kvno);
-	resp.ticket_len			= htonl(token->kad->ticket_len);
-
-	resp.encrypted.call_id[0] = htonl(conn->channels[0].call_counter);
-	resp.encrypted.call_id[1] = htonl(conn->channels[1].call_counter);
-	resp.encrypted.call_id[2] = htonl(conn->channels[2].call_counter);
-	resp.encrypted.call_id[3] = htonl(conn->channels[3].call_counter);
+	resp = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
+	if (!resp)
+		return -ENOMEM;
+
+	resp->version			= htonl(RXKAD_VERSION);
+	resp->encrypted.epoch		= htonl(conn->proto.epoch);
+	resp->encrypted.cid		= htonl(conn->proto.cid);
+	resp->encrypted.securityIndex	= htonl(conn->security_ix);
+	resp->encrypted.inc_nonce	= htonl(nonce + 1);
+	resp->encrypted.level		= htonl(conn->params.security_level);
+	resp->kvno			= htonl(token->kad->kvno);
+	resp->ticket_len		= htonl(token->kad->ticket_len);
+	resp->encrypted.call_id[0]	= htonl(conn->channels[0].call_counter);
+	resp->encrypted.call_id[1]	= htonl(conn->channels[1].call_counter);
+	resp->encrypted.call_id[2]	= htonl(conn->channels[2].call_counter);
+	resp->encrypted.call_id[3]	= htonl(conn->channels[3].call_counter);
 
 	/* calculate the response checksum and then do the encryption */
-	rxkad_calc_response_checksum(&resp);
-	rxkad_encrypt_response(conn, &resp, token->kad);
-	return rxkad_send_response(conn, &sp->hdr, &resp, token->kad);
+	rxkad_calc_response_checksum(resp);
+	rxkad_encrypt_response(conn, resp, token->kad);
+	ret = rxkad_send_response(conn, &sp->hdr, resp, token->kad);
+	kfree(resp);
+	return ret;
 
 protocol_error:
 	trace_rxrpc_rx_eproto(NULL, sp->hdr.serial, eproto);
@@ -1048,8 +1050,7 @@ static int rxkad_verify_response(struct
 				 struct sk_buff *skb,
 				 u32 *_abort_code)
 {
-	struct rxkad_response response
-		__attribute__((aligned(8))); /* must be aligned for crypto */
+	struct rxkad_response *response;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_crypt session_key;
 	const char *eproto;
@@ -1061,17 +1062,22 @@ static int rxkad_verify_response(struct
 
 	_enter("{%d,%x}", conn->debug_id, key_serial(conn->server_key));
 
+	ret = -ENOMEM;
+	response = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
+	if (!response)
+		goto temporary_error;
+
 	eproto = tracepoint_string("rxkad_rsp_short");
 	abort_code = RXKADPACKETSHORT;
 	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  &response, sizeof(response)) < 0)
+			  response, sizeof(*response)) < 0)
 		goto protocol_error;
-	if (!pskb_pull(skb, sizeof(response)))
+	if (!pskb_pull(skb, sizeof(*response)))
 		BUG();
 
-	version = ntohl(response.version);
-	ticket_len = ntohl(response.ticket_len);
-	kvno = ntohl(response.kvno);
+	version = ntohl(response->version);
+	ticket_len = ntohl(response->ticket_len);
+	kvno = ntohl(response->kvno);
 	_proto("Rx RESPONSE %%%u { v=%u kv=%u tl=%u }",
 	       sp->hdr.serial, version, kvno, ticket_len);
 
@@ -1105,31 +1111,31 @@ static int rxkad_verify_response(struct
 	ret = rxkad_decrypt_ticket(conn, skb, ticket, ticket_len, &session_key,
 				   &expiry, _abort_code);
 	if (ret < 0)
-		goto temporary_error_free;
+		goto temporary_error_free_resp;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
-	rxkad_decrypt_response(conn, &response, &session_key);
+	rxkad_decrypt_response(conn, response, &session_key);
 
 	eproto = tracepoint_string("rxkad_rsp_param");
 	abort_code = RXKADSEALEDINCON;
-	if (ntohl(response.encrypted.epoch) != conn->proto.epoch)
+	if (ntohl(response->encrypted.epoch) != conn->proto.epoch)
 		goto protocol_error_free;
-	if (ntohl(response.encrypted.cid) != conn->proto.cid)
+	if (ntohl(response->encrypted.cid) != conn->proto.cid)
 		goto protocol_error_free;
-	if (ntohl(response.encrypted.securityIndex) != conn->security_ix)
+	if (ntohl(response->encrypted.securityIndex) != conn->security_ix)
 		goto protocol_error_free;
-	csum = response.encrypted.checksum;
-	response.encrypted.checksum = 0;
-	rxkad_calc_response_checksum(&response);
+	csum = response->encrypted.checksum;
+	response->encrypted.checksum = 0;
+	rxkad_calc_response_checksum(response);
 	eproto = tracepoint_string("rxkad_rsp_csum");
-	if (response.encrypted.checksum != csum)
+	if (response->encrypted.checksum != csum)
 		goto protocol_error_free;
 
 	spin_lock(&conn->channel_lock);
 	for (i = 0; i < RXRPC_MAXCALLS; i++) {
 		struct rxrpc_call *call;
-		u32 call_id = ntohl(response.encrypted.call_id[i]);
+		u32 call_id = ntohl(response->encrypted.call_id[i]);
 
 		eproto = tracepoint_string("rxkad_rsp_callid");
 		if (call_id > INT_MAX)
@@ -1153,12 +1159,12 @@ static int rxkad_verify_response(struct
 
 	eproto = tracepoint_string("rxkad_rsp_seq");
 	abort_code = RXKADOUTOFSEQUENCE;
-	if (ntohl(response.encrypted.inc_nonce) != conn->security_nonce + 1)
+	if (ntohl(response->encrypted.inc_nonce) != conn->security_nonce + 1)
 		goto protocol_error_free;
 
 	eproto = tracepoint_string("rxkad_rsp_level");
 	abort_code = RXKADLEVELFAIL;
-	level = ntohl(response.encrypted.level);
+	level = ntohl(response->encrypted.level);
 	if (level > RXRPC_SECURITY_ENCRYPT)
 		goto protocol_error_free;
 	conn->params.security_level = level;
@@ -1168,9 +1174,10 @@ static int rxkad_verify_response(struct
 	 * as for a client connection */
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 	if (ret < 0)
-		goto temporary_error_free;
+		goto temporary_error_free_ticket;
 
 	kfree(ticket);
+	kfree(response);
 	_leave(" = 0");
 	return 0;
 
@@ -1179,12 +1186,15 @@ protocol_error_unlock:
 protocol_error_free:
 	kfree(ticket);
 protocol_error:
+	kfree(response);
 	trace_rxrpc_rx_eproto(NULL, sp->hdr.serial, eproto);
 	*_abort_code = abort_code;
 	return -EPROTO;
 
-temporary_error_free:
+temporary_error_free_ticket:
 	kfree(ticket);
+temporary_error_free_resp:
+	kfree(response);
 temporary_error:
 	/* Ignore the response packet if we got a temporary error such as
 	 * ENOMEM.  We just want to send the challenge again.  Note that we
