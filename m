Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43F5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFC0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA599jcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFC0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbeKUXvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:51:48 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39958 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbeKUXvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:51:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22-v6so5525269pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KkU0+Dae85pPY7GfTmoaU9IRRYDbrx5haffTjaBbHrY=;
        b=EA599jcxMhhjiiCmObEVOINK8P7dDm6mDjNaYIPsTFNxIoDXNIbXCTy5anPR7wnPdi
         Ix/H3AKSPSqp8NCBR6/D9tU640vRGMkbYvs8H77eFmA39FMOVxiegmWZ9ofRb+45knjH
         5uMY5MsPsswIL6EsMgflTkJGURnPCj43Q5FSMmYpaN9XS8k32BfM6pMTWX1ImiZ1y6nN
         YGZjTYDog20PkyU0b1kFXFlMZj4m9PLgXt4HNkDGsYkO8k/Iu9MJjbyzcY29zEIYL6WY
         1PlsAVaOMcEr1h0gEqoYFUZ6n0ruFv+FjW6hplRdnDlR1Xr1kwg8gALr44GFGuwOpLQn
         pb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KkU0+Dae85pPY7GfTmoaU9IRRYDbrx5haffTjaBbHrY=;
        b=HrwGqm4qx7NAjVSZTv7SoLExk2IHC4KJdZDtHJCq8y+DCJ39zi6XtEjb7gRDdsBqFJ
         Kd4LOsCnmCcwzV7W7/m6Hk/qF9De5nQcJmdFN1q7IIbEhnX93HU8BOGLHKD9Mp7UHik7
         hqG6eFHbX9SD67E7J8fOrsg+Mc+q5HWJV1SboKKDzK+B15o97VExRn6WoXDTxgls+rn6
         gZ33nopy9cm0VAuFhIFJmoqOdo22OsZVqYfidJ9JUAxUBPq0ORBlldqXIKYH0/EzbmZu
         xaeEKnVuGBRwOEZ+SU/AZntq1wTznERT++i2tPqNOuGadAf4WR7SWSTZNA55fE94voc1
         5CSg==
X-Gm-Message-State: AA+aEWaSFplRghsF/GrctUXwsQ76hr0lV3OY3lgrcj7rtxw8pmQab6Vw
        T4odjklJQFHEVFZnnN+Cd60=
X-Google-Smtp-Source: AFSGD/UtYhv27cXp13MWCw/nRp+nmVimP2lgimBQlHOrv/X9g9b7i3BI2KxgFlfP+g5UTa06IJQl8Q==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr6090833pgs.166.1542806247543;
        Wed, 21 Nov 2018 05:17:27 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q8-v6sm92214081pfa.18.2018.11.21.05.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 05:17:26 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     eric@anholt.net, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] drm/pl111: add of_node_put()
Date:   Wed, 21 Nov 2018 08:17:23 -0500
Message-Id: <20181121131723.22431-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/gpu/drm/pl111/pl111_vexpress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/pl111/pl111_vexpress.c b/drivers/gpu/drm/pl111/pl111_vexpress.c
index 5fa0441bb6df..38c938c9adda 100644
--- a/drivers/gpu/drm/pl111/pl111_vexpress.c
+++ b/drivers/gpu/drm/pl111/pl111_vexpress.c
@@ -55,6 +55,8 @@ int pl111_vexpress_clcd_init(struct device *dev,
 		}
 	}
 
+	of_node_put(root);
+
 	/*
 	 * If there is a coretile HDLCD and it has a driver,
 	 * do not mux the CLCD on the motherboard to the DVI.
-- 
2.17.0

