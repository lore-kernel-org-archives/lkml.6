Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE28DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766DA2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766DA2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756712AbeFSJbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:31:38 -0400
Received: from muru.com ([72.249.23.125]:48108 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756270AbeFSJbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:31:35 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 6E7DA805C;
        Tue, 19 Jun 2018 09:34:17 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/5] pinctrl fixes for generic functions and groups
Date:   Tue, 19 Jun 2018 02:31:21 -0700
Message-Id: <20180619093126.74060-1-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are fixes to the race issues for generic group and functions
reported by H. Nikolaus Schaller <hns@goldelico.com>. I have not seen
the issue here myself, so please test to see if this is sufficient.

I've also fixed rza1 in addition to pinctrl-single. Please also check
the drivers pinctrl-mt7622.c and pinctrl-ingenic.c if mutex fixes are
needed there.

Regards,

Tony

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
