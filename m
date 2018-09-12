Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D8FC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4611720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4611720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeILKWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:22:45 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:41248 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeILKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:22:45 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 5222B3A28F9;
        Wed, 12 Sep 2018 06:52:35 +0200 (CEST)
X-Originating-IP: 118.96.227.93
Received: from ubuntuVM.lan (unknown [118.96.227.93])
        (Authenticated sender: aditya@kobol.io)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4D4EEFF805;
        Wed, 12 Sep 2018 04:52:27 +0000 (UTC)
From:   Aditya Prayoga <aditya@kobol.io>
To:     linux-gpio@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Gauthier Provost <gauthier@kobol.io>,
        Dennis Gilmore <dennis@ausil.us>,
        Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH v2 0/1] gpio: mvebu: Add support for multiple PWM lines
Date:   Wed, 12 Sep 2018 12:51:54 +0800
Message-Id: <1536727915-113932-1-git-send-email-aditya@kobol.io>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
The PWM pins on both connector are connected to GPIO on bank 1. Current
gpio-mvebu does not allow more than one PWM on the same bank.

Aditya

---

Changes v1->v2:
  * Merge/squash "[Patch 2/2] gpio: mvebu: Allow to use non-default PWM counter"
  * Allow only two PWMs as suggested by Andrew Lunn and Richard Genoud

---

Aditya Prayoga (1):
  gpio: mvebu: Add support for multiple PWM lines per GPIO chip

 drivers/gpio/gpio-mvebu.c | 73 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 13 deletions(-)

-- 
2.7.4

