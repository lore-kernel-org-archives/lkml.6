Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD2C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B82081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93B82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeKCAjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:39:51 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKCAju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:39:50 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N7zNt-1fX5B740nr-0153HK; Fri, 02 Nov 2018 16:31:43 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N7zNt-1fX5B740nr-0153HK; Fri, 02 Nov 2018 16:31:43 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Wang Long <wanglong19@meituan.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix uninitialized variable warnings
Date:   Fri,  2 Nov 2018 16:31:06 +0100
Message-Id: <20181102153138.1399758-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:EqZJZNB6u/gzxKkNz+cGMuBdNt50fQBppwS5v7b4clXrKDDXYSH
 gGk2I9xZzl0X+UmvFC2Qk72DaA//3On/mBJP9NB/dledExJyDGOpGCI2lN70ce+d1vwiZOk
 z+TVo4rEde+DHeVeIerYI4ADSRGf+jEw/y2isjgtBZhAye5qQFUA9ZqSF3V3+Q8r9drEiXH
 J8lMVOJbJLh2q+HHT9fJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gW3o6OSuNvM=:mgCbZ/k2+A3hO7hD4oXf5A
 WGw1bP/yBKdd7FPaE+4wqiNlgHXv9pZbJRPv9UOqeLSEfflQqiYVYgwzyJM2OSR30DbfarxdM
 eusUTP0jFfFedWj1XpuGQJCN4w9YbB0Y6JnDeXrCgsQJihdwn0qEVuT0DKQ059/oskhq22zIG
 lMkpkoepHNyf9BmscQZE8quY0b7zSrfykoUOn5OuyQKH/Fe73/dUg7wpobok8ERjj1tFfbMjX
 rfa84TqO1Od7hwFXWXpBKq5/suMQ0vtEgElwmivH2z9OJ5MeJ8tZ1v/La7PygegzYzHsZ8Acn
 6PgyR9hgqFNffCGikQ2Ua7vlMfISI0FHYsHaNmIavvflLMvXaULFgu0U5xxjGmaz75nAaYyCM
 tIyrhgB/yeHAePWUy8yRCxEmv8Sy8+0mZNtwgLSJewrPb7dSZHvm2v44SCits71kVkSAGMllv
 4VNg1oTKx82PdiuF0kg4KoLdUbf/4vCGJlqgvlxEQlatZt4VeccFJY4LE0M0VxQRUGY8PXUxQ
 jiQBMMuyQaGPeBCi+UlI5U3uk7MDfq1Xq0S5aqol8dfjRqS0AdqSDwArsKsJYk3Aq1oaz5IQS
 HjOQJ4DB2B8Wd9faA8Fp+rVudiwkWJUserZpNjWM2Th4SaOzqrWuv4mLiPbJ78iqXAkTQ3JS3
 /ZOJZnlTzzDz6ieEAA82FOE8iAEfCDtUWiigMsT4xIdRX9Ih1DihiAL2hicF6aMMkmhy3giLc
 EDOEpeOfYEn8GGulaSn6A5k7tPGmo3MfDYzZs90m06GU63iZYXrT/Dm04dD0c53/CbJO54e1g
 qoeI0Mq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a rare randconfig build, I got a warning about possibly uninitialized
variables:

mm/page-writeback.c: In function 'balance_dirty_pages':
mm/page-writeback.c:1623:16: error: 'writeback' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    mdtc->dirty += writeback;
                ^~
mm/page-writeback.c:1624:4: error: 'filepages' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    mdtc_calc_avail(mdtc, filepages, headroom);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/page-writeback.c:1624:4: error: 'headroom' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The compiler evidently fails to notice that the usage is in dead code
after 'mdtc' is set to NULL when CONFIG_CGROUP_WRITEBACK is disabled.
Adding an IS_ENABLED() check makes this clear to the compiler.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3f690bae6b78..f02535b7731a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1611,7 +1611,7 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 			bg_thresh = gdtc->bg_thresh;
 		}
 
-		if (mdtc) {
+		if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) && mdtc) {
 			unsigned long filepages, headroom, writeback;
 
 			/*
@@ -1944,7 +1944,7 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 	    wb_calc_thresh(gdtc->wb, gdtc->bg_thresh))
 		return true;
 
-	if (mdtc) {
+	if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) && mdtc) {
 		unsigned long filepages, headroom, writeback;
 
 		mem_cgroup_wb_stats(wb, &filepages, &headroom, &mdtc->dirty,
-- 
2.18.0

