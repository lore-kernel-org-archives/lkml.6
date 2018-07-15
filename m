Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D250ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CAA2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PByEDACk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CAA2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeGOVIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 17:08:44 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43510 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeGOVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 17:08:43 -0400
Received: by mail-yw0-f193.google.com with SMTP id l189-v6so13522740ywb.10;
        Sun, 15 Jul 2018 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2oEZ48TktgqMUh9LzKU/mN/m3FTpCr89dsJljuCoI1Y=;
        b=PByEDACkS24MvmnGGtyS0QSeAD6N+vS+48kalojlqDO1B1HgVMuYuUtZ+qmlrJRay8
         4Bwnz5WVQP5Nr6hFdsT67L5yjkyFODn0r7BIW915EEhJ9cMUq4vehAD9zaApMx/DqrCa
         A2w4KUwGn19iWc4C3WAP9dY3QobmCEmMTHd8rNZK71hYn8qOZ6FOie3fR/jGMCO7E5om
         SWNftSqClDrX+j25ia0SdpOri9WdEyTKxF7gKgc5n96VnpQIrm2HZ5C3Ww0e/N/N9AAO
         32hGgSxBBlCvJWMjgVPkRnViR8c2YSXOq33GbdILysDCgdm8PfNJGddGxxzlTr2+ENiZ
         vzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2oEZ48TktgqMUh9LzKU/mN/m3FTpCr89dsJljuCoI1Y=;
        b=r1Z5dW3H05B90DPh6sgT+RC8m38SEWMFfnqdMG0NjgiXspAKGXnfC+EsfiEIhnj+lh
         o33NJuo9SHuHLwckvi5hRTbiJF+Fxo8LExaspRJMMNNwOOiuTHukVskqgdrC/fSQmd6P
         dJ1hJhj2jqX9n/9Ji++WZyy7mnGHKQhZ7gcIE8o4NVugod5GtMjaYT4beTcj3ghrZN7Q
         GbQWPCVlc42p9USoGSAK+1EoaD2GD7GZH6PMa1lVKCj118BoeyrnepqEh6JC9+HAbcS0
         zB0XLrCOhqFlJIFSICRjfXaetjU/szI7YSz1rOYlowAMnQtOCtOJBxWeqXoDPINzeEYI
         KxXw==
X-Gm-Message-State: AOUpUlHhwewWXtewS0efC1eb5PLIiH4VKOz3iXeViQXHj3on7gKRyKii
        GWhFwjMNsSJZWV2SZZKr0cI=
X-Google-Smtp-Source: AAOMgpfZF/cehRxyqNJYIm4wSWvR9TFWRK7BhHdQn3eBKkxKkZYj+U+X7TAIVNInZwDJRcV/3ZBY0Q==
X-Received: by 2002:a0d:f645:: with SMTP id g66-v6mr6878406ywf.253.1531687473599;
        Sun, 15 Jul 2018 13:44:33 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id o81-v6sm13749094ywb.76.2018.07.15.13.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:44:33 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org, jic23@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 00/11] Introduce the Counter subsystem
Date:   Sun, 15 Jul 2018 16:44:24 -0400
Message-Id: <cover.1531685024.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v8:
 - Add counter_enum.h file
 - Simplify COUNTER Kconfig option help text
 - Rename generic-counter.c to the more straightforward counter.c
 - Update copyright and license boilerplate (use recommended SPDX line)
 - Replace EXPORT_SYMBOL lines with respective EXPORT_SYMBOL_GPL lines
 - Replace scnprintf lines with sprintf since we're dealing with sysfs files
 - Add struct counter_attr_parm to simplify counter_attribute_create parameters
 - Rename *_comp_t suffixes to *_unit in order to avoid *_t suffix implications
 - List sysfs attribute values verbatim in sysfs documentation files
 - Reorganize 104-QUAD-8 driver license boilerplate update to dedicated patch

This revision is functionally identical to the last; changes in this version
were made to improve clarity, formatting and whitespace, and organization. I
also took this opportunity to record some of the new ACKs from the last
submission.

The counter_enum.h file was created to hold the Generic Counter enum helper
functions required by the Generic Counter enum macros (i.e. COUNTER_SIGNAL_ENUM,
COUNTER_COUNT_ENUM, etc.). These helper functions are not intended to be used
directly by driver authors, so I thought it best to keep them separated. Now the
counter.h file contains only macro, functions, and data structures that are
expected to possibly appear in a counter device driver.

The counter_attribute_create function parameter list was large so I reorganized
the parameters into the counter_attr_parm structure, which may be set and passed
by reference to the counter_attribute_create function. Since the show and store
function pointers match with the struct device_attribute show and store function
pointers, I decided to keep them declared as there are here without a typedef --
however, I can typedef them in a future revision if it will improve clarity to
do so.

Heads-up for Jonathan Cameron: you may pick-up the "iio: 104-quad-8: Update
license boilerplate" patch independent of this series; it's the SPDX license
boilerplate update for the 104-QUAD-8 IIO driver.

Sincerely,

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
 drivers/{iio => }/counter/104-quad-8.c        |  782 ++++++++-
 drivers/counter/Kconfig                       |   51 +
 drivers/{iio => }/counter/Makefile            |    5 +-
 drivers/counter/counter.c                     | 1561 +++++++++++++++++
 drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
 drivers/counter/stm32-timer-cnt.c             |  390 ++++
 drivers/iio/Kconfig                           |    1 -
 drivers/iio/Makefile                          |    1 -
 drivers/iio/counter/Kconfig                   |   34 -
 include/linux/counter.h                       |  505 ++++++
 include/linux/counter_enum.h                  |   45 +
 24 files changed, 4341 insertions(+), 86 deletions(-)
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

