Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB56ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45D320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45D320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeGTVIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:08:37 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:49020 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727383AbeGTVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:08:37 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 93A573A417B;
        Fri, 20 Jul 2018 21:24:07 +0200 (CEST)
X-Originating-IP: 140.213.19.3
Received: from ubuntuVM.localdomain (unknown [140.213.19.3])
        (Authenticated sender: aditya@kobol.io)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 118AEC0007;
        Fri, 20 Jul 2018 19:24:00 +0000 (UTC)
From:   Aditya Prayoga <aditya@kobol.io>
To:     linux-gpio@vger.kernel.org
Cc:     Gauthier Provost <gauthier@kobol.io>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH 0/2] gpio: mvebu: Add support for multiple PWM lines
Date:   Sat, 21 Jul 2018 03:23:41 +0800
Message-Id: <1532114623-81911-1-git-send-email-aditya@kobol.io>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
The PWM pins on both connector are connected to GPIO on bank 1. Current gpio-
mvebu does not allow more than one PWM on the same bank.

Aditya

---

Aditya Prayoga (2):
  gpio: mvebu: Add support for multiple PWM lines per GPIO chip
  gpio: mvebu: Allow to use non-default PWM counter

 drivers/gpio/gpio-mvebu.c | 111 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 19 deletions(-)

-- 
2.7.4

