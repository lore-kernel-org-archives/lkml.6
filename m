Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F40C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75D721A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5FtkHJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391339AbeLVRWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:22:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42592 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeLVRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:22:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so3903739plp.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=funrV15ZJBWQbvTyrc7hNi1+PIiElalVGUOWUykLzEo=;
        b=W5FtkHJnwJqMKXrfuyrDbT7+/7RpMZMJuT9Ve1yglGjKxEtRzD+cQ3+IDjhoOe2fwc
         Oz2k+CWmeUHqfoCFVvVv5LzNOo/yv2vsgsamxE8qX7GHIsgRyX2InRQfVMkFdEOhR1kX
         WgoFlxrRoguve7ShQobiPY6qnzeH8vASvAvs93AIOftfHaqDSuMnidCcAWn25Em7hFLZ
         2RaH4Q8aCjT34zj5PlHAtbnbfzCjXz6BvETvXMw1HTe2xrctzNm4Dg6NZh21zC5g8ljZ
         7UjzJqcAAsSNyXnO4+X96tPEyL9HxhDhVBizgNs6sTN//QBjhqn9OVEDgE9Tg5gsM120
         X2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=funrV15ZJBWQbvTyrc7hNi1+PIiElalVGUOWUykLzEo=;
        b=r2Gx+61LEWwLgTVz6pu3RT8WUkmLmBgsWgTjeLLDBW6HSMYQ8HGXe5q1T413xa/fpg
         dwHDSKrVmDydHp5tYTh8BgZTbK+4CamoJk4/RP95WaxUrPZVrHLiGGN7XiBfs6yqvATm
         /YD1wS6AoJlKKot+paTTAsBOJkrNXmdAKeaHDTNDInBPJ+tGyHTAhl4/CteCjfwjZejv
         qRIOCnSQHgiQs/x1RmkW8wn1oAbg3nlOeEFF/pUPGHTl/DiIUDFaCScNPzMkdLywFI+/
         b8cK/7OrBic0CpUJSIz0sRLhS+6Y+oDG1XLxDFbeDxm04ue7KJj6ydxRyBPX7dq7HVLM
         N0Jw==
X-Gm-Message-State: AJcUukdRHtqGrJKin4XBKZ7WyWovbVTnBnUlcMBqy8TTSDUhz1pjmRdp
        Mg5g28fOW3kA3UqAqlIm+pa1imjH8Mg=
X-Google-Smtp-Source: ALg8bN6qrp4qq2pAyE5c0ERwlRzUHIkvLH0OLJySIxuX2ckAv5xquLiNPPUDQy6hRtmsoCZAs+eC1Q==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr6715300plr.15.1545489956960;
        Sat, 22 Dec 2018 06:45:56 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id o8sm51541985pfa.42.2018.12.22.06.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:45:56 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:15:49 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v4 0/4] greybus: gpio: Switch to the gpio descriptor interface
Message-ID: <cover.1545488665.git.nishadkamdar@gmail.com>
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

Changes in v4:
 - Changes mentioned in individual patches of the set.
Changes in v3:
 - Combines the latest versions of the three greybus patches together
   in a patch series.

Nishad Kamdar (4):
  staging: greybus: gpio: switch GPIO portions to use GPIOLIB_IRQCHIP
  staging: greybus: gpio: Use gpiochip_get_data() in place of
    gpio_chip_to_gb_gpio_controller()
  staging: greybus: arche-apb-ctrl.c: Switch to the gpio descriptor
    interface
  staging: greybus: arche-platform: Switch to the gpio descriptor
    interface

 drivers/staging/greybus/Kconfig          |   1 +
 drivers/staging/greybus/TODO             |   2 -
 drivers/staging/greybus/arche-apb-ctrl.c | 154 ++++++++-----------
 drivers/staging/greybus/arche-platform.c | 124 +++++----------
 drivers/staging/greybus/gpio.c           | 187 +++--------------------
 5 files changed, 129 insertions(+), 339 deletions(-)

-- 
2.17.1

