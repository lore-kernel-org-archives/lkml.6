Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0FAC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D9520892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE08xj7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D9520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeG2T54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 15:57:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33788 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeG2T54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 15:57:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id r24-v6so6488958wmh.0;
        Sun, 29 Jul 2018 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tj43NRWwO0pqgC1FeTFRBEe9+4k0aBlHopCe7Wz5ysM=;
        b=aE08xj7zvCfSZzNAKSky9/m7kAmDNIO7nu6zxTRQy+tYO0z/WLsDBvD83NrLj5d8t0
         OnVA0hgbJRfbtEyf8X6DjC6s9uNKsnLfW+9oiXNCKGiaGt18UkcYJEq0CExC4Pkv9YvW
         BVX7fj51xS0p2+DKKncTiIp3x3D/q+j0b0iIyC3ZoU0MssaSrtc1vQWKq/GQYdnDtaUI
         oW5w2NaAWqNfwRCQYxhgIvAPtIO98w5xGR8hJYwLSyt7XUmAdK3w8FjxQ5GyYcNbPKvi
         TBSgwuID/ENIW7zNufgHV13Y5+b227hKGDqU1yj3OHimZVv/Mkt4eErijFonRw69B7bi
         OT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tj43NRWwO0pqgC1FeTFRBEe9+4k0aBlHopCe7Wz5ysM=;
        b=WqxtFGpy+HMHsLobMmWjiIZMqgdIVZKhQ4VN455xLe47EQPZEq0yTcn+QZQ24pgUiP
         ntir46Rz2oSW/g4Ve3hh9aUD3vudpx8AItgZEjhhY0vnoWkd6l3UViwjEp81T9vHtasr
         pjJAi9+9N3Lj5My1ccARVGaj+bsRtLGmgCcB4C9AQI8BIhJuDdy4bcgxJpg1WYC4+8oH
         fAqZfhr+5uaBDXWVIhL7jHs27pINH/uN8PA+ezWoeBTQJqarnPysb/83zHUfG+OMyK6s
         m/9obyrVzFiAriPg+1Jnp0/NrLZ4FknFny3KblSXN5om/D3qmXHRYTWCgJugGeX0TqKZ
         DO7g==
X-Gm-Message-State: AOUpUlFh3VJpGMRL2heEkYc/wM04P4RTNE7cBr9MCmgSgIUY9iRaLY1a
        GiynKZ2MOaHEfGlZlyYPKpo=
X-Google-Smtp-Source: AAOMgpfOzF9i7JrGjhmhaQQchwnTrcSaSC41yiBW6/TJi3LlGbAMH/GXsVy+kYj9LHp1NLk8qMoXnA==
X-Received: by 2002:a1c:3b05:: with SMTP id i5-v6mr12698479wma.57.1532888795851;
        Sun, 29 Jul 2018 11:26:35 -0700 (PDT)
Received: from localhost.localdomain (p5DCFE1FB.dip0.t-ipconnect.de. [93.207.225.251])
        by smtp.gmail.com with ESMTPSA id f6-v6sm8985217wrp.30.2018.07.29.11.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:26:34 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 0/5] Add Actions Semi S700 pinctrl support 
Date:   Sun, 29 Jul 2018 20:25:46 +0200
Message-Id: <20180729182551.19383-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
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

