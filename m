Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB656C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA162084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="MSCM6otc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA162084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeH2M6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:58:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32979 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeH2M55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:57:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id h9-v6so3370517edr.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpDvVtdSqLEG0+QPxw7Qs3v0IkD26P6KASqUsAywFwU=;
        b=MSCM6otcc0gvcru+sQKQ7dSSKXZoIy8duuze1WefYuXSw8Kby2oybIDxBMULt4+0KJ
         AyIWldkvWiLzRzypFUQbWevnMXGnErP4TY5ydb743dTbOeE90ay+mFIW8tHdMhuo8xSM
         8oMJuA8AFXQ0ZhttSkVUoNbrU5+CSMhZYx5HATXokxyyZMFkelF/iUv0hqiOGYpYLj2/
         eZaU3PJZdAyFytYbHsLrCvzrFPz/PxxA+D4i2Mudpg9M9LaVQmmCYt/GFUcdWRoiwS7d
         VXlMBafR+fkdhdhtQz8VjC9/OVTREryyfXNh3xYxnJ8TYjJQV1bY/PEfaZgSjKzGqAkH
         EffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpDvVtdSqLEG0+QPxw7Qs3v0IkD26P6KASqUsAywFwU=;
        b=K4wjRN7jEwazZnO2xVUyTJ1BT5LWnZO0d3z2zqUHkoCCizY22rB3Lzgx3ZpuH9Mmr9
         Y9xq2u30FQ3gwAgQiuna9xT3YJvBx9NIFwfzzxGiaORG8PWmvCJjxac2YdJ9jRmhUQOl
         KHxftFGLojIPc5CyUIdIFAw1mliVSlpUya9iitI9YKK5rfjGdXEWptBzdNCX6dzbcqMz
         lNzZz+UEyC4r6YajYYI+zRO59zRBiWKRxzRtggDeC6LmgdS8Fr4Y/uAY+iJ69g/K4PL3
         FGKxGeSJnDH9NDucAZfgqCU0/Rut158X+Zzqh3R6JM+ep32StMcAyOLXe5yKCKCQmeQV
         Lbgw==
X-Gm-Message-State: APzg51Ahvh2dZwlXiwyV/8qQbmgMdgYmQEywNgkoN/EHIe1CIWR8hAX7
        Iyu8LstiYueEzRyHbR46o4x4EA==
X-Google-Smtp-Source: ANB0VdboSl4HoEYyR6ZQugWo7CeAmk3Ko3c8yIJeUPpvebx60T5OkdvRxGMTS7gXw7/rQyedViK8aw==
X-Received: by 2002:a50:9a64:: with SMTP id o91-v6mr6718241edb.123.1535533322571;
        Wed, 29 Aug 2018 02:02:02 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id a41-v6sm1546569edc.57.2018.08.29.02.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 02:02:02 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 4/4] lightnvm: pblk: guarantee emeta on line close
Date:   Wed, 29 Aug 2018 11:01:53 +0200
Message-Id: <1535533313-29944-5-git-send-email-javier@cnexlabs.com>
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

If a line is recovered from open chunks, the memory structures for
emeta have not necessarily been properly set on line initialization.
When closing a line, make sure that emeta is consistent so that the line
can be recovered on the fast path on next reboot.

Also, remove a couple of empty lines at the end of the function.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 1e4dc0c1ed88..fdcbeb920c9e 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1857,6 +1857,17 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 	wa->pad = cpu_to_le64(atomic64_read(&pblk->pad_wa));
 	wa->gc = cpu_to_le64(atomic64_read(&pblk->gc_wa));
 
+	if (le32_to_cpu(emeta_buf->header.identifier) != PBLK_MAGIC) {
+		emeta_buf->header.identifier = cpu_to_le32(PBLK_MAGIC);
+		memcpy(emeta_buf->header.uuid, pblk->instance_uuid, 16);
+		emeta_buf->header.id = cpu_to_le32(line->id);
+		emeta_buf->header.type = cpu_to_le16(line->type);
+		emeta_buf->header.version_major = EMETA_VERSION_MAJOR;
+		emeta_buf->header.version_minor = EMETA_VERSION_MINOR;
+		emeta_buf->header.crc = cpu_to_le32(
+			pblk_calc_meta_header_crc(pblk, &emeta_buf->header));
+	}
+
 	emeta_buf->nr_valid_lbas = cpu_to_le64(line->nr_valid_lbas);
 	emeta_buf->crc = cpu_to_le32(pblk_calc_emeta_crc(pblk, emeta_buf));
 
@@ -1874,8 +1885,6 @@ void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
 	spin_unlock(&l_mg->close_lock);
 
 	pblk_line_should_sync_meta(pblk);
-
-
 }
 
 static void pblk_save_lba_list(struct pblk *pblk, struct pblk_line *line)
-- 
2.7.4

