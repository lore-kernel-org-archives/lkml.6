Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68D9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E162086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E162086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeIZLMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:12:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53554 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZLME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:12:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id BA809263B51
From:   Helen Koike <helen.koike@collabora.com>
To:     dm-devel@redhat.com
Cc:     agk@redhat.com, snitzer@redhat.com, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, wad@chromium.org,
        linux-doc@vger.kernel.org, linux-lvm@redhat.com,
        kernel@collabora.com
Subject: [PATCH 0/2] boot to a mapped device
Date:   Wed, 26 Sep 2018 02:00:45 -0300
Message-Id: <cover.1537936397.git.helen.koike@collabora.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is reviving an old patchwork.
Booting from a mapped device requires an initramfs. This series is
allows for device-mapper targets to be configured at boot time for
use early in the boot process (as the root device or otherwise).

Example, the following could be added in the boot parameters.
dm="lroot,,,rw, 0 4096 linear 98:16 0, 4096 4096 linear 98:32 0" root=/dev/dm-0

Enric Balletbo i Serra (1):
  dm ioctl: add a device mapper ioctl function.

Will Drewry (1):
  init: add support to directly boot to a mapped device

 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |   3 +
 Documentation/device-mapper/dm-boot.txt       |  63 +++
 drivers/md/dm-ioctl.c                         |  50 ++
 include/linux/device-mapper.h                 |   6 +
 init/Makefile                                 |   1 +
 init/do_mounts.c                              |   1 +
 init/do_mounts.h                              |  10 +
 init/do_mounts_dm.c                           | 475 ++++++++++++++++++
 9 files changed, 610 insertions(+)
 create mode 100644 Documentation/device-mapper/dm-boot.txt
 create mode 100644 init/do_mounts_dm.c

-- 
2.19.0

