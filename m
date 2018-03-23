Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802494-2-8101763502764618728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802493; b=Hl2vBctBuPfErjAXAoI5NZzjMG2i2nzhGpomM1mZPl3lIvm
    rKyPSYh1X0YFETdfsb5KdoEkjdTM4qGBVtWjpZAUkFAhVJO2gFFPnI2MRxSISdAT
    xhuzszb66f6W9/Kb/5YyEgGfNXKc0kr1G67ItOmT0qu573SF0yMywwGRTwOgIwcA
    runWJyleKZTL5jVktWK7OguAZkCwIENHT4XDkVtRhwxIXfpifbjp9NTrAKP5sgDP
    cofEpenjB0xDrk3EC0xA3vLCch1CKbOD3re0lUt5SWS8DznMO9E3LJzjjrQ6WjV3
    GP3Uh5d1JtNdEQDZHRXGrR7/mcUrrK8DC6XxZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802493; bh=LWFvTOYBTU89bN+nZh3CEDhlEg
    +4XaZmYgQXDEPaGgk=; b=e3bXLn0cMDJVT3UUkJoo6D2Q0JyXxDPeBUVIvXQPqW
    5gsrrdEThFnA9wTW9HrAyRdzOhBn9Y8kWDCHnqNXVJmqoUVz+IiCl8TxnKhL10c4
    AyfnUbH+npS9SjUnvVuM6xi0wJUUyUwx2moGV5vujdk6OIrOzaHyYwVMrDfaU5ht
    DtQHut/D9tu2XVGxAivuths4Cfrk3lZz3IHTzllULDN17GdUHYujeKTISuAeUAKL
    jMi+ACDxkiVzn/OtkuUnv/C2/0JLFAE3RCMJ4hFViqXMHEKLHCy9/eB6yh4HlbXp
    AMqDp4QPBeK+t46c5ewLWYO5GqySFJEOsoN6y1dfJrdw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1755863AbeCWKN0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:13:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755860AbeCWKNZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Shilovsky <pshilov@microsoft.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Steve French <smfrench@gmail.com>
Subject: [PATCH 4.4 04/97] CIFS: Enable encryption during session setup phase
Date: Fri, 23 Mar 2018 10:53:51 +0100
Message-Id: <20180323094157.798345134@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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

From: Pavel Shilovsky <pshilov@microsoft.com>

commit cabfb3680f78981d26c078a26e5c748531257ebb upstream.

In order to allow encryption on SMB connection we need to exchange
a session key and generate encryption and decryption keys.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Cc: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/sess.c    |   22 ++++++++++------------
 fs/cifs/smb2pdu.c |    8 +-------
 2 files changed, 11 insertions(+), 19 deletions(-)

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
@@ -832,10 +832,8 @@ ssetup_exit:
 
 	if (!rc) {
 		mutex_lock(&server->srv_mutex);
-		if (server->sign && server->ops->generate_signingkey) {
+		if (server->ops->generate_signingkey) {
 			rc = server->ops->generate_signingkey(ses);
-			kfree(ses->auth_key.response);
-			ses->auth_key.response = NULL;
 			if (rc) {
 				cifs_dbg(FYI,
 					"SMB3 session key generation failed\n");
@@ -857,10 +855,6 @@ ssetup_exit:
 	}
 
 keygen_exit:
-	if (!server->sign) {
-		kfree(ses->auth_key.response);
-		ses->auth_key.response = NULL;
-	}
 	if (spnego_key) {
 		key_invalidate(spnego_key);
 		key_put(spnego_key);
