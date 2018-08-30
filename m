Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06487C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6417205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6417205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeH3QQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:16:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46041 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeH3QQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:16:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so6986198lff.12;
        Thu, 30 Aug 2018 05:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J0L5E5OYhi8ZdpG6+EZRwPDvaxC3WCb+Xvu7A7vbDXU=;
        b=dqLv9D9KK1ptfghKN8Y8wVT/D3lPIYpb6JKtWdN/ENPO9QE3BCoAJ6p89sdihpsiqX
         JHe3K6HDZgnJbp9i4dJ/45aL4BSDxQGfdoCAvIx9FfOrKLlFpddjlTrAk5FK9zaNmoD8
         FEbCtb8RK5pk3mUsuCmJw1U4va963FnuueRif4AsWNcYwKGXVo1HAEpnIJB5zJHUcEUY
         kxVQCeF2vv7UoeaGDwBI3kgX2UkCCEW3SY4XFjApK4y8Oj7fAUCyjz1adxDzIyTOOkLE
         QEjVmyRCPAAYQPczrvzmMgR49BYsmojLOVEsSS+ucah/hlK2Y7tibDbPYH8+gutZfisS
         BWHw==
X-Gm-Message-State: APzg51DqTq8OAp8VLZ+D6+7T76vEQRzO48xVhwry+2CiMm+lALzc8RZS
        8twxC2rBigWxieosxgAEsLg=
X-Google-Smtp-Source: ANB0VdbO5yJovZcYFa2fc0ptSegyfnuteKffptcPj0YucQQnftCU7S4ltEJOapVKwgB7PvYUb+T3tA==
X-Received: by 2002:a19:11d1:: with SMTP id 78-v6mr7079336lfr.25.1535631251581;
        Thu, 30 Aug 2018 05:14:11 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t15-v6sm1211253ljh.21.2018.08.30.05.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 05:14:11 -0700 (PDT)
Date:   Thu, 30 Aug 2018 15:13:57 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     corbet@lwn.net, mturquette@baylibre.com, sboyd@kernel.org,
        linux@armlinux.org.uk, andrew.smirnov@gmail.com, robh@kernel.org,
        sre@kernel.org, linux@roeck-us.net, sjhuang@iluvatar.ai,
        matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 0/2] clk: Support ROHM BD71837 (BD71847)
Message-ID: <cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for clk gate included in ROHM BD71837
(and BD71847) Power Management ICs. Additionally patch series adds support
for new managed interfaces for clkdev lookup and parent_of_provider
registrations.

Please note that the patch has not been tested on BD71847 - I will
verify the BD71847 part and do appropriate documentation/naming changes
after verification. Hence only BD71837 support is announced here even
though the BD71847 should be identical what comes to clk registers.

BD71837 driver in the patch series depends on defines submitted as part of
this patch set:
https://lore.kernel.org/lkml/cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com/

The managed interfaces are continuation of discussion started here:
https://lore.kernel.org/lkml/20180730125550.GD8862@localhost.localdomain/
Difference to previous patch:
 - dropped devm_clk_register_clkdev
 - added new interfaces to Documentation/driver-model/devres.txt
 - did not rename __clk_register_clkdev
 - simplified IS_ERR - checks/code dublication by dropping checks from
   devm_clk_hw_register_clkdev.
   As negative point is this causes devres_alloc to be done before checking
   for IS_ERR(hw) inside do_clk_register_clkdev.

and BD71837 driver is continuation for patch discussion started here:
https://lore.kernel.org/lkml/d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com/
Difference to previous patch:
 - Simply fail out if no parent clock is found from DT. This simplifies
   driver a lot and encourages proper clk tree modelling in DT.

patch series is based on linux-next tag next-20180823

Patch 1:
	Add new managed interfaces
Patch 2:
	Support BD71837

Matti Vaittinen (2):
  clk: clkdev/of_clk - add managed lookup and provider registrations
  clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock

 Documentation/driver-model/devres.txt |   3 +
 drivers/clk/Kconfig                   |   6 ++
 drivers/clk/Makefile                  |   1 +
 drivers/clk/clk-bd718x7.c             | 131 ++++++++++++++++++++++++++++++++++
 drivers/clk/clk.c                     |  28 ++++++--
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++-------
 include/linux/clk-provider.h          |   4 ++
 include/linux/clkdev.h                |   4 ++
 8 files changed, 267 insertions(+), 32 deletions(-)
 create mode 100644 drivers/clk/clk-bd718x7.c

-- 
2.14.3

