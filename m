Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44FFECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE0E2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qN6KqwLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE0E2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeKIAUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:20:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42388 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKIAUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:20:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so8941378pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=L6Bv0QL7e5/lq3+5iv4iDqS+JLxvgUreI4/F7/Cuz9A=;
        b=qN6KqwLRCqJmXxidsZoYwc6atTNrav/LnMz+KJiPbh2Wy/TXA4Tbi/rqvA9W/xGd2x
         VkIxx1QmCBGNVGhW9I6XJ0DZVhfVXxOdMJxo8lG6RzuIDoWUZEASY4R13iRKiWUTZXiW
         DYSqz1spU89yNww1epa5dW93x0hDQdV184T5VojaPY+l4Ycz7rqknboLI+ppcIEWZCRP
         B3KoqNbMCus3l2BqGiuFIGixEqTWY9ME/yQuRR1yG+PtRMF4urV/oQbYzD+8/RKgCjJv
         wg9C73LUL5xMGEHIQ5Q8nYpZfQ7k8eC+B3VeizQ+miBiwloJZseqErgUoVZf/5ioVA6P
         re6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=L6Bv0QL7e5/lq3+5iv4iDqS+JLxvgUreI4/F7/Cuz9A=;
        b=NrS7Iqtd5CIF6qPVdR+r04OCMoQ1xVcPX3F3UnHbMThTonwWDFGWgRDtrX9JuF4UI8
         8NtvwkfbvFQUBd6pe3fFO+mxfssljOdWBpo/zNcIQyN5eSLGo3FLE+kXKXUSC5OxJTZ1
         8QV5p0ESEKuRO8IjkAzljMqwdXaA0uUB6sgSQMaVeS6ExfMm+c7b4LhJTiOJhBFKR/VS
         197hKGLVxFRH7Y8RxsCOpDP9YrtBxS+whICniOkFedPz0SGcyIbMA7BRbdGRJHjn6pWv
         tRlWAo61PKalgKUFR2wcdBT+dMlQH7sIGIEinYrdLfZXGOADwiueq0L4iokIez9ThbLX
         ASvQ==
X-Gm-Message-State: AGRZ1gLzb29gOCM4PTdVY3eYjVCRxJPb4LQ7yRENrZmPYau8o5KTZg62
        M4d3J1FCJblCASrDT463rwE=
X-Google-Smtp-Source: AJdET5cdeo0NKKN00YXp88GVmbAQph4Ut7Q872wMO9kqmE9xTUUock8M3iPHi6XmLUPy3hUS8s1Yzg==
X-Received: by 2002:a63:1412:: with SMTP id u18mr3911570pgl.247.1541688298112;
        Thu, 08 Nov 2018 06:44:58 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.60.95])
        by smtp.gmail.com with ESMTPSA id q76-v6sm6220887pfa.18.2018.11.08.06.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:44:57 -0800 (PST)
Date:   Thu, 8 Nov 2018 20:14:54 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     linux@armlinux.org.uk
Cc:     jrdr.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] arm/mach-sa1100/hackkit.c: Remove duplicate header
Message-ID: <20181108144454.GA3797@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/tty.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 643d5f2d9af9..0016d25e7deb 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -22,7 +22,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.17.1

