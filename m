Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD53C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23410206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L6nmnmme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23410206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeIMUQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:16:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33281 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeIMUQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:16:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so4910237ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5/5FV0hit7uAnZ0nQWbKPt1/vEPngT8R67K/oP1DRsA=;
        b=L6nmnmmeKjdAwe1ujf3r981e/j7vDcjKguA3QCfplP9skkAQAretUDQL8DhOHPuSbQ
         kgsutEgdRbzqcCpx6EvT6XLHnqhv+QHeouVeN9Ieti24bhmI9eh8cphLwPc6Aa8eYjO7
         U8bF2CERS5457x0ZwSeiqB8Y9LV2/pecpjCYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5/5FV0hit7uAnZ0nQWbKPt1/vEPngT8R67K/oP1DRsA=;
        b=auOuzGSW8fayWHyMauPMjBfaB8D/UsCJsuUjoXEEfg5Lk6jEHhuM+heX5Mlrtc57ki
         LMtaO5zptKarte9wdz8Dqu//PAERqv5YWnA0b9+p/O2duB9Ljl6uFzdS7GU6bInsnp16
         geGWvsmw+QwUpobgYXS9KBKVyDof87RfOQB5EUujve+dEE/gxlHaDjIMsxSxNTxkULxD
         g+rdlnOr6Fh+waWh3CCDPmvsfdnWYrSwNawcmEF5a2ILldqc6eM0/KJ2TEttsLu3wmTY
         l7s3dTT7C10PyW6d2T0f3+wOoG32FCg6+D7ae4ZnyoKnMfcmh0mZzlVLn5BYsnE4Xfc4
         /eCw==
X-Gm-Message-State: APzg51ANh00GJ1xXZdMOXPbwGiSgWZUQ0wwtw2XqOLR9RoTT8SKVxj/u
        xr3m7OpUVciv1a6UmG7SB2dHS9XRQRM=
X-Google-Smtp-Source: ANB0VdbvLMiYV1XOwMwzyRrnBDkoDCSIPytroN7JdgrXE7pjD1OTQNNAIJbSqNq9YQtWTFcC4G7rPA==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr4763010ljc.148.1536851167496;
        Thu, 13 Sep 2018 08:06:07 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s23-v6sm736430ljs.38.2018.09.13.08.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 08:06:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.19-rc4
Date:   Thu, 13 Sep 2018 17:06:04 +0200
Message-Id: <20180913150604.3887-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.19-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-rc2

for you to fetch changes up to c483a5cc9d09f4ceaa9abb106f863cc89cb643d9:

  mmc: meson-mx-sdio: fix OF child-node lookup (2018-09-05 08:28:45 +0200)

----------------------------------------------------------------
MMC host:
 - meson-mx-sdio: Fix OF child-node lookup
 - omap_hsmmc: Fix wakeirq handling on removal

----------------------------------------------------------------
Andreas Kemnade (1):
      mmc: omap_hsmmc: fix wakeirq handling on removal

Johan Hovold (1):
      mmc: meson-mx-sdio: fix OF child-node lookup

 drivers/mmc/host/meson-mx-sdio.c | 8 ++++++--
 drivers/mmc/host/omap_hsmmc.c    | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)
