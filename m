Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EE5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0FF20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTjyHm3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0FF20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbeGYVF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbeGYVF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:05:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BC720844;
        Wed, 25 Jul 2018 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532548338;
        bh=jsu/k4Z2xH9v6Y7vtj/6Wdq36qQRRwUEfHrcye17dHM=;
        h=Subject:From:To:Cc:Date:From;
        b=FTjyHm3PAPZ3JPp9ug7DBpjPq0JVQ8dyO8UxrOdrKVKpYcWVbuRXp9hb5KChh0icw
         IIQk0YzLvjfloqmcIp0Ojygqki7bCNuVWDkZKQrR4TBL9LFRSqHmBcbFUTVaxmH7rG
         RTUPaRmLj0vIKE8H+7TFielholhL2nXasT1dePkM=
Subject: [PATCH v1 0/4] PCI: Remove unnecessary includes of
 <linux/pci-aspm.h>
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        ath9k-devel@qca.qualcomm.com, linuxwifi@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Wed, 25 Jul 2018 14:52:08 -0500
Message-ID: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove includes of <linux/pci-aspm.h> from files that don't need
it.  I'll apply all these via the PCI tree unless there's objection.

---

Bjorn Helgaas (4):
      igb: Remove unnecessary include of <linux/pci-aspm.h>
      ath9k: Remove unnecessary include of <linux/pci-aspm.h>
      iwlwifi: Remove unnecessary include of <linux/pci-aspm.h>
      PCI: Remove unnecessary include of <linux/pci-aspm.h>


 drivers/net/ethernet/intel/igb/igb_main.c     |    1 -
 drivers/net/wireless/ath/ath9k/pci.c          |    1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    1 -
 drivers/pci/pci-sysfs.c                       |    1 -
 drivers/pci/pci.c                             |    1 -
 drivers/pci/probe.c                           |    1 -
 drivers/pci/remove.c                          |    1 -
 7 files changed, 7 deletions(-)
