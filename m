Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F26C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E1D24001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRkXqLWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E1D24001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933568AbeGFNHL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:07:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39107 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbeGFNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:07:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so14358301wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 06:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WJeLuqyEJc7/tPpKxg+RC7iLj+X8Fywv7Zs3uhn6DB8=;
        b=iRkXqLWFnhArdsBb6TmP9EISMQ872vTwH07GyVtX469rW0yvMMZGbTzu3Ex2qOXO3j
         H8YxX1B/9Gh2ov3Pd8QvNMTKyy0FFLUsi58j2jugeJxgz5VX7ocdfmrANJj7UFVqqDcX
         Y6BHmXmsj+YfBIIkVW5PWbBm4fIJfy2qXyeFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WJeLuqyEJc7/tPpKxg+RC7iLj+X8Fywv7Zs3uhn6DB8=;
        b=f3EiE1XezwyWlhvJAg5jw2mv2tJ/+TpaWRlJ5ru6DB0wXmskHZvYXsr6j/E6hflrCn
         fVGdZYJGFc4iXXZ0sAvHdgVQ4n1AwPJSpWeM62yKjXgTY0bgPEBC1UGQpqhEG66UjjmI
         ARJ77zmT/4veJaQpiUa1+4JL3YIJGedstpm7sc4U6p3bQcagod2ny/HcMOMfVIz43WZ2
         ZVbiEZTIBVo3U35KvRcOIJON3kxryDUmll7sYfX+Kaq9SZdeW+IoMtqz5rQVNNjdqO/J
         EoRci+2fjfadsp7MCw0s45qcp305dc/9Wo2rcnM0DHEN/jBTwiYC9H91fGlgG8W8P8E4
         WVRw==
X-Gm-Message-State: APt69E2IcR/KY9SC4e9vNGLB7GLWov3di4ZLXZXv17UivDlZjPDs2bXY
        1ky3zn0JrmOlLFbpbe1UhLYtJQ==
X-Google-Smtp-Source: AAOMgpc/5R8EZZwqCnDxqtnoeiu8jPhtjD5Y2rmjWaLSFJv2ITjUgKV6JEJDi9ify20bU7HL6epyPg==
X-Received: by 2002:a1c:90e:: with SMTP id 14-v6mr6684069wmj.130.1530882428381;
        Fri, 06 Jul 2018 06:07:08 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.214.65.221])
        by smtp.gmail.com with ESMTPSA id n6-v6sm719241wrr.27.2018.07.06.06.07.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 06:07:07 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        arnaud.pouliquen@st.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] sound: stm32: replace "%p" with "%pK"
Date:   Fri,  6 Jul 2018 15:07:03 +0200
Message-Id: <20180706130703.22352-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index db73fef3e500..0e9373064032 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -149,7 +149,7 @@ static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 	unsigned int old_pos = priv->pos;
 	unsigned int cur_size = size;
 
-	dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %zu\n",
+	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
 		__func__, &pcm_buff[priv->pos], priv->pos, size);
 
 	if ((priv->pos + size) > buff_size) {
-- 
2.15.0

