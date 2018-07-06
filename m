Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F609C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0350223F4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIw54DWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0350223F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754227AbeGFIQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:16:08 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39134 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeGFIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:16:05 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so7798630pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KBVWoCjiNTgx3OnopaUozpRLlK9tc1muAL6uwtd7eM8=;
        b=IIw54DWkDXYRccHSMjpmgHB0umWJr2Ggmu4f8zAw+imiWejPJy71zXZiSUN6XPO2CT
         JGGhx1eu+CGElJchLD3ofpR1UalMrIZpmLSNKdt0MzznsROCSmgepAlomEnz9VWLZ4q7
         /TFmyiSU/HR/VyDz9XST+r+F/ErC1lLfPU7Ax05lYu2i3c1tO/MCYub6bbc10Dpk7GrC
         lLx6LdyVk3CYI+vuJVFdQ/8S4UYjZ2lFnRnrhzKNcnSnujN1chHCru4n6Nr9+tO5+eJr
         WCl9vnBSE6R74mjAkLelx6lz6x4ma+awSHbEQVHsLT4/TwNRLSgojUc8wP5CM4xbkzLq
         7xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KBVWoCjiNTgx3OnopaUozpRLlK9tc1muAL6uwtd7eM8=;
        b=Kd/1Fg1zHX0QfwfW/2hzBy3Wy+M6dcIdaw2lTBwvfWLuxGJOwwjlMvLRitXPALX2oR
         LMt545yvCoMj0YHnuk/WCKmpAFjKrDGhSYI19O1ONCToJSXMeyYCGmj37u5844byyS0W
         0sY94jPNjpH48QuouQQBJJxABw5bfgLrHCAMOUZygpIkQH+FqoXOLlQsix7mC0AqX5Sz
         N0Yd5lqWKyaOilKgC9HQQgrFY/szPB9uyvnjnzA8zKtbOqKgSj2X390evMmwUoMpCuLx
         hquTXZRRzwmDlBMTx6X2HTXhImhMcRJpa7Drg4ZOi/mgQn7IxKQsU/ZcSoK1c24+NK0S
         5EPQ==
X-Gm-Message-State: APt69E08OGmLY25rJu8O3O3Oq/CyDxwUrFSWXUhlUh31ye8vpf7CBzHa
        ync9ey+xEfgMC8P7zwzXkF4=
X-Google-Smtp-Source: AAOMgpdjOsuiY+SR9NWHwZGVIRnLuo6Gg5sF8CUM3ZvEuBK1umTwI1CKDM54XhCmVp/Enw1dYHuH2Q==
X-Received: by 2002:a63:5d58:: with SMTP id o24-v6mr6961593pgm.349.1530864965186;
        Fri, 06 Jul 2018 01:16:05 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id c141-v6sm4673049pfc.25.2018.07.06.01.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 01:16:04 -0700 (PDT)
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
Subject: [PATCH v10 6/6] mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()
Date:   Fri,  6 Jul 2018 16:14:20 +0800
Message-Id: <1530864860-7671-7-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
References: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), if pfn and
pfn+1 are in the same memblock region, we can record the last returned
memblock region index and check whether pfn++ is still in the same
region.

Currently it only improve the performance on arm/arm64 and will have no
impact on other arches.

For the performance improvement, after this set, I can see the time
overhead of memmap_init() is reduced from 27956us to 13537us in my
armv8a server(QDF2400 with 96G memory, pagesize 64k).

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/mmzone.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 57cdc42..83b1d11 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1267,11 +1267,16 @@ static inline int pfn_present(unsigned long pfn)
 #define pfn_to_nid(pfn)		(0)
 #endif
 
-#define early_pfn_valid(pfn)	pfn_valid(pfn)
 #ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
 extern ulong memblock_next_valid_pfn(ulong pfn);
 #define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
-#endif
+
+extern int pfn_valid_region(ulong pfn);
+#define early_pfn_valid(pfn)	pfn_valid_region(pfn)
+#else
+#define early_pfn_valid(pfn)	pfn_valid(pfn)
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
+
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
-- 
1.8.3.1

