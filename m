Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14800ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8413F2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="biePd9Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8413F2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbeIUNRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38347 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389287AbeIUNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id t25-v6so2042665wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=LMHPqISd9Xa9CxHXc3d76ZGOHdt//JgqheKCMneS+6w=;
        b=biePd9Q+sI6rSgTuAIgQLcyZ0wT0wPycBuyhJXmZAcilx/nTGoO8QelYqx1wOww8vE
         QHFxNvZrBQ5sSbFHbcOLPHIKEdkw7gMaUvaapkXefsaCKlc/22dZ9NDZAXdbw9xY1nMD
         Gbf8Mn27J7k+Fh3gaPlvrqu7VpYLLJfEWYXnLj3mSVsJT3AWhLxN8yERkrN65qZjh9eK
         Txc72sTrBiS8LSuPWCHmyQYKJBMWhtjzlO3XW4ybHziSiXJd3t6FAf8DtnYqlpD6c6LO
         u4gepbX8ssHXGWt2qdeftZEV7VAR+JiQzvYd5w5BwBUMGkGhy9CUwyQ+Am9X9npH1Fvs
         LXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LMHPqISd9Xa9CxHXc3d76ZGOHdt//JgqheKCMneS+6w=;
        b=HkRhXA+ksSQJVKhP2wQHxnqofRLTwtDc8SGvBlMNXpVj5r7OybYanqkA1BS309ixCZ
         cOS4L21gkeLhmwOGdJG8gam/xaUN0LCc44r44uhgP+mqrwGKa73+3A9kETSUvtekXf++
         9I/C56DAz3elQspyEw9t1vw2FTcKt4aEZquxc+LEqwI0X5vI1U0B2WDgVzPQu7Km9GYq
         vVPF4+2/LdVZqUsEap7z63beJ/ZhwoMf3PKafuJyvVRlKNNZwklCUwKbUIUEqitc772s
         SHLq1fYVztg1bZ+7m+7SKCOE5kGtmRGNjmHZt5sIHScf4/NUftC3iHpVMKCNhRCP6slz
         9hsw==
X-Gm-Message-State: ABuFfohwBySG2AouQTter2vAVWyeah1nRnTRLepeXDUmN/3Cg/YaPk7p
        hQt4S3Gg8rfm/9g/fsT55zk69g==
X-Google-Smtp-Source: ANB0VdYo98o3FquR1UWi4wGMXxK1AEIwcSQAP65ReO8iwqscOERsmv2mtXiQNk+/yQsDouljxzhLAg==
X-Received: by 2002:a1c:8c08:: with SMTP id o8-v6mr6050054wmd.60.1537514966526;
        Fri, 21 Sep 2018 00:29:26 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:25 -0700 (PDT)
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
Subject: [PATCH v5 00/22] nvmem: rework of the subsystem for non-DT users
Date:   Fri, 21 Sep 2018 09:28:59 +0200
Message-Id: <20180921072921.19387-1-brgl@bgdev.pl>
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

First five patches fix issues with existing code.

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

v4 -> v5:
- rebased on top of char-misc-next and retested

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

