Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE697C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686002086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaAFIofQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686002086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbeIUT3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:38 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37137 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390137AbeIUT3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:37 -0400
Received: by mail-it1-f195.google.com with SMTP id h20-v6so1931861itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ov3wg4XZJI4qwoa7b5oqsUQXgLTAbqq1B8k7ALORMss=;
        b=HaAFIofQsH7OlyhY1W4YajH08ToS8S2F6h5xezXwH8DfgrbGD4rp+9bwlYp710SzEO
         RlsHzFFxd9jmmRsgdcXkyYG95b52+VyaUS8asB2BNZbBoXTmsjRmJtIBMVq1XgHaltxU
         JIF2fLggLduKODY5jkHyOANftP75tpX4i4YKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ov3wg4XZJI4qwoa7b5oqsUQXgLTAbqq1B8k7ALORMss=;
        b=j6EB6vOUJ0Id2JFiQWZXVATj3sqo+roGgexDwpjumfjI3fJ5FJ5rqcXBjdS7vEE1Bq
         UojizeqK1W33SjFAbHEoR9UuOjh7n/2OoPLyec999NDImjvhM2fXKvkOX4b8ys1llIpT
         +w0jhxy36F0sHdrSyt4S0eyamzLcTsIG9FuQVoFeZ6oGQ0kxt8piAgB5txywsEG0gRgS
         i9tSpwqCQfH4mTIoDDwo2NBQxxI8bnR3eGkHcI3Sm+V3RWjvVqP1CSvUZ0moJVS9CNrv
         aLaDq7hiJeG7Vg0iKzZe6IRff+ASC8lLb/1SGk1k4RcjMMd6OL1XoGln0giuDdvig+Pn
         PLiQ==
X-Gm-Message-State: APzg51Ce+SSdGQka45KbhTVbBejnMO8vLI4/fMR9dMMTL8hdzawphgrS
        XHUmf3J3DZOnAf0JFAwwOhGNtg==
X-Google-Smtp-Source: ANB0VdZOmPdfOQDJDumDUozfBZZzbM1/TwP8pVufL+9W1e0MQUkMMX6xLp7L6MwPUbDclnHLOSKN4A==
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr6089307itc.16.1537537241722;
        Fri, 21 Sep 2018 06:40:41 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:41 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/26] nvmem: remove a stray newline
Date:   Fri, 21 Sep 2018 06:40:06 -0700
Message-Id: <20180921134026.4596-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are two empty lines between devm_nvmem_unregister() and
__nvmem_device_get(). Remove one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0e963d83a099..1ced9caa811b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -613,7 +613,6 @@ int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL(devm_nvmem_unregister);
 
-
 static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 					       struct nvmem_cell **cellp,
 					       const char *cell_id)
-- 
2.19.0

