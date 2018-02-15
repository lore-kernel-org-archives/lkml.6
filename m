Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709076-2-11394621468442323548
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
    t=1518709074; b=KAcaEOpiKkEdeexDdO32VPgEfUkyvR4wisIZJklmc7XiKNM
    U28I87ksi+g8iJWCWEAIF+NuHFKOpThQ2yTL/TRzE9Z6nI0CC8eRwy4CO4QmGzy4
    6CVFrrx/sn2I17/7th80qUaCXtQ03m+Dru1qrQk1mTfTPTV4cigbkbSEcpvwpgqS
    r5QdEWirRugvUQ+tYLOXKSABkfkhqwTj2pJBfpvEpcwsQhIwzcybjA2HLWIlw8Mq
    8m2w29vb4VEwrDiBWMGuBumsqovgQXiEBLxK64Vg8zqaMXFjQ4MdlRbV6p6/mAA+
    lhyrcECgMjM0SuUhG4l+5yJukCggS2/A9RLyHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709074; bh=K5ZQmwsXD24MvHk+LC1wE5E6H2
    OV1xxUphZGYRX9fIE=; b=YXakj4zwHVzdcpTYLSIerLpTVNT+nFEyvmH56vVEfj
    iTCfYCFWlgFNnSP0DhxDgvW63CanTerGiQStikQ1pyj5TMbWVZzP21UNwSwMfb7K
    EYTttsDnURiZ/fg+s97T4fJo/GgVf9j9/2rQg4FMGJ0NNf/DObHmUYb5X9Cd6Yyq
    Lp0nhqqtJ5TRXl45c8nuZOrmV/kx3UxKdRpLdS10i6HQnLVaWBVP/J6S9OvWRTdo
    GIYDAlultdxs5MFLf/NflUD5ZT9qSDyWhhQDuiEBPR+SWRsF0GKJRgXWDuv6Q/vU
    loaByKC6C+YTkucMI5G47qJHDnic3e6KqjBVwSJOnSRw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423192AbeBOPhu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:37:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422752AbeBOPhs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:37:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 180/195] lib/ubsan.c: s/missaligned/misaligned/
Date: Thu, 15 Feb 2018 16:17:51 +0100
Message-Id: <20180215151715.225755940@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
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

From: Andrew Morton <akpm@linux-foundation.org>

commit b8fe1120b4ba342b4f156d24e952d6e686b20298 upstream.

A vist from the spelling fairy.

Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/ubsan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -281,7 +281,7 @@ static void handle_null_ptr_deref(struct
 	ubsan_epilogue(&flags);
 }
 
-static void handle_missaligned_access(struct type_mismatch_data *data,
+static void handle_misaligned_access(struct type_mismatch_data *data,
 				unsigned long ptr)
 {
 	unsigned long flags;
@@ -322,7 +322,7 @@ void __ubsan_handle_type_mismatch(struct
 	if (!ptr)
 		handle_null_ptr_deref(data);
 	else if (data->alignment && !IS_ALIGNED(ptr, data->alignment))
-		handle_missaligned_access(data, ptr);
+		handle_misaligned_access(data, ptr);
 	else
 		handle_object_size_mismatch(data, ptr);
 }
