Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 29C14C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D027C208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/0suI9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D027C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936150AbeFOGa1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:30:27 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39287 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755739AbeFOG2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:28:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so6586416lfd.6;
        Thu, 14 Jun 2018 23:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dhkkTlp2qwFS5yPkjU3sYNdZxOZni/6Y3AJB2+5XVs0=;
        b=k/0suI9RP9jsNbyZ6jWp3ZUOxmpyvwTD2aSerj/WzRJEKhI1+tJB8VrRpdIgIAI9Tt
         AIkZZI+w6NgY0FDGNvnpsjZSFaQRGcbPPIEmsA5ZABmGfTSuxdrQjNM33RMoD0qNXDSz
         gcgJ9dvRfFSZ7VJQBJhYvexm3HQEQwc9KxhKAI9LfBa8rO/CTh6AhHFZxK36eWdzH/tF
         sas2ySdW8fMWEqZZPVDiLfLoal9RmB5OWpxmlK9NaVz5H/VjvPKgXaDyPF3eZ2YomyO5
         wWGfIXd1MfAMOeDYWM3tW8/XpZ+07KAQQhD57/6oVp/Q7+zz+u5qAPAiERXUcz61DLNS
         7vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dhkkTlp2qwFS5yPkjU3sYNdZxOZni/6Y3AJB2+5XVs0=;
        b=PdVVyMwUZ0cKwVV8zcQxrHnme1WJIcLYHbrRdr2xcEij14ZPdOouDEjQ00bzmHNHE5
         9C+IentMRiLnJFZ8XEF8j7biJv2fwtYlL9sA0LPPHSEf8xVrTTS4DtNmViyxuD7geynX
         3dSJ9Sa1OW625kU/pgjF3UVTDkkYEgLyYCq0GzUzRZe0j05HkqCI28I77E2E9dUtb2y/
         vzEI1ypT0jrum63t1gazfJn3Q/OOlVp+selIVK18U2BrpdKBcpe/glZVbMSFIjb1T8tW
         Sg/3J1NAX+vtDQJOKT0eDRxbazNxIR2BDXGLF5OALtd1Pfl127+tA2f15p5PnPNCqlIf
         +6uw==
X-Gm-Message-State: APt69E3WNvw9TEb3kMYPYpQ4Hsi0bMgKu+OUDkdBY6VmhTEk+Nby43J7
        CH8qp0Ia8ZZZztd+CA6+vKg=
X-Google-Smtp-Source: ADUXVKJd4QD+DG+/iYJ9b0IWXM945hlplWqGNw7ZL4AjH/Yfc5zHr1DyKOUjoc2dxPpll4+TPg5U6w==
X-Received: by 2002:a2e:9dd0:: with SMTP id x16-v6mr310196ljj.142.1529044083314;
        Thu, 14 Jun 2018 23:28:03 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id t126-v6sm1355040lff.7.2018.06.14.23.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 23:28:02 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v4 1/9] xen/grant-table: Export gnttab_{alloc|free}_pages as GPL
Date:   Fri, 15 Jun 2018 09:27:45 +0300
Message-Id: <20180615062753.9229-2-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615062753.9229-1-andr2000@gmail.com>
References: <20180615062753.9229-1-andr2000@gmail.com>
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

