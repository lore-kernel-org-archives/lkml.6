Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A41BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B5D2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiVcnF+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B5D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeIDHJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36106 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeIDHJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id e11-v6so896702plb.3;
        Mon, 03 Sep 2018 19:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7uAJRAvdTqzcpqqjK5tzDqg/rePnC+seodc9IPByu00=;
        b=qiVcnF+ySqN7ITShcOwC3qNgjM3JKqbmljNdAqNdyllcVbWnPz6Itm2idIo9p42Alj
         ZDYiIJ4rn2N8ntUIdVqN8hSr5A1K1mpp6RdMU3r84HK8i+aR7AI5/sQaaOwGMNqVjI+D
         BMwJD+42vq3QBhEBzU6McJeKTvsUUtgKV1JtMnmR6dwEAKtiGteyxjsVyP3/xVfuCKrk
         3jroEOtR65o4N+L32fJ8/e5Sr5NlEMlyMtHbQhKMevX+bMwEu0wu+Pj7wq4J8nMCAYGv
         QrfmAlgf/VPuqPxG+ojWGvasclRJLzGhnIAtequ5N23MSwb6JvU7kaUlZVWBCUmZQDzr
         I+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7uAJRAvdTqzcpqqjK5tzDqg/rePnC+seodc9IPByu00=;
        b=ss01vZkCKZ0A1yAClsq9SExRe344QO5OMm6oQRLys2O7IsDlzwp7uIe+xZAxyU2JlH
         Eph95aSYZT1+sg2XdgGrg6UcZX0Z1bQ79f/bkchQewfrG7F5goiJOn2hR6g8WBBLHiRc
         ilh1ifUYP232/+v9EFQzEu/MJ8nTzqpsZRHkIdMdIeEqs2gX0Goc5PHaYUBl938DRTkL
         EPDdA/j7XMBe/NQALfoh8hmuwyQikzsyqMRNCYEafkOPBkz/ATzu0QviBkO9sCExA8gn
         epQV9/qJ3ieUWt6tDnIfRkNF7QZhhWyo84KiGlEMEL2PW2XIhcqHkl5m4qZD2lAP2gyb
         3TrA==
X-Gm-Message-State: APzg51DuRaw3aJSVJNNbxaNproa3zUxsD85Eighh6tifMzV2c8pw3uGm
        dTl4cYAys5C8LyuAzFeXlHY=
X-Google-Smtp-Source: ANB0Vdb9myTURZoXqFquAqZsyos/o7S6Qr6wTdmjZEKLC+KG8zP08IwRTFrTKxV/1UXVeW5jyKmyVQ==
X-Received: by 2002:a17:902:7c8c:: with SMTP id y12-v6mr28570270pll.283.1536029196519;
        Mon, 03 Sep 2018 19:46:36 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:36 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 21/25] staging: greybus: uart: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:47 +0900
Message-Id: <1536029091-4426-22-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/staging/greybus/uart.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 8a00632..182155b 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -393,21 +393,15 @@ static void release_minor(struct gb_tty *gb_tty)
 static int gb_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct gb_tty *gb_tty;
-	int retval;
 
 	gb_tty = get_gb_by_minor(tty->index);
 	if (!gb_tty)
 		return -ENODEV;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = gb_tty;
+
 	return 0;
-error:
-	tty_port_put(&gb_tty->port);
-	return retval;
 }
 
 static int gb_tty_open(struct tty_struct *tty, struct file *file)
-- 
2.7.4

