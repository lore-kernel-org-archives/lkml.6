Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B22C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D82720881
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoZFkntd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfAYNur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:50:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37760 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYNur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:50:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so6983528lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 05:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2cgDgJCXbM7SgzHTfhBhdnsde3Z4ewq3kODySppK7gc=;
        b=DoZFkntdIXNd60D5zXJcyXiKrCxTOYHma58LtKsbXOITYjjHgem/kajybVm1W29dz5
         LENfw2xmV3j43wouUi3Le1D6r7Cd+DpigzQyovGiyX5btY1w/UDLt7ZU/30ppwCmVbqK
         H6IoGT31DgdDKk4+/Wmc9INzaKb4qr55BU/Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2cgDgJCXbM7SgzHTfhBhdnsde3Z4ewq3kODySppK7gc=;
        b=PGXUieJ5ejxf8E3AysCHXpqVyfTvx6V7l1Dc0PYJtTsKCYge1iI4/m5CrtYi+9CBuj
         z1zY+8zF4ub2gKGOKuHY+d7CeAvyR2zGDwqKhz0Nsg51WodUG2ECthO7QDTygw2LATdq
         LOB3TT75GwhmAFj0CMO2Ga6we97o4LvE25ELEiWw7B7TpdxDZka4Z+Z99TCYXGt5I0IG
         WZFRfT1RFMI2ZQWLwAJ2oo1TKVXhOBoPd8Wf0jRH9xj3YprgY4baNarRUoXnE9KbJ5WD
         1dCprv2iFFWyz3XBIvbhlmL9siWmn1f03Mg1KMG3eHiYwxwCPEraPr8x4dBxD1LHU7ir
         rNSw==
X-Gm-Message-State: AJcUukcCnrDCQQpijR/vJhRjpf/W883lIlyjDra+JQpa8xZefjZI9LSD
        Frm1XFkfH4PWhrt/hV5dOoknNg==
X-Google-Smtp-Source: ALg8bN5V2wGmCTTZqJyCXF6wuOGLVPpMhzjW5Jf7LJm/AMVyOF/L6BXGtkhCPJ777i3KeMh5GEworA==
X-Received: by 2002:a19:6514:: with SMTP id z20mr473701lfb.31.1548424244941;
        Fri, 25 Jan 2019 05:50:44 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q128-v6sm1505684ljq.14.2019.01.25.05.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 05:50:44 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.0-rc4
Date:   Fri, 25 Jan 2019 14:50:43 +0100
Message-Id: <20190125135043.22286-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.0-rc4. Details about the
highlights are as usual found in the signed tag.

Note that, my GPG-key expired last week, I have set a new expiration date for
it and re-published it, however not sure if it's been replicated to all
keyservers yet. Please tell if there is any issues from your side.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc2

for you to fetch changes up to f3716b8ae9347797b73896725f192c3a7b0069b5:

  mmc: dw_mmc-bluefield: : Fix the license information (2019-01-22 08:46:20 +0100)

----------------------------------------------------------------
MMC host:
 - sdhci-acpi: Fixup build dependency for PCI
 - sdhci-omap: Resolve Kconfig warnings on keystone
 - sdhci-iproc: Propagate errors from DT parsing
 - meson-gx: Fixup IRQ handling in release callback
 - meson-gx: Use signal re-sampling to fixup tuning
 - dw_mmc-bluefield: Fix the license information

----------------------------------------------------------------
Andreas Fenkart (1):
      mmc: meson-gx: enable signal re-sampling together with tuning

Faiz Abbas (1):
      mmc: host: Fix Kconfig warnings on keystone_defconfig

Liming Sun (1):
      mmc: dw_mmc-bluefield: : Fix the license information

Remi Pommarel (1):
      mmc: meson-gx: Free irq in release() callback

Sinan Kaya (1):
      mmc: sdhci-acpi: Make PCI dependency explicit

Stefan Wahren (1):
      mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

 drivers/mmc/host/Kconfig            |  4 ++--
 drivers/mmc/host/dw_mmc-bluefield.c |  5 -----
 drivers/mmc/host/meson-gx-mmc.c     | 32 ++++++++++++++++++++------------
 drivers/mmc/host/sdhci-iproc.c      |  5 ++++-
 4 files changed, 26 insertions(+), 20 deletions(-)
