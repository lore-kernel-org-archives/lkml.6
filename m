Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5050FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0335C20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0335C20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965720AbeFOLLu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:11:50 -0400
Received: from muru.com ([72.249.23.125]:47320 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965626AbeFOLLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:11:49 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 146EF8076;
        Fri, 15 Jun 2018 11:14:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] pinctrl fixes for generic functions and groups
Date:   Fri, 15 Jun 2018 04:11:36 -0700
Message-Id: <20180615111141.37184-1-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are fixes to the race issues for generic group and functions
reported by H. Nikolaus Schaller <hns@goldelico.com>. I have not seen
the issue here myself, so please test to see if this is sufficient.

I've also fixed rza1 in addition to pinctrl-single. Please also check
the drivers pinctrl-mt7622.c and pinctrl-ingenic.c if mutex fixes are
needed there.

Regards,

Tony

Tony Lindgren (5):
  pinctrl: core: Return selector to the pinctrl driver
  pinctrl: pinmux: Return selector to the pinctrl driver
  pinctrl: single: Fix group and function selector use
  pinctrl: rza1: Fix selector use for groups and functions
  pinctrl: core: Remove broken remove_last group and pinmux functions

 drivers/pinctrl/core.c           |  5 +-
 drivers/pinctrl/core.h           |  6 ---
 drivers/pinctrl/pinctrl-rza1.c   | 25 ++++-----
 drivers/pinctrl/pinctrl-single.c | 91 +++++++++++++++++++-------------
 drivers/pinctrl/pinmux.c         |  5 +-
 drivers/pinctrl/pinmux.h         |  7 ---
 6 files changed, 74 insertions(+), 65 deletions(-)

-- 
2.17.1
