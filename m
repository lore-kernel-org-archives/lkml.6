Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164547-2-12555511680556304452
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164546; b=lyL0nu1fVmSv8IOzYpdjEZrl9rNta7D4GulQ17Pu3NiTwGqHHT
    hGFwrthCeM/nan+zVnigCraOjpjmMrF2WGc92Hsh3XgdlqAnfW9gw3NJHUZ8HB0u
    /9RxrXXhQEMtJus7XHKoNOksaCMR6Db9HeK9vI5QHKhkuOjmzyugisgNc/5kamrm
    dHMZPidJXbeUX4XfTpod1VaYpke+EVzsNVDnW1bOkfMwezpo34sA+2dCJNhjUqFv
    HOVWBbxHrhZMQgk6cgh2fL0C8Kb+HKuSUw0aCFK6FlhUwdZcqM9Qtch9FwQ1G8Ce
    Mh6WSJE1jV8XbM7mQZDffyZShRQA+tY8BqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164546; bh=yAcRBSoEVP5G5ZyqlfcmHt/LJQYS0v
    HugHX6gfjyhsY=; b=hLLn4c5SoJUs5pHTPPQ6xT8bNVTHciLMMhsJnHI+Jbsa9v
    Y163zxiSsxsaUalIGPn1cSoYyXJjmkPG/PXobfuVefZrN67s4Gc2OCEKrKxIwUiz
    jPVsXgcvO7bxfdXLMBDfMIdUkRtPO1EVq/5/POYpmjwAQdnjyatJ+e0Nsz9btbmy
    7cEphTWppT/03cxS1/SkNsNMAxx78bmbIQMUH8cmeWcUvXSAAz6I/H7WTiodBwN/
    po9yXnUTDbSd1IWDA0R4I2tZHBvM5MOOv81dcqTDefV6UYaSJjZ1KAPkhybJStoH
    vNHk4cmNhTwAHoGuHcqEUl4/Wdum3ABiLZO0yY4w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=fB9EYrMd x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=fB9EYrMd x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD3G5jLJuLfC2N6IaD1QRAWoVRI9dXEwh3xi+t/+k3ucIZotiH0L4TM4sNW5IAchw6WxqIXddRkL7kemUoUxPZah1b87Xty+ASRv3oCOHaGWYxCDgibK
    6AJdMLEdoYDBvJcJQdOh8Be6e/lQeLEnPQeN/va+bAkHNlsQAxsLjEnOeZgsAtQBZcLlhOKAES/gvkuwnPy6FNe+ydgyf9RIqSmpbA7AajW+z7cYLBycTxQV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=vmLDa1wCAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=e87FW0PGWPbJLDRRSGYA:9 a=QEXdDO2ut3YA:10 a=h8Bt5HTj68qkN2fS7gvA:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966210AbeEXMV6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966143AbeEXJlG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 16/45] sctp: delay the authentication for the duplicated cookie-echo chunk
Date: Thu, 24 May 2018 11:38:24 +0200
Message-Id: <20180524093122.489558564@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 59d8d4434f429b4fa8a346fd889058bda427a837 ]

Now sctp only delays the authentication for the normal cookie-echo
chunk by setting chunk->auth_chunk in sctp_endpoint_bh_rcv(). But
for the duplicated one with auth, in sctp_assoc_bh_rcv(), it does
authentication first based on the old asoc, which will definitely
fail due to the different auth info in the old asoc.

The duplicated cookie-echo chunk will create a new asoc with the
auth info from this chunk, and the authentication should also be
done with the new asoc's auth info for all of the collision 'A',
'B' and 'D'. Otherwise, the duplicated cookie-echo chunk with auth
will never pass the authentication and create the new connection.

This issue exists since very beginning, and this fix is to make
sctp_assoc_bh_rcv() follow the way sctp_endpoint_bh_rcv() does
for the normal cookie-echo chunk to delay the authentication.

While at it, remove the unused params from sctp_sf_authenticate()
and define sctp_auth_chunk_verify() used for all the places that
do the delayed authentication.

v1->v2:
  fix the typo in changelog as Marcelo noticed.

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/associola.c    |   30 ++++++++++++++++
 net/sctp/sm_statefuns.c |   87 ++++++++++++++++++++++++++----------------------
 2 files changed, 77 insertions(+), 40 deletions(-)

