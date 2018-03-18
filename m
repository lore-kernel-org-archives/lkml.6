Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELvycQHGOSF3CRZJ8ZR2cMk+eT7rS/TXv77FuSR12LuYKR2YNzte7B2jnTLZ06Lz0uVy/K4S
ARC-Seal: i=1; a=rsa-sha256; t=1521378853; cv=none;
        d=google.com; s=arc-20160816;
        b=En+qplfCfV1b80lGSmOh7ozxTNWoARarNmQyHRinis9RZQR886KZVO1FlzDoll8S2+
         zXW+rVWFuyb4hhWOTKXP48m7PXTYuNKyDUOe25L5+CEWUexNaK2yQyb/D0fjbbN1PTek
         TYyNnYIS7Z29quuRwNgNGplxnWQpdB8lrYM+5MRpYGVKSTlmCUcnn71b8mR5UgLXZCdn
         Q+NFh9LlaMbPdXpidR2La9bn7NfLxP6/R+oFn/AaH1e/MemhkxKeS5+yFo5QM9uUC0N1
         5+RVGmaITFoL/Z1R9Su4l/oQsU+yYR/We8Op2volPXHCtPvPllhon8FCudI6707Lb0Ff
         brNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=q8OtgO+5IgE3iZLbLLTr2ffKCFYIiFXVrYZ7nWtlbRg=;
        b=Iyka38L1uzykYSQ1ZYX8LAuHEfNTinLenjs+eU2vBLdeg1tb436xChmDK8NH8WbG7K
         9c9vd8TouHELXaceZoxhkk6EW3zvE/tqIqxLUWIaKddyKoXn+GRv/Xro8n90iw7UE33L
         8ipy8ekVj9Cg+HH85mVtEXynEB+w9/35VHTH0522jPKQch5aMKqsUfI383KMBmYne0Wy
         prLIUvJT/bF4m5RTwQwDxIpAAR93DdNzkniQDUCzASmiJ30QQMrza2PC12NGbLbA9wg/
         a3MatTy9qbXs2p4OL7e+Wd2nzjdND+asojNaPlC7Z5bjhDK3dXxF9632v3j3XKYmYuaY
         gBrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: Abbott Liu <liuwenliang@huawei.com>
To: <linux@armlinux.org.uk>, <aryabinin@virtuozzo.com>,
	<marc.zyngier@arm.com>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <f.fainelli@gmail.com>,
	<liuwenliang@huawei.com>, <akpm@linux-foundation.org>,
	<afzal.mohd.ma@gmail.com>, <alexander.levin@verizon.com>
CC: <glider@google.com>, <dvyukov@google.com>, <christoffer.dall@linaro.org>,
	<linux@rasmusvillemoes.dk>, <mawilcox@microsoft.com>, <pombredanne@nexb.com>,
	<ard.biesheuvel@linaro.org>, <vladimir.murzin@arm.com>,
	<nicolas.pitre@linaro.org>, <tglx@linutronix.de>, <thgarnie@google.com>,
	<dhowells@redhat.com>, <keescook@chromium.org>, <arnd@arndb.de>,
	<geert@linux-m68k.org>, <tixy@linaro.org>, <mark.rutland@arm.com>,
	<james.morse@arm.com>, <zhichao.huang@linaro.org>, <jinb.park7@gmail.com>,
	<labbott@redhat.com>, <philip@cog.systems>, <grygorii.strashko@linaro.org>,
	<catalin.marinas@arm.com>, <opendmb@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
	<kvmarm@lists.cs.columbia.edu>, <linux-mm@kvack.org>
Subject: [PATCH 7/7] Enable KASan for arm
Date: Sun, 18 Mar 2018 20:53:42 +0800
Message-ID: <20180318125342.4278-8-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180318125342.4278-1-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.187.223]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281352954780373?=
X-GMAIL-MSGID: =?utf-8?q?1595281352954780373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Ryabinin <a.ryabinin@samsung.com>

This patch enable kernel address sanitizer for arm.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

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
