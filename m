Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD648ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942BD20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHYSWca6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942BD20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGSJZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:25:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34869 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeGSJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:25:56 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so6483950edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=EkSFjcgUxnl8asIKE3cL4xQEJDYglhPXXggN7glmMEQ=;
        b=mHYSWca6qfCqdgNPHHp6CN3Yt46xhpaFR53XMSrhx/Xa2VMbPkjn5EMoiox6hTTEAh
         wvZVUx5CLMe3m05Ftp+iV51QRj+aoxHKsd6eD0cED8XZBhJZEn8kRvZNtzLwZiNQP+T3
         u1ypyqDHAb6V9WJ/yv4pLPx3kjZm4DNteY+YxA/qGZA5ACkP93mXKaTrlcH9BAxd0E2W
         fwNGWcrGvQAIwFI9vACJjwodUvg6i/TpFb8S78VvvKdfV9qBzncxhp2rjOGetEesZZSK
         6qEg35TLinUXR1QEosKaRRudxjnlFFCMFW0c5WQiIB6umvVCUjz/XT9wB9c+smOsSH6x
         rH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=EkSFjcgUxnl8asIKE3cL4xQEJDYglhPXXggN7glmMEQ=;
        b=iRZG2y/IP/lWygbByTQ7NHQBtKU2yE4gMoCqOfxViP/83nr3bTwTlxAv2yezsGnl8h
         JFYzR0rJXrrceMPvK/X0vVyuxt6RybIsCyDpmHTBUCBpNlcIu+VxKR0Uqn7obux1H7xG
         wPx/75dampZf7PXF0ApFWu5LXmIf9Sg0cteab24M9OOGoljSTV5DlRs+2176BcAZQy99
         z04XWkvo2ie047iu+yQKx/gIrv9oZOwU9dNGD8YhbM5CmSZATmpIpClgErVRw3aisT5w
         eVVzTTu5Nfr3Uix/BIAA7pOv0GoZa3r3wngCkn5UF9fZM7mynAlUnXIF3iAm/rnB2iWO
         /C7A==
X-Gm-Message-State: AOUpUlEq5GRkwp3gPw5x+z6aq1hF4LM+ZRSrO7tpNNVgvJTMzR26CzfY
        2eGiFStLfeqZA5E6I/AMwJtM1+ph
X-Google-Smtp-Source: AAOMgpd9reYwdeokNImLcy9Q0sxwsj8/2Z2+QzXsojWf5rQc3eiATGrYHhawROwptt7xSDlxb6Yf6w==
X-Received: by 2002:a50:fd93:: with SMTP id o19-v6mr9977324edt.73.1531989829841;
        Thu, 19 Jul 2018 01:43:49 -0700 (PDT)
Received: from squirrel.local ([2001:981:5f7c:1:8e70:5aff:fe05:accc])
        by smtp.gmail.com with ESMTPSA id j16-v6sm1477981edj.71.2018.07.19.01.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 01:43:49 -0700 (PDT)
Date:   Thu, 19 Jul 2018 10:43:46 +0200
From:   Matthijs van Duin <matthijsvanduin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <asarai@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric W Biederman <ebiederm@xmission.com>
Subject: [PATCH] pty: fix O_CLOEXEC for TIOCGPTPEER
Message-ID: <20180719084346.GA2360@squirrel.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Eric W Biederman <ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was being ignored because the flags were not passed to fd allocation.

Fixes: 54ebbfb16034 ("tty: add TIOCGPTPEER ioctl")
Signed-off-by: Matthijs van Duin <matthijsvanduin@gmail.com>
---
 drivers/tty/pty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index b0e2c4847a5d..678406e0948b 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -625,7 +625,7 @@ int ptm_open_peer(struct file *master, struct tty_struct *tty, int flags)
 	if (tty->driver != ptm_driver)
 		return -EIO;
 
-	fd = get_unused_fd_flags(0);
+	fd = get_unused_fd_flags(flags);
 	if (fd < 0) {
 		retval = fd;
 		goto err;
-- 
2.18.0

