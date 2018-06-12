Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48585C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E960C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvjThtgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E960C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933782AbeFLNmP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:42:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42530 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933203AbeFLNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:42:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id v135-v6so36086309lfa.9;
        Tue, 12 Jun 2018 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhkkTlp2qwFS5yPkjU3sYNdZxOZni/6Y3AJB2+5XVs0=;
        b=PvjThtgIUjk9nWYLTg6DKgh5LccNkiQjOCmVvRR8M3oDWdMcXLXMDynX3fpZRl1hmt
         9RezOdOH9OwUbjlQh5hxavaGVtmjkVvEiVgTIZP/5tTRuP83RtPv1ZsNUpgHHkihPAVd
         x8Nz2qlT3vKcpOI7z1wIPayUHMU93TTlXfsvDDJADPNRAYqWPUtGg36I1Hho32zkmIWe
         gO1lBiE8UP5lbc4Fk/HJVQWkLgX7ewRD+FqtO2BRi5pEk2Pp8S64s3tD4PiO/GKehw6+
         iiUntsaHbVi5Uwe0HowCxfzDfBVmTi9QJIResT+WPYxv67TfDpeQsNOY4n0nZ2QMWbF6
         dLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhkkTlp2qwFS5yPkjU3sYNdZxOZni/6Y3AJB2+5XVs0=;
        b=sIAztr4jiKjypBqEdfPJrkBx064m+eqN2KXsIWdl3lIJYkXELjzAS2xvUR4m3C/Q7v
         v3Y/ENANCk0HqONMbJmlTtUiFkYmog+XgqyEH1NQNoSFl/fGLJ3RgozmTv3PvLO8pH0A
         3C8DIHJweZNuWkgOE2ladcsSZRDO0uJrfHKPK8QwhJZ0kLsrQYbmn5T2vgMmrmTkP2R7
         VftYhImM1elBh0in5ira8pcofIxtd8qB1G5S79guEh737qlPOCR+wsiZ7aM7n5P3FZLQ
         A+4RcchrmDwS9XdyNShBAftOcghV+7eghGUWgObb7G/GnmbjfMfD8BLd/xGH4f+WW6z5
         FLWg==
X-Gm-Message-State: APt69E2RcGq+Jf2PckeKQ0iw/hyM17chqJiILiPHEO4ZpDEn9fRLD0mk
        p/7U4osl+2Yniuk/88aQX7I=
X-Google-Smtp-Source: ADUXVKJikByD83jLwbKThiGVc8tQQAgd8SjB1hNRA32v/uF6BFI1fwhY+uFfmW2CGAdP4RtCf9yUEA==
X-Received: by 2002:a2e:8590:: with SMTP id b16-v6mr277600lji.131.1528810930470;
        Tue, 12 Jun 2018 06:42:10 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id x18-v6sm46692ljh.63.2018.06.12.06.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 06:42:09 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v3 1/9] xen/grant-table: Export gnttab_{alloc|free}_pages as GPL
Date:   Tue, 12 Jun 2018 16:41:52 +0300
Message-Id: <20180612134200.17456-2-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612134200.17456-1-andr2000@gmail.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Only gnttab_{alloc|free}_pages are exported as EXPORT_SYMBOL
while all the rest are exported as EXPORT_SYMBOL_GPL, thus
effectively making it not possible for non-GPL driver modules
to use grant table module. Export gnttab_{alloc|free}_pages as
EXPORT_SYMBOL_GPL so all the exports are aligned.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/grant-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 27be107d6480..ba36ff3e4903 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -799,7 +799,7 @@ int gnttab_alloc_pages(int nr_pages, struct page **pages)
 
 	return 0;
 }
-EXPORT_SYMBOL(gnttab_alloc_pages);
+EXPORT_SYMBOL_GPL(gnttab_alloc_pages);
 
 /**
  * gnttab_free_pages - free pages allocated by gnttab_alloc_pages()
@@ -820,7 +820,7 @@ void gnttab_free_pages(int nr_pages, struct page **pages)
 	}
 	free_xenballooned_pages(nr_pages, pages);
 }
-EXPORT_SYMBOL(gnttab_free_pages);
+EXPORT_SYMBOL_GPL(gnttab_free_pages);
 
 /* Handling of paged out grant targets (GNTST_eagain) */
 #define MAX_DELAY 256
-- 
2.17.1

