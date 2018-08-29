Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A21EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348AE2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="m/gHofHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348AE2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeH2M54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:57:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45384 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeH2M5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so3345415eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ffn4jK+AP1mfvxC0eYWzStCC8ro2vYixtu8eyEmpaVU=;
        b=m/gHofHSae8Zfwpl25mOumdRm8yVJYAglafYFT3eZf9Ss5UaFjtayrskq13YDpaPvn
         eN6X4jWmYZQpW3vaUU0YXZO0iYBGnNZfEe4s3YLx3EmuYFZKOHvI+kHWHu9H9NsbMihY
         Qh6aeU125oeXeM6kIpXovGdTjaxBG10v16GgvFtTim8YXy7sQIyNsLqrQKeb+POAjc02
         +EswfMAEWRlNl/TSUYSaRrgeV0OWED5V2+GCBwnQvxULO2lL5unExs9ioak4LUb9CAZf
         KV67skgpYHzOqRoOYvexEHDXpaqHvp9NJasTisoLxgXhg2AGWvsCdmauDKTrCTaYntXT
         QQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ffn4jK+AP1mfvxC0eYWzStCC8ro2vYixtu8eyEmpaVU=;
        b=TbS7ipr/OLFrEeyd0LhXq1bzlVBs3HujR89uO93GqWArgbtjYZYMbLJeT7+tLHZN20
         Ebm7W5tAG4LZhj+eTLlSL7vwTIpipkrDdv+fxHcGofQI9GSLyYbgWx0z3aOKSoZWXVr8
         bqweeutZIN/qWpgnbwzu3fqyGQq2R6+3LOPSpBKQJAxO7Axlpx0XIAn0wabDv6ZKYmG/
         gzkpFkEGsfxtgA0qYGVzvA0qPeobuZNVh8lzGJS7JKnOsMdiSzLqU29vPMrMZgFaCpoL
         HkRVmeAdsKezLRpSN+hHwmzn3wX0VnCvfPacbfqRT12rbSGC/z4RvYQ+HCW4umoTZqjG
         Ul1w==
X-Gm-Message-State: APzg51AaBx1ImrvkYMs+tpqZFPaltj7P2KaynRHOChqVqXD7+Z7XPFtM
        3soghyU6EBq+tuc57tD6TDeP6g==
X-Google-Smtp-Source: ANB0Vdbl4ZpN4OCPQh9bwNdC1dZGZ3vDf1AyrYodhF+pkaekqUZY5s5QOwY8XaLfzGi/+L/IDzR34w==
X-Received: by 2002:a50:b4db:: with SMTP id x27-v6mr6465620edd.155.1535533320187;
        Wed, 29 Aug 2018 02:02:00 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id a41-v6sm1546569edc.57.2018.08.29.02.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 02:01:59 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/4] lightnvm: pblk: calculate line pad distance in helper
Date:   Wed, 29 Aug 2018 11:01:50 +0200
Message-Id: <1535533313-29944-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a line is padded, calculate the pad distance directly on the helper
being used for this purpose.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-recovery.c | 2 --
 drivers/lightnvm/pblk.h          | 5 +++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index fdc770f2545f..188c89819a40 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -487,8 +487,6 @@ static int pblk_recov_scan_all_oob(struct pblk *pblk, struct pblk_line *line,
 		bitmap_clear(line->map_bitmap, line->cur_sec, nr_error_bits);
 
 		pad_secs = pblk_pad_distance(pblk);
-		if (pad_secs > line->left_msecs)
-			pad_secs = line->left_msecs;
 
 		ret = pblk_recov_pad_oob(pblk, line, pad_secs);
 		if (ret)
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 54f937c1fb62..994a081994fb 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -990,12 +990,13 @@ static inline int pblk_line_vsc(struct pblk_line *line)
 	return le32_to_cpu(*line->vsc);
 }
 
-static inline int pblk_pad_distance(struct pblk *pblk)
+static inline int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
+	int distance = geo->mw_cunits * geo->all_luns * geo->ws_opt;
 
-	return geo->mw_cunits * geo->all_luns * geo->ws_opt;
+	return (distance > line->left_msecs) ? line->left_msecs : distance;
 }
 
 static inline int pblk_ppa_to_line_id(struct ppa_addr p)
-- 
2.7.4

