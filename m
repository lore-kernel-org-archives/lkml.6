Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42837ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEFF20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lAn3HCm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEFF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeINTzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50691 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeINTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so2192591wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=C7YmUP7Ahf5v3p/iKKH5UAXvHZeq2ka+DLDLIyWbPL4=;
        b=lAn3HCm2GDNkL0il7S9rSNAQghqC44FhgFZlupusRbwwrOEnu/2UCWta8LV4KU8GTb
         mRafyifWEc4BCwZWPg5AqbTvTV8d1LAgistgu+6XB0YKK/QWbFiWyUFRhTHTMtDlDMJR
         r+Aip/BrD5faR4aYhqzO0zxQTyoMEcliFvPxsfEy7eFqiDsqJlB9znoyeojWX+PYVxSj
         ohhUI3qk8T/r+2nUIsLmR+g++GUNm3ybGRAYkjL1rkaX7Jp7fRFOCtrmV9SWlC9y8SmG
         zJ+mgoPYFe1rfbCegMXJCziks9MWAyAYPwosNfvlI5Qo4KTQoacL9qIDAfCrSLnZQ15i
         1jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C7YmUP7Ahf5v3p/iKKH5UAXvHZeq2ka+DLDLIyWbPL4=;
        b=cmzGVouy4tiB1xcNSKKmTqCp2YkN3P2jqGk82AKLtgCmN9cvHpQHwF7Ql+RQvXq/EJ
         /rJemeqUOVs9RMuA4OG5FOrLDlm4xPPZecp08rjKkegFC7grkSWisOj68t2u4e4gPVc+
         xM5JkBGJesVTLVaVnw9Q+V5/FIofqlayJ3kIsn+C+lXAQk9dpHsYgsASRjM4idGR0po2
         DqDhUANkUtgd/ZCmMVfq0o07zOQNXQoiJLFvnpVdLjMYdxohrpx1cZDJDUR6MLSKAE1l
         NdKXr7q5zxMfUbo79V55frbq/lofX1ezHVZ5JcxFSV4RmDNKxNEySVVgI6qZ4thObseO
         nREQ==
X-Gm-Message-State: APzg51AJlu/wT71Kjx4+TV0m1OePP3nIR3MdTl3DhkTqPO6pTwg/t53o
        sgL8fWliMir/DKJRlNIGjC2vZQ==
X-Google-Smtp-Source: ANB0VdYEO6bcD1lGmqRTqpsRb958+seos+wM7pVFx/DAoaSomJGJh0A7qtiBwrM/wPmph6xZfg1pfA==
X-Received: by 2002:a1c:c5cc:: with SMTP id v195-v6mr2660444wmf.29.1536936023793;
        Fri, 14 Sep 2018 07:40:23 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 00/22] nvmem: rework of the subsystem for non-DT users
Date:   Fri, 14 Sep 2018 16:39:49 +0200
Message-Id: <20180914144011.27614-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

NOTE: I decided to post v4 despite no new reviews from Srinivas as I'll
be off next week. There were a couple issues reported by the kbuild bot
and one bug I noticed after sending v3.

This series contains nvmem framework changes prerequisite for further
development of my previous series[1] that aims at removal of the
platform data struct from at24 EEPROM driver.

The patches are conceptually split into a couple groups.

First five patches fix issues with existing issues.

Patch 6 switches the nvmem providers to using kref which is necessary
for removal of the return value from nvmem_unregister(). This is an
approach similar to the one used in the clock framework where the
provider is only removed after the last reference to it is dropped.

Patch 7 changes the errno returned from the driver after kzalloc()
fails from -EINVAL to -ENOMEM which makes more sense.

Patches 8-10 convert last remaining users of nvmem_unregister() who
still check its return value to using devm_nvmem_unregister() and
patch 11 changes its return value from int to void.

Patches 12-15 introduce the most significant changes of this series:
we remove the global cell list, add support for static cell definitions
external to the provider structure, change the way DT lookup works and
allow to associate resources and consumers using lookup tables. The way
nvmem_cell_get() for non-DT users is changed but there are no current
users and it's currently broken anyway (cell being removed after a call
to nvmem_cell_put()).

Patch 16 updates the documentation.

Patch 17 adds support for notifiers to nvmem so that users can
subscribe for events such as device or cell registration or removal.

Patches 18 & 19 add some minor improvements to the codebase.

Last three patches contain fixes to warnings emitted by checkpatch.
It's a good moment to add them if we're already touching a big part
of the subsystem's code.

Tested both DT and non-DT use cases.

[1] https://lkml.org/lkml/2018/8/10/149

v1 -> v2:
- extended the lookup structure with a proper con_id independent from the
  cell name defined in the cell definition table
- added a patch that makes the naming convention for the cell name argument
  in the nvmem_cell_get() family of functions consistent
- there were two users of nvmem_unregister() that still checked the return
  value, now switched to devm_nvmem_register()
- fixed build failures reported by kbuild test robot

v2 -> v3:
- dropped the patch removing unused APIs and introduced changes on top of
  existing code instead
- fixed nvmem provider reference decreasing in error paths
- added checkpatch fixes
- removed nvmem-machine.h and distributed new definitions among existing
  consumer and provider headers
- reordered patches thematically
- added more patches fixing issues in existing codebase

v3 -> v4:
- fixed the notifier chain call when removing nvmem devices: call the
  notifier chain for NVMEM_REMOVE before releasing any resources
- added patch 7/22 ("sunxi_sid: return -ENOMEM if kzalloc() fails")
- fixed the return value in error path for patch 8/22 ("sunxi_sid: use
  devm_nvmem_register())"
- fixed the return value of devm_nvmem_unregister() in
  patch 11/22 ("change the signature of nvmem_unregister()")

Bartosz Golaszewski (22):
  nvmem: provide nvmem_dev_name()
  nvmem: remove the name field from struct nvmem_device
  nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
  nvmem: remove a stray newline
  nvmem: check the return value of nvmem_add_cells()
  nvmem: use kref
  nvmem: sunxi_sid: return -ENOMEM if kzalloc() fails
  nvmem: sunxi_sid: use devm_nvmem_register()
  nvmem: lpc18xx_eeprom: use devm_nvmem_register()
  nvmem: mxs-ocotp: use devm_nvmem_register()
  nvmem: change the signature of nvmem_unregister()
  nvmem: remove the global cell list
  nvmem: add support for cell info
  nvmem: resolve cells from DT at registration time
  nvmem: add support for cell lookups from machine code
  Documentation: nvmem: document cell tables and lookup entries
  nvmem: add a notifier chain
  nvmem: use SPDX license identifiers
  nvmem: make the naming of arguments in nvmem_cell_get() consistent
  nvmem: use EOPNOTSUPP instead of ENOSYS
  nvmem: fix commenting style
  nvmem: use octal permissions instead of constants

 Documentation/nvmem/nvmem.txt  |  31 ++
 drivers/nvmem/core.c           | 527 ++++++++++++++++++++++-----------
 drivers/nvmem/lpc18xx_eeprom.c |   6 +-
 drivers/nvmem/mxs-ocotp.c      |   4 +-
 drivers/nvmem/sunxi_sid.c      |  20 +-
 include/linux/nvmem-consumer.h | 100 +++++--
 include/linux/nvmem-provider.h |  50 ++--
 7 files changed, 497 insertions(+), 241 deletions(-)

-- 
2.18.0

