Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77616C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2F20859
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfAFT2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:28:31 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:30519 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfAFT2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:28:31 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:143e:fcd5:beb7:2140])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 0550113F866;
        Sun,  6 Jan 2019 20:28:23 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 0/8] nvmem: Various small fixes and improvements
Date:   Sun,  6 Jan 2019 20:28:12 +0100
Message-Id: <20190106192820.12558-1-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series is mostly small bug fixes, but also add a new API
to make things simpler in drivers that need to request an optional cell.

Alban Bedel (8):
  nvmem: core: Set the provider read-only when no write callback is
    given
  nvmem: core: Fix of_nvmem_cell_get() for optional cells
  nvmem: Add nvmem_cell_get_optional and devm_nvmem_cell_get_optional
  nvmem: core: Fix cell lookup when no cell is found
  nvmem: core: Properly handle connection ID in of_nvmem_device_get()
  nvmem: core: Always reference the device returned by
    nvmem_device_get()
  nvmem: core: Fix device reference leak
  nvmem: core: Avoid useless iterations in nvmem_cell_get_from_lookup()

 drivers/nvmem/core.c           | 86 +++++++++++++++++++++++++++-------
 include/linux/nvmem-consumer.h | 16 +++++++
 2 files changed, 86 insertions(+), 16 deletions(-)

-- 
2.19.1

