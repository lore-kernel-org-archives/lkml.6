Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B42C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A735E2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJmU4cXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A735E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeLMWzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:55:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33270 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeLMWzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:55:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so4237990qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FlmgjsOljKHoCliMfpygHF2ImS5ElP2rgSghsY1VUG4=;
        b=WJmU4cXa0SW769aIk9PD188enT2/HNUcJX2GpnuZiILCQOlhh4g1qR1PqNmjn4vd+b
         mvxokEgskfZpD7IbSwnBWmmVfjxtu07gyNv4LjVfNDIOEDH4HrUQ4WHRnofcSGmFr5rZ
         t6P0U3EphYSWspgpBthiTCUX5cPnm6kKZIxLW00O8QlEU5IgKGmGE4Bf+YtwZBfnNyxe
         ndqjWBZY2e3I2TP4YVMQJtBX1chDyEtSzUt35qDHLPXtvv20YMjop4hyKsHq+JEKjk2F
         RrVCo7Hq5n6lv/E1q7NbF4wgO/Bo5XoeyIglFgp1Kr8lTYDJ87nOf0hKXA/KHKqGEzBe
         bNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FlmgjsOljKHoCliMfpygHF2ImS5ElP2rgSghsY1VUG4=;
        b=ACyBoW46iCPZFugTEX552h3J7gs5+uJ2g/UglFj9CdBRD4ijAqkb08iVNH7/nvBgnB
         6+OjHYeCQbaNyInTih9eJtu12Y7YGSdDEk43dPIzWgvD8Ad5QZMXBm5avTef3hSwJEKZ
         ERHvoJvqjLJZupijCIwHK5+gxUX6bXhkyAiI+fibHe/bt1YkvcMFcjEhcI+mCzqqHI7H
         rgi8f8U7q9W78xRk6OAXF4nSVejizujnuIHiwFwirj4mrAmnROWePz5q4xrr7CwnF3LX
         RcR9mcZCcZN8Q+LrGJUkFyXJQ5vLG3/rr3ss4lxSJGgg8JY3zb55FrcmNdIDecg/1bwr
         lgJw==
X-Gm-Message-State: AA+aEWYnumvr14k+RtCJLULTvHpc/Vh4nLUmgqoAprTvC5vYnLqkAn+K
        jr/A1wNVvRRGhW4nVUYf0McdMueufG3LSA==
X-Google-Smtp-Source: AFSGD/UYc9w9on/fzXrwe5ph08L+4OmYrPOF+oA1b0IycfYamFuwBBl733Ly8OjLvuqdkOkZG8VCxg==
X-Received: by 2002:a0c:9144:: with SMTP id q62mr643242qvq.87.1544741743495;
        Thu, 13 Dec 2018 14:55:43 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m68sm1723068qte.49.2018.12.13.14.55.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 14:55:42 -0800 (PST)
Date:   Thu, 13 Dec 2018 20:55:37 -0200
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] drm: Remove complete task from TODO documentation
Message-ID: <20181213225537.nq4dwidn6tma33iv@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove the follow complete task from TODO documentation:

  drm_mode_config.crtc_idr is misnamed, since it contains all KMS object.
  Should be renamed to drm_mode_config.object_idr.

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 Documentation/gpu/todo.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 14191b64446d..41da7b06195c 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -354,9 +354,6 @@ KMS cleanups
 
 Some of these date from the very introduction of KMS in 2008 ...
 
-- drm_mode_config.crtc_idr is misnamed, since it contains all KMS object. Should
-  be renamed to drm_mode_config.object_idr.
-
 - drm_display_mode doesn't need to be derived from drm_mode_object. That's
   leftovers from older (never merged into upstream) KMS designs where modes
   where set using their ID, including support to add/remove modes.
-- 
2.19.2

