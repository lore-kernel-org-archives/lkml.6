Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F24C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1B923F9A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLwN0iXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1B923F9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeFVJkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:40:46 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40677 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeFVJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:40:44 -0400
Received: by mail-wr0-f194.google.com with SMTP id g18-v6so6026318wro.7;
        Fri, 22 Jun 2018 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w4PrFchovxeNpBwGuc4y+0WiRjWG/ZeYnQuY7/HHlrc=;
        b=cLwN0iXbw2mxUKMq9Z7GeFCUXBC0brWBY+jy8Ps5wb8XHVntKlySCm48kobmjGnlQn
         u1mOqDJ1ziGKTE2fklmCHTRDm+6q331Sy7oCGPWKlsSIpEwSq2L9TmZZsD8/CmhwaHc1
         8SLztblzUDqNYOFahT7LszuXBSyKH5F0WYUr+a2JxjKsPRlFPwgTy+vldbd3rlvzXWm6
         Ul3OscHjxxZBwGZ+h3ZCBct67IJwiOlJzzOgFryPp0WVu0gaPvNcGbe5Sm80T4IbLfxl
         sDdTBcvh+4OGpBziAONBqb4TOae4BIphelueMZgNYhF1n/oRv2U8Kh16/IyFACUBzLNW
         E4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w4PrFchovxeNpBwGuc4y+0WiRjWG/ZeYnQuY7/HHlrc=;
        b=cH2KcHDV/h9ly5wxMsKO7Pw0WFhQhiIhW0Fc0CrHBMAw315waFWfX8ov8A5TFFmChQ
         uf5345duMLY+VyGuF4lTgAu9FN2ln5SDJfD8pTnnkJ8nM/3Y7z8iVqPs0SG783G2bzgT
         bxIarZS691v4i680gVVzUsMu04l8CYS1h8o88er4SAXp9JDMMVw0qJO6XPJPdVFd76DW
         3Ki8ZZdY7eVgs8S7IUfOGM6HFiJreP3hunfWb6KS+XjQ0f0ThG7keimRFEJqOAM69238
         ijeeif3huRyf/9/S7oSthbYvO1ynp12uy6gVyEqFZeErMGHM+pkTg9V5cGkzqTh1lJxr
         xdpg==
X-Gm-Message-State: APt69E2kipqH3rglhMDKLan9IQS5pgUVlP8FhRfXKNpXdtmF7x4u5CE2
        7n+hWt+JdCDgKAaqgViA7gHgnmFl
X-Google-Smtp-Source: AAOMgpeoThpcNcMnSXMBeyVi57WujVJcLANWPUMa3ri4skeTAa4tkrumGMgN7ypr9Xcvtun1eTma8g==
X-Received: by 2002:adf:b587:: with SMTP id c7-v6mr931753wre.141.1529660443068;
        Fri, 22 Jun 2018 02:40:43 -0700 (PDT)
Received: from kitone-HP-ProBook-4530s ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id t10-v6sm6993943wrq.74.2018.06.22.02.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 02:40:42 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:35:57 +0300
From:   Kitone Elvis Peter <elviskitone@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] block: Replace symbolic permissions
Message-ID: <20180622113557.GA6594@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace S_IRUGO with 0444 in module parameter declarations.
This makes it more readable and it matches the style used 
in other declarations.

Signed-off-by: Kitone Elvis Peter <elviskitone@gmail.com>
---
 drivers/block/brd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 4f998ed..e2a1278 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -332,15 +332,15 @@ static const struct block_device_operations brd_fops = {
  * And now the modules code and kernel interface.
  */
 static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
-module_param(rd_nr, int, S_IRUGO);
+module_param(rd_nr, int, 0444);
 MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
 
 unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
-module_param(rd_size, ulong, S_IRUGO);
+module_param(rd_size, ulong, 0444);
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
 
 static int max_part = 1;
-module_param(max_part, int, S_IRUGO);
+module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
 MODULE_LICENSE("GPL");
-- 
2.7.4

