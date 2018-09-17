Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFA6ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988EC214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxEMue/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988EC214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeIQSG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:06:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44776 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbeIQSGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:06:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id ba4-v6so7366084plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8NUYuCYaCzDeRPUgrtSpdxrhLgbqeQc5/GPywkozWpY=;
        b=mxEMue/nc4s0ny6awblHLIfXYl92wdlrjS1VWpbr9wsYz3PwNJp6to3pgNHGK9DlXD
         UMTzo0TIZGoZeGfGSBfxGsYcemsJJ+WQrU2sduMeNXeiGv8Hgo/UoB3K/w8hfG3PeDSB
         VzEOenJJoPLkdpoFUXsP208/262qd9cpvvy7y9i6Sjo8BCzeFpsjyY4ZgrLXJR5LGkOh
         lsg+l44WP5q25hvkud9Okivj6QldQUuJiCvVThQaoVfaxLjuhfjWhmN97ox4dtp4m3rt
         ddZ5IiS6yJ3DK837MPsYYMd2S538XBMXy5qyY6gGKL2ke99G12mKC+lYNIZ5ssic3f5Q
         sWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8NUYuCYaCzDeRPUgrtSpdxrhLgbqeQc5/GPywkozWpY=;
        b=bKAWiXnWkL4hU/YqCAJavurpLVtE3Rp2gYG1zq7HWNyiOBZY3r+28sDTtJo+ugSr7J
         xHOc1g+QKuOub2bzgsW1CMkMHBGZw5UGrH50WgA0Whr2qXjaINyT/74EY5ag9dqQwJLo
         UVezO7dAmVxfFgd+70gEfqynLef7UwS4cFiR6eA40NpZZR+iTZGbG+29BEQse45j3EIq
         CNj5xp/byoX7ao/N3lAGitpHvMAYuc/SJR/Z0ap5RV9qq9Z+BsgdXUMXHmSgWGZhYlpy
         JsxmeOU1NIZziXCdyTJxPwvge+SiHJchtj+f0q6ID+xNPtoBKcckM2RRb+07T+Zye4Cy
         68vw==
X-Gm-Message-State: APzg51CrmYIY8gvnDfAYLfSPqs9SPxof0uu1+B25Vyx5AzyMkd6akoin
        YANGJIbvMx9aIMcVVH+K7aE=
X-Google-Smtp-Source: ANB0VdZs/XiNAJZTz0PEntY+YX1RCVi6deNLCiHGkRVMUp8P9XdXSBYnLMy7+Ao9U2Iqg4wlnMjDzg==
X-Received: by 2002:a17:902:b702:: with SMTP id d2-v6mr25002133pls.12.1537187985662;
        Mon, 17 Sep 2018 05:39:45 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id v22-v6sm26960020pfi.60.2018.09.17.05.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 05:39:45 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 02/10] staging: gasket: interrupt: remove PCI-MSIX-specific status check
Date:   Mon, 17 Sep 2018 05:38:57 -0700
Message-Id: <20180917123905.213639-3-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917123905.213639-1-toddpoynor@gmail.com>
References: <20180917123905.213639-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Devices not using MSIX don't use the msix_initialized field, so don't
require it to be set in the interrupt system status check. The general
check for interrupts configured that follows can cover both MSIX and
device-managed interrupts.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_interrupt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index 2cd262be65ca0..49d47afad64fa 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -478,11 +478,6 @@ int gasket_interrupt_system_status(struct gasket_dev *gasket_dev)
 		return GASKET_STATUS_DEAD;
 	}
 
-	if (!gasket_dev->interrupt_data->msix_configured) {
-		dev_dbg(gasket_dev->dev, "Interrupt not initialized\n");
-		return GASKET_STATUS_LAMED;
-	}
-
 	if (gasket_dev->interrupt_data->num_configured !=
 		gasket_dev->interrupt_data->num_interrupts) {
 		dev_dbg(gasket_dev->dev,
-- 
2.19.0.397.gdd90340f6a-goog

