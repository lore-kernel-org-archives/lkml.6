Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B2F94C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFC920864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUFzjRFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFC920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966387AbeFNOTx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965659AbeFNOM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:59 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86913208DA;
        Thu, 14 Jun 2018 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985579;
        bh=Y/RXxsH+YGpu8YARvYtFF3M8fZvTZOu1TdKNCEkNRFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUFzjRFlWl8h75VjQwKUmQY/XraxBXrxecV3+9T8AWJJZci6RLp0G8uJaim4BgMMi
         XeWCb4wMXJPs31r8H3UTOOAakYjafsXX2ACsYiJRuEK+hQzIEa3tyQytKrBHt/IJd/
         7Z+renDXITfuG78CTE0YKxgtQomGyIB8HKMGnKoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.4 02/24] x86: Remove unused function cpu_has_ht_siblings()
Date:   Thu, 14 Jun 2018 16:04:57 +0200
Message-Id: <20180614132724.578941852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit ed29210cd6a67425026e78aa298fa434e11a74e3 upstream.

It is used nowhere.

Signed-off-by: Juergen Gross <jgross@suse.com>
Link: http://lkml.kernel.org/r/1447761943-770-1-git-send-email-jgross@suse.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/smp.h |    9 ---------
 1 file changed, 9 deletions(-)

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -21,15 +21,6 @@
 extern int smp_num_siblings;
 extern unsigned int num_processors;
 
-static inline bool cpu_has_ht_siblings(void)
-{
-	bool has_siblings = false;
-#ifdef CONFIG_SMP
-	has_siblings = cpu_has_ht && smp_num_siblings > 1;
-#endif
-	return has_siblings;
-}
-
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 /* cpus sharing the last level cache: */


