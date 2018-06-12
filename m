Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6D649C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210F3208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lbmlb5n8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210F3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754423AbeFLUtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:49:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39276 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753517AbeFLUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:49:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id w7-v6so403363wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=MpiRjHj4g89PdprBUicm3hngwetF+rdWseWCSZDOChk=;
        b=lbmlb5n80/NdD4FAc0i+iL33vTb9DYeJVTrzDueMiSsAai5BOx2n0i4o8+vYnRv0CI
         vHGbTGjKaRVVqfP/7b65LDzCwTxdSeeUKxF8x1W0cDEPZQe5tleN5yKml7WnEK5Qsbpy
         GZLy16mZ7SlTUhriOdSyvYYLNxcSWJUDzvxAgMlQCo9ivRDYwbg+qQ40kkx0YPYPOE4W
         HTS5CsHs1yBtefaXnPhNxEJhkNqtAKiqgZl3mu5egIDH8pPTyyNx9IBoI1Rj673dWvzK
         5M+v4fWOoinjsei7mSFrEC/Wypl3dupQYUb90yM4fXcgf5ury+Q8kj9yFyvGitHh4tx/
         8l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MpiRjHj4g89PdprBUicm3hngwetF+rdWseWCSZDOChk=;
        b=s7wMBTuJzW4ZINI02tm9pSUn4+BsnKol4JTRnJowxnUryeu6ezudYTZH1jWGwYtx3P
         LVTc2KM55vvs4WWtBuQ3VWGHHV/ZraabfFwhZ+4DwxTzh1uOGZt92nX9e+cjJf559bYv
         tzfPdDdxiSum95VNIxn4ZxZuD3r2ugFzQXuCEHrA9k6YR7iUCFSDpw/f/ISeuyZYWODT
         FTljk6UdN0lD6iJQILXP4EHMOoYkhsBwR/YbPiR9XIDtotZMy/I4mxy9WHJAtLeWAoOE
         /jYotdZ22EY9Wx3YEZyNQ39hzETHAbq26xVziGz8ZvNOPqiHq0BvJ9KIXmmfBtSqVFos
         0BMg==
X-Gm-Message-State: APt69E0IrDE6LCjNt0bUDQYDCukkGcPW8oJahCGT3vbL3VZtYXdvq/1y
        b2wATfGvhq7a411tZnCSKKPRJmLfCGc=
X-Google-Smtp-Source: ADUXVKIofw8TihljlEhYIu3yMaziPnf+9Cn66fy34K07/046n/V700ULpzCCY4VUOwe9tx1EVyBgrw==
X-Received: by 2002:a5d:4a4d:: with SMTP id v13-v6mr1866441wrs.91.1528836589861;
        Tue, 12 Jun 2018 13:49:49 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id e17-v6sm528446edq.12.2018.06.12.13.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:49:49 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasiliy Khoruzhick <vasilykh@arista.com>, x86@kernel.org
Subject: [RFC] x86/vdso: Align vdso after searching for free area
Date:   Tue, 12 Jun 2018 21:49:48 +0100
Message-Id: <20180612204948.4752-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is errata for AMD family 15h CPUs [1] and since
commit dfb09f9b7ab03 ("x86, amd: Avoid cache aliasing penalties on AMD
family 15h") bits [14:12] are being cleared for shared libraries.
Also per-boot ASLR applies over upper bits by OR directly over the
address.

As we need special alignment and lower bits values to be set, it makes
only a little sense to call get_unmapped_area() after calculating the
address. It also can lead to random crashes if get_unmapped_area()
actually changes/aligns the address, which we observed on 15h CPU.
Usually it's not a problem as there isn't many mappings (except possibly
ld.so, uprobes?) and result address is the same before/after
get_unmapped_area().

Move align_vdso_addr() after get_unmapped_area() to make sure that
errata for AMD 15h is always applied.

[1]: https://developer.amd.com/wordpress/media/2012/10/SharedL1InstructionCacheonAMD15hCPU.pdf
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Cc: x86@kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c    | 18 ++++++++++--------
 arch/x86/include/asm/elf.h   |  1 +
 arch/x86/kernel/sys_x86_64.c |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556dbb12..862f0cce3ee6 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -154,18 +154,26 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long text_start;
+	unsigned long area_size = image->size - image->sym_vvar_start;
 	int ret = 0;
 
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
-	addr = get_unmapped_area(NULL, addr,
-				 image->size - image->sym_vvar_start, 0, 0);
+	/* Find a bigger place for vma then needed - to align vdso later. */
+	area_size += get_align_mask();
+	addr = get_unmapped_area(NULL, addr, area_size, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret = addr;
 		goto up_fail;
 	}
 
+	/*
+	 * Forcibly align the final address in case we have a hardware
+	 * issue that requires alignment for performance reasons.
+	 */
+	addr = align_vdso_addr(addr);
+
 	text_start = addr - image->sym_vvar_start;
 
 	/*
@@ -239,12 +247,6 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 		addr = start;
 	}
 
-	/*
-	 * Forcibly align the final address in case we have a hardware
-	 * issue that requires alignment for performance reasons.
-	 */
-	addr = align_vdso_addr(addr);
-
 	return addr;
 }
 
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2a1e2a..88aa49294c9c 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -382,4 +382,5 @@ struct va_alignment {
 
 extern struct va_alignment va_align;
 extern unsigned long align_vdso_addr(unsigned long);
+extern unsigned long get_align_mask(void);
 #endif /* _ASM_X86_ELF_H */
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 6a78d4b36a79..4dd74c6f236d 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -27,7 +27,7 @@
 /*
  * Align a virtual address to avoid aliasing in the I$ on AMD F15h.
  */
-static unsigned long get_align_mask(void)
+unsigned long get_align_mask(void)
 {
 	/* handle 32- and 64-bit case with a single conditional */
 	if (va_align.flags < 0 || !(va_align.flags & (2 - mmap_is_ia32())))
-- 
2.13.6

