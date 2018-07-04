Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE131C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BED020841
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPuVagFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BED020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934055AbeGDLpK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933296AbeGDLpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:45:04 -0400
Received: from localhost.localdomain (unknown [122.167.70.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B7424376;
        Wed,  4 Jul 2018 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530704704;
        bh=l4VLYIZoXIjrkPdyhBPYhyd6MU44UigznT/mY87AzGA=;
        h=From:To:Cc:Subject:Date:From;
        b=LPuVagFt7YWr6T++suiu+gf4zWoIDbhh4UxEP7QJZMxEaYudHDZEp+okJlrVC1NMh
         mo0z+bsrfuIF4QaEjKlcNvHG1Ps54G7pwteII6ZxB5O0VtOFtzt+DyBbbGwbzEUUdw
         fNqWWDIk2i1GS31vHAg+REn0HnQnebzIDBnAzSyM=
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
Subject: [PATCH v4 0/6] crypto: Add Qcom PRNG support
Date:   Wed,  4 Jul 2018 17:14:21 +0530
Message-Id: <20180704114427.29953-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the hwrng qcom driver and replaces it with crypto qcom
driver and then adds support for Execution Environment (EE) found in v2
version of the hardware and ACPI support for these

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
 drivers/crypto/qcom-rng.c                          | 237 +++++++++++++++++++++
 7 files changed, 252 insertions(+), 198 deletions(-)
 rename Documentation/devicetree/bindings/{rng => crypto}/qcom,prng.txt (73%)
 delete mode 100644 drivers/char/hw_random/msm-rng.c
 create mode 100644 drivers/crypto/qcom-rng.c

-- 
2.14.4

