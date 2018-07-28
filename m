Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38243C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 01:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8F720671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 01:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qo4w/fsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8F720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbeG1C42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 22:56:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42442 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388893AbeG1C42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 22:56:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so4156990pgp.9;
        Fri, 27 Jul 2018 18:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=74IexoqrWuAflctdUE888PDI6MI2K9K6VRp4yTZOwbM=;
        b=qo4w/fsrvqFVqclogIc2Amzi/faG4+YBcH72DfwaOv/DOND0kA7GdHSAfu8FIqRLi5
         6FcvHcT4IwtFLBSBCkAyNZv7152GkKX6sBUxwg2faxZDgjV33dZwyamDgojQ6yCEwcL7
         ZZFVIm5dkDt7J145wEd40ZNohIxn9toojecN4g065bBuofseE6gXpl1uJvezb1R/rn7v
         WdxpTAmfCyO85sfHSdE3VfEBFz46jWALMA1qod0CmpYXjs0gE8afEZLlrx8OYmacbYaV
         7AeY8GkuXetf79fZQDnF9/I5SZZECDZ2hWOU6+zV+rOsVdoM4KRqKO+1NdajuoADG+Pv
         yvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=74IexoqrWuAflctdUE888PDI6MI2K9K6VRp4yTZOwbM=;
        b=J8Adg0zLYd+vEAnFtb+SmmiXU6zGAbcwmbVrW0BzYQpMAeBWyW9UiloOd+HqKJxVri
         ITuRaQPF+VrBf2/g8yuRFXFLRkkIDO8B0MGKzKjDjc50oRxTRPU5dyYuQPN5T/LH8B5Z
         nqT9hwVZBLNoAdARYT4ATo7s0VkrSNYF7bjNunAyamQwfr/S64sMUK4iidRYEHrMgGvm
         nG+gg/sQ5jqnDmSo7XjVcUd9zxRz9DP4TLaUvzLRBuv1OUZcWFcpBb7IsNxDughwzv6c
         xhbt4DX9cch10Rr3X4odt97SYyCmzzc7vhc7dbb2ZAnGwx2AoO4RTIhiANVeBp1u+K5Y
         XQSA==
X-Gm-Message-State: AOUpUlFgucMPfGZ9Ab1/hwc+GAqd+keCTLLHCephRV5Dqhsu4/8c4sGo
        +Et9Pc6e6CqE8906CCmkdhwsWnzg
X-Google-Smtp-Source: AAOMgpdYMVod2HCBuU92OBiNvjuhehWqB6+NnKvd8KQwyVELkteBESOhxgW2EUMyzH/D+CiGv40gEg==
X-Received: by 2002:a63:8b44:: with SMTP id j65-v6mr8159108pge.248.1532741518887;
        Fri, 27 Jul 2018 18:31:58 -0700 (PDT)
Received: from pjb1027-Latitude-E5410 ([58.227.15.43])
        by smtp.gmail.com with ESMTPSA id y18-v6sm5429764pfl.90.2018.07.27.18.31.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 18:31:58 -0700 (PDT)
Date:   Sat, 28 Jul 2018 10:31:51 +0900
From:   Jinbum Park <jinb.park7@gmail.com>
To:     axboe@kernel.dk, bart.vanassche@wdc.com,
        jiufei.xue@linux.alibaba.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pktcdvd: Fix possible Spectre-v1 for pkt_devs
Message-ID: <20180728013151.GA15457@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User controls @dev_minor which to be used as index of pkt_devs.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of pkt_devs, [1]
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @dev_minor before using it to prevent attack.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 drivers/block/pktcdvd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index c61d20c..665760d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -67,8 +67,8 @@
 #include <scsi/scsi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
-
 #include <linux/uaccess.h>
+#include <linux/nospec.h>
 
 #define DRIVER_NAME	"pktcdvd"
 
@@ -2229,9 +2229,13 @@ static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 
 static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
 {
+	unsigned int idx = 0;
+
 	if (dev_minor >= MAX_WRITERS)
 		return NULL;
-	return pkt_devs[dev_minor];
+
+	idx = array_index_nospec(dev_minor, MAX_WRITERS);
+	return pkt_devs[idx];
 }
 
 static int pkt_open(struct block_device *bdev, fmode_t mode)
-- 
1.9.1