--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1001,9 +1001,10 @@ static void sctp_assoc_bh_rcv(struct wor
 	struct sctp_endpoint *ep;
 	struct sctp_chunk *chunk;
 	struct sctp_inq *inqueue;
-	int state;
 	sctp_subtype_t subtype;
+	int first_time = 1;	/* is this the first time through the loop */
 	int error = 0;
+	int state;
 
 	/* The association should be held so we should be safe. */
 	ep = asoc->ep;
@@ -1014,6 +1015,30 @@ static void sctp_assoc_bh_rcv(struct wor
 		state = asoc->state;
 		subtype = SCTP_ST_CHUNK(chunk->chunk_hdr->type);
 
+		/* If the first chunk in the packet is AUTH, do special
+		 * processing specified in Section 6.3 of SCTP-AUTH spec
+		 */
+		if (first_time && subtype.chunk == SCTP_CID_AUTH) {
+			struct sctp_chunkhdr *next_hdr;
+
+			next_hdr = sctp_inq_peek(inqueue);
+			if (!next_hdr)
+				goto normal;
+
+			/* If the next chunk is COOKIE-ECHO, skip the AUTH
+			 * chunk while saving a pointer to it so we can do
+			 * Authentication later (during cookie-echo
+			 * processing).
+			 */
+			if (next_hdr->type == SCTP_CID_COOKIE_ECHO) {
+				chunk->auth_chunk = skb_clone(chunk->skb,
+							      GFP_ATOMIC);
+				chunk->auth = 1;
+				continue;
+			}
+		}
+
+normal:
 		/* SCTP-AUTH, Section 6.3:
 		 *    The receiver has a list of chunk types which it expects
 		 *    to be received only after an AUTH-chunk.  This list has
@@ -1052,6 +1077,9 @@ static void sctp_assoc_bh_rcv(struct wor
 		/* If there is an error on chunk, discard this packet. */
 		if (error && chunk)
 			chunk->pdiscard = 1;
+
+		if (first_time)
+			first_time = 0;
 	}
 	sctp_association_put(asoc);
 }
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -144,10 +144,8 @@ static sctp_disposition_t sctp_sf_violat
 				     void *arg,
 				     sctp_cmd_seq_t *commands);
 
