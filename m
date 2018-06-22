Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF32C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609B423F63
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+ktI6+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609B423F63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeFVJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:38:16 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38472 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeFVJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:38:14 -0400
Received: by mail-wm0-f44.google.com with SMTP id 69-v6so1777754wmf.3;
        Fri, 22 Jun 2018 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6pDO54cy1U6HDhIB7XOWr+6TNsITqkSN+Gt84rVkatc=;
        b=r+ktI6+9eMHPb4+oM3TP2/MnPBvY9c9Fz1vR9D904QRBCbazXUCR2+34hLDymDwp1I
         ItlXvdxJenxFoMjyBQnx8g3RwIx56qTWp4bDCgTVSK0zfetNfWkNgf9rg917KSQPDZb+
         L3QpN8N+iSbRNdlcjl884ZeGo18uzHMAU/3+TYnmk/aJRjjhNEFct5QBuY1NCwI6GTFH
         2p2jJozdYITiDzmdbttDNbNP8cCwsIRev6jX7vXmcnmVMCSJzQVyCCWzD1PqSRV/6WUm
         AYY2vGuayxy1nEBoPK69q23wkjY67FNF8l6E180iCnuPhzfbizeero6hHzwCMEbU3/wK
         41GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6pDO54cy1U6HDhIB7XOWr+6TNsITqkSN+Gt84rVkatc=;
        b=QpwHKnxErXKHyvN/gi4TjgCI0jZsai0Zek5bp1DDASIznWYlUPoMcj9BG9/gQy9RIe
         J+J/4oloR1S0ei8W9QiRTlDim0NXTTYCSwIkGM/KO+W9TthuCz4CLbvKE4UXoJOrScF/
         EINbXTrqbxjv7/a4SmzXeuAHVodEQTrQ7NxMuxNLwKKE2Ev1sUka5enll7wb3wy3FipS
         uLF4qWoBN4c3vBFnr2IDdofk5+smR7fdbsSIn3mJscekfOsMvLkBLvC1vmqoq/HaFhco
         Pul+I2C5tfvPKQqRRPkzIWQ2q58S49CYeDFQ41/XOVyMz5Asb8gj6Xpoj6huhu7dIn1S
         r5hw==
X-Gm-Message-State: APt69E3z4dcC3thaK9IJ10MxuvZZNW1sfwDOVvOpUw+lLIkMp47/+d2o
        glCiwyHkOxjy6njTY1uqq36zUoRA
X-Google-Smtp-Source: AAOMgpfHAnhlKf9djJZSeb8WPOQhZezI16CHOkN0+qOD6Um/8m1wXbyaInUzTCVDXQfI0CNnbwLWLw==
X-Received: by 2002:a1c:e846:: with SMTP id f67-v6mr1073990wmh.63.1529660292862;
        Fri, 22 Jun 2018 02:38:12 -0700 (PDT)
Received: from kitone-HP-ProBook-4530s ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id d7-v6sm6568344wrm.9.2018.06.22.02.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 02:38:12 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:33:25 +0300
From:   Kitone Elvis Peter <elviskitone@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] block: Use SPDX License Identifier
Message-ID: <20180622113325.GA6552@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is need to identify a license in source code files
for open source software.

Signed-off-by: Kitone Elvis Peter <elviskitone@gmail.com>
---
 drivers/block/brd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 66cb0f8..4f998ed 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Ram backed block device driver.
  *
-- 
2.7.4

