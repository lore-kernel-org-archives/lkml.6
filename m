Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A4E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3Ou/Vhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A4E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391643AbeKWAk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:40:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38234 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbeKWAk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:40:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so9316390plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lcyTXcwG8IW93lclxLqw2h+G8hESlcBlbKfmLy6kdQs=;
        b=Z3Ou/VhiDkMKYrFzQ9FwUg08Wvz5Uf+fV7FdMDgpYMdjO+qtrVER6C4KZbE5UlB9Y3
         5ED7xV8LZG6t4k4WF45xLdFi/qVxdNXYDJh69XVT2P2v1nCLx6xQMTMWRJuSxNJSHL8b
         FEWt7mURK0dQj2mUtomzC8B0HXRvzn9CdMgJMh8dUsrs0Wb7U3gFHGkjGzhzouxGfW96
         8JjvBzAWNzRZTpgQ+nnN6DB+gVPwXcpGF8edDhsrWHlMlqlYFnxJdt2DAttwyD9HkUq0
         mBZxhyRZSHnGCWqgXObqNKlbQWTN7NW4C1mluo48zEZNKGlhXflVvuVq3JoYoJtEjWIR
         6qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lcyTXcwG8IW93lclxLqw2h+G8hESlcBlbKfmLy6kdQs=;
        b=HXCx2T86oybQiMoBzlnqheGvxVM2m16Ly2MGecVGCt3MpVDVvoUrJTcAMm+nAlePz8
         ir+QLHZ9BXSsLMNal6aeB+BANHFfvQERU80zFw1i2TQArMjWfQh9QVlseVaoaue2rwHV
         nnp4F9wuDNuqh8PcDLSq2BaoVxet90B/nDp1E4FMnarftMmHbmz3Oo0dtAu5vf5n7VSA
         plgkaIpUsahggROix+OdOr+YVo0YR3Ojz4LBOfzX7iAfBFTt9ExYyJZkxlQ5PluFrSuJ
         QKEAo2Xfa6kNv5qy2qs7EduemRBBTUdgPogbiVMj80/wZvsNKJvJ0KOme59X1yaBzE7Z
         gaiA==
X-Gm-Message-State: AA+aEWZuRhW7o9T6p1rv9tBWSlWcaKQiJXIaJnWpse2MbEj2HQOK5Ar4
        0c6CRjjEXmSAWS+8n84C8Ts=
X-Google-Smtp-Source: AFSGD/UkSW5niOZTh4WyzIwmTj1FjYJOoLVrJ1T6cxnPY7EJQRAvSB0dEVNuBruwze8FWu3jsq4+2Q==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr11476554pld.181.1542895290205;
        Thu, 22 Nov 2018 06:01:30 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([45.251.61.83])
        by smtp.gmail.com with ESMTPSA id m11sm39923623pgh.51.2018.11.22.06.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 06:01:29 -0800 (PST)
Date:   Thu, 22 Nov 2018 19:31:26 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, Tony.Cheng@amd.com,
        Bhawanpreet.Lakha@amd.com, David.Francis@amd.com,
        hersenxs.wu@amd.com
Cc:     jrdr.linux@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: [PATCH] drm/amd/display: Remove duplicate header
Message-ID: <20181122140126.GA3124@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dce/dce_mem_input.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index d68f951f9869..c41408c3eaf1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -40,7 +40,6 @@
 #include "dce/dce_mem_input.h"
 #include "dce/dce_link_encoder.h"
 #include "dce/dce_stream_encoder.h"
-#include "dce/dce_mem_input.h"
 #include "dce/dce_ipp.h"
 #include "dce/dce_transform.h"
 #include "dce/dce_opp.h"
-- 
2.17.1

