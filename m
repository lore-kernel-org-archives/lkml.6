Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3C1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2466920855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ga+QVnlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2466920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIKCR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:17:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39240 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeIKCRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:17:55 -0400
Received: by mail-it0-f65.google.com with SMTP id h1-v6so30695879itj.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wk+6ffpnHdc0lzFq+O02sq3Vbnscyt3DSG/QITMKIW0=;
        b=Ga+QVnlzYVYAI58UlxCh+JXSmi8vljYO+0UTFbdC5jOuLwHzTaaUtlw9cJPIkyi78I
         IGc59owbrDwW0aZhXu2ew4s1V66rTw5B8HJ/PEqJ0PjqZ9ejLnWJU8MB9IxnQKlCzus5
         dT50JK6dwMi/boCIqwyKeUagzyGXRoc1p7MWfzdxP1Q08TBIU+JCpVErDJI/0AU0hUbv
         UZb6i94g5LRZqVZ2l4zw/L3DnRY5KAESur2y8Dlf1wmtmKG6jjFqAUp5GLC/1vfrYRbt
         fXgk5Apmcd/FV40Ozp7ZF+kiEpDCNw7kazuov6MZfNp9C9EDo4rwG4j8bTZLSyfJCnMO
         U09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wk+6ffpnHdc0lzFq+O02sq3Vbnscyt3DSG/QITMKIW0=;
        b=H0P2sOMb/zvmm2AbBgyv9eQsZ2Fp+3/4f96Cbp/mlPopVCZdgpsNftKpx1Tf/FR5yu
         mLgzIoBZwDGuYuY3zvVFZPnYHFl3+apSR6TNcZ179LtBMUU+wOkPHmPpVvDcLwzbGP3C
         PKwMoANyomQ2SoCvCkc/YjJ/5rkZzmGPjm3vexHKhOY4X/5JgIPJzqrJXdha8TgAsGTr
         D17nKvytLPVMMGpejr3VMcbsLCRUeW4i2brKUmeE3nspm23kWXvIg6BKxToLZw9nJAO+
         S17CPnCEwrWAL1Am1fd3Jsh9b44GEXUQKJlmenUZst34Hqy4sDHxl0ChtrDRUUNAJxJZ
         ldAg==
X-Gm-Message-State: APzg51CwEkxtmaOAZLO//cPt8EwMXT1wq/YKLo4Synjjg4P452g2Zpis
        AEkocjLqxuNAJuvyEP62kr/+Mw==
X-Google-Smtp-Source: ANB0VdbiTBNOZQg45oMfKDTxNc3WF7OtIEQW2qISHiTxdtd0XqH5b3wmzkn8lty5ayJVWNZd1Hcs7A==
X-Received: by 2002:a24:6e52:: with SMTP id w79-v6mr1666688itc.0.1536614515975;
        Mon, 10 Sep 2018 14:21:55 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id g129-v6sm8189649itg.16.2018.09.10.14.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:21:54 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sound: enable interrupt after dma buffer initialization
Date:   Mon, 10 Sep 2018 15:21:50 -0600
Message-Id: <20180910212150.202655-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180910211718.200802-1-yuzhao@google.com>
References: <20180910211718.200802-1-yuzhao@google.com>
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

