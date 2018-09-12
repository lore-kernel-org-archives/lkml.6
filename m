Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EEBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9123320866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="J9HoMRc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9123320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeILTn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:43:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46596 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeILTn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:43:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so1155509pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6/ydt6N6S/55utOAFvJcmvh4Eg5M9T60iCGCfN79Lr4=;
        b=J9HoMRc1Cw2DWHgjkSmnvF69yzHPXFmKuJQbJiIfK2vbP0DE6gIGMX+pb6B15fR4OQ
         eO+dqb2Epv0AJtJI3HwryzOwmsopDb2wGrX3d0MOE1JwQs2td4Y+3sbn2Pu1ZqcbcJHJ
         Ua/q/FRpewipvA0FYWr3b8kh2n7Qo4zxyMgMnp2luzLKVQ8TIKfmm5vq7QTm275RzncO
         uf6JVBY5ImqUItQEdYxu9xBDCjWfJnuAC7q8Lwn5VEGtWE5ZzYQd+AZeJxOoiYGWvUjl
         dQGH/GWxtoz099unBQJkAaztK/YW+HyXHov3+BpUzAtLReBFBkLXB88EzVd8lsMrUrh1
         czTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6/ydt6N6S/55utOAFvJcmvh4Eg5M9T60iCGCfN79Lr4=;
        b=Ex+5Qh/NZMXCwfI/w6QfuZ8/ZU5KzrzCtON9Pp7HWK5p3+yipEB9v+EfHMaq02Dv97
         6+tvjBtvbvr0ra76MA4eRe6fXEmgbKdlWZYx385wDlMeMgwo2XPHsGyolrgCvOKNnp8+
         VwbacN9V7vslFKR3TKPkwc6MEV6AUOwbcJlj9hr2Q5nRBtoVJxt1MYyV5N4bcWopEUyF
         kKS7WG51KHepjqx3MbjIJjR3WyWRMXtYxNd2kQk1lLtF5qqtC8hIhfYysHomNkNEeGbE
         fj5KGu7L7rZpnMslKnclQ7RvrXc95J4UrxEOU8+6mpym7wIoMJ90E6XeEgKu64z+L2cF
         ekNA==
X-Gm-Message-State: APzg51Chx5pHj2XZsMdtetQf7YROvL5oKtLaJI9gIXDuWQW9ciorcPhA
        rSRHfQVXgaujD3pnLCmBRu/MYw==
X-Google-Smtp-Source: ANB0VdaiDVuGawS5kiGpum53yeK1oMijtV0Fz8YMWsMf+6e0XWKMN2RVTDE81QQt4wEJrEba3zza8w==
X-Received: by 2002:a63:c912:: with SMTP id o18-v6mr2601378pgg.331.1536763120095;
        Wed, 12 Sep 2018 07:38:40 -0700 (PDT)
Received: from anup-ubuntu64.dlink.router ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id y85-v6sm2416083pfa.170.2018.09.12.07.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:38:39 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
Date:   Wed, 12 Sep 2018 20:08:22 +0530
Message-Id: <20180912143822.21948-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
is in-correct. This patch shows CPU ID and Hart ID separately
in /proc/cpuinfo using cpuid_to_hardid_map().

With this patch, contents of /proc/cpuinfo looks as follows:
cpu	: 0
hart	: 1
isa	: rv64imafdcsu
mmu	: sv48

cpu	: 1
hart	: 0
isa	: rv64imafdcsu
mmu	: sv48

cpu	: 2
hart	: 3
isa	: rv64imafdcsu
mmu	: sv48

cpu	: 3
hart	: 2
isa	: rv64imafdcsu
mmu	: sv48

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kernel/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f0f0ec2737b7..7c1342e242e6 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -87,7 +87,8 @@ static int c_show(struct seq_file *m, void *v)
 						   NULL);
 	const char *compat, *isa, *mmu;
 
-	seq_printf(m, "hart\t: %lu\n", cpu_id);
+	seq_printf(m, "cpu\t: %lu\n", cpu_id);
+	seq_printf(m, "hart\t: %lu\n", cpuid_to_hardid_map(cpu_id));
 	if (!of_property_read_string(node, "riscv,isa", &isa)
 	    && isa[0] == 'r'
 	    && isa[1] == 'v')
-- 
2.17.1

