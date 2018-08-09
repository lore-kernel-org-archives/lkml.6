Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888DAC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4494C21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPQIoQ4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4494C21F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeHIUcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHIUcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so3213653pfh.5;
        Thu, 09 Aug 2018 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RFAEmNnOCZ/Kp9MrXLAGDUXGdn+QYEpwfWj/EYZS03E=;
        b=gPQIoQ4lIVOzADQ7cuVb38GRq3XQ+5Nc/eTdm73tvxZJfcYlpN7o5miXBIiYV9ORT2
         gaApJ1K5rwvwvJ7hccpRkvs0ThWcFLBdXnvsGToK/9CrC/ixiCIxhLaqCk8hOhg16/mv
         QvGbtK4hH3XGQJkEvCCLEeEgoIrMFSwobVzeM2Jrv5vFw/su7j5k7sZbx9VckCoHtjWC
         CExZQS5S0sJ3J3HHRUxVC+d7kNRDACZ2WYBvZyFZdcsy9pEcfyt64Dvqq/vFeaMVS9/w
         +lBTxo2sNeRlkw/CXix7e3EUbXTY9TumftHuLr1aGDTMepERkBqRza4m0HqsVhVVFUyL
         o3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RFAEmNnOCZ/Kp9MrXLAGDUXGdn+QYEpwfWj/EYZS03E=;
        b=PrvXXmXo9IQoXiQjoCXZyy6HqejQxPVbrilnjywrgEdzH5fxKc7sw9bpkPgQvjjcB0
         FvFdhYMvLgHuNrgPyd8kBn5tgTklFweokWjRQvrOWgPYHNQrcENgnCOIfjp+D1jnTEyq
         Mda4msKng6qcEvcdpgfmsVTlPBzKAXUGRc1lMvAMuKhtvW9IVvzwCyxXBxZotwodx0CB
         7vgDO73ypnLLjRNjg8go5eV9DSpY836WLL1+x/jKhVJhYzJ/e1w0PXuny6IHd4pfYEjA
         /U2uliMN49n47h2Vd1nz20nEuPQ4+KBevfphwyDtHorLJ/zmvFA2BvkGmgCyyPa6MnE9
         7B5Q==
X-Gm-Message-State: AOUpUlHgdylyy49ISPLAtRXX30bhrwHbA+x+sKSDWYp/T63pF8G3TwKz
        hLfBVzSc5vNGSi/mVlE+pZQ=
X-Google-Smtp-Source: AA+uWPytyB9LSwNkRVph7qMwaie9wNtbDldRK1eR2hKOUeDao4hr2ETfzuwvY6kDTbBLQ1KP8xIQYw==
X-Received: by 2002:a62:ccd0:: with SMTP id j77-v6mr3437875pfk.22.1533837962594;
        Thu, 09 Aug 2018 11:06:02 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id n9-v6sm13285315pfg.21.2018.08.09.11.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:01 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 06/17] btrfs: disable direct IO in HMZONED mode
Date:   Fri, 10 Aug 2018 03:04:39 +0900
Message-Id: <20180809180450.5091-7-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct write I/Os can be directed at existing extents that have already
been written. Such write requests are prohibited on host-managed zoned
block devices. So disable direct IO support for a volume with HMZONED mode
enabled.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 212fa71317d6..05f5e05ccf37 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8523,6 +8523,9 @@ static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 	unsigned int blocksize_mask = fs_info->sectorsize - 1;
 	ssize_t retval = -EINVAL;
 
+	if (btrfs_fs_incompat(fs_info, HMZONED))
+		goto out;
+
 	if (offset & blocksize_mask)
 		goto out;
 
-- 
2.18.0

