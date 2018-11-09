Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D182C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4E208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="nm6yixIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC4E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeKJHnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:43:43 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38605 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeKJHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:43:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so4340531qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dING+HiS7HKWkkFEB+SEPaXGLx4JAuKSkz5VRR/7Cok=;
        b=nm6yixIcEHATojXTP/rq2iz5I/4kTmTMqHMHOt7MY0MywCm9N1SPwtvHGCmrOTy8lt
         w7eiZypRk4RJkBI7vzCYeOMq8qSKrcwR3D5V1LV9YR19Tg0YNGWXdhTUgMfi1JgCQSHJ
         2WwKw/228Z5ow1xWIWbGpPM31Ml5vsEwa1teB7D/5232ZGKKqeNpCzPsi4SQBgJH1dyf
         EGMzy7zAL7bzgX24sQ74sqamxnuvl0XH+HSNVU5dXXS5D9LPuGbCE/Ch3eag4axTD5U+
         kA8AxDruoABbYpXb81qq/QEshqaRfuM1MFFTPKoMHN+r+KOKv61i3fOjCgH0aD2+muIn
         8uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dING+HiS7HKWkkFEB+SEPaXGLx4JAuKSkz5VRR/7Cok=;
        b=oKeGQCxtKZF0kGJIpRqWSAKgmmK/9mR44eFYLhFe8/xgUwwg6j7sKjmQn9E4fVe16a
         3QfQ2d5qnCVEMcEyzppkt6Lp03iA2+c5+CA6uUcLNq6F9LawxTI2ETY4aWB3wIA+pZ8/
         UnUV39gfnE3mWNcLCyx4PKjKG1UvwJGEz6cyargqtNyb5mXrX7Nbd+xKVO9TUImdieCL
         FzUFOEbZdc64huM9sR9fc0WNrHyeJ3m96iFXbZA3D7s8VKqDZqw3wZzKZAKv4/SITWQ4
         1wNA4wBDLIawW6SjGbLcVMhbNEG3bgsjZMeGaZl1qeMjYbDOtf+anSh6UKGl5WHE9ugC
         Z2Fw==
X-Gm-Message-State: AGRZ1gLIkMrdlIke+J+ojVk94ebBRqO12oExgILlkB2G5eAGyvhaEjq/
        iuHJ98EgMlOwfaYd/Tqbe1L4WA==
X-Google-Smtp-Source: AJdET5cNWuv9507medUqibxB0PSrpjZYicTEqXFXix34g14kjH2Txps/84MyW7H4rC0zNB0eyimv2w==
X-Received: by 2002:a37:a703:: with SMTP id q3mr9985720qke.272.1541800871772;
        Fri, 09 Nov 2018 14:01:11 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id k6sm6082723qtk.41.2018.11.09.14.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:01:10 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH 0/6] staging:iio:ad2s90: Add dt support and move out of staging
Date:   Fri,  9 Nov 2018 20:00:38 -0200
Message-Id: <20181109220044.24843-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds device tree support to ad2s90, with standard
device tree id table, adds the respective dt-binding documentation,
solves a codestyle warning and move the driver out of staging.

This patch set completes all the remaining itens listed to be done
before moving the driver out of staging, enumerated in this mail thread:
https://marc.info/?l=linux-iio&m=154028966111330&w=2, except by one
codestyle problem: "CHECK: struct mutex definition without comment". It
seems to be a commonly ignored check for mutexes of device states. If I
am wrong, please, let me know and I will be happy to send a patch to
tackle it.

Matheus Tavares (6):
  staging:iio:ad2s90: Add device tree support
  staging:iio:ad2s90: Remove spi setup that should be done via dt
  staging:iio:ad2s90: Add max frequency check at probe
  dt-bindings:iio:resolver: Add docs for ad2s90
  staging:iio:ad2s90: Add SPDX license identifier
  staging:iio:ad2s90: Move out of staging

 .../bindings/iio/resolver/ad2s90.txt          | 26 ++++++++++++++++
 drivers/iio/resolver/Kconfig                  | 10 ++++++
 drivers/iio/resolver/Makefile                 |  1 +
 drivers/{staging => }/iio/resolver/ad2s90.c   | 31 ++++++++++++-------
 drivers/staging/iio/resolver/Kconfig          | 10 ------
 drivers/staging/iio/resolver/Makefile         |  1 -
 6 files changed, 57 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
 rename drivers/{staging => }/iio/resolver/ad2s90.c (81%)

-- 
2.18.0

