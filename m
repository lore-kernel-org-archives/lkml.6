Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66758C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F28215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F28215EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeHRTGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:06:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeHRTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:06:21 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B9FECBD4;
        Sat, 18 Aug 2018 15:58:08 +0000 (UTC)
Date:   Sat, 18 Aug 2018 17:57:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core patches for 4.19-rc1
Message-ID: <20180818155758.GA22665@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

  Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-4.19-rc1

for you to fetch changes up to d2fc88a61b4ea99f574bde16e92718e22f312136:

  Merge 4.18-rc7 into driver-core-next (2018-07-30 10:08:09 +0200)

----------------------------------------------------------------
Driver core patches for 4.19-rc1

Here are all of the driver core and related patches for 4.19-rc1.

ZNothing huge here, just a number of small cleanups and the ability to
now stop the deferred probing after init happens.

All of these have been in linux-next for a while with only a merge issue
reported.  That merge issue is in fs/sysfs/group.c and Stephen has
posted the diff of what it should be to resolve this.  I'll follow up
with that diff to this pull request.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Benjamin Gaignard (1):
      base: core: Remove WARN_ON from link dependencies check

Benjamin Herrenschmidt (1):
      drivers: core: Remove glue dirs from sysfs earlier

Greg Kroah-Hartman (1):
      Merge 4.18-rc7 into driver-core-next

Guenter Roeck (2):
      kernfs: Replace strncpy with memcpy
      kobject: Replace strncpy with memcpy

Javier Martinez Canillas (1):
      driver core: add a debugfs entry to show deferred devices

Joe Perches (1):
      device: Add #define dev_fmt similar to #define pr_fmt

Luis R. Rodriguez (1):
      Documentation: update firmware loader fallback reference

Pingfan Liu (1):
      drivers/base: stop new probing during shutdown

Rajat Jain (1):
      sysfs: Fix internal_create_group() for named group updates

Randy Dunlap (2):
      linux/device.h: fix kernel-doc notation warning
      sysfs.h: fix non-kernel-doc comment

Rob Herring (6):
      driver core: allow stopping deferred probe after init
      dt-bindings: pinctrl: add a 'pinctrl-use-default' property
      pinctrl: Support stopping deferred probe after initcalls
      iommu: Stop deferring probe at end of initcalls
      iommu: Remove IOMMU_OF_DECLARE
      PM / Domains: Stop deferring probe at the end of initcall

Shaokun Zhang (1):
      driver core: remove unnecessary function extern declare

Sudeep Holla (1):
      drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number

Todd Poynor (1):
      drivers: base: initcall_debug logs for driver probe times

Wesley W. Terpstra (1):
      base: fix order of OF initialization

 Documentation/admin-guide/kernel-parameters.txt    |   9 ++
 .../bindings/pinctrl/pinctrl-bindings.txt          |   6 +
 .../driver-api/firmware/fallback-mechanisms.rst    |   7 +-
 drivers/base/base.h                                |   2 -
 drivers/base/cacheinfo.c                           |  24 ++--
 drivers/base/core.c                                |  23 ++--
 drivers/base/dd.c                                  | 134 +++++++++++++++++----
 drivers/base/init.c                                |   2 +-
 drivers/base/power/domain.c                        |   2 +-
 drivers/iommu/arm-smmu-v3.c                        |   2 -
 drivers/iommu/arm-smmu.c                           |   7 --
 drivers/iommu/exynos-iommu.c                       |   2 -
 drivers/iommu/ipmmu-vmsa.c                         |   3 -
 drivers/iommu/msm_iommu.c                          |   2 -
 drivers/iommu/of_iommu.c                           |  21 +---
 drivers/iommu/qcom_iommu.c                         |   2 -
 drivers/iommu/rockchip-iommu.c                     |   2 -
 drivers/pinctrl/devicetree.c                       |  15 ++-
 fs/kernfs/symlink.c                                |   2 +-
 fs/sysfs/group.c                                   |  29 +++--
 include/asm-generic/vmlinux.lds.h                  |   2 -
 include/linux/device.h                             | 107 +++++++++-------
 include/linux/kobject.h                            |  17 +++
 include/linux/of_iommu.h                           |   4 -
 include/linux/sysfs.h                              |   6 +-
 lib/kobject.c                                      |   2 +-
 26 files changed, 273 insertions(+), 161 deletions(-)
