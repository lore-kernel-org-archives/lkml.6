Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5BBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6947C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="jYq9jMCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6947C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeGRXjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:39:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34076 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730226AbeGRXj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:39:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so2671863pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3zK1N/1xTLC08ekFsVD34euJSqM/sHfKuTlLNtQ5ic0=;
        b=jYq9jMCI99K9s8rIV9bv9dmiWcxRNIVv37el/7baBAnuBmCBh98g86uW4AIhluKPyM
         lm9tiCvxG0sd15pW4MTgpIVndjGdSUbA3LGKiSr/VOUASiPJaL3onF1Pnd9ad6DXwGou
         5FOd3mf386igpAavtgeVjWzUQRrdyjRWev2qgWT5omaq7il/4mLYD7tMZQqSMX5nmP6n
         xftRyDmce2snItwAU1BClBeD/v93P3iPcHOLGnjBzfsc8XU7uV8QIwK7EwTW0Q8IiKNW
         2TUVlvLIbtwjKnn77m4A2BNl2+Dw3OnijvudmwP6PKlFefZISaPWm55mRErvmS9SAHPS
         oB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3zK1N/1xTLC08ekFsVD34euJSqM/sHfKuTlLNtQ5ic0=;
        b=shNwW5a5Io6KQ++N45ZF7QVdFcAJlKPt6jWkkk+YMoSHPqqHxwU6L8bt+8QvpK8klF
         uccOH2o6TGvGRMozWTEZNBIfZ1pa05cUptnY2PCmbM3I4HluKjadJ/8w0gCCphhiODQz
         SM3A9FwykSCTp8+6gqnrU7xI2wKv7uwNi26zGzgpjfpR3cMjRVuDW7purscif/iU4uz4
         bdp7By+XInlG5iqWwqbLCD/wRNrI9KYK0oGIMzhObE/tjMtF6t8BFVPpD+7NEuT01Fxd
         C2JChttGRztSLWOJ6qJCCQH26m3WDB1dzaCYxcqqjzGIcq2nuPdNJnjuqhLGuTjP36X9
         HRhQ==
X-Gm-Message-State: AOUpUlEyamJRLSLesisPiHh4fNJFeeuO20980IO+C3A9pgQKYEeJgxlW
        RINF0TA1PWEo7+Rah7gqgv0cZUj9WyY=
X-Google-Smtp-Source: AAOMgpe24mo4it/+QYqoyfnJHoiRI6kpUa58/Vu15J9CUhdVvlKMEqpbQWjJbaycGBRQ/Ct7TwazZw==
X-Received: by 2002:a63:d518:: with SMTP id c24-v6mr7582625pgg.357.1531954760736;
        Wed, 18 Jul 2018 15:59:20 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s16-v6sm6377946pfm.114.2018.07.18.15.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:59:20 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3 7/8] proc/kcore: optimize multiple page reads
Date:   Wed, 18 Jul 2018 15:58:47 -0700
Message-Id: <fd346c11090cf93d867e01b8d73a6567c5ac6361.1531953780.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531953780.git.osandov@fb.com>
References: <cover.1531953780.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The current code does a full search of the segment list every time for
every page. This is wasteful, since it's almost certain that the next
page will be in the same segment. Instead, check if the previous segment
covers the current page before doing the list search.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e2ca58d49938..25fefdd05ee5 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -428,10 +428,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 
+	m = NULL;
 	while (buflen) {
-		list_for_each_entry(m, &kclist_head, list) {
-			if (start >= m->addr && start < (m->addr+m->size))
-				break;
+		/*
+		 * If this is the first iteration or the address is not within
+		 * the previous entry, search for a matching entry.
+		 */
+		if (!m || start < m->addr || start >= m->addr + m->size) {
+			list_for_each_entry(m, &kclist_head, list) {
+				if (start >= m->addr &&
+				    start < m->addr + m->size)
+					break;
+			}
 		}
 
 		if (&m->list == &kclist_head) {
-- 
2.18.0

