Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B8EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A82C243F8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A82C243F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933630AbeFVOt7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:49:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54314 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeFVOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:49:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CD0DD288EC5
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/2] Avoid firmware warning in imx-sdma
Date:   Fri, 22 Jun 2018 16:49:49 +0200
Message-Id: <20180622144951.17464-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Avoid firmware warning in imx-sdma

Hi,

I grabbed the first patch from patchwork from an 2017 patch series. As far as I
could see, their usecase vanished due to switching to sync FW API (that already
supports NOWARN). This series fixes a kernel warning in imx-sdma driver, which
works fine with ROM firmware (and already prints an info message about ROM
firmware being used due to missing firmware file). This has been tested on
arch/arm/boot/dts/imx53-ppd.dts.

-- Sebastian

Rafał Miłecki (1):
  firmware: add more flexible request_firmware_async function

Sebastian Reichel (1):
  dmaengine: imx-sdma: request firmware with FW_OPT_NO_WARN

 drivers/base/firmware_loader/main.c | 41 ++++++++++++++++++++++++-----
 drivers/dma/imx-sdma.c              |  8 +++---
 include/linux/firmware.h            | 20 ++++++++++++++
 3 files changed, 59 insertions(+), 10 deletions(-)

-- 
2.17.1

