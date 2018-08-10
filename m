Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D9C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD1720845
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD1720845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeHKBiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:38:19 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:50926
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbeHKBiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:38:19 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id oGTCfUuVodH2EoGTCfguuy; Fri, 10 Aug 2018 16:05:23 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1foGTC-0000Xr-78; Fri, 10 Aug 2018 16:05:22 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/5] Miscellaneous fixes/enhancements 
Date:   Fri, 10 Aug 2018 23:05:20 +0000
Message-Id: <20180810230520.2055-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfC4WDABPcwRV3y/3V+KCVQqDHOW2OUFs4p1r+43Rf6AN6rKcqQhgJYRZgOdjRoyrEKeBmS/Yln09HZkD7mOy12z5xYOHR9JV0JA/66W7UIYkdCY/Sskm
 PfD8aJb2b1qCU1icZjPZya8jz5HU6F5nBBgZtVRhcC/CJbbRElo9eGnySnQprrFzA1x0Vq8sDgZC8wm2ZwsnQDAIO8+j6CrG5AM/Y2EDxArSB1Jdo9reRF6B
 O0NNQFNaQP6DPOFAVbXW8hu97KKsHFtgewDon7nzPcOgPdz7yiBps+HenXGKbqF1Xy3cT30Z5vIxqkK1en0VrwFpHosRTUjmcTr8qBERVXZL8p3fh3QnZNnh
 WNtIDrXXIQKl3wbNyATE1r5XzTUeA8/bb+sOJHSEHC3XhiCkAtPM3x0MvwVZKTcyjU6sQkchxzGrUXQUMGKk4jMJjrvc/PNzxhamiIqXW1P5SuVUsZ81ZnsD
 9rQuq0j8HTY26HIujYbwYT8eFk6MX2T69lcjN6Zai4MTxqUHpI3tE+V4KAJPKXjsurVWkzgTPMs4ldCq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Miscellaneous fixes/enhancements.

K. Y. Srinivasan (1):
  Tools: hv: Fix a bug in the key delete code

Michael Kelley (1):
  Drivers: hv: vmbus: Fix synic per-cpu context initialization

Stephen Hemminger (3):
  vmbus: add driver_override support
  uio_hv_generic: increase size of receive and send buffers
  uio_hv_generic: drop #ifdef DEBUG

 Documentation/ABI/testing/sysfs-bus-vmbus |  21 ++++
 drivers/hv/hv.c                           |  15 ++-
 drivers/hv/vmbus_drv.c                    | 115 ++++++++++++++++++----
 drivers/uio/uio_hv_generic.c              |   7 +-
 include/linux/hyperv.h                    |   1 +
 tools/hv/hv_kvp_daemon.c                  |   2 +-
 6 files changed, 134 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-vmbus

-- 
2.18.0

