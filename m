Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB80C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02341206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCBdWckB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02341206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406173AbeKWDqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:46:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42701 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbeKWDqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:46:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so2181735pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FRiwUOcpoS8c8tdAFcGpkoKWSvt5uAnHYr8nmG9U9O4=;
        b=qCBdWckBYGoAhWb65AnDg5BklftjZqzwUVFKLbfsURGrll4jsyoQ2vTSE14c40Dhr1
         dTE9Zn76F/ufSoMZgeM288AI27SAKq2RkVapn50nh6M7fHtANcmy06f4HgQneVGK3NUZ
         Mg0Ym1wPfkysLgtcfzLMBznqxj5dBTf1amC7n/tPPm9BZEHP1y1g8xlD6YtSkUSbWNIi
         dtESUs2Z3BqjztbKlirXmP8L4BJ+oy9BUlrJ0xpWwIQT/glXduKEGEiMjxiF4JuD6wFQ
         tWRQPS12UEhvcq5MM6Ca/0JblpzwDP1c3h3Vtmo4E8jGZQFk09UUdC7jthgx+A2efn/b
         MU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FRiwUOcpoS8c8tdAFcGpkoKWSvt5uAnHYr8nmG9U9O4=;
        b=nb0ls44TdjOb+U2jgSY7P3KtPkWIs8C0fBddbo7N40bKdyDGg76QKKWZ822oW04C2J
         30Rnx8ZQylQJVfJJMzOTIh6JOaGQzNzThWkOw7qxge4koumA8YeQc/eae1x5QQARwfsy
         9ITVmpTvg63URxwfqwa/1KdX01r5XoyuThvDRR37f7ye8fhIllV6L8B3awAAe1CExJQY
         37Cw3XMsS2f+ex5uoRoIaRD+EBtWdYqiqP99J2ieY8YFdhAqSHZwl15SQZBgv3pfwGFW
         lPuY2by7F5dD3hA33XGeVLzxXtP6RhymWmCK+q8VDatr8TtLq0AyWvpFZjVoPMjqP7jK
         +c7A==
X-Gm-Message-State: AA+aEWZCpoSqlFp7t6IfcOtdEO6gUa/u8aCO1ogi0jevqDDcX8g8QPco
        VqoLf8RxRMzJkI02ds1vcAM=
X-Google-Smtp-Source: AFSGD/ULRiU/JlyYWo2xyH6iiOKL4rbX6b2xOYIeAo0rG1Q7e8NVw27/JB6nTTafDCzfLE6hngsMXw==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr10708069pgx.10.1542906390409;
        Thu, 22 Nov 2018 09:06:30 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id l62-v6sm64928042pfl.28.2018.11.22.09.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 09:06:29 -0800 (PST)
Date:   Thu, 22 Nov 2018 22:36:24 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] greybus: gpio: Switch to the gpio descriptor interface
Message-ID: <cover.1542898267.git.nishadkamdar@gmail.com>
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
 drivers/staging/greybus/arche-apb-ctrl.c | 159 ++++++++------------
 drivers/staging/greybus/arche-platform.c | 119 +++++----------
 drivers/staging/greybus/gpio.c           | 184 +++--------------------
 4 files changed, 130 insertions(+), 333 deletions(-)

-- 
2.17.1

