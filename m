Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AIpwx4+hpL390jBy/WRiZpDAD09Qz+EC7+BE8m94LtyUX20eQFWHJKn4RYf5OXS+uLdB4RycHz4O
ARC-Seal: i=1; a=rsa-sha256; t=1522671903; cv=none;
        d=google.com; s=arc-20160816;
        b=j5G+4WFTwnifTU5zHEtmP5yv3ovG7dk+D5j6RHTCACyo2sGxmb+pLalD0bM36JuZW7
         pS6TVzVdPOVVI7FFzVdjiAEihO5SO7sNyjqOgBI64hFhPmHcTKLxHgSuDDBTGhQGtmbB
         nqmusBnZfpskJBORizGn7n3CBd9yctx6rszr64YWPPMepa7mmLBq44TnPER8gWJpMoZh
         b8VFXeUJOcXREEoYmPDBCpvmNCVx7ppot3QbYTZISoqbLdgqJtMtD1v1J6PzyLI7kAZZ
         RYXrXl7k1mgsMuF3JrNUu4YtNrx8x/GLfiljkbePy9b0NES3XBmYXI7tqBAe1UTlnvUu
         j7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:to:from
         :arc-authentication-results;
        bh=42BcgaJnAkq+2rJ1rntz2JwK5cZiMbI/Af8WYX0NF08=;
        b=qy5uxTY8+iBUUE5Ysmb2HX998STi34iPZVMR9Ozu/+mXDPS/gG/dU/l4xaKhkYryZu
         A0UPlMcOZ54tvsNLh32VlTMm1oDkMSCUgmldbT/zf9GYKJoqVO8ORajkdtZ16RwO7yCB
         r57RyDvsnYNMspo2xvrEWynea07h88JOvtjQjXq86v0ZoxXWhVjjWAvBG8fpc4CzH1G8
         A8u9QsAEzH6bFYAt7bQKiwX7n69sTX12VzK2FTTogefaU/4trXejRpdP8cQu27W6HGU6
         8FY0IbCtMLUi+Ba6LycUzm6FNqEluhpT4yNrFsKAG4NFCjpyE/ptdHYUSdUCcDwi8WKQ
         9ktw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.35 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <aryabinin@virtuozzo.com>, <dvyukov@google.com>, <corbet@lwn.net>,
	<linux@armlinux.org.uk>, <christoffer.dall@linaro.org>,
	<marc.zyngier@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<liuwenliang@huawei.com>, <akpm@linux-foundation.org>,
	<linux@rasmusvillemoes.dk>, <mawilcox@microsoft.com>, <pombredanne@nexb.com>,
	<ard.biesheuvel@linaro.org>, <vladimir.murzin@arm.com>,
	<alexander.levin@verizon.com>, <nicolas.pitre@linaro.org>,
	<tglx@linutronix.de>, <thgarnie@google.com>, <dhowells@redhat.com>,
	<keescook@chromium.org>, <arnd@arndb.de>, <geert@linux-m68k.org>,
	<tixy@linaro.org>, <julien.thierry@arm.com>, <mark.rutland@arm.com>,
	<james.morse@arm.com>, <zhichao.huang@linaro.org>, <jinb.park7@gmail.com>,
	<labbott@redhat.com>, <philip@cog.systems>, <grygorii.strashko@linaro.org>,
	<catalin.marinas@arm.com>, <opendmb@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <kasan-dev@googlegroups.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.cs.columbia.edu>,
	<linux-mm@kvack.org>
Subject: [PATCH v3 6/6] Enable KASan for arm
Date: Mon, 2 Apr 2018 20:04:40 +0800
Message-ID: <20180402120440.31900-7-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180402120440.31900-1-liuwenliang@huawei.com>
References: <20180402120440.31900-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596637213618557598?=
X-GMAIL-MSGID: =?utf-8?q?1596637213618557598?=
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
index 7e3d535..ac2287b 100644
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
