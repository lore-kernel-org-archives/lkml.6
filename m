Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF4920843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNi0e2LW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF4920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeIDHJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44886 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeIDHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id ba4-v6so877437plb.11;
        Mon, 03 Sep 2018 19:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cFthBZpqEg0o3AkyH/cDmTIfBXszV9IUyle8uuggvS8=;
        b=aNi0e2LWGTCNFKhvBzvp9RSWI4K8sFoCffRPjC6GBPC60fswx+xdzp5nYULURssfvj
         AcmU73szVeL9Yon04e+s1hDKOPu5H/yUiF8WMigIbAUSITUPXobWi2u9ie2USkPGiiYc
         VUzPOBfIqQ5XQNwR0AhTNcVqTJZFUh6UhEHjYY3PiywCRjwuBQiSdtgm9JQu3C0ufaNX
         G1PG9H8xMEiBCz8nXOTVrK9HJs+g9QiNC9Zp97wshBBijnkkdgio1vJyJ3IF6Koh4Bjg
         V366MG8eIOzCyof4CbYJjsswUYUnO8dewNQk1eqNtvCNS6eZUsOw0G8HxTX+cdLTAnGp
         3jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cFthBZpqEg0o3AkyH/cDmTIfBXszV9IUyle8uuggvS8=;
        b=KiI3yzCN6/gdzKbL2YndtZxQTs4n8il+T8CPQAseaD9XpJXhhaeMyX0udJEKPEK4Dn
         8IuUMO3zHE9QMQUAeqWUiEHJBiT8yHt1BaZ0YHWDygng1paezhCtI0ob60fFYHLCdoTr
         5sosI0OJYm8ebQ+mYCC1nAdS/gokwEHxfivsdpt9RiGKtGYhFSb1agUZMhs5Nm2XmalR
         XaQmAzDgPpStfUxkV6PCRdP0Mi2W/r34Ab7y+Ap/V7atXKBNVQmp1XznWzeDttaF1bEH
         mRv9HlCwpA02MB2IxaqsaldYTIXMoNiMiDKwGc3H1StMBtv5oXcVniCuF6QQJAYCoBLd
         E8Eg==
X-Gm-Message-State: APzg51CJ4A+WmNTIanMIb4+osixNhO3IgZdS3vNLcE0RNN80Ygbkwpuy
        7s3lQqx3q4wJeJXE1tm4sRM=
X-Google-Smtp-Source: ANB0Vdb/WRa4NVDIg3GfWcusn9xJSZ0Ijn/aDoPmw+y9Ebo2U5QHHaSskgvFPR6GkxGhJ7z7pDh+Cw==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14-v6mr31457955plo.213.1536029172827;
        Mon, 03 Sep 2018 19:46:12 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:12 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 16/25] isdn: capi: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:42 +0900
Message-Id: <1536029091-4426-17-git-send-email-climbbb.kim@gmail.com>
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
 drivers/isdn/capi/capi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index ef5560b..08daf3a 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -999,13 +999,11 @@ static int
 capinc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct capiminor *mp = capiminor_get(tty->index);
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0)
-		tty->driver_data = mp;
-	else
-		capiminor_put(mp);
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = mp;
+
+	return 0;
 }
 
 static void capinc_tty_cleanup(struct tty_struct *tty)
-- 
2.7.4

