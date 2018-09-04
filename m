Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D35DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F4A20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPzUgfkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F4A20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeIDHIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33016 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeIDHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so904094pgc.0;
        Mon, 03 Sep 2018 19:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rc/M0zTwkM5DtzotXjyB3OA+o8WtWUoAU9ZFvniXG20=;
        b=KPzUgfkzoUz0PqjZeY1nZEB9kP+7qnTDhqdQ7uP1OYJIguHxB1gC4fz8odMm8vs7fq
         gyCDeZUYvFDOiLyW4PEfyXHRZMHeG9G4SB0KmWOBMnaz9Bkzwyc/sUw+D+6CeCnWUlkD
         ZDrmCfFV1MnGRCwMGuFDkXCYPW23nq+/pdXfY/DAa3k7qIxEQkK4Pgyjf1ZnCM3r7/OF
         OoFM6/cEUnSuJ3hyHurRehpkJkLXZ001Jfe05fh0pTHig+mdgw0ihtuiEUQJrWl9I+7f
         OgXG/Tf0Iw5l/WD63ZYzSZIDEcmsPxt7VZTbzZ7/R24CbhAxTnZyTvohKrJu870O8J01
         SbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rc/M0zTwkM5DtzotXjyB3OA+o8WtWUoAU9ZFvniXG20=;
        b=o5kdCOCCpXgwEW4sNV9IdYLNOG9PxVZTmt1BLyWwlWWc1sYeW/LHW9oIKhb33G9vRm
         GYBZTSA3FJNdqjvof+s2d/F6pzLIP4xEgmy5op8QgZnwFn+W3b8zl+3ifo3RnK5Q2QdU
         6NZyfnVGAjslKKHj9Zl0iKgMmW5eqMLRiDrIE5GirTAuM1BqPY+8hFAsfXRMEbYs29jg
         D8X+z4AkXQaHLFPW4euMtYDdl+oWqFIHhnkxZME3LslSzFUkEgzjNE5TZQjDFOv1H6pg
         V/fys0NSXmFvhW7cdFG2mq5BloW8MZZ8wNepN1t9LCigjWr+ompmDJh3d5DXCpZZVrgS
         5lxw==
X-Gm-Message-State: APzg51DGZkL9STd/1lwAKJ8lauL/zFZm5uPVLmpVzJutIQv9Iqn25rn8
        +WjxYaJco2bLqtrStXkeUts=
X-Google-Smtp-Source: ANB0VdZRuilWHvSCLGZGpfFX+Bw85dsSGFudReDzlQqdW+R9VzYYy23UMe3/xdiQ/g/NoJOsHg+bDw==
X-Received: by 2002:a62:4299:: with SMTP id h25-v6mr27083940pfd.73.1536029149780;
        Mon, 03 Sep 2018 19:45:49 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:49 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 11/25] tty: synclinkmp: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:37 +0900
Message-Id: <1536029091-4426-12-git-send-email-climbbb.kim@gmail.com>
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
 drivers/tty/synclinkmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index 1e4d5b9..2d99a5b 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -734,8 +734,9 @@ static int install(struct tty_driver *driver, struct tty_struct *tty)
 	}
 
 	tty->driver_data = info;
+	tty_port_install(&info->port, driver, tty);
 
-	return tty_port_install(&info->port, driver, tty);
+	return 0;
 }
 
 /* Called when a port is opened.  Init and enable port.
-- 
2.7.4

