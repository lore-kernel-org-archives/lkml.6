Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752752238B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpDfi8/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752752238B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHIUhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40697 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeHIUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so3110314pgp.7;
        Thu, 09 Aug 2018 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NbmpInz5/joKYbzaioP/45OSGEcNKQUls8Zih/tMAyA=;
        b=PpDfi8/3zCXQAWOTly/hgj2fVILbBAR/v1v/oAR4VkoW0JyMySKDDJbh8tSSx7A5tP
         GWfBTZqXIm0Rr2sw3REdv6oX8lY0uG4U9ho4clFIn+7GYon4E0RvWSaETIG6H+iRLJR4
         bu/uD9us01N1nxqsV/U6DZWi745nP2Qu/PUs/j9xxxivZ2Oxfe2LHL55UpSqvLb8fR9U
         /ZEGQ3gbkgg6CfdLjKLLfNxrC9rdnFz+K7KGQ6QfLF+OYweCbj3n6tnsBN/CMOOFRdlJ
         jI+Eo7ybOGqs76KmBmycTK2SCGSL7H5RDVpoKnlp+aFmzyo0BWeb5+UlMifP4L0RgXz2
         YuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NbmpInz5/joKYbzaioP/45OSGEcNKQUls8Zih/tMAyA=;
        b=j43Tu96wsGPFNjfHI1JMN0YvsxyDGIQ1SWE0eW5I5YbCuhudZ5zwWcsr1sGqio8GW8
         XPGsqg053VWe11Rsj7OZo4csPE2Z42gVi6v96NQ34pjSM5+Xmq46jPbt3HKuxU6S00Z/
         VKUr88De/ttBSr4m6PaKwy6Kt6sbnHY+/uo/y0EBbuF7jjLanar0ka72IjSogZDu45Ae
         Bt1SP/fOJE9hPwZIruvrpjOktSoEq5yB825oUdIAHQ+Vcjo5qiUJaGfFhYlTDoDOJmrt
         AGg1Yue9enGBQqqayOmnT11dks0a9nN7G02ecSwRfCuf5izUvHzzU1536H9KI48/M2qU
         rlKw==
X-Gm-Message-State: AOUpUlGEIFIFzT7d3EjUJxm7u8heCTtcy/t9wHFhfmN262omwmTt4jVB
        iJP2bfLEbAysc4nJc4diMlA=
X-Google-Smtp-Source: AA+uWPw9TNS57HDQ/KEKkC4gS5NfT7obFwEDNPSStVTnwWkjjfhNU5gxk525k+iu+x1Qchubc0jnBQ==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr3130277pga.353.1533838284236;
        Thu, 09 Aug 2018 11:11:24 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id e14-v6sm9778335pff.128.2018.08.09.11.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:23 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 06/12] btrfs-progs: avoid writing super block to sequential zones
Date:   Fri, 10 Aug 2018 03:10:59 +0900
Message-Id: <20180809181105.12856-6-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to write a super block copy in sequential write required
zones as this prevents in-place updates required for super blocks.  This
patch limits super block possible locations to zones accepting random
writes. In particular, the zone containing the first block of the device or
partition being formatted must accept random writes.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 disk-io.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/disk-io.c b/disk-io.c
index 26e4f6e9..127d8cf4 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1523,6 +1523,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 			    struct btrfs_super_block *sb,
 			    struct btrfs_device *device)
 {
+	struct btrfs_zone_info *zinfo = &device->zinfo;
 	u64 bytenr;
 	u32 crc;
 	int i, ret;
@@ -1534,6 +1535,11 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		btrfs_csum_final(crc, &sb->csum[0]);
 
+		if (!zone_is_random_write(zinfo, fs_info->super_bytenr)) {
+			ret = -EIO;
+			goto write_err;
+		}
+
 		/*
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
 		 * zero filled, we can use it directly
@@ -1550,6 +1556,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 		bytenr = btrfs_sb_offset(i);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE > device->total_bytes)
 			break;
+		if (!zone_is_random_write(zinfo, bytenr))
+			continue;
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-- 
2.18.0

