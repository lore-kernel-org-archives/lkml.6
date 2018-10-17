Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D5BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB3E20645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgvNJzIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB3E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJRFaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:30:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43614 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeJRFaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:30:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so31302906wrt.10;
        Wed, 17 Oct 2018 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0xCAw4f+vtZqMzAQHPtQyZCIPaPnxXCe8PejRsciDGA=;
        b=fgvNJzIR54IExs2Q6ixhKdrVL6HGzb04VWNOGkPbeXkeaW7BOBwSM8eluDdoseRMcz
         oZd8bTd06PG0r72zn56OSP6jtGMO283VVKqbmBKkxzEgVg8UghyTnQ6WBrryOPVp5NDL
         i3vlggn1OFyw9G+/P7zC4sGy49W+PPGDzxhZds9ADANAE/QS4kc+L7FYx4njxp+dZQRw
         dhVirz4NC9MBWR6EwWZVGst9wJNHiG98Ze1qLZbSBfjDEG0wYlOjCMN86xtSjO1pbf/P
         Wl5zYk9GNWhDDqi9DIPLW46evtcZ+ph535y+wxZkjJnjD3gmzQpkvz8l7OaUSBEYJkAB
         2WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0xCAw4f+vtZqMzAQHPtQyZCIPaPnxXCe8PejRsciDGA=;
        b=o+NqQbZDZE/V9XwGAUHGQMZ1RpAMnFMckT/6EVjHdhYHqPY1uR7faU2efZJ30jFQzE
         CvPYl8g/nbs0P33mxNhp6aJrKE+nZeF6tjJYspJV8nw+EvrRoFP4M6Ztd6ervhwdtBea
         HPvQwszxjW8tdc++tRW7k2NnLtaNJKprrDtXEt+vYnwO5E1W6VZdMZC59WUvHn50dYNn
         cZ7fIOAQjTIfIPONtxMu7bDn15wvobIhj3i8uc5fi4c9CHj/ujAOKJa7xfqx2npt4PnA
         2cJyZBzd6ZxTM+3lZTW9CfEHbr8v9qKje/P7Bxd3rW5FL7mnAc2QFoWvm2qOWM/e/Ftj
         1psQ==
X-Gm-Message-State: ABuFfojGHcvygRXqxZG69c2zzVUzN14b4KcE/gvQ6hPFTQFwVcDKwygd
        lG1Ui7hxYxVRS2AuVNIT/gs=
X-Google-Smtp-Source: ACcGV63bFjEJKNw1yw+j1vxXHxl/5dlxKqQ6sO8XrpeFMTKjAh6lWHBFANLylnkuaq4PfQewOrlPHQ==
X-Received: by 2002:adf:e28d:: with SMTP id v13-v6mr24568592wri.139.1539811956987;
        Wed, 17 Oct 2018 14:32:36 -0700 (PDT)
Received: from localhost.localdomain (164-235-243-213.terrecablate.net. [213.243.235.164])
        by smtp.gmail.com with ESMTPSA id 4-v6sm3623962wmt.16.2018.10.17.14.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 14:32:35 -0700 (PDT)
From:   ektor5 <ek5.chimenti@gmail.com>
Cc:     hverkuil@xs4all.nl, luca.pisani@udoo.org, jose.abreu@synopsys.com,
        sean@mess.org, sakari.ailus@linux.intel.com,
        ektor5 <ek5.chimenti@gmail.com>, jacopo@jmondi.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 0/2] Add SECO Boards CEC device driver
Date:   Wed, 17 Oct 2018 23:31:40 +0200
Message-Id: <cover.1539807092.git.ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches aims to add CEC functionalities to SECO
devices, in particular UDOO X86.

The communication is achieved via Braswell SMBus (i2c-i801) to the
onboard STM32 microcontroller that handles the CEC signals. The driver
use direct access to the PCI addresses, due to the limitations of the
specific driver in presence of ACPI calls.

The basic functionalities are tested with success with cec-ctl and
cec-compliance.

v3:
 - Refactored rx/tx for loops
 - Removed more debug prints
 - Sorted headers 

v2:
 - Removed useless debug prints
 - Added DMI && PCI to dependences
 - Removed useless ifdefs
 - Renamed all irda references to ir
 - Fixed SPDX clause
 - Several style fixes


Ettore Chimenti (2):
  media: add SECO cec driver
  seco-cec: add Consumer-IR support

 MAINTAINERS                                |   6 +
 drivers/media/platform/Kconfig             |  22 +
 drivers/media/platform/Makefile            |   2 +
 drivers/media/platform/seco-cec/Makefile   |   1 +
 drivers/media/platform/seco-cec/seco-cec.c | 822 +++++++++++++++++++++
 drivers/media/platform/seco-cec/seco-cec.h | 141 ++++
 6 files changed, 994 insertions(+)
 create mode 100644 drivers/media/platform/seco-cec/Makefile
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.c
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.h

-- 
2.18.0

