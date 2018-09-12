Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943F5C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3AF2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JR/GwVgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3AF2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeIMAu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:50:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36313 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbeIMAu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:50:58 -0400
Received: by mail-io1-f67.google.com with SMTP id q5-v6so1234108iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gU0Xw9xYPd7fvW2y/9a178olu/xNhZC6qCabhyWgBjI=;
        b=JR/GwVgMP3mFwh7UZrSKhsv8er7TnMgCpHwdzKrUCEgec/7EqG1xD9OV6oj5ldcpsB
         0kvIw1cd1/CFR3omvZM+HhhSIhglH8eZSxbsjhZ2t8Bv2UTgX9nBTzIQ9UKiS8I1ff0j
         UFZELpM6ngKDi6Q798SUvFyJRDo5ytVsl8NoIEYSB8BgVD5OFS9o6ZHcB2kJkfZsFugm
         WRi8zNCCv9xTB4nABPcMCNN8iiPqB3rDF9X6SuyvhP6Zj9I3WOUXxZaLaC5Uve4gw74P
         EHPXX7lpI3zJWLIkJSRGtHoPo1SFr8siVXjYb0gRlt8odwvtW+G7vaebRqN9G7ZwXVcL
         FvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gU0Xw9xYPd7fvW2y/9a178olu/xNhZC6qCabhyWgBjI=;
        b=I+mx5eMCleK8inEWpTuQ1vBh05abvmV98QY4M8KeiV+Woo1gbraUi43f3k8naOwIMs
         35KIK3G5e6lz5euoyDXRyQIbmRCLL6SLamloIgHPCe01Oy/eij0eAPpucqiBM1pi2cra
         PNxWJFSt1psyEnOeL3yPsf9Z95oXVB4hOLTaM2CVD0uflyMqGvrQiMixzwgCSK+Ikf23
         M7ihy1rFVfFp14427oP65WclKjWD7JOQES+wxi03WCAaD0XeSNNj0GU8ouxW1FXZ6+3s
         mLnhn7s0EqIVWmRIYS4PsuhucpARHi2uUyKtK7zgblLgE/tLzVZS3hdgXWt0sz7I5XLr
         MLXQ==
X-Gm-Message-State: APzg51DERDu9cjm0cvk00LF0JNoGPKtpU9uuGW08GdhtCJJF4DfU5WrZ
        hvomXT+n/qqBCvsa3a/u+9x8+g==
X-Google-Smtp-Source: ANB0VdZNV1UllZkGk9aksWZBwrNObr7kYSYGkUZdbzMAN1sBtrKM2MFkrTv9mSzYGMff+KfN2nkVRQ==
X-Received: by 2002:a6b:b7c7:: with SMTP id h190-v6mr3466844iof.164.1536781495042;
        Wed, 12 Sep 2018 12:44:55 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id a14-v6sm575845ioh.45.2018.09.12.12.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 12:44:53 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Vinod Koul <vkoul@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ASoC: enable interrupt after dma buffer initialization
Date:   Wed, 12 Sep 2018 13:44:41 -0600
Message-Id: <20180912194441.200564-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180912194343.200443-1-yuzhao@google.com>
References: <20180912194343.200443-1-yuzhao@google.com>
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

