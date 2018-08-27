Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D770C208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+JJjERU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D770C208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeH0WLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:55 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:37280 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:55 -0400
Received: by mail-qt0-f201.google.com with SMTP id b5-v6so15256287qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l5kHGX+UokVpJkr3J9HVJHAQtjVzj+xuyS4h6ET9iVA=;
        b=I+JJjERUVkXRbYvzkG2tS3/MMx6Ej02qOSzQ6G29pEmfcLPlSNyY2FpaZjmW/rXUXY
         Nr2FrrlAiFqiPBE07vzsC+JZySEooNOYD5zAfMZ2SkL1DnBoRT555ZBMmKF8YsOMXSFP
         vbMrgU9w7LR9nyKrPg6HuoDYBCF57NIg8BD1lBG5W8Y5XxllmF7X/GcI6SbASl1XeIVQ
         fQ1A0wlCqYKE7+SVTUtFEUPxRCirdplrCVcznqE/CQ1Ec1DrV9DIIL9ppG0chBP9kdDk
         RCBZqh/FFriMD/wwufCG8MAlBtgH1yq24TbmLFlSJgEdqBSRczkv/nG90JMCMQBREtNO
         E8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l5kHGX+UokVpJkr3J9HVJHAQtjVzj+xuyS4h6ET9iVA=;
        b=WEpm3hatU5X5EVJHBmjXP3NZWGhv+jA+yHs8yLh8GSnEhe1rK1bzokSJpjQICxVqA7
         DYBBHu4oD1xHgcGBjWzgUEC6Wxs4f2/5OUUOeyjKMglOJDl5qBfTg9MHPnxGC90jt3r9
         yI0y47o1umyEb4IzeOGxsdShHWzA+eyAZy0W0X0jieU93SddbHPzFHVWHdl/KA6y5eRa
         s8MV0ELNdAEKI4qwIR/T1yAbPSUFoJxsQvH5NqRpPpAD8GSPyzZ4kFllxu8v97Uy8O43
         MYHKWnoPUY8HlKfbNyy2DEFpChiVB47UQjQMHUGLJNfD3OoJqfMkUHlaewm9Nnbwe3GJ
         jOZg==
X-Gm-Message-State: APzg51A0gaaCsieoQZlc1PAbK7NzyjA2nHyCuO4PcnUcTscmPRxmenxZ
        D3p0VWQBFeUrOZXUSqFO32LVENCf
X-Google-Smtp-Source: ANB0VdYq0gxtQ0pTeVoNchxuDKAEoxnh/O7jjy0LwrdMkJlOeczdeZ1XBQvqm96JlayD+jkT7F5rWUMW
X-Received: by 2002:ac8:44d2:: with SMTP id b18-v6mr8712829qto.51.1535394253028;
 Mon, 27 Aug 2018 11:24:13 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:08 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-13-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 13/20] platform: goldfish: pipe: Remove a blank line before '}'
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

checkpatch: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index ff0e150d15d5..14441e7106ba 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -272,8 +272,8 @@ static int pin_user_pages(unsigned long first_page, unsigned long last_page,
 		return -EFAULT;
 	if (ret < requested_pages)
 		*iter_last_page_size = PAGE_SIZE;
-	return ret;
 
+	return ret;
 }
 
 static void release_user_pages(struct page **pages, int pages_count,
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

