Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEQVbk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 17:31:40 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39357 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQVbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 17:31:38 -0400
X-Google-Smtp-Source: AB8JxZoFDsQAw0uADBgnf/WRt0lyt36YP3WOPB7uo7Ox9PcFy1hgl54GDu8/0A5nDzgSyRGEFw3Ffw==
Date: Fri, 18 May 2018 00:31:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: x86@kernel, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86: verify_cpu: use XOR for CPUID.EAX=0
Message-ID: <20180517213135.GB4047@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOV eax, imm32 is 5 bytes. XOR eax, eax is 2 bytes.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/kernel/verify_cpu.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -51,7 +51,7 @@ ENTRY(verify_cpu)
 	jz	.Lverify_cpu_no_longmode	# cpu has no cpuid
 #endif
 
-	movl	$0x0,%eax		# See if cpuid 1 is implemented
+	xor	%eax, %eax		# See if cpuid 1 is implemented
 	cpuid
 	cmpl	$0x1,%eax
 	jb	.Lverify_cpu_no_longmode	# no cpuid 1
