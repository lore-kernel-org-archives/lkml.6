Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E199C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF7eVhNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E199C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbeKPU6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:58:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41239 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeKPU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:58:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so11226281pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WTFdkNewQ4vLFWOGOIwdbq0bojgFfQMd/wSFy4A3xVI=;
        b=OF7eVhNQ4zYQHbXwyA3ROn2+tLZfolWompEeavgIePk7Lw/l6luK4Nw9rQ7UOlWpoa
         rRSvQbsG/5LMXJ+o1E2SJsel9uJtzvdZZMz7Vx6lOCZJq+oHmppppG3gxjgpx2anUTsr
         LnR/6w83XEZtA34jMisuXTU1fv2C7MCU1QAonnYaOWQBYNWm7OeptTX8tkkUVfr811OA
         BfTsHz1eKwvWvJ/Dz56PtX5m88a0rK/tdDAGmlRlljSw2OsoeNiTjcdcT8FMAQRCWcJ1
         bnhqVvN4bcvk1Gs9eBpuVxgdL1huKOUgnd1esRw+0d6sxXQPuL51g3ha4SZ68+ahfTFi
         8wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WTFdkNewQ4vLFWOGOIwdbq0bojgFfQMd/wSFy4A3xVI=;
        b=ijFOXsBuhcKOB7ekTnj7RtDY4Scmo9Y5HKlwr4PWxi4eFyELx3smstlz4XjycrL+pg
         rHrG/kGpRKj5zp3tc6s+UdNQNyK2M+YKIzu+/sN29Ulaq/GJQ4JdTLVX6y4Ix7spY8v9
         VSQ9s8GY8t+/bU+KEeF9P6aNip3DUXZtJ555zG2v/F5VlXnaOLfDnoioT26Zym5mBjim
         jXyPr+A2xDabmLBE/t8IBFTwLP0LxzzXVZUETwcE5bJx/hafPzyn21qdjetBTeH69vb2
         acTuu7ICoz+JYKFgupwZwn1vzUd+pVaGYoLfe1uCTuUR35VvtYKm1wXt0mSWAeLr5Tec
         brNw==
X-Gm-Message-State: AGRZ1gJk72zAqUBWUabiXh6of8wE8RM3dfgqBS3Sux52FlYkjcQqzChh
        TnuXsib4hb3HliED7RJrPuUP8x4/
X-Google-Smtp-Source: AJdET5dlRCakPImo4kZMXh8t5ZrGlauyqCK6/UqCKab/hLwfeHEFstkYuTFATtlrnTQyUgiFt4v3yA==
X-Received: by 2002:a63:a002:: with SMTP id r2mr9312161pge.212.1542365227410;
        Fri, 16 Nov 2018 02:47:07 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.99])
        by smtp.gmail.com with ESMTPSA id p15-v6sm53192948pfj.72.2018.11.16.02.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 02:47:06 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:17:03 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     benh@kernel.crashing.org, eajames@linux.vnet.ibm.com,
        alistair@popple.id.au, cbostic@linux.vnet.ibm.com
Cc:     jrdr.linux@gmail.com, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drivers/fsi/fsi-scom.c: Remove duplicate header
Message-ID: <20181116104703.GA10221@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/cdev.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/fsi/fsi-scom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index df94021dd9d1..81dc01ac2351 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -20,7 +20,6 @@
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
-#include <linux/cdev.h>
 #include <linux/list.h>
 
 #include <uapi/linux/fsi.h>
-- 
2.17.1

