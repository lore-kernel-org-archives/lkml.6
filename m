Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B264CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C62184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0Icvr2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfACUDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:03:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40662 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfACUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:03:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so17155935pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3OiOCQaxJrH2kl8We28912V13gwfwdP5IuL7Exmn6Cw=;
        b=N0Icvr2l5LSsQavuiLzk7GyhQ6NAYACROYu4FiaLYirlxIIkmpbQjzObYThip0MPIw
         PavRTBdqJDO9Mh0mCS92D76QXBNXRVX/3xD3M4W34KHLEe1O+HNV6ZEaBQDCvlf6qS40
         yGhNFG+t/KPZJr4YalwjHCdNtKXa/+oJjMpag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3OiOCQaxJrH2kl8We28912V13gwfwdP5IuL7Exmn6Cw=;
        b=KMX6QrNOsiCCc0/Avwz2uWZer2dz7zbtc6ZiNEk4d2T1YHEaeMeSTxyUNOFz9sotI/
         DXrx5SpEFOW6Ch9xLhy0LBa7y4pgDS1MQWa161mPyiy4qCYs4Hx9C76Fe0K6gKcfjhPm
         DuQ20Il/RmLjLLwP9Mv1a1d37fdKcvihy9stAmsyqE5FmPRQhLJxcZiGKKHJgHYXbtz1
         Vf2lv8hfgWp3XMljshCMHKRqE7wobIn84AwsIFopqhZj+Uw2ukjvLz5LuFfunkcEUEU5
         cH8nhymEA0xDO8AJxpgJ4IwTou2rxIScRq7K2wfbyaZq+bWDh68Sf/TF/IpeZYb4xaCU
         eP9w==
X-Gm-Message-State: AJcUukdx+ybahMGhEhh00IDUMWmSwRxuydlF+W0nH+6HTFlGgoXegvrp
        saYFSGrwgaImCnIzWCKvLina8w==
X-Google-Smtp-Source: ALg8bN6a7gAVio4QBaHZ5Jac85BhDu5HG1ScO27hjrnxAqGLVz2m79kxW7yObMoe9kfKB/rv71Knbg==
X-Received: by 2002:a63:e001:: with SMTP id e1mr18312707pgh.39.1546545782155;
        Thu, 03 Jan 2019 12:03:02 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e16sm77421961pfn.46.2019.01.03.12.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 12:03:01 -0800 (PST)
Date:   Thu, 3 Jan 2019 12:02:59 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [GIT PULL] hwspinlock updates for v4.21
Message-ID: <20190103200259.GA1563@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/hwlock-v4.21

for you to fetch changes up to 4d5a91fd1f42a821d14b92b082b8e71be9911ba5:

  hwspinlock: fix return value check in stm32_hwspinlock_probe() (2019-01-03 11:42:10 -0800)

----------------------------------------------------------------
hwspinlock updates for v4.21

This adds support for the hardware semaphores found in STM32MP1.

----------------------------------------------------------------
Benjamin Gaignard (2):
      dt-bindings: hwlock: Document STM32 hwspinlock bindings
      hwspinlock: add STM32 hwspinlock device

Wei Yongjun (1):
      hwspinlock: fix return value check in stm32_hwspinlock_probe()

 .../bindings/hwlock/st,stm32-hwspinlock.txt        |  23 +++
 drivers/hwspinlock/Kconfig                         |   9 ++
 drivers/hwspinlock/Makefile                        |   1 +
 drivers/hwspinlock/stm32_hwspinlock.c              | 156 +++++++++++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
 create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c
