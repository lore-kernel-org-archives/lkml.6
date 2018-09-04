Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF0FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5563520843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSyhtXkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5563520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeIDHIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34894 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9-v6so899372plr.2;
        Mon, 03 Sep 2018 19:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dM0xQ787rzw6bkqyfUjT3zjhB0YPJAJ51j5bAjS2T8=;
        b=LSyhtXkGxa0FU0fVjsQpau0if65BJFmvzTCCED/yoMtBCsWTOnczf44bQOG4WVD3fk
         bT5CCAsnyu0hAMzH85mdtgxH14TdL6PUQ1zver7BZy05sFf+wiPf/8I+q/7zE38P/9Jd
         IhyNrZV6oM9k8dcP2bJRKaTsooiRxqt9q7/8AgVMWoxqLoV/Hz8djpSqpBqpqZJmvQxQ
         3FrLn2wBuQCXyxmN+IqBghprw+qPZeipg8ugBJVDSlOIm3/nRW0IkuAg8ycUsP8MrpIX
         TqWth4eQahCzAXARFo70j1Tvdj5cgsBSWRmX6jbV1gMaL44/FiWoFnrJSyklXMgO4wkq
         QXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dM0xQ787rzw6bkqyfUjT3zjhB0YPJAJ51j5bAjS2T8=;
        b=DRcEj6E8NvijUoiOzqvfYJ+TDW5WDAdmvlN+bdFeAUmIPxWY2KJBNGBOpSz3g118d+
         Q0ug850Y4TQ2aFJtyTuvR9MOEFRWlhflfWmy6Aoo1jdtC+I8kdDJSIC+v8gTEImU7pW8
         Qj+qYGPUz6cnpWNm6fYV9sOBlsUVnpLN5CMnCoMdF4PomNvh8ZB2DE3vLuo508bfwu9o
         AL3tB66/lFvilZdZLQfue9MJM6LHbCQgAoqwfMP2/IqVCiLHz528AD04J1Vg9GD2Neym
         3GFVJEa02a1R16j7jIO3lCswcoLiSf+dJh0otrHsn+05wUa/rDqD+XgLKiK+1JhxLw9Y
         TtpQ==
X-Gm-Message-State: APzg51BMv+XuA1NfZJ7JvcSqLWyuQMgRA24+iXeBy+KBs8de11AJ0msN
        tI12ppgbYJcbvzPgCT9FSUM=
X-Google-Smtp-Source: ANB0Vda07x392kbhxT9E/C+zoKxcW85Bqrj63tRUL/LAuoI3BB2I0JaA0GyiQM4GxiYzWJUg3ATX1g==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13-v6mr26735699pls.139.1536029136410;
        Mon, 03 Sep 2018 19:45:36 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:35 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 08/25] tty: n_gsm: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:34 +0900
Message-Id: <1536029091-4426-9-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/n_gsm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 86b7e20..c52fa2d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2917,7 +2917,6 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	unsigned int line = tty->index;
 	unsigned int mux = line >> 6;
 	bool alloc = false;
-	int ret;
 
 	line = line & 0x3F;
 
@@ -2949,14 +2948,8 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 		mutex_unlock(&gsm->mutex);
 		return -ENOMEM;
 	}
-	ret = tty_port_install(&dlci->port, driver, tty);
-	if (ret) {
-		if (alloc)
-			dlci_put(dlci);
-		mutex_unlock(&gsm->mutex);
-		return ret;
-	}
 
+	tty_port_install(&dlci->port, driver, tty);
 	dlci_get(dlci);
 	dlci_get(gsm->dlci[0]);
 	mux_get(gsm);
-- 
2.7.4

