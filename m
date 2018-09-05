Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D76DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29F0206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29F0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeIENwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:52:50 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:55128 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeIENwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:52:49 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id XlPU1y00Q3XaVaC01lPUyw; Wed, 05 Sep 2018 11:23:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fxU24-0006p3-II; Wed, 05 Sep 2018 11:23:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fxTlB-0002aO-2d; Wed, 05 Sep 2018 11:06:01 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] gpio: Fix VLA removal fallout
Date:   Wed,  5 Sep 2018 11:05:52 +0200
Message-Id: <20180905090555.9888-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

This patch series fixes various (mostly harmless) issues introduced by
commit 3027743f83f867d8 ("gpio: Remove VLA from gpiolib").

As per the "one patch should fix one issue"-policy, this series contains 3
patches, although they all have the same Fixes: tag.

W.r.t. propagating errors: while gpiod_set_array_value_complex() and its
callers can now return an error code, this is currently limited to -ENOMEM.
Actual failures setting a GPIO output value cannot be propagated, as
gpio_chip.set() still returns void.  Do you want to change that?
E.g. gen_74x164_set_value() can fail.

Feel free to fold patches if deemed appropriate.

Thanks!

Geert Uytterhoeven (3):
  Documentation: gpio: Fix return type of gpiod_set_raw_array_value*()
  gpio: Propagate errors from gpiod_set_array_value_complex()
  gpio: Restore indentation of continued lines

 Documentation/driver-api/gpio/consumer.rst | 24 +++++++--------
 drivers/gpio/gpiolib.c                     | 34 +++++++++++-----------
 drivers/gpio/gpiolib.h                     |  6 ++--
 include/linux/gpio/consumer.h              | 31 ++++++++++----------
 4 files changed, 48 insertions(+), 47 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
