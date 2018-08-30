Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1FCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9284C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C82duvrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9284C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeH3QWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:22:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37107 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbeH3QWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:22:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so7017395lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 05:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kcQZKylmuKTfrl5YbdHzer7IO9giBs6csUI8h84vBI8=;
        b=C82duvrJQUaPqrXg4V1+SffCtEPApNDYGEJjrlbRgE5ZaXg36pdvhgvNv0fu/csMhn
         mXQz4vfRUS5tOWz+WFBN9/6tkgRL9oYiOxB8F4fTl8UhZ8V40r6BGsqrxolbx5a89eRJ
         H+4iDq6AxSg2JrOGj8Bv0M/Ug9E9Ec85WeO+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kcQZKylmuKTfrl5YbdHzer7IO9giBs6csUI8h84vBI8=;
        b=ppXNY5/3zapSK3bZR76MuMN13rbZqqrR/NYbE6/3Wx4C52RtPiylhjEORiZRD6/uvA
         TdrmeMcLyKKifEplSsgoscS/xXr4UmYoImlKMtGgwH3aBRq3YxGAoqwJARx0hX74PrH2
         4+odLgdGTTRwZN7ZH2+AP4aF+/RYL9RU6AVWGp5gt6gPJvaeLwhTvJa5Jloq8fGV0r54
         2ziwb+5GVdXlGI1Ax6nypMF/PJNHJJKf+Ln1sW7h2qrujTJJAOzgZAX5UWupqzsfMemA
         ASYrjRkxaMtffwxqCIuph+T4T+0cb+p1NAUuPh11PXgwhCszlpbvFrNrleNmuzDJW4SY
         4qeA==
X-Gm-Message-State: APzg51CPZE5ZZIkfApPoi86puTmnSEj1o/0d88A1KZ8Bc1McLP5pJUiV
        /LqCO7gGIBJR0HaUcQV6I3YTHg==
X-Google-Smtp-Source: ANB0VdYqUT7GF7D0EbL15hSt7iMjgRvg1LLjEw6tvnj8YJekuTYtyVKwVBSpkwGeFUv6yHr/hpDgjw==
X-Received: by 2002:a19:264a:: with SMTP id m71-v6mr1538788lfm.112.1535631655190;
        Thu, 30 Aug 2018 05:20:55 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id h26-v6sm684493ljg.36.2018.08.30.05.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 05:20:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ian W MORRISON <ianwmorrison@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [GIT PULL] MMC fixes for v4.19-rc2
Date:   Thu, 30 Aug 2018 14:20:53 +0200
Message-Id: <20180830122053.15803-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.19-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 778a33959a8ad4cb1ea2f4c5119f9e1e8b9f9d9b:

  Merge tag 'please-pull-noboot' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2018-08-20 19:37:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-2

for you to fetch changes up to d2332f887ddfba50fee93b8e1736376517c2df0c:

  mmc: renesas_sdhi_internal_dmac: mask DMAC interrupts (2018-08-23 10:00:49 +0200)

----------------------------------------------------------------
MMC core:
 - Fix unsupported parallel dispatch of requests

MMC host:
 - atmel-mci/android-goldfish: Fixup logic of sg_copy_{from,to}_buffer
 - renesas_sdhi_internal_dmac: Prevent IRQ-storm due of DMAC IRQs
 - renesas_sdhi_internal_dmac: Fixup bad register offset

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: block: Fix unsupported parallel dispatch of requests

Ludovic Desroches (2):
      mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
      mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer conversion

Sergei Shtylyov (2):
      mmc: renesas_sdhi_internal_dmac: fix #define RST_RESERVED_BITS
      mmc: renesas_sdhi_internal_dmac: mask DMAC interrupts

 drivers/mmc/core/queue.c                      | 12 +++++++-----
 drivers/mmc/core/queue.h                      |  1 +
 drivers/mmc/host/android-goldfish.c           |  4 ++--
 drivers/mmc/host/atmel-mci.c                  | 12 ++++++------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 10 +++++++++-
 5 files changed, 25 insertions(+), 14 deletions(-)
