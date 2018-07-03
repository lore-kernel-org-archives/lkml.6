Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4788EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB2A22B3E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5AwKwav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB2A22B3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbeGCGFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753789AbeGCGFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:05:08 -0400
Received: from localhost.localdomain (unknown [171.61.87.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9125E2246B;
        Tue,  3 Jul 2018 06:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530597908;
        bh=0/zuTleqSsnjMnY+CDspVcE5HFctMHG1Cg/NpX5NucE=;
        h=From:To:Cc:Subject:Date:From;
        b=o5AwKwavi1MX/BiPN/rKDzu5/7FctJpfeTGapiDGGJU+j62MroW/VVNTSrMcFnSCI
         f1MN9bgRy8f4VFrfwmKmuIa7tCn2NH7DWN4Z49UqDpB3phch5FTWPbfVasyxV7XXfz
         Jz3ESMBQ/7cC4CBFg92bCqV0lToWwxPO4cM0lkWo=
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 0/6] crypto: Add Qcom PRNG support
Date:   Tue,  3 Jul 2018 11:34:28 +0530
Message-Id: <20180703060434.19293-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the hwrng qcom driver and replaces it with crypto qcom
driver and then adds support for Execution Environment (EE) found in v2
version of the hardware and ACPI support for these

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
 drivers/crypto/qcom-rng.c                          | 244 +++++++++++++++++++++
 7 files changed, 259 insertions(+), 198 deletions(-)
 rename Documentation/devicetree/bindings/{rng => crypto}/qcom,prng.txt (73%)
 delete mode 100644 drivers/char/hw_random/msm-rng.c
 create mode 100644 drivers/crypto/qcom-rng.c

-- 
2.14.4

