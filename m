Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749EECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790D820881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LfC2nw2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790D820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeINPrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:47:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35885 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINPrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:47:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id e1-v6so10018690wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ZMJB5DD8w/7nYPogAV2huoYB+2lw0VvyWSY+ZRFuKbA=;
        b=LfC2nw2L85qACufhVqcVDZPpXYgFQ5X3rTACZOOM+4CDqmzIqvPEr8qjwKjWDLwSds
         6sBxPnNJOWiOlaeSI0Cn+LW3E6FJsKO/5jfUGwAdzjUErZ6xtsdtwmwYmQw1pk5KFmw/
         GGUr6GdQZjBlC/VwBS9O6n9bsjF7WdW/+pHJQGCJWi3DMoB9rJ6uZg+yjGpAxn33h3Co
         tBNyjXDvOcnbfWoWYBiKumYL9bbeJfuFYsFUN8LHzvqUe5MHRypV+UR2HNAv7dk1K2Ll
         vwuk9ZJynPcCffSDxs7u8qdNzY+4WfvDD/3hkuw1xZY7QY18EWCHnO1pSl6q2GhPQu9G
         4DQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZMJB5DD8w/7nYPogAV2huoYB+2lw0VvyWSY+ZRFuKbA=;
        b=OC1HZg0hfA8On/7+ihj1W3xHcTxnBhx3Di46KzKHa+0ShHIV2wQwYZWWT1BJXuPT27
         P9mXXMVIwek9sQPowps3TD68g8wOls3XMdNuEeM3J9KMziKQA8GzqlLjADt6MzUNmYwy
         sqZA9eDv3CBVRRr/CoRH0ayYOl/8fgm0u2bnIU4foX3KJ4K6I5sq+3bzr1rbiItDJh/R
         DdnY1Ju6qqO3ZJcWykFcSLOPHHVf1RVjo0MqIfASiMYnKW7tp6LzTLUki1kiM1pvhCyw
         xhjN4c90IvYa058cAdUkiUXrFd3H7a4+rtV50xM84pbzbJFQs4eJJAPudorZyQra0AsB
         qbhA==
X-Gm-Message-State: APzg51DvePRj/Ay8bA8C7gLpb1pWuqo2VBJ6SyQ3PlsAD3yDBffRreEj
        ab64our7jZNHT32h5TPRTwTQ0g==
X-Google-Smtp-Source: ANB0VdbFmBOg3os/5wv8Hov5O2vn+9QPS3r4p96KIFqOqZNc80wizxfIbKNl+SESA4YvteQzvFR/oQ==
X-Received: by 2002:adf:9366:: with SMTP id 93-v6mr8898592wro.60.1536921199171;
        Fri, 14 Sep 2018 03:33:19 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r6-v6sm6376790wrt.92.2018.09.14.03.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 03:33:18 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, jdmason@kudzu.us
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 0/2] net: ethernet: neterion: use linux/io-64-nonatomic-lo-hi.h
Date:   Fri, 14 Sep 2018 10:33:08 +0000
Message-Id: <1536921190-38619-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This serie remove usage of custom writeq/readq in favor of ones defined in linux/io-64-nonatomic-lo-hi.h

This serie is only compile tested.

Regards

Corentin Labbe (2):
  net: neterion: vxge: use linux/io-64-nonatomic-lo-hi.h
  net: neterion: s2io: Use linux/io-64-nonatomic-lo-hi.h

 drivers/net/ethernet/neterion/s2io.c              |  1 +
 drivers/net/ethernet/neterion/s2io.h              | 22 +---------------------
 drivers/net/ethernet/neterion/vxge/vxge-config.c  |  1 +
 drivers/net/ethernet/neterion/vxge/vxge-config.h  | 20 --------------------
 drivers/net/ethernet/neterion/vxge/vxge-traffic.c |  1 +
 5 files changed, 4 insertions(+), 41 deletions(-)

-- 
2.7.4

