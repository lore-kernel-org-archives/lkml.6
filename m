Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286C421872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="elnUwm/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfBAJ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:59:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44269 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfBAJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:59:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so5231285lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C7wx2ZdZPNzYn4RfMP0oGSUl0ii6r/uy4pj+pVa7tEk=;
        b=elnUwm/wevjmDGYH9Spro0S3HPXDkExbJJCysdbO2PDs0+qVJGx6NhLl3TT+NYxWaC
         KsN2701VdGomrjA6+uYbzyVf0IOQiPWgY4wHNISjp1lTdSXntQY444WgY4c7stP1Ast8
         gh4iWYfW4s8fuh2ilK+fi5Yzyk/uF3iAJz6P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C7wx2ZdZPNzYn4RfMP0oGSUl0ii6r/uy4pj+pVa7tEk=;
        b=ILWD3q9D8q8aMHMZ3eSYij5vTLIM2Tq/4+UuijvSsl22D+/u/MDG+NgbRjcyEqw8hf
         RbYCcM0Z4Xg0zIxA1c0r6mK5tw9GyCxr8EC0UdCFC38d2ROA0TiDzF33Y/ze9Daje3Gr
         Gi6CRjKGbfDfkgGpj+7IJnlsEdjttYnyd/sohI9z0UTHdzlo34q5aObuozS3zQnUBxmg
         lxJHnFMHj0LkborBACoRoyAi3WulEJZi3suuxKq++jm8u/p8rOjQtxsdaIocshfuVhpF
         51+TrINwre+sy0BADNCdcgqTLVwHkBHqpOMEFqiIt6hETt9w57nLajFHQ3EVA1c/Syop
         CMQg==
X-Gm-Message-State: AJcUukdud0D356wmWMb/OVhki1K2xB5Vv7q5tw4hgOtcpC4z/2p+xC+l
        9eIB5SAclNGXhBGh4rSLEeyadQ==
X-Google-Smtp-Source: ALg8bN43EVOqzDb3091Z+p6t9PK+UVYwS0AbAm1zm6R3IMrtYHq5j2OJXOvNMUOwmloBOpmca4kiIw==
X-Received: by 2002:a2e:9556:: with SMTP id t22-v6mr30297824ljh.36.1549015196394;
        Fri, 01 Feb 2019 01:59:56 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b20sm1267177lfj.61.2019.02.01.01.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:59:55 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.0-rc5
Date:   Fri,  1 Feb 2019 10:59:54 +0100
Message-Id: <20190201095954.18273-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a few MMC fixes intended for v5.0-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc4

for you to fetch changes up to 3751e008da0df4384031bd66a516c0292f915605:

  mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay (2019-01-28 12:49:28 +0100)

----------------------------------------------------------------
MMC host:
 - mediatek: Fix incorrect register write for tunings
 - bcm2835: Fixup leakage of DMA channel on probe errors

----------------------------------------------------------------
Chaotian Jing (1):
      mmc: mediatek: fix incorrect register setting of hs400_cmd_int_delay

Lukas Wunner (1):
      mmc: bcm2835: Fix DMA channel leak on probe error

 drivers/mmc/host/bcm2835.c | 2 ++
 drivers/mmc/host/mtk-sd.c  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
