Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6586FC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAFD20854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAFD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeIJABc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:01:32 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:44710 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbeIJABb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:01:31 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 6685FC0262;
        Sun,  9 Sep 2018 21:10:52 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id A668CC0FF8; Sun,  9 Sep 2018 21:10:50 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id E468BC0FE6;
        Sun,  9 Sep 2018 21:10:19 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 0/4] Follow-up patches for Cedrus v9
Date:   Sun,  9 Sep 2018 21:10:11 +0200
Message-Id: <20180909191015.20902-1-contact@paulk.fr>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This brings the requested modifications on top of version 9 of the
Cedrus VPU driver, that implements stateless video decoding using the
Request API.

Changes since v1:
* Added two more commits to fix build issues with non-sunxi configs.

In order to build correctly on non-sunxi platforms, the following commit
is also required to select the sunxi SRAM driver:
* drivers: soc: Allow building the sunxi driver without ARCH_SUNXI

Paul Kocialkowski (4):
  media: cedrus: Fix error reporting in request validation
  media: cedrus: Add TODO file with tasks to complete before unstaging
  media: cedrus: Wrap PHYS_PFN_OFFSET with ifdef and add dedicated
    comment
  media: cedrus: Select the sunxi SRAM driver in Kconfig

 drivers/staging/media/sunxi/cedrus/Kconfig     |  1 +
 drivers/staging/media/sunxi/cedrus/TODO        |  7 +++++++
 drivers/staging/media/sunxi/cedrus/cedrus.c    | 15 ++++++++++++---
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c |  5 +++++
 4 files changed, 25 insertions(+), 3 deletions(-)
 create mode 100644 drivers/staging/media/sunxi/cedrus/TODO

-- 
2.18.0

