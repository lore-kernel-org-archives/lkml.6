Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KSwPAuyGHltyOQAAmS7hNA
	; Mon, 11 Jun 2018 14:27:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3E1D360792; Mon, 11 Jun 2018 14:27:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djsguOgB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BB1E56074D;
	Mon, 11 Jun 2018 14:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB1E56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934700AbeFKO1z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:27:55 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36868 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934639AbeFKO1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:27:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id d8-v6so20649107wro.4;
        Mon, 11 Jun 2018 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JrH8Ij012fxadUQg2ac4/rVD+BQU/gbbLmpgAyRLZ40=;
        b=djsguOgBZk0tahd/Sk/UKcThoATqGoCqBrpjAv3z3yGk3aisAYI/UXin3idbwfwB4v
         eJm40jLygT7kJSiYV96XHHzgSXmDv/ESfqckQ2xXRd2m/0+yrM3G/hHu683uONn0qICk
         SjhIiz0qXIZ/1qkkONWnL6K9OGBmSJbk4yNSeT/hGVxAbIbrZodS6m1eUzAQAxOs/juC
         Ddzr0HgwQHgI3C8JYwyeK3jHA3l9TTI37PKysMZBeA4RLzNCqRFnTGNaihbJ0ZyoTJGi
         /0YL+k8Gx3n++a9QtcmD7TIoHFMS/yV6ddWviN2xEI6Narq9cI2FHuGgn+6ibUFJ4dNG
         EuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JrH8Ij012fxadUQg2ac4/rVD+BQU/gbbLmpgAyRLZ40=;
        b=LRBkI2uRKkJsdxct6S0IsEc8ht6Rcy5VsbqQ6A5pOU7exn0XLL+x5/FVKQjlE1Hien
         6q8yeC6GrpYhcoOZ0ushK9bx3iF20T5Iq3E8uJW+x968o448b21oX+oABLv8YgY6m9tu
         Dc8jmqjSXf1EENCanzsK8gjYRVB2KxnP6YtjktHbEfgbvFtvXrJxgJGbUoUuhLJcFy56
         DLN2C/0RJ7ekvqLsyz/tCq1ZajFS+UUJJJFb2nVw2oMZW5ZBYJh1q2AC/O/K90Yhtat8
         IRtfvZado62KWPNz+CiOJLPqIf9acCzNT7YT+OsWtve3AKpgjKvslw5tVGn1YvHgMitE
         CWuw==
X-Gm-Message-State: APt69E25sm+hHcPHzSV9sxCSmOPvumemBJQrXTv8tvBNHgYJwkyHmUxt
        kojM33+YRw5sGh0C6+Pqy1I=
X-Google-Smtp-Source: ADUXVKK9f7f+rHNt8exA6JpIdu8zC/LeXfnm/HL89yRzcjW2Y/dbGLeCTn12cxcNCb/WdIjnKZErjg==
X-Received: by 2002:adf:9663:: with SMTP id c32-v6mr13938968wra.89.1528727265266;
        Mon, 11 Jun 2018 07:27:45 -0700 (PDT)
Received: from localhost.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id y18-v6sm36204266wrl.53.2018.06.11.07.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 07:27:44 -0700 (PDT)
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: davem@davemloft.net
Cc: tobin@apporbit.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arcnet: com20020: Fixup missing SLOWARB bit
Date: Mon, 11 Jun 2018 16:27:37 +0200
Message-Id: <20180611142737.20983-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

If com20020 clock is major of 40Mhz SLOWARB bit is requested.

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/net/arcnet/com20020.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index 8d979a66d8e9..1a0fd30fe8ae 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -133,6 +133,10 @@ int com20020_check(struct net_device *dev)
 	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
 	lp->setup2 = (lp->clockm << 4) | 8;
 
+	/* If clock is major of 40Mhz, SLOWARB bit must be set */
+	if (lp->clockm > 1)
+		lp->setup2 |= SLOWARB;
+
 	/* CHECK: should we do this for SOHARD cards ? */
 	/* Enable P1Mode for backplane mode */
 	lp->setup = lp->setup | P1MODE;
-- 
2.14.4
