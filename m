Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E44ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EB820854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzOu5TTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EB820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeGUUEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34628 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so14138197wrt.1;
        Sat, 21 Jul 2018 12:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ymlCkC7UtcvznfbwfCWP7nAOLsnaf7ommwT//m37oPw=;
        b=ZzOu5TTIfh0/jPIUpSv6nLOHQetPSBw/zoIc2R7nfpquZO6ZGjUocLpAErPzl2Xv2z
         F9voG9rO5FLvRjM4Mo2jvT1g8Ml6Hm9LdBqgGiYFetdBFoKeNWBRhCPqZkNSAeEy/G9d
         9odUjZQ5BQxH2ROl3fsoCflPpVlaDiPeXFGSXE6P0nJGNhyiHmDuZJvdw3pQId7Apizw
         PjrdY9luSQVW2q4sPebsiZ7At6ZbZjcRvMjMqMvdOysIsz/nmpc7ttGTdih+AhraGBre
         0vDJK8JoGbGYaqFnSVXhVCeKOKuY0OLKHaVTEt4y5I/YW9/RgcpygSSdQcao5nvujb9k
         KcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ymlCkC7UtcvznfbwfCWP7nAOLsnaf7ommwT//m37oPw=;
        b=KOWQ/jxj1LpTg4fTLin8YMMnPZGhDqI66ISnZWCedcn5X3UJ+3uUCtDu//sYq4eaUB
         tEg3EGt8UYpSz6ZTwvl9sZwz3PIabXn4Ie0iO7JIc5UElM+qDxmIYDbQ+VkwpPrX8nGP
         sVewFoBJV1biIqeyV+oLopsNNEBogl7/WdugsulZ3D93whwIGSk8aCq9mRj/U/SYUAfX
         8ARrq3ahn8DokYmnrebpjlbtTg3SE8eZy9XP67kBB7VupwQFnMl8e/D+c5nTlCXe4avs
         xlkIu9Ke7P9Z/DIdVBZQ0UcHjP8WcxLwAG2WSoIHeCS6D3p+kbdHqNWH1wJ9PlVTsTOZ
         sMyQ==
X-Gm-Message-State: AOUpUlF/rSwJO8tw5uHozJG4MHCs0wnQiCWf68mnxdh/gleYaQJKubGd
        ZUy0XY4Y/lBLyUTJGpEllxE=
X-Google-Smtp-Source: AAOMgpfH0Gb2wkcottbFEhhX56dnkKU4VI7qTpqbkKVLizj0Yq5aqaOYDRxoQWhk/8WrdZ9XsDxiPQ==
X-Received: by 2002:adf:e14a:: with SMTP id f10-v6mr4321555wri.42.1532200246949;
        Sat, 21 Jul 2018 12:10:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:10:46 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] touchscreen: ili210x: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:46 +0530
Message-Id: <20180721191029.25658-5-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(calibrate, S_IWUSR, NULL, ili210x_calibrate);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/ili210x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 6f76eeedf465..07526a6f2cb7 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -169,7 +169,7 @@ static ssize_t ili210x_calibrate(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(calibrate, S_IWUSR, NULL, ili210x_calibrate);
+static DEVICE_ATTR(calibrate, 0200, NULL, ili210x_calibrate);
 
 static struct attribute *ili210x_attributes[] = {
 	&dev_attr_calibrate.attr,
-- 
2.17.1

