Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA03C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E475220870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="G5XhvwpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E475220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeLLWQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:16:43 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40646 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbeLLWQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:42 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Subject: [PATCH v8 00/26] Ingenic TCU patchset v8
Date:   Wed, 12 Dec 2018 23:08:55 +0100
Message-Id: <20181212220922.18759-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544652572; bh=TJOhGzIlzuaZqrJA9gEl7GkZSxKqpJ8OfjnN5JlUsb0=; h=From:To:Cc:Subject:Date:Message-Id; b=G5XhvwpH0M9UajYKH7j3MtZoT/E9oDN4rjx5WBzI7k+AUBWU09nqLKiWD/u+gPrzia9lbB0ccCTP19DTUAaM9RU/lFJzbljTsgspYt+Y/QxhkON/wzdKdFFW9em1KiPyLXYKKRj8INEIGP9hCraiES5sgeQs3HQwhHbn5QFNfPw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's the version 8 and hopefully final version of my patchset, which
adds support for the Timer/Counter Unit found in JZ47xx SoCs from
Ingenic.

The big change is that the timer driver has been simplified. The code to
dynamically update the system timer or clocksource to a new channel has
been removed. Now, the system timer and clocksource are provided as
children nodes in the devicetree, and the TCU channel to use for these
is deduced from their respective memory resource. The PWM driver will
also deduce from its memory resources whether a given PWM channel can be
used, or is reserved for the system timers.

Kind regards,
- Paul Cercueil

