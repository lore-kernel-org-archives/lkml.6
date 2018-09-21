Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B66ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E3D2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZatlGjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E3D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbeIUPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:49:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40795 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeIUPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:49:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207-v6so2538027wme.5;
        Fri, 21 Sep 2018 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSx0ef2TUQP4ehNpFQ+0t0PfkVB4oEWMntfqZJFNvGw=;
        b=bZatlGjbPqcFLYaeupyWX5ek3OgW9FC0I5U6zteZo3e0fiDR5rKYavOTl8BLrLT27d
         WKzspsllAs+AP15jNrV8zZMQwAluVJ95jKoK0Yq9RMzvnpD09mqDuL+n4aIr+pqPlivd
         LgPAxwvIayDUfSG0lRlQqNZ7G55R6JOw5QB5CKG9p/z+xcSxHIEPJKdM3NS5gDqP8Mpw
         OFnXpchrMkAgNweMkLI82FbCfq33Ptul6GMBIQpV5hJooWD/sfQhNagKfyPmX4dtKdDD
         4J0acwmpua+Kh7xEn8OlIbQ9xNHO9L2ZaZqXbSDTxSsgjA+Ia7tdav8s8EnGcp9sxgDj
         qiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RSx0ef2TUQP4ehNpFQ+0t0PfkVB4oEWMntfqZJFNvGw=;
        b=KgdwvASnfoYCcy3TWssrZUPDMX8NZin2uo9FJodj073k3WbnIfkPScDSrZVDL9J+T0
         /yupRCpnrSPhpui2ShICAuiyPDN5oKsGLgTjp3Gd+3wkYQDnNvgpihYGacvAQezYH/Rd
         kgGFuoa3GwRLeDlZu/Tc0ODLnJEolpRzCmkbCDybYk3Cee1Ub3xNi/vUsVZfXyuTw2Mt
         u5xOWvUSAg10I5uEu6jJkAq8rZb1NrSRO4QgVB+vcDUlefmTrE/yYdX+ixVSmiuaxc/0
         cnFNX7Bc3n+ZY6Hyh29UOGk8H877pmrr9axN3lWbVjDVen+SKXQKvQf7bvgm1pLO7x0m
         pdlw==
X-Gm-Message-State: APzg51C8kOc5kPvCCrgK7NK3MPaS7f+0mKB28FtbBsncH9A0yYfXwuMF
        hY9HZGGfr/YLoyjiwL31+XQ=
X-Google-Smtp-Source: ANB0VdaNCVtXkPqbcKgqaApmyShMRCJ8M1YDtsqz4p8jA4h/nFKPAfOjYuUvafsU5MfuYgL63fLpwA==
X-Received: by 2002:a1c:ac1:: with SMTP id 184-v6mr6060079wmk.119.1537524055440;
        Fri, 21 Sep 2018 03:00:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id m68-v6sm8894354wmb.10.2018.09.21.03.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 03:00:54 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] media: pxa_camera: Fix check for pdev->dev.of_node
Date:   Fri, 21 Sep 2018 03:00:45 -0700
Message-Id: <20180921100045.20181-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/media/platform/pxa_camera.c:2400:17: warning: address of
'pdev->dev.of_node' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (&pdev->dev.of_node && !pcdev->pdata) {
             ~~~~~~~~~~^~~~~~~ ~~
1 warning generated.

Judging from the rest of the kernel, it seems like this was an error and
just the value of of_node should be checked rather than the address.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/media/platform/pxa_camera.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index 3288d22de2a0..6717834e8041 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -2397,7 +2397,7 @@ static int pxa_camera_probe(struct platform_device *pdev)
 	pcdev->res = res;
 
 	pcdev->pdata = pdev->dev.platform_data;
-	if (&pdev->dev.of_node && !pcdev->pdata) {
+	if (pdev->dev.of_node && !pcdev->pdata) {
 		err = pxa_camera_pdata_from_dt(&pdev->dev, pcdev, &pcdev->asd);
 	} else {
 		pcdev->platform_flags = pcdev->pdata->flags;
-- 
2.19.0

