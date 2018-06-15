Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 331A0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD39020896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="MgGLz8fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD39020896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965787AbeFOLQQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:16:16 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:43302 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965650AbeFOLQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:16:15 -0400
Received: by mail-wr0-f182.google.com with SMTP id d2-v6so9528586wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 04:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gvjogtcL8m8ru3mMPC4lYRL+vSKtnDFDHwIo2EHHDtc=;
        b=MgGLz8fuNHNIeY18a/4rTqRM7Fe2jB268IYuRLoAN0pA5/p/EHejji4gRj2+ULdYdB
         o2NdUNOHINKFmrdtV9p4V8ZI1JCtMAHdywOMnt4NHkULEc6kWV6b/6Ko2RqQa0EV6YoG
         4ExgdKuEK9KRvOUwytkZhE15T+5G7ugIthUnPaRYIToc3hdRLB/sMF/A5HGR9iUqD2by
         LFpU5UK3y1lLI+lXY3sf3gd43W7Qi0Ft4+ONjefrJvwfz7EV4+aQifAcWodECRU8wwnO
         PtSFZ+qF6KXF/01682FZybnlZDTOZ7kVfO39dbnp2Pg0QyBYIdWdXMvUUTrqgr5Ug3Cu
         4PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gvjogtcL8m8ru3mMPC4lYRL+vSKtnDFDHwIo2EHHDtc=;
        b=DxkE7Mj0nO1zFDgTOMfTLpfyFEajQ1vQgmJl9nWBm2eH7rpHkLLmfBBBZKZrfbsDWD
         LWlXvLAtvn0RWmjtOzeVg8VXPUlzJFEG2FprSCHMNkqUyIbqecZsjHtqj1KUToUg/DZ4
         SF7onozzjzhLgBa0uvw2DLdZoDB4iOxo35GVoP5USQnuPsg52okTXGK15mjR5HNotIi3
         FOaOLQSa61+gy0IkybBqYj5VWx6X6ofWEZ4uKnnaY/qhanCgJrxTQ+G2sCsl6W6tDl6H
         dhfNz72lPx8IYpkRFtCH29xc/gek5MjBQdc2sxDLQ9A7bstnQ8Nm1S1zvp75bdoSe+j3
         r5bA==
X-Gm-Message-State: APt69E34L1qPAgeHTbpEJj7xSOtwk5Oj2V4t4CokaxHcwGj1IjVFXX6E
        0fUWdThyHJas4rGhQmktZCVresYiqMI=
X-Google-Smtp-Source: ADUXVKIngtMupgN/9pcHODGaDW+rPTpCuzhVrYmU0z6mBnEyKHclvqXtfJ75nyH8GjjLcJC+kmyvpg==
X-Received: by 2002:adf:9dc9:: with SMTP id q9-v6mr1337014wre.12.1529061373739;
        Fri, 15 Jun 2018 04:16:13 -0700 (PDT)
Received: from ws00837.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id r11-v6sm7632984wrn.34.2018.06.15.04.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 04:16:13 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@profitbricks.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Gioh Kim <gi-oh.kim@profitbricks.com>
Subject: [RFC] replace comments for bvl_vec with bio_vec
Date:   Fri, 15 Jun 2018 13:15:54 +0200
Message-Id: <20180615111554.14005-1-gi-oh.kim@profitbricks.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think bvl_vec means bio_vec_list that was replaced with bio_vec
long time ago. If I am correct, I think some comments for blk_vec
need to be replaced with bio_vec.

Signed-off-by: Gioh Kim <gi-oh.kim@profitbricks.com>
---
 include/linux/blk_types.h | 2 +-
 include/linux/bvec.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3c4f390aea4b..a39dc0a665b9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -196,7 +196,7 @@ struct bio {
 	 * Everything starting with bi_max_vecs will be preserved by bio_reset()
 	 */
 
-	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
+	unsigned short		bi_max_vecs;	/* max bio_vecs we can hold */
 
 	atomic_t		__bi_cnt;	/* pin count */
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index fe7a22dd133b..6023dc9e6f79 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -38,7 +38,7 @@ struct bvec_iter {
 						   sectors */
 	unsigned int		bi_size;	/* residual I/O count */
 
-	unsigned int		bi_idx;		/* current index into bvl_vec */
+	unsigned int		bi_idx;		/* current index into bio_vec */
 
 	unsigned int            bi_done;	/* number of bytes completed */
 
-- 
2.14.1

