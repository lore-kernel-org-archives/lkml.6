Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7431ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F96920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sXiBWjbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F96920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeKIC3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:29:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33679 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIC3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:29:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so1965914wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnT+CPZ5Ez8yylU6/4sQZKyJDq+mZGE2QCWEaDqPJbU=;
        b=sXiBWjbZ2i6QFAJUhDcr5/ALQi5tl1ur3GMVfvkwYHuTpohpXmFSMnM6HmspQUAAXO
         FYmz+WPyRN7DUubqsUR/U+TfjCFGvMRCOygj1YsLqatg4J3ab5fDPkxE3Bjhx9MOXaf4
         rXw5unH8d5sMge9IbLRi/Zjt0H+0SBHrJU6CVCrxbgLePIw8UOGJbUteEjl0xpLgeDsR
         /wXNerguDhbyySTvPhROgy1nhMNQi6XhqUljymJKq9jVrigdeNfbAOUjFp7cgkpVI/go
         Ia6ePyr19Qp19NaQaSENHOqvebvIJgSF9xvR2t+aez/PKrbteiGbPqNIs7QqLR57oBZy
         BiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xnT+CPZ5Ez8yylU6/4sQZKyJDq+mZGE2QCWEaDqPJbU=;
        b=K+iAB5+R/nhcHTmn00/e3GMnh/nSLmowQEHAEyfw/xDLSppnvWDvS53vzBPHK2quVS
         vHhoFkDdxgpApmGB4uG1ZYMXTNf8nZhZ6M86EkAv+Ei2jxcd0ErPmORtcw+kxOfwih+F
         cjfSFSWqjtRzkmsA8sVvCPZpUMU/lDMydtjvUyLKv6ohK/pFg347cVHsrL/sRcDSNhtq
         +TXhgoa4ZjRbsjGfQG4AmnuOPQu1H1jMNscbI4PFy6D69NfwuUH0YoqrQL0b7jPXmEG4
         oC5rIPekBXN61xSPyg4XzFHDOoIuqW0bsONVZY2jZa9ZQ+aLJNnOz3I1hp0wm1L/S33/
         gh+Q==
X-Gm-Message-State: AGRZ1gKQqs1GH5Us8KQARI5H8HQk9sjUS50oSlOKwQftc+Ni44M75sTU
        I7a++uRPm0aJHFdj7yvT0cwaTg==
X-Google-Smtp-Source: AJdET5e5a6yqwEEK72rB+lT0J4PvCSf9ZvrH4/Idvi4TTahUBKriAeGMF8WHMR5VFXkXrASDJcefVg==
X-Received: by 2002:a1c:992:: with SMTP id 140-v6mr1876605wmj.136.1541695988125;
        Thu, 08 Nov 2018 08:53:08 -0800 (PST)
Received: from debian-brgl.lan ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h5-v6sm7815987wrs.51.2018.11.08.08.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:53:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] gpio: mockup: misc updates
Date:   Thu,  8 Nov 2018 17:52:52 +0100
Message-Id: <20181108165255.9940-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is a fix that should go in for 4.20.

Next two patches introduce features for 4.21 - lock protection of the
dummy chip structures and implementation of the get_multiple() callback.

Bartosz Golaszewski (3):
  gpio: mockup: fix indicated direction
  gpio: mockup: add locking
  gpio: mockup: implement get_multiple()

 drivers/gpio/gpio-mockup.c | 71 +++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 9 deletions(-)

-- 
2.19.1

