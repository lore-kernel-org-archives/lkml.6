Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B47CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F6A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4/6qhsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F6A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbeGWJ5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:57:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38959 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbeGWJ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:57:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so760338pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=erk/KbvCvjjlU5yGXQ24Voz3/gy6gOLtRpvJgcibe1M=;
        b=e4/6qhspPVokcCO3dbifuvDs1lFf5isakuaugYVl13+Kymg+5FzFp/ZNlOfdCR1ZVE
         s0tJ+i/jDIkHiOLS+VktvxKkB8AE4EtS8rYHRE/jxymR2RS1DPOeVj5qTZrP4pFYYDXR
         P+oxKWp0XviSMt+uHIYFnHh94zfRij9AWyK4xyMxmdu/4RWjsNoC0zyYuHj6XsSHAkWe
         KpxzGUoEfmbupjhb3zObFrChxhLv75lz6H2UwV0ilL/aiFLT5qBCQkjhPEBVg6n2jqDU
         oae0ZtgZveSjp2byfLuidXjKg5eO+0KWTt/VL8UORHF73Kiy0EJQiEUcm8da7xb36dP1
         Pb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=erk/KbvCvjjlU5yGXQ24Voz3/gy6gOLtRpvJgcibe1M=;
        b=EsnsK7r1Og5kLOpf1fGlG7oUAOXpdpl3Br93Sm3+p8nDCi4XuA93SedYakOJRHVO4k
         oXbn440lLpmqMPV0I1kgzOEXyng+JAsrENIVre8YFtRCAJrvpMG7XQxh4wkWhGcgFaGq
         69gOF5Fm1Wdt6bu0JpfAKcDIDt0RLcGF5l6O1l9yy2XM2nMWzK7QZDNzqzpLKHuM4O9L
         yrnhVX+C1LI18LVrnDWXNYu03JLZ30SipDJhSzq0oWVhaEcpFmC82UWNwEuxOz2GTXHx
         AHng0Kxa0gU8OTA6hB+opaOK6lHYODf7ALzr6Pm0XJC0ZcFehr+zG1ee/tGV7S6HbWGm
         oSyA==
X-Gm-Message-State: AOUpUlGBGD0PLcEyE6hnXuvL9mtZjKzMEypK3Y/4C+Y5fefI/yJaccTf
        lJU1Wsq1FPloze5eJmpb3stjozhrGbM=
X-Google-Smtp-Source: AAOMgpewp5F1k9xl5SdxIsyj0SAodGtjQpVmeOYenQ0hl06P8fARW2hmAM5VwgKZDQSN6iWJFEPdkQ==
X-Received: by 2002:a63:2b15:: with SMTP id r21-v6mr11542786pgr.262.1532336212863;
        Mon, 23 Jul 2018 01:56:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-162-147-103.hsd1.ca.comcast.net. [73.162.147.103])
        by smtp.gmail.com with ESMTPSA id a17-v6sm13445119pfg.106.2018.07.23.01.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 01:56:51 -0700 (PDT)
From:   Yue Wang <yuleopen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yuleopen@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jussi Laako <jussi@sonarnerd.net>,
        Nobutaka Okabe <nob77413@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Mack <daniel@zonque.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Alberto Aguirre <albaguirre@gmail.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] alsa/usb-audio: Generic DSD detection for Thesycon-based implementations
Date:   Mon, 23 Jul 2018 01:56:46 -0700
Message-Id: <20180723085647.49537-1-yuleopen@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thesycon provides solutions to XMOS chips, and has its own device vendor id.

In this patch, we use generic method to detect DSD capability of Thesycon-based UAC2
implementations in order to support a wide range of current and future devices.

The patch will enable the SNDRV_PCM_FMTBIT_DSD_U32_BE bit for the DAC
hence enable native DSD playback up to DSD512 format.

Signed-off-by: Yue Wang <yuleopen@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 02b6cc02767f..06ae3f5adf4b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1443,6 +1443,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	 */
 	switch (USB_ID_VENDOR(chip->usb_id)) {
 	case 0x20b1:  /* XMOS based devices */
+	case 0x152a:  /* Thesycon devices */
 	case 0x25ce:  /* Mytek devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-- 
2.18.0

