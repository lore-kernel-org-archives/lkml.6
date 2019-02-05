Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2772081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PVWtoOLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfBEGip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:38:45 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:56050 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfBEGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UeDDj4+sC98fNB247nCslNa1w0CBFzWHfhDQgozFWVU=; b=PVWtoOLf/PXgGQ+ZnFNWu3xyMX
        D8pg1k42aIH0L5Rdqi879pn3/b1SSDu42/j2oeWdV2bupEzCb0f/ziREXowh5s+GfJVmZOr7cquzF
        70UBvLn/YTQuNHlKAk/e6FKYify/D9ZDzEKCqsFnc7fTimECfXFp6qnry05pDIyL6OUY=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gquND-0005AW-L5; Tue, 05 Feb 2019 07:38:23 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gquNC-0003sj-BH; Tue, 05 Feb 2019 07:38:22 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 0/2] drm/omap: panel-tpo-td028ttec1: add backlight support
Date:   Tue,  5 Feb 2019 07:38:11 +0100
Message-Id: <20190205063813.14873-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel has a backlight, so add a property describing that and
add the code to use that.
This makes things like xset dpms force off
also turn off the backlight, so we do not need to rely on additional
userspace programs to do that.

Andreas Kemnade (2):
  drm/omap: panel-tpo-td028ttec1: add backlight support
  dt-bindings: panel: td028ttec1: add backlight property

 .../devicetree/bindings/display/panel/tpo,td028ttec1.txt       |  2 ++
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

-- 
2.11.0

