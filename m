Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KfNoD3hMGVu8YQAAmS7hNA
	; Thu, 07 Jun 2018 15:26:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E15906074D; Thu,  7 Jun 2018 15:25:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BE22F6063F;
	Thu,  7 Jun 2018 15:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE22F6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935540AbeFGPZz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:25:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41149 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935273AbeFGO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:03 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbV-0005Zm-T9; Thu, 07 Jun 2018 15:09:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003Aj-1E; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Cornelia Huck" <cohuck@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.38619078@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 313/410] KVM: s390: provide io interrupt kvm_stat
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

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit 09a0fb67536a49af19f2bfc632100e9de91fe526 upstream.

We already count io interrupts, but we forgot to print them.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: d8346b7d9b ("KVM: s390: Support for I/O interrupts.")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/kvm/kvm-s390.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -62,6 +62,7 @@ struct kvm_stats_debugfs_item debugfs_en
 	{ "deliver_prefix_signal", VCPU_STAT(deliver_prefix_signal) },
 	{ "deliver_restart_signal", VCPU_STAT(deliver_restart_signal) },
 	{ "deliver_program_interruption", VCPU_STAT(deliver_program_int) },
+	{ "deliver_io_interrupt", VCPU_STAT(deliver_io_int) },
 	{ "exit_wait_state", VCPU_STAT(exit_wait_state) },
 	{ "instruction_pfmf", VCPU_STAT(instruction_pfmf) },
 	{ "instruction_stidp", VCPU_STAT(instruction_stidp) },
