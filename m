Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50217C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B34E20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcmdTC4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B34E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeIDHIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38524 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id f4-v6so891006pgq.5;
        Mon, 03 Sep 2018 19:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QKXT0IAdiXGunM0h8TcwlUcNbYTcAP1VBYf+0K34IOw=;
        b=bcmdTC4IFRlkcnu8u5M3hslCsrGt3xtnfwLmuDwqml+VgFsLScxRsX69Z1WHq4kc/F
         7kOOGpZVzNBqUlLfNCs6h4N3vT57A4SMcoD0/LoJ85+okOM8C6uWDUm3nbAM82/n1FLh
         tc19OURIJS64bFCfl5XVccjOqxgGBbwBH8RBgK4o7puXJRGfZFeyjATTcm/rfzvsxRJi
         EImZoqDjUmyiBKtKyAlgBe+BYfWQA7JVEY1eZnNcvnEBeA4jIoHwOpDyTdTAgZsf/X/B
         Ng7O+h1OHgnw7JBoRQNg54u/dkDSQP1afDCKoL5yrkEXdSDdtSIe4/elSPza0sn8cWS8
         NNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QKXT0IAdiXGunM0h8TcwlUcNbYTcAP1VBYf+0K34IOw=;
        b=GQxK0jWsWlxWuw04GZKeclsut8E4R8wl8PA53amcoW0pMJDv5c3pARs7egfJm0WnHg
         cfs+Xif9wPESw48x6s6WC1YkgeNFEipWKWK/d6+gz8su0F/Vrf+QspY+JPOEwf3Lmw8o
         RogOE8XXYIVUWL1bmBA/E20oMLUlNusivoY9EPWQ4ZAi8b7K5+Dwl1sLll8/e/zA/acb
         He/mQPHZTAn/DXwWiB85tbtUenkcvMiBksveoXmoxK3itcHv5Ax6rs7gmTmVGQ3zTAQ9
         u41Vuig0mhfM0+fIzMfVhe8ghtODoMNv0x9PUWyRZXr5ry13sqroQRJCC6Zk9YJ3ej9u
         LVTw==
X-Gm-Message-State: APzg51D8MiYFdOSEiwP7YVXStBlAAI9lTBqeFBB0Jsa0x22uVTC1fbLJ
        gdD20Sl2FPHXexCgdUkeaxM=
X-Google-Smtp-Source: ANB0VdYezC4JAodZd+e37kZ7Y2b8TpdNW+oJVm7jwyD2eR4ESWNi9ENUOHoDLCeUFD0/JsJRlCKvRQ==
X-Received: by 2002:a63:f54c:: with SMTP id e12-v6mr29197845pgk.286.1536029114284;
        Mon, 03 Sep 2018 19:45:14 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:13 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 03/25] s390: char: con3215: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:29 +0900
Message-Id: <1536029091-4426-4-git-send-email-climbbb.kim@gmail.com>
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
 drivers/s390/char/con3215.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 8c9d412..6a9f6d9 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -965,8 +965,9 @@ static int tty3215_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	tty->driver_data = raw;
+	tty_port_install(&raw->port, driver, tty);
 
-	return tty_port_install(&raw->port, driver, tty);
+	return 0;
 }
 
 /*
-- 
2.7.4

