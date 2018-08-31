Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB7920837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sy7zrQ5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB7920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeHaSsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:48:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44510 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeHaSsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:48:38 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DEE5AB8E;
        Fri, 31 Aug 2018 16:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535726449;
        bh=pjMOkiBJJjCDlI41fdhhm5Tv9YrQnb4feRHnZF2SD0I=;
        h=From:To:Cc:Subject:Date:From;
        b=sy7zrQ5SQj0sIF1HCTkeXJmYbBkwmgjfkd1xqzpMri6zKUHzE/q44EeJ5BHTh6JxL
         RGrn4EVfoqZijNaqndn5X6E7+DFvjARbjOPJwae7RwW/Rq2r2ovD7b03VeYmeqGrAE
         cQ9QX8gDeYbMCuktbQ3artiq+3Ii/yL86gUzryN8=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 0/6] VSP1 Updates
Date:   Fri, 31 Aug 2018 15:40:38 +0100
Message-Id: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An assorted selection of fixes and updates for the VSP1 to improve code
quality and remove incorrect limitations.

The SRU and UDS are capable of larger partitions, as part of the
partition algorithm - but we only document this support for now, as
updating it should be done in consideration with the overlap and phase
corrections necessary.

Kieran Bingham (6):
  media: vsp1: Remove artificial pixel limitation
  media: vsp1: Correct the pitch on multiplanar formats
  media: vsp1: Implement partition algorithm restrictions
  media: vsp1: Document max_width restriction on SRU
  media: vsp1: Document max_width restriction on UDS
  media: vsp1: use periods at the end of comment sentences

 drivers/media/platform/vsp1/vsp1_brx.c    |  4 +--
 drivers/media/platform/vsp1/vsp1_drm.c    | 10 ++++++
 drivers/media/platform/vsp1/vsp1_drv.c    |  6 ++--
 drivers/media/platform/vsp1/vsp1_entity.c |  2 +-
 drivers/media/platform/vsp1/vsp1_rpf.c    |  4 +--
 drivers/media/platform/vsp1/vsp1_sru.c    | 13 ++++++--
 drivers/media/platform/vsp1/vsp1_sru.h    |  1 +
 drivers/media/platform/vsp1/vsp1_uds.c    | 14 +++++++--
 drivers/media/platform/vsp1/vsp1_video.c  | 38 ++++++++++++++++++-----
 drivers/media/platform/vsp1/vsp1_wpf.c    |  2 +-
 include/media/vsp1.h                      |  2 +-
 11 files changed, 73 insertions(+), 23 deletions(-)

-- 
2.17.1

