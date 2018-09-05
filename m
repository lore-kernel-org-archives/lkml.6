Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48976C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59902086E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qnjbugl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59902086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeIEO1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:27:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41993 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbeIEO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so6936423wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1esYnT12DAU+a8ymd1+Yc6yh/+Mab4WiQa0qKqtIV+E=;
        b=qnjbugl7MMvhDYPxF/sEelqKaDMuic9dfK2P7ViI+r/OiUsOiXNKwI9rZbg1/tjsxL
         KB7EGR+5673Ci4tIjuWn2Ssr5BuATBmsFAv8pyZsiOGVhMiSoOxC9SmPiqQoH2DaAhic
         RAjeP0REzCufar081Hvo3oCWlOdo01IEVn2vwz/F/lpv/hOsNeTpIT6HXJAKxmZD9xIV
         wTqoqPXirfRxOR8XZ3L+G99ulIWHSuusdgcrqTWZcT06XfvqIdtocYVl/GPXtfL3IqUd
         I+t9dsh45rkSz7laEWBYIHW2vDJVV+oOt1GzZby/376yMRenhSfPp83gbd33myARh/TS
         ycpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1esYnT12DAU+a8ymd1+Yc6yh/+Mab4WiQa0qKqtIV+E=;
        b=IES5Xm2n8QZQvuDoLYH7Cca2a0VAvCb8gvpHXIs7zl7ZMCoGZcq9/GMlshJqfF0B55
         PleUj/2EMOe3S02vtoYIPLQ7dwZduz/7yvTMU7zgQJKw26LktHnRtX52KNjViqHClNNz
         sJ5EtiWUnYmH7Ql/2HD9UnDMtovK5R8tLREmFm9bDPFsXbHDMF1FV9cZmGEJKY9PSQrQ
         8YCUS+4C32T1qE91oAeHc4EFX3v32LMRBheWYX/6RITH9OPS5ac1sj6G3ryqaAUuUunN
         eR5eXHGi3WQH/fLekSqinGWh0yKqDjnQDpAzvqfWky7NUrPkpxVCpV4eVChuCSnkSRus
         /+qg==
X-Gm-Message-State: APzg51Dv4QVregqjFIrzbMdCKM4tru9T40SL4XB3Jkbvo+YWkBRj2e9+
        lKN/b65Ao7w8hN30/zG0RnD42Q==
X-Google-Smtp-Source: ANB0VdY7UKco99LyHRW27v7yYGThDDKfHNjeOSYUkhZKH2E38bIODrHKcE2jQ6P1sfR54fAwhS6aGA==
X-Received: by 2002:a5d:434c:: with SMTP id u12-v6mr26052105wrr.189.1536141483834;
        Wed, 05 Sep 2018 02:58:03 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-33-235.w90-86.abo.wanadoo.fr. [90.86.152.235])
        by smtp.gmail.com with ESMTPSA id l12-v6sm2127815wrv.29.2018.09.05.02.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:58:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
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
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/13] nvmem: rework of the subsystem for non-DT users
Date:   Wed,  5 Sep 2018 11:57:25 +0200
Message-Id: <20180905095738.26406-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series contains nvmem framework changes prerequisite for further
development of my previous series[1] that aims at removal of the
platform data struct from at24 EEPROM driver.

First we remove unused APIs and the global cell list. We then switch
to using kref instead of manual user counting. Next we simplify the
provider unregistration by removing the return value from
nvmem_unregister().

Next three patches improve the framework by adding a notifier chain
for future use and fixing the issue with nvmem device names.

Finally we add support for cell definitions, cell lookups and make
DT systems resolve the nvmem cells during provider's registration.

Last patch just uses the SPDX license identifiers.

Tested both DT and non-DT use cases.

[1] https://lkml.org/lkml/2018/8/10/149

Bartosz Golaszewski (13):
  nvmem: remove unused APIs
  nvmem: remove the global cell list
  nvmem: use kref
  nvmem: lpc18xx_eeprom: use devm_nvmem_register()
  nvmem: change the signature of nvmem_unregister()
  nvmem: provide nvmem_dev_name()
  nvmem: remove the name field from struct nvmem_device
  nvmem: add a notifier chain
  nvmem: add support for cell info
  nvmem: resolve cells from DT at registration time
  nvmem: add support for cell lookups from machine code
  Documentation: nvmem: document cell tables and lookup entries
  nvmem: use SPDX license identifiers

 Documentation/nvmem/nvmem.txt  |  30 ++
 MAINTAINERS                    |   1 +
 drivers/nvmem/core.c           | 650 ++++++++++++++++++---------------
 drivers/nvmem/lpc18xx_eeprom.c |   6 +-
 include/linux/nvmem-consumer.h |  50 ++-
 include/linux/nvmem-machine.h  |  56 +++
 include/linux/nvmem-provider.h |  22 +-
 7 files changed, 465 insertions(+), 350 deletions(-)
 create mode 100644 include/linux/nvmem-machine.h

-- 
2.18.0

