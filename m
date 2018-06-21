Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6362EC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7E421EEF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Izj1ryc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7E421EEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933549AbeFUVHH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:07:07 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44264 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933015AbeFUVHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:07:05 -0400
Received: by mail-yb0-f193.google.com with SMTP id a2-v6so1176003ybe.11;
        Thu, 21 Jun 2018 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zdMYNRsTUyULQmqRvvWl0ZMAW5YD79UQwta8SiHatZ4=;
        b=Izj1ryc3LWLhoPCfROXO5zlrTS9wzwgDUykILj6BHELeW1aGDBYsKK8IT8NUU0uGHO
         EbsTUWbYnB1YHvrGkB7PZiHOALOIQS5nHv6ytVceueEohsaQhaRDTuuf3hn+8yZ829cO
         sgzcfUTurQZaDjsZ9PsWdR0YteA3wqQi8E4724/GuU06f16xI1JH/KPG9rjp804+HyAz
         VB2ptKX9qM6ILoCfP8rVHZdrsGDoQa015YUb/JIrPPcBUpMXGdLrLPD/YJk5TRkJXgj+
         QjAHU/8W60ZV3u+2e93D3JDaEaqEmmJ88cbjaEH/04tTbb8A/22dVdQFM/MC83xfdS1s
         jSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zdMYNRsTUyULQmqRvvWl0ZMAW5YD79UQwta8SiHatZ4=;
        b=k833groBFh71GOEa0c7Go9z9FNlTZbqpslJov1wwvuPhn6OlOjLW4h2D6Zk3bVhxlW
         D5AFRwzEjv2qyyMaWUxfHLHXNrDO0ZVPs7dXRqyNB5ZAKQzl34W2UjYfJL90Fd5tX7Mo
         eJOmOpNKokNW+djeIHcqQ1JVy/o45M93rE7qwyjC1KeSqwKV6QiSKMzkqPp0bTwymLTR
         lAmsKQO/Tewx5Sr9AwlrkVZfkYE1a7mrSW8HmknhVy1yVIFw1b9Gk8K66B2vqy+Sk1Pf
         GZiiU2mWuI35UfAO70fZPy4UbD1IpBD2c3+yY5g3wiRgMt9p+BdMvS9m6ilHSKX0r22D
         AKiA==
X-Gm-Message-State: APt69E1fleZcqdW1Kyp7o7gI3FGoiW/CzDKMy3M/vHyB0F7PVDexwBH0
        pvqYrzBjG1AE9fFT5ObSLVc=
X-Google-Smtp-Source: ADUXVKLJzQpa/huXasZvEfRfA4Xub4tHWMdyPOtdusCUwNKKjIIo8KdhmzSyJOvhdoXyWAMUjIE4Eg==
X-Received: by 2002:a25:aa2f:: with SMTP id s44-v6mr7182995ybi.298.1529615224082;
        Thu, 21 Jun 2018 14:07:04 -0700 (PDT)
Received: from localhost ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id c73-v6sm2285319ywa.41.2018.06.21.14.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 14:07:03 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 00/10] Introduce the Counter subsystem
Date:   Thu, 21 Jun 2018 17:06:46 -0400
Message-Id: <cover.1529607879.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v7:
 - Use git-format-patch "-M" switch option to format renames properly
   (apologies to Jonathan for reviewing delete/add pairs in past revs)
 - Remove superfluous license boilerplate in favor of SPDX lines
 - Rename functions to match <noun>_<action> naming convention; e.g.
   signal_read_value_set, count_read_value_set, etc.
 - Rename COUNT_POSITION_UNSIGNED to COUNT_POSITION, and remove
   COUNT_POSITION_SIGNED
 - Inline local variables that are only used once
 - Remove COUNT_FUNCTION_QUADRATURE_X2_RISING and
   COUNT_FUNCTION_QUADRATURE_X2_FALLING; these can be reintroduced when
   a practical use-case is determined
 - Explicitly free allocated attribute pointers on error in
   counter_device_groups_prepare
 - Remove pretty tab alignment for symbol declarations in counter.h
 - Fix kernel-doc syntax typos ("groups_list" and "groups" missing ':')
 - Clarify in kernel-doc comments the use of "val" parameter for the
   signal_read, count_read, and count_write callbacks
 - Cleanup Generic Counter attributes documentation (explain preset
   registers, remove superfluous text, etc.)
 - Cleanup Generic Counter driver API documentation (improve formatting
   by reorganizing options into intended sections, fix typos, etc.)
 - Utilize register defines to remove dependence on magic numbers in
   104-QUAD-8 counter driver
 - Update Kconfig description for the 104-QUAD-8 counter driver to
   describe its Generic Counter interface
 - Remove "mode" wording from STM32 Timer dt-bindings documentation;
   STM32 Timer features a proper quadrature encoder counter device
 - Fix typo in STM32 Timer documentation: IN1/IN2 pins are CH1/CH2 pins

