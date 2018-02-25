Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeBYRYt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 12:24:49 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37599 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeBYRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 12:23:07 -0500
X-Google-Smtp-Source: AH8x225GV4DdsWu6hbnXCus9QJ8ixe767noPnq+Ahk7ZEUZ4am/23voCpAl8ETbWjaIL6ism3obFVw==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 12/21] powerpc: Add missing prototype for time_init
Date: Sun, 25 Feb 2018 18:22:27 +0100
Message-Id: <20180225172236.29650-13-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function time_init did not have a prototype defined in the time.h
header. Fix the following warning (treated as error in W=1):

  CC      arch/powerpc/kernel/time.o
arch/powerpc/kernel/time.c:1068:13: error: no previous prototype for ‘time_init’ [-Werror=missing-prototypes]
 void __init time_init(void)
             ^~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/time.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index a7a8a9ac5991..828ebe7ba7dc 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -205,6 +205,7 @@ struct cpu_usage {
 DECLARE_PER_CPU(struct cpu_usage, cpu_usage_array);
 
 extern void secondary_cpu_time_init(void);
+extern void __init time_init(void);
 
 DECLARE_PER_CPU(u64, decrementers_next_tb);
 
-- 
2.11.0
