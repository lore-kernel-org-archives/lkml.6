Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id v6OgIFhEGVutEwAAmS7hNA
	; Thu, 07 Jun 2018 15:10:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF7E0608B8; Thu,  7 Jun 2018 15:10:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 268CB601B4;
	Thu,  7 Jun 2018 15:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 268CB601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935803AbeFGPKq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:10:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41481 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965016AbeFGPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbV-0005hL-SR; Thu, 07 Jun 2018 15:09:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0003AU-SV; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Michal Suchanek" <hramrach@gmail.com>,
        "David Vrabel" <david.vrabel@citrix.com>,
        "Stefano Stabellini" <stefano.stabellini@eu.citrix.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.450624095@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 310/410] xen/arm: Define xen_arch_suspend()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit ffb7dbed47da6ac4460b606a3feee295bbe4d9e2 upstream.

Commit 2b953a5e994c ("xen: Suspend ticks on all CPUs during suspend")
introduced xen_arch_suspend() routine but did so only for x86, breaking
ARM builds.

We need to add it to ARM as well.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reported-by: Michal Suchanek <hramrach@gmail.com>
Tested-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/xen/enlighten.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -344,6 +344,7 @@ void xen_arch_pre_suspend(void) { }
 void xen_arch_post_suspend(int suspend_cancelled) { }
 void xen_timer_resume(void) { }
 void xen_arch_resume(void) { }
+void xen_arch_suspend(void) { }
 
 
 /* In the hypervisor.S file. */
