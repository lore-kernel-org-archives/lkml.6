Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218597-2-3014378545403848668
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
    t=1519218594; b=LvGtzGQqXZ/5VJMlLI+J8ciTWINLBwRhZtWaLvq+TQYMvML
    tGKccQ5H1Ue4fdszEmmSDuP9VFykA6jKn1ypU4cziRODNK3PXwxEMsYyX+cqBQeR
    JI7vE1cMhDeLqYxd/4wRcGPfH+8PaMg/8mpdHMugo6NUxkQ0LogMiQWO1qunbzFR
    RBbHQB6I8BZWZk02Wi3qkr0pXJpmZz10rcIx6v4SnudLLleQdmf9Azbs+L0INect
    yxWTOLQgvJh+rFWiyfMJr78Bpryr9i5qZuyvFyLHTy6MR71qNcLZBjW1/rwvmArj
    Qo9QEtUn1OEIfMBauaIrYQhNOnDsWueuRPqLUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218594; bh=4urOZxobNegxTUhbP5k6JntUBg
    FibsBvM/pEofQnb1A=; b=VnlPseaK7mR+ls7f6fPR6YNiMqSWxGr4i/9wZ9IviK
    XdyD4DBwtlmNXfDtY++iDEdJPY2oill9cnez5GYQFVhMov4MQ25ovTrWAcR+UExA
    /KDurPjD9a8M3RqLjCoOyJy4nz9aLsexa5lityw1uw76F/35QvChGSvlm219+sAh
    KZEilVQERv+Nri/FCaPuNdHm7qxzW9JJUyRTPS+fiFn5ssbDnX5dxx1DKXWjtIVv
    wXUm+yT10AsH8UL2o3cjx382vUfbv0d0CFj5crkJ6d+hZ0dnEOam6MMcg4vRqsi6
    0OYf2Y+r6bZSxBl7brRC8XANkRjZgxey4paC/G2eE7qA==
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
        id S965436AbeBUNJc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:09:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965416AbeBUNJ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:09:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 085/163] x86/spectre: Fix an error message
Date: Wed, 21 Feb 2018 13:48:34 +0100
Message-Id: <20180221124535.102667182@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 9de29eac8d2189424d81c0d840cd0469aa3d41c8 upstream.

If i == ARRAY_SIZE(mitigation_options) then we accidentally print
garbage from one space beyond the end of the mitigation_options[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Fixes: 9005c6834c0f ("x86/spectre: Simplify spectre_v2 command line parsing")
Link: http://lkml.kernel.org/r/20180214071416.GA26677@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -174,7 +174,7 @@ static enum spectre_v2_mitigation_cmd __
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
