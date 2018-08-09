Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1FEC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC8921F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYnnVZaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC8921F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeHIUcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42520 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeHIUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id g6-v6so2869211plq.9;
        Thu, 09 Aug 2018 11:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/GURDllLYMHk2phIf3qJDu1l3AZY/16TJzzt0itEyGw=;
        b=cYnnVZaZzaefZs1xpQS72jbPduwS0XGILb6IFqCORgd7G3VXzqFjbDcfZtdCobEwdg
         wEv339LjyDL82Sy8qWRZrCP2BQBm/6HKh5dnZh7ItC9Zg9ziKc0vdCoqaaapclOC9Yl0
         SGeP79vRax8ZlpZgPraimNptBIH+4vC+bEo1K2faJcmmYozmYnX62+cR6mKmgmu5go6/
         JhhJNGYHaErjXU8KGiT+4FKCNeFT3UeHkEDjrIPNPU/GnLTa3S+XjuRF440ZWzYG5+5+
         tGpsqHD3lOpsCjSXjwyMGV0DvsjA7t7Cw426olFrXO52gDyzYL9DuVwG+3pVcY8KsdK8
         YY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/GURDllLYMHk2phIf3qJDu1l3AZY/16TJzzt0itEyGw=;
        b=h7p/tZkvshG1ZfJ1htN28ahOL1PgdJ/atpRkdgIAeu2mXG4lJnhIbn5Gme81XvidWV
         gfAPYCi+3RnqA0PQ1zDMFdtHF5/12BxGUWYQ7A2oUab5ewjugGwL/s9xCWOFVN5Te4Wx
         aafdvqdmip/SI86hnccKP8WkUgZedqHslw2NshaGogu5LeHzXjrCESAzcFF/MlNkFIL9
         ijjuwzV31l1NitO6xUhxQPMZLcqowrVhCU4QSFkyvKOY/5ugYHOp3flL0otWju0ETrs1
         2EPUV4cY7o+iFEyDzhRvs2eGrKmK3Axx6G2+mWXw+A5BHybMA8UKpkCK9RJfvbDjRob+
         d01w==
X-Gm-Message-State: AOUpUlEOY4DPX9azK7c3b6LdanGoy86hmcTYQ2Gv4/59Pq0mSxx5p+PP
        Z0xufkrZBr+GAV1D9tEcD+k=
X-Google-Smtp-Source: AA+uWPzVbFgQwlPUIVEmy2bZoHjlwNCnRYywomp59rEHgkjb/Ek+4IE0Q9cRcVfH5ezqIqHXFhPXdw==
X-Received: by 2002:a17:902:1703:: with SMTP id i3-v6mr2913894pli.263.1533837980310;
        Thu, 09 Aug 2018 11:06:20 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id c66-v6sm17034649pfc.138.2018.08.09.11.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:19 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 13/17] btrfs: avoid sync IO prioritization on checksum in HMZONED mode
Date:   Fri, 10 Aug 2018 03:04:46 +0900
Message-Id: <20180809180450.5091-14-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By prioritizing sync I/Os, btrfs calls btrfs_map_block() for blocks
allocated later before calling the function allocated earlier. By the
disorder of calling btrfs_map_block(), syncing on I/Os on larger LBAs
sometime wait for I/Os on smaller LBAs.

Since active checksum worker is limited to some specified number, it is
possible to wait for non-starting checksum on smaller LBAs. In such
situation, transactions are stucked waiting for I/Os on smaller LBAs to
finish, which is never finished.

This situation can be reproduced by e.g. fstests btrfs/073.

To avoid such disordering, disable sync IO prioritization for now. In the
future, it will be reworked to finish checksumming of I/Os on smaller I/Os
on committing a transaction.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 00fa6aca9bb5..f79abd5e6b3a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -807,7 +807,7 @@ blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 	async->status = 0;
 
-	if (op_is_sync(bio->bi_opf))
+	if (op_is_sync(bio->bi_opf) && !btrfs_fs_incompat(fs_info, HMZONED))
 		btrfs_set_work_high_priority(&async->work);
 
 	btrfs_queue_work(fs_info->workers, &async->work);
-- 
2.18.0

