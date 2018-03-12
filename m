Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824150-2-16502174224352592280
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824149; b=r0eZ5QznOhd/4LFfaT8YmhM8AXOvPshV0ioSO0DW7s2xbl5
    unKCbsvw3T8yop9UShriF001I06ZsqXdHLU0zcroT9LtN6tcmDj0KI/9xVg5fVKe
    ZG11025A7M03EVx77pgerdafEUs/803MfTnObfLpW/HnuiXZ8iX/OufKtC8gTDr7
    aky3MzC4zhPYwoulTBGgOq5+N+I7ZV/Z6aYIFuJnPxBS9wnQ6lOIj+UYfaOKkTz4
    W7DbR7GHpqfDWa57fqYuNjBs8Nt8N4OP5EXnF5t6ReDrfqE9OK6HlfeD/mP1ClbH
    sza9I59P3Z3OVlk8wHxYRxz8uquY5Y/PqoB8+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824149; bh=/UyDjRcyZdWozb/quFo
    d/4bI/b6zqCDUHDpc8XEUTX8=; b=VEIBJQOsAaG8uGl0JKrgGciR1+2gvXfGXBu
    hOoT8V2ObQCWyit/KXiuo6AKYhjv7g+WtPDXAOOcAwxQpeNMEhc1EniR4VioOGKr
    h2DkPkh2We6MEaEmoDWGrK3ZgxynzoCNCHqjJqCqWKrpRaqzays76lF9i7uU7TaO
    66tES/+ACb8/no1VSN0WteyeM+n9ko96Obo4U9szQz+W4f3FeJGI+hvCBYdflIC7
    carnUZSPHd4fzca4hD16mhnVa8qZEGBWtnAO/PaKrhe0DVtrLcHj+yot3xp9LyZo
    RsFHJm1d60ZEQUMF4PrtGr3KvEd7oLp780ohmfBuCqPf6W3ylUA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932697AbeCLDJG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:09:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41600 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932808AbeCLDHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Borislav Petkov" <bp@alien8.de>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Darren Kenny" <darren.kenny@oracle.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.461982130@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 65/76] x86/speculation: Fix typo IBRS_ATT, which
 should be IBRS_ALL
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Darren Kenny <darren.kenny@oracle.com>

commit af189c95a371b59f493dbe0f50c0a09724868881 upstream.

Fixes: 117cc7a908c83 ("x86/retpoline: Fill return stack buffer on vmexit")
Signed-off-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180202191220.blvgkgutojecxr3b@starbug-vm.ie.oracle.com
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -178,7 +178,7 @@ extern char __indirect_thunk_end[];
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
  * retpoline and IBRS mitigations for Spectre v2 need this; only on future
- * CPUs with IBRS_ATT *might* it be avoided.
+ * CPUs with IBRS_ALL *might* it be avoided.
  */
 static inline void vmexit_fill_RSB(void)
 {
