Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB7C71125
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2F420652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTjEYY+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2F420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJNR6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 13:58:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39453 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeJNR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 13:58:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id d15-v6so15174637edq.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XNRTztLLrP7qH1JkVKw9HZH/QTPl4SqbDRmg5OAx5yo=;
        b=BTjEYY+sFUM7smMC+JfX53552NWZ98JZ65cGxiIggx1O2LaEFot2te2bVw2LblWKqU
         0brsha3TTZ405TJnBQCq0b7jx57qWxYpLcbc2u8uQDFOM1KRtv9at3toDkzKURyEbfoi
         Vo0ge+HOfKJ2o0OauzuUxBUvoDrXe2lBXGb2uCUCj8MIFOGcd3kidM/nJRLUctwkPKhl
         4qDpaLY2T6LTpXqkKujWQz4PzjR40BTeR2lcxSHoN8/8XJIoyT97dCJt8KhKyXDbapIy
         Q2Lod582eomzNFlu2iL/yd4jL4gVsJh4U5O2AF3FjK4lOHmjTp9NpoZsBu2BAPY/Hklk
         9cCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNRTztLLrP7qH1JkVKw9HZH/QTPl4SqbDRmg5OAx5yo=;
        b=NcLZtwftnhEAXKWvNfkJyk47nuc+w3Q43+Fy93GdetFfJqqfK/NnZ6WRSB5NP7dGE/
         HvyBbhlgwSGm8vX+Z9uwbZR/4JrgBdFhu43T4TuYe+sUXoSWH1gO5ZEUpgeenrTKPboq
         taqW3apzQZEwrOii7ON9FiAY3fvALwoFTJtrc4gr+ldYJsqBHlUT9b6eQntrSjgsbwoa
         9/MbKbIG9+fz+P6SOgusaLJtUYJMJLjJn5bMYbS+fWXVcUjNeFYpsn1YmfQiCmcIkoH8
         rtr6EI5MC7rsCgzqHBf7JCIGDsopoJ8O1TvjPq8isHoHCWYHsF0x6YB2B7pWYp/pM36t
         0CVA==
X-Gm-Message-State: ABuFfogBZ1rk1JO7i4RT9lkNUbyYvfyWC/D7yx2aUe55vszJ/9BYDBvj
        exmtB55ofEpI+3byCezyT6uGAuJI
X-Google-Smtp-Source: ACcGV62LwImGACVCR6ylB/MxTd1u9Dl8XS7ECOMCejs51osc3xPZurR9diLHqWtPwQ/8+e05Z+YplA==
X-Received: by 2002:a17:906:708:: with SMTP id y8-v6mr14434443ejb.175.1539512285463;
        Sun, 14 Oct 2018 03:18:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id o13-v6sm1475630ejb.34.2018.10.14.03.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 03:18:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 7/8] staging: rtl8188eu: rename Hal_MappingOutPipe() - style
Date:   Sun, 14 Oct 2018 12:17:41 +0200
Message-Id: <20181014101742.10952-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014101742.10952-1-straube.linux@gmail.com>
References: <20181014101742.10952-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename Hal_MappingOutPipe() to avoid CamelCase.
Hal_MappingOutPipe -> hal_mapping_out_pipe

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_com.c     | 2 +-
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 2 +-
 drivers/staging/rtl8188eu/include/hal_com.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index 3e93760a2816..6db5c34ed02e 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -262,7 +262,7 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 	}
 }
 
-bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
+bool hal_mapping_out_pipe(struct adapter *adapter, u8 numoutpipe)
 {
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
 	bool  wifi_cfg = (pregistrypriv->wifi_spec) ? true : false;
diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 8f26427a8bc9..f25d52fbb341 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -52,7 +52,7 @@ static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumInPip
 
 	/*  All config other than above support one Bulk IN and one Interrupt IN. */
 
-	result = Hal_MappingOutPipe(adapt, NumOutPipe);
+	result = hal_mapping_out_pipe(adapt, NumOutPipe);
 
 	return result;
 }
diff --git a/drivers/staging/rtl8188eu/include/hal_com.h b/drivers/staging/rtl8188eu/include/hal_com.h
index a2d8108f9ef1..2f7bdade40a5 100644
--- a/drivers/staging/rtl8188eu/include/hal_com.h
+++ b/drivers/staging/rtl8188eu/include/hal_com.h
@@ -146,7 +146,7 @@ u8 MRateToHwRate(u8 rate);
 
 void hal_set_brate_cfg(u8 *brates, u16 *rate_cfg);
 
-bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe);
+bool hal_mapping_out_pipe(struct adapter *adapter, u8 numoutpipe);
 
 void hal_init_macaddr(struct adapter *adapter);
 #endif /* __HAL_COMMON_H__ */
-- 
2.19.1

