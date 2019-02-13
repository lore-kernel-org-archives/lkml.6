Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C288C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A29820700
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSZGh9rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392517AbfBMQNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:13:25 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40152 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392481AbfBMQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:13:24 -0500
Received: by mail-wm1-f47.google.com with SMTP id q21so3020186wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lIWWoez3wtwu40qsq7ScX6E/uuw/MJvh6CXR6TUM7dY=;
        b=RSZGh9rrW0OkwPQs6ZHNdbUhYdNeBBLoZqmy1JQYbhwkxBdAJ0nwC4rek6VAPMCW9t
         +iXLKzC56RnJxO+8ckzo/yQ3tMh4h6IvFagxluG3EoUI1u53DG4WD1MhazQZpx5il67y
         ziBnwBfFajURIpng23M3lsIQuYxGhr01czGwXWYcqMqSKpQVb7LpkolqDsMh4TuJeRIx
         B1by3xj95xaNA4z5DZ2F+xL+15W6apxQoszhQ9rszeH8tKWHERBsX4J3LPoYJWNeNN0m
         dDMTIAh/p5Ejtb8MT8qlPfxGUIthZNNy/7PHnfGgJVAfSJWecbTs0uUmyvcBWH5e7api
         auKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lIWWoez3wtwu40qsq7ScX6E/uuw/MJvh6CXR6TUM7dY=;
        b=gTGaJrpklPvcuN952lO+YTZpkXtmQ0duLlqux3MM+G16mfOBVGWTpD8xY8sePUe/nj
         6moUAlOlOLN3fltBkEsBO2IEGhgsTlcJfX9F5mNjbovuEpY13Z/EirjWAT/cGSE4Pckx
         j8F0EAvPZwRStIw5zqyZ8xRx4GwVshpnxQ7tj2ab7cHWOqj31/oCzUcxm1/ru/+u7QXC
         +k/VwZz0v2rP0Iiq292I8QTbejz4aWfTMArHmjODxoPjcyxKy0MBASLwlNepXRRupn1w
         Di55JvTFrxJ0q88KLtOrsoFsyJhHrCrZxg/s2nnPhLvwDX7bgVOmXSYcvHP0DWF8PH9c
         VaJg==
X-Gm-Message-State: AHQUAuaoeq13sCyrsyXeSgH9/jjLf5MySk3B7FVp0koxGu7DP1EJSbbL
        +Gj/35+nylUH1RSDPerhGemJxvsoyl0=
X-Google-Smtp-Source: AHgI3IZUavB1RBBF4LFqd7BygDb50ZZapHn6EAVpt7xVRjYKFiMgkahiDpSMdrFCGdhVUw/DkoHf4w==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr872708wme.119.1550074402511;
        Wed, 13 Feb 2019 08:13:22 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id f134sm6007950wme.31.2019.02.13.08.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 08:13:21 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     bbrezillon@kernel.org, jgg@ziepe.ca, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH] .mailmap: Add Mathieu Othacehe
Date:   Wed, 13 Feb 2019 17:12:49 +0100
Message-Id: <20190213161249.17155-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some contributions appears as Mathieu Othacehe and other as Mathieu
OTHACEHE.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ea98fcc197e4..37e1847c7988 100644
--- a/.mailmap
+++ b/.mailmap
@@ -123,6 +123,7 @@ Mark Brown <broonie@sirena.org.uk>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
+Mathieu Othacehe <m.othacehe@gmail.com>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
 Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>
-- 
2.17.1

