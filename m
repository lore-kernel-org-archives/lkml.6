Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 634D2C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1742D2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5GH3OBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1742D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934413AbeFKSYt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:24:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33567 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934271AbeFKSYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:24:47 -0400
Received: by mail-pl0-f65.google.com with SMTP id n10-v6so12794077plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YOFD4BYZX+1dNUvzeYwNm7x0DrBCGnfGMXi/Sk3muVQ=;
        b=G5GH3OBo6wngdJH8oKGh5SLVebdjqBk8B48RUrJ1OBkRiju66SuI/x5QFnkncfMlIl
         SFwC3ajUSHl0+bmRZLQIfXr2tNgBsO/10v03W3nk0k4B7T3Wi5Fun/nQ1AcGwqDJmsBP
         adLnUiBFgXZW7zAmJzhmr23q3KHDbMK1fwERs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YOFD4BYZX+1dNUvzeYwNm7x0DrBCGnfGMXi/Sk3muVQ=;
        b=oZ8FGdb69UK/rLAzLfYT021++6IOPaFn9ehfOXCzZRnZcHeMWHvi+/cnuvLgRvzCTd
         p9I9lf2CkptLXCJcIqWP8IhLyEZCJdbyt0IdLvAHL+0cVMHF6MUCejFXfA50FiF3pMEF
         IXRkBhVWOh16gtJxyI8rElvcaKuCdWNiV5XroWuNZrRUd5kHau/V/eMr4RuBiqkbM/3Y
         irwen3Xm2UekXbBoCU2Up+V32yS13IAFEKr3GhYPIWqCClIBDMeCU2NqOd6UlxMfmuUF
         xMtf8967dB9qemounxHyBedDHIHt90nHZws2SE2AfRXBvUM8S7/vMOJGECsPFy7KiHEm
         eunA==
X-Gm-Message-State: APt69E3PxUeLLXCF+iNUlxlQcRl2YSiFEIm6LSvwl0Ym+z17+Dhk32QE
        ITTslhoJfrD1bB7sOoym0t5JoQ==
X-Google-Smtp-Source: ADUXVKITJg/24wF4heNvUVAVUp1yCxyosrsfotCWEsKZb7J6a+SdBtd0ubo55IEvEj4mtCpLerf3Hw==
X-Received: by 2002:a17:902:925:: with SMTP id 34-v6mr310685plm.218.1528741486986;
        Mon, 11 Jun 2018 11:24:46 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k10-v6sm60057293pfj.29.2018.06.11.11.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:24:46 -0700 (PDT)
Date:   Mon, 11 Jun 2018 11:24:44 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [GIT PULL] rpmsg updates for v4.18
Message-ID: <20180611182444.GE3206@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 75bc37fefc4471e718ba8e651aa74673d4e0a9eb:

  Linux 4.17-rc4 (2018-05-06 16:57:38 -1000)

are available in the Git repository at:

  git://github.com/andersson/remoteproc tags/rpmsg-v4.18

for you to fetch changes up to 4a2e84c6ed85434ce7843e4844b4d3263f7e233b:

  rpmsg: smd: do not use mananged resources for endpoints and channels (2018-06-04 12:35:03 -0700)

----------------------------------------------------------------
rpmsg updates for v4.18

This migrates rpmsg to use SPDX license headers and fixes a
use-after-free in SMD.

----------------------------------------------------------------
Anup Patel (1):
      rpmsg: Add driver_override device attribute for rpmsg_device

Bjorn Andersson (2):
      rpmsg: qcom_smd: Access APCS through mailbox framework
      Merge tag 'v4.17-rc4' into rpmsg-next

Srinivas Kandagatla (1):
      rpmsg: smd: do not use mananged resources for endpoints and channels

Suman Anna (5):
      rpmsg: Switch to SPDX license identifier
      rpmsg: virtio_rpmsg_bus: Switch to SPDX license identifier
      rpmsg: smd: Switch to SPDX license identifier
      rpmsg: glink: Switch to SPDX license identifier
      rpmsg: char: Switch to SPDX license identifier

 Documentation/ABI/testing/sysfs-bus-rpmsg          | 20 +++++
 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |  8 +-
 drivers/rpmsg/Kconfig                              |  3 +
 drivers/rpmsg/qcom_glink_native.c                  | 10 +--
 drivers/rpmsg/qcom_glink_native.h                  | 10 +--
 drivers/rpmsg/qcom_glink_rpm.c                     | 10 +--
 drivers/rpmsg/qcom_glink_smem.c                    | 10 +--
 drivers/rpmsg/qcom_smd.c                           | 96 +++++++++++++---------
 drivers/rpmsg/rpmsg_char.c                         | 10 +--
 drivers/rpmsg/rpmsg_core.c                         | 49 +++++++++--
 drivers/rpmsg/rpmsg_internal.h                     | 10 +--
 drivers/rpmsg/virtio_rpmsg_bus.c                   | 10 +--
 include/linux/rpmsg.h                              | 27 +-----
 include/linux/rpmsg/qcom_glink.h                   |  2 +
 include/uapi/linux/rpmsg.h                         |  9 --
 15 files changed, 139 insertions(+), 145 deletions(-)
