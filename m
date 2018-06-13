Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 31386C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EC820660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PKBmGzt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8EC820660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936023AbeFMPpE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:45:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935833AbeFMPpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zhNUq/nluPl4EX8p5kLhFmyHsXOaKiM3aQzizi34jlE=; b=PKBmGzt1DT2KYNn+48bbtpVeu
        yLZGDkd0aLKVgK6xBBrx6sRy1SfNdUWqGMRC/Fl9Ld+uQ/08LNspXqN3i2a55YcudQ9GaYj/gzL9e
        vzr2WBR+qPzfRyhWqBt/ibZVMY9vRajnJ2q1prff2lVFHWNCv4Y60O7KNMkZIwPv+qw6q++ncXJO2
        4+R65FwgJx7N0CXfuWEwaRqIqEqDr3VFTVDamQN0cSiDKDg89kNuyK7geRbuZnMDTm2SKYTxVoyhx
        yrxcl5lh3TGMzXs8jA0+VxoMFy4L99qcTkJJ7GE13JTRegA2mTmHRrNBoG/QcFVsKuiXCIH0DJgGJ
        wtrztIgWQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT7xD-0001RB-7j; Wed, 13 Jun 2018 15:45:01 +0000
Date:   Wed, 13 Jun 2018 08:44:57 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [GIT PULL] platform-drivers-x86 for 4.18-1
Message-ID: <20180613154457.GA121841@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.18-1

for you to fetch changes up to 26ed9d1c07efa5c3a3810dbb7c668e132e91d426:

  platform/x86: silead_dmi: Add entry for Chuwi Hi8 tablet touchscreen (2018-06-08 14:22:15 +0300)

Thanks,

Darren Hart
VMware Open Source Technology Center
----------------------------------------------------------------
platform-drivers-x86 for v4.18-1

Several incremental improvements including new keycodes, new models, new
quirks, and related documentation. Adds LED platform driver activation
for Mellanox systems.  Some minor optimizations and cleanups. Includes
several bug fixes, message silencing, mostly minor.

The following commits were previously merged during the 4.17 RC cycle:
 - 06b8b00b33 platform/x86: asus-wireless: Fix NULL pointer dereference
 - 6ed66c3ce0 platform/x86: Kconfig: Fix dell-laptop dependency chain.
 - 74783c99bf platform/x86: DELL_WMI use depends on instead of select for DELL_SMBIOS
 - cf48bf9eee platform/x86: asus-wmi: Fix NULL pointer dereference

The following is an automated git shortlog grouped by driver:

acer-wmi:
 -  add another KEY_POWER keycode

apple-gmux:
 -  fix gmux_get_client_id()'s return type

asus-laptop:
 -  Simplify getting .drvdata

asus-wireless:
 -  Fix format specifier

dell-laptop:
 -  Fix keyboard backlight timeout on XPS 13 9370

dell-smbios:
 -  Match on www.dell.com in OEM strings too

dell-wmi:
 -  Ignore new rfkill and fn-lock events
 -  Set correct keycode for Fn + left arrow

fujitsu-laptop:
 -  Simplify soft key handling

ideapad-laptop:
 -  Add E42-80 to no_hw_rfkill
 -  Add fn-lock setting
 -  Add MIIX 720-12IKB to no_hw_rfkill

lib/string_helpers:
 -  Add missed declaration of struct task_struct

intel_scu_ipc:
 -  Replace mdelay with usleep_range in intel_scu_ipc_i2c_cntrl

mlx-platform:
 -  Add LED platform driver activation

platform/mellanox:
 -  Add new ODM system types to mlx-platform
 -  mlxreg-hotplug: add extra cycle for hotplug work queue
 -  mlxreg-hotplug: Document fixes for hotplug private data

platform_data/mlxreg:
 -  Document fixes for hotplug device

silead_dmi:
 -  Add entry for Chuwi Hi8 tablet touchscreen
 -  Add touchscreen info for the Onda V891w tablet
 -  Add info for the PoV mobii TAB-P800W (v2.0)
 -  Add touchscreen info for the Jumper EZpad 6 Pro

thinkpad_acpi:
 -  silence false-positive-prone pr_warn
 -  do not report thermal sensor state for tablet mode switch
 -  silence HKEY 0x6032, 0x60f0, 0x6030

----------------------------------------------------------------
Andy Shevchenko (1):
      lib/string_helpers: Add missed declaration of struct task_struct

Antonio Rosario Intilisano (1):
      platform/x86: acer-wmi: add another KEY_POWER keycode

