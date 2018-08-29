Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C3BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45F72084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMzbE7Tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45F72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeH2MUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:20:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46990 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeH2MUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:20:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so3904493wrc.13;
        Wed, 29 Aug 2018 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XtYRjlhiKvEpjJetczLkLlsMnUaCN4xaDfrvFFQKH9o=;
        b=gMzbE7Tx9iuQCtTcb8B3FPVab6qz0YdA6Vh2LHz7OawXSrCvDAY0SMdB/4PyVZRe8T
         cFEaqqqvjBRIAFa3rJVKY8FvkrNqSSQHjs8fk1uePT05jYG1OxSEOpw7NUmFqMdZjcs8
         fMJrj2qiOu4JFNRBnhQzNIOa2zO8XwEoub0+DXPOWe4P+XNVyI6Zn+lv+GxLSMipgSvx
         P1Vx9OtAPShNkyrlHGoNDox5bDN0uPMt9UhZHPf93IsY+MSAZp/UYekff5VGbRs8Vytg
         ZdIcPHbvI1gHvHj0nHqx14w3nEzUlHKlHRGTY4izIcVX8Se5Vc5Q/uPdyR8mN41Ki0ZE
         8uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XtYRjlhiKvEpjJetczLkLlsMnUaCN4xaDfrvFFQKH9o=;
        b=GsgUZeYaxHK0fMzNwHEEGVpSq/GZcJ6oS64+h/IqywMjclGVa3JFwY+lb2KVuKbp+j
         VXDKm5y7sNI5VTm7z0lQLJDO+TbpIx1s8fW3qJfn6f4RF6X2vfdeUl5s/RPqFj1DQkJJ
         U9Wil45yAK/sQWQbBQRmT9WoNS86qVa0ihCQ//Dgoe+Wx6keUzQcGf/Q++8koOav7API
         B6P/WsE1tRGUzHaZsMVn6CQypx5B9t9R4qYrdZtwA2Sr4Xbyu+naCww0cEVvR9S6ZscP
         dtNXmQ4mKILoQ4J/HTJy9AhJRtj3p/G/yw3z/QieUyCW8MvqGqqYfTOs/fFQ0ytZ+iMc
         jkVA==
X-Gm-Message-State: APzg51BB8VZOQA5J8Y0hiD+27iBeZ6J2H53aqY30Rgc0FcU8rjHBIqpb
        RzxvSTIu1ED+U+DpEpiXjDQ=
X-Google-Smtp-Source: ANB0VdaTcllByKNPkdAiByLvgPOMvSAcGXQ1pjA7pzt+dUMjyzw8bZf5azahG1eQL62rc/w2Lvrxug==
X-Received: by 2002:adf:b609:: with SMTP id f9-v6mr3367905wre.14.1535531070215;
        Wed, 29 Aug 2018 01:24:30 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id g7-v6sm3013025wrw.30.2018.08.29.01.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 01:24:29 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 0/5] Add Actions Semi S700 pinctrl support
Date:   Wed, 29 Aug 2018 10:24:08 +0200
Message-Id: <20180829082413.2512005-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
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

Chnagelog in v4
- Fixed 0-DAY sparse warnings on static declaration

Chnagelog in v5
- Rebase to mainline

Saravanan Sekar (5):
  pinctrl: actions: define constructor generic to Actions Semi SoC's
  pinctrl: actions: define pad control configurtion to SoC specific
  dt-bindings: pinctrl: Add bindings for Actions Semi S700 SoC
  pinctrl: actions: Add Actions Semi S700 pinctrl driver
  arm64: dts: actions: Add pinctrl node for Actions Semi S700

 .../bindings/pinctrl/actions,s700-pinctrl.txt      |  170 ++
 arch/arm64/boot/dts/actions/s700.dtsi              |   16 +
 drivers/pinctrl/actions/Kconfig                    |    6 +
 drivers/pinctrl/actions/Makefile                   |    1 +
 drivers/pinctrl/actions/pinctrl-owl.c              |   71 +-
 drivers/pinctrl/actions/pinctrl-owl.h              |  142 +-
 drivers/pinctrl/actions/pinctrl-s700.c             | 1925 ++++++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c             |  205 +--
 8 files changed, 2337 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
 create mode 100644 drivers/pinctrl/actions/pinctrl-s700.c

-- 
2.14.4

