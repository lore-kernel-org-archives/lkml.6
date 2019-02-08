Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478C1217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivtx6h+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfBHTxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:53:20 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38871 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:53:20 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so5352656qtb.5;
        Fri, 08 Feb 2019 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=m48btDFIA378+ayDeuzi7R/YAoo5Rj7FXo5HjH4KBS8=;
        b=Ivtx6h+7sn2iofCZbDUBboxs6tnu+lXvpmX9PqlTkNu+pddwkvBHWmgx9wm14ZrV0/
         XbQgrgFu9fmx/5vKy/4uMwjJQfHViGmlVgGOdF3NzMoBDrUOm0UENrG1ym/7w76lQG35
         rnoXXUBiJv9/QZKR06uDxs/IKYTdhFZmhRAFoiLyGAhuDT/giH1lXUGjPmI9fdBqBLm8
         Pwva5G37jElhLcg0WnL0yEByqN5vTBdVm+o8pEp2lWpVCioIeRJ+8wnRLxNE8PCuW02y
         5UDaMho9rqP8peFKOb3paBB2ibYJ96TNTCNvjvJPM/voPQFw//WHsU2PK7LxYqepZQOP
         xkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m48btDFIA378+ayDeuzi7R/YAoo5Rj7FXo5HjH4KBS8=;
        b=XSLBWXXMQunhEjkGrhG/WvNSPBJ3nlj0HsRQagsveGQDmT3/aY94N73kEmwIe4OqQQ
         MHYGMB9oTUKgLol0S04kj6lxdiG7gcmSsTxtmKzplHpepxQcAj0T+aN98JcRg0CDnBRe
         M9z6fbcvUFDreMlaDdmN2xo/yVReL1qcPJ/oUyihZAqVLZaI8mKG6m175qteIImMCmE4
         bFeAMKoT/NRczipVumzfd0kJs5V3APudjr64KryWzl5c/1QpNOfQekzQrsrBnzdYGOHL
         YsDI1LA5vRDuWv2jnZd+UjYVzUaMQaX7OVsjTvZEDQ107NWb/2IzSJYVtILjoBDbkIMi
         aIDw==
X-Gm-Message-State: AHQUAuadFlGeq4BPXKVsgLu6Lm5vkWkFbhCB/JsGAzmJVv7HIrRV5QkO
        V8uoS5KdSs2BPRenlNe5v5s=
X-Google-Smtp-Source: AHgI3IZ79d6So9aj8kA0Zpe6EjdjWKydCBy1b2r0IX9w0oX4kjyGyJeU4oK2wdvrH5oG3TT27zKuwg==
X-Received: by 2002:ad4:4085:: with SMTP id l5mr6853325qvp.122.1549655599265;
        Fri, 08 Feb 2019 11:53:19 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g3sm2275950qkm.44.2019.02.08.11.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 11:53:18 -0800 (PST)
Date:   Fri, 8 Feb 2019 17:53:12 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/doc: Remove solved KMS cleanup task
Message-ID: <20190208195312.aqv7acr3hgion5yz@smtp.gmail.com>
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