Darren Hart (1):
      platform/x86: DELL_WMI use depends on instead of select for DELL_SMBIOS

Darren Hart (VMware) (1):
      platform/x86: fujitsu-laptop: Simplify soft key handling

Hans de Goede (3):
      platform/x86: silead_dmi: Add touchscreen info for the Jumper EZpad 6 Pro
      platform/x86: silead_dmi: Add info for the PoV mobii TAB-P800W (v2.0)
      platform/x86: silead_dmi: Add touchscreen info for the Onda V891w tablet

Henk Vergonet (1):
      platform/x86: dell-wmi: Set correct keycode for Fn + left arrow

Henrique de Moraes Holschuh (3):
      platform/x86: thinkpad_acpi: silence HKEY 0x6032, 0x60f0, 0x6030
      platform/x86: thinkpad_acpi: do not report thermal sensor state for tablet mode switch
      platform/x86: thinkpad_acpi: silence false-positive-prone pr_warn

Jia-Ju Bai (1):
      platform: x86: intel_scu_ipc: Replace mdelay with usleep_range in intel_scu_ipc_i2c_cntrl

João Paulo Rechi Vita (3):
      platform/x86: asus-wireless: Fix NULL pointer dereference
      platform/x86: asus-wmi: Fix NULL pointer dereference
      platform/x86: asus-wireless: Fix format specifier

Kai Heng Feng (1):
      platform/x86: dell-wmi: Ignore new rfkill and fn-lock events

Luc Van Oostenryck (1):
      platform/x86: apple-gmux: fix gmux_get_client_id()'s return type

Mario Limonciello (2):
      platform/x86: dell-smbios: Match on www.dell.com in OEM strings too
      platform/x86: Kconfig: Fix dell-laptop dependency chain.

Oleg Keri (1):
      platform/x86: ideapad-laptop: Add fn-lock setting

Takashi Iwai (1):
      platform/x86: ideapad-laptop: Add MIIX 720-12IKB to no_hw_rfkill

Timur Kristóf (1):
      platform/x86: dell-laptop: Fix keyboard backlight timeout on XPS 13 9370

Vadim Pasternak (5):
      platform_data/mlxreg: Document fixes for hotplug device
      platform/mellanox: mlxreg-hotplug: Document fixes for hotplug private data
      platform/mellanox: mlxreg-hotplug: add extra cycle for hotplug work queue
      platform/mellanox: Add new ODM system types to mlx-platform
      platform/x86: mlx-platform: Add LED platform driver activation

Wolfram Sang (1):
      platform/x86: Simplify getting .drvdata

dylanchu (1):
      platform/x86: ideapad-laptop: Add E42-80 to no_hw_rfkill

yuk7 (1):
      platform/x86: silead_dmi: Add entry for Chuwi Hi8 tablet touchscreen

 .../ABI/testing/sysfs-platform-ideapad-laptop      |  13 +
 Documentation/laptops/thinkpad-acpi.txt            |   2 +
 drivers/platform/mellanox/mlxreg-hotplug.c         |  54 ++--
 drivers/platform/x86/Kconfig                       |   4 +-
 drivers/platform/x86/acer-wmi.c                    |   1 +
 drivers/platform/x86/apple-gmux.c                  |   2 +-
 drivers/platform/x86/asus-laptop.c                 |   3 +-
 drivers/platform/x86/asus-wireless.c               |   6 +-
 drivers/platform/x86/asus-wmi.c                    |  26 +-
 drivers/platform/x86/dell-laptop.c                 |  17 +-
 drivers/platform/x86/dell-smbios-base.c            |   5 +-
 drivers/platform/x86/dell-wmi.c                    |  16 +-
 drivers/platform/x86/fujitsu-laptop.c              |  47 ++--
 drivers/platform/x86/ideapad-laptop.c              |  66 ++++-
 drivers/platform/x86/intel_scu_ipc.c               |   4 +-
 drivers/platform/x86/mlx-platform.c                | 289 ++++++++++++++++++++-
 drivers/platform/x86/samsung-laptop.c              |   3 +-
 drivers/platform/x86/silead_dmi.c                  | 101 ++++++-
 drivers/platform/x86/thinkpad_acpi.c               |  30 ++-
 include/linux/platform_data/mlxreg.h               |   3 +-
 include/linux/string_helpers.h                     |   1 +
 21 files changed, 603 insertions(+), 90 deletions(-)

-- 
Darren Hart
VMware Open Source Technology Center
