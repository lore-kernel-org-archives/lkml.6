Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B24C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADC5208E5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKm/a8Of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADC5208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbeGIGUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeGIGUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:20:04 -0400
Received: from localhost.localdomain (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FC74208AF;
        Mon,  9 Jul 2018 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531117203;
        bh=dq/aBqrRZK0ztleYdXJD/4A7IoGqTeVpT7o6G/ns3PQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gKm/a8OfMEnhbdvElXVGtlU6U9PFdhfdxSjzvGZ+pZaTzko8+fjvD9oNwfiYTImSE
         kITFCo+dHjIjjxDUmdXgr8wb4jRZJzlVvI3QHVnPLcYQCYc5E+TjDNjWe13ObQPgGf
         TTBR00/vg94P6qsb/49h5CFEkVGLVyvpI2g/AsdA=
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 0/6] crypto: Add Qcom PRNG support
Date:   Mon,  9 Jul 2018 11:49:19 +0530
Message-Id: <20180709061925.20276-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the hwrng qcom driver and replaces it with crypto qcom
driver and then adds support for Execution Environment (EE) found in v2
version of the hardware and ACPI support for these

Changes in v5:
 - Update ACPI check and use generic driver data API

Changes in v4:
 - Use memcpy for data copy
 - Fix trailing bytes copy
 - Fix ACPI ID table name

Timur Tabi (1):
  crypto: qcom: Add ACPI support

Vinod Koul (5):
  hwrng: remove msm hw_random driver
  dt-bindings: crypto: Move prng binding to crypto
  crypto: Add Qcom prng driver
  dt-bindings: crypto: Add new compatible qcom,prng-ee
  crypto: qcom: Add support for prng-ee

 .../bindings/{rng => crypto}/qcom,prng.txt         |   4 +-
 drivers/char/hw_random/Kconfig                     |  13 --
 drivers/char/hw_random/Makefile                    |   1 -
 drivers/char/hw_random/msm-rng.c                   | 183 ----------------
 drivers/crypto/Kconfig                             |  11 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/qcom-rng.c                          | 229 +++++++++++++++++++++
 7 files changed, 244 insertions(+), 198 deletions(-)
 rename Documentation/devicetree/bindings/{rng => crypto}/qcom,prng.txt (73%)
 delete mode 100644 drivers/char/hw_random/msm-rng.c
 create mode 100644 drivers/crypto/qcom-rng.c

-- 
2.14.4

