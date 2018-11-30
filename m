Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF2CC65BAF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808442145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eR81Gzpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808442145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeLAFx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:53:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43611 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeLAFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:53:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so2856085pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IG7KRCWaojU1bB2x6elFS8JLJg5OGapgO5FtAnCgCzM=;
        b=eR81GzpzDzdMjHwlH7UN8hQc2PhFXh4zxkagfQpuLUEoJz/H3yCRLL4gV6X7c6pL2g
         xOIZZUGPma3AUQJsZIb4UnRjn3c7Ez6dWs+y1LRv28eyBAa298s25pm+O1kOCe6zbokD
         je/h9wBxtXRRbXRY8jrb8Je0qcjAi8kN7JyMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IG7KRCWaojU1bB2x6elFS8JLJg5OGapgO5FtAnCgCzM=;
        b=TNCniwNF7dbp2wqUEf7cuyhvEZejGWh+TzPbnW2xr/9EE4bs+rZKQiLDksyWQJ/GjG
         w6E83xMBQZKBZ03wDvBQD6l5KugLhXEfDuXTQHHhaTtZKcgVkaHpqBAm0MQG8IQvDoqA
         gOgYtSSKNsKwNC2GzzlH+aTNePonL+lvut2w9SJHL9CyDOo/R7UlTa8yvWXoi+fU9W/h
         hT/SvVo4iv+9b/AKLJ9vu0Dt5jGXOAYD8mElZn2lC6AjvZvfeq+RS5bmPGG2HpPRJ9/o
         eKIoiANAjxypK4VRqnKobP28iibD57smo0xte09E0uEv6OTbOva/ewbuSzAs4ste36lD
         qhjQ==
X-Gm-Message-State: AA+aEWY9fhhcUw8aZ7peSljXnHtCuX0CItasWaSrSffP0nnXpc038i4H
        SMrsO8yO7Ov+FpEBlz9qdXt3w7d+Nbg=
X-Google-Smtp-Source: AFSGD/VruTurxButpnNWTJKd4LeKbbF5ewudhVyxxtbRET00jIeRD7eFXTLI25rW5Panaj2uw8Kn0Q==
X-Received: by 2002:a63:9749:: with SMTP id d9mr5591505pgo.415.1543603394789;
        Fri, 30 Nov 2018 10:43:14 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 10:43:14 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] coresight: fix spelling mistake "deffered" -> "deferred"
Date:   Fri, 30 Nov 2018 11:43:07 -0700
Message-Id: <1543603387-32645-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the dev_info error message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 35d6f9709274..ef339ff22090 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -856,7 +856,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	if (stm_register_device(dev, &drvdata->stm, THIS_MODULE)) {
 		dev_info(dev,
-			 "stm_register_device failed, probing deffered\n");
+			 "stm_register_device failed, probing deferred\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.7.4

