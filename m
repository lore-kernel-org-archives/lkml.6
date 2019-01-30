Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82077C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8Vvc3JX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfA3Sum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:50:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32817 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfA3Sul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:50:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id p7so675387wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpbNrACNP/GKX+WIXeaKSjWt/fW5blabksjd3PN5CXQ=;
        b=I8Vvc3JXEHAVndQQIv6NCfHM0FgWDmjbGfKo0mmcicM3yIc/5Mis5KyrYislXKaRxh
         XtKN3F6ZKekxbC2G5bOFps0byNiKLemvdPF3yE0BWrBzGfno63c+QQwm0kxTvL/BIN64
         /7K6Jmm4XpiQvTpKd4MhEZ6ietMxdLHXv1IMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpbNrACNP/GKX+WIXeaKSjWt/fW5blabksjd3PN5CXQ=;
        b=WOUhJME7pc6DpqWnkonAvD32PfrGI95ZkNCn8BOSE5BcI2gI+UgQC/gxTC7dwv0hBH
         NW4xLopo+cnXakAsC6cgpVUyzbpBpqNWRyg/39YMhzLjKHciZ/mVjhGD9YQ67Iyzj/OM
         JEUH3/fNFh8f81mpHj0wq0A/A683uaibl1Zg79ii2+VVaa5vVa7fJGuUlQ1G8CXP8bC2
         i3KEmeB1YV45torj3K1qogXt2doH0qKCVWTepHchMj+ay8mCCXQvZd77hTLpoEBG8Ae8
         d/UwFOib/wg49aKEl9oI4o+Tlna7xyRCNM/kjc8Od7Z+P9Zd/NaIta+OOKr6xlD1xMcK
         AA6A==
X-Gm-Message-State: AJcUukfdZm2BQj7H3BHZOO3/tWWH76a3ZoahKjBMOd+CwQBzP7scdI+U
        uhht9hE+k9lUJW9OZpMSM0xzSQ==
X-Google-Smtp-Source: ALg8bN6bQZzv9WvL3Ik6oLTw5cHU/QqswgLIiqwZtDXfYEoC8t3WQ8Bz5lUpBofiFsCN4uG08JxP8w==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr31614979wrc.168.1548874239682;
        Wed, 30 Jan 2019 10:50:39 -0800 (PST)
Received: from localhost.localdomain (99.red-79-146-83.dynamicip.rima-tde.net. [79.146.83.99])
        by smtp.gmail.com with ESMTPSA id a17sm2802575wrs.58.2019.01.30.10.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 10:50:38 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org
Cc:     shawn.guo@linaro.org, vkoul@kernel.org, khasim.mohammed@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] USB SS PHY for Qualcomm's QCS404
Date:   Wed, 30 Jan 2019 19:50:29 +0100
Message-Id: <20190130185031.24798-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set adds USB SS PHY support to Qualcomm's QCS404 SoC
The PHY is implemented using Synopsys' SS PHY IP

The code is losely based on Sriharsha Allenki's
<sallenki@codeaurora.org> original implementation.

v2:
  enable OTG mode detection
  move vdd voltage levels to driver
  use bulk_ control interfaces
  ss-phy-bindings [1]

v3:
  remove clk/regulator counters
  vdd constrains in device tree
  update error labels
  fix get_optional vbus
  allocate arrays statically
  fix typos in bindings

[1] ss-phy-binding discussion:
 - qcom,dwc3-ss-usb-phy exist for a generic usb2/usb3 phy driver that
 was never merged. Rather than trying to re-use these bindings (or
 delete them) I  propose that we go ahead with the new separate
 bindings for HS and SS: if  not now - investigation  in progress- in
 the  future  it might be  possible to have again a common phy driver
 for  which these old  bindings would be the binding agreement. 


Jorge Ramirez-Ortiz (2):
  dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
  phy: qualcomm: usb: Add SuperSpeed PHY driver

 .../bindings/usb/qcom,usb-ssphy.txt           |  74 ++++
 drivers/phy/qualcomm/Kconfig                  |  11 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c        | 328 ++++++++++++++++++
 4 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.20.1

