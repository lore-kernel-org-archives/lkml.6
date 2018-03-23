Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805195-2-1248911842373429809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805194; b=wYWpUEWvSAXmwREjletSnN2bbUQaHTjkz/QV0yKWwOguDWE
    SrdK/mlT4NyQnphC8gHKUbuOZL6WUKOERssLuHDfj32+4wPiRzk8Ln1OZVBmUBe5
    14X/lRV6ClhL9AWiW5lyeoJnLd4TmX/zPgV7fXIvU7GguZFCXditTXl9mttCOXsE
    X80uyYhUsdO2DjEqhXXMDJulzeXpYGtgU0c0Gegq3/eQ7nxVZqafM5yWnZYUEOhx
    ubolHgPQYOe88wPi0wc6wuIglhcN398Cfl036uBQoAQZvR5yGuMWsl9SAEDbcOyk
    gqiKVh3/vYAG/aR5tFF5m4sv3tzrbfouQznHy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805194; bh=3K4QqGCkzDH5VcXXL0cYu/BtTV
    yZ3/y5tuyyCy9feB4=; b=jsZn4kr3FWJT3sUG6rRW1ZTaOs3ZEc+qdKMyo+Sz+P
    w2ICTK9aSZj/ZCNOYghIhLxbFosnPIcSu+VwY8ZsneOeNEqoewwj1d3uwM25+OgJ
    G5yzlq4ge2EbjsGbKG55bRr3HGeltDPMbcP+a+qT2ui4P/kWDRPdrrsXfiHu5i0P
    Cy3OGx6INZb5KThleci9UTVtIHzC9u6XjekTkzyDhjqrNGbaR28e1Oo/b65KrFNS
    i2c8qCJ/nrtvvSP69iQnXObr0xayIihlhfIBhMM/dIKPCkg37/Lb/A5zls1qgIhA
    SBfXdawsDKPvZdbLWyu+aAwYwT2hXkpiSD3+/1IV0zRg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754681AbeCWKEU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754642AbeCWKEQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <smfrench@gmail.com>
Subject: [PATCH 4.9 004/177] CIFS: Enable encryption during session setup phase
Date: Fri, 23 Mar 2018 10:52:12 +0100
Message-Id: <20180323094205.390766145@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Shilovsky <pshilov@microsoft.com>

commit cabfb3680f78981d26c078a26e5c748531257ebb upstream.

In order to allow encryption on SMB connection we need to exchange
a session key and generate encryption and decryption keys.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Cc: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/cifs/sess.c    |   22 ++++++++++------------
 fs/cifs/smb2pdu.c |   12 ++----------
 2 files changed, 12 insertions(+), 22 deletions(-)

--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -344,13 +344,12 @@ void build_ntlmssp_negotiate_blob(unsign
 	/* BB is NTLMV2 session security format easier to use here? */
 	flags = NTLMSSP_NEGOTIATE_56 |	NTLMSSP_REQUEST_TARGET |
 		NTLMSSP_NEGOTIATE_128 | NTLMSSP_NEGOTIATE_UNICODE |
-		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC;
-	if (ses->server->sign) {
+		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC |
+		NTLMSSP_NEGOTIATE_SEAL;
+	if (ses->server->sign)
 		flags |= NTLMSSP_NEGOTIATE_SIGN;
-		if (!ses->server->session_estab ||
-				ses->ntlmssp->sesskey_per_smbsess)
-			flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
-	}
+	if (!ses->server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
+		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
 
 	sec_blob->NegotiateFlags = cpu_to_le32(flags);
 
@@ -407,13 +406,12 @@ int build_ntlmssp_auth_blob(unsigned cha
 	flags = NTLMSSP_NEGOTIATE_56 |
 		NTLMSSP_REQUEST_TARGET | NTLMSSP_NEGOTIATE_TARGET_INFO |
 		NTLMSSP_NEGOTIATE_128 | NTLMSSP_NEGOTIATE_UNICODE |
-		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC;
-	if (ses->server->sign) {
+		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC |
+		NTLMSSP_NEGOTIATE_SEAL;
+	if (ses->server->sign)
 		flags |= NTLMSSP_NEGOTIATE_SIGN;
-		if (!ses->server->session_estab ||
-				ses->ntlmssp->sesskey_per_smbsess)
-			flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
-	}
+	if (!ses->server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
+		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
 
 	tmp = *pbuffer + sizeof(AUTHENTICATE_MESSAGE);
 	sec_blob->NegotiateFlags = cpu_to_le32(flags);
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -707,15 +707,13 @@ SMB2_sess_establish_session(struct SMB2_
 	struct cifs_ses *ses = sess_data->ses;
 
 	mutex_lock(&ses->server->srv_mutex);
-	if (ses->server->sign && ses->server->ops->generate_signingkey) {
+	if (ses->server->ops->generate_signingkey) {
 		rc = ses->server->ops->generate_signingkey(ses);
-		kfree(ses->auth_key.response);
-		ses->auth_key.response = NULL;
 		if (rc) {
 			cifs_dbg(FYI,
 				"SMB3 session key generation failed\n");
 			mutex_unlock(&ses->server->srv_mutex);
-			goto keygen_exit;
+			return rc;
 		}
 	}
 	if (!ses->server->session_estab) {
@@ -729,12 +727,6 @@ SMB2_sess_establish_session(struct SMB2_
 	ses->status = CifsGood;
 	ses->need_reconnect = false;
 	spin_unlock(&GlobalMid_Lock);
-
-keygen_exit:
-	if (!ses->server->sign) {
-		kfree(ses->auth_key.response);
-		ses->auth_key.response = NULL;
-	}
 	return rc;
 }
 
