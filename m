Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28104C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DF5214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m36ndSYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DF5214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeLFJ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:56:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39386 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeLFJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:56:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so22583628wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y1O0i4LsrdJRLR5xupdJwfh3yMg1QXWfDUS+Qohz1NU=;
        b=m36ndSYHhatelG/LGALpZcBP8+UyUVRWbWm/hkJ5gXXj4HN/OmyoCTUYrwZsDOCn4L
         HfB3dvaa+3BsXHD9OFTdBMuLz5goSPtbPRaCs3DEK+xaDHL5YXBTkphC/SzFm0ce7KcI
         oe6fkvTEqgsPHYW9j/vprkWGYRYNKm9DPUAYYpuXL32O5rpK2PRbL0DVZN2yktDmB26V
         CO/9qXHIwPRn8y7puddkoY0dEgOmnvrz0nvLczLJr/Dbux2YhkUuIYhepT4Cq5rnJIYv
         U9DAYdDKDozX2zNYQ0AB+nFGL60nVQn8evYJ1aPMJOV4uYhQK6Tc3Z4WlP0Zo4uEtsdT
         arNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y1O0i4LsrdJRLR5xupdJwfh3yMg1QXWfDUS+Qohz1NU=;
        b=oD1QoSP8eAr9//6H23D4Fa0VuNXp7UaKU/FpAPlXqud05p3Hes061VgDJrIZXxc191
         NEr3BNyNMDrl0psFCNHim2ZaKahkBzGHEHULRopYVt3//RI6ALJ9aUKnKLKYlbbyINvS
         85VtML7IeZWwX3eBA6cIJ86tPwc0zHbjaVyjxY9ntGvXK6t/4AWBJor+PvAd5Ek6NcA6
         DI50rYUj7IQRcXvqU1ZxgHwXXAUOBz71HpIukrjk7soVWFQfo9PNH0pcbge9EFkj4hFw
         B8J2rfTNXcDio0ygvOE220jhZzd61EN2IWzXWTgAaRwknbq0f+D3ZyQk3sdctUehYuBx
         kRfQ==
X-Gm-Message-State: AA+aEWYopGnM7WxWUmReT+OhaLIovzSeG1OV/m/ELkCURW6fdJ9EqQ6p
        DwcgGzBMSBNmrweX8FYYLA==
X-Google-Smtp-Source: AFSGD/W7IbKs4CSA3RsXd6bpA3FYkb2rTmfGhYqeSA6vgJX1oi8q3vReplyylPP+J4M2hMzxwu7lNA==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr26156859wrw.304.1544090209864;
        Thu, 06 Dec 2018 01:56:49 -0800 (PST)
Received: from localhost (host34-126-dynamic.27-79-r.retail.telecomitalia.it. [79.27.126.34])
        by smtp.gmail.com with ESMTPSA id b16sm21618452wrm.41.2018.12.06.01.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 01:56:49 -0800 (PST)
Date:   Thu, 6 Dec 2018 10:56:48 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt functions
Message-ID: <20181206095648.GA8249@Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These interrupt functions are already non-attachable by kprobes.
Blacklist them explicitly so that they can show up in
/sys/kernel/debug/kprobes/blacklist and tools like BCC can use this
additional information.

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/x86/entry/entry_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ce25d84023c0..1f0efdb7b629 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -566,6 +566,7 @@ ENTRY(interrupt_entry)
 
 	ret
 END(interrupt_entry)
+_ASM_NOKPROBE(interrupt_entry)
 
 
 /* Interrupt entry/exit. */
@@ -766,6 +767,7 @@ native_irq_return_ldt:
 	jmp	native_irq_return_iret
 #endif
 END(common_interrupt)
+_ASM_NOKPROBE(common_interrupt)
 
 /*
  * APIC interrupts.
@@ -780,6 +782,7 @@ ENTRY(\sym)
 	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
 END(\sym)
+_ASM_NOKPROBE(\sym)
 .endm
 
 /* Make sure APIC interrupt handlers end up in the irqentry section: */
@@ -960,6 +963,7 @@ ENTRY(\sym)
 
 	jmp	error_exit
 	.endif
+_ASM_NOKPROBE(\sym)
 END(\sym)
 .endm
 
-- 
2.17.1
