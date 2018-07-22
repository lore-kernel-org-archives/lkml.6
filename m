Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A0CECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD22F20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDQDjj0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD22F20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbeGVXJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35338 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbeGVXJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so3099061wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZDnPry2kvTpbJGnHKEi/UQ3WqxXGgo/hV4on7Vav77Y=;
        b=sDQDjj0SaSWBBA9qPlz8IzVrfO4lP5TI+n17XtNsvFybryHJdrJnFct3aJeA5xALcW
         QRpsCNndAnZxi2l3AlT/KOyjha9krU8GeIVainT05gPeMPVvcDHlZ+YhfQTICG46sR8U
         hyVJ2K+nOkqIpT+jnj+0B/UVfDviPqKWMtcVgZf4NEla4eVY+InqRyzoJ+7WHMMVyJsJ
         f5hi/mqTXE0YD2v1mTmxCETLVWSiIt8ThX+jMPxoN63QSCHzN4uhj0l/zj2FWUHx5yTX
         EDzZQQN9UedCW+SO+AYo4/dbO1YZdp7detyLOwwiZkO6HLd/a70Vrmtj3rvkE88v/+3v
         zZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZDnPry2kvTpbJGnHKEi/UQ3WqxXGgo/hV4on7Vav77Y=;
        b=pqRb2+uujDRLAkHmLXxngWatfgtaz7NxMLk5tLN6sU6t4xdXQOpCY9CRnouT0mdtDY
         tQFoEJ1+jWhb5mgFDXlFsMaxIw9TzaWxm9c8jWtK+xxo63ieIeBI7HeHwPRnhnwwo1D2
         49vE32RKd4hvvMPRzrq6pM9Fy3lqemqbb73UGKvSshDbdTQu5tlQ1OymMeW5G17jFiAo
         duJxP79OunnXMz4zNOOkW/blQehGl7yPUyDiwkmGV7CnjR12dm+h3ukV90h9sYlePUfs
         +/n0hXx+cBcwlti8jS/X7BxHlTA4maFH1mfRKrw2vFq58rgWcvyZHtJoWqbplg8ewfPJ
         KRFg==
X-Gm-Message-State: AOUpUlE1xeF5Hv2i3Qj2gQjh9YTE8xaFZzBDqnxiuV6YjFVKuqBU3d7G
        VD3WEJG5h7tYX9Q5Go/AHAivdEYMz+k=
X-Google-Smtp-Source: AAOMgpew1oXRoeUkxTP13EAvuCz7dkFvH5t6/XO+UsAylEGjXY3Jfv6jYaflTA/zt8FHscQD/S+RDg==
X-Received: by 2002:a1c:99c2:: with SMTP id b185-v6mr5612464wme.15.1532297459710;
        Sun, 22 Jul 2018 15:10:59 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:59 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/20] staging:rtl8192u: Remove unused Zebra4 definitions - Style
Date:   Sun, 22 Jul 2018 23:10:23 +0100
Message-Id: <20180722221035.14453-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'Zebra4' definitions. These definitions fail the
checkpatch CamelCase naming test, rather then rename as they are unused
definitions they have simply been removed. This is a coding style
change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 73944a9f9622..ea0c3bdc2a77 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -103,8 +103,6 @@
 
 /* Zebra4 */
 #define rGlobalCtrl				0
-#define rRTL8256_TxLPF				19
-#define rRTL8256_RxLPF				11
 
 /* RTL8258 */
 #define rRTL8258_TxLPF				0x11
-- 
2.18.0

