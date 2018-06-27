Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E04FC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B6724139
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="GlEg78kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B6724139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964976AbeF0LzH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:55:07 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35986 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbeF0LzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:55:03 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] pinctrl_gpio_get_direction & ingenic fixes
Date:   Wed, 27 Jun 2018 13:48:59 +0200
Message-Id: <20180627114904.10890-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530100161; bh=rQSz/py4U7jjyy33o2jDDbyUu6I/+of8p+6RpwtmY7I=; h=From:To:Cc:Subject:Date:Message-Id; b=GlEg78kMTxl1Hqj/TioenyQOUkGIxxNPonuxxjXWkHUGPScfRTbHLnKlFXX8JMimCPMqbKya1pTXqWyOWIyVxOO2pekjDos/WL3xFJXTGNKFR8voPBzyiUDhEEQqYSMLanQrs8oWVkHbWwjGc7EgzkKwawxDwplQszBBvMHAXug=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a set of (rather RFC) patches, to implement
pinctrl_gpio_get_direction(). I did that, because my gpio-ingenic driver
calls pinctrl_gpio_set_direction() within its gpio_chip's .set_direction
callback, but there was no corresponding function to implement the
.get_direction callback. If that's not the right way to do it, please
advise.

If not merging the whole series, patch [3/5] is a real fix that should
go through.

Note that it doesn't make checkpatch.pl happy, I wasn't sure whether I
should try to comply to checkpatch.pl or match the coding style in the
pinctrl subsystem, I chose the latter.

Thanks,
-Paul

