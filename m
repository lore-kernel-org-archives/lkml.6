Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415211-2-13218291668636571419
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415210; b=lLI6zchGfo/AOtXU57ggI5pkcG1Zs+EanLgE4ZN8sk+zGBt
    4UCHlZd0plNUElIE/4N7uCmn4ZRyOvWvcNpHLFujyVrnLdJvzgsj9ymJycC0Xkye
    +6mPdbl2dVfL3eh5qljAfHOlctIKDwAsMegEPTT3W7GbjX+Kthp9TU3Ww6DwmsxG
    OZDMcIahAEEv2MbvYTvi885L6DHZvsNd2r8bsS9wDdLooIa2CrLQ1pK4w8uCfaZu
    xx79stxzyxliG2BJkd3BWu556mtk2e5FxJX6bN1g4zHuZD6ezQylyZZIOypfISmk
    C5i95W1vw/Ux2HfHqDwsgBcgqApTTlNJOIK4DHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415210; bh=DZ29spuYEgpme/1RjPgDBFvHzL
    3O408ljZkcvOdoGzo=; b=nTnlFrbAMx9QA/Lbik/cBJRMZw09NEL/0nx5YHtFNL
    AkgQKrLWj5GZNux16c5cc9rpCsFv0YaLX3oTe4RSLkacM8xYssBuJSv/axq4qp5G
    RBOaoDg74g2kFP48JfeCR88T5TopsbjyJ+Go5MGnb87moJYxk5J/mK1tXE3Fbxx9
    66nkHR2S3G3MGCEFojY988fcaOoXB67zM5aHPypcN5EvcvXjbjux4m2sLKk01XPT
    gHYCgsA/c1TrQKfWcWiqJUq6FxQDTba689wX+HwEYNdaEV2EJRSoXX/QiWQwBfnm
    v9BdRL6mjM2qULeaU5Wg4EhcwoCoJVCynOehJ0XXMzGA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934214AbeBWSrr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44658 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933902AbeBWSrq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH 4.9 120/145] security/keys: BIG_KEY requires CONFIG_CRYPTO
Date: Fri, 23 Feb 2018 19:27:06 +0100
Message-Id: <20180223170740.329173598@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 3cd18d1981731d5f74b8e437009124ac99905d14 upstream.

The recent rework introduced a possible randconfig build failure
when CONFIG_CRYPTO configured to only allow modules:

security/keys/big_key.o: In function `big_key_crypt':
big_key.c:(.text+0x29f): undefined reference to `crypto_aead_setkey'
security/keys/big_key.o: In function `big_key_init':
big_key.c:(.init.text+0x1a): undefined reference to `crypto_alloc_aead'
big_key.c:(.init.text+0x45): undefined reference to `crypto_aead_setauthsize'
big_key.c:(.init.text+0x77): undefined reference to `crypto_destroy_tfm'
crypto/gcm.o: In function `gcm_hash_crypt_remain_continue':
gcm.c:(.text+0x167): undefined reference to `crypto_ahash_finup'
crypto/gcm.o: In function `crypto_gcm_exit_tfm':
gcm.c:(.text+0x847): undefined reference to `crypto_destroy_tfm'

When we 'select CRYPTO' like the other users, we always get a
configuration that builds.

Fixes: 428490e38b2e ("security/keys: rewrite all of big_key crypto")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/keys/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -45,6 +45,7 @@ config BIG_KEYS
 	bool "Large payload keys"
 	depends on KEYS
 	depends on TMPFS
+	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_GCM
 	help
