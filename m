Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB15C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EB123F4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNFYHImM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EB123F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeGFIPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:15:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41139 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753688AbeGFIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:15:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so2531138ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KPtnS3pR0e6k1wruvZ/TmyKB2yqnQlAi9FUL26a/INc=;
        b=kNFYHImMC/45MdigANa2QLU2iw0muDk6UGej7TqyveuZfNRAXHnQFN2McdRcAPu/oB
         Z2ySewh42xNfvOo7i1Q5jJwC+WwimW1Ikdot9PFzkpODnynjtVax9K04wiubC/vOi2Cj
         FRDWw3lpTTR/8i4Jof3PGyebe1EBjjYY7t7I0YZpw+5u9pMAcaMFdLG4fRVLbti/6j+w
         lMddoaJNGKTyVW79OeMOpj5dq/xJs+AQHV+Ez1RTxHMgpQAG9/fQNPZpxuU9R4k5KqnC
         2/tvVwwqzaHYNqWVI0GwgLMkyC9b9AHmP5S5i6BLIA7KoRScLuHC+heeIKqYoZq8p8Au
         /1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KPtnS3pR0e6k1wruvZ/TmyKB2yqnQlAi9FUL26a/INc=;
        b=kAFyQgnkRA0MD/8XZbYX1TdjB7wb1VwtV6biYp7jfCObniSOGYP+xP0l18KHYdU0J0
         8qexvPn0aJ1p+tJNZsuROz7o64JIlbTgI4+QadKjIKGu7ctZscsun+fhOa42BindGX9F
         V3CEAFuRFSfmuhwl6wWPmdnzbS0WUUVG8t6YR6IUxr30LG00PTAWtaJxK08VNNFIIjjE
         lTeCiKObAuUGjMmfr7/22bjdF7sIgl6NIXgIhIvaYs+yaiGM/tv/iYS18b0CKawcHtJo
         X0GWpYmB+kIlS2Z3M0kglBDSvYVjevelJj9wqoU+0Q1GJfDkP9W0RMP1anH5R+jRjj1v
         D3zg==
X-Gm-Message-State: APt69E3N0LyA/nELTSwMw7KYKyG7WOy1wsZPoOXs27lr1NgAG3hZ9t6W
        k3C3NIEoJTJ4Nz3dX4rcaF4=
X-Google-Smtp-Source: AAOMgpfhNmsZVN3wrbPmFvFavr4jbMT4C5yNyFZDfpBak9N5yBiuRp14Wf8+5LcPDm2OB/SwdqFN1g==
X-Received: by 2002:a17:902:8d96:: with SMTP id v22-v6mr9248199plo.176.1530864900341;
        Fri, 06 Jul 2018 01:15:00 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id c141-v6sm4673049pfc.25.2018.07.06.01.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 01:14:59 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>, richard.weiyang@gmail.com,
        Jia He <hejianet@gmail.com>, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v10 1/6] arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
Date:   Fri,  6 Jul 2018 16:14:15 +0800
Message-Id: <1530864860-7671-2-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
References: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_HAVE_MEMBLOCK_PFN_VALID a new config option so it can move
memblock_next_valid_pfn to generic code file. All the latter optimizations
are based on this config.

The memblock initialization time on arm/arm64 can benefit from this.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/Kconfig   | 4 ++++
 arch/arm64/Kconfig | 4 ++++
 mm/Kconfig         | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 843edfd..7ea2636 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1642,6 +1642,10 @@ config ARCH_SELECT_MEMORY_MODEL
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
+config HAVE_MEMBLOCK_PFN_VALID
+	def_bool y
+	depends on HAVE_ARCH_PFN_VALID
+
 config HAVE_GENERIC_GUP
 	def_bool y
 	depends on ARM_LPAE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..26d75f4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -778,6 +778,10 @@ config ARCH_SELECT_MEMORY_MODEL
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
+config HAVE_MEMBLOCK_PFN_VALID
+	def_bool y
+	depends on HAVE_ARCH_PFN_VALID
+
 config HW_PERF_EVENTS
 	def_bool y
 	depends on ARM_PMU
diff --git a/mm/Kconfig b/mm/Kconfig
index 94af022..28fcf54 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
 
+config HAVE_MEMBLOCK_PFN_VALID
+	bool
+
 config HAVE_GENERIC_GUP
 	bool
 
-- 
1.8.3.1

