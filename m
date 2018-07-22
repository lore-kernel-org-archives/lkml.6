Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05199C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9E020854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIV70HUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9E020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbeGVRda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:33:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39891 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbeGVRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:33:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so14047306wmb.4;
        Sun, 22 Jul 2018 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FUjjrbkH5Elfvj/1+BIl2kR6ghyGwGKFDxZvHjf7Oeg=;
        b=CIV70HUQBXkaSBmDzIZXrdv2he04FvJkPChuRsxIU4ti3UoR8wmoI23cZYt5vi4Jwo
         9q+ZWANKtWyfA45P7C6DNujh1da8TY2MrdGQdmBl9XnYFFi3d4K7kZCofMhRYoLpfLuD
         SG4OrhpKrWr846eZKUT+WZTQEsdRNu7SpbdyJdGgB19HhuexVSUQQli5BXKPnTT7mM2R
         d7W71qQgHcRL5Sqz1WCju+B9nGOa0MW2VKeMIRD5MENSKYa7hWPNRZROCAnLZm6uqNCA
         mhOWw39OZYTNEEhEp4LV0K+6YKjMUoL5CHxD63gOkmqVnAOPTS37ueWso4FOYc47sdgP
         ARXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FUjjrbkH5Elfvj/1+BIl2kR6ghyGwGKFDxZvHjf7Oeg=;
        b=MVngilGHSlmii6Wy8XCakvI3uJZx0rAHmtA+Qo9ahwB8QeAzt68Zuflda1++ZuJbBd
         u78iQOY5hfLte/47yqgMwbfalt+RAEPxTPcDRnDFsHxVvg8DCeXiEPV0q0hSrhxiDe9G
         vNUEz3mHwo5CVxBev+uNfwrfYuLIzJtgDmxIXXuDDzs0K+DjpMQLlOrl4lNTX1LuiE8l
         7A2sLiya3yalT7WROisR4SVQmPI5QTtdQ7gUCVyeMrHiq9aNLsl/FLxCrcph4dRX4hfo
         1MKjnzmpdfPbGPXDnG3FW0uhYm2nU/Ucc/Zsa8Dy9hufwDKyNR6vN1909msrDn6St6T/
         KPIg==
X-Gm-Message-State: AOUpUlE+VmvATz7j51bJBJhsmWdzcw8Siw0KS6SQ+tEOd4/kfy+Wwnyp
        iLmIyzrXzm09Kz7pIvpbGSA=
X-Google-Smtp-Source: AAOMgpevLSVff1sPZqRtdiFjVzL2s6HJ3lxjSTMJz4+E9K46YKrFCJo6KTgsBz9F5ExU9U2G3y3Xcw==
X-Received: by 2002:a1c:7a19:: with SMTP id v25-v6mr5308007wmc.81.1532277375781;
        Sun, 22 Jul 2018 09:36:15 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.37.46])
        by smtp.gmail.com with ESMTPSA id z8-v6sm15195653wrp.54.2018.07.22.09.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 09:36:14 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 0/5] Add Actions Semi S700 pinctrl support
Date:   Sun, 22 Jul 2018 18:35:56 +0200
Message-Id: <20180722163601.28346-1-sravanhome@gmail.com>
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

Saravanan Sekar (5):
  pinctrl: actions: define constructor generic to Actions Semi SoC's
  pinctrl: actions: define pad control configurtion to SoC specific
  dt-bindings: pinctrl: Add bindings for Actions Semi S700 SoC
  pinctrl: actions: Add Actions Semi S700 pinctrl driver
  arm64: dts: actions: Add pinctrl node for Actions Semi S700

 .../bindings/pinctrl/actions,s700-pinctrl.txt |  162 ++
 arch/arm64/boot/dts/actions/s700.dtsi         |    6 +
 drivers/pinctrl/actions/Kconfig               |    6 +
 drivers/pinctrl/actions/Makefile              |    1 +
 drivers/pinctrl/actions/pinctrl-owl.c         |   64 +-
 drivers/pinctrl/actions/pinctrl-owl.h         |  135 +-
 drivers/pinctrl/actions/pinctrl-s700.c        | 1925 +++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c        |  188 +-
 8 files changed, 2302 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
 create mode 100644 drivers/pinctrl/actions/pinctrl-s700.c

-- 
2.18.0

