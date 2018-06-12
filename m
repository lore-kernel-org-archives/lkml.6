Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42BFAC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2DC2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXQuK5YG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2DC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbeFLEuz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:50:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43685 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbeFLEuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:50:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so2357650pfm.10;
        Mon, 11 Jun 2018 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1TKrvCSm+Eh984/81unuiMPXREU2a4wzPgn4YkBsUNU=;
        b=HXQuK5YGv7k+Fu1oI9NJDEb5+4OIld8snzh/dgL6aVPVOUT3Qydhe6Du9dOOBi1CPy
         PWTIvs1cgOYBwKkgywK01j/iC0Gj9PROwTSFzCZy6gexwGVKyVINEve3l7veJsv1bHKV
         qdvuHFWvo8ueeY1pRFoTLIO46rRkmRir7/L/HmMsTliZ2QotvyFCd7SANFKbKRvVmI25
         IBCtY90aVQJS/rqK+9GZ2qZUaImP2S7trW0rFdMVgkLwACTKu6/+j8du6cwZz2zEHEUt
         XsnEJGAXP1YQQtGBsmOWlu6bs+YOYJSb7uYs4iZfAs+HXEdmFKIE9OXu3z6EqSM95k5d
         zhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1TKrvCSm+Eh984/81unuiMPXREU2a4wzPgn4YkBsUNU=;
        b=V4Ewhl1FBKThhNPsQSPxQ1J8mMnw9LPQKKaXALBXBdkzTF7VTEKtw+xcNXQtDZ5NYj
         UKDzw/nzW2EbvumkVqZJLTe7/+fU8/l6SJfUxhHaDd2qcgBYdkvs9Lzo/qHD4Hz61y+P
         GueulBX7KzhZYkB9IeHUJq+iw5KQFUoNXxfqjWoFuX5kf7bOGY1pss4uWnmiW3fylcg/
         9vh+qbohMLpHfIXW0oGkSiDSe6tUurkY6fo15DZ8B1wc3b0DWvVys6VQjlezQ82FNpgd
         xPk6czoCF+XHuTiAWtGc/7rR6zeoTTGBJN3z2nYyboecTix2RjILXe1DuFpGU3WAznbg
         DUEw==
X-Gm-Message-State: APt69E17ga8PuQVVdRquSatSAfsbFH23DRZhnLYlMjfdzdJd8va+kXBf
        jmGsgvj2DbusXKOQputEUxyzUBYTJRU=
X-Google-Smtp-Source: ADUXVKJMYUKPkqX+mE/Vj6tj9MDJuvzz8JiS6eRIBKKfZxPGDuWZq+0jiULxM0PLJhoL4hh7wCMTvw==
X-Received: by 2002:a62:c809:: with SMTP id z9-v6mr2127331pff.5.1528779052004;
        Mon, 11 Jun 2018 21:50:52 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id z26-v6sm3652975pfd.60.2018.06.11.21.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:50:51 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: add error handling for try_module_get
Date:   Tue, 12 Jun 2018 12:50:46 +0800
Message-Id: <1528779046-42341-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When try_module_get fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling try_module_get.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/tty/serial/kgdboc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index b4ba2b1..641e22a 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -286,8 +286,10 @@ static void kgdboc_pre_exp_handler(void)
 		con_debug_enter(vc_cons[fg_console].d);
 	}
 	/* Increment the module count when the debugger is active */
-	if (!kgdb_connected)
-		try_module_get(THIS_MODULE);
+	if (!kgdb_connected) {
+		if (!try_module_get(THIS_MODULE))
+			printk(KERN_ERR "kgdboc: cannot get module.\n");
+	}
 }
 
 static void kgdboc_post_exp_handler(void)
-- 
2.7.4

