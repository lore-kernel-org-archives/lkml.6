Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F12C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D579C2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="biiWKRRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D579C2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeILMzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:00 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53236 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeILMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:00 -0400
Received: by mail-wm0-f54.google.com with SMTP id y139-v6so1242355wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TJZEkVnSvAIA3IqHAOBx/ownWju+/i0MtjAf6LSOEBE=;
        b=biiWKRRv8fWa8di98ZGF+cGigmBkVpiLsK+oSDa44+53p68XevXsx8nWElVV8C9FeI
         IKKq8lGfIhRfpBulV+tGwoLTS1jRql+TGkgDeZeKhoKvznXU6UG9ig1YdXBlGAm+grMh
         z1iAfWC5jjDcZePN+MhbjfN07q69koyGqZSzkWNThlpsIT7B8FVdN2YgP1jSO5ClRiL6
         I9IkAs1bFIKBAZNKDSI6IFyt4bVqtUx5LBqxzovXGw3VDoB1nwhax1HEHHOKJPCEG8N8
         3od7xIAlkHRAKzOAvNs25LbbjtSstqDMBdlvHEMEbNyCzLEH8CgiVtpgV6DwgnkHYjGR
         G0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TJZEkVnSvAIA3IqHAOBx/ownWju+/i0MtjAf6LSOEBE=;
        b=NuYFwQ6veI1xYGplwWEWoM4SIR+yVu2uBa9AwQLvrfhj4K6Pe2fnPDkFLKFqJNeclp
         mPlvlIsiIssiavLCN0I7Qhe51LQrby1CD1DwYU4N3XIG2f5di1Y0QbITVy5d91PiTmXZ
         dnlzIqYjFKk8kyAxpqk4X57RgxOqozDiQ6PdPX3vouFVsM3AeHEd2PLVjq9Cuk879kEB
         ivX7aF0rDiWXY8TXyEODPbyIL1M9rH4jUon4wc34Cle4b8+polc9LXsvsREd4utCiubo
         NzkTCxIdz9uZkZAQ8uRySsGxhLF+eAVECMfAsuWubfPHrq+IHxKQnv/OwgkfkkCt7hfO
         Utnw==
X-Gm-Message-State: APzg51BgFUfXnVZytAxDUyU+eoe9w9xC9W42adxl2YPKo53eMjeDnnAB
        qZGKUTQf/FxYCmbIk0qWGkcwDA==
X-Google-Smtp-Source: ANB0VdY6TgOoTSMyBjRuWb2GQXY1JIKjUJf+ppPRKE36sKh9vNuW9k0yIeTRmf18Wr5lHOcjTMfsIQ==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr758518wmf.43.1536738699724;
        Wed, 12 Sep 2018 00:51:39 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:39 -0700 (PDT)
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
Subject: [PATCH v3 00/21] nvmem: rework of the subsystem for non-DT users
Date:   Wed, 12 Sep 2018 09:51:08 +0200
Message-Id: <20180912075129.25185-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series contains nvmem framework changes prerequisite for further
development of my previous series[1] that aims at removal of the
platform data struct from at24 EEPROM driver.

The patches are conceptually split into a couple groups.

First five patches fix issues with existing issues.

Patch 6 switches the nvmem providers to using kref which is necessary
for removal of the return value from nvmem_unregister(). This is an
approach similar to the one used in the clock framework where the
provider is only removed after the last reference to it is dropped.

Patches 7-9 convert last remaining users of nvmem_unregister() who
still check its return value to using devm_nvmem_unregister() and
patch 10 changes its return value from int to void.

Patches 11-14 introduce the most significant changes of this series:
we remove the global cell list, add support for static cell definitions
external to the provider structure, change the way DT lookup works and
allow to associate resources and consumers using lookup tables. The way
nvmem_cell_get() for non-DT users is changed but there are no current
users and it's currently broken anyway (cell being removed after a call
to nvmem_cell_put()).

Patch 15 updates the documentation.

Patch 16 adds support for notifiers to nvmem so that users can
subscribe for events such as device or cell registration or removal.

Patches 17 & 18 add some minor improvements to the codebase.

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

Bartosz Golaszewski (21):
  nvmem: provide nvmem_dev_name()
  nvmem: remove the name field from struct nvmem_device
  nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
  nvmem: remove a stray newline
  nvmem: check the return value of nvmem_add_cells()
  nvmem: use kref
  nvmem: lpc18xx_eeprom: use devm_nvmem_register()
  nvmem: sunxi_sid: use devm_nvmem_register()
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
 include/linux/nvmem-provider.h |  49 +--
 7 files changed, 497 insertions(+), 240 deletions(-)

-- 
2.18.0

