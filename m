Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E5A20846
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/l7Q3Iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E5A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeIAU7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:59:36 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:38325 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeIAU7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:59:36 -0400
Received: by mail-pg1-f172.google.com with SMTP id f4-v6so1504920pgq.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 09:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bFtEweahimNcALdMLjMduK55ciwaLvJyHurtShWLLCY=;
        b=n/l7Q3IuSyZyPI7o9x2nbUV3GYtLOA7DLulCkrm03Nwbmc6a24HqkY3AdyuSsl5GMU
         OiuU4z+gGP3gfqNDbSDkZHSaZTvm41oJLmz4Mp7A2dXVea5+sSi4vF3RN/rJVpf1YzWz
         TPdYNMFKMKKyKnIITbte5eeudI8SuLkkZnUC03E6mzSz5wPm34OrHrCeG6Tb3l4G0YZj
         rPKo7PY8jR/+O/f8BMrFv7Jov7DRk8jbj5deBSo6Wqi9cirLWuo42nVgFmrNH8ZE8XU5
         osFQOrYArgVgHtFBZO5zrZOe0YAHme0KTrNSt7ZFe258oG/lnpEkamM3c87QVqf9Xx+G
         T+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bFtEweahimNcALdMLjMduK55ciwaLvJyHurtShWLLCY=;
        b=fueOufGp+Wkbb9JbGaXm6BTSsGC3YgQdxZP3LwPu8YP8iFZD5+fmcKZgftTdWhRcCE
         poKff2qhyXNvq21OaG7sjVf4A8GTDSdii5ZskmftFVm4KTrIwxUOaUXRtzEp5F6gllAw
         huHk891Jg0MrBiGqnntvbU6NTpbyzp4TGtaMwHmCa716MhsF4PYKfuC1Gtr5ICeCKXMe
         iKDeKdhnyLTAcCdnRMQSN+TtejKtSXgyq6uiivxw80NuSeR8ImTkAGP0CId60TJ03lre
         Mj2QVHRg2F4qzq/jioG7+DT8hrhLHCOJ2UDI8+0OSYMxCtc7CJqJx91Twm41tUaWzZHC
         7Cfw==
X-Gm-Message-State: APzg51BbrcDi2L3L/kyMVrLYzNaJTn+zJUDZUySIjv93bpydTWwtG0Qv
        sDigTzppXUz9b9vVeeYQ3AV6ImiG
X-Google-Smtp-Source: ANB0VdastnDO5+WlfY/RmYEQSdq1uzlm4Exddx41dPMlobId2ngSY/Wx+YhlB+HSuP9Spl3ggG4ERw==
X-Received: by 2002:a62:1d54:: with SMTP id d81-v6mr21564259pfd.139.1535820420714;
        Sat, 01 Sep 2018 09:47:00 -0700 (PDT)
Received: from dfrey-debian-linux.sierrawireless.local (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id x65-v6sm22994095pfk.140.2018.09.01.09.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 09:46:59 -0700 (PDT)
From:   David Frey <dpfrey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, David Frey <dpfrey@gmail.com>
Subject: regmap: split regmap_config.use_single_rw
Date:   Sat,  1 Sep 2018 09:50:39 -0700
Message-Id: <20180901165041.25026-1-dpfrey@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series splits regmap_config.use_single_rw into
use_single_read and use_single_write.

Motivation:
When multiple sequential registers need to be read or written, the
author can either choose to call regmap_bulk_read/write() once or call
regmap_read/write() repeatedly. The _bulk option has the advantages of
being more compact since only one function call is needed and more
efficient since multiple registers are read/written at once instead of
having to pay for transaction and addressing overhead of the underlying
transport multiple times.

Many chips don't support bulk access, but it's still convenient to be
able to read/write multiple registers with a single function call. This
is what use_single_rw=true is for. When this option is set, bulk
reads/writes are automatically split into a series of single register
accesses.

Some other chips (for example the Bosch bmi160 IMU) support bulk reads,
but not bulk writes. Currently for chips like this, the author must
choose between convenience or efficiency by setting use_single_rw =
true/false respectively.

Proposal:
In this patch series I split the use_single_rw member of struct
regmap_config into use_single_read and use_single_write. This change is
in line with what is already implemented inside of the internal struct
regmap which is populated from struct regmap_config.

Updates:
v2
  * Combined patch to split use_single_rw apart and the patch to update
    the clients into a single patch so that kbuild test robot will be
    happy.

David Frey (2):
  regmap: fix comment for regmap.use_single_write
  regmap: split up regmap_config.use_single_rw

 drivers/base/regmap/internal.h           |  2 +-
 drivers/base/regmap/regmap.c             |  4 ++--
 drivers/edac/altera_edac.c               |  3 ++-
 drivers/hwmon/lm75.c                     |  3 ++-
 drivers/hwmon/lm95245.c                  |  3 ++-
 drivers/hwmon/tmp102.c                   |  3 ++-
 drivers/hwmon/tmp108.c                   |  3 ++-
 drivers/iio/light/apds9960.c             |  3 ++-
 drivers/iio/light/max44000.c             | 23 ++++++++++++-----------
 drivers/iio/temperature/mlx90632.c       |  3 ++-
 drivers/input/touchscreen/tsc200x-core.c |  3 ++-
 drivers/mfd/altera-a10sr.c               |  3 ++-
 drivers/mfd/da9052-spi.c                 |  3 ++-
 drivers/mfd/mc13xxx-spi.c                |  3 ++-
 drivers/mfd/twl6040.c                    |  3 ++-
 drivers/regulator/ltc3589.c              |  3 ++-
 drivers/regulator/ltc3676.c              |  3 ++-
 include/linux/regmap.h                   | 12 ++++++++----
 sound/hda/hdac_regmap.c                  |  3 ++-
 sound/soc/codecs/cs35l33.c               |  3 ++-
 sound/soc/codecs/cs35l35.c               |  3 ++-
 sound/soc/codecs/cs43130.c               |  4 +++-
 sound/soc/codecs/es8328.c                |  3 ++-
 sound/soc/codecs/rt1305.c                |  3 ++-
 sound/soc/codecs/rt5514.c                |  3 ++-
 sound/soc/codecs/rt5616.c                |  3 ++-
 sound/soc/codecs/rt5640.c                |  3 ++-
 sound/soc/codecs/rt5645.c                |  9 ++++++---
 sound/soc/codecs/rt5651.c                |  3 ++-
 sound/soc/codecs/rt5660.c                |  3 ++-
 sound/soc/codecs/rt5663.c                |  9 ++++++---
 sound/soc/codecs/rt5665.c                |  3 ++-
 sound/soc/codecs/rt5668.c                |  3 ++-
 sound/soc/codecs/rt5670.c                |  3 ++-
 sound/soc/codecs/rt5682.c                |  3 ++-
 35 files changed, 94 insertions(+), 53 deletions(-)

-- 
2.11.0

