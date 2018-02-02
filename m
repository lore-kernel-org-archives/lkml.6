Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591609-2-14765292854665936731
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
    t=1517591609; b=fbu4Ir81v0Q2Pl4vmhju/axOWJPkupV5biJfbcrjW1nhhr+
    rs+x0CwRd8oAdfzgy8YeG6sCHljVbEIdpKeKRiu5JN8+bY1vqGE7BXUm3a8J1V7+
    V3Iwta4o/Sv5OGtgE4zeMJzF6IR4JUiw4fvOCXbk8wBvtMwUgE6hf0W0Z5cl6ea3
    VLeIOkiiA8SHCJuOOKqQ4fivaHUaBOIBZNtXJAZEOGypuxYL8gPmnL4KzNa1PXtZ
    oLKXLeRrHTpaIL4p1d/jOnRich7L0UYnk/2XNSAutrXlVl+pj1CRo4qcxAFgkLym
    ZNZDS23+wJ7FVnPwM/P90dU1Z7VxaJYfKeuSJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591609; bh=aaaxlkwsEV6o7QUiHDxfMKRbUl
    yU9Fol50rBN32AVbM=; b=wZCeQChpHW5pFC8Th2pv4WYqxIEWtvInvgaXqcfTd1
    fa71yWF/I5XeLou7z0sPGktVWXJEbUBlrBHjJGWTWmdKVnnbf65edSvUmaX1nL9I
    Tg54U9ALFEV1bPRhkFijNRgDE/Mhm6kyFu7M2vTutsFCnllA7SCDscg6QAxna3at
    XqefoUHDCq8dkgSvTwcRwVMYU5Cjwm6bZpt3UlWOK02G8/ux1TNgH+JOV8pa58Lm
    UhjZU4q+UPTj97DZdpg27/nQdt0NffmwbsU9fsPUXqty6MSLzLd5qPXmwaFFkrUe
    5uS6oeqTijSCj6ZylF0r/WFL7NeE7wjnPuifiJyCZxLg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeBBRN1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:13:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeBBRNH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:13:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>
Subject: [PATCH 4.14 130/156] staging: ccree: NULLify backup_info when unused
Date: Fri,  2 Feb 2018 17:58:31 +0100
Message-Id: <20180202140846.258179410@linuxfoundation.org>
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

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 46df8824982e4fb0198776078d4a8c3e2d531464 upstream.

backup_info field is only allocated for decrypt code path.
The field was not nullified when not used causing a kfree
in an error handling path to attempt to free random
addresses as uncovered in stress testing.

Fixes: 737aed947f9b ("staging: ccree: save ciphertext for CTS IV")
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/ccree/ssi_cipher.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/ccree/ssi_cipher.c
+++ b/drivers/staging/ccree/ssi_cipher.c
@@ -904,6 +904,7 @@ static int ssi_ablkcipher_decrypt(struct
 	scatterwalk_map_and_copy(req_ctx->backup_info, req->src,
 				 (req->nbytes - ivsize), ivsize, 0);
 	req_ctx->is_giv = false;
+	req_ctx->backup_info = NULL;
 
 	return ssi_blkcipher_process(tfm, req_ctx, req->dst, req->src, req->nbytes, req->info, ivsize, (void *)req, DRV_CRYPTO_DIRECTION_DECRYPT);
 }
