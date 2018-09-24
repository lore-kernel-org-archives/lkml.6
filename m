Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD93C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915A420842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 01:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orFgewGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915A420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeIXHlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 03:41:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40816 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeIXHlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 03:41:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id e9-v6so7301662qtp.7;
        Sun, 23 Sep 2018 18:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=GdBoOoo9au5nVF9CN0xPwHw/Lenyg8WZDczWEzk6XcU=;
        b=orFgewGzt0KHxC/lpCk62WCVz4kg/h1Zfk+7QZoRW74iTMpZ3Vn1Bbr384pm1IRzdZ
         A9l8iLjJ1xU581a713jFEWZVflzU6OMG1IZq8Po/SoEsbsS3QqrThpT1lzJkkCdVvts5
         cgsgDYqvjCn/gwuL8I5N8Ee69lTkEDTjdpLJafK4lSnB9GORpq7DyyzXry3YsC9rQ5WB
         gHavkrBTzaMB+fk6B0sNTrUSuPa/Tw6s+UVQKOjuP/VRI2n6qxOJEhTHHqn9WompaHN1
         Rrwd85I8fZvYAWVH7Y0y0yY3NvEiWH0ODNu9zonhE2Ldhkv7voP1n98aoncHHxB0Uamd
         uAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=GdBoOoo9au5nVF9CN0xPwHw/Lenyg8WZDczWEzk6XcU=;
        b=i2ald8Al8Oesj00+fJNMlorT8P087GAks/PYAshi0V9dV6eBdXMsKKBi66a1x0HPzZ
         DQGR2hTvXBXHXe54HFxT2vnzDY8gezsth+U/EQNefLHEjNcQ7m1vZajUH5vTxiB2Z37J
         NOi9iZkIuemW5zACjOGXBQ7ynMEKnvYe81WvR8tuwnQFBCH4AR7cGkg8zEthww5FlkHB
         JyeT5hzm/Dy+sZrGZahHlJ8kP07eSUEeQjtUipDLDAzlITFQwT55sHls1nkOEHLkHQx/
         Q9Ebhc0OaCF+unrOvODNNME05j8q3jEyWcWiyWdW/qYg6zpHffILhOWkXPivHWDpwlAg
         4RUA==
X-Gm-Message-State: ABuFfogX4q8vLwcgILIociBJQGICkFGMgheMog32Pf2buvWs11Jb7wzk
        QWE2kfLISaEH3cOj4QZNUAo=
X-Google-Smtp-Source: ACcGV61rgrWlL476NxV7/l9qrthAbmda6r78OmUxUeFxdbzIban5FjU2tIppbYKj/gRFNJ797NyXcg==
X-Received: by 2002:a0c:e2cd:: with SMTP id t13-v6mr5842300qvl.79.1537753298227;
        Sun, 23 Sep 2018 18:41:38 -0700 (PDT)
Received: from josh-ThinkPad-T460s (65-120-91-61.dia.static.qwest.net. [65.120.91.61])
        by smtp.gmail.com with ESMTPSA id o7-v6sm17537859qtp.75.2018.09.23.18.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 18:41:37 -0700 (PDT)
From:   Josh Abraham <j.abraham1776@gmail.com>
X-Google-Original-From: Josh Abraham <sinisterpatrician@gmail.com>
Date:   Sun, 23 Sep 2018 21:41:35 -0400
To:     hminas@synopsys.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        j.abraham1776@gmail.com
Subject: [PATCH] usb: dwc2: remove set but unused variable
Message-ID: <20180924014135.GA27711@josh-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a set but unused variable in hcd.c.

Fixes gcc warning:
variable ‘data_fifo’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>
---
 drivers/usb/dwc2/hcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2bd6e6bfc241..5f23b933cafc 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1328,14 +1328,11 @@ static void dwc2_hc_write_packet(struct dwc2_hsotg *hsotg,
 	u32 remaining_count;
 	u32 byte_count;
 	u32 dword_count;
-	u32 __iomem *data_fifo;
 	u32 *data_buf = (u32 *)chan->xfer_buf;
 
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "%s()\n", __func__);
 
-	data_fifo = (u32 __iomem *)(hsotg->regs + HCFIFO(chan->hc_num));
-
 	remaining_count = chan->xfer_len - chan->xfer_count;
 	if (remaining_count > chan->max_packet)
 		byte_count = chan->max_packet;
-- 
2.17.1

