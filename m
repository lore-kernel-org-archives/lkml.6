Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A96FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320F621B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SBz5c+25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbfBOPZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:25:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52360 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfBOPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:25:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so10343294wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1dckFGTvQZYZhzzGrXR67W/UknA8fLi1pgVAz9HiRo=;
        b=SBz5c+25n9ero2mxCaWzbMROn/Xwy+rvqBb3syanJhg8NJpmX/tRY2aCn8Qt8Edkd5
         MJNE77cpoJSO/1111I7+S4b7casfJy7aQy32p9AhSxuQndSOCgT7g7910cjmG1q6/9Py
         wzS4OEp0IozpNcfzswpb4bLD53VAJXjtbkm2pP2DVgWNhnuBp0DRj4o90TD/CIYsK70C
         yKMF4PGawtELQdJCEHuq0HaaBmrQ3VrrCnaWzQVJnOwk2Wnnc402AM4+fC4Nq+EQeqYI
         x3ltrvbmxso1Tuwcpt3hPWEwqR3wr02KE8Ykf3NWotaiNGqhF6x7+j+I+BJ8JUGW8b5k
         pL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f1dckFGTvQZYZhzzGrXR67W/UknA8fLi1pgVAz9HiRo=;
        b=r8XEswvzuz9zH0qH42H5t+2R08ec4Tbw0hiKTYD0lHyuzM7ga1SnCA6/R/Tq5U2UYS
         75IRiJ0P4ul25bElDHU/x2+28RFc9oalsRYlGFM1xs+rH2FxvCXHxv043qRlBlOLbWQz
         JhPWO9SnWei6bj7ce/SVaMN3Nlif0MEPTb6VdK0TIpG9ZsT+hFaDfhLcJYmT776bXPtq
         qvby3e8Z3cUR8cUoXy0j+yLRXkIs4J5peZivVBAy+9VnMVLVhwsFdQJfoLFRB9f2Iy6x
         wCF3chxVXmdkm4epwwHod07Wns7elMb+BLTg0wMm6sWr8Dopc8DXkdURgAXU+RSyhRjY
         pQUQ==
X-Gm-Message-State: AHQUAubzf75msNKZHMyRFPpnUhg0yVnMniD1ocJwxQbM/5FCd5BanW5l
        b4ojarGNMnUactbRKCAFBB3kiA==
X-Google-Smtp-Source: AHgI3IbzW2wp/4etnh1CI/wbfZWmg5uqbWhiL1NBc5R+hrHrR7m90cXdLcjy7Fp5C6CrxN9p1AvjRA==
X-Received: by 2002:a1c:2097:: with SMTP id g145mr6637328wmg.81.1550244317511;
        Fri, 15 Feb 2019 07:25:17 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-7-43.w90-86.abo.wanadoo.fr. [90.86.124.43])
        by smtp.gmail.com with ESMTPSA id y5sm1904337wmg.31.2019.02.15.07.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:25:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] drivers: new helper for ioremapping memory resources
Date:   Fri, 15 Feb 2019 16:25:05 +0100
Message-Id: <20190215152507.31066-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are currently 1200+ instances of using platform_get_resource()
and devm_ioremap_resource() together in the kernel tree. It's a minor
redundancy, but consolidation is always good.

The first patch in this series adds a wrapper for these two calls and
the second uses it in a driver I could test.

If accepted I can prepare a script that'll apply this tree-wide.

Bartosz Golaszewski (2):
  drivers: provide devm_platform_ioremap_resource()
  gpio: davinci: use devm_platform_ioremap_resource()

 drivers/base/platform.c         | 18 ++++++++++++++++++
 drivers/gpio/gpio-davinci.c     |  4 +---
 include/linux/platform_device.h |  3 +++
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.20.1

