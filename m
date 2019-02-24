Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E38C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A981C2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxyl5I/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfBXMfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 07:35:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41676 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbfBXMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 07:35:15 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so3188767plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 04:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eww4YGVNqaj9wRyOutY/EPgdrl5kM4y1BOCar4JSDOY=;
        b=jxyl5I/2HwfMWNaGOrGaBhrL0uom2+tVm75LY7sjNFlCLVt1Go95qKPHLyi+GivV/u
         /sy5MtB0kqC+sTReLVH7GmkIel6oG0y1x6r1Lmhc1EoQh+cg/uF+sJresUakl6SVRV/1
         cTXRXIIBjjf9mRXZI0M+YNTQayY5rZ2b6BpxoBR50Nia9aEr6CBuDB5fWfCuSgYt6IW+
         PdxNFA4nMAKZ0cT+jBGYPINhrJX9eqoryn3YxU/a2AxGLEhkAiKEPXJhKkJoYqpYIC3b
         C3mEcaPRCcbof5Eb6rM7kyW/QctbaiggK2iK8lp9FmvWRo1miJ4jRP4yDJ6PLJNQOI1N
         8zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eww4YGVNqaj9wRyOutY/EPgdrl5kM4y1BOCar4JSDOY=;
        b=Cm4m4oyTL2e2iFx1hLelGiZTdWD2pk3pVqw9j73sRYwCGwfx79RQ/gQYRdvsOR9mKr
         kO4Gj1F7TJL5UcBfQFRcXY2tqhxHJZ0xpt81jLT64tUebqytL1KfEWd3O8FbZGr/0yqD
         Zp2/lvUzYPvBsXUZpG+Z22vRsHKOYMTcD9kqyTaa49nOIaucpcOpHGKR7nxXaiXdmyxt
         6xJsPcBoF7IWjswbvPrSyNj9W9+dS5tFAtUN2ImIsMM5OEZqv7foIUQ8Mwt045BNrLNN
         XrQugyxQHvjjAmxiioduUNnVSJqxdcIRAgIWu1LM66LGFeV1d1E+MU1WXsIyJoprJ2Qz
         mAhw==
X-Gm-Message-State: AHQUAuaWr01nHDdHT2uCo5u3VC+wHOxNRIQlMTq8S9HbXXdFljAbvWk4
        +X4hmNcU9CH2Z1EohZ0xfQ==
X-Google-Smtp-Source: AHgI3IYnsiekbeLSFtIgzri2SnnfjeNt2qRN/KWI9yLMZxIuOKs3/2jqj0gP3wC81SLZ/uMG63ce5A==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr13818923ply.65.1551011715029;
        Sun, 24 Feb 2019 04:35:15 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6sm9524634pgb.2.2019.02.24.04.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 04:35:14 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] x86/numa: build node fallback info after setting up node to cpumask map
Date:   Sun, 24 Feb 2019 20:34:09 +0800
Message-Id: <1551011649-30103-7-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous patches, on x86, it is safe to call
memblock_build_node_order() after init_cpu_to_node(), which has set up node
to cpumask map. So calling memblock_build_node_order() to feed memblock with
numa node fall back info.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mel Gorman <mgorman@suse.de>
CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>
CC: Petr Tesarik <ptesarik@suse.cz>
CC: Michal Hocko <mhocko@suse.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Vacek <neelx@redhat.com>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a5..3ec1a6e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1245,6 +1245,8 @@ void __init setup_arch(char **cmdline_p)
 	prefill_possible_map();
 
 	init_cpu_to_node();
+	/* node to cpumask map is ready */
+	memblock_build_node_order();
 
 	io_apic_init_mappings();
 
-- 
2.7.4

