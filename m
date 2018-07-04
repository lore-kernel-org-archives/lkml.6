Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E98C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD420878
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EKFS64QM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECD420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeGDPI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:08:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54825 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeGDPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:08:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so6308428wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Z0+LWP64HppbEBr6laVBjSKgTOpZdCndaYmupFzuNE=;
        b=EKFS64QM0V/XeYW/P6nUFXPQ9sHFKJNbzDWTUmXUp3DeWY3c/toh9u8yE4Cr+5UGVx
         5/VDOM2o/4CbHHH2XjS5LRcySLM8CF5aEJRAb011IyUEZNjx5/7fu9jRnVzRI5AETnJ3
         +ixfb/YoPisTtVLTlx4PuybdEzlhcS7l+WSqNicyZMaxQrwlrSIYVos52yQUlL2zkA26
         4SrHcB8UmbhO4n0pvdDMNNJegR5I+H63NYqdQOeRvTsZYjdN9ycWy/h9GCb8mpXQm7Wp
         XBM8HjRNuTqz8mjkQyJVGlJRA1mTz3FD0pbqYxnx/earHHRAJc+iVuzz4IaXcw922Z+e
         WgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Z0+LWP64HppbEBr6laVBjSKgTOpZdCndaYmupFzuNE=;
        b=YhCf0cwhP1BhI+MkiN378LCMrAb1bVNegtfoF8NOtCe2bu8TQM3GR9MgbQq/6NthC/
         vfeFp/nFVlY3HaYsUtQjjt36okAPVUNn6Y2BZpsG97aq8Rzuw/DG6otbupnTMkePQquf
         IczgJlQZFROyY2LwpdMbI/fBTXe0y71zh8NL1fMT4sPug9lPgwbdEDefKxTe64nQiLiI
         Y2cCSRfXzJKQiVEZulRppuxMP0Mb118uGmN8DMz1WJyeMf1/VgoLA1QZ+Y6vb5NQehXP
         WkuB5wD97Dmvey/O3QNje0hJQfl5q9pcq4eFUUflfDyTgSwJ+enBT8DEqtAT0k/uS60f
         9KeA==
X-Gm-Message-State: APt69E0NbIzpdpTztshZVzj3TCSwrhcdX/VYsjFdqnd2/3Qh/jVzYp55
        QEnaMPGCqmHiu/Q/gM5rT2Q6Ow==
X-Google-Smtp-Source: AAOMgpcGitO69gmy4gZC6BGtyc+43bs4D4Vu6O4mTRJhB0mSeACw5yX5nHf2YNqrrEJ4HsgHiVuCKQ==
X-Received: by 2002:a5d:44ca:: with SMTP id z10-v6mr1961412wrr.210.1530716904232;
        Wed, 04 Jul 2018 08:08:24 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l7-v6sm9607737wmh.1.2018.07.04.08.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 08:08:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
Subject: [PATCH v8 0/6] Add ChromeOS EC CEC Support
Date:   Wed,  4 Jul 2018 17:08:15 +0200
Message-Id: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The new Google "Fizz" Intel-based ChromeOS device is gaining CEC support
through it's Embedded Controller, to enable the Linux CEC Core to communicate
with it and get the CEC Physical Address from the correct HDMI Connector, the
following must be added/changed:
- Add the CEC sub-device registration in the ChromeOS EC MFD Driver
- Add the CEC related commands and events definitions into the EC MFD driver
- Add a way to get a CEC notifier with it's (optional) connector name
- Add the CEC notifier to the i915 HDMI driver
- Add the proper ChromeOS EC CEC Driver

The CEC notifier with the connector name is the tricky point, since even on
Device-Tree platforms, there is no way to distinguish between multiple HDMI
connectors from the same DRM driver. The solution I implemented is pretty
simple and only adds an optional connector name to eventually distinguish
an HDMI connector notifier from another if they share the same device.

Feel free to comment this patchset !

Changes since v7:
- rebased on v4.18-rc1
- Fixed whitespace issues on patch 3
- Added Lee's tags

Changes since v6:
- Added stable identifier comment in intel_display.h
- Renamed to cec_notifier in intel_hdmi.c/intel_drv.h
- Added Acked-by/Reviewed-By tags

Changes since v5:
 - Small fixups on include/linux/mfd/cros_ec_commands.h
 - Fixed on cros-ec-cec driver accordingly
 - Added Reviewed-By tags

Changes since v4:
 - Split patch 3 to move the mkbp event size change into a separate patch

Changes since v3 (incorrectly reported as v2):
 - Renamed "Chrome OS" to "ChromeOS"
 - Updated cros_ec_commands.h new structs definitions to kernel doc format
 - Added Reviewed-By tags

Changes since v2:
 - Add i915 port_identifier() and use this stable name as cec_notifier conn name
 - Fixed and cleaned up the CEC commands and events handling
 - Rebased the CEC sub-device registration on top of Enric's serie
 - Fixed comments typo on cec driver
 - Protected the DMI match only with PCI and DMI Kconfigs

Changes since v1:
 - Added cec_notifier_put to intel_hdmi
 - Fixed all small reported issues on the EC CEC driver
 - Moved the cec_notifier_get out of the #if .. #else .. #endif

Changes since RFC:
 - Moved CEC sub-device registration after CEC commands and events definitions patch
 - Removed get_notifier_get_byname
 - Added CEC_CORE select into i915 Kconfig
 - Removed CEC driver fallback if notifier is not configured on HW, added explicit warn
 - Fixed CEC core return type on error
 - Moved to cros-ec-cec media platform directory
 - Use bus_find_device() to find the pci i915 device instead of get_notifier_get_byname()
 - Fix Logical Address setup
 - Added comment about HW support
 - Removed memset of msg structures

Neil Armstrong (6):
  media: cec-notifier: Get notifier by device and connector name
  drm/i915: hdmi: add CEC notifier to intel_hdmi
  mfd: cros-ec: Increase maximum mkbp event size
  mfd: cros-ec: Introduce CEC commands and events definitions.
  mfd: cros_ec_dev: Add CEC sub-device registration
  media: platform: Add ChromeOS EC CEC driver

 drivers/gpu/drm/i915/Kconfig                     |   1 +
 drivers/gpu/drm/i915/intel_display.h             |  24 ++
 drivers/gpu/drm/i915/intel_drv.h                 |   2 +
 drivers/gpu/drm/i915/intel_hdmi.c                |  13 +
 drivers/media/cec/cec-notifier.c                 |  11 +-
 drivers/media/platform/Kconfig                   |  11 +
 drivers/media/platform/Makefile                  |   2 +
 drivers/media/platform/cros-ec-cec/Makefile      |   1 +
 drivers/media/platform/cros-ec-cec/cros-ec-cec.c | 347 +++++++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                        |  16 ++
 drivers/platform/chrome/cros_ec_proto.c          |  40 ++-
 include/linux/mfd/cros_ec.h                      |   2 +-
 include/linux/mfd/cros_ec_commands.h             |  97 +++++++
 include/media/cec-notifier.h                     |  27 +-
 14 files changed, 578 insertions(+), 16 deletions(-)
 create mode 100644 drivers/media/platform/cros-ec-cec/Makefile
 create mode 100644 drivers/media/platform/cros-ec-cec/cros-ec-cec.c

-- 
2.7.4

