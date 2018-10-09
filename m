Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A3C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6013D214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6013D214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeJJDcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:32:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:33327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeJJDcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:32:11 -0400
Received: from ls3530.fritz.box ([92.116.190.11]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LswqM-1fi9aY1vT8-012cJ6; Tue, 09
 Oct 2018 22:13:24 +0200
Received: from ls3530.fritz.box ([92.116.190.11]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LswqM-1fi9aY1vT8-012cJ6; Tue, 09
 Oct 2018 22:13:24 +0200
Date:   Tue, 9 Oct 2018 22:13:21 +0200
From:   Helge Deller <deller@gmx.de>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v3 4/6] parisc: uapi header and system call table file
 generation
Message-ID: <20181009201321.GA28911@ls3530.fritz.box>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-5-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538975801-13735-5-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:/PWtdBnS8lDeTPmWziQV9OMb06a4zQCtAhKO80BxaVYiDnCf1VI
 zMkH+7ll66aH4M+qesTL2bFBaQa84oXmOkq7+l9/+O8sZQRUD5UqnfGkI4Y8OvlkMgabb1+
 GYAJaL9jEnGzuc8Ul+bGi1/HJGaZmQt3FkBL0mz1liREGrxsizGzoD74byIDO/5++dARlS1
 FaDzvr1xdjJGV8hF1wdrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mHUcCajHNrs=:dC0Qg7JRqKXrhgRXm+VQ/c
 UJZynhic4ymOWa+fyQaRZSq7rCr8xdAgjpEFoXhq7og7MFFbr0NmZ83MgreBvp1XISVtsHaVM
 QqluUNapVDNjLZMoga+jFMXnTdr9MOrbCHp+6OSHu9eMziCmOyH3YItfXK0r77Am5NkakuH8p
 rkv0IrbxNTLWesZB+5gIPKHe4X9e41SRKkuUX+zm0NQCOeBSahqYfTP5bgZ7mCa6Z+LeRWr+r
 Ol4/fE/AqJ3bt/y0e/61y3HCWQwyU7CX5R5u3gFzEtQ4QSBCFfmh8v8JVNOn/toeg8uFE8BZR
 NLdCpVrbnmtxH+GupDrchAQwKnE/sT2KD45+oRXwGXnEK2L5Iyxmf1lwFId1LqHwXzbIgGhE9
 vJAgBCQMMiizDyKultuUxJXebXiAa/Xf5bcQ+0PNC2pcfZ0JdwSmxq9soXv/9RZmIXdPxRUT9
 Hy7EyOeyFIo+UEJak/EUPjgb/WPF4I8ondjR5L/5qG2EN0Ct8WZ5EWL6rQLESpqIl86jlQIHY
 LwE1+uEGlp+XgLnCeUG+jigsWRIp8haiSrHEwED6YZTMusSFTanlnk80dRMHwvzK433cFIBTU
 iFzmIg5VI+7k3tOZ7e8yXTkL/vVPlk4cQTKvbELg/YjpGmWor7zBWx0BpmrR9S/LNlhaCawNL
 gsXTLySu3hZ1yBQn3+n0vSJ1eH8TnxpYd2GUHHWkVqh0nwsdsU9c0Q9lwT70qvv7jj/9tXyGp
 nenZBno9BDWiQPOEdQm/Cnz85GKNEcK/8oojbY+b5VfSlKzgjp6wq8Aqu5KGuVwYCQ7zftfHt
 f8hyMMdh0ttFn9BoztMCn7qdnlhOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Firoz Khan <firoz.khan@linaro.org>:
> System call table generation script must be run to generate
> unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
> will have changes which will invokes the script.
> 
> This patch will generate unistd_32/64.h and syscall_table_
> 32/64/c32.h files by the syscall table generation script
> invoked by arch/parisc/Makefile and the generated files against
> the removed files will be identical.
> 
> The generated uapi header file will be included in uapi/asm/
> unistd_32/64.h and generated system call table support file will
> be included by arch/sparc/kernel/syscall_table_32/64.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/parisc/Makefile                  |   4 +
>  arch/parisc/include/asm/Kbuild        |   3 +
>  arch/parisc/include/uapi/asm/Kbuild   |   2 +
>  arch/parisc/include/uapi/asm/unistd.h | 373 +--------------------------
>  arch/parisc/kernel/syscall.S          |  12 +-
>  arch/parisc/kernel/syscall_table.S    | 459 ----------------------------------


Can we please get rid of those two new files: 

>  arch/parisc/kernel/syscall_table_32.S |  13 +
>  arch/parisc/kernel/syscall_table_64.S |  20 ++

Both are not needed (at least on parisc) if you apply the following
patch on top of your patch series.
This patch finally fixes the 64-bit kernel on parisc (tested on real
hardware).

Helge

diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 2523b83b88d8..45cddeeb968f 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -923,10 +923,20 @@ ENTRY(lws_table)
 END(lws_table)
 	/* End of lws table */
 
-#include "syscall_table_32.S"
+#define __SYSCALL(nr, entry, nargs) ASM_ULONG_INSN entry
+
+ENTRY(sys_call_table)
+#if defined(CONFIG_64BIT)
+#include <asm/syscall_table_c32.h>	/* compat syscalls */
+#else
+#include <asm/syscall_table_32.h>	/* 32-bit native syscalls */
+#endif
+END(sys_call_table)
+
 #ifdef CONFIG_64BIT
-#define SYSCALL_TABLE_64BIT
-#include "syscall_table_64.S"
+ENTRY(sys_call_table64)
+#include <asm/syscall_table_64.h>	/* 64-bit native syscalls */
+END(sys_call_table64)
 #endif
 
 	/*
