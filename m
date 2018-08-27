Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27576C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA181208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DMaigmw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA181208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeH0Wqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38207 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH0Wqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so7398pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=tS7zRWdd15kfyiSebAWS3VyxqqXFazZi8cIkgiYuQkM=;
        b=DMaigmw+gldRTyWzc5XtnrIFwyUPt/e5ENmvbhsNckqNKQxfIHZbRUDaq1PEdrbvNt
         NOPdvYtuvQGqnfFDgA0pBM55pnVQC80z+BVHgLRKkEOGxy4NbXYoSoacgZm5/hdChjv/
         Ear6xEOIv7exsWXtsi05oBtKeAgEPj/MfYVRHLLEamQgKaQJxqoF5aptCMsmyljFv/g7
         +B2P6YZHDctdahbBlf2+UfJSAFqnT+w6yvGJabzAHKU2Ph4nhb9AwbsZfbo6aGWoQMUW
         vF2LnVKRj8hC7heCFAvE2eoctqxiblxlZPXm9+JXeEsVhkanxAGkc0a8x+W9+IQ4mVdL
         J3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=tS7zRWdd15kfyiSebAWS3VyxqqXFazZi8cIkgiYuQkM=;
        b=kXDWnUiJLqW0Oy0tg1JKLIw0xLeGmskmmtBV7DhbfPicO3LFU0eHA/psAeUhFhZdjF
         n7g5dMPcqejBYxIt7s5egSkLp8v4lfKBmOXGDViwYH0bdvrj+1r2lTc9iwpPBANgNFfu
         dD2NJJ3VMVlDJHTHSzCADwd9uzDmj7YriuRKoLahhR8g093SYo1prFnYICY6MEJqqnE4
         VHQvoc9N2dD6UU5JYa5A75uCv5YIFCFgR5HlAtu+XXjbldzQwx3zFbiVz0kj0havckXM
         6R5KpIP1TQVRX5XURVtn2dbh+UqRQsuKtjMd6aodJwxwMu0DpiwcGFmzulF/inweGRAT
         RDEA==
X-Gm-Message-State: APzg51AeObVFjSGt7+cPCab7n5iRmGbJkTloAOkVkh1N8niCxZpqPICU
        MRc3iXZ0O9n8aB0ay8CzRdlcRA==
X-Google-Smtp-Source: ANB0VdZOo8UVgFfdd553u2UcaU2rWdc41hbb9MRrlKosRrA9DdXXj51pjzBRX4fVepW8aIhEogrIYg==
X-Received: by 2002:a62:444d:: with SMTP id r74-v6mr15448674pfa.96.1535396334633;
        Mon, 27 Aug 2018 11:58:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f19-v6sm24629000pfd.147.2018.08.27.11.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:53 -0700 (PDT)
Subject: [PATCH 8/8] RISC-V: Disable preemption before enabling interrupts when booting secondary harts
Date:   Mon, 27 Aug 2018 11:42:43 -0700
Message-Id: <20180827184243.25344-9-palmer@sifive.com>
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

I'm not sure, but I think this was a bug: if the scheduler fired right
here then I believe it would blow up.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/smpboot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 953bc540207d..45515cc70181 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -110,7 +110,9 @@ asmlinkage void __init smp_callin(void)
 	/* Remote TLB flushes are ignored while the CPU is offline, so emit a local
 	 * TLB flush right now just in case. */
 	local_flush_tlb_all();
-	local_irq_enable();
+	/* Disable preemption before enabling interrupts, so we don't try to
+	 * schedule a CPU that hasn't actually started yet. */
 	preempt_disable();
+	local_irq_enable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
-- 
2.16.4

