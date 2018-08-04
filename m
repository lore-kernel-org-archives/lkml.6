Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42566C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E624E217BD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvjgAV5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E624E217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeHDQgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42454 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDQgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so3124850edp.9;
        Sat, 04 Aug 2018 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HoDgZfBMvmopss3/KZ9Yhdd3kHwVTh5sU6YvPw/iDIk=;
        b=rvjgAV5c0pkIBDkpmAHI4gZltLq6r3Z+O6YTI9J6YZmMU+icx2zebVd5vXp9h4TxKM
         FbWRhSXvl0aruTP29U8JKN68lfjqcQxmr6PzVfAP1NYeFavCgq3z1iQrjgJAw5MyraDV
         S9BBfoP24DG0qodwGvFK0HScSeFfI36Fo08Y/A76XRpTE0XGpnRrzR6Tnu0q42ZbTIo+
         JaCNa5HeXHCf0Fd6aD/mJeuGNdZ1y3+0P2dmYhY/ajhUd0VrbZer85XLWkBZLhdr2leI
         Ya+VoUKXXVC+xOnJJkgcFLOTdEUA1cRcbMX6l0nxiJZD7r0XbMcHbE1JF4KuIF09QtLN
         VC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HoDgZfBMvmopss3/KZ9Yhdd3kHwVTh5sU6YvPw/iDIk=;
        b=IaWKxiEU1dNZO+Cm+WAV+/u7G6xcFYWYbP4YIEoo7OJoOOe4o3l1mR7QFt/w+HFFiE
         qwcxIux9gnmAxo5tCzCqii58D+A0ChR6olKT7HOG1tUXRyHXO2hUKjybdrHlWg2g/mmb
         s5yP7wjvw3p++NpBGIJc1r9BBTfTG19YwfF3KlSpaQt7IrrzGDv5dWPxMpcO64sjUq2X
         o3dxIuIsmrzgyOpacei8Wjp63RtrE0hON8iVDzM+UIrIe4hToxsMf06POWwQq7DhMf/V
         a9eq9IztGiTjaIP9C+HWECTyRR9BBvSQWh8b3ytD9mmZpTMoA0+HUhdBqEHV5zIhne6j
         w2Xg==
X-Gm-Message-State: AOUpUlG37wtkms1ZKCTIyAHkkLVpBTNYmJsJOxaV0C78kww081S28beq
        hcS9zAZ4DyAuzlDWm3adles=
X-Google-Smtp-Source: AAOMgpcswNHp+9Okj5kWuUGayNH4WY3jUbA8C0braDwiSMT3VWc3uxuhbZegZa64xCsyLygXbehMrQ==
X-Received: by 2002:a50:d0ca:: with SMTP id g10-v6mr11132584edf.182.1533393327506;
        Sat, 04 Aug 2018 07:35:27 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Tegra GART driver clean up and optimization
Date:   Sat,  4 Aug 2018 17:29:55 +0300
Message-Id: <20180804143003.15817-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch-series makes GART driver one step closer to become actually
usable by addressing the following:

1. Thierry noticed that Memory Controller driver uses registers that belong
   to GART in [0] and for now MC driver only reports the fact of GART's page
   fault. The first two patches of the series are addressing this shortcoming
   by providing integration of the MC driver with the GART.

   [0] https://www.spinics.net/lists/linux-tegra/msg33072.html

2. Currently GART has bee kept disabled by the commit c7e3ca515e784
   ("iommu/tegra: gart: Do not register with bus"). If GART is re-enabled than
   all devices in the system are getting assigned to the GART as it is a global
   systems IOMMU provider. This is wrong simply because GART doesn't handle all
   those devices. This series makes GART to accept only devices that are
   explicitly assigned to GART in device tree using 'iommu' phandle.

3. This series makes a generic clean up of the driver, like removing dead code.

4. This series introduces and utilizes iotlb_sync_map() callback that was
   previously suggested by Joerg Roedel in [1], optimizing mapping / unmapping
   performance.

   [1] https://www.spinics.net/lists/linux-tegra/msg32914.html


Changelog:

v2: Addressed review comments from Robin Murphy to v1 by moving devices
    iommu_fwspec check to gart_iommu_add_device().

    Dropped the "Provide single domain and group for all devices" patch from
    the series for now because after some more considering it became not
    exactly apparent whether that is what we need, that was also suggested
    by Robin Murphy in the review comment. Maybe something like a runtime
    IOMMU usage for devices would be a better solution, allowing to implement
    transparent context switching of virtual IOMMU domains.

    Some very minor code cleanups, reworded commit messages.

Dmitry Osipenko (8):
  memory: tegra: Provide facility for integration with the GART driver
  iommu/tegra: gart: Provide access to Memory Controller driver
  iommu/tegra: gart: Clean up drivers module code
  iommu/tegra: gart: Remove pr_fmt and clean up includes
  iommu/tegra: gart: Clean up driver probe errors handling
  iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
  iommu: Introduce iotlb_sync_map callback
  iommu/tegra: gart: Optimize mapping / unmapping performance

 drivers/iommu/iommu.c      |  8 ++-
 drivers/iommu/tegra-gart.c | 99 +++++++++++++++++++++++---------------
 drivers/memory/tegra/mc.c  | 26 ++++++++--
 include/linux/iommu.h      |  1 +
 include/soc/tegra/mc.h     | 13 +++++
 5 files changed, 103 insertions(+), 44 deletions(-)

-- 
2.18.0

