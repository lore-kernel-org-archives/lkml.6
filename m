Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55613FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107EC208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107EC208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeG3LIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:08:39 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:51573 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726703AbeG3LIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:08:38 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w6U94LgQ004897;
        Mon, 30 Jul 2018 12:04:21 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 0BFA363129; Mon, 30 Jul 2018 12:34:21 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/1] gpio: mmio: add get_set inverted direction io support
Date:   Mon, 30 Jul 2018 12:34:17 +0300
Message-Id: <20180730093418.124648-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bgpio direction register use dirin and setting  
BGPIOF_READ_OUTPUT_REG_SET flag, the get_set I/O functions reading 
the inverted set register of each direction, it means:

when direction=in the get_set function read set register.
when direction=out the get_set function read dat register.

but is should be inverted.

conversion about it with Linus Walleij:
https://www.spinics.net/lists/devicetree/msg241973.html

to solve it, adding get_set_inv_dir and get_set_multiple_inv_dir
I/O functions to call the data register when the direction is input and
set register when the direction is output.
the functions will linked to the I/O get functions if the user set
BGPIOF_INVERTED_REG_DIR flag in the bgpio initialization.

Tomer Maimon (1):
  gpio: mmio: add inverted direction get_set io support

 drivers/gpio/gpio-mmio.c    | 48 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/gpio/driver.h |  1 +
 2 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.14.1

