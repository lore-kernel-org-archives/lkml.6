Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FC9ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCA52086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XamnmrYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCA52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJ0ECk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:02:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34004 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJ0ECk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:02:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id z2-v6so2543952qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hCzofeQ0bxOb9JH+yn6Hps680QgMg5RDZ0Eg84Xgy8k=;
        b=XamnmrYGwDIsjzdsvUjKhUltvKqjRdvbLCnw93m0v+KYMJAD786RzrU5c+zJ2fPHz5
         b/lLC7uuTjh8Xjqd70Q+A4UO+hdyWZRhA/djRZ0qLe/vyAwup0Ou0tqCVi675ViSIGed
         upPGQEfZBJTewOxhXjXsFdEb5p4IwSYWdQGjSl72dQ6l4dfYECQUEQjCs0H5ooJ9lzkh
         TxF36w6S/e6k5RKOGIpxSx6gxlNUsJEJEX21eZ1LgwrzlkkLkTnHD3xsDarXqQDSPaYH
         9F6dRwcCfAvViddG7b/5oE1OTCeKmz7afe8eF6H4weKpEb/irVIYW5NO3ZxZshAKMjfU
         t1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hCzofeQ0bxOb9JH+yn6Hps680QgMg5RDZ0Eg84Xgy8k=;
        b=VnVktl1UEXrI7qfdYKsu+o98ezhQalOl6PbU0xHViaQ6qsaEky2dLio7HArKvyVbtY
         ANDbJsSiZ5/yT3UrHsUcEfUrwJWUpeVL7L/ro1RXEUpt2ab+ci2GnpFDPcvxdeyf2f5o
         74YzhuYNm/ATtNFN2dZXJEuYYjgtG2b5OjFig0BT/HCGfwJgpOYF+77HKbDgMbJhx1Dc
         4RGLUdUSQ8HZXxf7vOB4SpD3uxGQ1zReMdJ/+AGhCXSGrvH+dGKcxrhIPFfH/aXy2Oni
         NS6Wuc9ZCc2TNEkc7wBGqnGF30t7gnj/GBaPJAmp2HdoPc0xiIsxdOUC1q8ov4aWG41f
         dvWA==
X-Gm-Message-State: AGRZ1gL3z2IfJNnXkbJdqPfQLIMmkCaUZZb2MYi7VNKmlebzdxheho2n
        DP1VkAV/ND0YI386NaCsn7S37Gt8HIw=
X-Google-Smtp-Source: AJdET5cA77NvhwmDWBKQL+YVXhgOjk7yrmNKulc0yDgRbA8J84aDkx5uxD5I91GXXaHlbsex1vc2XA==
X-Received: by 2002:a0c:948e:: with SMTP id j14mr4501328qvj.155.1540581863311;
        Fri, 26 Oct 2018 12:24:23 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y144-v6sm4080661qka.7.2018.10.26.12.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:24:22 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:24:18 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 5/6] drm/qxl: Add space before open parentheses
Message-ID: <1ab3ba05c140aae01bde66f73ff1f3b78bf7dfb3.1540579956.git.shayenneluzmoura@gmail.com>
References: <cover.1540579956.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540579956.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space to remove checkpath.pl error:

ERROR: space required before the open parenthesis '('

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 5b00e0f26de1..2ce9a8dcec84 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -940,8 +940,8 @@ static enum drm_mode_status qxl_conn_mode_valid(struct drm_connector *connector,
 	/* TODO: is this called for user defined modes? (xrandr --add-mode)
 	 * TODO: check that the mode fits in the framebuffer */
 
-	if(qdev->monitors_config_width == mode->hdisplay &&
-	   qdev->monitors_config_height == mode->vdisplay)
+	if (qdev->monitors_config_width == mode->hdisplay &&
+	    qdev->monitors_config_height == mode->vdisplay)
 		return MODE_OK;
 
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
-- 
2.19.1

