Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC1C282CB
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5822133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pW5Omw8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfA0UaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:30:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37239 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0UaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:30:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id t33so16230179qtt.4;
        Sun, 27 Jan 2019 12:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x0xpwfJTYmKMrI6IiBvN0+6STIL0Vh4u6UvzeC6GJo4=;
        b=pW5Omw8p6G8BzpwC1kCuWI+4cJtrNY+Fiiak/naWdzD+vne1gHMieJadn0+1k4CQnE
         3coWixByAAbYQWm9zGIGt9KOWuDeodELQ+o+7xgLCgVWWC2w86JtwualPR/9HguMG6KC
         3yy/TSB4kgazR1omO+fa1+add9cuLA8BGayRFfrAEq4sQ8VIkvNPapLEPFJoDSZtzZWr
         v4T0VsgpIHTa47u5WIT6mbS7gpKm9ZzQ1EgtZIpnn2Vktmyj1lc2sLNF25O2KreRr76k
         UxPRh2+T6oBxbMfZ/Q4bHIzaDeTdeLlDnU+32f/S0GFW5YpLtM8Fh21yalHx9OBiarTE
         pyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x0xpwfJTYmKMrI6IiBvN0+6STIL0Vh4u6UvzeC6GJo4=;
        b=RAQOR2bUOgmTBhbGCsTXf7OFp1OMeCMMEDLGIv2KoOB6YfAHh6BCEnIrKQhf4HjQKT
         6UsuQKz51kioQIFtrR0o4+dDPUXAx6UAYjOrUHqJFGJ2c5ok6khsbWhuY+YRfzoi9Bg4
         IEqx92QlTE5EwpVYxB/d6RhUsCYOzAAMHdaagI/vs0wKbjSVDjUCmWZ0ArbLLpMJQNhr
         oRowQjn83968DSTkZqDnuDV4ASv4Kp1dVr6EebNMafCPKMZb8Cj0nDww00Ch3eGzsxf4
         JZgmEmE75UqO3WSUfTFF0mhhkJx80anFXh3x69co/M8O7zME8nNmI0KfkNNF9LL7aqpk
         y9QQ==
X-Gm-Message-State: AJcUukcJ/iKswK/OjWzwlADz+fHS5z+nS7a6on97jPfMNwF+0+va1RHd
        5msv1yME7Vvh1vEQtGuV3XU=
X-Google-Smtp-Source: ALg8bN6RmF4UawEAhLMuhFUIVNrs0Obu59DkbGCkWUDskDO5oFG10HgoeQQPdjq6HinPWWsvKjFN0Q==
X-Received: by 2002:ac8:2e6a:: with SMTP id s39mr19307233qta.355.1548621013703;
        Sun, 27 Jan 2019 12:30:13 -0800 (PST)
Received: from renatolg ([186.220.19.121])
        by smtp.gmail.com with ESMTPSA id e186sm59608324qkb.32.2019.01.27.12.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 12:30:13 -0800 (PST)
Date:   Sun, 27 Jan 2019 18:30:00 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 0/2] staging: iio: ad7780: move out of staging
Message-ID: <20190127202957.o3ghqnwjt2konxge@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add user input to ad7780 'gain' & 'filter' gpio
pins. It also includes a patch to move ad7780 out of staging and to the
main tree.

Renato Lui Geh (2):
  staging: iio: ad7780: add gain & filter gpio support
  staging: iio: ad7780: moving ad7780 out of staging

 drivers/iio/adc/Kconfig                |  13 +
 drivers/iio/adc/Makefile               |   1 +
 drivers/iio/adc/ad7780.c               | 361 +++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig        |  13 -
 drivers/staging/iio/adc/Makefile       |   1 -
 drivers/staging/iio/adc/ad7780.c       | 277 -------------------
 include/linux/iio/adc/ad_sigma_delta.h |   5 +
 7 files changed, 380 insertions(+), 291 deletions(-)
 create mode 100644 drivers/iio/adc/ad7780.c
 delete mode 100644 drivers/staging/iio/adc/ad7780.c

-- 
2.20.1

