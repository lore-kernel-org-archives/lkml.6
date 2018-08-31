Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33253C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAF72077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="bNXuW2X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAF72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeHaRmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:42:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33012 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeHaRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:42:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id d8-v6so1009647edv.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsfEnpTiYn1PWDa4g6Or6NeGiBShHwNa3Cf8U7f4g0s=;
        b=bNXuW2X1z9jjesBmMazyYCJAGETzVykPDZRUYuEQay0MQ2Y6IRbkDj3Wkabae2+FXL
         IlmeF5P7YAVW02v4O264gPL4ZAsD3nKl6ie2Sxk3Dwhs1njJ9/BL2wlN4MnYqYOVNXnu
         2XSOPXA04zRgqZGXBPzpaH3SPGIxoIOaTEUTlQWoxuym3kpq20R5R3yxOxmT5fMyiBio
         zzrotqwpegvw/qJtFGK4YggmYm3KMXVJkMxB5/d+laYdfbk4HwJ2UOB/1zy4GxJxjYGy
         kibnGn7kOV6sA+84p6acayEAwcNU6Vu2a0yOsev5QWuI36+2ZVfiV7tYwbyhGQBvlMUC
         tmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsfEnpTiYn1PWDa4g6Or6NeGiBShHwNa3Cf8U7f4g0s=;
        b=KqAvuRTus6P17xUJ16sf0iVV65uB87InY3FVC1FjRBEBBAebdviipzVd5Z0QVqipBC
         B/Xd1VSLzmlF68b6wqYuwgzOLVlzW9tBPhdwVOC2q2Ea2FTCDMkAQyswYkBJk+aM+JWe
         R6iKF9J2VKekmMEV1pzbbFylyc0dzML8v/t6c2+fGhPHLlp1w4f09+b6rFZhbbXu+lSn
         AR1o/OTbw74zhc+zM9Jo9aGHLfFoRnFSA9HGCaSlVQq85KEJn3tXG4227yX1TuYNk5Z3
         6wSg0A9K+/7B7zq47pqSH+MtgRi/GynZimpzv+nyX8W2s17qhWekRQ9QVqSd3xlfKCjD
         zUgA==
X-Gm-Message-State: APzg51DkWbldkF8FAMHusgbTjUXbwNbdubqMgq/5i4ATXvg+DvyH/6Xb
        NRByg+VD5nUFh//vmc4goS4eIA==
X-Google-Smtp-Source: ANB0VdYB2/Q9yFpcyMwkIi67JbQKawoWEUjitK+nMyQtNS58Qlh4Y7y7B/B5YFKVaBNu7L/7iz2dpQ==
X-Received: by 2002:a50:fc03:: with SMTP id i3-v6mr18357777edr.85.1535722486649;
        Fri, 31 Aug 2018 06:34:46 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id i19-v6sm1937851edg.64.2018.08.31.06.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 06:34:46 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/4] lightnvm: use right address format on 1.2 path
Date:   Fri, 31 Aug 2018 15:34:34 +0200
Message-Id: <1535722477-31288-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
References: <1535722477-31288-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct ppa_addr defines different address formats. When we are in the
1.2 path, use 1.2 addressing, even when the generic format works too.
This improves readability.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index f7154398ba38..e9f14c67f4f3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -998,8 +998,8 @@ static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
 				goto done;
 
 			ppa_gen.ppa = 0;
-			ppa_gen.a.ch = ch;
-			ppa_gen.a.lun = lun;
+			ppa_gen.g.ch = ch;
+			ppa_gen.g.lun = lun;
 			ppa_dev = generic_to_dev_addr(dev, ppa_gen);
 
 			ret = dev->ops->get_bb_tbl(dev, ppa_dev, blks);
-- 
2.7.4

