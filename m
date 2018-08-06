Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B1C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77218219C5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77218219C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeHFEiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:38:18 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:32787 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeHFEiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:38:18 -0400
X-Originating-IP: 112.215.208.161
Received: from ubuntuVM.localdomain (unknown [112.215.208.161])
        (Authenticated sender: aditya@kobol.io)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 182E4C0003;
        Mon,  6 Aug 2018 02:31:19 +0000 (UTC)
From:   Aditya Prayoga <aditya@kobol.io>
To:     linux-gpio@vger.kernel.org
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Gauthier Provost <gauthier@kobol.io>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Gilmore <dennis@ausil.us>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH RESEND 0/2] gpio: mvebu: Add support for multiple PWM lines
Date:   Mon,  6 Aug 2018 10:29:14 +0800
Message-Id: <1533522556-55055-1-git-send-email-aditya@kobol.io>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
The PWM pins on both connector are connected to GPIO on bank 1. Current gpio-
mvebu does not allow more than one PWM on the same bank.

Resend the patch to add more reviewer.

Aditya

---

Aditya Prayoga (2):
  gpio: mvebu: Add support for multiple PWM lines per GPIO chip
  gpio: mvebu: Allow to use non-default PWM counter

 drivers/gpio/gpio-mvebu.c | 111 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 19 deletions(-)

-- 
2.7.4

