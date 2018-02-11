Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326373-2-1442593909342408498
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326373; b=rRp6ZZZGLQT9rEIAk/aOWC93sOdJdX1I+WG87m9/F7pjsYI
    AUfI6bvjwZrVvc5RhxpwsZjBTptwGRtALpBe3SZoTHdbMCWQakAPCrKgtarY44e2
    DCxN1OOUIu3eLEBb/W/HbxPXzDoXuOwnquW1DFE9EaGl0Xvil2mdew17rZyac02q
    i5PSvFZGSDA79Tz+LOlup2ZuWUP1vCv8gXmf1gqAd4kN/iVuaIgVV3Psu1A+Unwl
    gDmjpPAfCcxHyVU2x1RLHLf0peVnwFoHIxgQvHjvjOIs+0QqFAch74euE2yGv78P
    i/KeFm779dAo/6nVS+LB6W9W7VESyRtfbqsSbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326373; bh=17GuyvbNu6zJVyc56Cf
    fv2lCV8PAAJqPi2WkwHs2NO4=; b=l+WerhQNRxvW/sOL8paoTUK6IBFmWZ1e7lh
    IxzD6fhSZOsV08oyTdSXL2JwuQfOvOV9CAyDrwYkWn/DVFwAcV6Q+9DQt/wL0YzM
    AROiIAPcggmJ/TbVpE/cGTUvJZfLhsVEXUvG3vrpOHkl54HT7ZNShAjXRmKawR3b
    AoEVoZIzrZMw/2VKLtX2/BKVMMfOFyo01dYop28sGM9x0B6o5sa0FRi8UNw4sqPK
    /ysvjKTpso+G7lFy2EgGcGNke9VJS53Au77nDbcOOmqgHpQYf/xlMi4xIpbZQXtd
    +QSgzcw/PkawR7q8zNkBn3gAIYY4eQQtBXI/cAIVU+ffsl07gMQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeBKFTO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:19:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753528AbeBKFS2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:28 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Shriya" <shriyak@linux.vnet.ibm.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.366642386@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 059/136] powerpc/powernv/cpufreq: Fix the frequency
 read by /proc/cpuinfo
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shriya <shriyak@linux.vnet.ibm.com>

commit cd77b5ce208c153260ed7882d8910f2395bfaabd upstream.

The call to /proc/cpuinfo in turn calls cpufreq_quick_get() which
returns the last frequency requested by the kernel, but may not
reflect the actual frequency the processor is running at. This patch
makes a call to cpufreq_get() instead which returns the current
frequency reported by the hardware.

Fixes: fb5153d05a7d ("powerpc: powernv: Implement ppc_md.get_proc_freq()")
Signed-off-by: Shriya <shriyak@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/platforms/powernv/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -309,7 +309,7 @@ unsigned long pnv_get_proc_freq(unsigned
 {
 	unsigned long ret_freq;
 
-	ret_freq = cpufreq_quick_get(cpu) * 1000ul;
+	ret_freq = cpufreq_get(cpu) * 1000ul;
 
 	/*
 	 * If the backend cpufreq driver does not exist,
