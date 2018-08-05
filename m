Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BD3C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC52217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C4UpDh0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC52217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeHEJ4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:56:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32956 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeHEJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:56:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15-v6so10651883qtp.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x+BLaAHXu937pAEb0Vqsl32EUCSTmEzEEw6Xf43IHkY=;
        b=C4UpDh0wU2fGiJy6mnIfGeJJnvVY/9Q6dcAAAkdr31k6+HLsaLVoKxytvqdGZJjobb
         ncLVO8ghYJreoSYVBQvm6B/87foQ8AJJ+IK7GnO8rtterRlY01WRAR4iStWFQa6v+FT9
         IzTBqCVl/tCXK+QCx1XIQFjoBAQruZzTuky9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x+BLaAHXu937pAEb0Vqsl32EUCSTmEzEEw6Xf43IHkY=;
        b=bFDRSlXXid/BP910+efDY/peOBynMHht5x7J3iaomydBZxBl7bjd0uuAJlDrcsGNyK
         /EugtuHL6z6NyQA1eHMj0K6Q3E7Fogm8ghWmHa7pmXnsEK03/cwCA9RVkUxjQxdbPiEo
         96ZMzj+oyJjEniEM3P+aWtl9i4YBVwVjHLqFxPN2iP/ER45jyLrHE10K/HrJAdge1ZJm
         BxbOVQiIe0dXH7XUeSbtjYNneB77ZQRzhQKM6gx98jKJHlePDMvil83PZDupoxcF7/Ou
         lsWeKuN8JuNaWRWC3khuBA8G/b/cavbwaRg+eqnWLaH1itogt4+QkGNGpoGelP5itaBs
         mC3g==
X-Gm-Message-State: AOUpUlFmftHeVi0wJmuQtw3CPc5BfaTEaYFTugCqgodiHNpFvthqbvrp
        43PEPzNps8YiUUBkoCmH8Irm+w==
X-Google-Smtp-Source: AAOMgpd3TXatydeJqzX9JUNHr/OlGRGNrd15qlaFd9wSekohALr8OlQAmomwI0thL/gq8F5nUZbeKA==
X-Received: by 2002:a0c:8b11:: with SMTP id q17-v6mr9127380qva.193.1533455587550;
        Sun, 05 Aug 2018 00:53:07 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q18-v6sm6363905qtg.82.2018.08.05.00.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Aug 2018 00:53:06 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        vikram.prakash@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 0/2] Add ACPI support to IPROC SDHCI
Date:   Sun,  5 Aug 2018 13:22:50 +0530
Message-Id: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds
  - Feature to get generic device properties in the
    place of DT properties.
  - ACPI support to IPROC SDHCI varients

This patch series is based off v4.18-rc3

Changes from v3:
  - Replaced separate device tree and ACPI get match data APIs
    with single device_get_match_data API.

Changes from v2:
  - Added patch "Convert DT properties to generic device properties"
    given by Adrian Hunter to this patch series because
    "Add ACPI support to IPROC SDHCI" patch is depends on this.

Changes from v1:
  - Removed sdhci_iproc_data array change and add directly
    into of and acpi id tables.
  - Add a change to get match data directly.
  - Removed clock-frequency property read change.
  - Used sdhci_get_property to get properties.
  - Verified with patch given by Adrian Hunter
    mmc: sdhci-pltfm: Convert DT properties to generic device properties

Adrian Hunter (1):
  mmc: sdhci-pltfm: Convert DT properties to generic device properties

Srinath Mannam (1):
  mmc: host: iproc: Add ACPI support to IPROC SDHCI

 drivers/mmc/host/Kconfig       |  1 +
 drivers/mmc/host/sdhci-iproc.c | 59 ++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
 4 files changed, 87 insertions(+), 48 deletions(-)

-- 
2.7.4

