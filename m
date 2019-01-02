Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC84C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C796218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqUAtJUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfABRGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:06:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36541 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbfABRGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:06:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so15435377pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NNMFfm8TbUG0EK1ZBv6bIRDbrgZ3RA6KxsPrECi5Blk=;
        b=uqUAtJUtHFQ/dOKF50GDJ4ZPwbnqESw2ZeVa7+6upJK4qlIH1x/iKJJt4Ztz2khGo0
         49WaYagIms3hcDFnwCZGEpODV1m5JCItOQv/OrDNR30a7fbV1jHDU9sf1RzvLl9gudtX
         xTZSu7NN5HsTh7qkCoJVy1UPQP48sjONlqrt9cqcXC+S8qHb5dfh9tSIk19/6B5/WG6E
         VMEZ4+VZdua4bSGtYvh5R0tq6Wfh8lOefN4afnzLsG7vmxK1VbQeX1nnE9xYChRgZjpC
         qbojpdVX/502rVCNfdhcqTEWdC/Xz45Ct//8BJCa86/KKLhnpVtG7PjKTWzwkWJexLuw
         nazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NNMFfm8TbUG0EK1ZBv6bIRDbrgZ3RA6KxsPrECi5Blk=;
        b=ZHKZl9DP5RfVt3WM07OaWzlr3sgjHo3NwBip3Prw7qogJVcRMQzWapSgLn5hX7wYH2
         X2pu3Xl7zThc4A/Il50diz+VOy4XZ9fGdXHnXnz4UKiLRY6XFXzqVBREO0Qk5MQ5E9je
         Fr5sOXF97Rt9blHEW8kTbMvCDAeJCuvFsxMGnS1jpYGoukxhbrR54HX9z0ykA8FYEhsg
         amzuBKOMI1FweXOWuGFYrpBj2YPUF0JllPX8y7o+E3gf6bKzVcVxWeyqWonPdS0IM+qu
         K9OF43gTx+jlaOg0l+F3WTmSUyZu1M8lUPhQy2Bj3Nwz6jUFyctFnMykeeBPaj0gbgtQ
         rrlQ==
X-Gm-Message-State: AA+aEWYAiAVzReTkHtpMy3MauJk3gvGJrJl6oyle+JQC+VVUdbXJphGZ
        Gw7HTbOj5Q8VG5DHwoxGivHO2rZm64qlhA==
X-Google-Smtp-Source: ALg8bN6jHUJDtgZUHYSl7LgHmWjBpKY9lsamfS5pvKdyfUv3a4i07h3RbKsU1EW6MvMaeKTHowSJUA==
X-Received: by 2002:a62:cec6:: with SMTP id y189mr46843735pfg.100.1546448800201;
        Wed, 02 Jan 2019 09:06:40 -0800 (PST)
Received: from Ideapad-330S ([49.206.14.88])
        by smtp.gmail.com with ESMTPSA id m11sm68836429pgh.51.2019.01.02.09.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 09:06:39 -0800 (PST)
Date:   Wed, 2 Jan 2019 22:36:33 +0530
From:   b-ak <anur.bhargav@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby
 mode
Message-ID: <20190102170633.GA9724@Ideapad-330S>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the bootup of the kernel, as soon as the DAPM framework kicks in
it pushes the codec into standy mode.

The existing TVL320AIC32x4 codec driver doesn't prepare the clock in
the probe function.
This leads to an OOPS when the DAPM tries to put it into standy by calling
clk_disable_unprepare()

This patch fixes that problem.

Signed-off-by: b-ak <anur.bhargav@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e2b5a11b16d1..7cf363595abd 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1167,6 +1167,12 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap)
 	if (IS_ERR(aic32x4->mclk)) {
 		dev_err(dev, "Failed getting the mclk. The current implementation does not support the usage of this codec without mclk\n");
 		return PTR_ERR(aic32x4->mclk);
+	} else {
+		ret = clk_prepare_enable(aic32x4->mclk);
+		if (ret != 0) {
+			dev_err(dev, "Failed to enable MCLK: %d\n", ret);
+			return ret;
+		}
 	}
 
 	if (gpio_is_valid(aic32x4->rstn_gpio)) {
-- 
2.19.1

