Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7137C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85F02086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PITaHHu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfANOzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:55:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34641 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfANOzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:55:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so10257398plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/N5d1VcQrImfVLWi+C9ftXvOyEN/W8gZ8wROAP+1YAo=;
        b=PITaHHu3/62MFpLoVv6zfQaaM6vrTm/efriWWYppojIOV40pGZlBYfcUQHf7eOqnT7
         G8Au012zmhRtvO+ykQry8vU4fVkNsTAXxKrOa6qbLxBxvDkY8yQgfQveDXgELf8wjPEA
         3WqOJkLxUWLds0XteycfPG5LTFnF/3a72vI+wgKAxPtZB2/oIOiogCoBlBIRqouYQzPq
         wi8+awdyCXTBo2souHZmg+WQ9A7GhZdoDMhEh+itNn6LsjdS06fLw8CaW9UWlAXIwI0S
         1GCPrYKaYSzWGUBy1QPuTIlRZibbTtLpKzvzzqQqMgE2FIYDbhjuLe0JUgR3c4ogsno7
         1pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/N5d1VcQrImfVLWi+C9ftXvOyEN/W8gZ8wROAP+1YAo=;
        b=Ic9v3Pn8IOxkI7uCw2xRbvlHIrXy3oWpQ4sWcQpKJLMMivFmrO0hMborhwMbZMtqze
         rAf+wZ3DufIYon4Rmcjf48WWH1BixMjtUFzVlsjvZBaHXOVhv0UHZWiK4qtwpFiYmQp1
         poSBZdVinDklGlut4UP54eQ+fATnx3fhr1VKS8EtLn8FZPzH7VdoYLl8+xQpenoRXAvP
         hZL6WoCEgn3vpFvAydoA+dPRxffECZaViL1s5kUPn/1X2QCo00LbIqoLiqigvRDxNrUz
         BInPNRTe+FIYDloOuSascqnjBYFcnSOY7nBcQOJ8c7BE1bdeRTalEQ8EkSxkjuYhc2QY
         bcgw==
X-Gm-Message-State: AJcUukdVdUfaEJpAFRcxPNgpO1EfKaW4CbWjHSYX2l3ht5yXTueZe2Ph
        VTIu55OIbm6QSVP99Kq402U=
X-Google-Smtp-Source: ALg8bN4MorCedtXJcO49Sx7aSxRkKcYDCycT5blPwO+b+99+mjFMs++Vw+eBrOzuDF7o0gjAzK7R7w==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1mr25532156pli.64.1547477715003;
        Mon, 14 Jan 2019 06:55:15 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id p6sm893019pfn.53.2019.01.14.06.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 06:55:14 -0800 (PST)
Date:   Mon, 14 Jan 2019 20:25:07 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v7 0/3] greybus: gpio: Switch to the gpio descriptor interface
Message-ID: <cover.1547476997.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts uses of the old GPIO API to the GPIO
descriptor API. It also converts the GPIO driver to use the
GPIO irqchip library GPIOLIB_IRQCHIP instead of repimplementing
the same.

Chnages in v7:
 - Combine the three patches together.
Changes in v6:
 - Patchset now contains two patches as the patch
   1 has been accepted.
 - Changes mentioned in individual patches of the set.
Changes in v5:
 - Drop the patch which uses gpiochip_get_data() in place of
   gpio_chip_to_gb_gpio_controller() as of now.
 - This is because it currently breaks the driver, since
   gpiochip_add() sets the data pointer to NULL.  
Changes in v4:
 - Changes mentioned in individual patches of the set.
Changes in v3:
 - Combines the latest versions of the three greybus patches together
   in a patch series.

Nishad Kamdar (3):
  staging: greybus: gpio: switch GPIO portions to use GPIOLIB_IRQCHIP
  staging: greybus: arche-apb-ctrl.c: Switch to the gpio descriptor
    interface
  staging: greybus: arche-platform: Switch to the gpio descriptor
    interface

 drivers/staging/greybus/Kconfig          |   1 +
 drivers/staging/greybus/TODO             |   2 -
 drivers/staging/greybus/arche-apb-ctrl.c | 152 +++++++++-------------
 drivers/staging/greybus/arche-platform.c | 124 ++++++------------
 drivers/staging/greybus/gpio.c           | 156 ++---------------------
 5 files changed, 113 insertions(+), 322 deletions(-)

-- 
2.17.1

