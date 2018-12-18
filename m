Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE959C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD52218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRIUyLp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeLRWAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:00:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeLRWAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:00:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so17461360wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 14:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ydSAlnd72VkQ6lGpPSCbYq4vE2P1PydjacJOrhz/zN0=;
        b=jRIUyLp/4QHRrny9LWddhWAJID7GF7mlDFGuK2DnWoswCv7oSP10H/WQBrHtf9JYve
         dakU/umJ5DqsjpHY0X7DjOIWA3ATFeMt4kItii6TFazvHROYMg1NAZNsdjtxu8ja8eH/
         ukVCXTHZYrYzF5ISBZ6jUyVKuTLvWgbUhMtsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ydSAlnd72VkQ6lGpPSCbYq4vE2P1PydjacJOrhz/zN0=;
        b=WVtbtK0CBkGcZmNMlIO1ci4D20K6vCVum7HTduaTwoCoNECUslb8QK+xP9pY4sagTK
         31KQ7/duofkV2ozrGNO+82SHuoqk1ZISEOxJp/8e7F4aMHMVHs+36ZIkDuu1ZDYfX5vE
         UU87vOVcd7JKeZx084jjAB3PY0I5UOgziogiKZ6iUaZGzt1M6/AF9ZWaVwhg3Cjx71BQ
         kyK9WF+kktwDIHej+4y4mZX23E1UeF/ybO/ngCNaddxYGGu4eSUUD6+DkcbVAzVUvMID
         sUC8CZrRm8hzN3NrIijVH+4fCPRIfs1cxC/86T2jFVujO35tarH6iF5iyubNAC+Ot90t
         GbHw==
X-Gm-Message-State: AA+aEWaRtxL288UQX7N4RAf/wF8iaIQwunqK4fzGoQSjdb4Ti4Dy6kSr
        Wc3PpHs9RApjw8/TYmEzzmR42Q==
X-Google-Smtp-Source: AFSGD/X2HJF+QVbYmnu/lOvYSqSKJL59TR2w9ELRB5bh0VQmaesbuMLoNXj6oTdNGAYM8hKZyRELhw==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr16815373wrw.34.1545170414485;
        Tue, 18 Dec 2018 14:00:14 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id x76sm7449158wmd.27.2018.12.18.14.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 14:00:13 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     mike.leach@linaro.org, linux@armlinux.org.uk
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v3 2/2] coresight: etmv4: Update ID register table to add  UCI support
Date:   Tue, 18 Dec 2018 21:59:44 +0000
Message-Id: <20181218215944.2444-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181218215944.2444-1-mike.leach@linaro.org>
References: <20181218215944.2444-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the ID register tables to contain a UCI entry for the A35 ETM
device to allow correct matching of driver in the amba bus code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 53e2fb6e86f6..2fb8054e43ab 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1073,12 +1073,28 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		.mask	= 0x000fffff,		\
 	}
 
+static struct amba_cs_uci_id uci_id_etm4[] = {
+	{
+		/*  ETMv4 UCI data */
+		.devarch	= 0x47704a13,
+		.devarch_mask	= 0xfff0ffff,
+		.devtype	= 0x00000013,
+	}
+};
+
+#define ETM4x_AMBA_UCI_ID(pid)			\
+	{					\
+		.id	= pid,			\
+		.mask	= 0x000fffff,		\
+		.data	= uci_id_etm4,		\
+	}
+
 static const struct amba_id etm4_ids[] = {
 	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
 	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
 	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
 	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
-	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	ETM4x_AMBA_UCI_ID(0x000bb9da),		/* Cortex-A35 */
 	{},
 };
 
-- 
2.19.1

