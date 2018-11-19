Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1B52146D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sv45BNyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1B52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404775AbeKTDvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:51:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404728AbeKTDvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:51:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id u5-v6so27651364wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+5rV8i8oHAlZCp9BrjdSXzDHw5vrl+aIvlpSNxpC04=;
        b=sv45BNyFXG98rVEUXSuOI+lgHZgjUg5xwoOUc83v5acd0OsW6+U+9c6hkGjllywz+Z
         +mYa8Pp6dMD6Dj3z132SayAzcPiFUezDhHFiQ6b9GZ1+HbO+gPvk7eJdLli6M6Pm7aDp
         yvTkTWg4GyPVv5+cToj21xhgO7l/fld8I0Po+a35SVrHXei9pZ/00mwpxSiNVxot6cr4
         FbpSvNbS+Z8JySxL4rI2xopNeM8Kdax53vP1n8fNMR9QF+k5d/onDhRA6WKqOK7/U9+n
         FjPjGg+UKfsu7LexwgYtUDMbONwR2COyPbx03Ej7NiqCb4FbRj7Zs9j1nefbnhf2ePV2
         qQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+5rV8i8oHAlZCp9BrjdSXzDHw5vrl+aIvlpSNxpC04=;
        b=W50IgpWxdGp2a5Do/c+lxZ4fwLnpUADDPNnuoPUabOXsZ09APfwOGYxQ3KHTBfvuUi
         vhW0W/7G3X7oqGKMUQzluJKON7N68Kxm9w4pr1QgAd6qjtr89gVjHR4Ctwhn3FU1hW1H
         RUH9zAveNzdBpaoP9sIh7Ek2v6vTIvb1GopsRiF1+We1lUObuTLAYeAR3CwiGpzfm5Q7
         2mi0zm2RMdi2ek9dkDXz0qrDCt5wmHgXLVD3kPdZ3ddV+aG1cKnriBGRR8sQtoYxfmh1
         AaleMhmutWgH5PvXS0/ErxkUstrJCzTTUzkEQLa0QqRdybTtBrspJ8n0EhUq8zLqCxlP
         KaJQ==
X-Gm-Message-State: AA+aEWZ1xxuZkaPsnIYRdXraY25z6eyj2U6RzEwYao+0E2WGIzI/QadB
        p9e/8Ae5Vm+TGD81xuX+FkS3CA==
X-Google-Smtp-Source: AFSGD/UOnJKpBQZNcwhfKdJD/c2SfY50D4CePkI6Yh7W+ALQWMH0I5DjVzv2hGxFtShtidsjDNfgcg==
X-Received: by 2002:adf:891a:: with SMTP id s26mr944808wrs.44.1542648437776;
        Mon, 19 Nov 2018 09:27:17 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l143-v6sm23685190wmb.23.2018.11.19.09.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:27:16 -0800 (PST)
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
Subject: [PATCH v11 14/24] kasan, arm64: enable top byte ignore for the kernel
Date:   Mon, 19 Nov 2018 18:26:30 +0100
Message-Id: <7194a50384cb755e389ccecda66942e15b7b76ad.1542648335.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <cover.1542648335.git.andreyknvl@google.com>
References: <cover.1542648335.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag-based KASAN uses the Top Byte Ignore feature of arm64 CPUs to store a
pointer tag in the top byte of each pointer. This commit enables the
TCR_TBI1 bit, which enables Top Byte Ignore for the kernel, when tag-based
KASAN is used.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/mm/proc.S                   | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 1d7d8da2ef9b..d43b870c39b3 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -291,6 +291,7 @@
 #define TCR_A1			(UL(1) << 22)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
+#define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
 #define TCR_NFD1		(UL(1) << 54)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 2c75b0b903ae..d861f208eeb1 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -47,6 +47,12 @@
 /* PTWs cacheable, inner/outer WBWA */
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define TCR_KASAN_FLAGS TCR_TBI1
+#else
+#define TCR_KASAN_FLAGS 0
+#endif
+
 #define MAIR(attr, mt)	((attr) << ((mt) * 8))
 
 /*
@@ -445,7 +451,7 @@ ENTRY(__cpu_setup)
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
-			TCR_TBI0 | TCR_A1
+			TCR_TBI0 | TCR_A1 | TCR_KASAN_FLAGS
 	tcr_set_idmap_t0sz	x10, x9
 
 	/*
-- 
2.19.1.1215.g8438c0b245-goog

