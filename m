Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3E9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F174F20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpBcYXtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F174F20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbeGWJCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:02:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41047 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbeGWJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:02:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so11696878pgu.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZRDlAXi838hbo9cS2Rej0Foh/z9W6XsUJlqjyBzm1AQ=;
        b=YpBcYXtJPiP4fOA49Pof8uN4BXsQLHrIT/NVZ8srSYCTEM7oRHiBaxJv/2TimKXD8b
         dPhnoLVu6/fyL9K3wqF+M1W/HLRk+PnR5Pi1bdNE+VRWWfykodZwLHFoyZHLuGAOiZnY
         BufVDYtCIXP/61URTL8+B5Cr+wgs7Rp2cWi/gOMpOFgYMrsaLAAe4jm0BIjvK0SrAx0x
         sSJfpBBK43zskyGB7XdhqX1PvFW6eanQcAffYlGgIZK/FT15rp69d4Nb5/h4maL6MqXt
         9AIgBAqsi4cIkD6EgvfbrGHvqO5Od4MLXrtDCWBpoU+Zsw99gEGCPvg84wQ86ibn8B5T
         3D/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZRDlAXi838hbo9cS2Rej0Foh/z9W6XsUJlqjyBzm1AQ=;
        b=ZS3cCE18QdKfZVjpFvFZOKzgyBgv034MhOspocqrqDCL0RAVTk1gHvtG0xy1nDDBHP
         uH6tzAILryp/hIY4fYSgWbpLDpsgMU9Ne3qfNiU4DG4knK4ENoQ3mqiNH3H9OqtC282z
         vFg+HFBlazGRhr3+v9dcJuE8Nw0ynP8PzUAHQZ5ExZMMU/J5y3vx1aZo1BORMgvdeDZ2
         jgmiU39JIUa7FnjYv6Rufvg5mh5FZ4D/EuI+7ZxGKEf4SHBM6Ai5dYnblxP5iGKBHMHP
         36kiUnbesS30M8QwGijmMx8ggdCsnlCL8/UcZMjWmCvRsP8QNdWyU5hhYcFFzGmMG0iA
         VPRQ==
X-Gm-Message-State: AOUpUlEfJVjRsvuJ5YPDomSvL18nSmjTz9gDSiGegG+WBqbrm+SmuVDd
        RX1PeF7gvbAwgd3r0yNh1ecx5D9PUbY=
X-Google-Smtp-Source: AAOMgpcIKbC42Yw+6tuljDdxSVDoV9ssWR1wOYwJAt5uCKeETWhAilLAZwgUxihs6yq9MjTtY4rCzg==
X-Received: by 2002:a63:4386:: with SMTP id q128-v6mr11242456pga.353.1532332945121;
        Mon, 23 Jul 2018 01:02:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-162-147-103.hsd1.ca.comcast.net. [73.162.147.103])
        by smtp.gmail.com with ESMTPSA id h4-v6sm9032052pgp.13.2018.07.23.01.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 01:02:24 -0700 (PDT)
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
Subject: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD interface
Date:   Mon, 23 Jul 2018 01:02:06 -0700
Message-Id: <20180723080208.44235-1-yuleopen@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support for native DSD for Topping DX7s DAC. The
product description is on
http://en.tpdz.net/products_detail/productId=32.html and it's
available on https://www.amazon.com/Balanced-Headphone-Amplifier-Topping-2ES9038Q2M/dp/B07B4VFS21

The DAC uses XMOS chip but uses a special vendor id and product id.
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

