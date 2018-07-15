Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D521BECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF61208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4ON2ZlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF61208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbeGOOEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:04:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41138 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeGOOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:04:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so22995477ljy.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8BQ0IHaATCYoeTqwviFqp/+r2Wdc9WKKUjlXlfEVTJM=;
        b=X4ON2ZlOBXVIZ7yepqQX/70owlb6Ksgcju2K9lJ3ZQ6L5WytzrJWLBti3kqNGZ6lYK
         hEoStBzcM9DudHd5K4BPApR5s75Zauoe74HlWpanF58pwapjVfhKlYB7CYsDs7e3KI1w
         KWfgpPeiOUaSHrErnPOMwvO5lNIqQoh4AwkZIoJQ6AX8zHozBdbHjUKsy/MbQZGacpvl
         4bt+XIBrQ7uJmNxorcc+ztaN1Kq2MbwR1a104IH42APHhVw0xu6osz/D1Ms98YCf6ZK7
         U1RIhlg9qt0kRh+UN2kAgcCxRywMyKc6TQ4vyslWfTB5jZOrC+H2DTvodfIh0agd0k1v
         rYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8BQ0IHaATCYoeTqwviFqp/+r2Wdc9WKKUjlXlfEVTJM=;
        b=GCtnzPEU13BP5hdBb9is/A75GqIO2+adIz1ti8avkq7VwcAb4loUxhHz5uI+02sRk9
         QlWvQpX5Vo5wxR2izbrSCu034Zn74fsQXPHQeJq0QefskOJkqmGuJbBvjAOfx3nyb65A
         UGYeUOZQZRHx8I13L6vvl15tmq0MuxARrOoe9btvNHuaelTFwgetbvl1KKekJoVSZfL5
         VqDZVsShEdKBysWIUuD3S72ufeJlelUz6unY7Vya5K6Hd6TXblASZEPG7j93igL3JZI1
         NAZ4eWySVJeB83d8ZIB4uRu2HXyqfl/ug/fdusofBR6HnP1UJ7vI3EVhDA8eJBoykEtl
         2niA==
X-Gm-Message-State: AOUpUlHAZ+nTp0zIBTP8R5IkAxyao5imb71Daa2DaB4ogaNLYdLUVyzg
        2qWMAmiotfsaiL6TCXKvTQ4=
X-Google-Smtp-Source: AAOMgpc7DuQPWsPCzzBkYk1pSY2If36bO846n8dg/jk4AFphX21EZULr2oiIxgNxGX98S9bk6exJJg==
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr7739669lje.70.1531662100519;
        Sun, 15 Jul 2018 06:41:40 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id n17-v6sm4436982ljb.82.2018.07.15.06.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 06:41:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fehHJ-0006WP-1t; Sun, 15 Jul 2018 15:41:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] tty: fix termios input-speed encoding when using BOTHER
Date:   Sun, 15 Jul 2018 15:39:34 +0200
Message-Id: <20180715133935.24964-3-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715133935.24964-1-johan@kernel.org>
References: <20180715133935.24964-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the termios CIBAUD bits are left unset (i.e. B0), we use the same
output and input speed and should leave CIBAUD unchanged.

When the user requests a rate using BOTHER and c_ospeed which the driver
cannot set exactly, the driver can report back the actual baud rate
using tty_termios_encode_baud_rate(). If this rate is close enough to a
standard rate however, we could end up setting CIBAUD to a Bfoo value
despite the user having left it unset.

This in turn could lead to an unexpected input rate being set on
subsequent termios updates.

Fix this by using a zero tolerance value also for the input rate when
CIBAUD is clear so that the matching logic works as expected.

Fixes: 78137e3b34e1 ("[PATCH] tty: improve encode_baud_rate logic")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_baudrate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index a7a438f54e69..3e827a3d48d5 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -157,16 +157,20 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	termios->c_ospeed = obaud;
 
 #ifdef BOTHER
+	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
+		ibinput = 1;	/* An input speed was specified */
+
 	/* If the user asked for a precise weird speed give a precise weird
 	   answer. If they asked for a Bfoo speed they may have problems
 	   digesting non-exact replies so fuzz a bit */
 
-	if ((termios->c_cflag & CBAUD) == BOTHER)
+	if ((termios->c_cflag & CBAUD) == BOTHER) {
 		oclose = 0;
+		if (!ibinput)
+			iclose = 0;
+	}
 	if (((termios->c_cflag >> IBSHIFT) & CBAUD) == BOTHER)
 		iclose = 0;
-	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
-		ibinput = 1;	/* An input speed was specified */
 #endif
 	termios->c_cflag &= ~CBAUD;
 #ifdef IBSHIFT
-- 
2.18.0

