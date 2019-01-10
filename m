Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A252C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB32B21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aW1GrMh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfAJKOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:14:12 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33260 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfAJKOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:14:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so7911171lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 02:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkLvSLTq8CAdy+x2w96r72tpSm8LzzG31Jv3blujkXE=;
        b=aW1GrMh4Xda5D597gqJV8VHOYRLGFbRmtkJJCgfIobJNM8kvw9DM727nCYy4uY5cd0
         Z8SPZ1friS3j69o1sK7gaH4JnoPJjo/Gf/Hh1aK2VWv48nXaYSyy8w6Hvj3qkuJev7Gt
         +H7o6Eim/Wp5mswmBELvu65oxjS73x1UZn568=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkLvSLTq8CAdy+x2w96r72tpSm8LzzG31Jv3blujkXE=;
        b=cnrGivq0EcuFTFPOFaI1vTmVW/hxYu9LEBRiiryWNskYUkolk9OTxj/T30DLMt/qnt
         4ckOAUBtDnV2E+7psVDwdjWZzKFvi+h4OWQQwI7WtkyuU3eKcNYzyWI0ZVv+fFX7c3zT
         OEX92ZKFf7RrnxQUtN2TaNXFx3EAQA57lm9ZciJnPdK1bL4olf6w0BpLhoJA3QNZ1XgG
         zLDlUXv4jKBsLs4MVWtXmriPlCjNxUG0bMcrF1xtxrO8GyeCIX2vySXeoiH2Ls9If7Qd
         NdSpz80zk8VU458hNwHMKDd7ukIVoaNyzYzlVr32/nWSoA7loAazd4veDDP1siTGMJ+e
         mfYA==
X-Gm-Message-State: AJcUukfuNvJXee5TmVWJj/QEjsC5CpoxieiI2Q+X1SNM3u/LOwhdoVgD
        AdqRzkqdA1qufYkZGca/Wss4+w==
X-Google-Smtp-Source: ALg8bN6Ehyc2kl+1VMUwedxHVL3rMXzgaasA1nJYveFzGiSd/+VNc16a4mFAvwoXI8bcbpuX7IffPw==
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr5270656lfc.27.1547115250118;
        Thu, 10 Jan 2019 02:14:10 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id k14sm14120820lfc.70.2019.01.10.02.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 02:14:09 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] spi: dw: fix warning unused variable 'ret'
Date:   Thu, 10 Jan 2019 11:14:07 +0100
Message-Id: <20190110101407.7583-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SPI_DESIGNWARE are enabled we see the unused variable
warning in dw_spi_setup.

../drivers/spi/spi-dw.c: In function ‘dw_spi_setup’:
../drivers/spi/spi-dw.c:400:6: warning: unused variable ‘ret’ [-Wunused-variable]
  int ret;
      ^~~

Remove the unused varable.

Fixes: 9400c41e77b8 ("spi: dw: Convert to use CS GPIO descriptors")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/spi/spi-dw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f54b498001a9..7092e58add2c 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -397,7 +397,6 @@ static int dw_spi_setup(struct spi_device *spi)
 {
 	struct dw_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
-	int ret;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
-- 
2.19.2

