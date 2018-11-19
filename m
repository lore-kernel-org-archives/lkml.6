Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41CCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F88D20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XRgFtW78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F88D20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404703AbeKTDvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:51:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33342 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404677AbeKTDve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id u9-v6so32944829wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwKg6/9dBzGs42zHBzot5G3OJIBxXRkYl3JEBLj4VCI=;
        b=XRgFtW78jY8uE+DLOcRj01/ohwGwYRVTHOZm6kkIX3wG78z6h1mGRsYa7WH0kSmPHo
         AgJRvOnjXH+ryNrZV51t7wuW1nLUfyd7dVxMwdnHcE1gRgWDB5jR5a/noGVOeHj4w0B/
         8yuVzlMIRzVf2cnjqzvYbrpnoyo7e5Z1CXPyIYr53fB2+Pb1yBVNk+oDQlS/I+ZOm6do
         prUWxiNXpr1bUnZo7OoJTcsYxMaIWv4nn4nKD3LFFs3CROs/kb+6dwYChGBQKiN105SH
         5TdFEGUtGrIXnGkfkToX+7nV2GhomixqpcmF0F6aS6F+opCc3zhUMsY2CplJVtJK3cYR
         otIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwKg6/9dBzGs42zHBzot5G3OJIBxXRkYl3JEBLj4VCI=;
        b=s6VgQrEcmYZnQVc5je33TlDpwRfhW+IxDTj4z7AUhtLg7m2/99CiixS/grUeSIb8v+
         yYzxe89rSuGmlEeTRdkVkml14CaZtlvnZWYhXkAThW/u3ARqfaNGbMDs8Nw8bVxzpNlA
         OvjjPDOaI/3GnYht8klbl7FfboLhE+ci1n1XE3bWLp/WWgtq58vkIiYFIms1Fm6RKrCi
         YRs0tHC3x77iRWpmQrCdmeSDiO4oCU5XYfL+7ILQeCfjYrkrU/ahS5e0sglguj/5zx9d
         qkEdSXplWbKiqvz/IAci8efn9PrpROxEI/bv/qtaX7eKrahwIzj7xokT19EmUWVhgjum
         7a+Q==
X-Gm-Message-State: AA+aEWZaIcf0EShNLgYlCqbyh5M1cfP9HeUiYzZIt/N76I0BuTkXy8PM
        V/MXTZIkT8iA5Gu7kDk9RDU71g==
X-Google-Smtp-Source: AFSGD/WHNP7mi0wPd7mMILK100bob8aXhZpnIiD+3cKXrZDRq6mGPKEPk5lZq9uwmj5IXWtJqjVhRQ==
X-Received: by 2002:adf:a357:: with SMTP id d23mr5758176wrb.195.1542648428411;
        Mon, 19 Nov 2018 09:27:08 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:27:07 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v11 09/24] arm64: move untagged_addr macro from uaccess.h to memory.h
Date:   Mon, 19 Nov 2018 18:26:25 +0100
Message-Id: <0288334225edc99d98d70c896494e19c3bd9361a.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the untagged_addr() macro from arch/arm64/include/asm/uaccess.h
to arch/arm64/include/asm/memory.h to be later reused by KASAN.

Also make the untagged_addr() macro accept all kinds of address types
(void *, unsigned long, etc.). This allows not to specify type casts in
each place where the macro is used. This is done by using __typeof__.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/memory.h  | 8 ++++++++
 arch/arm64/include/asm/uaccess.h | 7 -------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 05fbc7ffcd31..deb95be44392 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -73,6 +73,14 @@
 #define KERNEL_START      _text
 #define KERNEL_END        _end
 
+/*
+ * When dealing with data aborts, watchpoints, or instruction traps we may end
+ * up with a tagged userland pointer. Clear the tag to get a sane pointer to
+ * pass on to access_ok(), for instance.
+ */
+#define untagged_addr(addr)	\
+	(__typeof__(addr))sign_extend64((__u64)(addr), 55)
+
 /*
  * Generic and tag-based KASAN require 1/8th and 1/16th of the kernel virtual
  * address space for the shadow region respectively. They can bloat the stack
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 07c34087bd5e..281a1e47263d 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -96,13 +96,6 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 	return ret;
 }
 
-/*
- * When dealing with data aborts, watchpoints, or instruction traps we may end
- * up with a tagged userland pointer. Clear the tag to get a sane pointer to
- * pass on to access_ok(), for instance.
- */
-#define untagged_addr(addr)		sign_extend64(addr, 55)
-
 #define access_ok(type, addr, size)	__range_ok(addr, size)
 #define user_addr_max			get_fs
 
-- 
2.19.1.1215.g8438c0b245-goog

