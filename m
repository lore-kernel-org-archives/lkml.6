Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F8C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A246206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 18:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Y9r6b//U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeL0SNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 13:13:36 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53590 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeL0SNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 13:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1545934412; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=iHRs7F5NSB5E2tPXVk3y3c+0YxqPmlhOCMBNLvl0sfo=;
        b=Y9r6b//UO1SFRoFninfKrapxXnrAXKcf2yZ0QPQv9IOlfF/rdNRbWU/h/N6exCPBmtLyJE
        ZrNmQmRIuJXAcHxFu6mEKQ08qnok8V+e8c2QWqCqwPWlz5UoCPTknL5TaxifNAI2I7oHH3
        ZWIGo8e0Py3To2ZCH0LO6ABNRklKkpc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v9 00/27] Ingenic TCU patchset v9
Date:   Thu, 27 Dec 2018 19:12:52 +0100
Message-Id: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v9 of my patchset to add support for the Timer/Counter Unit
present on Ingenic JZ47xx SoCs.

Changes from v8 mainly include:

- The system timer and clocksource sub-nodes of the ingenic-timer driver
  are gone. Now, the ingenic-timer will use the (optional) property
  named "ingenic,pwm-channels-mask" to know which TCU channels are
  reserved for PWM use.

- New patch [11/27] makes the PWM driver implement the .apply callback,
  which is cleaner and incidentally fixes a long-standing bug.

- The patch in V8 that converted the PWM driver to use the regmap and
  clocks provided by the ingenic-timer driver has been splitted in three
  patches, [12,13,14/27]. The algorithm in [14/27] has been slightly
  improved.

- The patch that adds support for the JZ4725B SoC to the PWM driver has
  been removed from the patchset, as it's been suggested that the core
  could use a "npwms" device property to override the number of PWMs set
  in the driver.

Thanks,
-Paul Cercueil

