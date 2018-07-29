Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C5C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B30920882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS+ypCvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B30920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeG2Vcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:32:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39192 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeG2Vcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:32:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so11284311wmb.4;
        Sun, 29 Jul 2018 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1e/Z6iDtW29Zz88e4CLIZEz9d8fpoppz46fhoPYktZo=;
        b=KS+ypCvRgNfR5zrpJzYy46CCbOZ0q52V7XhqspB8qNzmYFC9Yxv9o64HRqrkxcw73y
         nT1xFlxTkMK39Vq02L3LDMKraFwdLagAovb72+CUo1aWgnGMgpybNcXe0djgoBmVUHym
         16mOfzHYbgRvslCxrLUFiYpG38Ysisx0L8H5om+8KIoWe7nLW2Pqbmq4aVyW/NYFFFvI
         tYTLrUcTZ6qChAwVoUwMdM251POdz7MqfwCUtIBID2oz1j+5lrlP0JsA7AKK9Ywnem6M
         ZRiBjR4mKNu2P6g2r1pqwumJVf0g0gviPkFtLCNM+i17PJbyfoZ42o6w44AW27nz+sU+
         lIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1e/Z6iDtW29Zz88e4CLIZEz9d8fpoppz46fhoPYktZo=;
        b=UUBGxKBbryNP4oq0CcKMc4sNjWztUC2a/dCAjYm/izxOXKXmbnyE4GEJ8SfW/9uhyI
         aC/TLcIRmOgJTCZMGVOM2i4i3ew9Ki0r5L0/OrdMb6EceJjIU1ylvyR8HWxGL5X+jQMK
         x/FfsEymoKabliDAmALP2owZ2h6t7KMQcSJovEzyPMw+M9DnWzYdPKeunyPBNn8OBIQB
         iRI/ru4hmjbean64POxnRwy1p759b6kBeYqGCDyX0GxZMxtGvF6khgOlQxp/lG6WZGEw
         s7yHcmiT8rmRbQ6Tj7rnRi4l9ddofagYwtXp8naIqqDmWFXfhOfP/I46NPAuPAfFHHEu
         iiUA==
X-Gm-Message-State: AOUpUlFKqU5KcY2C7wYBQsnWWKMKcKfgPl9JVcvlfEmtAOENIop10uxY
        //B03w97U8zPIBsreeMtGe4=
X-Google-Smtp-Source: AAOMgpewoh4/G6k1RISZVW/tEf1s45NBM9Mjz9HtDIvKI2g0y+Hu2TdIEJWoEAYrmUQdmdZBckVMCA==
X-Received: by 2002:a1c:4d16:: with SMTP id o22-v6mr12115483wmh.49.1532894474666;
        Sun, 29 Jul 2018 13:01:14 -0700 (PDT)
Received: from localhost.localdomain (p5DCFE1FB.dip0.t-ipconnect.de. [93.207.225.251])
        by smtp.gmail.com with ESMTPSA id g15-v6sm12334213wrh.48.2018.07.29.13.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 13:01:13 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 0/5] Add Actions Semi S700 pinctrl support
Date:   Sun, 29 Jul 2018 22:00:33 +0200
Message-Id: <20180729200038.11795-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729182551.19383-1-sravanhome@gmail.com>
References: <20180729182551.19383-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds pinctrl support for Actions Semi S700 SoC.
Pinmux functions are only accessible for pin groups while pinconf
parameters are available for both pin groups and individual pins.

pinctrl driver is verified using the Cubieboard7.

common functionalities from s900 is moved for all Actions Semi
SoC's usage.
Common pad control configurations are moved to SoC specific

dts entry for pinctrl depends on clock driver which is still under review:
https://patchwork.kernel.org/patch/10533959/

Thanks,
Saravanan
Parthiban

Changelog in v2
- GPIO Interrupt support is added
- Device tree entry for GPIO and Interrupt configured
- GPIO and pinctrl define reorder, commit message findings fixed

depends on owl GPIO Interrupt support
https://patchwork.kernel.org/patch/10483477/

Chnagelog in v3
- Fixed 0-DAY bisectibility error

Saravanan Sekar (5):
  pinctrl: actions: define constructor generic to Actions Semi SoC's
  pinctrl: actions: define pad control configurtion to SoC specific
  dt-bindings: pinctrl: Add bindings for Actions Semi S700 SoC
  pinctrl: actions: Add Actions Semi S700 pinctrl driver
  arm64: dts: actions: Add pinctrl node for Actions Semi S700

 .../bindings/pinctrl/actions,s700-pinctrl.txt |  170 ++
 arch/arm64/boot/dts/actions/s700.dtsi         |   16 +
 drivers/pinctrl/actions/Kconfig               |    6 +
 drivers/pinctrl/actions/Makefile              |    1 +
 drivers/pinctrl/actions/pinctrl-owl.c         |   71 +-
 drivers/pinctrl/actions/pinctrl-owl.h         |  142 +-
 drivers/pinctrl/actions/pinctrl-s700.c        | 1925 +++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c        |  205 +-
 8 files changed, 2337 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
 create mode 100644 drivers/pinctrl/actions/pinctrl-s700.c

-- 
2.18.0

