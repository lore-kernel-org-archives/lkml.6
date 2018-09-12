Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9056DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A27420866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RZ3X5S77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A27420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeILFSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:18:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33471 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeILFSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:18:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id d8-v6so371212edv.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/YmuauxZavQGn8pT/koRDQ0Q9xTQ32n86mobHdHHnjg=;
        b=RZ3X5S77KAnGp/uGS2HJeEitLdU2Xl0tQA4izHUUGEa2cwpw+c1Y2oNCTFHgFIwbvU
         pBUqNrXtz0J3TMBW/iERd4hB2a+wMJvG3btvRdHuKQUM57EOrZW3/YcX1vk3OaIGUtSD
         GH1zxRBb0Azj9Gmz/RTEDRxsRRx3ULWZmpoyIM62F9Mzk8+V2Vg/wxrUBI6a+CiCO+KC
         aNp7DG7biFnVQNyEbmm/Dv73A3aMlOLVTpxAaQBoVCNO1CPRV3D+qlHHOosWsgOuUmwO
         5WdbKh/r5MLnb93+tFLLS3DpKXzPDIA9Ty13sgpsWngUJjcp4UFGPm6q8jy6ydSpXrki
         kDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/YmuauxZavQGn8pT/koRDQ0Q9xTQ32n86mobHdHHnjg=;
        b=gdisX0a7k/vLjjNlRIuPbQUp+5d8H148zDkff/zMGp6sdiPH8BlVTtsIB5IMU8NCWg
         VsK8ePgs0c4xR7QbM05F0FHSg/zyfPTY2bFoiHkQJ7GJlZgoDZilzdTmBAIOySLjUkot
         ZqxxPF0HtgT6lFKsryi3yJ84hsaBLt6QYFUdXRypBJVGVmN68qWZypJPQQarWiFD8aYw
         BuUL+DdbSI9pMJRxDv1VCV0XeKhMhVkW2seBo58joTB2cFcD2tXF2TJ48zNL/FKES/uW
         i5pf0JkVt4+cnvSa8hgo9WDoWgZ8kseVC5DnhXEamO7LXrY2ZnvECGcj6um7UA/3ofWU
         yDfw==
X-Gm-Message-State: APzg51DFD4xgKyzcBy1i/8afKb3ZlrXOpKe4bKu6ZMgBxwLUWFORREXr
        sujqwGqciz47vGi5Qsw2DJdg2YovL04=
X-Google-Smtp-Source: ANB0VdaCRQWN77BUOsNqV1RJ3ILYcQH0vlY/uK4dIqA29H4VUtQsiSDreUvhPrqoPZtSNFKwiuyYUA==
X-Received: by 2002:a50:8c98:: with SMTP id q24-v6mr32122230edq.2.1536711426549;
        Tue, 11 Sep 2018 17:17:06 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l16-v6sm10380593edb.41.2018.09.11.17.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:17:05 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>, Jiri Slaby <jslaby@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv4 1/7] tty: Drop tty->count on tty_reopen() failure
Date:   Wed, 12 Sep 2018 01:16:55 +0100
Message-Id: <20180912001702.18522-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180912001702.18522-1-dima@arista.com>
References: <20180912001702.18522-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of tty_ldisc_reinit() failure, tty->count should be decremented
back, otherwise we will never release_tty().
Tetsuo reported that it fixes noisy warnings on tty release like:
  pts pts4033: tty_release: tty->count(10529) != (#fd's(7) + #kopen's(0))

Fixes: commit 892d1fa7eaae ("tty: Destroy ldisc instance on hangup")

Cc: stable@vger.kernel.org # v4.6+
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Jiri Slaby <jslaby@suse.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3fe4d3..5e5da9acaf0a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1255,6 +1255,7 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
+	int retval;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1268,10 +1269,14 @@ static int tty_reopen(struct tty_struct *tty)
 
 	tty->count++;
 
-	if (!tty->ldisc)
-		return tty_ldisc_reinit(tty, tty->termios.c_line);
+	if (tty->ldisc)
+		return 0;
 
-	return 0;
+	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	if (retval)
+		tty->count--;
+
+	return retval;
 }
 
 /**
-- 
2.13.6

