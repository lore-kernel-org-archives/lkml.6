Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A63ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627E621571
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdAu4uRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627E621571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391582AbeIVDL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:11:59 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36927 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391538AbeIVDL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:11:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id c13-v6so8855509qkm.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8k0z+neWnT3E0Kj3SIHbyCIj0OoFwbYBzDgipnvG3bw=;
        b=UdAu4uRpIFx5/rQGJ9PcBi1kW34OiyEIbptNr0mYYK7s0hDaaTzAAIHyO//YGng61n
         ete3YeSVgONi4NIEDrZnE6TphkPvp4URZuhFKsQg2dm+lXnRgZh39EvPa2S25ikMIHs8
         PvLP0U3mDqEpLK4Gi7xfOl36/KcXVdbVWVfghfLfZmCcWhg6pE34Qu1WqF8N0Ja8yJ8m
         OIi9yOnpEROamM/V3CFXJoAEZB6Ybd66heckpyXFw6JD+yw7NTwQqsMZNgCj3OmCjIAO
         AdGRmoGI07HrD/Tzhq1hZkBx1lBXXWgdPb+2s2Ix1dv3O3Vif1RcYskTbO01cPNYcFm8
         Okrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8k0z+neWnT3E0Kj3SIHbyCIj0OoFwbYBzDgipnvG3bw=;
        b=JpUfl9OGDjA8D+Zv+lLkt9+gQNQQ/ar/Zg4ETE+JCC/rwzrBvSHrHthJQDiNzt5Xq/
         u1bbL6dVMstWozOcgbQBmRA8ThIWLnUGOuXkyY3IyqTaPUDIqM9cBbMBvFzqpJNJwXyN
         KuAR7Bj1GVE3FtybrXXhTAJaB9q/hzfVlpqgZmxQk5DrSZMjQAaqPlqVNKtIXbOic7xo
         SwiRCNJ9syRb/rUIbhPnLO1roS0jjP1bosgXu25kik+OmFU1LhEvheMmsJ6kkt6NlB6z
         do9VKw3hoVXjPbb9em3JRpakiHOoXyQJ5LaRqvrdNE5TNrLE9D3HWsbBpfnXlPseh9jk
         y19Q==
X-Gm-Message-State: APzg51CQblhByNJulzw+ScBtZtH5TX1N+zI10mw/b1G+K70OlbQ3F7JG
        FFI+rkwHtH2+VEOCydN9a94glvo=
X-Google-Smtp-Source: ANB0VdZvHIaGbZKcyrm6w1sIqoiOK7S6KxHCSTVNQMQuEWMLV/r0Qjs0W4B3uBvkJhtE42pMAmgtyA==
X-Received: by 2002:ae9:f10c:: with SMTP id k12-v6mr32175816qkg.342.1537564876779;
        Fri, 21 Sep 2018 14:21:16 -0700 (PDT)
Received: from localhost.localdomain ([2603:3003:4107:8d00::5ce6])
        by smtp.gmail.com with ESMTPSA id f6-v6sm16740401qke.77.2018.09.21.14.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 14:21:15 -0700 (PDT)
From:   Matthew Whitehead <tedheadster@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        luto@amacapital.net, bp@alien8.de, hpa@zytor.com,
        Matthew Whitehead <tedheadster@gmail.com>
Subject: [PATCH v2 2/2] x86/cpu: Change query logic so cpuid is enabled before testing
Date:   Fri, 21 Sep 2018 17:20:41 -0400
Message-Id: <20180921212041.13096-3-tedheadster@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180921212041.13096-1-tedheadster@gmail.com>
References: <20180921212041.13096-1-tedheadster@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently we check for cpuid to be enabled first. If it is not already
enabled, then we next call identify_cpu_without_cpuid() and clear
X86_FEATURE_CPUID.

Unfortunately, identify_cpu_without_cpuid() is the function where cpuid
becomes _enabled_ on Cyrix 6x86/6x86L cpus. So we must reverse the
calling sequence so that cpuid is first enabled, and then check a second
time to see if the feature has now been activated.

Reviewed-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Matthew Whitehead <tedheadster@gmail.com>
---
 arch/x86/kernel/cpu/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..60c7c5ce7e55 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1040,6 +1040,9 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
 	c->extended_cpuid_level = 0;
 
+	if (!have_cpuid_p())
+		identify_cpu_without_cpuid(c);
+	
 	/* cyrix could have cpuid enabled via c_identify()*/
 	if (have_cpuid_p()) {
 		cpu_detect(c);
@@ -1057,7 +1060,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		if (this_cpu->c_bsp_init)
 			this_cpu->c_bsp_init(c);
 	} else {
-		identify_cpu_without_cpuid(c);
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
 	}
 
-- 
2.16.4

