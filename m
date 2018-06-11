Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VA/AJJx5HluEOAAAmS7hNA
	; Mon, 11 Jun 2018 13:31:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1E548607BB; Mon, 11 Jun 2018 13:31:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hu84LKHy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A045660792;
	Mon, 11 Jun 2018 13:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A045660792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933130AbeFKNbG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:31:06 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40253 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754224AbeFKNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:31:00 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so30558632lfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lDdZ+12ye4H9JsUdu5+2AMHnLkdkF7ofjKyzEJiIn2U=;
        b=hu84LKHy75/wLhFShXTYOjz0+SniVId4gbnyRZqiEad/oW5UIJ0F4N3k1W1I1Vjhni
         wem/FGQmtc46tuPLhMCbWoTGhp2EQah59mgKS7o7FF6gPxoA+X4EuBk1WVR1wyfXFMIa
         hJR8r3MbZySYsolK5ghcneJBgNZWeegwFkkxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lDdZ+12ye4H9JsUdu5+2AMHnLkdkF7ofjKyzEJiIn2U=;
        b=AOm653tE8qixiVr2Zlodk1VF7TOj4u+N/oFqruXhmzYmRzjhIsSNbCLQk3HcE4TPyi
         XpZSCxKwZ4PSYTmLkTk7gQZ1nj7xdm+8UnEfAgxvbUx1JVXYnft/Mzy6xlB6ABgOsZtk
         9dOzQwe9ico02P1VLZTERp2DaJW78WxdOaCbuFVoQDQ9Fwkn0pD+8k0oh9Obgik7h/kB
         vt+30k7VIpa/n2iumNeMoSsXKdILfYkZ/QbdX8PzZz9Ht6GGaxP6sILjph/h5UIKpMQu
         QiSfXXnWvFEKmJcbw78HpmXFLIzCQe6Yppb37Of99uQQ/d8sbRIFA60CqVp+ey8Dgolm
         6xcQ==
X-Gm-Message-State: APt69E0Gz4QhrjGkpWZXMncCeu784tNeIvJ0nJokCHJ9QwxtVqUZADuN
        5LkscEyNzOi/udOnBPXOwa9rEQ==
X-Google-Smtp-Source: ADUXVKKPcPhqXPtK987Je+vAohmTXdz1Jo+gG4EoJvae+vh74fJmF54L9NTFKnngjtY1ap/8RKZ72w==
X-Received: by 2002:a2e:1188:: with SMTP id 8-v6mr12288206ljr.38.1528723859491;
        Mon, 11 Jun 2018 06:30:59 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id u24-v6sm2617712ljj.96.2018.06.11.06.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:30:58 -0700 (PDT)
From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 2/6] net: ethernet: ti: cpdma: fit rated channels in backward order
Date: Mon, 11 Jun 2018 16:30:43 +0300
Message-Id: <20180611133047.4818-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to TRM tx rated channels should be in 7..0 order,
so correct it.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/davinci_cpdma.c | 31 ++++++++++++-------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index cdbddf16dd29..19bb63902997 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -406,37 +406,36 @@ static int cpdma_chan_fit_rate(struct cpdma_chan *ch, u32 rate,
 	struct cpdma_chan *chan;
 	u32 old_rate = ch->rate;
 	u32 new_rmask = 0;
-	int rlim = 1;
+	int rlim = 0;
 	int i;
 
-	*prio_mode = 0;
 	for (i = tx_chan_num(0); i < tx_chan_num(CPDMA_MAX_CHANNELS); i++) {
 		chan = ctlr->channels[i];
-		if (!chan) {
-			rlim = 0;
+		if (!chan)
 			continue;
-		}
 
 		if (chan == ch)
 			chan->rate = rate;
 
 		if (chan->rate) {
-			if (rlim) {
-				new_rmask |= chan->mask;
-			} else {
-				ch->rate = old_rate;
-				dev_err(ctlr->dev, "Prev channel of %dch is not rate limited\n",
-					chan->chan_num);
-				return -EINVAL;
-			}
-		} else {
-			*prio_mode = 1;
-			rlim = 0;
+			rlim = 1;
+			new_rmask |= chan->mask;
+			continue;
 		}
+
+		if (rlim)
+			goto err;
 	}
 
 	*rmask = new_rmask;
+	*prio_mode = rlim;
 	return 0;
+
+err:
+	ch->rate = old_rate;
+	dev_err(ctlr->dev, "Upper cpdma ch%d is not rate limited\n",
+		chan->chan_num);
+	return -EINVAL;
 }
 
 static u32 cpdma_chan_set_factors(struct cpdma_ctlr *ctlr,
-- 
2.17.1
