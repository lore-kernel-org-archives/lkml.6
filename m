Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918C4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4075A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dEUVybXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4075A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbeJPXC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:02:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32981 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeJPXC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:02:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so11187406plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2qEtXmUxVTj0qrcV0MWJrLFly0loDRHJM4eipkUrHl0=;
        b=dEUVybXF5fCQ9DYFxmmDBaXmW9YfWgMK0b3WSdSk81igreKpGfutR3iCqZeVteNpNn
         tBKc6M2sFGq/88J8B1/fhQ6TxFuHt/5J2xkbl1sD9W1SFlgLwxUPUz+xqtLM6Rj+QSdg
         mio/F3RdnzkHxho9imZMEvgMqgL8bmOmyuQ+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2qEtXmUxVTj0qrcV0MWJrLFly0loDRHJM4eipkUrHl0=;
        b=teeV8ReTqiwcCt3xX5gvFvC9h/ZulS00HN4kbmFYzzQd8srz+SlajM8uM3l2zJUNhT
         6mXKajmB9F3Q71ugazR+WZgZkfhaUAaFj0TnPRFmwRGCh4xIgiCKO180I2Cu/5P6/VTw
         XEHp4y/JNo3SIhFXuX5Nk2jYC0lZfRx9WQQ+3GVIrxFLIXFMIPwC6jQ66/0H3N8O/5aX
         UczStrj+X2RtIlM249GnamtUH0Dp9t2xF+7voyIJJN+WKuybzxgvNn9+2WkurD0aqr/E
         4CLJM2ZMRT0l3mkYwuIn2sCGkLHxaSnePuYQlQnOucDx6i8kreVgihXrMmUdlBmekWY3
         cj1w==
X-Gm-Message-State: ABuFfojVLtR+8GWZ57RNMPLsjK4f5pDW7GywY9WBhrtAKWIay8TqD+1z
        WmSvx9jQWOb4l+4ZrOAftuqMZw==
X-Google-Smtp-Source: ACcGV62uE9dCL2RAuQzIveHpmNpwGr189oNhEMBsDjsNu89s9rS7p7V3sWb2DMFK71Udj/E9FoDC8g==
X-Received: by 2002:a17:902:b03:: with SMTP id 3-v6mr21868007plq.141.1539702692690;
        Tue, 16 Oct 2018 08:11:32 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i29-v6sm24227122pfj.82.2018.10.16.08.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 08:11:31 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 0/3] Stingray thermal driver support
Date:   Tue, 16 Oct 2018 20:41:17 +0530
Message-Id: <1539702680-3746-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds the stingray thermal driver and its
corresponding DT nodes with documentation.

Changes from v4
  - Addressed Rob Herring comments on DT parameters and
    thermal driver architecture.
  - Removed brcm,max-crit-temp DT parameter
  - Changed driver to thermal sensor registration model.
  - Added trip DT properties.

Changes from v3
  - Addressed Daniel lezcano comments.
  - Elaborated commit description of thermal driver patch.
  - Added brcm,max-crit-temp DT parameter.

Changes from v2:
  - All stingray TMON DT nodes are combine together into single.
    Temperature registers are combined into one mem resource.
    brcm,tmon-mask parameter has available TMONs mask value.
  - All available TMONs are initialized together in single
    instance of driver probe call.

Changes from v1:
  - Fixed auto build sparce warning.

Pramod Kumar (3):
  dt-bindings: thermal: Add binding document for SR thermal
  thermal: broadcom: Add Stingray thermal driver
  arm64: dts: stingray: Add Stingray Thermal DT support.

 .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/broadcom/Kconfig                   |   9 ++
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/sr-thermal.c              | 138 +++++++++++++++++++++
 6 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

-- 
2.7.4

