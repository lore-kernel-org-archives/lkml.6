Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48D4DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F177B208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELpEwE5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F177B208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbeFNLNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:13:07 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41594 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754938AbeFNLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:13:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so8784495lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i1c6hGIsFZHyiGX47e/WWCwQXd0tWR/Ucz6QYuepgAU=;
        b=ELpEwE5bBtaPqZCfQYT36lNmnXdQPz5WcT60emIBkdZ7LFOsb0GuIk73lNaGspWrV5
         V049xBrf0cHB+HtsiKB4dLsdrNFmHe5zM0/1QGrnkNMWXqDy0CUNOvSB1/yQRS/wb/Jv
         MJx/n2ecDg90bA5L9TB1uBr5kGlu+vzpQY8cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i1c6hGIsFZHyiGX47e/WWCwQXd0tWR/Ucz6QYuepgAU=;
        b=I91un81D3q6Fbx7HW684VYGzUuU+GGasrJkxQQBOAClTZKX08DMxHSbIaGioWwrZ/v
         MrPvmZzBdMwcW4zXNFBTIJ1TzSUrkNkqr1YN0ePOW3eY3OnSevBQGlu0hsDqW+7b/ojO
         ywGBpCf04pGcgVAqfXwqpVNK+wi7JskLnXA08pAcoILXpEFrQYtaJuVreVcIl3POU65W
         DdmHFKFbf3rcAMuuHs1DDCOYKLhAcPBaJV5nmi5ZX85Eo9zu3sHoXcBSBhm2HLpihF73
         pSpRGEl78N0OClvUO5BawnJMObU68jtIpx0jCMZ9AoDROWw+gB9hOSbCCs75TDzk+Jth
         VGnA==
X-Gm-Message-State: APt69E0WvyqhQS761uyd0C5eVZaFkes+koKXSL3VubEIasR0Me3rB2OE
        ZDzefTqrWEkBt/xqjBk3HRGlMg==
X-Google-Smtp-Source: ADUXVKJ5KHUsIPOf62CmFptir465xngzzW4WUbb54EhZiKYRt9cTBC5juNxe5SEiodvjew8EwEZvsw==
X-Received: by 2002:a19:3b0e:: with SMTP id i14-v6mr5681465lfa.48.1528974782564;
        Thu, 14 Jun 2018 04:13:02 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id o9-v6sm1041490lfk.2.2018.06.14.04.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 04:13:02 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] soc: qcom: Remove bogus depends on OF
Date:   Thu, 14 Jun 2018 13:11:37 +0200
Message-Id: <20180614111138.8923-7-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614111138.8923-1-niklas.cassel@linaro.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both QCOM_COMMAND_DB and QCOM_SMD_RPM build perfectly fine
without CONFIG_OF set. Remove these bogus depends of OF.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 1d4a9f3ada8c..3f4036a6173f 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -5,7 +5,7 @@ menu "Qualcomm SoC drivers"
 
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
-	depends on (ARCH_QCOM && OF) || COMPILE_TEST
+	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Command DB queries shared memory by key string for shared system
 	  resources. Platform drivers that require to set state of a shared
@@ -86,7 +86,7 @@ config QCOM_SMEM
 config QCOM_SMD_RPM
 	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
 	depends on ARCH_QCOM
-	depends on RPMSG && OF
+	depends on RPMSG
 	help
 	  If you say yes to this option, support will be included for the
 	  Resource Power Manager system found in the Qualcomm 8974 based
-- 
2.17.1

