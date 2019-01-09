Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE17C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518B62064C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj7NTL98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfAISdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:33:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44835 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfAISdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:33:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so3957857plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2ZHyQfZjd8TlXKXVdLreOQcBuxQUqyz9Pdg0+NQxots=;
        b=Wj7NTL982hx5lfg1Hxm51F3Kmy3829JOrh7mwwJ043w0PVjyDD8i8b7mWJyWgr2qUd
         uz5INFTySCo547U5UaJBZ7pjLp+Mt/Uc+53Hts7MWjDcdVRsFew35MUICbYH6kSUGnFt
         cHz3Eeq0BxWAGBHS+TodxEcKmJYl7Ri5G0YPgVkjlWvW6eQtGLZgzvb76M5lWixxapb+
         X4zHkO1qJ5EJighj35MA1Hqrfo/6pxRxt3BmfdYd3AvHGMR66XUkTKgOBVAlcE7PwbF+
         cwW0Fl+JFSQajE++A7QIjdRp9uE51tLFKK8MK8XGZSe2OAqCj0IkeyRfot2ryOgjzGiF
         3MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2ZHyQfZjd8TlXKXVdLreOQcBuxQUqyz9Pdg0+NQxots=;
        b=PV4TCC0Jy+PsS9qw1PFIchdk80gRpEs2yJFHwxRS7vJD5msPdnHlgVSR9WbWL+VcYb
         uY5ET20AE8y/cS9XIfBXTu/T4aXknR3G6l1SlKWk8yGXoMeYmQB/kg3gEmzTwOARLCDR
         6l7Oq7t9P2qNMkgWKnmxTE5DfUEIxnkM9dAu89zweqDUBQXCM5EeoNds+k/mWEJkctQc
         V8lHHfLRlrbm5hFPmmgHj0QvHNL696+e8T7NcgthMsiyev/vWNY57RHeOQEc1Qx1PuSu
         JHy1e7ObdEUZe5zW7WG03zKfK+G+P/vPzX1Ia3/o4a0tSK7h51t7iF586k/ZEo2l/Ij0
         uLpA==
X-Gm-Message-State: AJcUukew3WOCOJcsOjGHVmg/3qyNL/w5gL+eDtZkKyadw6m6ENhYThAe
        0owXgACd82Rf3Q2GJOwNwtc=
X-Google-Smtp-Source: ALg8bN7J/WMtPLTLbVDpXSsT8KqfOuKxQBWo1ptDGVllC96IFGX0Bu8RVKZYs99oETyLC+QeSkv+Dw==
X-Received: by 2002:a17:902:680f:: with SMTP id h15mr7057704plk.40.1547058823058;
        Wed, 09 Jan 2019 10:33:43 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.49.233])
        by smtp.gmail.com with ESMTPSA id v15sm104992776pfn.94.2019.01.09.10.33.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 10:33:42 -0800 (PST)
Date:   Thu, 10 Jan 2019 00:07:42 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v2] x86/mm/fault.c: Convert to use vm_fault_t
Message-ID: <20190109183742.GA24326@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_fault_t type for last argument of do_sigbus().

kbuild reported a warning during testing of final vm_fault_t patch
integrated in mm tree.

[auto build test WARNING on linus/master]
[also build test WARNING on v5.0-rc1 next-20190109]
[if your patch is applied to the wrong git tree, please drop us a note
to help improve the system]

https://github.com/0day-ci/linux/commits/Souptick-Joarder/
mm-Create-the-new-vm_fault_t-type/20190109-154216

All warnings:

arch/x86/mm/fault.c:1051:39: warning: restricted vm_fault_t degrades to integer
arch/x86/mm/fault.c:1057:29: warning: restricted vm_fault_t degrades to integer
arch/x86/mm/fault.c:1059:29: warning: restricted vm_fault_t degrades to integer
arch/x86/mm/fault.c:1094:62: warning: incorrect type in argument 4 (different base types)
arch/x86/mm/fault.c:1094:62:    expected unsigned int fault
arch/x86/mm/fault.c:1094:62:    got restricted vm_fault_t [usertype] fault

This patch has fixed the warnings.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: updated the change log.

 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2ff25ad..dea3725 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1031,7 +1031,7 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 
 static void
 do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
-	  unsigned int fault)
+	  vm_fault_t fault)
 {
 	struct task_struct *tsk = current;
 
-- 
1.9.1

