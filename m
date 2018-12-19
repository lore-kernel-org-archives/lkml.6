Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D93C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894602133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeLSNLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:11:40 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:49817 "EHLO
        mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeLSNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:11:36 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
        by mail.lysator.liu.se (Postfix) with ESMTP id 3A5E94001C;
        Wed, 19 Dec 2018 14:04:57 +0100 (CET)
Received: from orc.pedanet (c-17f4e255.26241707-0-68616c6d7374616473746164736e6174.bbcust.telenor.se [85.226.244.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lysator.liu.se (Postfix) with ESMTPSA id D491E40005;
        Wed, 19 Dec 2018 14:04:55 +0100 (CET)
From:   Peter Rosin <peda@lysator.liu.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] drm/bridge: various small lvds-encoder things
Date:   Wed, 19 Dec 2018 14:04:46 +0100
Message-Id: <20181219130449.31641-1-peda@lysator.liu.se>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Hi!

I'm not sure if I should have added the texas chips to the lvds_encoder_match
list in the driver, right next to the thine,thc63lvdm83d entry, but ended
up not doing that. That can always be added later, it needed...

Changes since v1:
- fork out the bindings for the texas chips into their own file in order
  to avoid clutter in the generic lvds-transmitter binding.
- added a patch to remove some surplus stuff in the generic lvds-transmitter
  binding.

Cheers,
Peter

Peter Rosin (3):
  dt-bindings: display: bridge: fork out ti,ds90c185 from
    lvds-transmitter
  dt-bindings: display: bridge: lvds-transmitter: cleanup example
  drm/bridge: add pwdn-gpios support to the lvds-encoder

 .../bindings/display/bridge/lvds-transmitter.txt   | 10 +---
 .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/lvds-encoder.c              | 34 +++++++++++++
 3 files changed, 90 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt

-- 
2.11.0

