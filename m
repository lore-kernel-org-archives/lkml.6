Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017EDC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C482021872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKWw2Vjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfBGKub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:50:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37030 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfBGKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:50:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so4189007wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=081b2WykrwcmfZxREyFy0rYtvIRmQI0giDh8mi53WU0=;
        b=jKWw2VjhjLdA19Yvvv2lrEJUtBjp5TTwzdFjXyxaLdLSlJtAZv0YrIEEIxxV354Hiw
         2lelZ67fbFEw3x0Mu2yQssfjxuGUGfx5U2iVDX+htrTkLDiw4THhxgCsfqHfNee1iPmT
         ing4KZT5zAhPomgoXB0C6sYWCLWQNw/p/3B0At5wyPdZ/X2NdOGBgGdIfxWC9S8/ZnE6
         Uf2fyQ8OLOHS2S+zPigeQl1KzkOc9xy95LX0JFZ7nTS8hdJaPhasKuUPUvTnNS4uPK75
         iMs5J+62OtKa5AwQoQvVQcsJFa+ojme5hTMVNNt4joGFel4YHOwTbDweByRbQjloWaB7
         Tu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=081b2WykrwcmfZxREyFy0rYtvIRmQI0giDh8mi53WU0=;
        b=UBTJX9bitwYe0P+O96oVi7OQp6LC3CqJuDKTCa8B91tM9uii1G61gFvXZkTj9B/Pmt
         novDF++hlVcHwiZqaDs7WiIzWyle96mfqkBkmQ5Hd+cHgT2eJvPyNNhu5FhLveMCvquc
         2GcIUuUe7E6sz1/GD1HMSEkpIDZFfu3Ov724PbuiHaahQva/N+UV+mt6cTR7AiLqEu+j
         KC7isdCXbu5jEHV/eGgZPa+diXH5XFlz9J5xI9uY5doBSbDtxmEro5rXgVrYL8ffhHBo
         M7X450NLO+SWBspnwaS9JhqRZb4AdPFV68iRIgmP5uosIlzp4jca1ayHFjWlQHT/DI2/
         /bQQ==
X-Gm-Message-State: AHQUAuZMhGMaGAcCNPlkQLx7noa08EdkOiVZLUbcAf/VdP3tB5Djqztc
        2EsNAae+ZU+TY7zN+e4MlIV2WVO3gvw=
X-Google-Smtp-Source: AHgI3IZtcRWJHqyPr8qbiJJVY4NIe5bDYyiAX0GZnQ6VgA7JxvTzCeNElbR8OwMBm+SLMAlaUPOTGg==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr11996893wrq.327.1549536626627;
        Thu, 07 Feb 2019 02:50:26 -0800 (PST)
Received: from localhost ([49.248.196.115])
        by smtp.gmail.com with ESMTPSA id o64sm22842872wmo.47.2019.02.07.02.50.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:50:26 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 05/24] drivers: thermal: tsens: Use consistent names for variables
Date:   Thu,  7 Feb 2019 16:19:23 +0530
Message-Id: <7abbbbcc0790936575c03caa72400a6293a7d6ed.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tsens_get_temp() uses the name 'data' for the void pointer, use the same
in tsens_get_trend() for consistency.

Remove a stray space while we're at it.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4582d2b30e94..0b5be08d515f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -20,13 +20,13 @@ static int tsens_get_temp(void *data, int *temp)
 	return priv->ops->get_temp(priv, s->id, temp);
 }
 
-static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
+static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
 {
-	const struct tsens_sensor *s = p;
+	const struct tsens_sensor *s = data;
 	struct tsens_priv *priv = s->priv;
 
 	if (priv->ops->get_trend)
-		return  priv->ops->get_trend(priv, s->id, trend);
+		return priv->ops->get_trend(priv, s->id, trend);
 
 	return -ENOTSUPP;
 }
-- 
2.17.1

