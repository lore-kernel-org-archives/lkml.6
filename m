Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF5AC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CB72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pGilnP/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CB72075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbeJYAHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:07:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54472 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJYAHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:07:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so5910913wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQo5A0wyypmhGUbKa0DCkg0XzQwxpTxcSTeITbOR2Z8=;
        b=pGilnP/6SeMnbKUl0A0dWZnQRxys7uzD8U3sAY6TPjzVxkFcg16nzn+atmwvTCYVDJ
         JCRSUAgxXpLSlulYp3ZCDad83zJVoxQGZzbTyQ6B6/eko1GAZzMgv7MlXDyNxuLR6QJf
         QrFkR1u6qc8rG0JgPYnVTr2T//EeGwPc1VBadAnJHY9Ix63IFW2Z0fxBIEMFWcX4Kft/
         SJHlm5H6JZ/5yl9wGVwd46ZUBa+qjbbnVJUw5llyXFAs/I97FMFPPccygedqF01eWkHd
         +jg3RvdzJructvr24Q8VCcf8Y9jcA/PZB7ZB0VUN+6YyMbITim5ZgUAacuN2XxtdzhYX
         ieWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQo5A0wyypmhGUbKa0DCkg0XzQwxpTxcSTeITbOR2Z8=;
        b=LAuusiw+sFQEVRTdso6B0txPoT40KhxXExqIMWkgCq21jQd9jBpcd9HSF2N8u9D4rF
         ikYc4K2SmNG6mnku/wF7r6vYY4dEQEnPKIsILjAnvdHC6QyMvfp6C6oJPduNCVCwlyk7
         Ub8I7QMGTCgCmW/u2XG1jz6Aq1CtTw9Dft/bmJG0VbRD2Orv5V95jbbT/Um/QtDfe5Wg
         fUrxV0xL6Ur8PBqzksAjslG27Az2DpePTtycVkjttyih3k9Xt8PbWzzO+t3s+aLxqSU6
         FYazlge8SeuldbsmRKePhKpsPof367absWYooQWw1N4hddKwGaWQsxkERgvqUFHvfs6D
         I5Ig==
X-Gm-Message-State: AGRZ1gJwXHRsfbY7XeJdv6P0tTQn4bgvnZttKNwW7ylMiuF4wLi84LF+
        9Q+hmp3rWcTmVzKHOwQtn7HN1A==
X-Google-Smtp-Source: AJdET5eyyHoAqBC89Hj23STGBRJGR+JauYQcbVNr1Wlu21U5VRtlhjOomLH6A1EKm8XBwqfvzGzAFg==
X-Received: by 2002:a1c:118c:: with SMTP id 134-v6mr3124521wmr.75.1540395555259;
        Wed, 24 Oct 2018 08:39:15 -0700 (PDT)
Received: from debian-brgl.event.pylonone.net ([185.7.230.216])
        by smtp.gmail.com with ESMTPSA id e142-v6sm11223761wmf.20.2018.10.24.08.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 08:39:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH] MAINTAINERS: add myself as co-maintainer of gpiolib
Date:   Wed, 24 Oct 2018 17:38:43 +0200
Message-Id: <20181024153843.16021-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

As discussed with Linus Walleij - I'm adding myself as
the co-maintainer.

Cc: Benoît Cousson <bcousson@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af2a61a31a8e..facf6a859854 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6279,6 +6279,7 @@ F:	tools/testing/selftests/gpio/
 
 GPIO SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
+M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
 L:	linux-gpio@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 S:	Maintained
-- 
2.19.1

