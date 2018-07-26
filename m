Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B0C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00BB20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SOUaedzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00BB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeGZOCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:02:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33017 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbeGZOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:02:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so1596925wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a+ev1bGmZHlGL08s3doi18bCWN3phVVcjsC7HmN0N84=;
        b=SOUaedzXxtGnPxHEyOFiPlxXXC7pvP5qC2+5nOvXb/Wgpxg7FLcKG1K7W09w9VsbE8
         sMBibxY3wBGbb7AOHSnVWBvS9FCS9QXs9aQzYsQgAwH/7gcJ/PHewM2+Dz5pA1o9/zOP
         GbEDJvX/rgyE3t45Wg8DZKMHddO6Pf7icLaTgZ44hj13r29g42DzoOFDkqSjr1KFSD02
         LZzJlomoHOA1GZ25iqk/duk7brLknuh1D+oz1/77tyonCo4bo279CoVHepTfSgl5w5Rt
         6jAn+4MZhNjdJUu9+fVgZa8U7GMDPNWEeD8Z+aeunPtVyGrxr8BmojN6om+g5480ho92
         Ywdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a+ev1bGmZHlGL08s3doi18bCWN3phVVcjsC7HmN0N84=;
        b=U+Yl2RvzWu2e5PHEQLEQkSYKRxzCnzgwMXxhLaWqcLTCcuZyWLXYLdud6qwCojmJPo
         8+TfHdHiZd6Kzfe+XdQFJvK/jIdPcgZ1EYOWM/REul1+8LfzO3pXBNKnH7exk+bUR69i
         oxYH8fj4lOtbdvAuknSKTo+J+wqkcT71LdjH+Fos9QUJRTV0UzNFRQLoMwoc8FnU5sg6
         JXCWBWzIBcx0W2IWI1W2mZum4ZlRf2iF6GEriWve5KDlfQSvY99lN+1FexKXeoRaTxyo
         /97+UYjXpRxMYl9GljLnkuZfMVIWL2AbNaDkqkkSWaGzDPsBJHS+zfW/mlgGUSFUV3Kz
         Ma2A==
X-Gm-Message-State: AOUpUlFeqDLUGxo/UwOTL/KEJdMBGagaE5AhyYTz9mNzFyOdjkOBk1SK
        6MtYfiZNbQuXmWv5OatKeN0Ttw==
X-Google-Smtp-Source: AAOMgpexpjF9VUVJagjAHwizM2j8sqdrimDsg171xx54WHaIJ3AN0NEz80JI2LL626ihgDp0QfPuyQ==
X-Received: by 2002:adf:fdcd:: with SMTP id i13-v6mr1442163wrs.276.1532609150700;
        Thu, 26 Jul 2018 05:45:50 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m207-v6sm1867744wma.31.2018.07.26.05.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 05:45:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/3] ASoC: meson: use IRQ_RETVAL in the fifo irq handler
Date:   Thu, 26 Jul 2018 14:45:42 +0200
Message-Id: <20180726124544.14740-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726124544.14740-1-jbrunet@baylibre.com>
References: <20180726124544.14740-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IRQ_RETVAL instead of the open coded ternary operation.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index db367d85290f..30262550e37b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -174,7 +174,7 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 	/* Ack irqs */
 	axg_fifo_ack_irq(fifo, status);
 
-	return !status ? IRQ_NONE : IRQ_HANDLED;
+	return IRQ_RETVAL(status);
 }
 
 static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
-- 
2.17.1

