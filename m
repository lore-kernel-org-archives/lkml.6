Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083CEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31D426208
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJmelMs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31D426208
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934309AbeFYWlg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:41:36 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:41972 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933969AbeFYWlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:31 -0400
Received: by mail-yb0-f201.google.com with SMTP id f22-v6so11089037ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0C+LMsVRbCpktsH0OP9a+VzlFglDWVu/5NfSR7InwoA=;
        b=NJmelMs3JGtjo0UodVP9ZvMLU2naSvRRF6ul/wNI+nvw1kYD4d/FeJOkctM1L+ujmi
         nNdwDfA2g1lvMv5rhiua2hAIu01gPwi594rBxnQFldPmIiTYb8ZtP5tCHIcJNTM7a/gk
         xWqhO9NHeoMbTX1210jR6embXbfGT9aIseMhanbCJWiGEdq37FxHM+BULPGuyzfb/1vc
         xq6aQdpxS/dfE6TOtvnPhOG3wOvkg+Un1Y5V/I2w6BkatD48/M2EXKo7uSVWUhB8lnEX
         0lDwyyjuiI9U1PBfbwK8tydil2pVenBkzUN8c9RHwZRqLtLLnjWrARpjkobbxGpu2j9e
         yJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0C+LMsVRbCpktsH0OP9a+VzlFglDWVu/5NfSR7InwoA=;
        b=UKbw44CGrg4CwCuprUfPsZ5VS55t6PsY3fNz8bEhcopFYhMrc6C9mdjY2j2HcXbRB2
         suthoASEda4HaMBPYMHmVwH4bAYaFHfwhe+94kbF2KZfPpGNMckqH7wsLSev19nvhTXK
         +SS0RDH1S8GWpnqNO/2YiOBT7wpHvuy3xres1SDuTxW1U8vCoKgdgfTCsYF6qpbQHyUQ
         M5xDCqYrswDAzSk47T7pPWf0ZXdb3mC6aANLjfEy99xs1ZzXunv8WAS+37aR75+5bpOQ
         I4bJXUrS3kQVJjXwmgQ9ffOYMLy0Lkl0U/L+Ln8WKDu1cN8kAvugSUZRXwznjxp4M3Zy
         YJTw==
X-Gm-Message-State: APt69E2GzznuxwK4HD40GkGYO+dsEg0dM1Obu1YUYERJO+yVr0J7vE7s
        pQWXn6NpYM/TZ4LvLN+aR5hn7oPWzZBo8A==
X-Google-Smtp-Source: ADUXVKIqVXM+wU3CsSYuZh3Q3Rse4uFmsl2JSdtyT/nKDKD1dMt/UNALHxq+X17U14i7wnlfDhbXw3/LXjBKsQ==
MIME-Version: 1.0
X-Received: by 2002:a25:9d8b:: with SMTP id v11-v6mr3853301ybp.51.1529966490949;
 Mon, 25 Jun 2018 15:41:30 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:00 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-13-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 12/27] x86/paravirt: Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if PIE is enabled, switch the paravirt assembly constraints to be
compatible. The %c/i constrains generate smaller code so is kept by
default.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/paravirt_types.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 180bc0bff0fb..140747a98d94 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -337,9 +337,17 @@ extern struct pv_lock_ops pv_lock_ops;
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
+#ifdef CONFIG_X86_PIE
+#define paravirt_opptr_call "a"
+#define paravirt_opptr_type "p"
+#else
+#define paravirt_opptr_call "c"
+#define paravirt_opptr_type "i"
+#endif
+
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(op))
+	[paravirt_opptr] paravirt_opptr_type (&(op))
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -395,7 +403,7 @@ int paravirt_disable_iospace(void);
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
+	"call *%" paravirt_opptr_call "[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.18.0.rc2.346.g013aa6912e-goog

