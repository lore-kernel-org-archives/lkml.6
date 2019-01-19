Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F8C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B912087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kSIYbvco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfASSVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:21:52 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:35046 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfASSVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k0OcdfncXzC48wa+LP3J6wVq9A0pTP+yp9J4ByEttWc=; b=kSIYbvco2ykmFIwGfUQmKxEDEv
        2rQwhxohxk0Ep7/3ExOjlRLUt6Kl4h1LS+p4ApOApaFQxgAUQ/ZkbhVihGgLbgF40OK6mo8xEJDFZ
        sh7SIdSZfwUKmC3hkMGZfxY9VH1gpY6pY4wGlZaq0Z6lfp7NN42YtQ2pXOI6oeKYOTNc=;
Received: from p200300ccfbfb41001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbfb:4100:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkvFT-0002M5-9e; Sat, 19 Jan 2019 19:21:39 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkvFS-0002Sv-Mm; Sat, 19 Jan 2019 19:21:38 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] drm/omap: panel-tpo-td028ttec1: add backlight support
Date:   Sat, 19 Jan 2019 19:21:29 +0100
Message-Id: <20190119182131.9341-1-andreas@kemnade.info>
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

 .../bindings/display/panel/tpo,td028ttec1.txt          |  2 ++
 .../gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c    | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.11.0

