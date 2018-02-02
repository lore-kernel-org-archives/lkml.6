Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591317-2-18396565388342063901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591317; b=Rx1tV8WlKvOgII6eVXaR9rz1CKIvtw47K+TCJ9i0aKFmNVV
    zSCBdtwS3GKTlQRvgiONc7T6FYZWJcVeunAIKQCWMngyREbUifVQ/UaPrxrFGej5
    CnHrpkz+DU1TC+i5YnFVa7xY7rrzkCWyX9TJgMjdf6uXoe7P3e/L+lVVFh9qLNAn
    G2jmHOk/xOQc31Yz8Cu6mpj4SvkkdfS5L73CvarQ0mIPeDxC/PRcu1Igv6CYrRWD
    L8xJ1OSK8oI/pHW9qz2nwPcu+I3v5pTNBbEij/7SwJtN9xqW1t6/Bfm1uZqbjqYl
    WFDq1cx2O3vOv5QmKOOmPHlqxdKpgZf5k4jQbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591317; bh=rFYFGB+a80WhrWVF2/souyb5P0
    0m2v0OL72P0T3yBoA=; b=nkGAggf22fv7kdE/BxVvMWFFbHdPR4OOhTLgrWjoVr
    szWaJhjXoHEtjTO1nloA3jefxijFjwFvAjyCaPBJ/zGDGMF6dg2MaOoD3CQVAfe4
    WEdi/wIDMSWIN+dy5MQpQ+XW2/o2Angb3L75ZbdCdbT8nUzC2blhWI3AcCh+nXud
    BdTkDGE8VOpr6pVgEvvNXDL3/rabJQYTiE730chUbKlNKsjntfLeJfP7A8EtCqNL
    J8xCJwDkpwasK07T6/ecZWljx+Tg51Bmk14KzPR1CgO59xys8o8kdS0j/hsfBg78
    FpCpIW5DHF95VPgWpnUSkCLjpDIme5D96MN99nC9HR6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeBBRIe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:08:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeBBRIa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:08:30 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 008/156] crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH
Date: Fri,  2 Feb 2018 17:56:29 +0100
Message-Id: <20180202140840.702526537@linuxfoundation.org>
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

From: Hauke Mehrtens <hauke@hauke-m.de>

commit b5b9007730ce1d90deaf25d7f678511550744bdc upstream.

This fixes a typo in the CRYPTO_KPP dependency of CRYPTO_ECDH.

Fixes: 3c4b23901a0c ("crypto: ecdh - Add ECDH software support")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -130,7 +130,7 @@ config CRYPTO_DH
 
 config CRYPTO_ECDH
 	tristate "ECDH algorithm"
-	select CRYTPO_KPP
+	select CRYPTO_KPP
 	select CRYPTO_RNG_DEFAULT
 	help
 	  Generic implementation of the ECDH algorithm
