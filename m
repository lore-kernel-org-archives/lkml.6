Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADE9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B358220854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMh2kNRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B358220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGVXsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:48:14 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:42101 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGVXsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:48:14 -0400
Received: by mail-yb0-f195.google.com with SMTP id c10-v6so6594259ybf.9;
        Sun, 22 Jul 2018 15:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A7C+IQtUBjQpU57XgReRLYs7kX27lQ6UC81xs0vzL7c=;
        b=YMh2kNRRFvozIUoU3NO2ZmrumteG88E0kMVRj+X23JL4CIWwCwt3Bl8+QhavEFiY8k
         gU56wGMAvyhplOR/T02fxLyRC3VV5h7QFPQAHd8cixh3ZMaz2Irkmz0TEvOkEJyIgIJ6
         CdFifX7kLyU1KLLSnw0G+cMdZTxT4nUO7GTk7JwU6uY/bTI1Q3AVwAaC5H0RlEl1JcPW
         JEJmNnpD6jV8Wz0RlGvUoYRTr030jCyY3AtRdVb5VnauOe4hCLWIcYihS9x3Acswkzp2
         DVGYNIpHy0c6bbJ57Ed+iDGTEXmLNAiWKJdq+z+a4wRzj5r2pIBpnGeCGBPSz3Zxsctg
         nfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A7C+IQtUBjQpU57XgReRLYs7kX27lQ6UC81xs0vzL7c=;
        b=U1ZXvghBrO7OHoU15ZMpFa2K6CJRE4JMz+dgMlR2Mynz+73Zij+L+r6bADEX6e7M49
         WEYvQKqRFInaOmzwQb9cYWWbdkLBy4kZagIA7mdOfU/iW4YHXpuF8HY59g5eCcxLllIm
         /vsACFGRvfB6PQ/GumYwwIzLmMPf/Iw2Ya6HAWO6J74eHMobkYtonNgFqbBVhBXUtQKC
         6CAyHyIVlA1GBKC2t9pQKzC+ROu+5EbEY4Q24bKPpzKOwAGabOFtBC8Hi+3xiRVJT+Z3
         74px/xXJwu2p6pRbvGuoCgk6eZ8MYgwgrFQuGYekyyVsb23Q9hZ8JWET8MKIsd4IxJCs
         JiZg==
X-Gm-Message-State: AOUpUlEdGdg3AeIB2xS4Yu7DE0EFjUouuq87By1T3ohEXx6LyK+PhteZ
        LnfbLiMxo+EOpFdOJ4J8CVo=
X-Google-Smtp-Source: AAOMgpcRXf6dNhGXgJf5dNlKCFopBOYYZcA52PQEPLFIKy062Qv1RrzyPtYXySUikrD9Abv8TNL7fA==
X-Received: by 2002:a25:6f84:: with SMTP id k126-v6mr5591015ybc.419.1532299796331;
        Sun, 22 Jul 2018 15:49:56 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id h3-v6sm3587167ywd.47.2018.07.22.15.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:49:55 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 00/11] Introduce the Counter subsystem
Date:   Sun, 22 Jul 2018 18:49:49 -0400
Message-Id: <cover.1532298882.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v9:
 - Prefix exported symbols with "counter_" to make counter namespace
   explicit and clear
 - Replace scnprintf and snprintf lines with sprintf in 104-quad-8.c
   since we're dealing with sysfs files

This revision is functionally identical to the last; changes in this
version were made to improve code clarity. Andrew Morton suggested
improving the names of the exported symbols to clean up the Counter
subsytem namespace. This revision adds a "counter_" prefix to the
exported symbols to keep the namespace tidy and these symbols as
clearly part of the Counter subsystem.

Andrew Morton also brought up a good point that the Generic Counter
"signal" terminology could conflict with the existing established use of
the term in other areas of the Linux kernel. I've changed the major
exported symbols in counter.h that used the "signal_" naming covention
to now use a "counter_signal_" naming convention in order to help
prevent this confusion; I've made similar changes to symbols in
counter.c as well. If this naming still causes trouble, we can consider
alternative names for this component.

William Breathitt Gray

Benjamin Gaignard (2):
  counter: Add STM32 Timer quadrature encoder
  dt-bindings: counter: Document stm32 quadrature encoder

Fabrice Gasnier (2):
  counter: stm32-lptimer: add counter device
  dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move

William Breathitt Gray (7):
  counter: Introduce the Generic Counter interface
  counter: Documentation: Add Generic Counter sysfs documentation
  docs: Add Generic Counter interface documentation
  iio: 104-quad-8: Update license boilerplate
  counter: 104-quad-8: Add Generic Counter interface support
  counter: 104-quad-8: Documentation: Add Generic Counter sysfs
    documentation
  iio: counter: Add deprecation markings for IIO Counter attributes

 Documentation/ABI/testing/sysfs-bus-counter   |  230 +++
 .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
 Documentation/ABI/testing/sysfs-bus-iio       |    8 +
 .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
 .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
 .../bindings/counter/stm32-timer-cnt.txt      |   31 +
 .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
 .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
 Documentation/driver-api/generic-counter.rst  |  342 ++++
 Documentation/driver-api/index.rst            |    1 +
 MAINTAINERS                                   |   15 +-
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/{iio => }/counter/104-quad-8.c        |  782 +++++++-
 drivers/counter/Kconfig                       |   51 +
 drivers/{iio => }/counter/Makefile            |    5 +-
 drivers/counter/counter.c                     | 1567 +++++++++++++++++
 drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
 drivers/counter/stm32-timer-cnt.c             |  390 ++++
 drivers/iio/Kconfig                           |    1 -
 drivers/iio/Makefile                          |    1 -
 drivers/iio/counter/Kconfig                   |   34 -
 include/linux/counter.h                       |  510 ++++++
 include/linux/counter_enum.h                  |   45 +
 24 files changed, 4352 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 create mode 100644 Documentation/driver-api/generic-counter.rst
 rename drivers/{iio => }/counter/104-quad-8.c (44%)
 create mode 100644 drivers/counter/Kconfig
 rename drivers/{iio => }/counter/Makefile (46%)
 create mode 100644 drivers/counter/counter.c
 rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (48%)
 create mode 100644 drivers/counter/stm32-timer-cnt.c
 delete mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 include/linux/counter.h
 create mode 100644 include/linux/counter_enum.h

-- 
2.18.0

