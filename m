Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbeEHOs7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:48:59 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38472 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbeEHOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:48:57 -0400
X-Google-Smtp-Source: AB8JxZodrpMhurwvn7NqT5GsLUBJPhNLBXe29LYKiTXpBjzQPa49CHJQUFByYFAaZ6+nSTJH4n8hPw==
Date: Tue, 8 May 2018 07:48:54 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [GIT PULL] libata fixes for v4.17-rc4
Message-ID: <20180508144854.GL2368884@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

An earlier commit to add reset control for embedded ahci controllers
affected some of the hardware specific drivers and got reverted for
now.  Other than that, just per-device workarounds and trivial
changes.

Thanks.

The following changes since commit fd3b36d275660c905da9900b078eea341847d5e4:

  Merge branch 'work.namei' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2018-04-09 12:48:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.17-fixes

for you to fetch changes up to 0d74d872c3f8b9cb3d096fb932a063b43b37f188:

  driver core: add __printf verification to __ata_ehi_pushv_desc (2018-05-07 08:32:20 -0700)

----------------------------------------------------------------
Colin Ian King (1):
      ata: fix spelling mistake: "directon" -> "direction"

Evan Wang (2):
      libahci: Allow drivers to override stop_engine
      ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI

Hans de Goede (2):
      libata: Apply NOLPM quirk for SAMSUNG MZMPC128HBFU-000MV SSD
      libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs

Kunihiko Hayashi (1):
      Revert "ata: ahci-platform: add reset control support"

Mathieu Malaterre (1):
      driver core: add __printf verification to __ata_ehi_pushv_desc

 .../devicetree/bindings/ata/ahci-platform.txt      |  1 -
 drivers/ata/ahci.c                                 |  6 +--
 drivers/ata/ahci.h                                 |  8 +++-
 drivers/ata/ahci_mvebu.c                           | 56 ++++++++++++++++++++++
 drivers/ata/ahci_qoriq.c                           |  2 +-
 drivers/ata/ahci_xgene.c                           |  4 +-
 drivers/ata/libahci.c                              | 20 ++++----
 drivers/ata/libahci_platform.c                     | 24 ++--------
 drivers/ata/libata-core.c                          |  6 +++
 drivers/ata/libata-eh.c                            |  4 +-
 drivers/ata/sata_highbank.c                        |  2 +-
 drivers/ata/sata_sil24.c                           |  4 +-
 12 files changed, 95 insertions(+), 42 deletions(-)

-- 
tejun
