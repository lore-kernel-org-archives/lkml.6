Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D6FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E0220870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTYim38q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E0220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbeGaVaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:30:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51687 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbeGaVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:30:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so4383048wma.1;
        Tue, 31 Jul 2018 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bWdqMld/i5K3K1vegGZzaqGIvZRP5WuoGPzyJw7Lts8=;
        b=TTYim38qzTTwCIvWtqThg8V1srfHQbJKoPA25FM6zCgIUwaVStbZX9DOGn5OEoq7Cx
         28q4W/FSs0nZBn8/OD7iapBZSwWWdF/Wl9PZXGb+p/R4rP4z8aEDFSNO0fG8J1uaTJR7
         oG0RjJduQ3NIp7RmLXzfz2gaykQXj2pB+vSu3yi/43gto3CLM3E5gj7LJZEBwSO3VYw0
         QHfabBQJqViwRTNmDx/G89fgzqXi28v4hb67AFJSEwCuoI8B3HGXyRaEBViwmNVMl2yS
         s1MhSGQXP0hS800FcuX7B0hxsjZtKBV9sMuESIRgIi0JOsfEpTiKlbrLo1fQ2XxVjy1I
         VPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bWdqMld/i5K3K1vegGZzaqGIvZRP5WuoGPzyJw7Lts8=;
        b=eLAYqrx1bv3cK84rLSc87FLR4J4NiHs7Eixl6RKZEu/uQ14MaV6uTXMt8SjzAki+Nn
         pKot/XfLAAp+1ZSHXXCIwfL6zdZJfHdmst3TJTl7F7FDB7G0xZsRdofHt9AiP0qDsihZ
         24m3wFPUn4dFhnWQjF5YqKGbV149Ex+z64AQ+E9CRR9PdSE+ODqCRWJapkpgkhXyJMm/
         V0YXS8d3jg/xUPN+Nr8pn2pQi2r3nln6H69uyMCPDfuvXmt6BW+btb9lj/UFhFTNan8v
         9N/4gmaJOPrdTekIJrOYMvRs+XmtbhMdK4b0BCGpT3lIPLrGdsphDFpgDMPXSL6kB/Ug
         mqRg==
X-Gm-Message-State: AOUpUlGd8XUfYthQGXtYjqRC6MZFoa5uDm2SH7O9FcH4/k2TbZzqAAII
        nEqwgXxw72puDCuGfKZDwpM=
X-Google-Smtp-Source: AAOMgpdO26pSJGKA046fpCJDm9a1zuTGpxR7z1J1I1JtPHsVwTv7NQLBfRTJgrwkQht5/amvRSvk1Q==
X-Received: by 2002:a1c:148f:: with SMTP id 137-v6mr650096wmu.61.1533066501808;
        Tue, 31 Jul 2018 12:48:21 -0700 (PDT)
Received: from localhost.localdomain (p5B3F73FD.dip0.t-ipconnect.de. [91.63.115.253])
        by smtp.gmail.com with ESMTPSA id z1-v6sm2444829wmf.5.2018.07.31.12.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 12:48:20 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 0/5] Add Actions Semi S700 pinctrl support 
Date:   Tue, 31 Jul 2018 21:47:38 +0200
Message-Id: <20180731194743.13678-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <0180729200038.11795-1-sravanhome@gmail.com>
References: <0180729200038.11795-1-sravanhome@gmail.com>
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

