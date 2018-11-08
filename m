Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAE8C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC632086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KAuDRxfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC632086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeKHUTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:19:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38034 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:19:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id f2-v6so706894wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhPNVmfRa7pNj+I7+aRTRJyzPUhJcyunyJ631PKqVN0=;
        b=KAuDRxfV51gyqH2rydf36nfkogw6aaFx9BalBn1zZaWDQCAWu3nPiQZHmSWC9i7CsS
         LU/i8c+wmoYJ4s1jDGJiZMeurcXyb/56EmgGoBMdhofORAmcrdu86yd3U2Wzg9+OCWGn
         iT/IdNpg/nMGMlllh706QcbIjc8lUEseB92YGm+QWGKY+PbTY7+sANcfGFirqOV6IOct
         +gkrV2feHpoun1ip/T6Wu5+PqUP5JrqqbPWtlAL5rbRijy93TofjQT+2VL/L4BSkPwuJ
         rvEhFV7BA0yq9KAI1Ay665ZG/XPoVrvoay3JQtafh7MpBU9ox4kCG2yLfO2qbEfevHq2
         Qq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vhPNVmfRa7pNj+I7+aRTRJyzPUhJcyunyJ631PKqVN0=;
        b=NnFJgONb4GoNHVJnEQKVb9z+WQbzb4V1HfoHTuccVzqMrXEfrBc6TpNTAlWDbDw+o1
         Y2516aMsX0aVezYdSYcmGNtpFvFnXMZE01rT3NCQf6jOg260rkSQmlT3EIwvR8Z8ftpt
         XLcPSqE2P9JYORwOKMAIe5SPwRbOXQmaPMEY5vzc1rFV+qOHz4jL2/0RwGwp+UYsjvEX
         cmooSlvb9qpPVF6BmlYBlkEDCFlaheg5Xi+aoyeW5fVZc+n8zA0o3Q6gTOlZ7mcOo/Ai
         UOOxIhF4Cclzje3QlXYn4MYZ/EJrYxkf0atQno7qub1AxV6j3anmbv9dhA5PGqJdnhp2
         whwg==
X-Gm-Message-State: AGRZ1gJYAyWWkbeK8Hsulr9n1+HAadB7nLTYhnE+vQrfNN4MaYEjNTxV
        xblGveJM5wqlIIv8U920vXRffw==
X-Google-Smtp-Source: AJdET5cS05uLjdFe4jY+1B2N4ffNf/4+hvR09ODCfpJg2AtYSVnxsz8CodO99dJDY3Y3pPypWnLg2A==
X-Received: by 2002:a1c:38c1:: with SMTP id f184-v6mr780517wma.24.1541673889832;
        Thu, 08 Nov 2018 02:44:49 -0800 (PST)
Received: from boomer.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o130-v6sm5884800wmd.11.2018.11.08.02.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 02:44:49 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ARM: dts: meson: set pinmux bias
Date:   Thu,  8 Nov 2018 11:44:22 +0100
Message-Id: <20181108104426.1877-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Amlogic chipsets, the bias set through pinconf applies to the pad
itself, not only the GPIO function. This means that even when we change
the function of the pad from GPIO to anything else, the bias previously
set still applies.

While trying to boot from SPI, I noticed the eMMC was not working anymore.
Even if the related eMMC pad are not used by the SPI, the ROM code sets a
pull-down on the eMMC pad and leaves it that way. This breaks the eMMC
later on, in both u-boot and Linux.

The underlying issue is that we inherit whatever was left by previous user
of the pad (pinconf, u-boot or the ROM code). As a consequence, the actual
setup we get is undefined.

There is nothing mentioned in the documentation about pad bias and pinmux
function, however leaving it undefined is not an option.

This patchset consistently disable the pad bias for every pinmux functions.
It seems to work well, we can only assume that the necessary bias (if any)
is already provided by the pin function itself.

I can't really test every pinmux configuration and it is fairly possible
I missed something so it would be nice if more people could confirm if
nothing (new) is broken after applying this series.

One things could be the i2c. Usually the i2c pull-ups are physically
present on the board but, if they are missing on platform, we may define
a special pinmux setting with pull-up enabled.

One last gotcha, I recently posted fixups around bias setting to pinctrl
which have been merged: [0] [1]. These must be applied before applying this
series, otherwise when requesting 'bias-disable' you'll probably get a
pull-down instead.

[0]: https://lkml.kernel.org/r/20181023160319.27003-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20181029151340.9087-1-jbrunet@baylibre.com

Jerome Brunet (4):
  arm64: dts: meson: remove extra subnode in mmc clk_gate pinmux
  arm64: dts: meson: disable pad bias for mmc pinmuxes
  arm64: dts: meson: consistently disable pin bias
  ARM: dts: meson: consistently disable pin bias

 arch/arm/boot/dts/meson8.dtsi               |  12 +++
 arch/arm/boot/dts/meson8b.dtsi              |   9 ++
 arch/arm/boot/dts/meson8m2.dtsi             |   1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 111 ++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  60 +++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  62 +++++++++--
 6 files changed, 231 insertions(+), 24 deletions(-)

-- 
2.19.1

