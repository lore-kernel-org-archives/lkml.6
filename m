Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862AAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A82A2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0npjnwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A82A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJRQws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:52:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36078 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeJRQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:52:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id y11-v6so14015877plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7f3p8DaD+OJHNqlVoz6G4mjpM3q6Pg5QN2ip5mfsPB0=;
        b=F0npjnwn8iNGfJ7j+3osZduTcfk1BvnsV0b5S1jvevzglGfqx11GYx2jkrUFjOFfBk
         aC5Tz0xe7fxBPWueVQa+pgp9OkIOiG4o9pVk1VFXjmpulESXea/fV6+AouxON2Jq6uRd
         7pRn+6LdZE0J3wFoUxbAH+Uqd/oPozsF+NYTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7f3p8DaD+OJHNqlVoz6G4mjpM3q6Pg5QN2ip5mfsPB0=;
        b=FtU8RjL+3maqGxe1o/J9fF0RC8PPU0Ijv+q/BJIn9LLqlzzseOoRgw/sc4/m8Vm43g
         a8Z77pSfcc/CMe4VPYgtt4DcqrIVA/fm7FzZ2XqGmfvQfNhU+wabWff+YmQRY4zuBnBp
         idw+w3MT71jXTEsjcwqDknDZ/+CInw++UJw0Y4v9GIbfkFcv8JUDTSY/jC1PRBMzAtw8
         ecO7/Wu/QxgXseHpwYqeKZ3qXcdXlqPi8py++E+OcWbIu2Y8G16O65Ra2b0iLiDwsnbD
         +5FDzbJjNm2Pa85H1hylVlF1pIysd5nkYiNDbWnStyHbbnWrFdrRGo3v5uiMowrjF0B5
         G1LA==
X-Gm-Message-State: ABuFfojYsbr9EJ9DxU9rke84g3i6KXhS7nMVD3TuGIgAw640jqhyqa6H
        Vf0dtx0ElLO8h2GYCTnyimxCfvdHIrmFMw==
X-Google-Smtp-Source: ACcGV627hPrCKf4lsVo8UKgQ+nJdgvqZ04vaCdCyCqE3mXfOJLbhGKfm+4UpwooyWDYpv/+J7hUThg==
X-Received: by 2002:a17:902:74c9:: with SMTP id f9-v6mr662553plt.99.1539852769501;
        Thu, 18 Oct 2018 01:52:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x186-v6sm18467528pfb.125.2018.10.18.01.52.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 01:52:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 2/5] rtc: sc27xx: Clear SPG value update interrupt status
Date:   Thu, 18 Oct 2018 16:52:27 +0800
Message-Id: <43a12635d57b134fc55d664af8f715b31bbc5f3b.1539851865.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1539851865.git.baolin.wang@linaro.org>
References: <cover.1539851865.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should clear the SPG value update interrupt status once the SPG value
is updated successfully, in case incorrect status validation for next time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index 8afba12..6ac5653 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -172,7 +172,8 @@ static int sprd_rtc_lock_alarm(struct sprd_rtc *rtc, bool lock)
 		return ret;
 	}
 
-	return 0;
+	return regmap_write(rtc->regmap, rtc->base + SPRD_RTC_INT_CLR,
+			    SPRD_RTC_SPG_UPD_EN);
 }
 
 static int sprd_rtc_get_secs(struct sprd_rtc *rtc, enum sprd_rtc_reg_types type,
-- 
1.7.9.5