Hi Greg,

This patchset is stabilizing so I hope you can take a look over it and
advise. This patchset introduces the Counter subsystem and the Generic
Counter driver API.

Last year, the STM32 LPTimer IIO driver authored by Fabrice Gasnier
opened up a discussion about the architecture of the IIO Counter
interface. The IIO Counter interface was developed to provide support
for the 104-QUAD-8 IIO driver -- several new IIO attributes were
implemented to support the functionality of the 104-QUAD-8 device. When
the STM32 LPTimer IIO driver was introduced, it too attempted to utilize
the IIO Counter interface to support the counter functionality of the
STM32 LPTimer device.

However, there were some difficulties with the IIO Counter interface.
For example, the 104-QUAD-8 device features a pulse-direction counter
and quadrature encoder counter (which can be toggled via the
quadrature_mode attribute), as well as three quadrature encoder modes
(x1, x2, and x4) which are set via the existing IIO scale attribute.
While this method works for the 104-QUAD-8, the STM32 LPTimer featured a
slightly different Quadrature x2 mode with different state machine
behavior -- as such there is ambiguity over what behavior "quadrature
x2" represents in the IIO Counter interface.

I decided to strip down these devices to arrive at the core essence of
what constitutes a "counter device" and therefore design a "generic
counter" abstraction to better represent these devices and prevent the
ambiguity we discovered with the existing IIO Counter interface. This
abstraction became the Generic Counter paradigm, which is explained in
detail within the Documentation/driver-api/generic-counter.rst file
introduced by this patchset.

Initially we attempted to further extend the IIO Counter interface in
order to integrate the Generic Counter API as part of the IIO subsystem,
but the outcome wasn't as clean as we desired. The results of our
efforts proved to grow increasingly complicated, sparsed with hacks, and
more often than not fought with the IIO subsystem rather than
complemented it. I decided to separate the Generic Counter API from the
IIO subsystem, and give it its own Counter subsystem in which to reside.
This allowed us to streamline development and avoid jeopardizing the
integrity of the IIO subsystem (we no longer have to bend the IIO API to
support our needs, but can instead implement the necessary
functionalities in the Counter subsystem as required).

The Counter subsystem has three consuming drivers thus far: two ported
from the IIO subsystem (104-QUAD-8 and STM32 LPTimer counter) and one
unique to the Counter subsystem (STM32 Timer counter). In userspace, the
Generic Counter interface is rather intuitive:

    * /sys/bus/counter/devices/
      - enumerated directories for counter devices
    * /sys/bus/counter/devices/counterX/
      - attributes for counterX where X is the enumeration ID
    * /sys/bus/counter/devices/counterX/signalY
      - attributes for signal Y where Y is the enumeration ID
    * /sys/bus/counter/devices/counterX/countY
      - attributes for count Y where Y is the enumeration ID

Although at this point the Counter subsystem is functionally separate
from the IIO subsystem, I believe it would be prudent to merge this
introduction patchset via the IIO tree due to the historical context of
these counter drivers and the development of this patchset. Are there
any additions or changes you believe I should make to this patchset
going forward?

Sincerely,

William Breathitt Gray

Benjamin Gaignard (2):
  counter: Add STM32 Timer quadrature encoder
  dt-bindings: counter: Document stm32 quadrature encoder

Fabrice Gasnier (2):
  counter: stm32-lptimer: add counter device
  dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move

William Breathitt Gray (6):
  counter: Introduce the Generic Counter interface
  counter: Documentation: Add Generic Counter sysfs documentation
  docs: Add Generic Counter interface documentation
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
 MAINTAINERS                                   |   14 +-
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/{iio => }/counter/104-quad-8.c        |  782 ++++++++-
 drivers/counter/Kconfig                       |   59 +
 drivers/{iio => }/counter/Makefile            |    6 +-
 drivers/counter/generic-counter.c             | 1519 +++++++++++++++++
 drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
 drivers/counter/stm32-timer-cnt.c             |  390 +++++
 drivers/iio/Kconfig                           |    1 -
 drivers/iio/Makefile                          |    1 -
 drivers/iio/counter/Kconfig                   |   34 -
 include/linux/counter.h                       |  534 ++++++
 23 files changed, 4292 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 create mode 100644 Documentation/driver-api/generic-counter.rst
 rename drivers/{iio => }/counter/104-quad-8.c (44%)
 create mode 100644 drivers/counter/Kconfig
 rename drivers/{iio => }/counter/Makefile (52%)
 create mode 100644 drivers/counter/generic-counter.c
 rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (48%)
 create mode 100644 drivers/counter/stm32-timer-cnt.c
 delete mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 include/linux/counter.h

-- 
2.17.1

