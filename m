Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4F4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA0D2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA7UAyXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA0D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeGNMRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:17:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36395 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeGNMRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:17:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so23700898lji.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 04:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0KFuPwyW39ysoD/KYqwgsSAMzWvlGurE+OqGn6h8LAo=;
        b=lA7UAyXmzTCKxAKr4jFY+/B5W25sZCu1+Wod9n+gWp7WnxQtCOBBC+KsYigCuORYe8
         Jy9FDngrVu8ONxVqAGF9aruVuB9ac/Kc1ubeQjNm6nhnmdH/mIqdiRsPkMVoSdymz5VP
         tHY+eY/LbyCiMtlv+SHi0AkQzDJm6H1HmfqIJ3ZT08G2hXVh/ldEeogqRnJbxvdIjaKg
         sHnfNIjS6gYoPdWrsi4Q4LhsYqSFrLn5vs0yhNjEQvs/HQYaSYdu4vKa6GSiPK4ITwvL
         fsf9o5MDCXstMWVzIKOegpJzYftu2ujogptTKvAd6nK3yBH6kjM5xby7fRIc8Nob2IlD
         2+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0KFuPwyW39ysoD/KYqwgsSAMzWvlGurE+OqGn6h8LAo=;
        b=mIcI+4AkvxiKxpok5SK3pnRDw4io83zXcBGgelqpScT+jWhPhK6bvYNhDppd0fwovd
         Ft5dlp4khvFIZdo7zv+R6yBwJlOm/r+XcqgRu+/Ro/rVWaPMxfPP/OO4AQd82x7dIGWL
         oVmLGNoCyncXg7MdYUruysPqwr4FRK/3HYRAx+ncJ4MhEpyh3A+k08yIG4I1IUgMqOPH
         e4Sh21YZmNV612RV6bvx7ssVn/cXtc5A1QOzZ8kNAz4NPmJGqBmw9mG6NycZRlVD3mOE
         7hrDECD7vcpe++J+qicdI3wciTnImG+j0s1SEZ9sxRFZpnYpJUfiPqaXQnpi62bbTRGg
         bX+Q==
X-Gm-Message-State: AOUpUlG+yv5gv8fmxZ12agJPv+5Qydnp161A7yAfJm7pcGmLxep9OGMb
        5LHPlkAhKB1dLCOH3xFQYho=
X-Google-Smtp-Source: AAOMgpf1lJCNceEdMQRdzTir6+rFdKw7kUhoO3vGtNB4yO/pVJV1h/+AMR8pxtSz4EX81TT3tuwgVg==
X-Received: by 2002:a2e:5519:: with SMTP id j25-v6mr5397426ljb.124.1531569536873;
        Sat, 14 Jul 2018 04:58:56 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id r64-v6sm7284222lff.90.2018.07.14.04.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 04:58:55 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 0/4] ntb: idt: Add hwmon temperature sensor interface
Date:   Sat, 14 Jul 2018 14:58:30 +0300
Message-Id: <20180714115834.3350-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT PCIe-switches are equipped with an embedded temperature sensor. It
works within the range [0; 127.5]C with a resolution of 0.5C. It can
be used to monitor the chip core temperature so to have prevent it from
possible overheating. It might be very topical for the chip, since it
gets heated like in hell especially if ASPM isn't enabled.

Other than the current sampled temperatur, the sensor interface exposes
history registors with lowest and highest measured temperature, thresholds
and alarm IRQs enabled/disable bits, ADC/filter settings. The device manual
states that the switch is able to generate a msi interrupt on PCIe upstreams
if the temperature crosses one of three configurable thresholds. But in
practice we discovered that the enable/disable threshold IRQs bits interface
is very broken (see the third patch commit message), so it can't be used
to create the hwmon alarm interface. As the result we had to remove the
already available temperature sensor IRQ handler and disable the corresponding
interrupt.

Current version of the driver provides following standard hwmon sysfs
files: temperature input, lowest and highest measured temperature
with possibility to reset the history, temperature offset. The rest of the
nodes can't be safely implemented for the chip due to the described issues.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Serge Semin (4):
  ntb: idt: Alter temperature read method
  ntb: idt: Add basic hwmon sysfs interface
  ntb: idt: Discard temperature sensor IRQ handler
  ntb: idt: Alter the driver info comments

 drivers/ntb/hw/idt/Kconfig      |   4 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c | 317 ++++++++++++++++++++++++++++++++++------
 drivers/ntb/hw/idt/ntb_hw_idt.h |  87 ++++++++++-
 3 files changed, 353 insertions(+), 55 deletions(-)

-- 
2.12.0

