Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D00C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821922083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RDz9gGqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821922083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeHaWVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:21:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46804 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeHaWVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:21:43 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 679CDB8E;
        Fri, 31 Aug 2018 20:13:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535739182;
        bh=nMU57z1ORa9uCNKQVVC/4vfJC3Hk4qVoYc6qDeGZleU=;
        h=From:To:Cc:Subject:Date:From;
        b=RDz9gGqc0RlKPwerxVSb7Cilqbe+fCG4HA4GV31OKn7iRsDPWjqSueJmCjtf2YyZo
         tTeYg3U9BpLL0ZqH7M3tPeJctxOLECJXbJbY/w33KoX9HTwqAP7aSEE/mpIBn0s3AO
         i3sxyhk+v77WJ7CbqyxuCVN2JsF0tU1TpLW+WbPs=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 0/3] drm: rcar-du: Update DU support
Date:   Fri, 31 Aug 2018 19:12:56 +0100
Message-Id: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 patches to remove current limitations in the DU.
Image formats that the hardware is capable of were not listed in the
driver, and are added by Koji Masuoka.

Frame sizes on Gen3 platforms were artificially limited to the Gen2
framesizes, and so this has been lifted to support larger displays such
as 4K outputs.

Finally restrictions on the framebuffer strides and alignments are
lifted due to the greater flexibility of the VSP.

Kieran Bingham (1):
  drm: rcar-du: Update Gen3 output limitations

Koji Matsuoka (1):
  drm: rcar-du: Add pixel format support

Laurent Pinchart (1):
  drm: rcar-du: Update framebuffer pitch and alignment limits for Gen3

 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 81 ++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 14 deletions(-)

-- 
2.17.1

