Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BE721873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545150199;
	bh=tGcHBZdwasvjiervYRfbkKSGSX9FI5nFAJ8rSyf1OI4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=lx9nG1aOotZlFNdlTcZXVbuiCHK6Olgs4KRubVK5VutXgsLWwbL7Q8uKIRnZQVW4c
	 Nqolvih4KOg/tJ7r+iCXO08yKfeBFESGPRAEyKMgVqMTuAUECwFZ1kzqLjEUbeljOX
	 KGcGSnNFC1W/1X52C6DYXtH5r+V9vyBYXLPoFDNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeLRQXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:23:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40019 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeLRQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:23:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so8335920edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 08:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0g1/EcXrWfzlu6dFXFwPJ34Xnq9GCNFuM6Gf8l29vM8=;
        b=ecebYUIt2sCAMqs4qrRVQi7ZUZM94PBexWnaLuadSjSdSDjf2PToEtouJNBD/FlQCX
         RM166TJP34pqrB5vR5JD543T4PpBbM3zYVK5f6HiJ1ETiuUHRGwgnhHgCzA0sWmqsSr1
         OKgVNgsAA3J1XionkZoXhBTSsr0QUCi6uzVzk+72MZkyBqQbRORdHpXSdH6An1tq4N3e
         viL6KjvByXVkIcPyclcVDB5kZyh+5/DH93prDIwabXBN4W+nX3O0o+Sw/GW1WYFM7BHa
         KrYbAfvJznw/zPvOHnydMyl5mal59bJTL+PxvOY5BBQALU+B68IvdibGB4NIsXh605o+
         o9cw==
X-Gm-Message-State: AA+aEWa8souZBVKOSRas1U/XEVJDo3e3ftDUmH4RFAP1cytDJcYoMuoa
        tS5Smdo6ROh4f8Kq8U8lMK8=
X-Google-Smtp-Source: AFSGD/WAq5W/NHTYo0B6lpL85g4a8J17Ly8mkDX9Xth6mbUyWUuuJVuOErAEWChrEC/mwsWwvdFu7Q==
X-Received: by 2002:a17:906:a301:: with SMTP id j1-v6mr13505963ejz.188.1545150196012;
        Tue, 18 Dec 2018 08:23:16 -0800 (PST)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q16sm4538203eds.60.2018.12.18.08.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 08:23:15 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] memory_hotplug: add missing newlines to debugging output
Date:   Tue, 18 Dec 2018 17:23:07 +0100
Message-Id: <20181218162307.10518-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

pages_correctly_probed is missing new lines which means that the line is
not printed rightaway but it rather waits for additional printks.

Add \n to all three messages in pages_correctly_probed.

Fixes: b77eab7079d9 ("mm/memory_hotplug: optimize probe routine")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 drivers/base/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 0e5985682642..b5ff45ab7967 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -207,15 +207,15 @@ static bool pages_correctly_probed(unsigned long start_pfn)
 			return false;
 
 		if (!present_section_nr(section_nr)) {
-			pr_warn("section %ld pfn[%lx, %lx) not present",
+			pr_warn("section %ld pfn[%lx, %lx) not present\n",
 				section_nr, pfn, pfn + PAGES_PER_SECTION);
 			return false;
 		} else if (!valid_section_nr(section_nr)) {
-			pr_warn("section %ld pfn[%lx, %lx) no valid memmap",
+			pr_warn("section %ld pfn[%lx, %lx) no valid memmap\n",
 				section_nr, pfn, pfn + PAGES_PER_SECTION);
 			return false;
 		} else if (online_section_nr(section_nr)) {
-			pr_warn("section %ld pfn[%lx, %lx) is already online",
+			pr_warn("section %ld pfn[%lx, %lx) is already online\n",
 				section_nr, pfn, pfn + PAGES_PER_SECTION);
 			return false;
 		}
-- 
2.19.2

