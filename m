Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D97ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDCE20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ+bRQIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDCE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbeGWJxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:53:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37120 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388101AbeGWJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:53:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so11775500pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/JyviaccfxnxTZu8g+CSwc1lVwmTWp0y+/Z04ozHOws=;
        b=hJ+bRQIQICQMw8rO9Ecwm9p14hvh7FXoxR4Sm5V/kNWzHcSAW/ce5hHGYBL9uF3UTt
         jwvs/AYAlR9GO1PyVOEloTZJtVwNjPrwAX6vUicDUVH+yFvF1DxmVjBYH6xSKrbjA42f
         csBQm1ok5t59Ca5ZH/sTipdZgF++zmSyyHVNTMHWYAdizGcZgKWH+j32yEy8LTJVNVMk
         AjQUl0qcnCiRNUvW/o3uu7y803E54jxB3hEMYTstQvPgpseAWIiqIu27CflW4cszLRL3
         Wg3lpE5mXA1ymb1nUvLJ3+feGS4QL9yecw2ApVyxUFjVgiwgubpaYETEjS0VDOsldeDk
         0M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/JyviaccfxnxTZu8g+CSwc1lVwmTWp0y+/Z04ozHOws=;
        b=UYgGzD80d8fg88k9Wy+PdAtFmHgqhKzh5TEkqGr8TrIYXjBmSnBbpheTGAFZRaGnFT
         J1npJwu4ClM8B85uhOn9FP46dfHIbuJTLTqRaU2Z+r1OZhe9BnhFuy917xtolUGxtSuJ
         p3KlySoAIQsaiBXnWbSEN5QLqrCxiNmoczRq7UiKkhxeovQorYbrI2TOJmUeD/AjPORv
         DVK8Xt6fUJUam1x1m+V9/aAHXyH+U748ZOGcSwwcwqFw0TKPeWkXwt8KdtyILyMWocPb
         Clr7h1XA0drjQyZxG4asZT2xW16oY98fDTjhRPZh5wfjQU2LWbwECNnYz/NM3mmCb4Lr
         XUJg==
X-Gm-Message-State: AOUpUlET85JThfIKymUfjyrcm6+0RBe74pe6SPt1i/HZscnYf9SPab/n
        XbhFyYmPUH6bgqhO/zCPSBw=
X-Google-Smtp-Source: AAOMgpfQprerSqV8GK+FUCzTnHFsyKRXxShwMkZsft8LAPRkVYlDL/+YuOroX2BhO2WQw3WBy26BNQ==
X-Received: by 2002:a62:a649:: with SMTP id t70-v6mr12397535pfe.149.1532336011895;
        Mon, 23 Jul 2018 01:53:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-162-147-103.hsd1.ca.comcast.net. [73.162.147.103])
        by smtp.gmail.com with ESMTPSA id k128-v6sm11670522pgk.4.2018.07.23.01.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 01:53:30 -0700 (PDT)
From:   Yue Wang <yuleopen@gmail.com>
To:     yuleopen@gmail.com
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jussi Laako <jussi@sonarnerd.net>,
        Nobutaka Okabe <nob77413@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Mack <daniel@zonque.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Alberto Aguirre <albaguirre@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alsa/usb-audio: Generic DSD detection for Thesycon-based implementations
Date:   Mon, 23 Jul 2018 01:53:25 -0700
Message-Id: <20180723085327.49134-1-yuleopen@gmail.com>
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
index 02b6cc02767f..c51e2dee3075 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1374,6 +1374,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		break;
 
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
+	case USB_ID(0x152a, 0x8750): /* Topping DX7s */
 	case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
 	case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
 	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
-- 
2.18.0

