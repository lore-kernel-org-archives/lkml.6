Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981242-2-17933141699886387890
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
    1523981241; b=gjTh/5U0uwAGxqNfhdfcVWUIbGRaOztlALShuakcC8yylAjSWg
    9XjMj1JaJcA4Oya7lgNH910/jfqJxfJGlivDxPshVRPrvmuugAv2vxTPB1tGODrX
    wRDSZu4yRRAYb7KpGnF1FGFUIgEINdwBI+EYsYdCBvyxxP+FnK7QiTUe2yPoBBA4
    oYfrWftzzjr+BDK9e8HtTtiPYqZTU0kNY13sMTJyMCExy4RgKlMpPqPKnWatDEj0
    hvPkAFK+CAs/rfMQTL59zjAW8b1BEO1sD3TdmUNXDTafrclIzXfS+A4ubK2kOg9m
    WI1oBBzyCc/PssrzRdu68w98ei1b0FvAkUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981241; bh=0U5ZZooJqLlZAkeUZCqBY3UGwzHDp/
    0d0Db2JlSrUjk=; b=vqTDn3xfiNZU4Fr9wJUJWo5O7/U2tuzH8LRBwM1FmiOA/O
    arbMi5maZXpPOIfrVQZu6XVo3D1p2conIbMvFhG4n/eMZYm6ns3r3KG2nPRZ+VWF
    uaXuz2Ss09OuPCm9sEJ9QNK2vXUK+KKh8o1wsFoLag0hvG5kl7vALBXXx6vAc7pv
    re8EQfd42NKdl0KrYF8jZN4Mb21Ml7CSnJ4m4k9+ZiJcsXEn2Knmp3JBPsYv+46h
    cbN7zIwiqlY4Paez3pw/WIEgw3CbT1K1u48JVtn8NYU3TCKFox2gF+b1ODTglRPg
    VvzAW12Z+cHKXUvtggqh7zrsin0HyI4uly3futsQ==
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
X-CM-Envelope: MS4wfDPvVwvZaJkn5t8oTFTe9U9e312557foTINvy4VYYFgGlnvBzCaAapj7G6r3SAW6KRrcIA745o43L5hXKPkAqYi70646nfNLy/twOBP7PLN9z6cH3jUr
    WThX2dNfBGtFD3P0tOtXc/Acyhsx0t5YBr7wGnlCbCSRh/VuX2f7wy9ud2mPut1Wau9AMGEu3crqIYWGL9o4ktDutdQFMEhGZkEJIwblhmUMKYCyS1p1q1Pp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=9umqrep8AAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=LUSmbqw4SSVLpwoNJWEA:9 a=QEXdDO2ut3YA:10
    a=JgnQmf0Qv7X5Eg3d4pfv:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754449AbeDQQHS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:07:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755076AbeDQQHQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:07:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Young <m.a.young@durham.ac.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.14 42/49] sunrpc: remove incorrect HMAC request initialization
Date: Tue, 17 Apr 2018 17:59:21 +0200
Message-Id: <20180417155717.044301920@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit f3aefb6a7066e24bfea7fcf1b07907576de69d63 upstream.

make_checksum_hmac_md5() is allocating an HMAC transform and doing
crypto API calls in the following order:

    crypto_ahash_init()
    crypto_ahash_setkey()
    crypto_ahash_digest()

This is wrong because it makes no sense to init() the request before a
key has been set, given that the initial state depends on the key.  And
digest() is short for init() + update() + final(), so in this case
there's no need to explicitly call init() at all.

Before commit 9fa68f620041 ("crypto: hash - prevent using keyed hashes
without setting key") the extra init() had no real effect, at least for
the software HMAC implementation.  (There are also hardware drivers that
implement HMAC-MD5, and it's not immediately obvious how gracefully they
handle init() before setkey().)  But now the crypto API detects this
incorrect initialization and returns -ENOKEY.  This is breaking NFS
mounts in some cases.

Fix it by removing the incorrect call to crypto_ahash_init().

Reported-by: Michael Young <m.a.young@durham.ac.uk>
Fixes: 9fa68f620041 ("crypto: hash - prevent using keyed hashes without setting key")
Fixes: fffdaef2eb4a ("gss_krb5: Add support for rc4-hmac encryption")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/auth_gss/gss_krb5_crypto.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -237,9 +237,6 @@ make_checksum_hmac_md5(struct krb5_ctx *
 
 	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
 
-	err = crypto_ahash_init(req);
-	if (err)
-		goto out;
 	err = crypto_ahash_setkey(hmac_md5, cksumkey, kctx->gk5e->keylength);
 	if (err)
 		goto out;
