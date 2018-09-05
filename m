Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B53C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85EB20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoeisPVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85EB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeIEQoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:44:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEQoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:44:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id x26-v6so3339969pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/k463ZanMjsoWadUXblNLFmCdOoPpyoSHFjZzLxxEM=;
        b=NoeisPVWdx8XXIrAbsFrQAI12yH85OVrvzC5A/oONpWW9ZVxdQbbuUMHliHocW1tn6
         bGzGnmURaYqzgxmw439hmyYmEx0IEvO5v13AjCiqU4qM3k41j3PDGPnq09KeEfsZIQnt
         XfIbj9ScluLShHX4A99rMVlZR7FUvy9JtdryfbsINXyPwyHooPtC1LqONPbm7QmmAYOk
         mBE2fNqpfqmgIu8+JaqJCW0ASIFJ1aTyheM/H9+PSxZ+xWRGFDlTduSjPudj6vq04yC8
         hyK/aGu1MbbTpGB6cw7MEs5v/SOPx/uQ67Nc+nONDLQnCbPQepo4JzKx/pihN7aCxrKI
         UAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/k463ZanMjsoWadUXblNLFmCdOoPpyoSHFjZzLxxEM=;
        b=ZuXL+o5iQAtvD7cSOvu4uuGCDyrD8YIJ1eqNyygqL9FcLc3Zh7DL14A/2kZz19iyDL
         8EZl8obJ7PrORyMvKaA+aKt+mBsOYW65M/h/oad3lJ42r0qkCHgdnIrSVVuG4AiD2eA+
         4ke9spoGGSdhdUpnm5uS68aZixnVlDMWLcBvGYRpJZQllHELOEi2jrft+PnDZA/RdqTB
         0tqSX9bqmFVRWa1NxmokESNSei455tlPOaMHGuI9V4M5Sy0el7FiBK5uqiBgkYBQscir
         W1herok4vi+qH7ZExxwAZiZIkLr1CskzYFQUXek067U6IK6p33drQGf8E0Sb7lLAIx8t
         PvdQ==
X-Gm-Message-State: APzg51DSuyyTNrmCxKneqr5VFF5McpQqTUmrxC+GQONA5BjiV5KeYCy4
        G5KPgXVSy9i9acdLE6UySeI=
X-Google-Smtp-Source: ANB0VdbElfZsCLW75nYrJWa4p6Mp7Az7oj5A3K1wSZQKk+2onqfHvJJ65J7mG7RtCZ/zgljB5DLOyg==
X-Received: by 2002:aa7:860b:: with SMTP id p11-v6mr40039080pfn.247.1536149694982;
        Wed, 05 Sep 2018 05:14:54 -0700 (PDT)
Received: from roar.local0.net (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id w5-v6sm2496227pfn.44.2018.09.05.05.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 05:14:54 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Matteo Croce <mcroce@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH 1/3] tty: hvc: hvc_poll() fix read loop hang
Date:   Wed,  5 Sep 2018 22:14:37 +1000
Message-Id: <20180905121439.23809-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905121439.23809-1-npiggin@gmail.com>
References: <20180905121439.23809-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop") causes
the virtio console to hang at times (e.g., if you paste a bunch of
characters to it.

The reason is that get_chars must return 0 before we can be sure the
driver will kick or poll input again, but this change only scheduled a
poll if get_chars had returned a full count. Change this to poll on
any > 0 count.

Fixes: ec97eaad1383 ("tty: hvc: hvc_poll() break hv read loop")
Reported-by: Matteo Croce <mcroce@redhat.com>
Reported-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Matteo Croce <mcroce@redhat.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a87bea..c917749708d2 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -717,10 +717,13 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 #endif /* CONFIG_MAGIC_SYSRQ */
 		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
-	if (n == count)
-		poll_mask |= HVC_POLL_READ;
 	read_total = n;
 
+	/*
+	 * Latency break, schedule another poll immediately.
+	 */
+	poll_mask |= HVC_POLL_READ;
+
  out:
 	/* Wakeup write queue if necessary */
 	if (hp->do_wakeup) {
-- 
2.18.0

