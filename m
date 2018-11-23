Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACC5206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNpjfOh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACC5206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502295AbeKWSI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:08:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38756 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502267AbeKWSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:08:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so9834009lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 23:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=L5sls9eV3MWTLO0pnIWzsSHT/Kklob8gaO3ICjSAj34=;
        b=FNpjfOh7P83Mhcw1npvN6nzAAGah0ssBXN1e58MaE8sD5cHRdqNhx2GDXFuni82GAX
         ywedhwJsj2cqXzH/j61imTLxagdWBzh/YKsg44RHbZPuqka6tQ4sWZC7EYyZHKTQn8nb
         M6aH3ntODL6vYIWV1ZHxndtEr15Lo2uM69T50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L5sls9eV3MWTLO0pnIWzsSHT/Kklob8gaO3ICjSAj34=;
        b=G76dMXbjnC6BWmSv0FGyl1U0JBINplF+qx5x6FF06s+A2FA8ikHx8cDeDRfilplW8F
         wljbS999Gcti7mAc8oytE9yzKISPtWNX3pzxM096XoKdAK0myPG6hCRG3RIZMbCy8/pQ
         Ndb+uYWig2tdwQl1GWRqWXSUM2ocrWgV33ewTG0GvFZIVvEViRS+w8wf1DFAkHw0s5Aj
         Ft/542c92FORGGkPmA86iTC4yN1p8o7OVFPICUZFbPUjjkNlZCRmmY5rlPpOWD0zS61o
         7z7sC7w8QuF2oU1lwzkOy7uCcnLY2zjA4oeTeGHmf4qpAt3Q30y1O+a2IQqCwf1GSaDA
         j69g==
X-Gm-Message-State: AA+aEWZlNIF08aWNmlG4Hyp3fg5Y0SndQuVDqCqyb50OpbnTbifB09Ww
        ciPe40VI8AHGEjU70fmyq2vUmQ==
X-Google-Smtp-Source: AJdET5dDViqQYqtEotfvNstWA4U7qHgz8p8DABnL/6s7aW0inONhJ7njPOrWF6XATIf0bgdBHYtKcw==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr8854132ljd.168.1542957920898;
        Thu, 22 Nov 2018 23:25:20 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f8sm3919343lfe.72.2018.11.22.23.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 23:25:20 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.20-rc4
Date:   Fri, 23 Nov 2018 08:25:18 +0100
Message-Id: <20181123072518.2033-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with two MMC fixes intended for v4.20-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc2

for you to fetch changes up to 5305ec6a27b2dc7398a689e661a4a2e951026f09:

  mmc: sdhci-pci: Workaround GLK firmware failing to restore the tuning value (2018-11-19 14:11:07 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-pci: Fixup card detect lookup
 - sdhci-pci: Workaround GLK firmware bug for tuning

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Workaround GLK firmware failing to restore the tuning value

Rajat Jain (1):
      mmc: sdhci-pci: Try "cd" for card-detect lookup before using NULL

 drivers/mmc/host/sdhci-pci-core.c | 86 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)
