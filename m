Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE46EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E4120C51
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf5qwU8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E4120C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbeGKSkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:40:47 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39142 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733106AbeGKSkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:40:47 -0400
Received: by mail-yb0-f195.google.com with SMTP id k127-v6so10413927ybk.6;
        Wed, 11 Jul 2018 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vFEpMOCFsOsVAM4m77Z4XeoUsj6KIds4gpfY7Swb9zM=;
        b=Nf5qwU8vYND6pSSgSfhLMRfpnDrTlSBwm/Bsp9fJSJHjBIkpWpcmXYWw9mIrluBS7U
         EvApK9gLINBs/59qqSr3UbP00SxUFO9xZYGHXoQ2HYZWtOb5PZxh6yrCsUWJaAZSCiox
         9YZ9DqJvjUrhsqrFaibhRSqm+JN1uN5PPIv2gLL5eV6K9jTaKzBEYckKkT6wSYySlyol
         4Tr/4OMYw9XyDx3/8xUrzUxP/n9vevwM9b9QADABGuwmoySYCDY/wLMmJhUBYyqlgfPB
         rqHtlyIg+72iyOnX0xIQeqtIopB/uT11Op+siTEgxdrt/7DqM8YP7mbEWaf82A69ddCT
         gOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=vFEpMOCFsOsVAM4m77Z4XeoUsj6KIds4gpfY7Swb9zM=;
        b=gKobnb8kA/XKQAcQWC987tKknMcLDN82aeX4o61GUDG37PxeTTYSCmjiYEq6weXYCq
         kgoKrVCmf55pvGDneCUlf+crvIw8zBs6b6R3+3eR6nbH0q/fqXrNXrvmmvl5U1VHNW39
         TRojfoPNPdgpF5Dznf8a/ErIikQWytwBrTC0opC0Ecoq76lTHI3lhOT6TH7hv4NNb0b8
         UhCxMh6yeYMXs2slL8QS+Bp+EbYzXUvKj214mE1eHUnYqw7gbfcJ00gfVZRvxwIpsDqg
         yGAaJcZ3OL1aVd4q0TSEMMyPCmjfAqToprIiz3mHnfvSeyH7A0bd/SSsbcKus9n1ex63
         kgRg==
X-Gm-Message-State: APt69E1Cj+vFPj0HUhhhVLDEGmOfgIorPbyhXnSJgiEGwxwIRswjt3yv
        7p2DpRgoND4k6p31YAjYr2A=
X-Google-Smtp-Source: AAOMgpfmn8L7xvP1oiHB8fD4UxB18WD3IXfM3Hk8iVlxwtcRSuyNmW3PeIpRL4hyroN5XVvU+HX9mw==
X-Received: by 2002:a25:ce8e:: with SMTP id x136-v6mr15873266ybe.118.1531334112271;
        Wed, 11 Jul 2018 11:35:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7350])
        by smtp.gmail.com with ESMTPSA id q131-v6sm24819570ywq.8.2018.07.11.11.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 11:35:11 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:35:10 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for v4.18-rc4
Message-ID: <20180711183510.GI72677@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

* Jens's patches to expand the usable command depth from 31 to 32
  broke sata_fsl due to a subtle command iteration bug.  Fixed by
  introducing explicit iteration helpers and using the correct
  variant.

* On some laptops, enabling LPM by default reportedly led to
  occasional hard hangs.  Blacklist the affected cases.

* Other misc fixes / changes.

Thanks.

The following changes since commit 9ffc59d57228d74809700be6f7ecb1db10292f05:

  Merge tag '4.18-rc1-more-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2018-06-18 14:28:19 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.18-fixes

for you to fetch changes up to d55bac2754476624f23bdf3b908d117f3cdf469b:

  ata: Remove depends on HAS_DMA in case of platform dependency (2018-07-02 13:18:22 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      sata_nv: remove redundant pointers sdev0 and sdev1

Damien Le Moal (2):
      ata: Fix ZBC_OUT command block check
      ata: Fix ZBC_OUT all bit handling

Geert Uytterhoeven (1):
      ata: Remove depends on HAS_DMA in case of platform dependency

Hans de Goede (1):
      ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Jens Axboe (4):
      libata: add command iterator helpers
      libata: convert eh to command iterators
      sata_fsl: convert to command iterator
      sata_fsl: remove dead code in tag retrieval

John Garry (1):
      libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()

Mika Westerberg (1):
      ahci: Add Intel Ice Lake LP PCI ID

Wei Yongjun (1):
      ata: ahci_mvebu: ahci_mvebu_stop_engine() can be static

 drivers/ata/Kconfig       |  2 --
 drivers/ata/ahci.c        | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_mvebu.c  |  2 +-
 drivers/ata/libahci.c     |  7 ++++--
 drivers/ata/libata-core.c |  3 +++
 drivers/ata/libata-eh.c   | 41 +++++++++++++-------------------
 drivers/ata/libata-scsi.c | 18 +++++++++-----
 drivers/ata/sata_fsl.c    |  9 +------
 drivers/ata/sata_nv.c     |  3 ---
 include/linux/libata.h    | 24 +++++++++++++++++++
 10 files changed, 122 insertions(+), 47 deletions(-)

-- 
tejun
