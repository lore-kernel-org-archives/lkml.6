Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A27FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF092084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsrN+Ps9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF092084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeKZGjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:39:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53582 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeKZGjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:39:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so12885789wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 11:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jI8lH1YQu0aQOWROpZ0vzfQ/xDoIenqwliY5mvM9yjQ=;
        b=EsrN+Ps9U2obVi4yTpseE0EpJMty+OfdIcxk4lorEaHWzc81YuZ7SnSRVhQOsrL2q+
         pVSLw2vQAb4zAazsXCE7rBE/maJf8ZWyMyCWrNwUf8uEobdnGGIIvamUZ/JPmF9pQzyi
         oHsqLqVmNl8fDoikJg1Gl+tgsDUNrC7oW0OtBZoN+RoxtRtfQc/ii+EaUfxzg8utKNZo
         UgHYcOhOXrdm3GWGM/gNREjXqWVY9eWxlBTTGqlXJ0i1GhWQHUsSAAZ4QmeeHzEugimC
         z5HJvymgH1jrFlwgLjuNXn8brkpStD3sgsV1E84VOOnP7ahQkA43qcWY+rb1OiUwVDHm
         ZuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jI8lH1YQu0aQOWROpZ0vzfQ/xDoIenqwliY5mvM9yjQ=;
        b=N0bGMLwuwpX0EpUPBt009W8YCWRdfREBLJVZDkiD4yDvtkfFRJTKe5MGbuVetPKJKt
         1oWvPlY/Wb56Fjf2N0pXlruFy/YVt165D2kBx+XnlL1KGvySVH9s1C2musKH5uH5shzp
         uxzifaH+b3iHFCzVK1uCzCbXYGml6eYUv+dJdiyauSG5x83rV/k6zbgCGQx56i5Gc5Qr
         Zn79lvdpXmubbGWrXyQ56TpwWiTMtTu4DVQPDXyqrKxvCWtmYPcsJ6cM2XuLM8uMcBXk
         L1m7JPCVkgbbNRqQFgMa9QjgaEPgOb6ef7CG8iUPoyy75rUfXQM2Noms11X6z02z8uAt
         V5QA==
X-Gm-Message-State: AGRZ1gKh1Vxfe4f6nndCxxIL8doQqCexcl35PoT9W+McpMWSMORE6DO8
        ytO9tG97U5Tbu2ZrxnTssIs=
X-Google-Smtp-Source: AJdET5cNOo7FY6xdl5COKdc7YPMaFAtDdEp69OOkesTIGt3467fE6gGRxXWm4EnWW+zNbqWGPR6Rkg==
X-Received: by 2002:a1c:d1cd:: with SMTP id i196mr20848552wmg.107.1543175263012;
        Sun, 25 Nov 2018 11:47:43 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id y138sm15744436wmc.16.2018.11.25.11.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 11:47:42 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/6] char: lp: move trailing statement to next line
Date:   Sun, 25 Nov 2018 19:47:33 +0000
Message-Id: <20181125194737.5591-2-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
References: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch errors for trailing if else statements.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 7b15272c0510..65bf32244f48 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -223,12 +223,15 @@ static void lp_error (int minor)
 		return;
 
 	polling = lp_table[minor].dev->port->irq == PARPORT_IRQ_NONE;
-	if (polling) lp_release_parport (&lp_table[minor]);
+	if (polling)
+		lp_release_parport (&lp_table[minor]);
 	prepare_to_wait(&lp_table[minor].waitq, &wait, TASK_INTERRUPTIBLE);
 	schedule_timeout(LP_TIMEOUT_POLLED);
 	finish_wait(&lp_table[minor].waitq, &wait);
-	if (polling) lp_claim_parport_or_block (&lp_table[minor]);
-	else parport_yield_blocking (lp_table[minor].dev);
+	if (polling)
+		lp_claim_parport_or_block (&lp_table[minor]);
+	else
+		parport_yield_blocking (lp_table[minor].dev);
 }
 
 static int lp_check_status(int minor)
-- 
2.11.0

