Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834045-2-1677002002892086087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834045; b=sJE0+zBI5pTxClDkycbHho0fx5gGx9v9RCL6h/ID/Dqs8eI
    nVwjr771iKeojqkfAyl3RpFb5stxLyVlcLPh9ix9tICe4PntJo9HsBzv2XDW7QHC
    WefS3OA1K2rh+qmvpmbO6COCfmr99hEatPR/BjiTGNvG3fEw4eIAJNnbNGB0JmFh
    XYlu8YvnEhdIHWiemB9CnWzXItFARwr1vuRfNDUZ74qDarl/yqqIp/iqqWXW7rwy
    4SWkARiPsVfxMXWwf20TtjYvdmxjR1p3UHYiUxZF67rdTt72WF8xIbSwi4JiX92x
    CXeqIVNPt2FadzK6b4FY/3Jm3KAsLapKcB5q/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834045; bh=y/Tg+m9rR6zlDkBgTDD
    CrA5wnh/dWcD1eQDqtDw6Xis=; b=V3IKVugPcRUnV8yb64LSZQxtoZThaD+dGN4
    lWn7MyjrWBznZW4tn5DnXT0biNmKqmnMgfWfgw6PDdo/K7Bin54R36dgDyrfOhiR
    r3ChbnEmyf6WBUQtWf7oeVf3gQ0/EjCo80LUXCMMdoQp76q7hLhbf4eiYTjp/gA5
    QnEeHPjaDUVhEYB3GFN9xIaABO9X3+lW+jbIqRKc9xxU/M8t6f17N/jaazDlFKCg
    UiNjnzFsAF5dXTvCxIHValXGbpJlXv1Jdaps4EQLKv65AihiiSsjkvzr5f0DDnOc
    o1Yxa1EX4TKdGW2Oqlr7qKeDUUzy33ebm/h/vppq9iiaZIdxpgQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934490AbeB1QFY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34880 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934460AbeB1QFT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:19 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Ravi Bangoria" <ravi.bangoria@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.391174386@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 111/254] powerpc/perf: Dereference BHRB entries safely
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

commit f41d84dddc66b164ac16acf3f584c276146f1c48 upstream.

It's theoretically possible that branch instructions recorded in
BHRB (Branch History Rolling Buffer) entries have already been
unmapped before they are processed by the kernel. Hence, trying to
dereference such memory location will result in a crash. eg:

    Unable to handle kernel paging request for data at address 0xd000000019c41764
    Faulting instruction address: 0xc000000000084a14
    NIP [c000000000084a14] branch_target+0x4/0x70
    LR [c0000000000eb828] record_and_restart+0x568/0x5c0
    Call Trace:
    [c0000000000eb3b4] record_and_restart+0xf4/0x5c0 (unreliable)
    [c0000000000ec378] perf_event_interrupt+0x298/0x460
    [c000000000027964] performance_monitor_exception+0x54/0x70
    [c000000000009ba4] performance_monitor_common+0x114/0x120

Fix it by deferefencing the addresses safely.

Fixes: 691231846ceb ("powerpc/perf: Fix setting of "to" addresses for BHRB")
Suggested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
[mpe: Use probe_kernel_read() which is clearer, tweak change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/perf/core-book3s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -391,8 +391,12 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 	int ret;
 	__u64 target;
 
-	if (is_kernel_addr(addr))
-		return branch_target((unsigned int *)addr);
+	if (is_kernel_addr(addr)) {
+		if (probe_kernel_read(&instr, (void *)addr, sizeof(instr)))
+			return 0;
+
+		return branch_target(&instr);
+	}
 
 	/* Userspace: need copy instruction here then translate it */
 	pagefault_disable();
