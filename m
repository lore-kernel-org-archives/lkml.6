Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095EEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B999B208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GkwzEejS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B999B208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeH0Wqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36196 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Wqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id e11-v6so11675plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=OOeABwsbWj8Lm5KgLNQ8fyixI3Acx/LIuBZl+NhzE20=;
        b=GkwzEejSJXTyEa6Nr2sz2J9ptcKHwUSdNT7s+/Ymt6mRp/HQLVvceBFdBOqmucOV+P
         d/eNWhLSAE1wWL+00MbjznGzYmzt3xWr/sklInfltbl55ujL8kDZ1S/LeUXXCKDkUtnL
         ocRdU22ODCIKn5SK4ZIr6vf9pZepjN9fEbaoDx7mvZxwt413r/M1h4LiXBNxaoKCMJCD
         M/ORmoVh/6hA8nIZbvGWBQweNyBGBzfSl4lZ4Ou7FTM9YLoTQawjmE2/59xneFv/j8ye
         b1rjJgFw9yOLBqGQSxF9E3V3bIS7/b/WZUlNbBt8MNSVFddcgPgBvsFMfdiwq6DQqTG9
         Mtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=OOeABwsbWj8Lm5KgLNQ8fyixI3Acx/LIuBZl+NhzE20=;
        b=tx9eMa75rh/Oq7AsfT7/KeV4JOfPuDuJ7ly3VtCnnbmxNyU8+k0+DebzNsD5df1LCW
         8W2w/dqqJyz7R+xwHUD1Xglzg0WIkSn/K+iYsr4tOeVlzmak2L2Wsy05e+F6XOAn7cN2
         1GpYz1UT1HQWRL0B7uPqzIpCQPVBaNe/VWheaW6ypGB9mZTVvvj5zBjraPBydUwXi8DN
         3VQNiw+fz8a1/pCDbdXlnP5GsQDkJ/W5OQChUzDrX6V5qwXEjqQtAqo3gxAJQi1AZfvw
         qHp9jJwMdhlvHpN7ccJouMITzM3R8CbYZ4lqsr/UZ+qb4TVM9bULTD0rgPmLkzb26WzB
         LfQw==
X-Gm-Message-State: APzg51DfoE9EZh882ghyErxbSFA2107bbOd6jnJtVOW5hGTHlvgAGfIu
        z0xF/xtUekoO/H2BkvVB01NqdQ==
X-Google-Smtp-Source: ANB0VdbNtFbL7zL8zb5JMXNlKa8em9apvnz8Pq7O57ZchtzaclHtde+4NGtUEfrvy4ftKOn68YxQ/A==
X-Received: by 2002:a17:902:7d91:: with SMTP id a17-v6mr3655923plm.123.1535396324127;
        Mon, 27 Aug 2018 11:58:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n4-v6sm19574572pgp.80.2018.08.27.11.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:43 -0700 (PDT)
Subject: [PATCH 3/8] RISC-V: Rename riscv_of_processor_hart to riscv_of_processor_hartid
Date:   Mon, 27 Aug 2018 11:42:38 -0700
Message-Id: <20180827184243.25344-4-palmer@sifive.com>
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

It's a bit confusing exactly what this function does: it actually
returns the hartid of an OF processor node, failing with -1 on invalid
nodes.  I've changed the name to _hartid() in order to make that a bit
more clear, as well as adding a comment.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/include/asm/processor.h | 4 +++-
 arch/riscv/kernel/cpu.c            | 2 +-
 arch/riscv/kernel/smpboot.c        | 2 +-
 drivers/clocksource/riscv_timer.c  | 2 +-
 drivers/irqchip/irq-sifive-plic.c  | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3fe4af8147d2..9d32670d84a4 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -88,7 +88,9 @@ static inline void wait_for_interrupt(void)
 }
 
 struct device_node;
-extern int riscv_of_processor_hart(struct device_node *node);
+/* Returns the hart ID of the given device tree node, or -1 if the device tree
+ * node isn't a RISC-V hart. */
+extern int riscv_of_processor_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ca6c81e54e37..19e98c1710dd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 
 /* Return -1 if not a valid hart */
-int riscv_of_processor_hart(struct device_node *node)
+int riscv_of_processor_hartid(struct device_node *node)
 {
 	const char *isa, *status;
 	u32 hart;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 56abab6a9812..5f29f8562cf6 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -53,7 +53,7 @@ void __init setup_smp(void)
 	int hart, im_okay_therefore_i_am = 0;
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
-		hart = riscv_of_processor_hart(dn);
+		hart = riscv_of_processor_hartid(dn);
 		if (hart >= 0) {
 			set_cpu_possible(hart, true);
 			set_cpu_present(hart, true);
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 4e8b347e43e2..ad7453fc3129 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -84,7 +84,7 @@ void riscv_timer_interrupt(void)
 
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
-	int cpu_id = riscv_of_processor_hart(n), error;
+	int cpu_id = riscv_of_processor_hartid(n), error;
 	struct clocksource *cs;
 
 	if (cpu_id != smp_processor_id())
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 532e9d68c704..c55eaa31cde2 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -176,7 +176,7 @@ static int plic_find_hart_id(struct device_node *node)
 {
 	for (; node; node = node->parent) {
 		if (of_device_is_compatible(node, "riscv"))
-			return riscv_of_processor_hart(node);
+			return riscv_of_processor_hartid(node);
 	}
 
 	return -1;
-- 
2.16.4

