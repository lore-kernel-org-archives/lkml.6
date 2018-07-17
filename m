Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2040B208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kduwpb4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2040B208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbeGQMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:35:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37384 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbeGQMfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:35:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id a26-v6so400394pfo.4;
        Tue, 17 Jul 2018 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZpA6K+CHXs0h/hfU8hcGiB7lprfK/b3I20WZX9HufpY=;
        b=kduwpb4PqMFdVKjobYd8MgFMz6iRDtnWQpuTBY5unqCPPv1Mh0gmGWXZG7DVC4a9iA
         BJw/QhDl694M3xfyE7zL0Ji3o5qJFxKEuOL8U6qsxnycbIciqbt0Le1Pzn/1NR3+9ta9
         Ug5w7373tax6o2OQkLlaTBfUtCRZOxaFGL/mxxGuKhXdgygKOXHEdWSXuOerBg53rqFQ
         XnrlmRCFG+pD6HF6WzHp1YE3aMdfXErVBcmcdx5tZHiUgRf4QJuyqff2KHYxaGPH7fgn
         u/gYbzgQsP9skRVjnijvQzAUCOAejTcQK1kvkds7MEuStkBZzzMQPz15TiI5GIix5FO9
         lqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZpA6K+CHXs0h/hfU8hcGiB7lprfK/b3I20WZX9HufpY=;
        b=iwutVLt5mzERvn+x1HfC8EMeToXQzM2QmERhDhCqIs95VmxJ/oH1IwaCyv71a3c8nf
         bGh7TcBvKY3CvS86mCw5MvLTvJTxQkA8Fj1mctW5Rn8NuZSDUBOO/j8Qbi9RtmAa1ARv
         0Ydxw5wNim9J7h+3dYH6hKLjMRDqnzEJG429Aqf8L/1oB4lsCIbr307C1iMYvoj1TRDB
         pFHQU/BbCSKi+KDr0RKruPhV3z5JH5F+YNijjFdOIYwvMUvMe8uLPng8gOWoysVp7m+0
         N0Vgj4Oc9NuXEq6V0gSzRtOVAFSc8w9xpAF7gbgoB+c/COGeKducE2CrasvU3T4afvk7
         cG6A==
X-Gm-Message-State: AOUpUlGZY9xWCl4DvhT4lwkuUByvPa6wxdutHGDy/U3TSqAowyvx+mno
        uAHYlO4UpBtBK6XJ0Q8+1qwDq72C
X-Google-Smtp-Source: AAOMgpcYE/H3a7TjTv8E0f5Sq1wQNju/u6vg3Kx8mLDEGmqULMqv8cMmryYummxZdv7ic1cOQnOrSQ==
X-Received: by 2002:a62:d8c:: with SMTP id 12-v6mr407736pfn.202.1531828964270;
        Tue, 17 Jul 2018 05:02:44 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id o26-v6sm1663804pfi.167.2018.07.17.05.02.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 05:02:43 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     inux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Subject: [PATCH] Bluetooth:hci_bcm:Check return value from devm_clk_get
Date:   Tue, 17 Jul 2018 17:32:37 +0530
Message-Id: <20180717120237.25030-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Check return value from devm_clk_get & return appropriate error.
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 441f5e1deb11..1295cc89d702 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -910,6 +910,8 @@ static int bcm_get_resources(struct bcm_device *dev)
 		return 0;
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
-- 
2.17.1

