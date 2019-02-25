Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6149AC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3776A2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM3xp0yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfBYTWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:22:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43023 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfBYTWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:22:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id m10so4924087plt.10;
        Mon, 25 Feb 2019 11:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H1seWcg78SKvCTvDVwa71qe5SIaY4AuF9iAmII/R9XM=;
        b=jM3xp0yjoVMvDi1bjdJqa9XBrj5xIWo0zDFvdX3r3WhnZICzKhgZpvMAT1jBrWR9zo
         h4y2LN27T+W8+xdNgUaJht+bwozHBPQ0QdjjAPzWvkGL4sw+vxHTubpAvOqj/+ayAQnb
         9wL3w2tJE1mFomXpZPQASGobbVkSiA6WaAkI6p5vbh+J3uMBjUcFwE2QThfiUOHCmVC4
         Eq+ymY3ie2nOYQ7v4fJzIS9C5ZpDDgcXkuLEjv0lXFXENyKcRXhyjTzw7iNi4uwi8B39
         u3U5+t/wwCUJg208a0cZA36co2U4sNrqwMJVnMpAmtOeJw0aHf7xjRoMJz5B5gPrK1Vk
         ep7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H1seWcg78SKvCTvDVwa71qe5SIaY4AuF9iAmII/R9XM=;
        b=lR/amxvPlJFb24xIoUnFHCh7hmsBUCKLhvlZO6nTMvMVwt/22L0RZM8wSEkEBbkirH
         p0k0CGWe6oIwp1Ue9iGFlTJOE3xfEiLAUB8qyNS9kAUXVrlEgiRUg13zfbEBD17pu0L2
         dugu58KJGLmAlFanTG2nCGf3YOIvm7hLPPV8qjYv9bSNdaCYWDh8O0UZD/5U19p5F0UK
         j9ioSyRIrcArpzzyEBBGJvOZrkucagt98wvicZivRbDd8hodxQ/mKmSdJhnLfYs0hDyg
         hgRGOqDYplgdgdhJNfFiN1nUau//kocqXTPVnqIaJlYNx20lfS84UV+GieeoT/zkpPqf
         Fhpw==
X-Gm-Message-State: AHQUAubafI3XSOtU+iQ2+0qgX4VoYZsNzQ7J9Hc0+3LbrdyJbuyxcsxA
        +vx46d0LBtBbtA3naSze4/A=
X-Google-Smtp-Source: AHgI3IYqVp7mOKHsypmKgiStdEIVikQd1ZnUaiTphelVf42PcBzwbYa7uQYSGSi78jUodgXMAaptoA==
X-Received: by 2002:a17:902:850a:: with SMTP id bj10mr21767250plb.91.1551122536120;
        Mon, 25 Feb 2019 11:22:16 -0800 (PST)
Received: from localhost.localdomain ([216.13.234.27])
        by smtp.gmail.com with ESMTPSA id a19sm13054413pfo.52.2019.02.25.11.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 11:22:15 -0800 (PST)
From:   Alamy Liu <alamy.liu@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] mmc: cqhci: fix space allocated for transfer descriptor
Date:   Mon, 25 Feb 2019 11:22:13 -0800
Message-Id: <20190225192214.3881-1-alamy.liu@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is not enough space being allocated when DCMD is disabled.

CQE_DCMD is not necessary to be enabled when CQE is enabled.
(Software could halt CQE to send command)

In the case that CQE_DCMD is not enabled, it still needs to allocate
space for data transfer. For instance:
  CQE_DCMD is enabled:  31 slots space (one slot used by DCMD)
  CQE_DCMD is disabled: 32 slots space

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Signed-off-by: Alamy Liu <alamy.liu@gmail.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 4cc7863c13..974997b6cb 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -202,7 +202,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
 	cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
 
 	cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
-		(cq_host->num_slots - 1);
+		cq_host->mmc->cqe_qdepth;
 
 	pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
 		 mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
-- 
2.17.1

