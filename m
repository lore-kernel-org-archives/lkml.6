Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97EEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9135E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLwU2245"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfANDPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:15:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41927 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfANDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 22:15:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so9451585plm.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 19:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PmJ3rvvHVnVYl7ZInTRvw9eSWwObnfuKuAqdBcDFqjE=;
        b=JLwU2245npCxKGzQwxJd/SvvlnFMz7t6mJjUQiYRI2jrAlLWFP4JPFYGbMnG8Jr7vn
         SctWtwkyLC9QOnEBY8qFaypa1qLf7R7jR9tmmecBnPgS4bOOZZFTFfSzJ8h68D//tQ74
         VvXRNvEDdjvp6tA+YLyD2Zfv/Iq6cS8MGWDNsXL2LPJlrdWIzitPXKkL65CiO8XIZVJC
         cYYMKRc2Hv9S+cC9TPWdQ84VTVV5gWb3bERyBZy5Kc7G60Key/k44V0atODwLLb318+c
         lHcM4TvLj2smwGTpK8+A5GRIHS4feoTLzOMRpzVD/3hcDHMaygRnaF+AoirGCkS7YHsm
         8bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PmJ3rvvHVnVYl7ZInTRvw9eSWwObnfuKuAqdBcDFqjE=;
        b=Ej8ojVN7jmW2NDuWCRs09g1vPcJAZEgQrthpnUXfnongc8n+dqIqFG/gk69GoHny98
         6epd4l6zc8s3qiCYB/DoJZcdFpOm+3dqaKIE7PY7wQvn8fWe0bfu5+9hIRW/V+7330NA
         3dUbPMjAlgKMFG9C9OkYvkLPMv3NER09dqmvNN9Pd3ls7VbHwH3E8Ro3++l5knf/Blec
         PDlHatO3QFYI8QyB2aXdqpyVLb+9hTRcWvogn4lEP3pjXfDsRu5dswirqBkEzypIdF1a
         hd5Xp+i09Mh6F5gd/0crz3c8WTTXOTzLKv/7xb7ggv+SmzagQwuriGU+vRfkQ8J043HJ
         O/mw==
X-Gm-Message-State: AJcUukf41qmpcCE898/Vx4/+dKAxSgnki6TC9GYvZkwOVEW9MO5fLXov
        bwnj+rs95XcMhxE6NNvemw==
X-Google-Smtp-Source: ALg8bN7xD9w2P2bhTBdh8CyGK/ijwrEmP7wD5vJiYnH1s0AEbhiysUVk/bptdutcabpEaCzVd74DBg==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr23832625plb.150.1547435733018;
        Sun, 13 Jan 2019 19:15:33 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n68sm138454550pfb.62.2019.01.13.19.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 19:15:32 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com
Subject: [PATCHv6] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr
Date:   Mon, 14 Jan 2019 11:15:11 +0800
Message-Id: <1547435711-5786-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People reported a bug on a high end server with many pcie devices, where
kernel bootup with crashkernel=384M, and kaslr is enabled. Even
though we still see much memory under 896 MB, the finding still failed
intermittently. Because currently we can only find region under 896 MB,
if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
randomly, and crashkernel reservation need be aligned to 128 MB, that's
why failure is found. It raises confusion to the end user that sometimes
crashkernel=X works while sometimes fails.
If want to make it succeed, customer can change kernel option to
"crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
limited space to behave even though its grammer looks more generic.
And we can't answer questions raised from customer that confidently:
1) why it doesn't succeed to reserve 896 MB;
2) what's wrong with memory region under 4G;
3) why I have to add ',high', I only require 384 MB, not 3840 MB.
This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
finally above 4G.
Dave Young sent the original post, and I just re-post it with commit log
improvement as his requirement.
http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
There was an old discussion below (previously posted by Chao Wang):
https://lkml.org/lkml/2013/10/15/601

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
---
v5 -> v6
  discard bottom-up allocation, just repost dyoung's original patch with commit log improved
---
 arch/x86/kernel/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a5..fa62c81 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
 						    high ? CRASH_ADDR_HIGH_MAX
 							 : CRASH_ADDR_LOW_MAX,
 						    crash_size, CRASH_ALIGN);
+#ifdef CONFIG_X86_64
+		/*
+		 * crashkernel=X reserve below 896M fails? Try below 4G
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						(1ULL << 32),
+						crash_size, CRASH_ALIGN);
+		/*
+		 * crashkernel=X reserve below 4G fails? Try MAXMEM
+		 */
+		if (!high && !crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX,
+						crash_size, CRASH_ALIGN);
+#endif
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
-- 
2.7.4

