Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8930C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33F922565
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ns36ydYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33F922565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeGDJwU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:52:20 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:56139 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932878AbeGDJv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:51:59 -0400
Received: by mail-wm0-f44.google.com with SMTP id v16-v6so5134842wmv.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GIK9ORkO2DwcYCiUPFLrufSRQfHEUxj9xTjfzebPSEw=;
        b=Ns36ydYVLOgeXR+/ijNVnsCla/eMMYZhEX+kLFlGzZJvheVDtNG5JoNUuSf5scqxZE
         e1Wg/OQBnTa/61j+xU4gyE6NAUG+XpKQWnxHMer4jJkG75jJyZwpdHCP62wbn3gKI/9r
         UfKdGiFudxNvXOAq7v7McjGkNuxCZuBYnHYoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GIK9ORkO2DwcYCiUPFLrufSRQfHEUxj9xTjfzebPSEw=;
        b=t89uV2bSmWOny7yjVn7hHi9FFRfaK7Mko3OGAs/YnjpuSkj3qH+GUvZ+KxkRYzN+ci
         FWCTCNu23Kev0JvsU53d1+yMEm+4/nREwPttCQZfw89pd8WqmARHBDODh1wzA4Ba4FGj
         pkgIdgraCq1AHkFgr/sdgdIxIIdAUQp8RCKk1BxaDmWbOAuyxT1a2VTUHkJAs98X/5FB
         E4T84crFievg0LK0AteOg188FS6xB5U4Scv7YHbR5lhMgdb0CdPVUB7Y0N/+8zjFp/St
         KiwbuZmb3DrdXO19fuPvouhv2JunS4EAwIG/JHuS6Eg58F1/MZBU/VD1fMTzvf6fQDYC
         M/dg==
X-Gm-Message-State: APt69E2AxbQ+T1Wn1lww8TKp/73+3BmRwe2+4Y+S3M8RZXm0c+BnwHaD
        kjfD5i5+iNhIOggv01N+WpaV6Q==
X-Google-Smtp-Source: AAOMgpcTXcJH9lO/hIe8WphygL1zzqXPtIAdndRXObgojCJpcSm3QZ9ra98anvj2BNffIgL42+QVkw==
X-Received: by 2002:a1c:2e90:: with SMTP id u138-v6mr1042157wmu.156.1530697917996;
        Wed, 04 Jul 2018 02:51:57 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6370089wmw.9.2018.07.04.02.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 02:51:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] ASoC: qdsp6: q6afe-dai: do not close port if its not opened
Date:   Wed,  4 Jul 2018 10:49:43 +0100
Message-Id: <20180704094944.16440-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
References: <20180704094944.16440-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afe ports are open as part of prepare, so for use cases like
"aplay sample.wav" were sample.wav is not present. This would
call port close eventhough port was never opened. DSP would
return errors for such use cases.

Avoid doing this by checking the port state.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 074582afda85..e7f809e3ee1f 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -314,6 +314,9 @@ static void q6afe_dai_shutdown(struct snd_pcm_substream *substream,
 	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	int rc;
 
+	if (!dai_data->is_port_started[dai->id])
+		return;
+
 	rc = q6afe_port_stop(dai_data->port[dai->id]);
 	if (rc < 0)
 		dev_err(dai->dev, "fail to close AFE port (%d)\n", rc);
-- 
2.16.2

