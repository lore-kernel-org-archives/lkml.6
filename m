Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C25EC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A82F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGesUx1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfBTFSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:37 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38158 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfBTFSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:13 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so12642750itg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8knuUgR1kA6CdUlUKLzOMqBZzMGKE4OzQ+ZM0NplKOI=;
        b=CGesUx1YRJkJeJX34wnGZ9BPtpWadCV0MfeE8tkoiMaHrjzCc8cJifVa4+Y84amrCh
         MiC+umlaK7XEndlGVly6qP1Q4Mh6P/p7PW1Gxw1tojILgvxazaHVPZM/eDLyVaFyBObZ
         cSN2TVnci+A+UOkGEWxY+xf0tpX79eP16dRhHvMigjgUpNUtgnjzko6w2KxYyslOL6lr
         hoHr4FzvV2WFNXaXkl0vRvJGGCCcc/L+htNhHl5np3e+7YxpOdkNf8xTe/ZVSdW4K54g
         7Ap6dVUpD4s5CZct6EU3y/Tzh173CfTYGpxrtJTEC7+jjgnIPpsnuEx0k2i3cmQbUvtB
         DLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8knuUgR1kA6CdUlUKLzOMqBZzMGKE4OzQ+ZM0NplKOI=;
        b=gvXpzlCZ5cXOhQIiqc+OqXa2T4tFHikgWUG202mAHZy7hJOKkLpzJK11zWJKMhxPRt
         UsgwXTKXMm1shdzPPkophEJkV7DG5KKHGfDtsMZEijPbyWY3M1ni0KVM6YsSZaq+lgHG
         rbC0PlRQc92rwN0vMcoBf6d5ilFXNGFvBCfNZ/p0hLbqL+vYff2xCgaYvjiscimr9aUh
         c9/wiAVl7j+iwIxMy4bdnYanBAvmBo7WQjXhlt70mnM+1t+a2dkupFXNr9sNGk04r0OY
         JEcYBI5HL+GkCOyCncX6AvxPAWlEas1I1W3dZMGHYVVYrQxTwKPf98uchbs1nrVOQ0zj
         yQ6A==
X-Gm-Message-State: AHQUAuY0CF7VcqNPyjpg9ZFb5yME6Vldwy+04CkmOPPnrZrqBAEw017b
        qyi+RM4Dbv+gj1rpV5bcUnM=
X-Google-Smtp-Source: AHgI3IZzCQsZLvj7Y8XzgV8ciKK5yeTmrXJWKe8cUWMKZ0tWYBgHP9Ryalai6LAWz0z3rpNyhZxF5w==
X-Received: by 2002:a02:9f86:: with SMTP id a6mr17338661jam.87.1550639892549;
        Tue, 19 Feb 2019 21:18:12 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:12 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 06/10] staging: mt7621-mmc: Bill the caller for I/O time
Date:   Tue, 19 Feb 2019 22:17:50 -0700
Message-Id: <20190220051754.12195-7-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When waiting on completions, use the _io variant so the caller is
charged as using I/O.

This should have no effect on the module's functionality, only improve
CPU accounting.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 97ed7510e96d..f12f9d6611c9 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -494,7 +494,7 @@ static unsigned int msdc_command_resp(struct msdc_host   *host,
 	//sdr_set_bits(host->base + MSDC_INTEN, wints);
 
 	spin_unlock(&host->lock);
-	if (!wait_for_completion_timeout(&host->cmd_done, 10 * timeout)) {
+	if (!wait_for_completion_io_timeout(&host->cmd_done, 10 * timeout)) {
 		dev_err(mmc_dev(host->mmc),
 			"%d -> XXX CMD<%d> wait_for_completion timeout ARG<0x%.8x>\n",
 			host->id, opcode, cmd->arg);
@@ -697,7 +697,7 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		msdc_dma_start(host);
 
 		spin_unlock(&host->lock);
-		if (!wait_for_completion_timeout(&host->xfer_done, DAT_TIMEOUT)) {
+		if (!wait_for_completion_io_timeout(&host->xfer_done, DAT_TIMEOUT)) {
 			dev_err(mmc_dev(host->mmc),
 				"%d -> XXX CMD<%d> wait xfer_done<%d> timeout!!\n",
 				host->id, cmd->opcode,
-- 
2.20.1

