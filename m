Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7BB50C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B44204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+jNw+BN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B44204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935586AbeFMMzG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:55:06 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37785 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935348AbeFMMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:55:03 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21-v6so3792732lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2KrdEOXycVhhumiKZo9P7nfQ2WES3KkhzqnWuWfYV/k=;
        b=K+jNw+BNbex/sRB8tRSfHtCeWwNDHmqIBNpvQ2sxqURxp+xMncZCDdXdw00ePozO3o
         E+SpphYaBCtLpTSY4NxQgIJVTLL19yO1YgD6ZI5AZQRXM7U5I4TPLFQUTPXDo7Atg7CV
         iyQSkc+wsDc1ybZoD3SVnInR/1+88fUsr77Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2KrdEOXycVhhumiKZo9P7nfQ2WES3KkhzqnWuWfYV/k=;
        b=C+Zn73auia6S4eZmM0P1/GtqdgsWTxX6nDM4dO05z3HAxaixGnsrnzILcsXAP4Ohjw
         /oE7IFvcZa4SZr2qa4B3xpFRcmLbeGzyi2EhOr9Pso7zUUV4020YBXhqL2P1MYAj04Jw
         AHYwBQWEMFCKmpPn7UCxbi+GqHWg3DOJZFzdF4ZVft2qALq2r8Mb69MR0u25LPoT1uCr
         4LqL411Fukv9HLRvJlP11LlCGki/pre11OkoCtgcWT8wQekHk0uy12NavzeTVHEudiY7
         CCx3HwNOGsiEsaHk/hRUsNZv1zPTSqKMdHPipk5vuzMgnlmnAtEjW4/rpBlPTRfa9TLh
         42uQ==
X-Gm-Message-State: APt69E3LO5U9Dv8zHUQMTVnoJOp3nGPzUJ54ZLbRIsIxePXx/uHaIKnA
        k3GkLPegOzkcgoS0B1lnRj2xBA==
X-Google-Smtp-Source: ADUXVKKG4L/CdQMLhGcKpoS91adevH8vHd0iiCu7DRsFGQnfM+WEwWIUV+uE0fvEDfSG0/dpHB7xYQ==
X-Received: by 2002:a2e:8590:: with SMTP id b16-v6mr2984342lji.131.1528894502423;
        Wed, 13 Jun 2018 05:55:02 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id o9-v6sm580840lfk.2.2018.06.13.05.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:55:01 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] soc: qcom: remove depends on ARCH_QCOM
Date:   Wed, 13 Jun 2018 14:53:55 +0200
Message-Id: <20180613125401.11734-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
we unconditionally include the soc/qcom/Makefile.

This opens up the possibility to compile test the code even when
building for other architectures.

This patch series prepares and enables all but two Kconfigs to be
compile tested even when building for other architectures.

Niklas Cassel (5):
  rpmsg: smd: Add missing include of sizes.h
  soc: qcom: smem: Add missing include of sizes.h
  soc: qcom: smp2p: Add select IRQ_DOMAIN
  soc: qcom: smsm: Add select IRQ_DOMAIN
  soc: qcom: Remove depends on ARCH_QCOM

 drivers/rpmsg/qcom_smd.c |  1 +
 drivers/soc/qcom/Kconfig | 12 ++++--------
 drivers/soc/qcom/smem.c  |  1 +
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.17.1

