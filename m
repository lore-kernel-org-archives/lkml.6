Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6469C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39B9224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="luTl4HCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39B9224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbeKMXtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:49:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56085 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732996AbeKMXtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:49:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id i73-v6so6704983wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXt5tOwWnUqzUxHs4I4UCWMdG9I4mq9Oz47yKE14Ty8=;
        b=luTl4HCvWkNvKbWwVsS8RC2pqGUZdNmNCZKPf6CNa15n+ttQT0Z7SuBHrM/MS+xJJU
         bAXpOnOpRyqL5ZZ9Mla284U159cPT4aG4nuhSudWRyTDdFS6d9jkj4cnmWwWmJNMiZgD
         56447OfbegzSuYX+7w8CCVoNEGF18GAsoiRdLEAgE0sjcUG6CxP8AyX/MmjpWt6lrIQq
         1pchWnCGgTt/GYDPVb1rcqo0pbYDwNAuDDdKlAqS7fqsbJ81PngpjAA2uVrwEkwq9TTk
         XYsqTr76tAfMJSBdImxpLNwZKsuxfy8IILwpS2oGXWKdCV/TiCT8cKLaMYuJuIaSBzW3
         5WMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXt5tOwWnUqzUxHs4I4UCWMdG9I4mq9Oz47yKE14Ty8=;
        b=Z7SlmzULcRM4+QJ22NF2RixBAXfolWV71r05iWXWdRLKKk4VyNdfJjBwqH9ElGlY39
         ogCaUMuWYYg77fkPxirJAxQbW3wSLvSNdczd7CmgZr655hRl9n1HJoFQynGtjbrc7aDM
         xnOWy57ztndjott0y6Za0SrIsH4Y+XlPcfg2kcY+8gFxN1lzKJXs3pUhVBT4d1vCXUuk
         TDtz9Dv0Mn7iG5J+CMfaonXs+pP9TqUKDGJbgjiZcY0esaPVKYnIgi+OZ/H4Lrwc+u5C
         MJidiS3Z0YKrL+Ewky4FW9vhtDKRBccuU2/kupSt5Oc1o6Hs8/UFJK6js6EZnU3VBOnS
         Q0QA==
X-Gm-Message-State: AGRZ1gKlRIGJu4z4LwYC8HM4X4s6PCubzIwiNfP7kMFq2ngaKDAXG0Fb
        D1z7S1mjVzyf8nKBmxsGXWcX1g==
X-Google-Smtp-Source: AJdET5epPjv1aA4Vd3EC/hpgK1PZu+EqAGr9PeW93Yh+xp6yysDq32zrv/SGjVwnYDrjuV3HTxCYGQ==
X-Received: by 2002:a1c:df05:: with SMTP id w5mr3436526wmg.37.1542117060961;
        Tue, 13 Nov 2018 05:51:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id j40-v6sm15170050wre.48.2018.11.13.05.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:51:00 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] ARM: davinci: fix ethernet support on da850-evm
Date:   Tue, 13 Nov 2018 14:50:48 +0100
Message-Id: <20181113135051.15308-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Ethernet doesn't work on da850-evm in legacy boot mode since v4.19. This
series addresses two problems I've found. I guess with this kind of
intrusive changes in the GPIO driver, other boards may be broken at the
moment too.

Bartosz Golaszewski (3):
  ARM: davinci: define gpio interrupts as separate resources
  gpio: davinci: restore a way to manually specify the GPIO base
  ARM: davinci: fix da850-evm boot in legacy mode

 arch/arm/mach-davinci/da850.c              |  4 ++-
 arch/arm/mach-davinci/devices-da8xx.c      | 42 +++++++++++++++++++++-
 drivers/gpio/gpio-davinci.c                |  2 +-
 include/linux/platform_data/gpio-davinci.h |  2 ++
 4 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.19.1

