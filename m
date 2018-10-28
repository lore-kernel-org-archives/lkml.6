Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7040ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA6320824
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRPlWHmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA6320824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeJ1Qd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:33:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42849 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeJ1Qd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:33:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so2409219pgq.9;
        Sun, 28 Oct 2018 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fp/9xhOD4HmbDF1HFdOd79Yf2CXGwv8kOhhb6d8fvHQ=;
        b=DRPlWHmXfEgKDLuQEObzbRdPkOOjwSCmj5kq+n2EoPDdn82EGIbPvygnk9YknrWawt
         /UYZ44J5dukNMGgdPFgOg7e42UlF4KOC/bK1ZKdtX03rZ6Fu7XUTAN7ukRpNsph1XzO9
         qWyzZ+Z9Ohs4++QVlOHY/XxRwJM3RI8NLMxmHgczSXP8rCB0pEAmzy6SqNPmwwbXQ8PM
         zBilOx9IBaC/S2a40/pFvFtsvu9yNnZaX04sTNglTxvu4mn8Jd9ksf4iyxtK8MzX02i2
         sEfQRjubVtFd6JB3PmC1FgnqelumTNaYIC7boht3Qg886Wqep7DKD/0zhAgKQ6qz0vJ/
         3Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fp/9xhOD4HmbDF1HFdOd79Yf2CXGwv8kOhhb6d8fvHQ=;
        b=li7Zv29nh+su1nBbvLBady1/uo5ivIAE3SY5SVQ6aJ4+uZXCPfeYbSD9qiBoDqnXY8
         Wqagz2tpXdTH8NhgB11QD6Fbf2Y+ngYShz8towNoX11ugWjwh4uj2u6JzwPDwS4b78rq
         mKzxD5sLJk/9Djz7AC585jYIGLPU5/zlGASL8vLhvXq8K0IcHXForFDWDZfYBMVL4DLV
         acH6azAxTxbx2rxLwn1jbrxGwBW0phFKr0E+evTknFIGVx4Msd9L0ln1hCYIaFpMzht3
         vIwTpo2blcCyAoLROSWeCZcYPZI/5vQ7aLVWplnHZGcbVUtJLT0ZFNyCwUoNkMMRUzpN
         gHaw==
X-Gm-Message-State: AGRZ1gImcHUKkb36vSvjZsvvMicPOnLnaYL9ECOoC0kXNIPVUMvl6mY1
        0UmkHJg5SqVVlGSFDgwMFjI=
X-Google-Smtp-Source: AJdET5crpDOU2ahx1Mt4JQxoeonw7L8bLfKrh/o1ockY1IMkn7fy0V+j+SZC2hJb+bncoCYtyFOhmQ==
X-Received: by 2002:a63:ce14:: with SMTP id y20-v6mr9688461pgf.248.1540713006718;
        Sun, 28 Oct 2018 00:50:06 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id t9-v6sm8514357pgl.37.2018.10.28.00.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 00:50:06 -0700 (PDT)
Date:   Sun, 28 Oct 2018 13:19:59 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface.
Message-ID: <cover.1540712249.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor

Changes in v6:
 - Split device tree table addition and device tree support 
   addition in two patches.
 - Replace platform data with device tree support.
 - Rename boolean property.
Changes in v5:
 - Add device tree support.
 - Add device tree table for matching vendor ID.
 - Add Support for retrieving platform data from device tree.
Changes in v4:
 - Add spaces after { and before } in gpios[]
   initialization.
 - Check the correct pointer for error.
 - Align the dev_err msg to existing format in the code.
Changes in v3:
 - Use a pointer to pointer for gpio_desc in
   struct ad2s1210_gpio as it will be used to
   modify a pointer.
 - Use dot notation to initialize the structure.
 - Use a pointer variable to avoid writing gpios[i].
Changes in v2:
 - Use the spi_device struct embedded in st instead
   of passing it as an argument to ad2s1210_setup_gpios().
 - Use an array of structs to reduce redundant code in
   in ad2s1210_setup_gpios().
 - Remove ad2s1210_free_gpios() as devm API is being used.
-

Nishad Kamdar (3):
  staging: iio: ad2s1210: Switch to the gpio descriptor interface
  staging: iio: ad2s1210: Add device tree table.
  staging: iio: ad2s1210: Add device tree support.

 drivers/staging/iio/resolver/Kconfig    |   1 +
 drivers/staging/iio/resolver/ad2s1210.c | 114 +++++++++++++-----------
 drivers/staging/iio/resolver/ad2s1210.h |  20 -----
 3 files changed, 65 insertions(+), 70 deletions(-)

-- 
2.17.1

