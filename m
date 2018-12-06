Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3561C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2DB20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="neyaAKT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2DB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbeLFMZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:25:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37683 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbeLFMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:25:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so307516wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3irOTZqglCe0+q+NuOFKdHcgcEut4vEB08n2fct2jM=;
        b=neyaAKT0SnRF3m9Va46jiGHE6yqDTX+/qkDaGCzTfyovNE7fgEiBpHCH6E8H6pp+Dg
         0V0P6R3gZXIzt6Npzf0dbDRYL8Segztlu9nPAwlHmkpVL6i1WQnVRLnveSf0VX7FUXUK
         0cTIsQkBwIH3ZkWUotsAs+TKxDFa5Y9Z2Quc3dcP2YuxWCU42kiKEIGfhwIkNFXUNKSD
         hCfLOG5PdM3jVSyheXBqSSO9uucECOKJeKjxpGpB7xEix22PdxX5UErNMDlIZlw4oPq9
         St5iuKFy2FfMyKSj8DLg2jVhjVWKfuYjzEnkhBGUnYmnyILzY+gq98tl22Emi+J1SvnQ
         mfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3irOTZqglCe0+q+NuOFKdHcgcEut4vEB08n2fct2jM=;
        b=PuQZjwkdsrGnNbQtzCDEagmQA9qf+XvYL8zgfJADHmI6BgepdIVVU6b4PgeIPh67Co
         FaP9OAEtF00SKeSN7MrGeSjv8U1CbLqUYztTtsmITpUWqMBqdEfo1IXTiAkLeoBQetzg
         1qnBQUVkqBj736jw8X/nXM9KLdBxRe28UOJVCrbC2TpC5NndnbBsmW263/1T4FpJcdtD
         XKBwL+trKByNg4vq1h+X3hgqBq/eZThGHRDEjDzOinoX4GND4zkno2r5RxAjREo8F5tU
         zCDuQvw51t7llraLZ7ZRcXtO3P5jXVoWRkQEMNfJyuQZpqP9Cp1okUKr4HnA1Hmnwux8
         xrNg==
X-Gm-Message-State: AA+aEWZfZj+Or68pBgz0qThI1lAmq0T54dS6gLZxLxhdAo+mEqqkhJ8R
        W1sI8o86qwVueeZe+sPOOX5Xpg==
X-Google-Smtp-Source: AFSGD/XkE8mejCoGUEy628et/JZL/sxDM+RBbFhKJ78kRjJ2xXA7tnfyWjFXQnlU4GWTOKOYRyZgpA==
X-Received: by 2002:adf:f091:: with SMTP id n17mr9679121wro.292.1544099125848;
        Thu, 06 Dec 2018 04:25:25 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id j8sm339988wrt.40.2018.12.06.04.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 04:25:25 -0800 (PST)
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
Subject: [PATCH v13 23/25] kasan, arm64: select HAVE_ARCH_KASAN_SW_TAGS
Date:   Thu,  6 Dec 2018 13:24:41 +0100
Message-Id: <25abce9a21d0c1df2d9d72488aced418c3465d7b.1544099024.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <cover.1544099024.git.andreyknvl@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that all the necessary infrastructure code has been introduced,
select HAVE_ARCH_KASAN_SW_TAGS for arm64 to enable software tag-based
KASAN mode.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..66f2c625fd1c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -111,6 +111,7 @@ config ARM64
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
+	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
-- 
2.20.0.rc1.387.gf8505762e3-goog

