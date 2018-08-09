Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F68BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CEF21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFo8X/Tg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CEF21F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeHIUbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:31:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39836 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHIUbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:31:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so3214233pff.6;
        Thu, 09 Aug 2018 11:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvQdS+YZIe+wiJ5ieDWw5b4M533zcVegstwJ0CglGQE=;
        b=EFo8X/TgD3VahlIHAUsX5R/ySsxz4FgZTSJTKfbfPtQZGnrRqBe9WsUy/yLRV+Ee0O
         LpovQvvaUYyXWIC414eM4PiJbgtno7RPoX2I92juVOoxgbNIDez0UXf4vkBLNOuMyeen
         EqT3bxCGXhT4BmNSo3jXs5Ljbre6bvC6EIzdLw31EJS9ARzZeAV3W2k8KaMTCWxIjwd7
         iDmia0T7L+npj3eLJq/NjBZY7eAlGfxpw36XEF+KmBWRkpXLww937FZTOSuzGPiS5Kvu
         UgrBHTOmWX8ZG5df9L7yLaEx77/gmWBzVEZHcXkDhDokZOZmdI3YDtamhxDbJytrfuSN
         B5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=PvQdS+YZIe+wiJ5ieDWw5b4M533zcVegstwJ0CglGQE=;
        b=b2Orjiy/ZZl/mYj9qP6AkGq6Q5L5J2UKxBO2/ld8VLQ+/scmm/sV+wKQuSHKLsn+yQ
         IgjT4M5ONoxR6C8y/kDdZ6nKe9+cqwJFlJ9IFgLLx1fdhHliYAeq2CoIMFkAbGrXB4Gg
         izfDfgWWKAra4o1gOHXKKUF+PavFtINivTOzZiMShLMsZXQO3hRxQ2UUaBlLCAedQOgo
         ILrRXkTNoi6vjn6jVsCqKQpYV5ju1dY4qYz+h2UxHNxqYDXM3LouhyW9SbnQAZxDDb7e
         44+IzFbqgiaQws80K6PkegnPLFEgJWRdvVG7pEdZ3pChBROs4BRPVxe9sgouuEvE/xju
         EVBw==
X-Gm-Message-State: AOUpUlFdJc+eQYPa3uEu46X0y/YQ1exnxVfCYSWPv/z2aXOxXYV4kWEJ
        uq+ru5xgTCXOC/rR6gswlw0=
X-Google-Smtp-Source: AA+uWPxuIBWQd+veUoDBmAVeOkXD3FTg3Kq/caxQCUmofXJrs5CwnuYX2LcrL9mZkcUlJiCBf5phVQ==
X-Received: by 2002:a63:5421:: with SMTP id i33-v6mr3157893pgb.417.1533837950755;
        Thu, 09 Aug 2018 11:05:50 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id t1-v6sm7299480pgp.32.2018.08.09.11.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:05:50 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 01/17] btrfs: introduce HMZONED feature flag
Date:   Fri, 10 Aug 2018 03:04:34 +0900
Message-Id: <20180809180450.5091-2-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the HMZONED incompat flag. The flag indicates that
the volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3717c864ba23..8065d416fb38 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -191,6 +191,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(extended_iref, EXTENDED_IREF);
 BTRFS_FEAT_ATTR_INCOMPAT(raid56, RAID56);
 BTRFS_FEAT_ATTR_INCOMPAT(skinny_metadata, SKINNY_METADATA);
 BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
+BTRFS_FEAT_ATTR_INCOMPAT(hmzoned, HMZONED);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
@@ -204,6 +205,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(raid56),
 	BTRFS_FEAT_ATTR_PTR(skinny_metadata),
 	BTRFS_FEAT_ATTR_PTR(no_holes),
+	BTRFS_FEAT_ATTR_PTR(hmzoned),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	NULL
 };
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 245aace2a400..c37b31a5b29d 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -269,6 +269,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID56		(1ULL << 7)
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 10)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.18.0

