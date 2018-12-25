Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FBBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF8621773
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="LIjeBLsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeLYIDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 03:03:41 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:37984 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLYIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 03:03:40 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 45AE5CA4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 08:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fn1xjai3eDKL for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 02:03:39 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 1024B93D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 02:03:39 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id t4so1386663iog.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 00:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JcN3Rf30IuJKLJ4ezaJyg+AZGeSySBgxTmgFWUrU114=;
        b=LIjeBLsPmwAWWn+71fCKNzqA8+DB/f3OFnE4OiaWTfrez1di1VA/MYdieYZyqp/Lm5
         k/rB9JdCWyZ4EZfRC5Yv883MlUHBLD0POcA+Fn4YBa12Dv/kYmvde59Atw8gsAGkNyS3
         YDZeB1dhIYUKofqQVX+lw/IinF2PIYNKQZFhMxICyek5LF5I+BpqfmZa0CmNhkabWiKa
         bbIN0+fWBwroYyrUxYrjlE8SNPDzjU4BYX/OjqQ1TQZ39fBnEqBIZObZGmyhH8onqM5G
         H6cCWKKW/AScxqPdw/BkdUittDjsoDvtg8HF0eoejImYF3lOHO7MXoHDqH8Dz42tL9/S
         WGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JcN3Rf30IuJKLJ4ezaJyg+AZGeSySBgxTmgFWUrU114=;
        b=YtIKbCGJVt4a/EBJPmNgGG1kGzLSVK4iYbV1WKOB4np6LdsKtGiart7UrkOzloFd5e
         b9HUlD/vCWJUIRxuoFgnI0aztKmOFvFLZbn8hZrcT6fljOQvuiGJH62A8qJXvUBGtbcT
         9n+BR8HQwSpywtiVcfKSiEUbdWL1uOKcCiKzUnn41eCusMjTXIXnNCk2Yp4Hzi2ew9AI
         FtcLh45eev1QqGXSDLLkyZkzXj0VQX5u5RB4gjwZ+O8NCi5IPBdAAZLjFYz4jca3FWhP
         ZO5HJX1J7lCMhpG5M8xFRBfb4c0eFuhIZq2mkDi2dY42KqkZg1B5pcaGgo5FpVT1+gp1
         ikqw==
X-Gm-Message-State: AJcUukcEJ9ID/jncMIvWs2xBmHNIcDbl9WBrZHvH7j1oi6NTDtY0JVTi
        kkNiQKp6ZxRigAM4JjbxpOqX2tOGDTkO71IoQ/gIif8HEpIyPziMg4uIbMQlQ+OuCXXlyEG3V+g
        WKVrFauVs9OcNOWaSypQJeHApUTCg
X-Received: by 2002:a6b:7207:: with SMTP id n7mr7521865ioc.85.1545725018687;
        Tue, 25 Dec 2018 00:03:38 -0800 (PST)
X-Google-Smtp-Source: ALg8bN48UKF0grf5fy6j9qdAJIjgduCLRUggvwQL104DTkqlUIqNYou4KUWrwG69IDnWS4bskntXmA==
X-Received: by 2002:a6b:7207:: with SMTP id n7mr7521855ioc.85.1545725018471;
        Tue, 25 Dec 2018 00:03:38 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id k18sm8808iog.31.2018.12.25.00.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 00:03:37 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Rosin <peda@axentia.se>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: drxk: add a missed check of the return value of write16
Date:   Tue, 25 Dec 2018 02:03:07 -0600
Message-Id: <20181225080308.68178-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

write16() could fail. The fix inserts a check for its return value
in case it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/media/dvb-frontends/drxk_hard.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 84ac3f73f8fe..b7579ffae690 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -6610,7 +6610,9 @@ static int drxk_get_stats(struct dvb_frontend *fe)
 	if (status < 0)
 		goto error;
 	pkt_error_count = reg16;
-	write16(state, SCU_RAM_FEC_ACCUM_PKT_FAILURES__A, 0);
+	status = write16(state, SCU_RAM_FEC_ACCUM_PKT_FAILURES__A, 0);
+	if (status < 0)
+		goto error;
 
 	post_bit_err_count *= post_bit_error_scale;
 
-- 
2.17.2 (Apple Git-113)

