Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B022C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BB025E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="esJPzil5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BB025E8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeFZPaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:30:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33324 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeFZPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:30:41 -0400
Received: by mail-lf0-f68.google.com with SMTP id b7-v6so6863109lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aN6HZZHl2Cz1VEDT1VHZFwOAVPnA7t5zp2KaLIWq7Kw=;
        b=esJPzil5vZpMKd4EIumFXRihPOwpKN+dh3Q4SIUk8O21irdJwNGnuo/eBaVRAB8nxB
         YADGXTZllCv2TJIZ4o3HKs2o3LrhqrhUKzrzR8TlA2L6V3mMTghDpbrKFHyHG6+ILCve
         FPQ2lhjVwuzD/ZQ12BUV8IXaX8UUH/mxsUodk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aN6HZZHl2Cz1VEDT1VHZFwOAVPnA7t5zp2KaLIWq7Kw=;
        b=OhhqsBhoOscg/gSMTa85HvvsCRzWeVSvXnM7fSi6Z39yPbU005QU24NvJa64UUb5vN
         rP3UOfoaBttLEeOfJMz8MG75upFQvAeG/0nXoBLNQcoDSzFq2CY5AoOknxKbUgZi7EYY
         2YF0ySDnll6T2Q90Eyhb5oqE8CZoGapaBrFbym/mWlRnCaswbx0PPtgqGbuom0kQqSVa
         l5GgjnDA/DgTbjvE78XzSXgi2BZUl8uUw85VFn3In6t/3Kxg6O5Bo4QE9+bDXX0nKdqN
         1nFfb1BJlvn7V78eoB6i/W8APHNDvHikPCkYdgPQRVW9vJLgJQA7/dut4S8RWRjh/AmZ
         eDhw==
X-Gm-Message-State: APt69E3RqvxRpus8RuY1XmP3b8og1RSWVTAz2sHj10mxxcDbZ9cinyfv
        9BZfeLaOTIhcDDhS+0mtwPp9/P++EHQ=
X-Google-Smtp-Source: AAOMgpeoTt49GCJ/sUtKplVr+STJ3cEyi8Y74eGvyuvQTtjbXV6DB84NxgJJcpAZEaR3MIbC7DsOvA==
X-Received: by 2002:a19:6d11:: with SMTP id i17-v6mr1574017lfc.103.1530027040140;
        Tue, 26 Jun 2018 08:30:40 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id g17-v6sm306096ljg.27.2018.06.26.08.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 08:30:39 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] mips: configs: remove no longer needed config option
Date:   Tue, 26 Jun 2018 17:30:35 +0200
Message-Id: <20180626153035.361-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit eedf265aa003 ("devpts: Make each mount of devpts an
independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
in the defconfig anymore.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/mips/configs/ip27_defconfig    | 1 -
 arch/mips/configs/nlm_xlp_defconfig | 1 -
 arch/mips/configs/nlm_xlr_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 91a9c13e2c82..fbcbfc365c64 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -262,7 +262,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_ALI1535=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index e8e1dd8e0e99..aec323ed6968 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -403,7 +403,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index c4477a4d40c1..88c185da23ce 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -336,7 +336,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
-- 
2.18.0

