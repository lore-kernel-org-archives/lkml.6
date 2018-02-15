Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709786-2-16714911653604499808
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
    t=1518709785; b=wJwWIq0TYG+Gc0nb+gLmMc59LMs6icg6RPKWHwN/P+O5g/4
    K+5d3OUMJTvB2lZxfeqOQztbr4IP/NfE7dJzCkJ1VOurnU7gZCqyrHWKRhzbCZWU
    eY8Pnlh7YtBrwikXqUvx9Nw4fehmt+lQ+Ec8xmDyvnhIVLs0fbFjGTFTprvOnqhv
    q8qXo750jjHIywJpNELBySTiERNJUBbfxp1uXnWgvrluZcWAX0S9W1nTYZ5vT9Q5
    soJb5nXmFH+njPE/G5VJrvMrrL+m66ztpyMwissySMuYB5AsN22LVPbhJELkxX1+
    HllXsJEUkDfpACUmWDLm6iLPmEYsNDNTIbc2T5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709785; bh=WPKBKLJunbz808X0/Z1c2s0dgs
    O+h0Z1nPbDn8r5EOw=; b=A24Ei8qPgbhLavjEctHlzSW3PH/t63cIP+3N+NPX6L
    r76ze/d3C/QWLMcHPkuQ+ipUWaO3HcGZCAkoZ/f4d/U8E7KDHW1b3FRGZOEXAbZ/
    bnAoA9u1s9wVqoelmQubS5GVSsIlmsnnbvc4NMSjQj9WA2oLu2RCzK0oMuX0Ppx1
    eCMzzq8+3NVtImNgDivt3FoMoM82pjTcR12OEZPu4cTZgdmIB5wMXJYbZ4sNhmHd
    H+sUJBuxz5vIfmMJ0QMleSiBArrsG5BeWldZ2XGZoKOWLdlTUGCdosT6iIL6T8Za
    b40csURfmlN7MN+R98kRWJ8v8F+iqbE/s6fLsNpizv1g==
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
        id S1424877AbeBOPt1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:49:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425044AbeBOPsK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:48:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.15 172/202] alpha: fix formating of stack content
Date: Thu, 15 Feb 2018 16:17:52 +0100
Message-Id: <20180215151721.859672517@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 4b01abdb32fc36abe877503bfbd33019159fad71 upstream.

Since version 4.9, the kernel automatically breaks printk calls into
multiple newlines unless pr_cont is used. Fix the alpha stacktrace code,
so that it prints stack trace in four columns, as it was initially
intended.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/traps.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -160,11 +160,16 @@ void show_stack(struct task_struct *task
 	for(i=0; i < kstack_depth_to_print; i++) {
 		if (((long) stack & (THREAD_SIZE-1)) == 0)
 			break;
-		if (i && ((i % 4) == 0))
-			printk("\n       ");
-		printk("%016lx ", *stack++);
+		if ((i % 4) == 0) {
+			if (i)
+				pr_cont("\n");
+			printk("       ");
+		} else {
+			pr_cont(" ");
+		}
+		pr_cont("%016lx", *stack++);
 	}
-	printk("\n");
+	pr_cont("\n");
 	dik_show_trace(sp);
 }
 
