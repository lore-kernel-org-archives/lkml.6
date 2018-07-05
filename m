Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A6FC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB2B24103
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB2B24103
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeGEJKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:10:30 -0400
Received: from muru.com ([72.249.23.125]:50298 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752440AbeGEJK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:10:28 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id AC875802B;
        Thu,  5 Jul 2018 09:13:25 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christ van Willegen <cvwillegen@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCHv3 0/5] pinctrl fixes for generic functions and groups
Date:   Thu,  5 Jul 2018 02:10:13 -0700
Message-Id: <20180705091018.60524-1-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a resend of fixes for a race issues for generic group and
functions reported by H. Nikolaus Schaller <hns@goldelico.com>.

Regards,

Tony


Changes since v2:

- Added Nikolaus to Cc as Reported-by did not do it

Changes since v1:

- Check if a function or group already exists as suggested by
  Andy Shevchenko

- Make sure we always have a valid name for functions and groups
  as suggested by Christ van Willegen

- Prettify rza1 variables as suggested by Jacopo Mondi

Tony Lindgren (5):
  pinctrl: core: Return selector to the pinctrl driver
  pinctrl: pinmux: Return selector to the pinctrl driver
  pinctrl: single: Fix group and function selector use
  pinctrl: rza1: Fix selector use for groups and functions
  pinctrl: core: Remove broken remove_last group and pinmux functions

 drivers/pinctrl/core.c           | 35 ++++++++++--
 drivers/pinctrl/core.h           |  6 ---
 drivers/pinctrl/pinctrl-rza1.c   | 24 +++++----
 drivers/pinctrl/pinctrl-single.c | 91 +++++++++++++++++++-------------
 drivers/pinctrl/pinmux.c         | 16 ++++--
 drivers/pinctrl/pinmux.h         |  7 ---
 6 files changed, 112 insertions(+), 67 deletions(-)

-- 
2.17.1
