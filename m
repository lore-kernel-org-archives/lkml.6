Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05A6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696D12083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHfLYCtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfBUSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:18:31 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35052 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfBUSS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:18:29 -0500
Received: by mail-io1-f68.google.com with SMTP id x4so2833812ion.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 10:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q1lWpb5oVfdrPg0jMk2RNiAz5bOGQvK2Bip/hT+WEKo=;
        b=nHfLYCtCQUqNEqdExAHUTg3uXM2N2IN/Tee8td3eSxIVhvMxFAdvI3pOHb18XI5J0T
         u7UqGG7nUpYObNb2sjM2djyytuRQ0YX25XNCm7sl2eMh1WOEpYecg0LaS3ZXgD2erR3Y
         iMAaMlzlyNOhr6FcfzDYS+DrFGz/CByWf4K9rcfKZDQmBshzpLbUcuwBaUihp4ZS7GRG
         drqXw2qBcdfOd3Xd0fRk6Hovm7mJj4toiyZ4l0SrQL1r+b/Q215Iu8+xMPsQkXoRSbdv
         5Es7wB1wG1SWaz0aNKvYNTBFIFwrVoLr5gBWc0p44jwCdBDmwGp54ecSdms4yQq6kUZk
         bf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q1lWpb5oVfdrPg0jMk2RNiAz5bOGQvK2Bip/hT+WEKo=;
        b=IcqkWVdnQJsXvfWCylRtJ+ww/n92Kx8LrtRthElmyifo+wUhmiKuAXbrv6B/fW8WwK
         gE1lPstrG6jD4l7KQKwAKYVkvV94fBEFYx7ySN5Yy5LkJJCbBPhnb/PejwXWVPg04hLV
         RnolyYw+SXPplYg5p3dT4ug9KqVhrG/EstXJHONXeh2ZET09ZsfAuAQ0de+cvAV+mHTA
         KIcdWgaxIBnhTzkpHUbPNTqRtRw0qTL0nNQ1yySbmxbLUyoXlECj6XCJOQhOIqQrnOVY
         uG1pr6zKb/93cmIq0qUA5cY8l5N1pJ8AVJYwisdf1e/R0WJ1Zt1ipTgxoKn9HvhiwFns
         hYCw==
X-Gm-Message-State: AHQUAuZPmtdhwULzd9cNIdQ7R/lzlg1yaqhy2lRhMGwA1kxt1MifBz3x
        6BHKz5Iy/5TG2gyjUx+JCK6hZzsp
X-Google-Smtp-Source: AHgI3IYNzaABvC9fxLjsrCWpjIsPss+ahJn3Re1PKtYbq7W3vNFtt0TrEwrqTfAgD+tddAKPeCA0XQ==
X-Received: by 2002:a02:bb0a:: with SMTP id y10mr24100000jan.125.1550773107888;
        Thu, 21 Feb 2019 10:18:27 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id s26sm3006284iol.41.2019.02.21.10.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 10:18:27 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sound: hdmi-codec: propagate physical_width
Date:   Thu, 21 Feb 2019 13:18:14 -0500
Message-Id: <20190221181814.24829-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221181814.24829-1-TheSven73@gmail.com>
References: <20190221181814.24829-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Infrastructure patch which allows the tda998x patch to
build.

This patch will be submitted for review if/when the
tda998x patch gets accepted.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 include/sound/hdmi-codec.h    | 1 +
 sound/soc/codecs/hdmi-codec.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 9483c55f871b..5ba3db37e349 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -52,6 +52,7 @@ struct hdmi_codec_params {
 	struct snd_aes_iec958 iec;
 	int sample_rate;
 	int sample_width;
+	int physical_width;
 	int channels;
 };
 
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index e5b6769b9797..007f20f2c5ac 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -518,6 +518,7 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 
 	hp.sample_width = params_width(params);
 	hp.sample_rate = params_rate(params);
+	hp.physical_width = params_physical_width(params);
 	hp.channels = params_channels(params);
 
 	return hcp->hcd.ops->hw_params(dai->dev->parent, hcp->hcd.data,
-- 
2.17.1

