Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA3ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D20A20858
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Tb5ZnIF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D20A20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeIRNen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:34:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38421 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeIRNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:34:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33-v6so1116137edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLGKaL8J8QVf4JP9nhKTXREyFuKqmlUS6C20OoZhKGU=;
        b=Tb5ZnIF8hIjsKp6fCxi13l1av8UDbjBv5g/JbiUGXuvBjqaWJMewb/ZEL3koH1BqSG
         xRihL7u1D/pncB1pV7rb3N3KCiL/ZBHRqtlLrtlNfdb2veI4RUPRvy9nc29Bi3S/+GdY
         J294a/Bkro3bkz3/Y3za4HZ1IkSEjuzbcavlVPVIsJ+VP0ooRm1QiNCrSDktaBcIT9KG
         GuzmvMvoMkR0CYO2jkVKG4VNZgrC0HHgITPENgYQH0xo3wX/9Ob7f5D6ZjDPA09HI41a
         nWhmNHa5UG1BT5ccnZUpracv/CKcBT+tZQCjqxjRZvr5Ppb+VhFqREKgvg9gDeXRy/vT
         rCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLGKaL8J8QVf4JP9nhKTXREyFuKqmlUS6C20OoZhKGU=;
        b=EtsBFDApiifnU0cSF4UuXVj3rjsjPVSaOyTkaaSqvxkNWM+FmvVKuU8lhaUmu8YbdK
         b4DASzHLiNx9FJSbT5MhKj07Wn+jbPI6YnJ4rYtwANXfHH5dChd+RYN+sDGNNvWk0U7x
         IkKrcb2g2strEibWmtzNPhBA0g2Fuo8bWaKyp21JQWzKOgQ32GprL6hGq8AGd1DDvEq8
         XjoytN/uIB/+LZg7iF52gd7rCkgdhYMATpu6rFrtEmhb6Hw2MGoKf08vffWnHQujC5G0
         rm28e32RkciL1re1gzIX/SLsMi/0G8w/MOw+RwmQ6oE33nhFNVsbQ6Q+PF1V+TFYs5Gi
         EkcQ==
X-Gm-Message-State: APzg51DbybcYJyqFnlEKrPoFRr6csGfAha6kr1sRIK+bIzjIGdA6HJ7E
        JjyvReN/XPpS1MqFwdErJ4kfeM4drHQ=
X-Google-Smtp-Source: ANB0VdbmrK8WM1Y8QtWKDu8aUoaTge/jpaVrWG/7AFQSnfdYN0vPiCVuIVXc1rXdyqqEWPLfRmAmzg==
X-Received: by 2002:a50:f297:: with SMTP id f23-v6mr50138098edm.40.1537257793525;
        Tue, 18 Sep 2018 01:03:13 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id l48-v6sm7221062eda.94.2018.09.18.01.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 01:03:12 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/4] lightnvm: pblk: remove unused function
Date:   Tue, 18 Sep 2018 10:03:02 +0200
Message-Id: <1537257785-31630-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
References: <1537257785-31630-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unused function in pblk-rb.c

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-rb.c | 26 --------------------------
 drivers/lightnvm/pblk.h    |  2 --
 2 files changed, 28 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index c26eab2ba8bd..82829e8151db 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -729,32 +729,6 @@ unsigned int pblk_rb_flush_point_count(struct pblk_rb *rb)
 	return (submitted < to_flush) ? (to_flush - submitted) : 0;
 }
 
-/*
- * Scan from the current position of the sync pointer to find the entry that
- * corresponds to the given ppa. This is necessary since write requests can be
- * completed out of order. The assumption is that the ppa is close to the sync
- * pointer thus the search will not take long.
- *
- * The caller of this function must guarantee that the sync pointer will no
- * reach the entry while it is using the metadata associated with it. With this
- * assumption in mind, there is no need to take the sync lock.
- */
-struct pblk_rb_entry *pblk_rb_sync_scan_entry(struct pblk_rb *rb,
-					      struct ppa_addr *ppa)
-{
-	unsigned int sync, subm, count;
-	unsigned int i;
-
-	sync = READ_ONCE(rb->sync);
-	subm = READ_ONCE(rb->subm);
-	count = pblk_rb_ring_count(subm, sync, rb->nr_entries);
-
-	for (i = 0; i < count; i++)
-		sync = (sync + 1) & (rb->nr_entries - 1);
-
-	return NULL;
-}
-
 int pblk_rb_tear_down_check(struct pblk_rb *rb)
 {
 	struct pblk_rb_entry *entry;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 127ee99c3efc..e70ece87a9f4 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -760,8 +760,6 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int entries);
 
 unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_sync_advance(struct pblk_rb *rb, unsigned int nr_entries);
-struct pblk_rb_entry *pblk_rb_sync_scan_entry(struct pblk_rb *rb,
-					      struct ppa_addr *ppa);
 void pblk_rb_sync_end(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_flush_point_count(struct pblk_rb *rb);
 
-- 
2.7.4

