Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB430C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7775B20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDUpzE1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfA2LfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:35:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33478 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfA2LfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:35:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so12744950wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NFHpMSLlTtGiK00UH+qqUo8z2oUdMcYvkTVCpigpA7I=;
        b=HDUpzE1NgNKjdsPmb5TS0IZiPnerLAb3UiWYUn1v3YguBkEvphCGQ+bBSdaC4kgg9z
         0/VTw53yaztyQpPjbYR92LL9yR2Z5Ah6jhMuQ+UGfIz9iOC3VlCP4XdASXZBURIFlfze
         TRr/dgzPiP6OQOIPe8cFfIz7P17p/VEGckJ7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NFHpMSLlTtGiK00UH+qqUo8z2oUdMcYvkTVCpigpA7I=;
        b=p/hl94XDxF+obHkV33ARRJtr2koQ8gHOQvKFHWuVeFHHM4zc+ZM9OsC03HOke99Osm
         aMN7tlEONrR1Gu/g/ACiIwsyj95chGGu6NcjzcFC95ZAYnNIBJAiLyXcSlWLDTE9KnE8
         CoA9tO1lPpe2/BzvPSn5NSG8T00EZHj6gQO/hI6oBpXw1lxMz4DZKGyBgavpkwMr7D5I
         SuQbX7ljjKJ3p3UizVjS+qDPf0QwknXVfstAJ/XCRvjP1mkrFdKqEgwfTNtQiNBy4oPb
         Z9ZxiG6CRARd59Nis5RTVKduEHdeCDllTuGJgBOxDFbI0++VBAzwwJu6PlifT+wxFudb
         XwyQ==
X-Gm-Message-State: AJcUukfz+bq7LVtKqklqKUH9KSC06SVZ/CMP6B+Y3GFIbn9gyYCNTNcT
        56qYDySwdgHc/md4JSS21ASutg==
X-Google-Smtp-Source: ALg8bN5QEnvmAi7Y1KyHyRmrB0L9BVh5IljLopTV18ZaYb4ehz4WJUqv5971II3qOUD/AJGytxFKCA==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr20272610wmc.21.1548761719213;
        Tue, 29 Jan 2019 03:35:19 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id i192sm1960129wmg.7.2019.01.29.03.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 03:35:18 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, kishon@ti.com, jackp@codeaurora.org,
        andy.gross@linaro.org, swboyd@chromium.org
Cc:     shawn.guo@linaro.org, vkoul@kernel.org, bjorn.andersson@linaro.org,
        khasim.mohammed@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] USB SS PHY for Qualcomm's QCS404
Date:   Tue, 29 Jan 2019 12:35:13 +0100
Message-Id: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set adds USB SS PHY support to Qualcomm's QCS404 SoC
The PHY is implemented using Synopsys SS PHY 1.0.0 IP

The code is losely based on Sriharsha Allenki's
<sallenki@codeaurora.org> original implementation.

v2:
  enable OTG mode detection
  move vdd voltage levels to driver
  use bulk_ control interfaces
  ss-phy-bindings [1]

[1] ss-phy-binding discussion:
 - qcom,dwc3-ss-usb-phy exist for a generic usb2/usb3 phy driver that
 was never merged. Rather than trying to re-use these bindings (or
 delete them) I  propose that we go ahead with the new separate
 bindings for HS and SS: if  not now - investigation  in progress- in
 the  future  it might be  possible to have again a common phy driver
 for  which these old  bindings would be the binding agreement. 
    
Jorge Ramirez-Ortiz (2):
  dt-bindings: Add Qualcomm USB Super-Speed PHY bindings
  phy: qualcomm: usb: Add Super-Speed PHY driver

 .../devicetree/bindings/usb/qcom,usb-ssphy.txt     |  73 +++++
 drivers/phy/qualcomm/Kconfig                       |  11 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c             | 347 +++++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.7.4

