Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C206C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A905216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ux6NW9Sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A905216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbeKMUxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:53:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41911 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeKMUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:53:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id v18-v6so12766413wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 02:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wt7pkL3la0ggYXUL0EKhSbI+tOA4s03vVHS9+1Kq4sc=;
        b=ux6NW9ShhTMAlzNi7lIpe327lxvhDDrySoRcEVsUGo/AjBDtTMNqzb+fKKLzdaMKIN
         EYuMspC8L3J/fE+srr+RWGopBDsCcfUkSrCFcDf+oEfCUkUFE0CGgIlC/T8bWyY6FdFS
         hYljbmOqJ36M3Y/rdkDBPWBxMvNptQWRYVANrH/xOXh+NWo0REjDuZkpHaACAyp2okN6
         EtegoVwldn/xcWYR4IE46lUKB8kAeDI2g4NJwlHRLSWw9YXuJQERCzqBVGkAkA9iV9WW
         abdpCmUow+SGBML2TUDdj5ZFAH0T9huWq5KSfd+PRAVwnqdblnDvzsh84HoVLoAOogbR
         M7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wt7pkL3la0ggYXUL0EKhSbI+tOA4s03vVHS9+1Kq4sc=;
        b=NLM1g8b9zg02/DD/yiUK7osQNKkuxpeJEBHwfGcBmZeNeEIpB9+2/Mwemp+4RFezjS
         WhLaca6mxZbEwrjI62FeOJnSNGQCYrCUs00u0YaLbBJKxb5Sp9D332ENbNUy3Ysc0DF0
         tjsRNcn858zuU/Qsxulw2uwbQZfnGqhjtEiHBABuwARk9bVhnPgDJUIW/i5PUMuwv2BW
         T2f55f7JOAIm2doKZgXtSRn5MBPYL0tGSJtKsw8xsEEEsGrV+LoFmjmjUmz5olcLfiHh
         ZWPi/hAvw7t2X10qZ0ujym/npEEZsFuFVmFiEvnJ4q4d5u5vyldiAwENxJE7uSUZ9RLd
         OetQ==
X-Gm-Message-State: AGRZ1gL8wit0Q38nghlaoHZV2fjPz22ymFGYvklLmRqEToX9i1XMrXSz
        CVCpXojoa1TEwdpbVWf0q4ZppQ==
X-Google-Smtp-Source: AJdET5dcFot088JbpfI+LtMUQon8sNzCV50XCdhWM+2SM9Me5OeYvSjrR8qP1WHEErDBe4mQYyML5Q==
X-Received: by 2002:adf:83e3:: with SMTP id 90-v6mr4541797wre.278.1542106558646;
        Tue, 13 Nov 2018 02:55:58 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id v9-v6sm20671096wrm.6.2018.11.13.02.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 02:55:57 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: meson: fix pull enable register calculation
Date:   Tue, 13 Nov 2018 11:55:36 +0100
Message-Id: <20181113105536.6459-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We just changed the code so we apply bias disable on the correct
register but forgot to align the register calculation. The result
is that we apply the change on the correct register, but possibly
at the incorrect offset/bit

This went undetected because offsets tends to be the same between
REG_PULL and REG_PULLEN for a given pin the EE controller. This
is not true for the AO controller.

Fixes: e39f9dd8206a ("pinctrl: meson: fix pinconf bias disable")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 53d449076dee..ea87d739f534 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -191,7 +191,8 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 		case PIN_CONFIG_BIAS_DISABLE:
 			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
 
-			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+			meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg,
+					       &bit);
 			ret = regmap_update_bits(pc->reg_pullen, reg,
 						 BIT(bit), 0);
 			if (ret)
-- 
2.19.1

