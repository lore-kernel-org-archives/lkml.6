Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F37F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfAJQ1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:27:55 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:56733 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbfAJQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:26:22 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6KQZ-1hNB0I3voH-016iww; Thu, 10 Jan 2019 17:25:20 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        firoz.khan@linaro.org, ebiederm@xmission.com,
        deepa.kernel@gmail.com, linux@dominikbrodowski.net,
        akpm@linux-foundation.org, dave@stgolabs.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 11/15] mips: fix n32 compat_ipc_parse_version
Date:   Thu, 10 Jan 2019 17:24:31 +0100
Message-Id: <20190110162435.309262-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NTeLC7MR2Bco8KMPQbeHemq+c8XkDiSkrQwrov4uU0Z2HIvLK3h
 B70xuWmOCA+GgP9GbJW06L0FSoky+iyRXiPQtor05zQnX3nSWgbCFexomF8JWeeFg3drH3y
 rXvQCh8Qq2yvqHXdwWp+IqlKijE958CWOwGDX5zrvh45L7DSmguLRjdatci2FIWThGOBeMO
 7Grv+aoRjg5U7DHRIfGJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9+dY9LvBJI=:bKGBCt806147bZ4SdhcCjz
 CjfhFmq62oMPvk12bhL/NPBuD+5FlocKRN+VDrlu+h+1YO7B5XMKs1rQ3bMyWXFjXtyrfVUmf
 ROFcBae7Gm7dn55/DbQjGxJB0kf9LN8M3r7dfpsX/llHt7fhXBWYwXxcBTsUfD0welfTav328
 EDIRylUi4qTuCL5Iz1Nfi2GSWB4mXFvcQ3V2YCErrq9qaRl3dP0Xj/QHcw2UC5UHXD2RrZNun
 ajqDXU4WSW9wdw5rWh9WyppYeb+r8+uvy8qnSE4JZkaLcvMsJ4wyypUhZvpUSQX4QefATbLZd
 z51aUK8wUHE+2Egci+WDHRnqzes2wM5K6O/LXALHZJITLXvaigwteu6ieZqq10+GZdb3+ct8z
 czBjsXuimew+gJhrQLYucnaH0q1xO8HZpwXJus5JJIY7c7UipaP7g+Y4XOcfDevXN1QRC/PqW
 UDf3gCSIyz5BygoBlLNZlYIfD243aj1b2j7/b3cne1RchQTejvJtnWreir8CZpzVDssrP5t7p
 2lbK8eWngwNVdCPotXiIUPbEC2XxM3avQAZj82p/+02ovqTGk11Z3iwL6txAojsEk31Q21+Ll
 4yTnEhil5jv8i1KAoINI+qkfWyZbpyy5Xl8BgJBk/x1Zu7W4l6OI8S2bLKyO/j7NTkKOylmda
 UcIZbdDo1TJkxvo4XDfB2o6PCbxZ2+UvgAyNn37onfsy4lX/gDc7LwuqgrnG7rp7o4p0dybPS
 aALSWonHNDRdQhORpQPMx1dXI5BMScV7uDxMFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reading through the sysvipc implementation, I noticed that the n32
semctl/shmctl/msgctl system calls behave differently based on whether
o32 support is enabled or not: Without o32, the IPC_64 flag passed by
user space is rejected but calls without that flag get IPC_64 behavior.

As far as I can tell, this was inadvertently changed by a cleanup patch
but never noticed by anyone, possibly nobody has tried using sysvipc
on n32 after linux-3.19.

Change it back to the old behavior now.

Fixes: 78aaf956ba3a ("MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT but no compat ABI.")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
As stated above, this was only found by inspection, the patch is not
tested. Please review accordingly.
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 787290781b8c..0d14f51d0002 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3155,6 +3155,7 @@ config MIPS32_O32
 config MIPS32_N32
 	bool "Kernel support for n32 binaries"
 	depends on 64BIT
+	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC
-- 
2.20.0

