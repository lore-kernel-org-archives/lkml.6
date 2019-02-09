Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7DDC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB6D21929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeIIX0lM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBIU7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:59:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53975 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfBIU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:59:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so9916962wmb.3;
        Sat, 09 Feb 2019 12:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5gsPuu7kp4vWr9AyZ0xebol6Mv8QrfZJckSkekStDY=;
        b=BeIIX0lMjejDOfcktbM69ANhNyOwTfJL3p6JuRqEQhs3C5IScmuEGGP/PXK8V5PypR
         j2PWgzT9i8xUGqtJOsk6iC6pSM0KL941u1uyPZiB3mJz70mBXZtxw3v7tJwmNRenMl7p
         xSZpQZgik//Op08nQNsXUBb7G7ofnKu173swXGroPXX83PbrAVR8f9WO8g1rVVHL9Fzc
         pASi5PiAli4zVPrEe0NzruJjhHHfMRoPhxwb+qNYSE8vGWCZY6Ey7fjimkNlL7ARwlJL
         3pSRWKJFYjd/URSSOq7fxW+1Dyq1axSi/7ijp70f7avnKp07cPm3Ev62OWhDSwNfrqUg
         t1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5gsPuu7kp4vWr9AyZ0xebol6Mv8QrfZJckSkekStDY=;
        b=uhi5kKwLv3WSN8b96tNISF/EfSAaUriF9qKLfOPQ/eaB0QG8C/am3FbSm0gxokyV0p
         MjInrwMXiX6VB64ADnZ6xoRJcLnrS0aD2J6YCbGnUDrpDawsvrSNwTN/gh3otua4hDlD
         TgPgFgIKbM28DoJYw3sYiUFJ/i/UHBHVA3JoiP7HBZYmtFt3AjiJGGThVjWfiPjsR4iR
         PMLvMmEQVbKg1JCyWIFCfT3d+O6O3SMkaf/dkkKl+HU1cNIkiIxriKJsRGrIbNtBjYL9
         /3TBGcLfnXUYZrPRSMiXAe+TKfhV8y+rDVVmcqiE+OkIoKuyygZYHRQh+jgYXTYHyl4r
         1rEA==
X-Gm-Message-State: AHQUAubs7+ZmVkhut/CP8K9mHP+uvhUgLVFRh7F+TLkBENiVO9rpvEky
        fBvS9180BkI8twVzo9IDgPA=
X-Google-Smtp-Source: AHgI3IaJzU9cx7beEMjlzSURJdlpS8DZNfnK/pM65vLwNlvH/+g3uWyo72BL48pCgWyQTCTv7BB1Fw==
X-Received: by 2002:a1c:cf82:: with SMTP id f124mr4006651wmg.95.1549745953420;
        Sat, 09 Feb 2019 12:59:13 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id q189sm5968232wma.27.2019.02.09.12.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 12:59:12 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, QiaoChong <qiaochong@loongson.cn>,
        Alan Cox <alan@linux.intel.com>, stable@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/2] parport_pc: fix find_superio io compare code, should use equal test.
Date:   Sat,  9 Feb 2019 20:59:07 +0000
Message-Id: <20190209205907.3770-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190209205907.3770-1-sudipm.mukherjee@gmail.com>
References: <20190209205907.3770-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: QiaoChong <qiaochong@loongson.cn>

In the original code before 181bf1e815a2 the loop was continuing until
it finds the first matching superios[i].io and p->base.
But after 181bf1e815a2 the logic changed and the loop now returns the
pointer to the first mismatched array element which is then used in
get_superio_dma() and get_superio_irq() and thus returning the wrong
value.
Fix the condition so that it now returns the correct pointer.

Fixes: 181bf1e815a2 ("parport_pc: clean up the modified while loops using for")
Cc: Alan Cox <alan@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: QiaoChong <qiaochong@loongson.cn>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
[rewrite the commit message]
---
 drivers/parport/parport_pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 9c8249f74479..6296dbb83d47 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -1377,7 +1377,7 @@ static struct superio_struct *find_superio(struct parport *p)
 {
 	int i;
 	for (i = 0; i < NR_SUPERIOS; i++)
-		if (superios[i].io != p->base)
+		if (superios[i].io == p->base)
 			return &superios[i];
 	return NULL;
 }
-- 
2.11.0

