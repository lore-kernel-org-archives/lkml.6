Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55CAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7888620862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmTjX9I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7888620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbeHAOKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:10:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37880 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387692AbeHAOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:10:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so13170040lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QuIyxlWm+54Ln3/OJU1SpHsQmFYhtrJkRHxBzdgjRBs=;
        b=PmTjX9I8Cl09QpPEHO2b8OnFegMZXrcE93SLEgoog+GKWxxNAktTD9MpLOV/KiPWSV
         Jv5s+w5fkKNG+SOif8YaB89/H1KvQYtQsjSPJOnFLtgDPZoiyI+E9PChVM5u3lHrcIdH
         lzX/+0HSnhU/HexdbgdF7eNvq3hWaCENs1Bq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QuIyxlWm+54Ln3/OJU1SpHsQmFYhtrJkRHxBzdgjRBs=;
        b=GPOcFSIL2CgPmkoeu+ImLC47ENFTgzGzE1yyvaknVlPcs+fgYAr5LRKzfRnWFGEnD9
         iBHLvf4icXihxBmHxnSL/qnp2bkSWQY2HKOuMOAXPMiUSwqz3Hj30ePS79Hk8Z0BYyjI
         Bq0ouobZFIYCgAtYpMyVRkEUJQeZnpsuO83TKfa3ydIfrUIsCCCDsk/k2ABSSGmv+VA7
         9DK2GynbjvAR5prTe9lMIXVSzEiS3a587uOFgbvDyY105IG7shdJAlPlz5n5fPjcHdjJ
         R+YHvCEMv787JNq7irDsziYs+FYwZ/yN6e5hWB76knVirycP0rDvws9bpXAt0V58xP8e
         vx8A==
X-Gm-Message-State: AOUpUlFb2wdgwy3R8XEzJv06wB7S1GhKo1rtcgRJrrZHS1S59UMoMTh3
        A/CpFiDivKgHHQDuxvIx1IuLQg==
X-Google-Smtp-Source: AAOMgpdFobB+v1sy9pE/NmqZIrj43iwwDBST27lk4VL4Lz8iG9152aRWTf7GhyIVDH+rUWYoI9nfaA==
X-Received: by 2002:a19:4c57:: with SMTP id z84-v6mr15290894lfa.67.1533126291191;
        Wed, 01 Aug 2018 05:24:51 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3100799ljc.56.2018.08.01.05.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 05:24:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] MMC fixes for v4.18-rc8
Date:   Wed,  1 Aug 2018 14:24:49 +0200
Message-Id: <20180801122449.32105-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with one MMC fix intended for v4.18-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe:

  Linux 4.18-rc5 (2018-07-15 12:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.18-rc5

for you to fetch changes up to 3b1074bf9817bf43d4da375aa5f4b6c88f1d953e:

  mmc: mxcmmc: Fix missing parentheses and brace (2018-07-16 11:45:44 +0200)

----------------------------------------------------------------
MMC host:
 - mxcmmc: Fix build error for powerpc

----------------------------------------------------------------
Kees Cook (1):
      mmc: mxcmmc: Fix missing parentheses and brace

 drivers/mmc/host/mxcmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
