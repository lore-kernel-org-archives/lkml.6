Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D305ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE6920693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avwmAWh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE6920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbeGQVjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34538 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:38 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so996684plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sl98jh2Z/LCf8jUVhFp+AaksKoLbkamo5ep6Om73x9E=;
        b=avwmAWh1B+vgMk/fb9xe5gyyWZ+1IO4ckX8W6ozaEe+3eSvVPnF+Nqx3AK7haB6vCQ
         g+dX+IlQGmR0nikAxOisuwTKGeKMOX9LPiy7ZozsZHgnCrlTC4fSA3HnEv3WL3yzGamy
         fsOYKCljJWrIqXZyHCuW6WDdOu7USpn3Tqtc9fsGroIwKCNqXVj7UfgoyvZpLsYCmXwH
         +7Qw1Bx8laaH6NSJTahkXLmcED/4qRtNAkcZK/SoqyRRB5ogkSHs10m19VOv8TVq2iwM
         x2gW3/JCyLayNIqG7LVO2ZuI3RRAlMUxCHxnChtwxIzexWUluColkK/oTTL3w4en4fEA
         WGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sl98jh2Z/LCf8jUVhFp+AaksKoLbkamo5ep6Om73x9E=;
        b=QeCKPYoZGOz6uil7pHuN/nm1XGCMVwl87lBHHBkeq+fyBfeqq5UR6t2647mbXi4L/5
         yD5hzfFeZB31U7Rlo+shZMI3NsFuKRvy7f/1f5HUsSC41gAztgHTuWTDRP5sqEmvTf1I
         lUhZsbu+hOLyAFcNOVPG8xuO9ISxPLbueQrR1m4bEvf3Utf1RdDhOQGHoroUOZyavYoh
         APC3c4j7sL5D2ukpkXe6EvzR546if0pdbi17qVPfdC5Qw2hKNk0YtxekGbCJfHMe8LkQ
         imoUwCSBr8w504Ag+b3Jk9D8iAHh6v0gRHP8h5BuYazXHA5ZPGS4p+JFNAK9DXvRQMUo
         xYSQ==
X-Gm-Message-State: AOUpUlFjB5pUnVPhkJdCFXmn6xouMSCYidHasF/GCsjj+JyOb4SmlQ6B
        v+JkvUDgUs+I4tC5l248IpA=
X-Google-Smtp-Source: AAOMgpc0GyqgySCvxiFmyKBHSTLSxbHxvSdvf1HaOj5a4w3/8T715XsB6lfbG5gMDt+YgjCj62UIpQ==
X-Received: by 2002:a17:902:be07:: with SMTP id r7-v6mr3220872pls.124.1531861511144;
        Tue, 17 Jul 2018 14:05:11 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:10 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 20/32] staging: gasket: fix class create bug handling
Date:   Tue, 17 Jul 2018 13:57:00 -0700
Message-Id: <20180717205712.29495-21-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

class_create() never returns NULL, and this driver should never return
PTR_ERR(NULL) anyway.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 0a87bc67eac19..b7f34576d4b3f 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -322,7 +322,7 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
 	internal->class =
 		class_create(driver_desc->module, driver_desc->name);
 
-	if (IS_ERR_OR_NULL(internal->class)) {
+	if (IS_ERR(internal->class)) {
 		gasket_nodev_error("Cannot register %s class [ret=%ld]",
 				   driver_desc->name, PTR_ERR(internal->class));
 		ret = PTR_ERR(internal->class);
-- 
2.18.0.203.gfac676dfb9-goog

