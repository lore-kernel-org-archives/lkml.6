Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6C9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9812054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBlRtS/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9812054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeICP37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:29:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34835 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeICP37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:29:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so261584wre.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 04:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3Iwcl00YGBnlbvpZZDajvdQimSyfWjbafvjQtZcgtzA=;
        b=CBlRtS/2PFYRllExbrHVMGJVgxoaJaOOoKcuVaQ19boiu6sbctc9CVWY8CbMjV9lNH
         qaS3cS2pBMCbaIkngQOtW0U4TA/5OTJ0ZqIyqMmuCRh8HPqXF7ZB+017TYdoRDy5yFBc
         XqRpVhS4RDV9j8me3ke9lf88Cx7ulVl58pukc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Iwcl00YGBnlbvpZZDajvdQimSyfWjbafvjQtZcgtzA=;
        b=gDNb9CBH5EAN/sbx0h11J3d+og8rsl7e37u3YzDM0ImUN964omLDf2xIG/Lr1fhaQz
         WQRsDGjdo7KotHgvmxN+I/YMjd8QhbzD7NFm8KXNfX9Yqp8doxov/FEKyQhZLmX/qyvd
         Et9fGIO6xUZ7xyH3l8s7lZenphRDHAzzv2S/pa/R0Qm8NnSvbjr+9UFHKe+CWDMVLkPI
         8Gv2VUobLq3Vn+TQ48GVNgqi0IvizlG+Qb/ubaDx5U/1wF4IL9TlW6DE/8zfLfDK0ong
         ESVfS1HiCtFJ21EhcSs2/cm2FE/FbCYhzt1J1MJMdM845vokGdLeuzv28G+UjyP6hNwo
         zT4A==
X-Gm-Message-State: APzg51ArQ/tGkQuGz087Sax6k0TtxydJzfOTEPQ7gdIijdIDgzz99+tM
        lhpXmQ6GHhdljtfjSeF0Y9tEVA==
X-Google-Smtp-Source: ANB0VdYMlFjdvu52xVAsFJ1GzZOpYejhIvC0dBF7Pz5csI+WJzd2CJZbKNu1lxVUZn3q2lpaBzWotg==
X-Received: by 2002:a5d:6aca:: with SMTP id u10-v6mr19548651wrw.44.1535973017735;
        Mon, 03 Sep 2018 04:10:17 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id o3-v6sm13861423wrn.58.2018.09.03.04.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 04:10:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: q6routing: initialize data correctly
Date:   Mon,  3 Sep 2018 12:07:47 +0100
Message-Id: <20180903110747.10745-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the router data fields are left as default zeros which are
valid dai ids, so initialize these to invalid value of -1.

Without intializing these correctly get_session_from_id() can return
incorrect session resulting in not closing the opened copp and messing
up with the copp ref count.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index dc94c5c53788..c6b51571be94 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -960,8 +960,10 @@ static int msm_routing_probe(struct snd_soc_component *c)
 {
 	int i;
 
-	for (i = 0; i < MAX_SESSIONS; i++)
+	for (i = 0; i < MAX_SESSIONS; i++) {
 		routing_data->sessions[i].port_id = -1;
+		routing_data->sessions[i].fedai_id = -1;
+	}
 
 	return 0;
 }
-- 
2.18.0

