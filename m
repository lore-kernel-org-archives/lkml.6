Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE790C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A3A20989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="QjjKcr+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A3A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbeKTXDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:03:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51400 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeKTXDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:03:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so1966257wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0mMvGGdPnorv2EU34yI8jmz8GqACAgWYdGh+p8ZMsQ=;
        b=QjjKcr+spuuqKFzX57KKnwfFkycaAJcBilhxGuAzVmbCsmQCG3DRSJ2dtYgq3ygjQZ
         krgQqAeqnOwUYlhZebh3mvpsVHAjmNWJbOgeUDvi54WJ8RNCl5gxWUdlxVmrKjLuohih
         zwVr36+WRiK4ThbmPHmedAQt8n6D4PYr3nVfT/Ged88IiyGOFTSGqTYNEh6zn5EeJumG
         lr+uZx4RhYfM6xYSDatg2r/CZRXachUl8B1wYrRsgj+JeQLztBz0dw4ReH0mIqEeXyiH
         DHVb1mkUcZf68ME4+eZWtovRSoOWZZfETCsgbo7jBn2azzWGz3YCyDNqlP47HHP63JMo
         dsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X0mMvGGdPnorv2EU34yI8jmz8GqACAgWYdGh+p8ZMsQ=;
        b=fxg2Kyr307OLdol7Ns+vvLCVXseGjg4ckQYyAKIa+fN4LLMgNcxuW+S1qH/+kFB02i
         HQldWZSrc5hSvYd7MOfub7vtnzWygmC/VQHEqUJphEooE2Kv4pVn5bkg0rZ6NsQBbOtE
         c1jb2aJMgS0lGM2l+8jLZ5cKxOgH+thL7nJAHEdk2n50zpbXa4xhHWFPyY5pa4cWfZsf
         0v66gkahXLYUAg7LMAWRw+2CiO8yFb+bMcrTYKO9vRSW209uHs+e3tYcTEandzuMOb0j
         mYg4wfRmQXXa1oubJr87EZ/hSUpIeCSc4PLweSprnW1euX0RnEJJDu1GOJAuKLVa0mIS
         vYpg==
X-Gm-Message-State: AGRZ1gKlvs716rmc8zbOUl71mTHzTC9LfS/mFJsxGgQfjQzYJqYsCB46
        1kklvwxX9exwVblzaGMwSeIM0Q==
X-Google-Smtp-Source: AFSGD/URmbOe+npCl+1WvmtAtBbKUAZ90eUBGtn1FMdf42xHPwUpbL6866Pr9w/GO/h+fcWxX72OUg==
X-Received: by 2002:a7b:cd16:: with SMTP id f22mr2007037wmj.88.1542717267544;
        Tue, 20 Nov 2018 04:34:27 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id v189-v6sm33482685wmd.40.2018.11.20.04.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:34:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/5] ARM: davinci: set GPIO base to 0 manually
Date:   Tue, 20 Nov 2018 13:31:20 +0100
Message-Id: <20181120123125.24938-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to the series that fixes a problem with ethernet
on da850-evm. All DaVinci boards in legacy mode were broken by commit
587f7a694f01 ("gpio: davinci: Use dev name for label and automatic
base selection"). This series sets the GPIO base to 0 manually for all
DaVinci SoCs.

Bartosz Golaszewski (5):
  ARM: davinci: dm365: set the GPIO base to 0
  ARM: davinci: dm646x: set the GPIO base to 0
  ARM: davinci: dm355: set the GPIO base to 0
  ARM: davinci: da830: set the GPIO base to 0
  ARM: davinci: dm644x: set the GPIO base to 0

 arch/arm/mach-davinci/da830.c  | 2 ++
 arch/arm/mach-davinci/dm355.c  | 2 ++
 arch/arm/mach-davinci/dm365.c  | 2 ++
 arch/arm/mach-davinci/dm644x.c | 2 ++
 arch/arm/mach-davinci/dm646x.c | 2 ++
 5 files changed, 10 insertions(+)

-- 
2.19.1

