Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184629-2-16086666890561468180
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
    t=1518184628; b=L1e+pcmzH+LzdDhFht0G8fDkyyG9NM+J5fRpW+jsx60uEUT
    fqQ33GkO0UGN/Z3nMfyJuhHeZ76cqTHbg6RrdIFOUTnGmcGOyjmnE6VZxkjsRwt9
    wqlfT7eXXzpMjLunv+CWpszEZQHPYN/RRAnr7sp/qajAUOrokJic4btoOt3Bd3AA
    a56MHqKfdyLZyi5n80mQG2/Dizf2EFRQSRqU4pwXikEVqv2EwMpS4ZstextzRTp2
    Xw2z9S9xvTMQQ1rIsffC2lEAilkHyR7pSoPJ7UJ1q4yzq8mo9ngT1EO0TylvJeQ2
    GXUqCtq/E0ef2Rbu7UdwWyiXMfXw2BaTbqyMTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184628; bh=B7C5UtEFraJojnxpHGFUfAc/1Y
    vBRG6NAzvMJt+J/38=; b=XfOjf5HHV8Vmsfg8bY5vt7yv8thVVOC8fqvh+2SEJH
    BJFwbYlMDW8i/8YSI2xnAFzTm1uDSGxISN9kVjDvbS9IlRIb6L4dbQdtmNR/gtp4
    uKcATGCfGtAsbXFxxkRyRNC+j6mZRChyxX7rKAxeqdmea4ZiMdWWuU+LayM08Ito
    Yl37nKxmTjkO0PkjL9nb3Kkzk9GHmwggNJQmPNednW6Spq8FeOcFBzcss8BupISK
    D+xfz7RAYVIrVz06p1ePcs1mBksMhXd1WDL0uSWs5fPpnm21Kp4JnCy5eB5/Ig5+
    toLOE5qQkoUgKpcpKeQs+npN1pt6l2CT2ReTvKC+mHWQ==
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
        id S1753044AbeBINpB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753475AbeBINo6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:44:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.14 01/22] .gitignore: sort normal pattern rules alphabetically
Date: Fri,  9 Feb 2018 14:39:50 +0100
Message-Id: <20180209133934.128031413@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
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

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 1377dd3e29878b8f5d9f5c9000975f50a428a0cd upstream.

We are having more and more ignore patterns.  Sort the list
alphabetically.  We will easily catch duplicated patterns if any.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 .gitignore |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

--- a/.gitignore
+++ b/.gitignore
@@ -7,38 +7,38 @@
 # command after changing this file, to see if there are
 # any tracked files which get ignored after the change.
 #
-# Normal rules
+# Normal rules (sorted alphabetically)
 #
 .*
+*.a
+*.bin
+*.bz2
+*.c.[012]*.*
+*.dwo
+*.elf
+*.gcno
+*.gz
+*.i
+*.ko
+*.ll
+*.lst
+*.lz4
+*.lzma
+*.lzo
+*.mod.c
 *.o
 *.o.*
-*.a
+*.order
+*.patch
 *.s
-*.ko
 *.so
 *.so.dbg
-*.mod.c
-*.i
-*.lst
+*.su
 *.symtypes
-*.order
-*.elf
-*.bin
 *.tar
-*.gz
-*.bz2
-*.lzma
 *.xz
-*.lz4
-*.lzo
-*.patch
-*.gcno
-*.ll
-modules.builtin
 Module.symvers
-*.dwo
-*.su
-*.c.[012]*.*
+modules.builtin
 
 #
 # Top-level generic files
