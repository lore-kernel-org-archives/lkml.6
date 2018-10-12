Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E26C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E792077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jc4w0Ir5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E792077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeJLSHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:07:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38764 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJLSHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:07:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id v7-v6so10950850ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 03:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pQyx0b+K8yL721nWL3juRtY3M3eLboXG1LSf+lBtyHE=;
        b=Jc4w0Ir57Ku8/KucHMVfNfNGgdRRISWk7V2XNlhanVqgM6TkMJ7pgRe1BVrqiZbAz9
         /VKRgiYsV6bXYX3YFcyKrJF/8yII/OAYE+YV8p6yeOikxK7BVcbPDsLp5CE4dnzoITQq
         ObWQlhuLA8WDF9xUT5kCmckODHqur4yf1Ivyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pQyx0b+K8yL721nWL3juRtY3M3eLboXG1LSf+lBtyHE=;
        b=CcgJqp8NF3eQ60zd727ZY+Ac6XTy8sXiErjk1H2Xvd2fDi0g6pwgVWXOOGv/RXA150
         SfXSQ2CYtoFoQVLxrU+ZKFPNSFO5/f8k5hU/bCuKWjmp7VIJpSXr/jAlY6rIfgc7mcbq
         iky6yrQUVZYwgUvgK/GuZXyRx/tzRTlEdcUULU5giPjxlD3ciBJxFcdvcJPbMYTM9MnA
         xSm1PFbrIXzrprgPheD1KrM0FOPUiuHCohpD4/X6aDIOcMl1LfwsJ/ypCzxo5Rp5buGu
         NpCxnTBclo1KqRXdoiKcdTu4IAGO4TGIGrnc/r9XAA9YLzfSZThPt9ov3MTOkKd3mora
         Mnng==
X-Gm-Message-State: ABuFfog1bomiIyVre3+BMbWV3c8rNfj6QKMdVmEagmFfz900n9UmnVzl
        NyVJk/w1y3SBGuudr7Ejdg+guA==
X-Google-Smtp-Source: ACcGV62VtPpkLlcGoe5Qes8rtHkviJJ0/ABq4Ul+n9na+o+VjpcKuykBR24gqRGf5dUgTfQucRLHWQ==
X-Received: by 2002:a2e:58e:: with SMTP id 136-v6mr1312926ljf.130.1539340532239;
        Fri, 12 Oct 2018 03:35:32 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id h27-v6sm178110lfl.31.2018.10.12.03.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 03:35:31 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus <torvalds@linux-foundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.19-rc8
Date:   Fri, 12 Oct 2018 12:35:29 +0200
Message-Id: <20181012103529.4688-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a PR with two MMC/WIFI/SDIO fixes intended for v4.19-rc8. Details about
the highlights are found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-rc7

for you to fetch changes up to 4f666675cdff0b986195413215eb062b7da6586f:

  libertas: call into generic suspend code before turning off power (2018-10-10 14:01:50 +0200)

----------------------------------------------------------------
MMC core:
 - Avoid fragile multiblock reads for the last sector in SPI mode

WIFI/SDIO:
 - libertas: Fixup suspend sequence for the SDIO card

----------------------------------------------------------------
Chris Boot (1):
      mmc: block: avoid multiblock reads for the last sector in SPI mode

Daniel Mack (1):
      libertas: call into generic suspend code before turning off power

 drivers/mmc/core/block.c                        | 10 ++++++++++
 drivers/net/wireless/marvell/libertas/if_sdio.c |  4 ++++
 2 files changed, 14 insertions(+)
