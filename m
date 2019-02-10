Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482ADC282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEBA2145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfBJVWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:22:05 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54925 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfBJVWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 16:22:05 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 3F402C0004;
        Sun, 10 Feb 2019 21:22:00 +0000 (UTC)
Date:   Sun, 10 Feb 2019 22:21:59 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ben.dooks@codethink.co.uk,
        ccaione@baylibre.com
Subject: Re: [PATCH v7 2/2] rtc: support for the Amlogic Meson RTC
Message-ID: <20190210212159.GK23062@piout.net>
References: <20190209001813.6792-1-martin.blumenstingl@googlemail.com>
 <20190209001813.6792-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209001813.6792-3-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2019 01:18:13+0100, Martin Blumenstingl wrote:
> Add support for the RTC block on the 32-bit Amlogic Meson6, Meson8,
> Meson8b and Meson8m2 SoCs.
> 
> The RTC is split in to two parts, which are both managed by this driver:
> - the AHB front end
> - and a simple serial connection to the actual registers
> 
> The RTC_COUNTER register which holds the time is 32-bits wide.
> 
> There are four 32-bit wide (in total: 16 bytes) "regmem" registers which
> are exposed using nvmem. On Amlogic's 3.10 kernel this is used to store
> data which needs to survive a suspend / resume cycle.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [resurrected Ben's patches after 2 years]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/rtc/Kconfig     |  11 ++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-meson.c | 410 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 422 insertions(+)
>  create mode 100644 drivers/rtc/rtc-meson.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
