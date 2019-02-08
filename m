Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C9BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6074E2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIare5xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfBHPfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:35:45 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfBHPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:35:45 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so4359209qtj.1;
        Fri, 08 Feb 2019 07:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=m48btDFIA378+ayDeuzi7R/YAoo5Rj7FXo5HjH4KBS8=;
        b=kIare5xkTh2vQzCvkA8P/YZouylww1X9CqhJ0ENfKpHsnWhWxq/c/gP1An2IQJO2MN
         mNPjq8zhvxVY+MGb100NM0szULFSG6vmzimdCLRVr8SFLGdu4Q2Cdl/lTAl4WgeZuoAW
         Mu4WERwXmjWt3drH74SmZTEzl/mwFm+xIH3uN44WdMTjJK8zTms+kQLLoHET/NE4LOEG
         qtBI6BDulq4LGTndVjHgARpZBcQXeNaRAVyX5ISHgaseQsd0yQUHSkRY/o9vTdEnRkDo
         bzfhNY4SvWO4eTnLk92dykIo87vb8LzaydhfzhAH9oDzOCU897VLcEK4mvN6+DMHWjS3
         RuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m48btDFIA378+ayDeuzi7R/YAoo5Rj7FXo5HjH4KBS8=;
        b=d/0dBHJIH9+tv7+PgyRna1seH4BbS4FREVeXKwSZ/gT7RBtxPnGQ/9uQRHIuDZgO1V
         AaK4wcaqmOYDybccfoAZLRu71ZDjp61s0N6J/VD6ClIGyXoLTE76dyoSqEAX7dLKoQvM
         kYb2SUEqYA4wHQBk2XC+0WvwGFXTfQbnCLApPEUnzJOimKYv1VAgW+AmfRFp6z7epubR
         igl4ENS4aHZ5rg+/xlnYacGMpIAuvY0bdonE5TncOecWZ7Ae2UUwUlh6y3yDPeIG13QW
         aWKpaK0lvapbTrTBHZtTqyrTJCtCoCnHu3NEeDZxrylclhz4ThK6yDm+LNeP8SbkZPR5
         QrpQ==
X-Gm-Message-State: AHQUAuZ+PoB0A7NKj+PGuqDZp36ia26piJ7v4MZdxa6tgSYhgPkT7eWs
        Ob4NbsMVDk9cJJLvmZBxbQI+sNJ1
X-Google-Smtp-Source: AHgI3IbEyOBwTz3GeYdlEUh+mBy9Uf05fSese0e3g7o45/35Gb+Mg4cYc9bpxRcwNZqOPofmemGukQ==
X-Received: by 2002:ac8:2614:: with SMTP id u20mr17029810qtu.28.1549640143738;
        Fri, 08 Feb 2019 07:35:43 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m63sm2276897qkd.37.2019.02.08.07.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 07:35:43 -0800 (PST)
Date:   Fri, 8 Feb 2019 13:35:39 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/doc: Remove solved KMS cleanup task
Message-ID: <20190208153539.esik2dy7xvoi4p4e@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove KMS cleanup task from documentation solved by patchset
https://patchwork.freedesktop.org/series/54310/

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
---
 Documentation/gpu/todo.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index cda4a37a02f0..159a4aba49e6 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -398,10 +398,6 @@ KMS cleanups
 
 Some of these date from the very introduction of KMS in 2008 ...
 
-- drm_display_mode doesn't need to be derived from drm_mode_object. That's
-  leftovers from older (never merged into upstream) KMS designs where modes
-  where set using their ID, including support to add/remove modes.
-
 - Make ->funcs and ->helper_private vtables optional. There's a bunch of empty
   function tables in drivers, but before we can remove them we need to make sure
   that all the users in helpers and drivers do correctly check for a NULL
-- 
2.17.1

