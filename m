Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E8C20685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="valmmHbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfAJRt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:49:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37353 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfAJRt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:49:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so5643663pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MZa32Esg9K4ZsfnV6hTpp491c1VoOb1/+Xb5dttpej4=;
        b=valmmHbGhRymwmoxbKdFLXs6pRkn5OTySqmv3loIv4U5cr8QVuyrdK2bcYCnLb+XKv
         JHthmunbiC0vHUtVP5uQSKF3Vbw0H8q43oamrO94YG10vvKmbU8gZv6T6aqzU4nycAtw
         lMi16KFUBduOL5erllRAq4EVj/y4kXHRHE7HOtw/wFWsh8775QVbv+i+bgKON6KbDYAT
         Nufc+qNtY82yMSP0T38IoxhbLa2ZEM24U31Os/q7d4J39vNF/oK5xwDRz5VsMrekx1zE
         N/NFaYsiphjUruo5UebppIPHsL/T4Eu85Ef02S0kFoug1C1lhQGFnvwypBdFlhkVE2Qb
         YfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MZa32Esg9K4ZsfnV6hTpp491c1VoOb1/+Xb5dttpej4=;
        b=ZvminCjpTwRLxAVxPRqsYocrjOQ2eFJmF1S7mSMJDbIkhKKJQmvGmW/c3TtLH5cNWw
         MzHnIr+qTS5u8AmfCtx1R3QqClt5577EmehxYsvPz2BLEseohnIptW5hNVcz6QRS88s+
         7CoAlMetP9SPu/XIoxibRBSw93KT12UXprEToKXMRs0VdHI8/zJTck7S9OjvGnpouFTD
         Mc1YQr7VaTqL9QN4y5dMXtMzKY2M0WfM5ekALZuCCkn5+EOo7seLE+7VSolwPTYqmkTX
         LUjs/y1sRzdrPgXnWqH7esdsO985AHHSqY+UhMySD9SvxHewc9+dIyDEViKnl2oowRU7
         wdZQ==
X-Gm-Message-State: AJcUukexLFKlpFccIL6BFBftbgNeVSk+UubdWm9yXL9yyoP85S7kqI+u
        Ov4zZQnkSwrWRwDt2bzmhM4=
X-Google-Smtp-Source: ALg8bN4wYoEtKJdziEgatz5L39rywGxyYhZKKbYlWIjYecEjq2OKMJ1IG3yw/SGTHPTQr1zFW2bfFA==
X-Received: by 2002:a63:5320:: with SMTP id h32mr124247pgb.414.1547142565381;
        Thu, 10 Jan 2019 09:49:25 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id g136sm123349338pfb.154.2019.01.10.09.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 09:49:24 -0800 (PST)
Date:   Thu, 10 Jan 2019 23:19:18 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v5 0/3] greybus: gpio: Switch to the gpio descriptor interface
Message-ID: <cover.1547141413.git.nishadkamdar@gmail.com>
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
 drivers/staging/greybus/arche-apb-ctrl.c | 154 +++++++++-------------
 drivers/staging/greybus/arche-platform.c | 124 ++++++------------
 drivers/staging/greybus/gpio.c           | 156 ++---------------------
 5 files changed, 115 insertions(+), 322 deletions(-)

-- 
2.17.1

