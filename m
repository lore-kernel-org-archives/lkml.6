Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94481C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6EC20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/H3Tkp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6EC20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIDHJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45487 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeIDHJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so873381pge.12;
        Mon, 03 Sep 2018 19:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tIm6EZtwcTj/6K07q+OAE3PS7sJKQ7sQ+h1iaHX1x3Y=;
        b=H/H3Tkp3uHiVEimPfiHOldaIHZ+9vgFJbNLaWIZwsJMXYQe3xgOiX9qvsHIJh96KSR
         460oFGHEhBNxbZQB2gljH7ub1xrfGuoqfDIRTSO4/7UZLyZqPLo+i9PUor6MigvqfEJg
         mJyJr8lW8/SJMCtYUznXQ2C2/yD0gPJ4ANXyd7DOiOlRMicuGe1rGmxz113QkausZDjn
         JeN349FcTBx48VunsQMKZvhMKDi4qw/FQQ7k0pcmvIyjm5OsxcxveQY8l/xrRp2CxjtB
         AaKsf9LR7aBIjxYAKflDwvZiNXJUpA+Tfw5bvQerNV7RIA9i+4ymP99mK5I4ilVArHwW
         gUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tIm6EZtwcTj/6K07q+OAE3PS7sJKQ7sQ+h1iaHX1x3Y=;
        b=fnkes1vSbRpg30/fzpY/vMHrRokyTt4ckKi1S+OLtdEy1O8wWJdN/qhiZPIzOGrYdR
         HCTr1e8Kv+IZACrBhFG3xkvvNUphax/Y/nDY+SxXvUcl/ZQJDkWDagPtTafJxOQ8ZWlQ
         2YbhNSwwiozEWoJw4AdROaHlnjx+EdgoasxovoiSGepeVld4hZPKemcZvwI63OSBP/V6
         J83j0ECU15LR0ZHqaYs1UeONrpc6/bCPsU1Tj0lDkocMg10UY+mN3P8KUUhYbmQxCARI
         4QhVaOzI2UsC1BBAhPX16bpnfQyDrsk7fVlT1C9PxKjVr7zjzoMIQhK++7b3F7UGi68r
         1GCg==
X-Gm-Message-State: APzg51DGX+FS0ndE8rXlliwFCuMUJlE9Y4OlBQl4NEFDx4Bc0uth/J2b
        OwzOmE+OUZwicH9Ta/cToow=
X-Google-Smtp-Source: ANB0VdZ6hJam4sJt4CsP1wMFFch33aXly5rOzu0Dy2V2g98FId2tgWLmFosIzGaFiEgoefPwpjcEWA==
X-Received: by 2002:a63:9809:: with SMTP id q9-v6mr28648150pgd.58.1536029201118;
        Mon, 03 Sep 2018 19:46:41 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:40 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 22/25] tty: nozomi: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:48 +0900
Message-Id: <1536029091-4426-23-git-send-email-climbbb.kim@gmail.com>
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
 drivers/tty/nozomi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index fed820e..479583d 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1555,13 +1555,11 @@ static int ntty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct port *port = get_port_by_tty(tty);
 	struct nozomi *dc = get_dc_by_tty(tty);
-	int ret;
 	if (!port || !dc || dc->state != NOZOMI_STATE_READY)
 		return -ENODEV;
-	ret = tty_standard_install(driver, tty);
-	if (ret == 0)
-		tty->driver_data = port;
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+	return 0;
 }
 
 static void ntty_cleanup(struct tty_struct *tty)
-- 
2.7.4

