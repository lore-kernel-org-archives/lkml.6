Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14963C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62EF21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlikYUqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62EF21F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHIUb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:31:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44915 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHIUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:31:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so3198410pff.11;
        Thu, 09 Aug 2018 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vragor325c5+mkfaiNN9c9VU2fiaVIcgfu01gZ3wtGE=;
        b=tlikYUqnqLXIS0Lu1xCQBWPm6kMPZpvmTEwdsavB5f4HIPzW8ojZw3kHq0+w7RkWJA
         hO2fAfdnBrdBgqfYOfjhqq4k4LL4Xou+JK5rUGklaC6hsoGIyg5pqg4698tgZrm/zgB0
         FMjZ0pRsfpNxd0QAhyf6IkUUtRLouYU1w9NYqBIy9uQyNzqGXdmzz0evhTNOeBnbbY5Q
         tLBYrBwM+uDnP8B/Ba4M7NmOztR5Qc1ShcybQPy+Gm2B8O+STacQkAplpBDppeuJhnEd
         TVHrOXjzWbwXDxDqtRO6DijH2Ri9bEocpusuhzK7iga3Zo7Mb5DZgOGr5Zduei85Wkvg
         wStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Vragor325c5+mkfaiNN9c9VU2fiaVIcgfu01gZ3wtGE=;
        b=JXzqdK3qywX+IF6Rpc5BH7IaXArtW1BYPiLZURkxxbcgGiaT3CI8xfgkcMDttstdpq
         3Z1LBURY7yzmhP12rpGMICivS0hrCPkO/L5Ug9qqDYmkwIFVhxJVXOduBrIU9Z9l7I78
         jXg0jgntyA+dgJnwWgMtWm6r2emZ31ONSoGfxc1QVpctD6UfwCYMPBxkEOHF8mPTNSZY
         aGaJrNQL48SbZ0PWgyb6W+f0sbG9SDWjbWYdpfgN80hOr54d4DAUF5YdV+AznxM8ehbt
         i7CLh6B/DQsBtpkMF3VwFjmo1AeIsd5MD2T8vI40gtfzLFTEbdrcUfgFbO/ghDpsZ/pK
         Izuw==
X-Gm-Message-State: AOUpUlFxkPOb9Y1K0j7+04LbZcIPmtaq7KB5RzvUg5nJIGHj56Gq3Gzs
        04n3sJzFX1GyF229jEWw740=
X-Google-Smtp-Source: AA+uWPzYZKRdXMUMuxDSXKi7uGDHmxq/C1675FqLvAgjwpq1e/Jj3mnK2RIgNPKd07Io1rA/Vshbnw==
X-Received: by 2002:a62:5b85:: with SMTP id p127-v6mr3478638pfb.33.1533837957898;
        Thu, 09 Aug 2018 11:05:57 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id 143-v6sm12128663pfy.156.2018.08.09.11.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:05:57 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 04/17] btrfs: limit super block locations in HMZONED mode
Date:   Fri, 10 Aug 2018 03:04:37 +0900
Message-Id: <20180809180450.5091-5-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When in HMZONED mode, make sure that device super blocks are located in
randomly writable zones of zoned block devices. That is, do not write super
blocks in sequential write required zones of host-managed zoned block
devices as update would not be possible.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/disk-io.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 14f284382ba7..6a014632ca1e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3435,6 +3435,13 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
 	return latest;
 }
 
+static int check_super_location(struct btrfs_device *device, u64 pos)
+{
+	/* any address is good on a regular (zone_size == 0) device */
+	/* non-SEQUENTIAL WRITE REQUIRED zones are capable on a zoned device */
+	return device->zone_size == 0 || !btrfs_dev_is_sequential(device, pos);
+}
+
 /*
  * Write superblock @sb to the @device. Do not wait for completion, all the
  * buffer heads we write are pinned.
@@ -3464,6 +3471,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
+		if (!check_super_location(device, bytenr))
+			continue;
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-- 
2.18.0

