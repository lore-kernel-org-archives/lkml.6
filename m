Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143B0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB49320652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QS1plIOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB49320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966692AbeFSPM0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:12:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50724 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSPMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:12:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so1020434wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RCKGTvrqrdNij3T1TJhcCnK0Po9h/heawlL2PdS3fb0=;
        b=QS1plIOWJ1QBXvxTweGL29BXf4HUpH5Z2Hl16l7qjjjM8E3+4JDlY2+yU4lTt6eo1X
         x7FoQirUDGnsKSWSJNe0Nb9vzQ6Q+o/fFJp4p53d9DrPM5ImarRpymHlVtOI+i+Z5RjM
         mAUTHL/eBt8gFMd1xF1ZZecvHqYji91mitr1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RCKGTvrqrdNij3T1TJhcCnK0Po9h/heawlL2PdS3fb0=;
        b=rVVXgnopvwtPDK2fXPo+d15R2gsc4wpTIxNwtt9BsQOGb+g4eG5pffu1Nh3SQhOTcP
         btsoDpSN2qDWbk3fWjT7dVPmlm4ZJKQwgEE5d/Uo47DRp9CwYfcou1w8Vt7nuiYXvZZd
         KeNAxvyUqWEAhTJIBwQT3dksU8DUzVydln+1mFs3TtFqsId/Av6Y0FaCq5yjVpqw89H7
         5rpAAIAS2ectkoCQXf9KjZAk53pqBuTSZ7CWTPqIXkOWj+wzGTUmSHDrjTe/wvuvKT58
         uKUVZjs/cpw7ds6JagINJF8VpJsl6wfQMnBU0U8pP/A3hzdaShhyWoG54IIsMFjN1Fwu
         63Pg==
X-Gm-Message-State: APt69E3neQMAtF25ql7JAtLxlwbVgXg+qJkq6weypMVf034OY+KS0yT4
        qvMCqhSsquR6EBqOp8vuOv/f8w==
X-Google-Smtp-Source: ADUXVKJZ68gMXRd4z65Q1I7C6236mzd6FzTVd98QqeiRZf7cshNVXhVxSeXooirASkCYR0N45o3H8A==
X-Received: by 2002:a1c:b80a:: with SMTP id i10-v6mr13012386wmf.123.1529421139156;
        Tue, 19 Jun 2018 08:12:19 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id f81-v6sm473599wmh.32.2018.06.19.08.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 08:12:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] slimbus: qcom: remove redundant depends in Kconfig
Date:   Tue, 19 Jun 2018 16:12:05 +0100
Message-Id: <20180619151205.11300-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
References: <20180619151205.11300-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM SLIMBus controller is already under a 'if SLIMBUS' in Kconfig,
having depends on SLIMBUS is totally redundant. Just remove it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 1a632fad597e..bfb78d9a6583 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -15,7 +15,6 @@ if SLIMBUS
 # SLIMbus controllers
 config SLIM_QCOM_CTRL
 	tristate "Qualcomm SLIMbus Manager Component"
-	depends on SLIMBUS
 	depends on HAS_IOMEM
 	help
 	  Select driver if Qualcomm's SLIMbus Manager Component is
-- 
2.16.2

