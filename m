Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E15C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89220659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0qD3Raki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F89220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeH2S6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:58:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40150 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbeH2S6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:58:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so5140292wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uUbMF3nMXRw/+9rZqOfjCDmKj73BdEnRsLVytA1Yk6Q=;
        b=0qD3Raki6lB/dZdEao0Ktml94uXot/dSS2tppB4k29vIR+pPbhOxyo7/ThW4SPQRFN
         PbvK+G9wfCmlbu4OZKsZsk01A7I8QrqN+8t1/XrHvM0iC4IO6aS5RWGZ7APzw5E4Bgyr
         be7kof5G/dnfyuUXiodeJSUHC7+6ns0SVX1/Dz+9wduczCnWEO/+8Lhu21Y54dQxLEbc
         OOs1ntOO/mJcoMiFZNLWrFQUFi8/3ghJZrB+G0bq0pl9sIBCjv+kZHUmgfm7aBpfPK+B
         jpqL0GfqFexxko70eCdQCrL0KxCyysMFhG7tO1MeSUhXzFiuXmrlPBfXDk0fBJnW7UQW
         rghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uUbMF3nMXRw/+9rZqOfjCDmKj73BdEnRsLVytA1Yk6Q=;
        b=SgKdjwfNv11iT2vof9mPffQZAtIjworflJfEBrIVzn3xm/DdUQk6baxWEA9osoTxal
         jTcAkVg/4HPaTzxmyYFKmmf+p3psZO2Zozp6Ckpj4UHDMxjQd6kIp7TxqnRM0AjbL4gY
         5bIgOCy+Io+8oNkCTcmiuAlWVKzw20XXTaq0uRWtNofZAyUnsWJkllnbvf5QcKyAmb4H
         jEVn0GjFDGvK/wmprXQhIHE46JnggqjVcJnRnH3Pb4O9C93iissdx6L7DnNmedFE4Leb
         gEtHldjpoJHdzWpId8FUbAtxKP94ALei5iRpOFg08hAyllDftVqIBK4sogSCUz/tTOyv
         PtUA==
X-Gm-Message-State: APzg51AoP7bpOpIrC7OcRvOaOV6SRMDnIs84hg/jWOOrGvX0OczNPQ9j
        tAe7oVg+TQQu0wv+BjCYj4HgVA==
X-Google-Smtp-Source: ANB0VdYnfu/IKQTnk/aEzhvE9cihI8Y4ivp9rJaXlTK4WkF3+uJ+N4RZRZBevvc5j/3nVFmVhFGCmg==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr4638185wrj.3.1535554860163;
        Wed, 29 Aug 2018 08:01:00 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v46-v6sm7267217wrc.63.2018.08.29.08.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 08:00:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ASoC: dmic: add DT module alias
Date:   Wed, 29 Aug 2018 17:00:49 +0200
Message-Id: <20180829150051.18190-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829150051.18190-1-jbrunet@baylibre.com>
References: <20180829150051.18190-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch the only alias provided by the dmic module is:
alias:          platform:dmic-codec

Device instantiated from DT will not probe automatically with this

After this patch, here is the new alias list:
alias:          platform:dmic-codec
alias:          of:N*T*Cdmic-codecC*
alias:          of:N*T*Cdmic-codec

Now the dmic codec probes automatically when instantiated from DT.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/dmic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 8c4926df9286..71322e0410ee 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -148,6 +148,7 @@ static const struct of_device_id dmic_dev_match[] = {
 	{.compatible = "dmic-codec"},
 	{}
 };
+MODULE_DEVICE_TABLE(of, dmic_dev_match);
 
 static struct platform_driver dmic_driver = {
 	.driver = {
-- 
2.17.1

