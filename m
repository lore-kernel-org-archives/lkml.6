Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98261C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A1320843
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A1320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeIYEto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:49:44 -0400
Received: from muru.com ([72.249.23.125]:57070 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeIYEto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:49:44 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CE75380BF;
        Mon, 24 Sep 2018 22:49:22 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] TI sysc driver updates for am335x and am437x
Date:   Mon, 24 Sep 2018 15:44:41 -0700
Message-Id: <20180924224445.97239-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are few updates for ti-sysc driver for am335x and am437x. I'll be
posting the related dts changes separately.

Based on testing with various devices, we can now also get rid of the
quirk flag for SYSC_QUIRK_RESOURCE_PROVIDER and make module names limited
to debug only except for few devices still using pm_runtime_irq_safe().

Regards,

Tony

Tony Lindgren (4):
  bus: ti-sysc: Defer suspend as needed
  bus: ti-sysc: Update revision masks to support am437x
  bus: ti-sysc: Detect more devices on am473x for debugging
  bus: ti-sysc: Detect devices on am335x when DEBUG is enabled

 drivers/bus/ti-sysc.c                 | 143 +++++++++++++++-----------
 include/linux/platform_data/ti-sysc.h |   1 -
 2 files changed, 85 insertions(+), 59 deletions(-)

-- 
2.19.0
