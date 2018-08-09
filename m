Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6D3C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9653E21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrhVm3gP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9653E21F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHIUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45242 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeHIUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so2862832pll.12;
        Thu, 09 Aug 2018 11:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NrqZh18qx3DHoiPixKO4KdHKXt6/Ehm+nt6+jgONI1w=;
        b=IrhVm3gPnOLyn0d4y9klzRiHMVOKLpQGD9mQx71AtZXKn4VHxeMyBrMdvXWlcCVZQ6
         o4giP3iamqlC+znVvN6xiB5aKPb33OI4+p47PzJYIrwz6c3RudrLPHQWFur9B5ND3LRo
         rVYhsTYQxoLlBDtQ7I1OpzeiIJTZnqZV6vZ3joTboMm/HfHuuAC34Po7/vcAuVkVBqbh
         ygTR0kxNMfC7IRoCD+oJxqCSi05QYuXI0NkQ6AYhDuQHV8DjuGwMW1QvopxYOGFwWmy4
         TtS+KyauBxrcBGshQtVMuG3Hr6l3e3A/hxkZKCTm3+ShCidFXxqivtOkxE/BKyGlWdNw
         YbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NrqZh18qx3DHoiPixKO4KdHKXt6/Ehm+nt6+jgONI1w=;
        b=KzF3xTPLu1j0VSWuo7TPrSrpaM+fbaBf0BR5SiqQ/JdoOCvtD8/Zxpf5AHyx64fjq6
         CKsvrHWbnkuFZX7+UhXDSn4CHR1vswhfVyAypOlrxl+7LjTX24OeX76fdhjP76y005I8
         t7FvDE2yObN0lvlkmBHfpkMBwXxkN3pKiETW1+H5jkv7fGh8Wqav1GMgRTvr/c10/i1y
         OHfoj8zE9YhINw2YmeWZ12IVkXo3cgrpDi3Z80JXJ7A9E68xXrj+X6bpK7LTUUFETVF4
         Y2rwwwUQcvASpPhe+ZkEcCp71A0OIU89eLDOjESZb0r6y1Onb+KnJdfUlH/ynY4G4osi
         dRRw==
X-Gm-Message-State: AOUpUlEHKJtrX13m6YpHeoYOdeYuJYZYTLzmvhVXkFz60+wfJlQJQLKT
        OZ/4tc2PJ6sF6fAqiumy5ZE=
X-Google-Smtp-Source: AA+uWPwxMW68laEP+5a8wKJUo1+Q48DkBgjnnCAzpNMWKuS35nC7mRPNjJZnupBHNxYFLGINthTBLA==
X-Received: by 2002:a17:902:925:: with SMTP id 34-v6mr2947097plm.307.1533837965120;
        Thu, 09 Aug 2018 11:06:05 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id 75-v6sm15976310pfr.115.2018.08.09.11.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:04 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 07/17] btrfs: disable device replace in HMZONED mode
Date:   Fri, 10 Aug 2018 03:04:40 +0900
Message-Id: <20180809180450.5091-8-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable device replacing feature in HMZONED mode, we should avoid write
replicating from replace source device to replace target device so that we
do not write to a location after the position of a zone's device write
pointer. In addition, scrub process should be modified to dispatch the
write I/Os sequentially and to fill holes between the extents. Finally,
write pointers of the zones should be synchronized to match with RAID
siblings in a RAID case.

It needs more works to solve all these issues. So disable the device
replace feature in HMZONED mode for now.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/dev-replace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 839a35008fd8..cde61fb217db 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -416,6 +416,9 @@ int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	struct btrfs_device *tgt_device = NULL;
 	struct btrfs_device *src_device = NULL;
 
+	if (btrfs_fs_incompat(fs_info, HMZONED))
+		return -EOPNOTSUPP;
+
 	ret = btrfs_find_device_by_devspec(fs_info, srcdevid,
 					    srcdev_name, &src_device);
 	if (ret)
-- 
2.18.0

