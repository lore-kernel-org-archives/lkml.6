Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50433ECDFB2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086DA208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMsYDVyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086DA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeGOOEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:04:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33481 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeGOOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:04:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id t21-v6so27769641lji.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 06:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w3//MMegry/Mr6ueBbLz58daQRq7pq3d3GyFX/maU5A=;
        b=HMsYDVyGVqGaljWu5fCYI/iEVYQkforAo/aYnsJHVXT+uDynt5+kQFwwuiAfJXf8lW
         nBMT3LXDahWPg2mbfBcTF+RXgoGrAeCn5isoD43Pp1DjBfaMlZF55DSTUzQ4vSwbhFfb
         RLSas3AKJMkXMviWAMfjfIUfPhfw0bqGc2BGTAvlnynUR+92CakogxmES5vkht5DOHTM
         Z7/hs6v9dn5WeO6e220QSSVdFJbzmAT20dazFl8IdkrV+SdzXiUFgAfzCDcL9aj2qlA3
         zSTBzAwTA6Tg9GdRZF94THdQNDBhOA7T3xQMZwyrOfJTYRHaiDmNbNfJdO3GVaE3R388
         p4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=w3//MMegry/Mr6ueBbLz58daQRq7pq3d3GyFX/maU5A=;
        b=fahGFi0v+cixjj4CiFVVet7xOim2g89UgwJyibRmTP6zo1JbgMIB/TeMT48jREQe2L
         bimMAuQmGrcVWXwZcJzuHcGJmR0zutWqPuqhtHiUVPJ9fi8Dpkfq3kN7Qn1/1g4FWgy9
         oIJLUMFcZVYQN+u9xlx7e3IjgSNEsJdgrRR5IIaGMcuHdv4/K3cbcSnKKFK9P73GkgMY
         z6M+lYwUloA7dB9KvDaaLnlfgLHkYCe8VT5/gwoCTj8fkjrznaGq/yzC5VMmJkcj/+fI
         +OYneQYGCzEK4LlVD9tRjCFppv4bP5+xnwhaN2Rn+MsvY2XRPuAEkSFnloHRAQPTTXL7
         fmkg==
X-Gm-Message-State: AOUpUlHZ5nCOvtRcMQipeA1Mtbf9WwgTFyaH+pvZHX42Gv9ZAg7Z7Akg
        0hKeO5nI+Lur22tKRRxh0ONbTDhP
X-Google-Smtp-Source: AAOMgpf/8zX120KJJEwDDHy3nt6RaAPL/iQNDn3KHXQkUNG5ddV0m5SPxIZbGCYrUtYBdwdKSlNxnA==
X-Received: by 2002:a2e:4357:: with SMTP id q84-v6mr7525441lja.13.1531662100986;
        Sun, 15 Jul 2018 06:41:40 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id 97-v6sm4699525lfw.13.2018.07.15.06.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 06:41:40 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fehHI-0006WK-Uv; Sun, 15 Jul 2018 15:41:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] tty: fix termios input-speed encoding
Date:   Sun, 15 Jul 2018 15:39:33 +0200
Message-Id: <20180715133935.24964-2-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715133935.24964-1-johan@kernel.org>
References: <20180715133935.24964-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to clear the CIBAUD bits before OR-ing the new mask when
encoding the termios input baud rate.

This could otherwise lead to an incorrect input rate being reported back
and incidentally set on subsequent termios updates.

Fixes: edc6afc54968 ("[PATCH] tty: switch to ktermios and new framework")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_baudrate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 6ff8cdfc9d2a..a7a438f54e69 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -169,6 +169,9 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 		ibinput = 1;	/* An input speed was specified */
 #endif
 	termios->c_cflag &= ~CBAUD;
+#ifdef IBSHIFT
+	termios->c_cflag &= ~(CBAUD << IBSHIFT);
+#endif
 
 	/*
 	 *	Our goal is to find a close match to the standard baud rate
-- 
2.18.0

