Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7561FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0C3214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw7jRvJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0C3214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbeKVBAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeKVBAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:00:06 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BD621527;
        Wed, 21 Nov 2018 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542810328;
        bh=A2jZN4p/WJ7fzEkFQW9I6vkHomxNjLtFwEnTtWsPYmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qw7jRvJvgU0JmYqkU615mhb4b70aShoBFjknjJauDKYc9PFxfeA0Mor8r2FkPMfOk
         S23hDAkdvNe2rPmHjIfYJMj0TUFSpHesjZEAgpbae6aCul8IUk9RCaRNbvwCYC1Doq
         vsbEJyA2NXJevLsBlIHy/n7PwVOk9T5HSUmXFUH8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 5/7] tools arch x86: Update tools's copy of cpufeatures.h
Date:   Wed, 21 Nov 2018 11:25:03 -0300
Message-Id: <20181121142505.27379-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
References: <20181121142505.27379-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in the following csets:

  ace6485a0326 ("x86/cpufeatures: Enumerate MOVDIR64B instruction")
  33823f4d63f7 ("x86/cpufeatures: Enumerate MOVDIRI instruction")

No tools were affected, copy it to silence this perf tool build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lkml.kernel.org/n/tip-83kcyqa1qkxkhm1s7q3hbpel@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 89a048c2faec..28c4a502b419 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -331,6 +331,8 @@
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
+#define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
+#define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
-- 
2.14.5

