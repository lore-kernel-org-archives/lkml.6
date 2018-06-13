Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C7469C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D51208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0vHSd40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D51208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936129AbeFMPKr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:10:47 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34828 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964778AbeFMPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:10:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so4518122lfc.2;
        Wed, 13 Jun 2018 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ntWc8rdo9GfTrwyXxCZTkAseM1hiGlwRnn7L4kwwyZo=;
        b=h0vHSd40tueTOp2PqGzpUzUHA4iGx8lwr9qr1PAMfuUqsy0Jr0nHpvcsmWN0j2x88U
         eTceZihj8OXj6zyHo1m6PKhkqvdRhbc0Njq6Ytxa44m1yZcZh9+p5/kXe08OcycHuAkw
         QkuXvEBnCW5Zvt6UbvyRV501ZFNnOgmcXLe8I5BSf7vAF7mwOjE+3mea6lD09C7b27iQ
         73KQizXCXNKQMFnOqZX1wdcM1KTTLwah06oGSwnk98u3y9s3Hf08jY7wd6k5pbiz5rcc
         s7lzcT6T/v1nherMC+mwAEjyMVy+92ywqHL9BCdoHYRtiADlAtPrpzvY8ISJAANzD/Zq
         Cfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=ntWc8rdo9GfTrwyXxCZTkAseM1hiGlwRnn7L4kwwyZo=;
        b=jqwWe71635gfk+ilhEVBMqj1zoqaDdQHdJOnV9kQI2ZvW1dsUTwb+NeGQ0IoMuTUxX
         RWvarO5NtY7c0m4KmxYVvRn6sGzH/qVLqyCFlFdNzp77HSgiKotWv5yC3A9J7WqEp2Tz
         9xoDW6wP7pWdYxCfoQhex6eoteXVKBIDgIeg3apbtVwTtJGGnW5Xqsht842tCGEWcE9g
         tJoG/0dUL4/Ueq6tvQfvzSywFjI8SOVU+ZJaId/+7Sy0m0stoykkSkAHe+6MJ/ymF7OB
         zQq5jZjIpGJgMZE6bxlAI5tsoTnqlUkpFg4s58S+JdQXYZC5ACHize5w6oEXuYpWosj5
         BvbQ==
X-Gm-Message-State: APt69E25Al++SwLbUINcztB9NNIFT+P5TampdQXfoTR59LR8ZfMZhEYl
        twvCb0MB1queAnjBWH2gVAk=
X-Google-Smtp-Source: ADUXVKLDkvwppKliQgmIDCpChfFqN4On8+c6IpScmnw4XiUhVB+B7FwiTsWZPSWH1ujYXJiwmkySwQ==
X-Received: by 2002:a2e:5b4a:: with SMTP id p71-v6mr2068604ljb.13.1528902639966;
        Wed, 13 Jun 2018 08:10:39 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id o26-v6sm575313ljg.39.2018.06.13.08.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:10:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@xi.terra>)
        id 1fT7Pd-0005Sa-MH; Wed, 13 Jun 2018 17:10:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] serdev: fix memleak on module unload
Date:   Wed, 13 Jun 2018 17:08:59 +0200
Message-Id: <20180613150859.20879-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to free all resources associated with the ida on module
exit.

Fixes: cd6484e1830b ("serdev: Introduce new bus for serial attached devices")
Cc: stable <stable@vger.kernel.org>	# 4.11
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index df93b727e984..9e59f4788589 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -617,6 +617,7 @@ EXPORT_SYMBOL_GPL(__serdev_device_driver_register);
 static void __exit serdev_exit(void)
 {
 	bus_unregister(&serdev_bus_type);
+	ida_destroy(&ctrl_ida);
 }
 module_exit(serdev_exit);
 
-- 
2.17.1

