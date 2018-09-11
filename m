Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425ECC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE1920881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1RDLgWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE1920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeILCP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:15:26 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40279 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeILCP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:15:26 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so198948ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gU0Xw9xYPd7fvW2y/9a178olu/xNhZC6qCabhyWgBjI=;
        b=K1RDLgWAps7qOrJ+L6wy9hFQMqFqEXfBn7q0JdXZ0RZPT+Euq3uRwwvRD9GTslzo0b
         kZNEynKLo/cusHAcPUWX49rjkX6nbLcT7KiC3cG488lEWOA1hRX8AQPKEpoFD7VhwUcz
         /V43yECrECpUoz53SJNAKWeyiaei/k+VyMNJONaorQK3dLLUHNfOfaXSjTxORMde23VQ
         AG5XHsPM9uVvfYkyAOdzZLLanNZXipx5An7s5XJfvrCIV84ALDjwYXR9APpdcKpxwinm
         9YQCu+ru/wplbWrzDnnDuwTKW6qwF4F7UxmxOWmSXbosz8jGmv+Ta2JaAl5QDpuA1jCz
         s+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gU0Xw9xYPd7fvW2y/9a178olu/xNhZC6qCabhyWgBjI=;
        b=a1mx7+A0hop6x3Hq36x9+9hmP3zoqy72ex4/4ORfJAMUmTkvSNHK8Oo10ET5QEsRgf
         Hmgs7f110A1xZcg3W1nff/R0DgCxWzaaE750kxDttlKxgYV1sXL3EizCczfFiUa8Ty7m
         qQBgIbygP7iiQnbS1OeuIeVOe4ro1KCk9KC8zyTNFSac1ibo0SuUmZPN5VusluaDs6Tl
         YgmvpBlwuVQUywWd3vwYoHaLo83Fu1eG+zH/i2GwGB6TttmWjJzYXtr605/Uzy61y/tz
         34FjLfuYNIsdtk5s5NjTzJ04ER/K4YWe1cVPTYhJA0ufec4I710yCZVOOEvNDtZpQe7E
         Xopg==
X-Gm-Message-State: APzg51CE9FVbhOSsIZBcum9ZuMjRFaVV28IJbzAhCaWl2Up9nHbpgbvM
        3pWtTgfQ2XdzUu2InLLODyjL2Q==
X-Google-Smtp-Source: ANB0VdbFTDFroSdz65NIO6f/i4uknFHauatXvNgZ6aYYKZEAtHlHn9sYF0fuHAZFREl8+Q7ZQQGDqw==
X-Received: by 2002:a24:e44a:: with SMTP id o71-v6mr3131010ith.124.1536700456583;
        Tue, 11 Sep 2018 14:14:16 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id g10-v6sm6830476iob.88.2018.09.11.14.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 14:14:15 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Vinod Koul <vkoul@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] sound: enable interrupt after dma buffer initialization
Date:   Tue, 11 Sep 2018 15:14:04 -0600
Message-Id: <20180911211404.32178-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180911211246.31914-1-yuzhao@google.com>
References: <20180911211246.31914-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_hdac_bus_init_chip(), we enable interrupt before
snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
been acquired and irq handler uses the dma buffer, kernel may crash
when interrupt comes in.

Fix the problem by postponing enabling irq after dma buffer
initialization. And warn once on null dma buffer pointer during the
initialization.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 sound/hda/hdac_controller.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 560ec0986e1a..11057d9f84ec 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -40,6 +40,8 @@ static void azx_clear_corbrp(struct hdac_bus *bus)
  */
 void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus)
 {
+	WARN_ON_ONCE(!bus->rb.area);
+
 	spin_lock_irq(&bus->reg_lock);
 	/* CORB set up */
 	bus->corb.addr = bus->rb.addr;
@@ -479,13 +481,15 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset)
 	/* reset controller */
 	azx_reset(bus, full_reset);
 
-	/* initialize interrupts */
+	/* clear interrupts */
 	azx_int_clear(bus);
-	azx_int_enable(bus);
 
 	/* initialize the codec command I/O */
 	snd_hdac_bus_init_cmd_io(bus);
 
+	/* enable interrupts after CORB/RIRB buffers are initialized above */
+	azx_int_enable(bus);
+
 	/* program the position buffer */
 	if (bus->use_posbuf && bus->posbuf.addr) {
 		snd_hdac_chip_writel(bus, DPLBASE, (u32)bus->posbuf.addr);
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

