Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC846C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FA120848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlEtEwjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FA120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeLCPx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:53:26 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41808 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeLCPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:53:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id z28so11155424edi.8;
        Mon, 03 Dec 2018 07:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bWKWoWovkbchqflJqtKRKQbvgYDk8laXhyJA33PSRg=;
        b=GlEtEwjWXKbBQ4HgfxP+3VuPPWBVwB7jbNAQoCmVZVU0/0vzivYkVfoz3TfczAubyk
         dgZSeKxE7gx0YNGpOnZLetQTuJ2BVvtQZzb1g88XKXCEHujI5XuGW7pfOw9PUOyKBpIB
         Aj69/7g2L5Az9/XFxnPE10b24fUnexrcPeL9iyAepCyElkEbQTKCR1hQjrQSWEBcQhZ3
         6tnmUNG9VyKhC0FN0mqvN136l2v/df4vVG8bfYaEEhppquNik1BcMbM/9BtUvD7l+Dn9
         et8fvOPatJigfCsDcguFb0LNzgWWZWAQHxni5z1h7Me9Bt4rIH94mX/4ivG2cVRDysoV
         sEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bWKWoWovkbchqflJqtKRKQbvgYDk8laXhyJA33PSRg=;
        b=YGOmtTUEAHNvsRwUkny9gpUmnR5MCZXg7xUi7jcx1YttcpgTmSHTHy75uI2RlPvI1j
         6d1o6KdEMAkS0NxuFqQH0K/M0Kss2mlh/C8jwNSrYnL5QiVK0MrQQkd75LnwFCVVCW8n
         oBOfzu8R5ZyzOlCYZtXu7QYe4iflqHGiTPoTwF5CQjNMVec00YkhkL5yS+29U3Ihz6sq
         0JVUXvY4XzH0S73/4LwJloF+H88iALK6HrVa/Kvqi2yQXUdLvvBX7XjYtgiYB2Ugupoh
         BpQed/n+VX7xa+iLxAGsyIhU74gfkfa60rx9xQ9R3JqWQYoNY+9aNufV7wZGrkMG3YG6
         n/WA==
X-Gm-Message-State: AA+aEWa1nk2KUorjXGhu0bjxaX3gJk/Xs3N1zpKYsWWA29MJF9dIepY8
        ZUTB9nu1aWQ5D8eGsqlNIhs=
X-Google-Smtp-Source: AFSGD/VD/CF20SDtTAwMaGQZLGuz7Ak/GBOHi9gS9t6JbMaw4gdlXTxMgB305t2qTrjeu7EazXCoig==
X-Received: by 2002:a17:906:1ec4:: with SMTP id m4-v6mr13267338ejj.35.1543852400206;
        Mon, 03 Dec 2018 07:53:20 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id gz20-v6sm2245688ejb.56.2018.12.03.07.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 07:53:19 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/hdmi - Add Tegra186 and Tegra194 support
Date:   Mon,  3 Dec 2018 16:53:17 +0100
Message-Id: <20181203155317.16627-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203155317.16627-1-thierry.reding@gmail.com>
References: <20181203155317.16627-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Tegra186 and Tegra194 contain the same codecs as earlier chips and can
be supported using the same patch function.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 67099cbb6be2..5fb3fa660b89 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3834,6 +3834,10 @@ HDA_CODEC_ENTRY(0x10de0020, "Tegra30 HDMI",	patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0022, "Tegra114 HDMI",	patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0028, "Tegra124 HDMI",	patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0029, "Tegra210 HDMI/DP",	patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de002d, "Tegra186 HDMI/DP0", patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
-- 
2.19.1

