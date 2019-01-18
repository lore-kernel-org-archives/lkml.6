Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D85DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B042087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8MtC0E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfARO6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:58:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35741 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfARO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:58:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so6186323pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=ZjGlpyuS0Uri5GGlPmvG1//lE2s47YIfXvZ7nXYvZiM=;
        b=o8MtC0E33+KA52OPtP5YZI++WKnc+/r5K3Le0SIoebcy+7Mkc+im+lwJsFFhq7Dc2w
         8ig7C99f/PBWKkxLVEqF/k1v2UMYHAvVKXq8ouP0Mje/FtVGRbznwSoNKbvD8RmT2DpZ
         Gn+dRADMpYxb0cmp9NSPYp3GEO1eYkkGi2pIWS7zz1j+018K7S+QeohE/a6j8jk8WKUu
         RigL48l7toxpMRd5EYQoGtLj10b0VaBD887QR8fX87d/Rj0E0zYN8sxm/fOdhrOz/+Fu
         bkvbUAQYs8Y2gjwPcmbST7hCzjvlOKmuvZtcjKt7atFxW/RtISH1k3XC+yiN3Cmri+aI
         qouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=ZjGlpyuS0Uri5GGlPmvG1//lE2s47YIfXvZ7nXYvZiM=;
        b=kB+3vGOAc+wk5b/CPFYevwmnRwy8qc9nFHHiVhyl+V48TwkYwxYKs5Z2C/m+6e9CQV
         z3I4vvIxkAfDRE9kQJOFT5I1q2Gk3MGhDmBY6K+nyt1m3fc3WfD2mqfSE/u+6j4Vyt84
         4LIkZ497Rx0Ev6YNFi+abxPj2+nNrmiPfE7fNukwktPwwUDbaMVgvr9HgxaxKtcfZcXE
         vUGM9Qg2E+HLoP+ODUcqj3HHS97UE7BoOi4WID63PtuotVF2ilvFWG0pMvXg0UIIwn0a
         1O1oqTP+/zfXfmnO4UwHZhU0cLto6H1b0m3cCF4Y+SVNcuBLcux+McWQZxN+Y5r050oA
         xCXQ==
X-Gm-Message-State: AJcUukf6Id1bkeiJmWFCWMaDMTvSQL8l1W3bkuiqo2h64VDrQXUfVytg
        s9JQZyNTjHmInPQh0hdVKr0=
X-Google-Smtp-Source: ALg8bN5aw/K2sgdnRnR7TSHjTw4W/Fyd9jBAMzafITyrvHVmweIs4GL8pxBPLn0NYaT4GYDDjYtulQ==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr17464801pgo.223.1547823517068;
        Fri, 18 Jan 2019 06:58:37 -0800 (PST)
Received: from sabyasachi ([45.116.191.235])
        by smtp.gmail.com with ESMTPSA id 22sm8812959pgd.85.2019.01.18.06.58.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Jan 2019 06:58:35 -0800 (PST)
Message-ID: <5c41e99b.1c69fb81.f240b.506a@mx.google.com>
X-Google-Original-Message-ID: <20190118145831.GA8995@sabyasachi.linux@gmail.com>
Date:   Fri, 18 Jan 2019 20:28:31 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        yuehaibing@huawei.com
Cc:     jrdr.linux@gmail.com, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] um: Remove duplicate headers
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sys/socket.h and sys/uio.h which are included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/um/drivers/vector_user.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index d2c17dd..c863921 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -23,7 +23,6 @@
 #include <netinet/ether.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
-#include <sys/socket.h>
 #include <sys/wait.h>
 #include <sys/uio.h>
 #include <linux/virtio_net.h>
@@ -31,7 +30,6 @@
 #include <stdlib.h>
 #include <os.h>
 #include <um_malloc.h>
-#include <sys/uio.h>
 #include "vector_user.h"
 
 #define ID_GRE 0
-- 
2.7.4

