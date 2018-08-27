Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2C5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DFF208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO4QD1Ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DFF208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeH0Qd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:33:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39748 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0Qd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:33:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so7704383pff.6;
        Mon, 27 Aug 2018 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CWQdb4PUOssyyJvHBQOSqSYqNSh0j6gj8Aqj/gw0/20=;
        b=iO4QD1Ibko0bBz6aI3lmWYQs41k7EWHctARh09BUnCYjGBDWPJjxDYmhPaNeVQAYGT
         MpvJEQt1sQGftvmnyybJp84SdBOo85BAYBjBUbvGWxX28jl1bMtWFXXbju0afxxzcadp
         OKS/CGYqx+U1GD05zJ7YjXeByT8JkvxZKCnnQMhNaoU+emqk9dEx4fFGzhM/Y82yihbY
         WBDb+Agf2dN/gAvwBmltW5PfI83JgxulL+fjCYhUlgmy/XBVRyxgJAODyVZS3pM7YAtX
         84uTVA8lffJAZKsK6b5551bN8v0TqOF9oVluPVroAbnDcy3SN/3/xLU2VsgnOzu1YLbi
         sSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CWQdb4PUOssyyJvHBQOSqSYqNSh0j6gj8Aqj/gw0/20=;
        b=eAZ7K2CLizrWYhlM9ilmN/HUZjfnX0dtZTz4lb38kFi/0qDNqhbMkqwfPz/f63YfAb
         h43jiKbWTrCnzN5dkum7qr1k/Cvbl5hDRQqMANGGqCCCWADfGOYLPh3blIBwSWQM+uzh
         hXaecrr5XD+bm4Jqvb/Sib9IK5aepkl/uYBM/Sues5AACDDAjUO8122n1VRT7eQmwA5e
         yTNogsHHbPGiTTDgaA2ijbDt0otlyhIv4kJ1kdhulRGtLeDrIi7/AnM4Jle41idu/ZHB
         KRlPkfAl7RqsRIIwaz9WPC+R2YXk8VepWcIRGGgZN1hlrVUQKMKorf97vQ2nCxJ7kl4r
         NR4Q==
X-Gm-Message-State: APzg51Di9Z4em+k6j1eP2KvnHL7nKcUltNFhgBBSRl4s6vEnDDkduODc
        jUqkVSeuLCH+Gpq8ZJzzgcg=
X-Google-Smtp-Source: ANB0VdbQp7cWJs70wIOGqPiOJkbKfaIVP44RqGfvlkmnj8APIoy/tL+VrWsf3nHZi8poQu2JHxaDvQ==
X-Received: by 2002:a63:6054:: with SMTP id u81-v6mr12398606pgb.433.1535374048681;
        Mon, 27 Aug 2018 05:47:28 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([103.65.40.43])
        by smtp.gmail.com with ESMTPSA id z6-v6sm19942639pgr.41.2018.08.27.05.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 05:47:28 -0700 (PDT)
From:   Li Qiang <liq3ea@gmail.com>
To:     alex.williamson@redhat.com, eric.auger@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiang02@corp.netease.com, Li Qiang <liq3ea@gmail.com>
Subject: [PATCH] vfio: fix potential memory leak in vfio_msi_cap_len
Date:   Mon, 27 Aug 2018 05:47:21 -0700
Message-Id: <1535374041-3551-1-git-send-email-liq3ea@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free the vdev->msi_perm in error path.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 115a36f6f403..62023b4a373b 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1180,8 +1180,10 @@ static int vfio_msi_cap_len(struct vfio_pci_device *vdev, u8 pos)
 		return -ENOMEM;
 
 	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
-	if (ret)
+	if (ret) {
+		kfree(vdev->msi_perm);
 		return ret;
+	}
 
 	return len;
 }
-- 
2.11.0

