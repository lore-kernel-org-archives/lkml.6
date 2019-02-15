Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C4D2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/UVc6Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405777AbfBOKk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:40:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51623 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405722AbfBOKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:40:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so9451621wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=weY+02WyQtYURWgOqk/sehPDo0eed1gHxxbmbDDrodg=;
        b=f/UVc6ImQ+JYHzqD6YxuotULEey2fKgeyS3yYswfkwkQ9bkfh0X4X6Udrw3ghBr/f1
         XFB9SrcCgYYlzMbn/588tI//Am87IzkoG+Jt1HOOQx/IU28j0D83f3MnGEoDThxzGNfk
         SB84ayWhGNu/wCM8b6gEl/zfAWk4alNJ11HYh/LI2Exirx8KGMSTVNXJ+Mi7Pe3A+NxW
         4fugOhb3MmE1KoYJd1XJL8+2L6o5oAixOvB6RPGUP6f6MEyhBwATkjYrZd8QjWUyg+tL
         XAWzgyvJvL7XrkF4a8LUtfYVS5OmyUVYXuheANUFw5/nmqICMUhZMyZhLSwp3YTwRfUu
         IjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=weY+02WyQtYURWgOqk/sehPDo0eed1gHxxbmbDDrodg=;
        b=On1XDDv7vvQRIvv7ZZHqbXjMP4tj/cDjZZtyTrAHiPn9WcsUO5zDs37g2/DWr6TcAd
         qLVsK8FJq3bY9AvtkqUCMq/Mlham0Dt/NDzRs66nwHCKqSMzvbMo0eyLYUkLK/Ft9iPo
         AjVhjA7+RWn/53jlGrgVUJf0412krlLq+1Ul5tXsHxvsYYFptXG6PHw72ZeFxMtC+MqH
         QiyjvZ2/Ike5/vo1bp8yrDeCWzGZb+lsr5z9yxoNFTvShndR3Mj91pXydqPcWeCOUuKl
         Esj89osH4THJi/Aql2GmhPT96uIOw3KgmTZ16d47Pa8jASCdUdmnfl3RUMhOn0pYAuZJ
         eSQQ==
X-Gm-Message-State: AHQUAuaVqgwwv+d7dFRvgUwvxeHCdUfJG/hIT7HJGIKPSmQVswyyv4Ms
        OuOo03Km+k4V7fnMgSTY2Br7OfBd3B8=
X-Google-Smtp-Source: AHgI3Ibs8O+U+Dp8EkWM2PgpV1vdshA7g+D7a04x/EDW3qQ5nG8O9QMblnwXO4pYYm8EmKYyXY8Qqg==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr5894201wmj.103.1550227248097;
        Fri, 15 Feb 2019 02:40:48 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v4sm6525577wme.6.2019.02.15.02.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Feb 2019 02:40:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] misc: fastrpc: Fix device_open when no session is available
Date:   Fri, 15 Feb 2019 10:40:07 +0000
Message-Id: <20190215104007.27103-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215104007.27103-1-srinivas.kandagatla@linaro.org>
References: <20190215104007.27103-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Escande <thierry.escande@linaro.org>

This change fixes fastrpc_device_open() when no session is available and
return an error in such case.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4b0db33896df..89aec17738ef 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1016,10 +1016,19 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	INIT_LIST_HEAD(&fl->user);
 	fl->tgid = current->tgid;
 	fl->cctx = cctx;
+
+	fl->sctx = fastrpc_session_alloc(cctx);
+	if (!fl->sctx) {
+		dev_err(&cctx->rpdev->dev, "No session available\n");
+		mutex_destroy(&fl->mutex);
+		kfree(fl);
+
+		return -EBUSY;
+	}
+
 	spin_lock(&cctx->lock);
 	list_add_tail(&fl->user, &cctx->users);
 	spin_unlock(&cctx->lock);
-	fl->sctx = fastrpc_session_alloc(cctx);
 
 	return 0;
 }
-- 
2.20.1

