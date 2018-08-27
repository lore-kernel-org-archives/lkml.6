Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78AFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDF5208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fofYOfJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDF5208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeH0Wqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38078 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbeH0Wqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id e2-v6so7483pgv.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=VVQ/j669lP7AtKkPCxikGWiRbu6RLArQXHpJiZK3da0=;
        b=fofYOfJUwER4Wx8jHvjiEK5B+KpWT6ugCf6AmfaUH35XBTRLuU/NyHDsk7gm7CUqL2
         +9/yBo44jqpjB0vtgOA/CUK6xtPlddDp6zPspAXz4LUreYywnX+jWUX4TSwSGdCkFqkJ
         AmTY+HvkPGudCniMsOoNUFRH16I93tKYHAxrQqGV/wyLBVh4XeupXOlnx2aOxMpSEZEt
         PQ8hD9SZfitEpNZ930Z3MSkYjO7gbalSXw1G971z/MbnrS13qyu8rmuQ/tiYgaPLQLMg
         lMGVLhNg4qpV0xIH3q+sdxtCfphFHzqxNaP1XvPNRZQFZUN9mR69E0403yB/q7p8VwFG
         vVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=VVQ/j669lP7AtKkPCxikGWiRbu6RLArQXHpJiZK3da0=;
        b=Ow8p5guUhc869FDv4pAAIVSKpTvhP0Ze2lipT/G94ahPSaIJqFup+fYDf6Y8QCQday
         HmfpMuktFUY1vDld5rf6hcCQe6RhJKDTwOhDKHrSVEHF7DU+z+TPDtM9t6iJ/pQuFdFg
         3/Y+utOx4scATJ7Mi4Qj9VelveGsnMDu8CxwpLWvOy8aYIsf0kdI8vzo6OJvUFPa8LRV
         QN8Li98o77l/6as2gQ/QYyDbLZ3VAhUxJqlEdPfWCEp1dBfp908A3TVJ3EnZZsS/c4Rn
         YBdgqHi8qUFogakxQ992mDw99Lk5Isa2eNkE3xC9lNdC48WQRc/u/KgrigYsiTBNXkYl
         Vsiw==
X-Gm-Message-State: APzg51DNYUh7WD7ziV33udlvurLpPHzp8Ccghk6yUMAYsii9QIC7VrbM
        6y9AGgxV1osaBch3mKgOaO4oHw==
X-Google-Smtp-Source: ANB0VdY8aB4U8CKjC+8xMkzu3sy+DzXjtSPHp+x8PWQi7coMOKb6zQLwnKR3f+YjSTf7C0RG/P8BsQ==
X-Received: by 2002:a62:2119:: with SMTP id h25-v6mr15766153pfh.112.1535396326393;
        Mon, 27 Aug 2018 11:58:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n9-v6sm14946pfg.21.2018.08.27.11.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:45 -0700 (PDT)
Subject: [PATCH 4/8] RISC-V: Filter ISA and MMU values in cpuinfo
Date:   Mon, 27 Aug 2018 11:42:39 -0700
Message-Id: <20180827184243.25344-5-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827184243.25344-1-palmer@sifive.com>
References: <20180827184243.25344-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, atish.patra@wdc.com,
        dmitriy@oss-tech.org, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, Greg KH <gregkh@linuxfoundation.org>,
        jeremy.linton@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't be directly passing device tree values to userspace, both
because there could be mistakes in device trees and because the kernel
doesn't support arbitrary ISAs.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/cpu.c | 62 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 19e98c1710dd..a18b4e3962a1 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -58,6 +58,57 @@ int riscv_of_processor_hartid(struct device_node *node)
 
 #ifdef CONFIG_PROC_FS
 
+static void print_isa(struct seq_file *f, const char *orig_isa)
+{
+    static const char *ext = "mafdc";
+    const char *isa = orig_isa;
+    const char *e;
+
+    /* Linux doesn't support rv32e or rv128i, and we only support booting
+     * kernels on harts with the same ISA that the kernel is compiled for. */
+#if defined(CONFIG_32BIT)
+    if (strncmp(isa, "rv32i", 5) != 0)
+        return;
+#elif defined(CONFIG_64BIT)
+    if (strncmp(isa, "rv64i", 5) != 0)
+        return;
+#endif
+
+    /* Print the base ISA, as we already know it's legal. */
+    seq_printf(f, "isa\t: ");
+    seq_write(f, isa, 5);
+    isa += 5;
+
+    /* Check the rest of the ISA string for valid extensions, printing those we
+     * find.  RISC-V ISA strings define an order, so we only print the
+     * extension bits when they're in order. */
+    for (e = ext; *e != '\0'; ++e) {
+        if (isa[0] == e[0]) {
+            seq_write(f, isa, 1);
+            isa++;
+        }
+    }
+
+    /* If we were given an unsupported ISA in the device tree then print a bit
+     * of info describing what went wrong. */
+    if (isa[0] != '\0')
+        pr_info("unsupported ISA \"%s\" in device tree", orig_isa);
+}
+
+static void print_mmu(struct seq_file *f, const char *mmu_type)
+{
+#if defined(CONFIG_32BIT)
+    if (strcmp(mmu_type, "riscv,sv32") != 0)
+        return;
+#elif defined(CONFIG_64BIT)
+    if ((strcmp(mmu_type, "riscv,sv39") != 0)
+        && (strcmp(mmu_type, "riscv,sv48") != 0))
+        return;
+#endif
+
+    seq_printf(f, "mmu\t: %s\n", mmu_type+6);
+}
+
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
@@ -83,13 +134,10 @@ static int c_show(struct seq_file *m, void *v)
 	const char *compat, *isa, *mmu;
 
 	seq_printf(m, "hart\t: %lu\n", hart_id);
-	if (!of_property_read_string(node, "riscv,isa", &isa)
-	    && isa[0] == 'r'
-	    && isa[1] == 'v')
-		seq_printf(m, "isa\t: %s\n", isa);
-	if (!of_property_read_string(node, "mmu-type", &mmu)
-	    && !strncmp(mmu, "riscv,", 6))
-		seq_printf(m, "mmu\t: %s\n", mmu+6);
+	if (!of_property_read_string(node, "riscv,isa", &isa))
+        print_isa(m, isa);
+	if (!of_property_read_string(node, "mmu-type", &mmu))
+        print_mmu(m, mmu);
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
 		seq_printf(m, "uarch\t: %s\n", compat);
-- 
2.16.4