-static sctp_ierror_t sctp_sf_authenticate(struct net *net,
-				    const struct sctp_endpoint *ep,
+static sctp_ierror_t sctp_sf_authenticate(
 				    const struct sctp_association *asoc,
-				    const sctp_subtype_t type,
 				    struct sctp_chunk *chunk);
 
 static sctp_disposition_t __sctp_sf_do_9_1_abort(struct net *net,
@@ -615,6 +613,38 @@ sctp_disposition_t sctp_sf_do_5_1C_ack(s
 	return SCTP_DISPOSITION_CONSUME;
 }
 
+static bool sctp_auth_chunk_verify(struct net *net, struct sctp_chunk *chunk,
+				   const struct sctp_association *asoc)
+{
+	struct sctp_chunk auth;
+
+	if (!chunk->auth_chunk)
+		return true;
+
+	/* SCTP-AUTH:  auth_chunk pointer is only set when the cookie-echo
+	 * is supposed to be authenticated and we have to do delayed
+	 * authentication.  We've just recreated the association using
+	 * the information in the cookie and now it's much easier to
+	 * do the authentication.
+	 */
+
+	/* Make sure that we and the peer are AUTH capable */
+	if (!net->sctp.auth_enable || !asoc->peer.auth_capable)
+		return false;
+
+	/* set-up our fake chunk so that we can process it */
+	auth.skb = chunk->auth_chunk;
+	auth.asoc = chunk->asoc;
+	auth.sctp_hdr = chunk->sctp_hdr;
+	auth.chunk_hdr = (struct sctp_chunkhdr *)
+				skb_push(chunk->auth_chunk,
+					 sizeof(struct sctp_chunkhdr));
+	skb_pull(chunk->auth_chunk, sizeof(struct sctp_chunkhdr));
+	auth.transport = chunk->transport;
+
+	return sctp_sf_authenticate(asoc, &auth) == SCTP_IERROR_NO_ERROR;
+}
+
 /*
  * Respond to a normal COOKIE ECHO chunk.
  * We are the side that is being asked for an association.
@@ -751,36 +781,9 @@ sctp_disposition_t sctp_sf_do_5_1D_ce(st
 	if (error)
 		goto nomem_init;
 
-	/* SCTP-AUTH:  auth_chunk pointer is only set when the cookie-echo
-	 * is supposed to be authenticated and we have to do delayed
-	 * authentication.  We've just recreated the association using
-	 * the information in the cookie and now it's much easier to
-	 * do the authentication.
-	 */
-	if (chunk->auth_chunk) {
-		struct sctp_chunk auth;
-		sctp_ierror_t ret;
-
-		/* Make sure that we and the peer are AUTH capable */
-		if (!net->sctp.auth_enable || !new_asoc->peer.auth_capable) {
-			sctp_association_free(new_asoc);
-			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-		}
-
-		/* set-up our fake chunk so that we can process it */
-		auth.skb = chunk->auth_chunk;
-		auth.asoc = chunk->asoc;
-		auth.sctp_hdr = chunk->sctp_hdr;
-		auth.chunk_hdr = (sctp_chunkhdr_t *)skb_push(chunk->auth_chunk,
-					    sizeof(sctp_chunkhdr_t));
-		skb_pull(chunk->auth_chunk, sizeof(sctp_chunkhdr_t));
-		auth.transport = chunk->transport;
-
-		ret = sctp_sf_authenticate(net, ep, new_asoc, type, &auth);
-		if (ret != SCTP_IERROR_NO_ERROR) {
-			sctp_association_free(new_asoc);
-			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-		}
+	if (!sctp_auth_chunk_verify(net, chunk, new_asoc)) {
+		sctp_association_free(new_asoc);
+		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
 	}
 
 	repl = sctp_make_cookie_ack(new_asoc, chunk);
@@ -1717,13 +1720,15 @@ static sctp_disposition_t sctp_sf_do_dup
 			       GFP_ATOMIC))
 		goto nomem;
 
+	if (!sctp_auth_chunk_verify(net, chunk, new_asoc))
+		return SCTP_DISPOSITION_DISCARD;
+
 	/* Make sure no new addresses are being added during the
 	 * restart.  Though this is a pretty complicated attack
 	 * since you'd have to get inside the cookie.
 	 */
-	if (!sctp_sf_check_restart_addrs(new_asoc, asoc, chunk, commands)) {
+	if (!sctp_sf_check_restart_addrs(new_asoc, asoc, chunk, commands))
 		return SCTP_DISPOSITION_CONSUME;
-	}
 
 	/* If the endpoint is in the SHUTDOWN-ACK-SENT state and recognizes
 	 * the peer has restarted (Action A), it MUST NOT setup a new
@@ -1828,6 +1833,9 @@ static sctp_disposition_t sctp_sf_do_dup
 			       GFP_ATOMIC))
 		goto nomem;
 
+	if (!sctp_auth_chunk_verify(net, chunk, new_asoc))
+		return SCTP_DISPOSITION_DISCARD;
+
 	/* Update the content of current association.  */
 	sctp_add_cmd_sf(commands, SCTP_CMD_UPDATE_ASSOC, SCTP_ASOC(new_asoc));
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
@@ -1920,6 +1928,9 @@ static sctp_disposition_t sctp_sf_do_dup
 	 * a COOKIE ACK.
 	 */
 
+	if (!sctp_auth_chunk_verify(net, chunk, asoc))
+		return SCTP_DISPOSITION_DISCARD;
+
 	/* Don't accidentally move back into established state. */
 	if (asoc->state < SCTP_STATE_ESTABLISHED) {
 		sctp_add_cmd_sf(commands, SCTP_CMD_TIMER_STOP,
@@ -3985,10 +3996,8 @@ gen_shutdown:
  *
  * The return value is the disposition of the chunk.
  */
-static sctp_ierror_t sctp_sf_authenticate(struct net *net,
-				    const struct sctp_endpoint *ep,
+static sctp_ierror_t sctp_sf_authenticate(
 				    const struct sctp_association *asoc,
-				    const sctp_subtype_t type,
 				    struct sctp_chunk *chunk)
 {
 	struct sctp_authhdr *auth_hdr;
@@ -4087,7 +4096,7 @@ sctp_disposition_t sctp_sf_eat_auth(stru
 						  commands);
 
 	auth_hdr = (struct sctp_authhdr *)chunk->skb->data;
-	error = sctp_sf_authenticate(net, ep, asoc, type, chunk);
+	error = sctp_sf_authenticate(asoc, chunk);
 	switch (error) {
 	case SCTP_IERROR_AUTH_BAD_HMAC:
 		/* Generate the ERROR chunk and discard the rest
