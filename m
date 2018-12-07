Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBA7C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2A120868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCZi6URz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2A120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLGJ4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:56:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53978 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLGJ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:56:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so3708293wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QOv09HwC0l9SeAA3LHJPh1tR0jzT/v43TpLg5dF+Ps0=;
        b=SCZi6URzZXBF7F3ciMQTdB8/AoYP9hd457iIch2xwAs6s5SUjq4+n0f7bVbURkBFIr
         nrdRgYQkNhouUOeMiGpTsSaoxJGbWRTZKIkbQhQcdFIEmSot75zEbtjHacKzLaR0LJLz
         aKUKnKsVPa/sIHmwsq8EmvFa0G9pEyeH9hvDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QOv09HwC0l9SeAA3LHJPh1tR0jzT/v43TpLg5dF+Ps0=;
        b=ukFSh1aqBVhxgV3ln6GvgHTNEaLuRSmdlbOQRWDLCMfXAMfY8ctRwEKxMPb8IS+w/U
         qtP1ZQIMGM6GwsAeklyEuQx+j/HDcC0T59AGCB2OwJND7Q0HQJsGu+NvCzZJTDCgquTV
         +P/wPO+5VShIZ+wQ0GhGUSGBrYwGLf605a4+0Qku7FLGKWdqSeRJsh+UXI11yK4bIKPX
         YndIYzkNgL0MSZvJh13cdeCocjbJcefnEoYUSIqk6rBgx7x5pSbex3JssXiWTii9mWHu
         vPu/5to5ZumQKDAP4TtKVUjai8WTTQRN7Xqqq5OAxRyIcTPTI7Anz3hKG2WPyTeNWvek
         WCZQ==
X-Gm-Message-State: AA+aEWaM36h9WcFA2JHyjm0S9FDSh6kItXT+rHInoExbcCjYXvy4pXqf
        SIHXme/IUOCOfPbF9DuNTYsRxQ==
X-Google-Smtp-Source: AFSGD/WfNk0r7l/7JfaQfeQuWlrVwvXMsgbz7xr2x+LUt3dzCOnWIGLZMmAQYLZhi6fTiNDlxxU8sg==
X-Received: by 2002:a1c:7eca:: with SMTP id z193mr1741447wmc.140.1544176572776;
        Fri, 07 Dec 2018 01:56:12 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h129sm3153776wma.0.2018.12.07.01.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 01:56:12 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
Subject: [PATCH 0/2] USB SS PHY for Qualcomm's QCS404
Date:   Fri,  7 Dec 2018 10:55:56 +0100
Message-Id: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set adds USB SS PHY support to Qualcomm's QCS404 SoC
The PHY is implemented using Synopsys SS PHY 1.0.0 IP

The code is based on Sriharsha Allenki's <sallenki@codeaurora.org>
original implementation.

Jorge Ramirez-Ortiz (1):
  dt-bindings: Add Qualcomm USB Super-Speed PHY bindings

Shawn Guo (1):
  phy: qualcomm: usb: Add Super-Speed PHY driver

 .../devicetree/bindings/usb/qcom,usb-ssphy.txt     |  78 +++++
 drivers/phy/qualcomm/Kconfig                       |  11 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c             | 340 +++++++++++++++++++++
 4 files changed, 430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.7.4

