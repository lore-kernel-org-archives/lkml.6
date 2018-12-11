Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334BEC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AA520811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AA520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeLKUGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:06:16 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:42815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeLKUGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:06:16 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MJEMt-1grUtW2az5-00Kk4w; Tue, 11 Dec 2018 21:05:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mmu_notifier: fix mmu_notifier_range_init warning
Date:   Tue, 11 Dec 2018 21:04:43 +0100
Message-Id: <20181211200526.3868586-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1MkcEApk+eXxquabhdLak8+/CEQwfqjWwL9KHXt8d14hBX7aRFV
 n20GdNsInfN2uBT80nbrsTwwpW2EGb1WGABGmcv+pfdLL/kh4+qtlJmaZDHf1/3G9Dk4kM6
 7R0QHqVJ36mV8wl1Y0oWXQYLXlGSByoglDxKDn0Fnd09MwYjSFAbm/YYBgUbnnzKmP+rfVx
 /qvAIHUwkbQJjFlnjNnhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nD4ZS/AeEqc=:HaU6cQ914RV1gbo3pr93+3
 GiP2vc4XFTHNQXp5Ld8hq9Ik++AtNzwaGb4p++wVGNDKQi1DC4VXCs5jzCJAA31McvQ5vnmDe
 hnNL6fXeZxOYtp8KaqU/v+xEmESaSNRVNfFzmGys1XHAvMl4WQx8gK+RTqrKAkykZsssmu15C
 QTIQeB/ZDvjUvkpSeJWR+YHuzwatlowwTJd1JMrQPZzAYO9dneP8OB2JULvNwPZyHAHZIt4nw
 zV9WkavQfkiW/Y/O7Py2v0llKpLd7kjSnQXAN/r5uovQ2CBUrCmb9sXzzCQDDp64A4YtgYGrW
 o2yMf7IrFwPpXMtJcA6cX6k03bTmF10EPI9y3/zr+tWG0w0QCQUKC/dH61woEIHuogny8iED7
 w7q29xfskQSeRT2LvNAzrS+eGbswe9+kgvj7kwrm9M2bx5jDs7wkLV6WjGdIcdWNyilTytDIE
 sinJebFU6+DuIr2E4sr711jYbWQL/Vl9THQRvygqk3ASaJjFKnEshW0rWEpMzfD1N/vmIievK
 2R6UdLVLd9y+Jdtj1vP+bndPXL1BeSJuNvuUuPcwNdYVyQQ8zESXe8IVOoxI+f+3Vr2JDTEsK
 41B518WB3RxCfFGebPgHE0rb/74FH00hymCVJxOJ68Lfk51z768hlRGPc2OXmIdRvwrQe5Yie
 KdYUOTc5Tfh/17UwFxND2qgA86kF5isOzNdvSxY12tLtstcP4DfvMDD1sshx8Q4QgcAXn3l7h
 SEdjNxY3uL3b60S1Nh0JuEXOin1NR0HamuDlrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro version of mmu_notifier_range_init() for CONFIG_MMU_NOTIFIER=n
does not evaluate all its arguments, leading to a warning in one case:

mm/migrate.c: In function 'migrate_vma_pages':
mm/migrate.c:2711:20: error: unused variable 'mm' [-Werror=unused-variable]
  struct mm_struct *mm = vma->vm_mm;

Pass down the 'mm' as into the inline function as well so gcc can
see why the variable exists.

Fixes: 137d92bd73b1 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/mmu_notifier.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 29f7b9670ba3..b13ea00ded5d 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -476,6 +476,7 @@ struct mmu_notifier_range {
 };
 
 static inline void _mmu_notifier_range_init(struct mmu_notifier_range *range,
+					    struct mm_struct *mm,
 					    unsigned long start,
 					    unsigned long end)
 {
@@ -484,7 +485,7 @@ static inline void _mmu_notifier_range_init(struct mmu_notifier_range *range,
 }
 
 #define mmu_notifier_range_init(range, mm, start, end, event) \
-	_mmu_notifier_range_init(range, start, end)
+	_mmu_notifier_range_init(range, mm, start, end)
 
 
 static inline int mm_has_notifiers(struct mm_struct *mm)
-- 
2.20.0

