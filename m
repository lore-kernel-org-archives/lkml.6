Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641323-1519411903-2-6595402240030542957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411902; b=s+pxglGYvCeoi7EMiUwo7E4Aag0DhSzKk4edAhkkdwbCpva
    xs1xU6tpjOa7bOdx4kSNzzfG8tXb2Cgc+Ct+Z/QEJFsuqU9FiBAl2F9hvS1vjTJc
    9UQIIwL4ckd/7laN/SL0QXuBHfbY/vkjBoP607Z60Mgb973VYt6JKont7ugsYBnB
    cjg7Yy0rkDvDsjY2+7ohff+cwEqPzdD6Lu8BFxfyF4QIzjSfGiR1ivnY9qmpdwVK
    30UhIlxkbabb6IM9WNxjiYtOpep3p8jLS354sCNhLZJ3x2RtqPgwSWt4sNaLthGt
    ptXEA+MubZ2bZCrqgSGYxnugDheQWnFNM4zuGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411902; bh=qOuZBK+DLveoEslwRpgoiLYr2N
    /+ElvKtO6KO6jbitQ=; b=v5KXHn/U7TQfGYxxqibNzI728mq1r/bVrpZqBqwC6W
    gKIX5IJXt3/7mDIV6Wwo7yrT0KSgz8yA1UsxyNce0hVfVZz425QeXns37T7H7Imv
    v6iafpiCYpYD92ByXKFv7CQST43+G0POhbNC+oWLd4uBdpEY8Y/0atgtal8E0pAp
    yqZPYB2J0KUco5ZQu1yeKgC1O8gVeHatSUYcIT0526u9zeEOmEJBvo+F4/VGDZYD
    FrExaN/8SqEkNUDIZIPirK3QhIsAqG6UT5hrFzOLgrS7MpdvgWJ8NLsHgEGqVAWm
    xE/rjpSVkn4HXJ2ys7MPphGa29ecDNM5criLwkP/eo9w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934997AbeBWSvk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:51:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934995AbeBWSvi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.14 054/159] binder: replace "%p" with "%pK"
Date: Fri, 23 Feb 2018 19:26:02 +0100
Message-Id: <20180223170750.142875604@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Todd Kjos <tkjos@android.com>

commit 8ca86f1639ec5890d400fff9211aca22d0a392eb upstream.

The format specifier "%p" can leak kernel addresses. Use
"%pK" instead. There were 4 remaining cases in binder.c.

Signed-off-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2141,7 +2141,7 @@ static void binder_transaction_buffer_re
 	int debug_id = buffer->debug_id;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
-		     "%d buffer release %d, size %zd-%zd, failed at %p\n",
+		     "%d buffer release %d, size %zd-%zd, failed at %pK\n",
 		     proc->pid, buffer->debug_id,
 		     buffer->data_size, buffer->offsets_size, failed_at);
 
@@ -3653,7 +3653,7 @@ static int binder_thread_write(struct bi
 				}
 			}
 			binder_debug(BINDER_DEBUG_DEAD_BINDER,
-				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %p\n",
+				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
 				     proc->pid, thread->pid, (u64)cookie,
 				     death);
 			if (death == NULL) {
@@ -4991,7 +4991,7 @@ static void print_binder_transaction_ilo
 	spin_lock(&t->lock);
 	to_proc = t->to_proc;
 	seq_printf(m,
-		   "%s %d: %p from %d:%d to %d:%d code %x flags %x pri %ld r%d",
+		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d",
 		   prefix, t->debug_id, t,
 		   t->from ? t->from->proc->pid : 0,
 		   t->from ? t->from->pid : 0,
@@ -5015,7 +5015,7 @@ static void print_binder_transaction_ilo
 	}
 	if (buffer->target_node)
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
-	seq_printf(m, " size %zd:%zd data %p\n",
+	seq_printf(m, " size %zd:%zd data %pK\n",
 		   buffer->data_size, buffer->offsets_size,
 		   buffer->data);
 }
