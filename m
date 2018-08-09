Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F889C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D182521EC4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDJvMdr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D182521EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeHISua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:50:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33768 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbeHISu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:50:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so4966272ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IPd6YBYVPcNUm07C5G7ey/jSlVjSbZzuqG4sLrrXf/s=;
        b=WDJvMdr2T2OBoVyOA+nIAOhSWQjybDFMMplER35MFiylZ/SJKOGkQiSgZZzefrHn2t
         sWmUzwr3NzGihF/SAs4llYPpCWES94b4iZksSnYiv3b4UVCFEtQkBUFS6VL2IbkOMkzF
         8ry3XnekzNiZrq/fCcfdBRFfSawJssmfwWBEc4NW1yfb2ZeNz22kW2BUh1N7gxq8auVx
         7BobVRcyfVResQIeiXPiCihXROUn4RPFFuMEeeZNBlAGXOMKmo/BUY1apVTIVCG+/xpe
         zKGEWcUaRQkNxDXmITB2BvxktTXeh6ueEHr1ES3RQN4eWnqp5MMj0R80MXeIHdW/M6Oo
         mFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IPd6YBYVPcNUm07C5G7ey/jSlVjSbZzuqG4sLrrXf/s=;
        b=jJEEOIYyKO9YCvQ5Y8EE15sQ/fP01OuGrW4EB925M4bkqgAlsvSwyJnEveHtQ1p7h7
         h4SbbrmM75e/ygU5cwEvMZ7gfwFmQVt7yjQgRQAUGJzc9Tpd0+edzEzm1xhJv+3Xs2lc
         vysnOXFu2U9WJyiJgE8S7E7TyzpZe4Kb8QxnJRqnvBaNa049bg87+MAJjXakcr9VcwV8
         Cr+PSZ89vr982tF/l4aq0oADgietydqjPzKOXGVSZdhq1/LnLvCk4lq0dj4xmPPYvYM9
         /3Xdp/3Te2MM9pgtPmt/56mLJCDRAIraXO4B4PocYHqNAr4hc2Tl04nzGpJbOj26axxw
         aoSw==
X-Gm-Message-State: AOUpUlGw2rYqnoZR1dCh4tK9UOsiCX3EU3jrHvxYDbsc5tE05BoaARxI
        saeTHr2QHgQR0da4OS/s3h4=
X-Google-Smtp-Source: AA+uWPwm08bGwH7m7XD/SbvFHKY3/XmaMS3xh0TkF9wAfqk0/4yDEFC3tyTORFaBkirqahW2aYPGmw==
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr2116344ljf.36.1533831890754;
        Thu, 09 Aug 2018 09:24:50 -0700 (PDT)
Received: from localhost.localdomain (185.59.110.199.maxnet.net.pl. [185.59.110.199])
        by smtp.gmail.com with ESMTPSA id w12-v6sm1218215lji.63.2018.08.09.09.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Aug 2018 09:24:50 -0700 (PDT)
From:   Arkadiusz Lis <areklis909@gmail.com>
To:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Arkadiusz Lis <areklis909@gmail.com>
Subject: [PATCH] Staging: One Laptop Per Child: add function argument names
Date:   Thu,  9 Aug 2018 18:23:59 +0200
Message-Id: <1533831839-7361-1-git-send-email-areklis909@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function argument names to pointers to functions
in struct dcon_platform_data: init, set_dconload and read_status
This commit removes checkpatch.pl warning.

Signed-off-by: Arkadiusz Lis <areklis909@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
index fa89bb9..0ce1a7a 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.h
+++ b/drivers/staging/olpc_dcon/olpc_dcon.h
@@ -91,10 +91,10 @@ struct dcon_priv {
 };
 
 struct dcon_platform_data {
-	int (*init)(struct dcon_priv *);
+	int (*init)(struct dcon_priv *dcon);
 	void (*bus_stabilize_wiggle)(void);
-	void (*set_dconload)(int);
-	int (*read_status)(u8 *);
+	void (*set_dconload)(int val);
+	int (*read_status)(u8 *status);
 };
 
 #include <linux/interrupt.h>
-- 
1.9.1

