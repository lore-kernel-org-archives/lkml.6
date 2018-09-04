Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E850C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DAD2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXSpGv6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DAD2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeIDHJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39937 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeIDHJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so885730pga.7;
        Mon, 03 Sep 2018 19:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fA2ErCgkNSVCLrHl8v8rTEOByo32QmaLjON3C67ERi8=;
        b=FXSpGv6Q+gVKqqkcRWl2vNMAOcNEdvYrXJL3ksktI+W6kt6ISgNAG0igOutTk5HyXJ
         ZW575WBe+/s6WfKUy1k5kv7a6ENWwjFJoQ9fdqllgGaI1ZW6hqIZexvnZGKjyrfTOBVK
         YIjINe7bm7REInnq72i6mTEg2qR8TTIZXXJxqa3Qfg6WC5fv5dBKcvNTUhSDQUkEe1xo
         5TKXGWS0vbp7Jy8sTD1RMiWAJ+otJSs+jBmy80tDyPO+7f/qiiXN+af1OgfhydXSP0dh
         FnComxuodg8phvHHndO7CBd+/+rlGF5KWvW8iYXGhnLEbZjYK3tbI7nxzb+lHQGKlXyk
         8Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fA2ErCgkNSVCLrHl8v8rTEOByo32QmaLjON3C67ERi8=;
        b=Les3L60FxT8R+IQLGnBAADQGq+n24e45CJjwcNT1CsDYzf5qzJQad0/pJAnAkWEXGa
         3aEYbrB+kgW7pwivGXzA6bSNwH0fnZF2AZqUWCUEGZhKwg+hpKt8Lau0AmI3IFTp/rNd
         isLNetlTMWPuWWsK2pqrwruYI8HCJ/4YHBcM3AIi3T2WKi2+/wDsGlAkTpIVREGzQrSb
         ZIK0KMXVZiXLl73GXJvpFLhGqsAEHy08Jeb7qQ3D3zVy5rubl0/aw7lrAAQA0YDz7RHE
         S7wBDRmgSMxBVnsqVHyl32G7xZAPJovLI/NSIWEb/pWJ5jCS79VLjgSizW7wLfRJVE3Z
         aJ9A==
X-Gm-Message-State: APzg51Ch1wijPxrHIETy1vg6knLgNlLPSgb6kGH6iQmItUqc+76XapeI
        Vuhy/GIigPbFyZ+FosG6f5g=
X-Google-Smtp-Source: ANB0VdbpNOEuUanWj5bVqUTmDeWxbrNm+KLWHG/fYkXr3pvSIbXucixHajRhrYWyzCbEeM2pBhP+MA==
X-Received: by 2002:a63:4f14:: with SMTP id d20-v6mr29062720pgb.121.1536029191652;
        Mon, 03 Sep 2018 19:46:31 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:31 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 20/25] staging: gdm724x: gdm_tty: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:46 +0900
Message-Id: <1536029091-4426-21-git-send-email-climbbb.kim@gmail.com>
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
 drivers/staging/gdm724x/gdm_tty.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 6e81369..d6348df 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -62,6 +62,7 @@ static int gdm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	mutex_lock(&gdm_table_lock);
+
 	gdm = gdm_table[ret][tty->index];
 	if (!gdm) {
 		mutex_unlock(&gdm_table_lock);
@@ -69,15 +70,9 @@ static int gdm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	}
 
 	tty_port_get(&gdm->port);
-
-	ret = tty_standard_install(driver, tty);
-	if (ret) {
-		tty_port_put(&gdm->port);
-		mutex_unlock(&gdm_table_lock);
-		return ret;
-	}
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = gdm;
+
 	mutex_unlock(&gdm_table_lock);
 
 	return 0;
-- 
2.7.4

