Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF67EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C94E20842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfAMN7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 08:59:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:60117 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfAMN7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 08:59:54 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJWAZ-1gffUy2EBv-0039LO; Sun, 13
 Jan 2019 14:59:51 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 0/2] GPIO: hlwd: Implement IRQ support
Date:   Sun, 13 Jan 2019 14:58:42 +0100
Message-Id: <20190113135844.13109-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+J01dWA1SlP1dD84qgC+sLk/06nfy+Jpnz8KEjqW/P9oJ+d1HxR
 uRCBGS1Je7PkNTlcQYxXXhmb9wx5R6RugEVN1r/iFGb6uvVi64qFT9Ow3nAEZVxVjwiFiq8
 mMMpum+0yu/m35mute5GGChc4pbigQ4qiS9Y90Du7u4XIH6qebdxyOaZnbiKmk94ckq62Aw
 fkbcSDxAd4l9AqGIdWBkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1fQLNYQs5Pk=:g9o37CEgwJ8Ic7ExIrTXrY
 y1ueJ88PY/h3G2103vLUF1qo7VZ/WqTuLVJn8qOvKU+dSLMfwRJ+Xwqk78V3kEeu0whaMDdkk
 DNgj00mXGWG5G2iMSe+eHmjEAFxmFsXq9ck/ElltyvF1jhWHEvzKMlUJLqKJ+pskTtTnUoOBP
 o4AuSA5As3j8mV+GyZ4NngNJNBytXcd9Jt+Q4JK3sLvX/qbCi+f2OoJcMRAznuy8SbcKhTMnh
 1QgVaHeZnz1Onb/mCe0EEfqmzAYS4xgmkz4Ej/hwbY+zOBjqZv+5UwpAiSJ0SssNLlDf4ZC1D
 z7BhjEWMeWXGILjwmIW28PqX7j9BntZzFvqfE+O6hLFdpss+5yQ4nkC9djqO7iYhRB5LtuW1y
 h9PE9HznfzeKCPPuggUuuZ51J/K5VrAEVPC+EKmKSFZQWa/SgdzwyLZStG5IOcggqpYI+Ep+V
 IAPrbAPSrW3n75m40wa+vqcYnWdV6FtrLKnpA8cFp9eE5FYG82NQ/3WqqfSC5IJZhn1S09X8N
 RDns4aLdo4CYBLbOjRSxwmESr3heIs2WTe7tHMHwky+NZ/SvYmEovPE2ptgX0NVsvJNf2jFk6
 8xjR+BBOX/OXr0sBWJMu+4IMX8BjHZqdk62X+yhdLey8Gtzwm0t+WfBfihJ1vT9XefobnOLwR
 Zg8WMhsY1bkKE0iADlUeFAKt992g6s4BxPYDCSXlOR11MUFWO16vQBXrgrubl+sg3XA9E3NRx
 TOzkBhIo+pfKUZV3MFPIHT7POLUs6b/mg/pISL2ymWd1tJdl4GLXgKi/+54UD2QIeeo39DKAA
 wvYuxBraEM6YDcxEZy/DE+1MiNCrQb7xkuqC/XSgjlL198rbgqQ12AE11VkEr+MdtpvUxKfjs
 Ud3BBfBiA+br4NKWeQtrwkvxwxKWQP92Si7b/P3CD9gQ5Vg3vaGiGh+G/OVkPb6TfsKQRKvIW
 IT2fmYzEnog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements IRQ support for the Hollywood GPIO controller
(Hollywood is one of the chips in the Nintendo Wii game console).

Together with two device tree patches[1], I can use the buttons (via the
gpio-keys driver) and the photoelectric sensor in the disc slot (via
gpio-event-mon).

[1]: https://www.spinics.net/lists/kernel/msg3010459.html

Jonathan Neuschäfer (2):
  gpio: hlwd: Add basic IRQ support
  gpio: hlwd: Implement edge trigger emulation

 drivers/gpio/Kconfig     |   1 +
 drivers/gpio/gpio-hlwd.c | 193 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 193 insertions(+), 1 deletion(-)

-- 
2.20.1

