Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7774C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42FA21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn9CL5fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBGLRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:17:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35300 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfBGLRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:17:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id z18so10345449wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSwUXwstcS5MWZYT0KETNDOkJuSS6swPSFLDu7aeu/g=;
        b=kn9CL5fJEF03kKdsiiWjtrbYh/EQ3PwowcBDMnq3ARppJstAw47yqeGmHewMvE8oX0
         C4lKQg1MD+ydEH0Yl8brbE+V1rh/x6V6bkXTdisNeTcJXiqoafu2G+82hBsRJxh78MJh
         lb7WNfuGngQ8cDeanvnkx9c0P9yMB9hftMEzYUiAEfad0CdV18pseFQDaQTHkSu8GhPY
         BGeTGPdAADmjU5rOaT6eS7hcNUahGU+IiWl6l9VTIRkV6/wTj0pFM8/YRGkQo0zmXfUE
         PEKn56ILQoJIT2tsM73XRqD4BqvneIltz0zfNxkQG7o818TJoUFqMYQRpAEQcrGUpTW1
         DCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSwUXwstcS5MWZYT0KETNDOkJuSS6swPSFLDu7aeu/g=;
        b=X4Ra8LvrHDmD66uTfVXxzZLBs7druyrIEU1DvGcg8GEURrEUlbiSShmqRZ5KsWx6GE
         4WTGthFAYkRpsgUJqH/i9IKV8YMHjH6PklOQRv8fV+ukCyAkPPioRncgNmR275YxjcSN
         lr+0rP3QFUOkcC73zN4iieFsANsA7uNDp5vT4b3oFfi+WU0IOcZHFFZastXNjn2VCHQb
         ZmweJVm/XDq05/jKaY24KtFJeHAeM5a87JynI+46NqRg/EjqZytAl6qss64bkPacP3Lq
         aDJ5WawLPIonY8z0cpuOJeJA6SxKzTBIzfAMPPtxZL9ECU58X+euynfPm+49KJJwMiSr
         qvoQ==
X-Gm-Message-State: AHQUAuZAUHOaS0MKlJZHXi6/FpzsHUVF1vWGknyqE3SpEDvKrTBv0bJ5
        6LNC9VJv7XBXw9AjZ7XQeeBn+A==
X-Google-Smtp-Source: AHgI3IbvcffGVQufgjI0mYmCMR2I7H2v4pzY3Qvf07ELBqRF/OvgNF4BNaNWWaXs/g858dlWMppdsQ==
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr3720855wrv.110.1549538259754;
        Thu, 07 Feb 2019 03:17:39 -0800 (PST)
Received: from localhost.localdomain (42.red-95-121-90.dynamicip.rima-tde.net. [95.121.90.42])
        by smtp.gmail.com with ESMTPSA id a62sm24490224wmf.47.2019.02.07.03.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 03:17:39 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh@kernel.org,
        bjorn.andersson@linaro.org
Cc:     swboyd@chromium.org, andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        jackp@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        khasim.mohammed@linaro.org
Subject: [PATCH v4 0/4] USB SS PHY for Qualcomm's QCS404
Date:   Thu,  7 Feb 2019 12:17:30 +0100
Message-Id: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
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

v4:
 dts:
   make compatible tag more specific to the driver
   define a connector node to contain the vbus regulator
   fix the resets definition
   fix example node
   remove unused binding (qcom-dwc3-usb-phy)
   connector: add optional property vbus-supply
 driver:
   vbus regulator is no longer optional
   
[1] ss-phy-binding discussion:
 - qcom,dwc3-ss-usb-phy exist for a generic usb2/usb3 phy driver that
 was never merged. Rather than trying to re-use these bindings I chose
 to delete them for simplicity
 

Jorge Ramirez-Ortiz (4):
  dt-bindings: phy: remove qcom-dwc3-usb-phy
  dt-bindings: connector: Add vbus-supply property
  dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
  phy: qualcomm: usb: Add SuperSpeed PHY driver

 .../bindings/connector/usb-connector.txt      |   4 +
 .../bindings/phy/qcom,snps-usb-ssphy.txt      |  79 +++++
 .../bindings/phy/qcom-dwc3-usb-phy.txt        |  37 --
 drivers/phy/qualcomm/Kconfig                  |  11 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c        | 322 ++++++++++++++++++
 6 files changed, 417 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.20.1

