Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE1DECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A2C208C1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VojxLPD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A2C208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeGOOEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 10:04:42 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35460 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeGOOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 10:04:41 -0400
Received: by mail-lf0-f65.google.com with SMTP id f18-v6so14289620lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=B6OCQVNoKL3ERM72KMQHUkADhQugADJSrE6aOjnHvAs=;
        b=VojxLPD5Y27iGgR0rMM7imggva2RpLe8MEmIe4E1r0DN39f+9+armqGVo6uWVBO83U
         pDZJfzfry/Q+ZVNUcfthpGductafvAHIDo9az50RvyPvLk+FlSYJQTErD7QllfyENXEE
         Y2CAJXu+xIg1YnfiqS5lw/niz7A5JfMhjiFhm5AaE2J2viNuk2kQeY/Ty1C3UG8h8hSt
         7V8swjx+BO9bMilkpIV2KRa9oyd6Y8pYLftHQV1HcNoh4rzsVQq9b6NQCXB4fP1HB1ye
         wcsHfGyrqq7HPYqDV2PC2F2+AcQzYRrrQixNfto+LdvcXKxlyIKy99nfZdzUeo130oNP
         TbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=B6OCQVNoKL3ERM72KMQHUkADhQugADJSrE6aOjnHvAs=;
        b=toyAvosdsxzvyNzoZg99JNFHodMwt3H3WjpgYVvaFgv4dDtu8zTM3Nnaf5af/w6O9y
         nXX7A644Z1D4kaBv0y2nrNoVr/dzgmUlaxFlvUVpBVftdcZ/Pv/95wmVzyji76is5+d2
         yufPCsBD7PDzNeohYfeaSDELQfnOC0M8Ke4k6SNGnusEf4pyXepa8gBFe3/Hat16sADP
         NCNdakjvQOSNs8AuK4+sMkXONG+mYHU/m5tMRQdoxQzJkLYrQY4YiIHnB6RCodsIRIyU
         RCvHAofFJuvVXpmcxSQDfx50N9hfDizvg7UPesl8lef4eqYJQAkFhMkoPJSOpcG+O4JA
         Lhig==
X-Gm-Message-State: AOUpUlF53m5JIXghShK2oESRPI3xZbkvfLDIwY3qbA/VGcb2jLbHJrFW
        0fNvr2kmRXsBiOeQeGJ2DYs=
X-Google-Smtp-Source: AAOMgpdmxZhsBnl9/oBWa9qIL52mo2Lk0kNWtUzCWmye8g9lns4VCyZkFMLQzvxRIZGbCjJMjoqh2A==
X-Received: by 2002:a19:d54c:: with SMTP id m73-v6mr9156416lfg.27.1531662100098;
        Sun, 15 Jul 2018 06:41:40 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id w12-v6sm3868448lji.63.2018.07.15.06.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 06:41:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fehHI-0006WH-QT; Sun, 15 Jul 2018 15:41:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] tty: fix input-speed handling
Date:   Sun, 15 Jul 2018 15:39:32 +0200
Message-Id: <20180715133935.24964-1-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out we had some long-standing bugs in how we handle termios input
speeds. Specifically, we could end up setting the CIBAUD bits despite
the user leaving them cleared (i.e. B0, which means that we use the same
input and output rate). And once any of these bits were set we failed to
clear them on later updates, leading to incorrect rates being reported
back to user space.

Both issues could lead to an unexpected input rate being set on
subsequent termios updates unless the user actively clears CIBAUD.

Fortunately, no in-tree tty driver seems to use the input speed for
anything but to suppress line-setting updates, so the impact of this
should be mostly limited to the CIBAUD bits sometimes being incorrectly
set in returned termios data.

The final patch cleans up the conditional compilation of the BOTHER and
CIBAUD functionality by not having the latter depend on the former.

Johan


Johan Hovold (3):
  tty: fix termios input-speed encoding
  tty: fix termios input-speed encoding when using BOTHER
  tty: support CIBAUD without BOTHER

 drivers/tty/tty_baudrate.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.18.0

