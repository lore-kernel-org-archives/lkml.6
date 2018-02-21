Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519217990-2-13346918411994334880
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
    t=1519217990; b=gdbkSZvqfmLUDF4K9cK4z+e1omgUjCA4C7ajLm6+QmDl4QD
    kG9wCWaTb/cbAwy7+ByTT9u5ei9bbFz1s2yhg7RNvY0B9vqd0t+pmRlL2l3ISArT
    U79IC+owPnFxU2lh8/QcU9Hn+NNqoP3gRoXS4MUCbwCnOWQIeQEGN6dqarXPqyZ+
    KpllCLK0TQE9Yt/Dw/LdJcjWzVqif74I9LAHSoHjOJCiNtPs6mA8cdY5sYgkxvhB
    wFZpDZ9dXzAiqR6xGv338nJDN2j2AUvhmJc8rt9Vtl9wxBaZmz5mdO2klwgqLdJ/
    ZgdDmQZe5ADfWLXvQd7y+yk645O5RchkHXyncog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217990; bh=HEKo1SiSY4T1vHyTgrgwpBdwMs
    8bv/tAo9G7+5cUjKk=; b=RPoKMKn7KsJXXUWtROHJWURoXEVINko8xHoGNBIr9+
    YQ+JGZ4zxM8BWFfiqhm/SAW+xNBakPBhcFvYD7zEHZW+LGWDVc/IqwbQyWId5+iR
    U21wFU/x9S+T3BHQyUvzklt3KOm3fFmwI7dJdbOdJVItOjjV0xqYDr6bNmFIcJWp
    il6JVI0/LFcIfCe4n15X0an5W1+bZ5RXeLhDSqwSE0qZAlL3/YnPiUG3tN5vQkVM
    jJdAdhalTi1SE/pdURjg/gJkvuLGh/rFonLlmf7Hwe7IaZkYcUo77weC3BgxFEGE
    5dpkUssPDqIsUlB2cc1tS0W+JWua+FULrTTJHfT2scRw==
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
        id S935147AbeBUM7m (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:59:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935123AbeBUM7k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:59:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, nadav.amit@gmail.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 047/167] x86/mm/pti: Fix PTI comment in entry_SYSCALL_64()
Date: Wed, 21 Feb 2018 13:47:38 +0100
Message-Id: <20180221124527.137143798@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
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

From: Nadav Amit <namit@vmware.com>

commit 14b1fcc62043729d12e8ae00f8297ab2ffe9fa91 upstream.

The comment is confusing since the path is taken when
CONFIG_PAGE_TABLE_ISOLATION=y is disabled (while the comment says it is not
taken).

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: nadav.amit@gmail.com
Link: http://lkml.kernel.org/r/20180209170638.15161-1-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -209,7 +209,7 @@ ENTRY(entry_SYSCALL_64)
 
 	swapgs
 	/*
-	 * This path is not taken when PAGE_TABLE_ISOLATION is disabled so it
+	 * This path is only taken when PAGE_TABLE_ISOLATION is disabled so it
 	 * is not required to switch CR3.
 	 */
 	movq	%rsp, PER_CPU_VAR(rsp_scratch)
