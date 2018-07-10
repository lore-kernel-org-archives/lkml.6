Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCE8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BE4208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwd8DT2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BE4208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeGJDeI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:34:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37285 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeGJDeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:34:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id x10-v6so5234997pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 20:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WsdLPdwvHqxlWUa/+V/y2YCutcj9kExp8LPWlKCa2ww=;
        b=kwd8DT2Qr5mDuK6ZdOVe0Ce/zmmnlcgS7ufvO31OR3hU1CsnY0Qh2DHoxTAb3WU5/N
         IJY0GxXJPzeB5ZZsu+zEg9tNRcJAqrX6vNtcweQWqJjQn4MKLwLScODAlIZfjOv7RJrX
         h0W+yauGw+jhqaIcCPzUj9AcYPr2/LXi3F/HMhTejdE5/BzVj4/RKbgKHYaftYR37frS
         lMD9XGcEgralV6IYm6PQleZHMLH8Zu6KVJ3jAhh5efMrUL0G93cV4MJxzVzHsLwtglAH
         DLuO8RbmTnq72OkweonEuE88hTWa0MT/YV/DAsA/qztTbHQYjwOVPyCfZzCjoUKD9GSQ
         jMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WsdLPdwvHqxlWUa/+V/y2YCutcj9kExp8LPWlKCa2ww=;
        b=Ptoqiwwy8a7PTnkYOLpcMx2TvKlpURQo08+wHHBWZ29Plb3TlhiXiXCnUe3vHKoV3+
         qHcfkizDHLlaXqXFBt4pO/TZjrhdtwGqj8SSQEBhl4Mg7E5yjCh/IDncWKnayNivxKOq
         Eb1lTftuOVpQiVhZSiGHvF71OnWhFuEugTB5s2cQ52gN/BMZKY5hdmi/yCcI449Lmcav
         9dMZBQ0LZm6vMSPpFgxmTykCMZ3JYqu/E0AsBgYYHul+XxYzIklf1uqx4SLxksOkQAUf
         sT73AFJAhaKdhm+pviIZYf5U/T1Ys2XedpSaKJQWWjH5KPuQdBpKeQPV7atayJyfTltC
         T/lA==
X-Gm-Message-State: APt69E2kSDAeUauh3JwtekdhlEK7jixQRbkYdLG4dIpFo4x71+/RYEu3
        oAXfWYVUKxVbk5rcGMvpPISICA==
X-Google-Smtp-Source: AAOMgpclipEGo6DWAARpkIqeFvrqkavtMbjdfmR31V+4/B/MuHP/Xpkq+P1YLmkxbux/cIceqC/70g==
X-Received: by 2002:a63:2c0d:: with SMTP id s13-v6mr21506830pgs.37.1531193643014;
        Mon, 09 Jul 2018 20:34:03 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1611:7129:1142:3149:848c])
        by smtp.gmail.com with ESMTPSA id z19-v6sm24778961pfe.163.2018.07.09.20.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 20:34:02 -0700 (PDT)
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH] f2fs: Keep alloc_valid_block_count in sync
Date:   Mon,  9 Jul 2018 20:32:42 -0700
Message-Id: <20180710033242.177557-1-drosen@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we attempt to request more blocks than we have room for, we try to
instead request as much as we can, however, alloc_valid_block_count
is not decremented to match the new value, allowing it to drift higher
until the next checkpoint. This always decrements it when the requested
amount cannot be fulfilled.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/f2fs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d8b1de83143..5af955a8736e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1680,18 +1680,20 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 		sbi->total_valid_block_count -= diff;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
-			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
 			goto enospc;
 		}
 	}
 	spin_unlock(&sbi->stat_lock);
 
-	if (unlikely(release))
+	if (unlikely(release)) {
+		percpu_counter_sub(&sbi->alloc_valid_block_count, release);
 		dquot_release_reservation_block(inode, release);
+	}
 	f2fs_i_blocks_write(inode, *count, true, true);
 	return 0;
 
 enospc:
+	percpu_counter_sub(&sbi->alloc_valid_block_count, release);
 	dquot_release_reservation_block(inode, release);
 	return -ENOSPC;
 }
-- 
2.18.0.203.gfac676dfb9-goog

