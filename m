Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F70C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADA521581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="G64sPQ5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADA521581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHTTRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:17:02 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45576 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeHTTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:17:02 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE64BCD;
        Mon, 20 Aug 2018 18:00:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534780849;
        bh=8h/PvtsGaGzMTLofYwrn+TPbir8N/u5LUftFJJhDo2U=;
        h=From:To:Cc:Subject:Date:From;
        b=G64sPQ5OaCAb5X+0gS6UPLD/u5SmDkwPXZip7lChZRPz8aQhgaziKyU5KqVfL4NUx
         LHql9QeIQ1EO2rDLHX1qdyWPuTdBrxjb1oRu2wYAwp+UA60Kf8yfirJpNC7XRR1hM/
         Tej5BMz6BDx4/tF4XHc+SS5OzNOwsH+D+WhKLsy4=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 0/2] drm: rcar-du: Add interlaced feature support flag
Date:   Mon, 20 Aug 2018 17:00:42 +0100
Message-Id: <20180820160044.15783-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R-Car DU on the D3 and E3 does not support interlaced pipelines,
thus we need to have a means to reject interlaced configurations on
those platoforms.

Provide a new feature flag, and add that flag to all existing devices
which currently support interlaced pipelines.

When D3 and E3 support is added, this feature flag shall be ommited.



Kieran Bingham (2):
  drm: rcar-du: Refactor Feature and Quirk definitions
  drm: rcar-du: Add interlaced feature flag

 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 14 +++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c  | 32 +++++++++++++++++---------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h  |  9 ++++----
 3 files changed, 40 insertions(+), 15 deletions(-)

-- 
2.17.1

