Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A6BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F36B217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BHhxaS6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeLZHxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 02:53:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39777 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLZHxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 02:53:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so7271089pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6KcVI3cNP/m+Pzq7VPTxDfr/tNVCCBYar/ZL8sY5nY=;
        b=BHhxaS6ToMPmSSUplC5HwpdloMho11QilVm013+jJP2dh7iJGFRyDfG/L++5HApmdK
         AOueomkkX2Vrgjbst6+biH3dVyWE1HcL0bJeR0ac4YKqnswidbLFOOIohXy8vK/Sq3f5
         IElNA8RK87/SKz8wCiB6xCuVyfJtKQOHFUVSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6KcVI3cNP/m+Pzq7VPTxDfr/tNVCCBYar/ZL8sY5nY=;
        b=CREHvkI9RJArW4+ywP8k811PbY/1eYtT1B8jgrczCnYgnxQNeBxOTZk1VvXIUXVxlu
         pQy9t29Oggvqw4wxt+zG0fR5NE0r3lJ2VRBHS9bj4/m24HK3U6y6FMx3/6HFA+qMdOg6
         QlFs7YRMahQraKz9jqc71YMNHYEOvlkpLTXrK0CEEiA+wVRrWDxgoBhnPkYhcPSWCeb4
         X8lWBptBS+2EhbxAqfDoLvweMRp76lCnHplpqmuFNKGTOuQgf7SEthlm46PdcKEyREQF
         BWy5xMUveqYj7+PDdS39RkwT0PHj6zTf27gPHlz8Q/49lHclJ9mgzJwlFk2uUdDqa8PZ
         qCsg==
X-Gm-Message-State: AJcUukcZg6re+Ga0NOkWuKFS3AMrxsHuXfkufD9WQewvKNuWSqLMVYFG
        6xbUTsluG0K+QxmX2qyR4IYKRA==
X-Google-Smtp-Source: ALg8bN54QEPfkuxduBY8t3+Ak8DMbpajQxNGG951kjbvOLaqYyatrf2rpWAr5huxlCP+e4gCbZKlig==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr18770971plq.84.1545810830966;
        Tue, 25 Dec 2018 23:53:50 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 84sm107392395pfa.115.2018.12.25.23.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 23:53:50 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Eddie Huang <eddie.huang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM)
Subject: [RFC,0/5] Add support for mt8183 SCP.
Date:   Wed, 26 Dec 2018 15:53:08 +0800
Message-Id: <20181226075330.82462-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for controlling and communicating with mt8183's system
control processor (SCP), using the remoteproc & rpmsg framework.
And also add a cros_ec driver for CrOS EC host command over rpmsg.

The overall structure of the series is:
* remoteproc/mtk_scp.c: Control the start / stop of SCP (Patch 2).
* remoteproc/mtk_scp_ipi.c: Communicates to SCP using inter-processor
  interrupt (IPI) and shared memory (Patch 2, 3).
* rpmsg/mtk_rpmsg.c: Wrapper to wrap the IPI communication into a rpmsg
  device. Supports name service for SCP firmware to
  announce channels (Patch 4).
* platform/chrome/cros_ec_rpmsg.c: Communicates with the SCP over the
  rpmsg framework (like what platform/chrome/cros_ec_{i2c,spi}.c does)
  (Patch 5).

Since I'm not familiar with the remoteproc / rpmsg framework, and there
are not much other custom rpmsg driver for reference, would like some
review / comments on the overall structure of the driver.


Erin Lo (2):
  dt-bindings: Add a binding for Mediatek SCP
  remoteproc/mediatek: add SCP support for mt8183

Pi-Hsun Shih (3):
  remoteproc: move IPI interface into separate file.
  rpmsg: add rpmsg support for mt8183 SCP.
  mfd: cros_ec: add EC host command support using rpmsg.

 .../bindings/remoteproc/mtk,scp.txt           |  10 +
 drivers/mfd/cros_ec_dev.c                     |  10 +
 drivers/platform/chrome/Kconfig               |   8 +
 drivers/platform/chrome/Makefile              |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c       | 164 +++++++
 drivers/remoteproc/Kconfig                    |   9 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/mtk_common.h               |  76 +++
 drivers/remoteproc/mtk_scp.c                  | 441 ++++++++++++++++++
 drivers/remoteproc/mtk_scp_ipi.c              | 109 +++++
 drivers/rpmsg/Kconfig                         |   5 +
 drivers/rpmsg/Makefile                        |   1 +
 drivers/rpmsg/mtk_rpmsg.c                     | 341 ++++++++++++++
 include/linux/mfd/cros_ec.h                   |   1 +
 include/linux/mfd/cros_ec_commands.h          |   2 +
 include/linux/platform_data/mtk_scp.h         | 143 ++++++
 include/linux/rpmsg/mtk_rpmsg.h               |  34 ++
 17 files changed, 1356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c
 create mode 100644 drivers/rpmsg/mtk_rpmsg.c
 create mode 100644 include/linux/platform_data/mtk_scp.h
 create mode 100644 include/linux/rpmsg/mtk_rpmsg.h

-- 
2.20.1.415.g653613c723-goog

