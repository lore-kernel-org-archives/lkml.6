Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A6CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7759821908
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 13:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2Cua8uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbeLYNbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 08:31:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38562 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYNbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 08:31:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so6569247pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZKeHwrSJbrF+XsJG54byRwCmIaArjZGv5xnLymdyy2I=;
        b=s2Cua8uvF2n+oJheZrqkXVpvsQ1Z06/InB69IJoCjMc50KzHFcv+PfKTic9Amf9PPN
         B3evbgDHGYmBDX2ba49x33o2plIjKwi/OlyY9Y1t8zQHbrdaWVdSv+dIGhi5PT2uwBTN
         b1QQzi8dHyC6yJa78xWos6SuvGgGwLzzTG79qyjn2tNFbazXm3YBKykNHZcnLa2l/aLa
         RmY2HeO45dZyysAURk0tlYEcFuEkRouoe9eEPrl/sD6tibKoZjUye2w8+sFzGmcdD7ZC
         Im9VNnJVJKfMgbUQnzNGhywFh3BIlPyN7Wrsv1iqOC31CafDScmWKSu5bme7uFsxGxsW
         Dsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZKeHwrSJbrF+XsJG54byRwCmIaArjZGv5xnLymdyy2I=;
        b=P+WiqOgltJqL1v+aLLjf+lFQLZa7rcQLKHUgbeP5WDM/RSsvwtt1AG28OiPBf80X0Q
         p5WO8IvEBoGos0MxKxikMx5QCFmLmYLaNVrn0v9M0lBGDNbjQ5+RJ3DthSKwUt1xKry1
         OXgzfVdhvYec4V44j8LZul0zkvlFNrcAagTkxQL8mXEXZUAGBVZo6jIbwbuUQojy7WFr
         gRRw9i97WuZ1aT5kSWsWuBLSryXF0yPFtpPEWxdd0kVr/Hbyapp04pvRm1JZKfdqboOz
         X/Ams2wZn3VdXKjgzVOyWYezSAfkUQgd/Ep5Nlj7xefi5/OZW6YrlsT90MSyczmsEfRD
         zF+A==
X-Gm-Message-State: AA+aEWY4gXUD3/lWVBmy7rgmXRvNWCAgCPX6g1Zcec3FCe55EBbAsn1F
        tK6BK1oCAqBEVqIBT/2PEbk=
X-Google-Smtp-Source: ALg8bN548mnkQzJNU5ExlT1BcEhHx5v5J/HceqIWspUvQIG/AOQCBjWeYz6tYVMqmCCRwQlIx2IObw==
X-Received: by 2002:a62:6385:: with SMTP id x127mr16897178pfb.15.1545744663040;
        Tue, 25 Dec 2018 05:31:03 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:204:441f:8d5d:c539:b11b:afea:4db3])
        by smtp.gmail.com with ESMTPSA id o4sm55824869pgs.12.2018.12.25.05.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 05:31:02 -0800 (PST)
Date:   Tue, 25 Dec 2018 19:00:56 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/intel_dsi_vbt: Remove duplicate header
Message-ID: <20181225133055.GA2628@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove video/mipi_display.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/i915/intel_dsi_vbt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_dsi_vbt.c b/drivers/gpu/drm/i915/intel_dsi_vbt.c
index ac83d6b89ae0..40a5efa33c3d 100644
--- a/drivers/gpu/drm/i915/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/intel_dsi_vbt.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <video/mipi_display.h>
 #include <asm/intel-mid.h>
-#include <video/mipi_display.h>
 #include "i915_drv.h"
 #include "intel_drv.h"
 #include "intel_dsi.h"
-- 
2.17.1

