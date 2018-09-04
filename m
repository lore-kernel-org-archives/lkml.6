Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972AAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515202086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbkt1Plx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515202086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeIDHIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40872 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so906325pfi.7;
        Mon, 03 Sep 2018 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tRdeqz+78ESzrb/nXjyBB6nqAAwIdJ3C0aGuFwzfOGg=;
        b=Lbkt1PlxVxfnVteEhPuZCMen61t/VT9dOcKgDaqKWjZ9uaMuAeJC1g2S72yEPZThiH
         jn/XI/ZimRlTHJ5JUCrUuzijODGVRgV7RwSfAuAuAn3cCwi0OXJSK+bZzA3MhA3ue3oY
         ykaxoEFwTzDAJQ+wAkTnPJvHL+0BRCoP5pq858TSLFDRjcfTbqFlgsLWvKmQM+HQwnQ7
         Xehsi9XWThKKXhu/+NOcW2UJyNcJHzOhtB3OTO4mYsfsIPC/Rpe1cpr8st02yfxnYAyT
         yHPCG7i0rrekINkocDYZ180/nHSZDNCnJK6kxoFz/n+zpvk8K6uyyOrTGHsQyR+nM5qu
         ul7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tRdeqz+78ESzrb/nXjyBB6nqAAwIdJ3C0aGuFwzfOGg=;
        b=EcEhrEXQDJw4Q0Z5svFzTvebzHnnkh/RQJl4agJaxx+S+C9ykapQcIHzs8T9PegzsJ
         JdOOidp96OHkMtAsDpLGvFTwh5ksiAFcE2ZwpU+kVM+j5Ud95B/F3ob+k8omEKY/Sz9c
         OUx5mlv5ozU7HL02UHDhG6x1uc6E4rLcl0kwOUC7BlnLllZURzxulOq0Y801U2O6CvOG
         cokbEkRTfbojlbq9Oy87jIIujyvjUfI+7TnVLDqjBWy/YCBJr+QFDfqUeIxp397WhthS
         ycoQS+1Jhsk+Ednn8ltBqVzQMbDpiZLQ4NNlXeUSHMU3FYYFOO1A7203hOe0O81yokl6
         He1w==
X-Gm-Message-State: APzg51CN9hkIbc9zJobd4D9sinYcAb2SF3HeHzEpjfjC+PxevHiMRWp3
        FbtuPVtWlnry4qw9xwX/lIU=
X-Google-Smtp-Source: ANB0VdZxoeKVSzXKlsmQQoJgCTH/oH+q/pdwXVf1VJP0KvD27gLq8E/VdhUMgirGPdI+/A3Z958PYA==
X-Received: by 2002:a63:e647:: with SMTP id p7-v6mr28111566pgj.218.1536029127255;
        Mon, 03 Sep 2018 19:45:27 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:26 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 06/25] tty: hvc: hvcs: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:32 +0900
Message-Id: <1536029091-4426-7-git-send-email-climbbb.kim@gmail.com>
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
 drivers/tty/hvc/hvcs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index cb4db1b..4dfa70c 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1140,16 +1140,10 @@ static int hvcs_install(struct tty_driver *driver, struct tty_struct *tty)
 		goto err_put;
 	}
 
-	retval = tty_port_install(&hvcsd->port, driver, tty);
-	if (retval)
-		goto err_irq;
+	tty_port_install(&hvcsd->port, driver, tty);
 
 	return 0;
-err_irq:
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	vio_disable_interrupts(hvcsd->vdev);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	free_irq(irq, hvcsd);
+
 err_put:
 	tty_port_put(&hvcsd->port);
 
-- 
2.7.4

