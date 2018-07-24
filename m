Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074BEC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE4B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo6bM8DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE4B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbeGXXbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:31:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37539 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388834AbeGXXbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:31:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so4030048wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQ1hrQIbXo4ILuEEm0+/82cRNiOE8p1XgzNfg9kLRKo=;
        b=mo6bM8DDHliRFyXNz0/2IuMlqmZTzASHuGtQl5enBFxkCW0qTt7ubCilewqM02NVDM
         Onphazi6JGmOgppf8vLNbYoTxJxqSwsRKBEWuyRvIQI7qt2Vi7JngFpMT9KtsxTo9owH
         MnI8+f/Sv5HYJ6gXrdvjK8Sr0GaDA7fbp2441fiPKZoJcvlguUb4xT43G3OZjFOyutzB
         wiYUr9AJj6hZ4ObTBCS8zoL4eIhoTMceNoFwOT63tAsFnEfRQwz+or8xk7blFEkNU8l9
         6kmQaFaCC/vghaAe3LdbRoYNXOCL8Oa7gDsxtFhEMsOggaXShUnx9XU+TDJrxJEe6/vf
         OWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQ1hrQIbXo4ILuEEm0+/82cRNiOE8p1XgzNfg9kLRKo=;
        b=ggyYzdxxJdTe/dAgkMzSir3L+3dyEmv4zAWelYIeToHrUmGrQbkljxCeM4dpsqm+k3
         2B6uv6elIVPqKcmZe5p0qyDJfoVu0m9cmF6IZP/lbJlti3QY1bFieGlYUfcQGpOmwLnB
         2rmb9pXgO+ndrWiOiY3EZXvno0F1kjYIzGt+WRBmk1AYwAzcL5gIppMg/4Dkx8K/9moG
         2VhQtwe2pmgAviBJkZ6sykUYB6dpv68lf3D6xyWeACAvl+wLrgMZFO0xa57drWYcwfS3
         KKVr+JNoLGw9C13VGEJRJo9+//uWiYhq4V7aynvT0Cpdw9B5ZBKbiVkyWNGJNZBAGLBE
         A4dQ==
X-Gm-Message-State: AOUpUlGifiFuVqrnfLqaez57ucFC1eRAjR2ubHsLJf2fe7UZ3HT/7XaQ
        MX4ZsujHF4NEoWytEj3h9VM=
X-Google-Smtp-Source: AAOMgpfOLj33+Q+ReDsmPmZgFuSoeRrv2XKYJhEWI0280WL7mZEx8ASKW5G0nn6xLm6+Oywh9neqJQ==
X-Received: by 2002:a1c:3f08:: with SMTP id m8-v6mr3258448wma.88.1532470946966;
        Tue, 24 Jul 2018 15:22:26 -0700 (PDT)
Received: from we.local (athedsl-4407117.home.otenet.gr. [79.130.175.61])
        by smtp.gmail.com with ESMTPSA id b6-v6sm20221035wru.66.2018.07.24.15.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:22:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by we.local (Postfix) with ESMTP id 3D77F6408C2;
        Wed, 25 Jul 2018 01:22:23 +0300 (EEST)
X-Virus-Scanned: amavisd-new at local
Received: from we.local ([127.0.0.1])
        by localhost (we.local [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6O66GTm4pmsj; Wed, 25 Jul 2018 01:22:22 +0300 (EEST)
Received: by we.local (Postfix, from userid 1000)
        id 684D66408C3; Wed, 25 Jul 2018 01:22:21 +0300 (EEST)
From:   Georgios Tsotsos <tsotsos@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Georgios Tsotsos <tsotsos@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        James Hogan <jhogan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Staging: octeon-usb: Adds SPDX License Identifier
Date:   Wed, 25 Jul 2018 01:22:12 +0300
Message-Id: <20180724222212.8742-6-tsotsos@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180724222212.8742-1-tsotsos@gmail.com>
References: <20180724222212.8742-1-tsotsos@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Georgios Tsotsos <tsotsos@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/staging/octeon-usb/octeon-hcd.h
index 3353aefe662e..769c36cf6614 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.h
+++ b/drivers/staging/octeon-usb/octeon-hcd.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Octeon HCD hardware register definitions.
  *
-- 
2.16.4

