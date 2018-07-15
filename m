Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E3FECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5194208E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJM5ncZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5194208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeGOOEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:04:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46375 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeGOOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:04:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so16754946ljj.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gdhf9BQPKgLrG3vOuSQF8ks4wZKV3uoquPzagwFOg/c=;
        b=qJM5ncZfnSaJWomdbSFpq9oMBul/RpfxSHPLkZh4wH3WSnl1/tEHleWZ5QAJFIi01v
         eV1mLYNqgABCJEmE+7UyBL5rTiTK/U/llb6RPNFGbhNEQqtGkL59Pa/UY28ryaA07q/R
         8rOYvbGQZpQZtbC0aJyQQn4JX6Ar/UVFHye/fPv6Lh04Wqc1fUtTSZXGMC7tj2gP1NEi
         w4jaYlorjjMt7YyruBO24WIe/jcFS1gf9ds6tfBbIxGCwokpLEjQG5/asG2Xb/8oqUaE
         3OQ5DZSFvxfRuQNDy5Ikzi1YJ65WA7vqO43ooK3BbmOJSAGXFDkNfu58rVLbS2wq/Ad6
         6vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Gdhf9BQPKgLrG3vOuSQF8ks4wZKV3uoquPzagwFOg/c=;
        b=GXYaaFESyfz/2ChZYLGe+H3gVwabNmE8w/6xeb6CM3gWuu1fxokWb8JckWSqjYdOcw
         Ncv4ukb0oQ6i0ZNKnsl0iK1GPDrF90JYStMFqq17+1WT63XpCpD39FCgGBs9udSlUYRx
         SBcnUrRqFxllXyyk7oA6CelxoI596qTakd5q3hOegILQzzT6WH5y8LHlD2a5JoPo6F10
         q7EiOO+Fu//QqjrG5//aHTilkV0l4iYlvbGdRrhbUj0ly7zSIJpIPzdCA5RVpQpMXZcT
         T9JShyCQ+0lUlAIhpTnlnx8E+GDo8JLDVteCgq7bMDop7SbBwI46biJfSIFHFMS7PcS4
         gc4w==
X-Gm-Message-State: AOUpUlFGSqIMrSE619oPjVMH3EwFEbsmYddZFlHy1tfFImsbSXc6m3Rv
        ssWpzNAljp3SRGCxPpe1zMw=
X-Google-Smtp-Source: AAOMgpfsTIVKBl5GMeobehzwUuycRwoNR7FRnnfRF0+dkzkqjvVsOc9qu2ePRS/C0YFO3ceKwkh7tA==
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr8456541ljf.79.1531662101464;
        Sun, 15 Jul 2018 06:41:41 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id w27-v6sm5269327lfk.5.2018.07.15.06.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 06:41:40 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fehHJ-0006WU-57; Sun, 15 Jul 2018 15:41:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] tty: support CIBAUD without BOTHER
Date:   Sun, 15 Jul 2018 15:39:35 +0200
Message-Id: <20180715133935.24964-4-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715133935.24964-1-johan@kernel.org>
References: <20180715133935.24964-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit edc6afc54968 ("[PATCH] tty: switch to ktermios and new
framework") arbitrary baud rates can be requested using BOTHER and input
rates can be requested using the termios CIBAUD bits (CBAUD shifted
IBSHIFT bits).

This functionality has been conditionally compiled depending on whether
an architecture defines BOTHER and IBSHIFT respectively, but would in
fact fail to compile unless both symbols were defined due to cross
dependencies.

Relax the IBSHIFT => BOTHER dependency so that an architecture could
theoretically support CIBAUD without the Linux-specific BOTHER, while
hopefully making the current conditional-compilation directives a bit
less confusing.

Note that the long-term goal is still to have all architectures support
both features, so an alternative could just be to have the lot depend on
BOTHER.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_baudrate.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 3e827a3d48d5..7576ceace571 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -100,11 +100,11 @@ speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 
 	if (cbaud == B0)
 		return tty_termios_baud_rate(termios);
-
+#ifdef BOTHER
 	/* Magic token for arbitrary speed via c_ispeed*/
 	if (cbaud == BOTHER)
 		return termios->c_ispeed;
-
+#endif
 	if (cbaud & CBAUDEX) {
 		cbaud &= ~CBAUDEX;
 
@@ -114,9 +114,9 @@ speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 			cbaud += 15;
 	}
 	return baud_table[cbaud];
-#else
+#else	/* IBSHIFT */
 	return tty_termios_baud_rate(termios);
-#endif
+#endif	/* IBSHIFT */
 }
 EXPORT_SYMBOL(tty_termios_input_baud_rate);
 
@@ -156,10 +156,11 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	termios->c_ispeed = ibaud;
 	termios->c_ospeed = obaud;
 
-#ifdef BOTHER
+#ifdef IBSHIFT
 	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
 		ibinput = 1;	/* An input speed was specified */
-
+#endif
+#ifdef BOTHER
 	/* If the user asked for a precise weird speed give a precise weird
 	   answer. If they asked for a Bfoo speed they may have problems
 	   digesting non-exact replies so fuzz a bit */
-- 
2.18.0

