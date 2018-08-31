Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395FEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF4620835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmOw8PSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF4620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeIADjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:39:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42480 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIADjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:39:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so6097961plq.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uBFxD8pops8pi4gwPJiNAHc0Bfzv+JaixYIlqqPJPnU=;
        b=UmOw8PSosAFNExEkz1dAmElpEYfdt2udwG3IAEB+cvyaMKPG8V4+jdLcMY1cd842W5
         9cSkZe/6bC1k3bDKzfneqbjQfKJK3hgLQXSwC9tDKd2Piw+9WKodBAVBNzdIrtAEye9I
         8tMjt1lWOmKo3QrBIS8ip5bv77UTaTnaEF0uo8Jqg/b0DqqSxbglg4NlJacXWoOMQpNM
         1uRtAYio/rvmzelLVhYmE7Koh6K0ANulqVGnEt9bjwH/XNVrYUT6QOgZLFIA9qBJyfXB
         5R5DPq1lQQZWayKCsi44Mol7SDxrfYDW7uLIDXi/J0XBacDcM5H/tQEgRQ06t8DD39hT
         orgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uBFxD8pops8pi4gwPJiNAHc0Bfzv+JaixYIlqqPJPnU=;
        b=jrNNdlB1LsRthhTSUFAaDjxwN5xHul5nVgNKb75YqN44oGSOyn9qSdoxg0eaQ7qxL1
         Sri4HFukRvi1ULZri32VcBg5iHX/kuQKnwEWUZw/hTzQxYHCIeESp6AMcXE4zboIVFHw
         0WQ+JDteFt3DmOY+lqJrSpQsFeJ22qGnuV3eF7zMbvD1JEFXNg0s65VNdd/sfMmZUnBr
         tIVb9W9cuGFIi1BmKXLt7trlwA8vE38Wmfzp4ChMi39bdVvE5+TDW693gyT/FfJ/uXi4
         u2IfNRTdBhokKFzBeeaQ5Nneq4iKKwWmQQhygywK+jo9qR8q3R6QU/SNDSNxDkBTG353
         /yiw==
X-Gm-Message-State: APzg51B6gPGy2Nco50sDn/GLVvxmTw4Ir1j5VPyIfZOsysJqVSCDNt19
        SfcSVkWYmmuAwifXx7Areb1iOjGQ
X-Google-Smtp-Source: ANB0Vda1f2VGeJtVLmn2P35rQVudhfS2AYIhuJM/wwivThT5K2S9245RFgU40YPIs/joyEUIkksV2w==
X-Received: by 2002:a17:902:1c5:: with SMTP id b63-v6mr18016219plb.82.1535758197998;
        Fri, 31 Aug 2018 16:29:57 -0700 (PDT)
Received: from dfrey-debian-linux.sierrawireless.local (carmd-fwm01.sierrawireless.com. [208.81.120.1])
        by smtp.gmail.com with ESMTPSA id o21-v6sm19462637pfa.54.2018.08.31.16.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:29:57 -0700 (PDT)
From:   David Frey <dpfrey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, David Frey <dpfrey@gmail.com>
Subject: [PATCH 0/3] regmap: split regmap_config.use_single_rw
Date:   Fri, 31 Aug 2018 16:33:30 -0700
Message-Id: <20180831233333.17223-1-dpfrey@gmail.com>
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

I submitted separate patches for the change that performs the split and
the update to all of the existing clients. I wasn't sure if this is the
preferred method or if it's better to combine those patches.


David Frey (3):
  regmap: fix comment for regmap.use_single_write
  regmap: split up regmap_config.use_single_rw
  regmap: update users of regmap_config.use_single_rw

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

