Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591245-2-17132393223148683269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591244; b=WnYmGEOP7QxCbd6mO4qNcuLiKS3QKFS7Ex/0G/3qrBCtklw
    nt9SdFZTmB4pfZkEE0AbQlmU8vzIjhhDb6ROGPXaDcmecRmjSMjjIgO2EBSL4HcT
    EUgJ0idLZxYz48d60I9rPdck/hlSr436hYMtLpx0pXITCqoqpRCQUwRXTNBstFUv
    tV/APgp+gdvHJyAwjJ7cL+Op/HRfhfPM+oT/oC4eQk0t0XUM7k8Z4Rvm+Hz7DCUy
    DsVNojje3peFAvNcB02XUDhF8FHXcGv7Pxt+c4E5Sn2fQAbCe1h8J5YAdsBP8j4s
    0giqeG8pY+4qXEUsa43zTQpBnaQbz7OSq4pO4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591244; bh=Xuh0/6KGmpxEkrUX+Pc7RISqYb
    TeEpBGK7Lam/dQmH0=; b=HxDBMNd2QxbNb/j9Cna65BkiOhVGWJ90yDqj1MIMg5
    ay4VUO39YsOZQ2UxJrtzyR9NSOjTUuEWMG0byU1hhS5Va0ryQ/i+BFpw+riqsXsj
    JGABBK9JV24i0mJOZG+kNxKxehDcff/CqlruLWoL3NMZadr84ScTGPWK/Xwhf8Ef
    pmLjUmoS0tvepPiudKRe8VEQkIWQonZkXP93cxZpREq1mOZFy9FDnvWONpG+K294
    gZLLr/40+JYRaEQf4Fz4ALnySjhmmM6VT9tcyIFCCjmcjqSoAUUKI9WCC33SAbMb
    IwdQgHW+q/b9/0H9p2lyDRYaFW6zCGNbT9ZeURNYM7ag==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeBBRHX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:07:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753050AbeBBRHR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:07:17 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 012/156] crypto: aesni - Use GCM IV size constant
Date: Fri,  2 Feb 2018 17:56:33 +0100
Message-Id: <20180202140840.871267023@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corentin LABBE <clabbe.montjoie@gmail.com>

commit 46d93748e5a3628f9f553832cd64d8a59d8bafde upstream.

This patch replace GCM IV size value by their constant name.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -28,6 +28,7 @@
 #include <crypto/cryptd.h>
 #include <crypto/ctr.h>
 #include <crypto/b128ops.h>
+#include <crypto/gcm.h>
 #include <crypto/xts.h>
 #include <asm/cpu_device_id.h>
 #include <asm/fpu/api.h>
@@ -1131,7 +1132,7 @@ static struct aead_alg aesni_aead_algs[]
 	.setauthsize		= common_rfc4106_set_authsize,
 	.encrypt		= helper_rfc4106_encrypt,
 	.decrypt		= helper_rfc4106_decrypt,
-	.ivsize			= 8,
+	.ivsize			= GCM_RFC4106_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "__gcm-aes-aesni",
@@ -1149,7 +1150,7 @@ static struct aead_alg aesni_aead_algs[]
 	.setauthsize		= rfc4106_set_authsize,
 	.encrypt		= rfc4106_encrypt,
 	.decrypt		= rfc4106_decrypt,
-	.ivsize			= 8,
+	.ivsize			= GCM_RFC4106_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "rfc4106(gcm(aes))",
@@ -1165,7 +1166,7 @@ static struct aead_alg aesni_aead_algs[]
 	.setauthsize		= generic_gcmaes_set_authsize,
 	.encrypt		= generic_gcmaes_encrypt,
 	.decrypt		= generic_gcmaes_decrypt,
-	.ivsize			= 12,
+	.ivsize			= GCM_AES_IV_SIZE,
 	.maxauthsize		= 16,
 	.base = {
 		.cra_name		= "gcm(aes)",
