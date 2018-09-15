Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2303ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B53720881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU2UTybV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B53720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeIOKnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 06:43:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51257 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeIOKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 06:43:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id y2-v6so3978022wma.1;
        Fri, 14 Sep 2018 22:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O7jOysXB3AWG7qkSJvbO/cQomiQ0kilMR9/2eTU9sw0=;
        b=JU2UTybVUIdjgCxtnkFiGT2T8AnvEgu3ghtxgmxbsSz9Tph1BcR1lb7n+9Z2wZPq7I
         Uu86IkUN/8p9vi1XtYjlLbFqtkqh571AAWGaYUphFLRTAvOziU1oZw8Vdg2HMIocc+BN
         RmdyujqzSI+awj9uS5Tkay368WkQxvc3y7IVbDoT1t1nFbEnywchwpTxxve5yGhxkY4d
         CDQW7edLKGI1eHLGgXSGjf7aUyzUgUG3DKbuv+gKlUvM9IUHsg8rQAeae7a2+Be/BX1D
         BkyYQj+tQ/itavO0yFfm8CnmsVDQsfjqVJFpQKBfonw89trNs4RxsEYRlRmpVWWsGrGm
         1w8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O7jOysXB3AWG7qkSJvbO/cQomiQ0kilMR9/2eTU9sw0=;
        b=gYairWI+GjFmRYkrs7CvGgZ6hT1pjgeDVODz1DJK/aJ2Il42HoR0VlIxlHSSrOU3wd
         mn0nTUakKN64aff9WVrIc5b4ITX1w3h8ipD+6iRMYFZPAIlttjTIiKwhJSDN09QoZRBX
         a/RIlGLuAOWHqBOmD7hZHYp7wd8jzVaheyhlLSgFvhADQAqP3IGaOUDmKGFKWlNbFCGJ
         IRVV+06oPbLzCdsV5i6ciEC+WtYSD5gTCL90qagz2CgNJ9CTAnlMhZB8qQ3syCEmBiJy
         A6RvJsLDlSXwYUiKmpxkBVugMgTCMkiEY0p9d19lCRNeiuPpLQE9/Th9ebWLgTAPv8XS
         mXlw==
X-Gm-Message-State: APzg51D9EHxzQq9yQyGQx+rmvIXeZTYwBUWbWSNirh0o+0JAk7eGXE6j
        i2jG9mt5QeH/sZ183dKcPM0=
X-Google-Smtp-Source: ANB0VdaJcNXABTZDIoC83mQtTDJE54cbkTRSGfKxkWA6aC8wLxV2w+VU8vmGSXhlrKRwNlXk9KFoLQ==
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr4323783wmg.67.1536989130016;
        Fri, 14 Sep 2018 22:25:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 142-v6sm804829wme.35.2018.09.14.22.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 22:25:29 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] iio: adc: max9611: Avoid implicit enum conversion warning
Date:   Fri, 14 Sep 2018 22:25:11 -0700
Message-Id: <20180915052511.2243-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when an enumerated type is implicitly converted to another.

drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
enumeration type 'enum max9611_conf_ids' to different enumeration type
'enum max9611_csa_gain' [-Wenum-conversion]
                        *csa_gain = gain_selectors[i];
                                  ~ ^~~~~~~~~~~~~~~~~
1 warning generated.

Change the type of the variable 'gain_selectors' to int so that Clang
understands this is expected behavior.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 0538ff8c4ac1..3c358b16a8fa 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
 				    u16 *adc_raw,
 				    enum max9611_csa_gain *csa_gain)
 {
-	enum max9611_conf_ids gain_selectors[] = {
+	int gain_selectors[] = {
 		CONF_SENSE_1x,
 		CONF_SENSE_4x,
 		CONF_SENSE_8x
-- 
2.18.0

