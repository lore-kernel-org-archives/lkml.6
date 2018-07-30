Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA3DC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CD320873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WcAgoum5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CD320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeG3HtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:49:22 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38166 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeG3HtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:49:22 -0400
Received: by mail-qk0-f193.google.com with SMTP id 126-v6so7074083qke.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Af73briFlHpRwU0coH9eh8gvoG5VcxLCBjN04TWpP6g=;
        b=WcAgoum5n0vRa5BTg5IrC5P+oAfxEeG7dHU6e7Tedkwn7UuhgONYHMAHOcvNxiT5aZ
         Yc97Z0p6X2NxFgRU+LkP8dt//VPzCCfnKq5l17vYel7PxCYHPoAKBd3/7ENSCNSNIG+i
         xAjM6IzmqNAKGxcBHS5kn08ikDOBMxZwbackc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Af73briFlHpRwU0coH9eh8gvoG5VcxLCBjN04TWpP6g=;
        b=GPBI9DHXIvdfOeqlpR4ZlOhYW5ri1SLJxTX3CfByI+FGYQemKEOn61J+T6FdlSPooU
         R06HT0or+wL1t/vpoI7npP2zBbKBX8nkF2xyx1kYJItUOAzC/Un+0ep4VamGB4ovGzv9
         /+iSRXAKe5nZXfshhwvCoPHl9tr/+MT5teqGC+XwbEEBl+g+NaedTMuRq7YYJDvVc1Ih
         +Ft6VUeN7uw3g8RxHyzDNClf2HnzEiRL1EdacKpQnRCGcHXua2IGrT2BfL/nZZGuZOT3
         PTkjg9qnu3qQLurwUy5xa+AFch6bs343A0iucnFiRA4diXiHJnq8VijC9dAQHMvHFngr
         AevQ==
X-Gm-Message-State: AOUpUlHd8OuWGc46ZIkOrRe48Exy3/o48xC5IlFwK96HwbbZqAJcbWfU
        7f8mEfO8IyGYgyyfm39RHfj8Zg==
X-Google-Smtp-Source: AAOMgpeG6Jze/ElqaMjvobZeAOU6M30RXjauQwlhQRNt7rYMnoRBZ8cls9yRD7fHyEqMOvkGmOi30w==
X-Received: by 2002:a37:9d58:: with SMTP id g85-v6mr14215393qke.230.1532931358622;
        Sun, 29 Jul 2018 23:15:58 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id z12-v6sm6211778qkf.40.2018.07.29.23.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 29 Jul 2018 23:15:57 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        vikram.prakash@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 0/2] Add ACPI support to IPROC SDHCI
Date:   Mon, 30 Jul 2018 11:45:41 +0530
Message-Id: <1532931343-9499-1-git-send-email-srinath.mannam@broadcom.com>
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
 drivers/mmc/host/sdhci-iproc.c | 63 ++++++++++++++++++++++++++------------
 drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
 4 files changed, 91 insertions(+), 48 deletions(-)

-- 
2.7.4

