Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08518ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24AC214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aQfvXEvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24AC214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJJCJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:09:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53214 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJJCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539111086; x=1570647086;
  h=from:to:cc:subject:date:message-id;
  bh=QbO4SRoV4FLbe735YZxFuxe+2rYyhQSJagMIlJj9fzw=;
  b=aQfvXEvyIh5ZUau4BIZf9p3XeYqzaiv2Z1yV1d3TE5THCz93O+n/d05/
   9PqFE+s3IWwWisRxJQzzow4dsrN6CnAKzBAOMAjQnDe+walW0cKhYo1dJ
   z8P26ju2pNH8PSPPg/Q3vR2KZ+Y64seHTDIALBgmcGRE5A+k+WXXdDFye
   er0YvlXUWx5JnqpuIkC5hkPhn6WoDq/UiLxIsXpebxFinxM6HLIXzwZxk
   Kv0nfrghrRu87TYSVWVr/GPTspWSfJJfg3XODsw4xN9jeo2IV1sqYeput
   kAI8LeHUtnzqUjDBmVlPd9V6v9UnEuGTjmQCuwgo7qURfCNjStxOTHhmf
   A==;
X-IronPort-AV: E=Sophos;i="5.54,361,1534780800"; 
   d="scan'208";a="93263445"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2018 02:51:25 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 09 Oct 2018 11:36:35 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Oct 2018 11:51:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        hch@infradead.org, atish.patra@wdc.com
Subject: [RFC 0/4] GPIO & PWM support for HiFive Unleashed 
Date:   Tue,  9 Oct 2018 11:51:21 -0700
Message-Id: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds GPIO & PWM drivers and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

Wesley W. Terpstra (4):
  pwm: sifive: Add DT documentation for SiFive PWM Controller.
  pwm: sifive: Add a driver for SiFive SoC PWM
  gpio: sifive: Add DT documentation for SiFive GPIO.
  gpio: sifive: Add GPIO driver for SiFive SoCs

 .../devicetree/bindings/gpio/gpio-sifive.txt       |  28 ++
 .../devicetree/bindings/pwm/pwm-sifive.txt         |  32 ++
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-sifive.c                         | 326 +++++++++++++++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 240 +++++++++++++++
 8 files changed, 645 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sifive.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/gpio/gpio-sifive.c
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
2.7.4

