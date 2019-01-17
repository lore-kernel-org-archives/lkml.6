Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5F0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2924E20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhq0zpy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfAQQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:10:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37465 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfAQQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:10:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so4957884plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=+tNCWTeDwzAR3YkgECYwqVXsz06QLCwhxiwZmg0mLHo=;
        b=nhq0zpy7CVbt8BtUMsl3SFOh9hobIjopS1v8B8UGdfNfXLjGDT76Vfa3z8aSOMKXYe
         SHFIfoPLtXPy9k1drVLx5zsPxmmA/bvDJt8Rv8TG4PAO/gwTMGijJRQLreRIWMVwJWG7
         Uhby+UBLk3kzTiZaKirq+f9n17wwLTcqaLD7nR9US+mbm4M6OWtKFdN/SmIbASyfxf9/
         aSdMlZ/8wnblNos5jsgKnOzL2ue1rdydzRhkeuXmGVIh1ngiuiZoiWvPtMciOlUFW3zb
         mhZKJGoxB06D7hEQXO2phMnJL2qsNdKXLy4CkHkgnqpG52jNki5N2pYuXh9PnLHser+9
         EPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=+tNCWTeDwzAR3YkgECYwqVXsz06QLCwhxiwZmg0mLHo=;
        b=Z0Vvft1q7X/Tcmc8irIhh3B4Z09u6mKbAhzLlEDlO3QqfJpEW70SnGwxd44TAcXG83
         4y+nOzswS7w65ZXwpPLXctv95P5INr4O3jv6fGHCnwFYCjHcbZ6zXvGduoGdFg3Xb9S8
         tZBtByKOhYvWJG3uOZ3QsGDj/Zwan3a1ko/QXoIEM1HZMsvVqU0YwGQAmIak7ooLlFoH
         zD1xuwSV85eo0FTiwMnC8CGuuF2LWPfljkPrBAxcqnSi2mnOgbFaC15ptLx1yZU3BCeo
         fund/8pxTAUQfGa6UPbqdBuu0c2mMEvyR+Qm7jD5GSk5oX7WxPPDz1/9VMgYrvpqTFL7
         YM+g==
X-Gm-Message-State: AJcUukd2PE3AnNMDRGFYB/fbPptEpBbdlaI8nmIp4Z6H6bNoinmsiwte
        IUiNc4slyYJy9lGFD6ndJYs=
X-Google-Smtp-Source: ALg8bN7kFkfPViNgA1x2DGpCEn7e5448U+Rnj/+2QUhCifWghKHeJbACGlJFWV9SepnpHy4cUIffAg==
X-Received: by 2002:a17:902:12b:: with SMTP id 40mr15311747plb.72.1547741438424;
        Thu, 17 Jan 2019 08:10:38 -0800 (PST)
Received: from sabyasachi ([45.116.191.230])
        by smtp.gmail.com with ESMTPSA id l184sm3859384pfc.112.2019.01.17.08.10.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 08:10:37 -0800 (PST)
Message-ID: <5c40a8fd.1c69fb81.e4b1b.8f85@mx.google.com>
X-Google-Original-Message-ID: <20190117161032.GA22958@sabyasachi.linux@gmail.com>
Date:   Thu, 17 Jan 2019 21:40:33 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        npiggin@gmail.com, msuchanek@suse.de, haren@linux.vnet.ibm.com,
        oohall@gmail.com, bsingharora@gmail.com
Cc:     jrdr.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] powerpc/powernv: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/printk.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index beed86f..802de0d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -26,7 +26,6 @@
 #include <linux/memblock.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
-#include <linux/printk.h>
 #include <linux/kmsg_dump.h>
 #include <linux/console.h>
 #include <linux/sched/debug.h>
-- 
2.7.4

