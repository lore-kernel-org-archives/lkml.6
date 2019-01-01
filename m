Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CF6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4898C2171F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=microgate-com.20150623.gappssmtp.com header.i=@microgate-com.20150623.gappssmtp.com header.b="dih6BhoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfAAU24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 15:28:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44220 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfAAU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 15:28:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so13705238plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 12:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VMXygqeRMN1W83XBoaIlpxbglZRQRMOh3rD875r6cPc=;
        b=dih6BhoAxbu2i4lGmB8B/RjzmpSjs1nIOpYVxgIZRJoT3fnpeEq/QZdthHkRXvWj0t
         1GWqd0k5VblW1iLp8KoiuilsPPpGdZ79y6IbsBf6FnoVTovmHR+0i1JhX/P4ldV5/EaN
         9RbRiyiI2OfiNBDBZ8SnJyWewl11bkQV7LgeTKAhY/PzcYeqN2TEU55HLkbglMbun4nq
         9ZzI02CGlJz7iSLcRb+HJ86KSTu9Lv3E3O9ci68ShRinr+7onauAoVL3XBDskkTLZjcW
         GHygWXV7IEb/l7hWOvr6rFpgG7Z7+F//s317NIfwUdxXGlO7G+ReGBwuQyggNPvewSK1
         281g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VMXygqeRMN1W83XBoaIlpxbglZRQRMOh3rD875r6cPc=;
        b=HSGn/EPGugJNtNpmF7AvbrRZ77AtyKhxGg5Nd4p03pelLYP+MPmukRbTtXjW1EaEXf
         pzeueWGwfjhvHqpEaKvLagCWz1jAeuGMgY/vvLac+GMHlgIlo9noukI0O4ddEl4VZ7EA
         poMABbC9ekuxopCYvGjxXZMeBTbKAOYI7Ad9ySRjadvxC1F9d1OmtDIR7A1WqXQscqhE
         yeA+bivpKkYBJp4etSWdGoJS1ec/9VqVlZ895dHlyqN831GjkjBUqLFN1cOMatIwxYRG
         BI1+gds9LwPyJMovTzOVEUGya2wznmTYk6S3cJ67kelXNJ0Td34JSYW0caqVNfwMRIfK
         jo9Q==
X-Gm-Message-State: AJcUukfbkDPhl8cxL2Sr5l0ecERZCX65p61vH07i/z9vnsd2i+OUPBgK
        z4GNYXGyVyy7A9hnDelpEuCUSQKotG0=
X-Google-Smtp-Source: ALg8bN7WUZClRGzOOlUZz9RiGL4pLDK3+xWx2iHuIX8mnc32H/vaqcVLAYxSxpiJ0JpxdbUtu/X8yA==
X-Received: by 2002:a17:902:9305:: with SMTP id bc5mr40950710plb.86.1546374534850;
        Tue, 01 Jan 2019 12:28:54 -0800 (PST)
Received: from [192.168.1.77] (c.208.53.119.160.static.broadstripe.net. [208.53.119.160])
        by smtp.gmail.com with ESMTPSA id t5sm76141876pfb.60.2019.01.01.12.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 12:28:54 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH] tty/n_hdlc: fix __might_sleep warning
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <62FAC6A3-AC41-44CD-8ABC-79F404BF8CB1@microgate.com>
Date:   Tue, 1 Jan 2019 12:28:53 -0800
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>,
        jslaby@suse.com, syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F23DE81F-C976-4AED-8990-84A6ADC1BF1F@microgate.com>
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <62FAC6A3-AC41-44CD-8ABC-79F404BF8CB1@microgate.com>
To:     "linux-kernel@vger.kernel.org Mailing List" 
        <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix __might_sleep warning in tty/n_hdlc.c read due to copy_to_user call =
while current is TASK_INTERRUPTIBLE.
This is a false positive since the code path does not depend on current =
state remaining TASK_INTERRUPTIBLE.
The loop breaks out and sets TASK_RUNNING after calling copy_to_user.=20
This patch supresses the warning by setting TASK_RUNNING before calling =
copy_to_user.

[1] =
https://syzkaller.appspot.com/bug?id=3D17d5de7f1fcab794cb8c40032f893f52de8=
99324

Signed-off-by: Paul Fulghum <paulkf@microgate.com>
Reported-by: syzbot =
<syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
=E2=80=94
--- a/drivers/tty/n_hdlc.c	2018-12-23 15:55:59.000000000 -0800
+++ b/drivers/tty/n_hdlc.c	2019-01-01 11:44:47.148153954 -0800
@@ -597,6 +597,7 @@ static ssize_t n_hdlc_tty_read(struct tt
 				/* too large for caller's buffer */
 				ret =3D -EOVERFLOW;
 			} else {
+				__set_current_state(TASK_RUNNING);
 				if (copy_to_user(buf, rbuf->buf, =
rbuf->count))
 					ret =3D -EFAULT;
 				else

=20=
