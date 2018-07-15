Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF50ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C0B20844
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obsqRhp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C0B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeGOU0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:26:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52068 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeGOU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:26:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so13153799wmc.1;
        Sun, 15 Jul 2018 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z9YKA9R2NRkKMrSWa+w/f/JkmOU8hR/EOaf+VhzWy4M=;
        b=obsqRhp6Ense03/jzik4Oxnc7k+VeBxR8yYcj9QvYjeEQc80XDBr0R4do+CsCt+hi3
         ivCXOhdDNhFm4An4wryHktlbBoU9m3v1UW1jfxMsUO+o0+b+nD3odIpFezE/lnXTNH3t
         y7Q2DLfa5WHD/aa/67Pvt5GjxBgz4rxTUqZt5Ar0qGgqHn9zITqnPkUO2nRqGWYwTcmr
         bL/UMZp6ZPcd3p/YD9mrxtL2Nqf1+8xWLnkFf9IPhN19m5FioH4HLIh58LJcfJw21TOB
         PKWsPj6c9Jv3OcuvxUPxw7WbdgWXqxDJbHb/P6erGbDXIPn+ZGP9d09X5lR2w6dpp+Ip
         F2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z9YKA9R2NRkKMrSWa+w/f/JkmOU8hR/EOaf+VhzWy4M=;
        b=MFtecYtqYukx4JVlsPLWlcMZy+SCaZkFZdEiegQmYO1JMgi1GagIKQZV7UepEf/ZrV
         w0Qw2y1a2IkXcaK7koLijCqSW08ej1AdS2LPiibjOL02/B1uI+Xk4tK/S0V8bdNrzJpm
         zXewOoTZmXHTINBCxMjjmqbPoUX6jkOKWLP0Mu+HMLxoARWzr+e8ZX+5OluaIfFOWFQf
         wRe9aK1bqs1dj6CyqpyUAjXg5S2Zp8FZF/hgxNOHXuLzDhSPWe+pyzV2RrYH65qdl7+o
         T1JqMk3SMSADUKwlYm94SCpkX6KP2jvt7X6Nd2BCo4CCarSGN8a2a0XvwuQm2wK4nQIf
         mk5Q==
X-Gm-Message-State: AOUpUlHfZhdNwGvHuqrRZBofiaIgKyjBG1iCjqjWXO464sjPDMyr/PXG
        dJAKhJ3BY1yk8wzgkTWadXA=
X-Google-Smtp-Source: AAOMgpdluZ7bs9EtJ0LXp7nnrho+8g2L0l857eL9QLu2LQm13ZI3McNCfhut2/ViH9YRMdUJ2OHPsA==
X-Received: by 2002:a1c:5dd4:: with SMTP id r203-v6mr8265776wmb.29.1531684933186;
        Sun, 15 Jul 2018 13:02:13 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id z7-v6sm20816234wrh.85.2018.07.15.13.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:02:12 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v5 0/5] Add clock driver for Actions S700 SoC
Date:   Sun, 15 Jul 2018 22:01:46 +0200
Message-Id: <20180715200151.10416-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for Actions Semi Owl series S700 SoC
with relevant clock bindings and device tree info. 

Changed the UART clock using CMU instance and changes are tested in
cubieboard7

Changelog v5:
- Commit message corrections
- Removed MMC_OWL_CLK_NANDPLL option, as no active consumer
- Device tree clock label name correction

Changelog v4:
- dt-bindings use absolute numbering for clocks
- Patch re-oredering

Changelog v3:
- Splitted uart clock DTS changes into separate patch
- Splitted REGMAP Kconfig selection into separate patch
- General naming convention as "Actions Semi" in dt-binding documentation
- Patch re-oredering
- Cleanup and fixed review findings

Changelog v2:
Fixed 0 day compilation warning
Modified existing dts Actions S900 clock bindings common to Actions
Soc family


Thanks and regards,
Saravanan,
Parthiban

Saravanan Sekar (5):
  clk: actions: Fix the missing REGMAP_MMIO dependency
  dt-bindings: clock: Add S700 support for Actions Semi Soc's
  clk: actions: Add S700 SoC clock support
  arm64: dts: actions: Add Clock Management Unit for S700
  arm64: dts: actions: Set UART clock reference from CMU

 ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +-
 .../boot/dts/actions/s700-cubieboard7.dts     |   8 +-
 arch/arm64/boot/dts/actions/s700.dtsi         |  14 +
 drivers/clk/actions/Kconfig                   |   7 +
 drivers/clk/actions/Makefile                  |   1 +
 drivers/clk/actions/owl-s700.c                | 606 ++++++++++++++++++
 include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++
 7 files changed, 758 insertions(+), 16 deletions(-)
 rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (68%)
 create mode 100644 drivers/clk/actions/owl-s700.c
 create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

-- 
2.18.0

