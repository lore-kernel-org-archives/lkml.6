Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx49laApV+4/YAAvKMtyJ4l5qjm0E8QaFAdRmKglFTz3dxs4QgOiKzuWyC+d4B4+8JUOKayod
ARC-Seal: i=1; a=rsa-sha256; t=1523538901; cv=none;
        d=google.com; s=arc-20160816;
        b=0muXjZ7x7e8ZrTmfFYiohDIFICl20Y33kDWzxM3GLufOMuPdtSj2/wdTB+8hf3/LME
         BfmP+ZjWUB2/zKAt2BVcVhf6BZ28eE/7hdg3bArX7D4BoBlsZkOSKfBmnfJKHqo4KiGQ
         lwCkd/RppV+oNQyw8rwr/WssxSjB4+WjCkTm6x8THRCnFK514TuYaAvtWjDJIZDi9JiZ
         PelzZVMSBbv+9UvdBJYxDDzkfuhxRauEJypiX2xhsbG6/l6R9MnBCL659H2WKrhDbi68
         wfQ7B8fmjbw10omZYrxAvuY039IGzAL/GgiRGI2Q5pcslIAU0IooaDdGqldDgNlzqmaq
         OZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=VAt99jAqTvB2oKyDTm7ekDeFuJ665ebK5ge/ZgqE4Po=;
        b=cMspnvWQyBA2GasUFjz6SQGCgX7b+/vI7I37Mgj8A6Pjz7JC3jZVKBuIRYnYX3OkID
         3A1Oe8+PL3XqxCcVesdv89qBZ+uiCp7KvzRdKFJhxLoma6VBL9weI2FkkSbyJSop4HH0
         kffITzcFnvR+o5S98R9q7g3QnbkDglz/v4+Zznkp2bxnPucoGai2b1BvJ3U4h2q9nk8i
         pq3Vtj6zuGXl7nzvhngSCiZeA8szUbpQJ2B5BZtm58idoJ5feG5pmL9Wt/hQbwwZTk5p
         8j1EH9h0vrZpXScKLgfKVHOk9K+fQDwDp3xVYE8eVG1GlyIaTd8OJXKexR86rncWG4tF
         x+IA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <aryabinin@virtuozzo.com>, <glider@google.com>, <dvyukov@google.com>,
	<corbet@lwn.net>, <linux@armlinux.org.uk>, <cdall@kernel.org>,
	<marc.zyngier@arm.com>, <arnd@arndb.de>, <nicolas.pitre@linaro.org>,
	<vladimir.murzin@arm.com>, <mingo@kernel.org>, <viro@zeniv.linux.org.uk>,
	<alexandre.belloni@bootlin.com>, <ard.biesheuvel@linaro.org>,
	<daniel.lezcano@linaro.org>, <pombredanne@nexb.com>,
	<kstewart@linuxfoundation.org>, <liuwenliang@huawei.com>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<mawilcox@microsoft.com>, <akpm@linux-foundation.org>,
	<mark.rutland@arm.com>, <afzal.mohd.ma@gmail.com>,
	<alexander.levin@verizon.com>, <tglx@linutronix.de>, <thgarnie@google.com>,
	<dhowells@redhat.com>, <keescook@chromium.org>, <geert@linux-m68k.org>,
	<tixy@linaro.org>, <julien.thierry@arm.com>, <james.morse@arm.com>,
	<zhichao.huang@linaro.org>, <jinb.park7@gmail.com>, <labbott@redhat.com>,
	<philip@cog.systems>, <grygorii.strashko@linaro.org>, <opendmb@gmail.com>,
	<mhocko@suse.com>, <kirill.shutemov@linux.intel.com>,
	<kasan-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.cs.columbia.edu>
Subject: [PATCH 6/6] Enable KASan for arm
Date: Thu, 12 Apr 2018 20:54:11 +0800
Message-ID: <20180412125411.326-7-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180412125411.326-1-liuwenliang@huawei.com>
References: <20180412125411.326-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597546327480494471?=
X-GMAIL-MSGID: =?utf-8?q?1597546327480494471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Ryabinin <a.ryabinin@samsung.com>

This patch enable kernel address sanitizer for arm.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Abbott Liu <liuwenliang@huawei.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 Documentation/dev-tools/kasan.rst | 2 +-
 arch/arm/Kconfig                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index f7a18f2..d92120d 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -12,7 +12,7 @@ KASAN uses compile-time instrumentation for checking every memory access,
 therefore you will need a GCC version 4.9.2 or later. GCC 5.0 or later is
 required for detection of out-of-bounds accesses to stack or global variables.
 
-Currently KASAN is supported only for the x86_64 and arm64 architectures.
+Currently KASAN is supported only for the x86_64, arm64 and arm architectures.
 
 Usage
 -----
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1878083..cd71bea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -49,6 +49,7 @@ config ARM
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_KASAN if MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
-- 
2.9.0
