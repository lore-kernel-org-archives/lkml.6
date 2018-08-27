Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9C2208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FGexe4i5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9C2208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeH0Wqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34776 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbeH0Wqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id u10-v6so16542pgr.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=bNKko3u8kBTJzVjDJntTO3XHS/eMwTd63KoZkoMaobw=;
        b=FGexe4i5Fw5vCfnRhM1XDv2jH7eBbhmVr5lPv7Uk+8FeZH/AgCQBsshpdtc2pI0phv
         oAe1oGlTKsgpibyClvcDVlFzw/c2L6LK7j02bnuYqaMkayk5eax3reASA/57iFxE82IJ
         7MUyS/QAVmjYT05tIjtaeBn02s4sj1HceW0vlSqUyloVbzeXVgm26XUCpPd6m5dKlUwE
         Z8yEt9a0ghrBV8J6skAtuGROv5ErQ/c6fUe7fxoHBuDZVM2OQczYiNde0MKxeA3aIOOP
         zj0a17E24SnuXs7rQRul8XfIutVBMLpoO49dm/pch7sEP3EPGafGiSe36hgRPLtya+BG
         tKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=bNKko3u8kBTJzVjDJntTO3XHS/eMwTd63KoZkoMaobw=;
        b=U2pqcpTSZ9MBcCgMJXf1dil6rhFAeoUeQq+f5QBigRKyigS+DBbOKDFJuSQ9K8m2TN
         HZIKy0t12k/c/QUlsDik+Ysq2GjhJeOO2OPL8l+ECSw6vBwDEWUEdL+xD3xgfYvM+SGf
         SU+OcXqBf9UgWaLGg39VzlkNLAY3J8JkVcIo2ZqViIFsPdhfiH4XX37P+J7YQNX49tc/
         hh86C57OtP/X+5XHK/96yki2yvvFVnE8OEDbN21EomHGGC73UFKwKXVah21q/xOp6UOU
         P96AgMIYGEUTabOj07yKQQ0R+JbEPKKXE7qhinheCpHz7JIVjK6mXCckUvV9SOC/J80B
         eTyQ==
X-Gm-Message-State: APzg51BJjJ31ye4YyBPQG1VEbXWxbaTPPPu2LCgYqXL0jzPrIdNcp3xr
        OFw69vFiQfXhkVCms045WNmF+A==
X-Google-Smtp-Source: ANB0VdaD8Zepv5Myc/nvgrOjfOUhEQnnMqoo3U8PnpvkyCGOycaG7e7xV81FBy3CO91E+N9+t1CZPw==
X-Received: by 2002:a62:83ca:: with SMTP id h193-v6mr15484347pfe.123.1535396328410;
        Mon, 27 Aug 2018 11:58:48 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l27-v6sm32876574pfi.180.2018.08.27.11.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:47 -0700 (PDT)
Subject: [PATCH 5/8] RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu
Date:   Mon, 27 Aug 2018 11:42:40 -0700
Message-Id: <20180827184243.25344-6-palmer@sifive.com>
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

The old name was a bit odd.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/smpboot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 5f29f8562cf6..e1f6a5ad0416 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -50,7 +50,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 void __init setup_smp(void)
 {
 	struct device_node *dn = NULL;
-	int hart, im_okay_therefore_i_am = 0;
+	int hart, found_boot_cpu = 0;
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
 		hart = riscv_of_processor_hartid(dn);
@@ -58,13 +58,13 @@ void __init setup_smp(void)
 			set_cpu_possible(hart, true);
 			set_cpu_present(hart, true);
 			if (hart == smp_processor_id()) {
-				BUG_ON(im_okay_therefore_i_am);
-				im_okay_therefore_i_am = 1;
+				BUG_ON(found_boot_cpu);
+				found_boot_cpu = 1;
 			}
 		}
 	}
 
-	BUG_ON(!im_okay_therefore_i_am);
+	BUG_ON(!found_boot_cpu);
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-- 
2.16.4

