Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3914AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AD620843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaY3Jg+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AD620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeIDHJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38719 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIDHI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so911470pfh.5;
        Mon, 03 Sep 2018 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HF0PCC9uCoqxnQ9gpvOU6TDEMKqHeKkM4XeDXQDJXAM=;
        b=QaY3Jg+LUbi6LQ/aa33tuRoTX/1JjEd63W8B2TSxWEL5lJ9KIpQD5gqrtHlt3vxnMO
         dkDNbosJk4FTRKImHBopXlCVuo0WJhPiGAkd9j1VhVNi3nt70gqrZUygbygxT9dPsOE8
         6gkWuI0CAvYU1CE4NUzK4cQLbqNzFZiojdzR4JvhQP51Mw+r/t0E5Xl4UPJqz1pTmvqM
         /m/RFtkfGSGGIFDNDtJZGrb2yWWCVsUNCoC/ZJ8bQj/KAafbDyDVZ8olNfuy9viHt5/7
         QQU/z+5fQ/Cjh2wSF2XGIU5fNMiSfnvKrM49z4nu5uXu6WCrztkdaQFUQ1LMGwW2dOxc
         RyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HF0PCC9uCoqxnQ9gpvOU6TDEMKqHeKkM4XeDXQDJXAM=;
        b=cwl4VJLiXayklQJOKorY9URvvS/SP0vcwviEB2PKJgcnDfVU25MkKZUFJvjybm+JJV
         dQ4S/aI7aoH9f2iXBwIPVmo7LUhaCGE+PcLQYFldVGPrHQNtEVBtZrueagA59B3oyGvH
         pZWqhA/2K/GIIoZLri6UX7IJWk5Tc/Io1yvab4DEb2BoG7t0vWXp/8bv5YtWd5VrhSnl
         /fOecyVGALihxAUF+Tv9egnXJq7SozylitvZT2xIQXzx3vidHN9grGuNVNmYsTQIt2tY
         XuKLsX2GkJlItGm0zH+mwRl7g8k2nI6K5YpsTo87ky2KPnHBQBIBRVsRq55rKyKcEunL
         NRnQ==
X-Gm-Message-State: APzg51CpfGsSi2Qy/WqEo4tQQ/LTF3wdk6o/x5Bo4gE97Rq/FNlJr9BX
        4rX4uPJJFrmgiJCLJiDn+RI=
X-Google-Smtp-Source: ANB0VdZfRaC9KxMLpiDu8nDLsh6bt+ua/83a4QRnKvVM2G1JGINXIqflEQa52rywQJCcHrRJRVjZMQ==
X-Received: by 2002:a62:7a01:: with SMTP id v1-v6mr32385003pfc.153.1536029163682;
        Mon, 03 Sep 2018 19:46:03 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:03 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 14/25] Bluetooth: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:40 +0900
Message-Id: <1536029091-4426-15-git-send-email-climbbb.kim@gmail.com>
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
 net/bluetooth/rfcomm/tty.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 5e44d84..b654420 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -710,7 +710,6 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct rfcomm_dev *dev;
 	struct rfcomm_dlc *dlc;
-	int err;
 
 	dev = rfcomm_dev_get(tty->index);
 	if (!dev)
@@ -725,11 +724,7 @@ static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
 
 	/* install the tty_port */
-	err = tty_port_install(&dev->port, driver, tty);
-	if (err) {
-		rfcomm_tty_cleanup(tty);
-		return err;
-	}
+	tty_port_install(&dev->port, driver, tty);
 
 	/* take over the tty_port reference if the port was created with the
 	 * flag RFCOMM_RELEASE_ONHUP. This will force the release of the port
-- 
2.7.4

