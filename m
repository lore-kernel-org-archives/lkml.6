Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F86C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106762075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=microgate-com.20150623.gappssmtp.com header.i=@microgate-com.20150623.gappssmtp.com header.b="fI5E2pxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfAADNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 22:13:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46726 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfAADNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 22:13:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so13152441ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 19:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PRlJLJKr5eFfT+b/vjdBWReTYKAn14YIYBq3f/2Pb8s=;
        b=fI5E2pxI2gH5i8BgT1zlgrKS3vX9KQCMyfSJiIb6FL+7CWXbOY3XEq8L5pyNsJTmvz
         APIXQpIkSd0qo/vwxGc8kugteAfH8K7yNj/W9DrIXuZ/Ar387ZkDVGgUZERhIeiijKsa
         wyRFg92n88ch/isKft0W9HwfgkbVGcnUDM+Gnw195LEsrsdqKpA0CMEDvKJQ6LJQgg3R
         gKyS2Cuq/cZuoGlJVEq4qyYgdPzaeuSngZPr2XGvF3uZ1Bz1jIKrgf853BdRm8+asKkV
         WG2NEqBnfLknUwgr6wBqhUhadizxXtjUvbouPXAvEuB68Z+c37LLG1seNZ11O+rgT4/k
         HYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PRlJLJKr5eFfT+b/vjdBWReTYKAn14YIYBq3f/2Pb8s=;
        b=h0Et2qC+P4piL86Sk8M4CwSxdNfcpxNVm2bIaIuYvOm4MC+kcEuEdqCDucoZxQJA3a
         UVGe7B13G/TxFJQ+8xIv7hqUCjoboDkAOkM8GcCz7twO8PYdAywFwyi+VW2JLUCIM2Dx
         Za/o7a4QO4pjbunAgmVtk8779RftIOI7a2GG04kD609/wmSTuXJvjRDKMQgM8QyHTvt8
         /F/6dtkznXeH4SlDxDMxXRGlgk+iLJKbwtXajKRcVpwonJObsgqE2G/yuVlxhEEEa+Yi
         4ZxlrtJiFpDl6HanOVXzx4qwJkHjvGmcZpROW5Mjux490AlDevfUZjJmiZar9irEL3z6
         rsIg==
X-Gm-Message-State: AJcUukeTFWr8i4oescZIu2O4Cc/Jmzfy6qyMJ7+UdJwhAMUHwVNW7IYX
        gi2iaSV5kdudtO/jMF3C/RTAsg==
X-Google-Smtp-Source: ALg8bN6iMFq6QaMzMaD57byM48sdF9G/4Ya+GeEemoe9FyifafIBWs+jJiRkuEkFuQSMQaaFJbRviQ==
X-Received: by 2002:a17:902:43e4:: with SMTP id j91mr38327898pld.147.1546312416225;
        Mon, 31 Dec 2018 19:13:36 -0800 (PST)
Received: from [192.168.1.77] (c.208.53.119.160.static.broadstripe.net. [208.53.119.160])
        by smtp.gmail.com with ESMTPSA id y71sm88127361pfi.123.2018.12.31.19.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 19:13:35 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
Date:   Mon, 31 Dec 2018 19:13:34 -0800
Cc:     Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        syzbot <syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <62FAC6A3-AC41-44CD-8ABC-79F404BF8CB1@microgate.com>
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Dec 31, 2018, at 7:11 PM, Paul Fulghum <paulkf@microgate.com> wrote:

NAK to this patch. It causes lost wakeups in both read and write paths.

The write path does not need changing.

The read path can be fixed by setting current to TASK_RUNNING at the top =
of the if (rbuf) block so the warning is not triggered by =
copy_to_user(). If this block runs the condition is satisfied and it =
breaks out of the polling loop where it is already being set to =
TASK_RUNNING and removed from the wait queue. This particular path just =
needs to account for the copy_to_user which occurs before breaking out.

I=E2=80=99ll make a patch to do this when I have the ability to test it =
in a day or two.


> On Dec 29, 2018, at 3:48 AM, Tetsuo Handa =
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>=20
> syzbot is hitting __might_sleep() warning [1], for commit =
1035b63d3c6fc34a
> ("n_hdlc: fix read and write locking") changed to set =
TASK_INTERRUPTIBLE
> state before calling copy_to_user(). Let's set TASK_INTERRUPTIBLE =
state
> immediately before calling schedule().
>=20
> [1] =
https://syzkaller.appspot.com/bug?id=3D17d5de7f1fcab794cb8c40032f893f52de8=
99324
>=20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot =
<syzbot+c244af085a0159d22879@syzkaller.appspotmail.com>
> Cc: Paul Fulghum <paulkf@microgate.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> drivers/tty/n_hdlc.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
> index dabb391..7835489 100644
> --- a/drivers/tty/n_hdlc.c
> +++ b/drivers/tty/n_hdlc.c
> @@ -589,8 +589,6 @@ static ssize_t n_hdlc_tty_read(struct tty_struct =
*tty, struct file *file,
> 		if (tty_hung_up_p(file))
> 			break;
>=20
> -		set_current_state(TASK_INTERRUPTIBLE);
> -
> 		rbuf =3D n_hdlc_buf_get(&n_hdlc->rx_buf_list);
> 		if (rbuf) {
> 			if (rbuf->count > nr) {
> @@ -617,6 +615,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct =
*tty, struct file *file,
> 			break;
> 		}
>=20
> +		set_current_state(TASK_INTERRUPTIBLE);
> 		schedule();
>=20
> 		if (signal_pending(current)) {
> @@ -673,8 +672,6 @@ static ssize_t n_hdlc_tty_write(struct tty_struct =
*tty, struct file *file,
> 	add_wait_queue(&tty->write_wait, &wait);
>=20
> 	for (;;) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> -=09
> 		tbuf =3D n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
> 		if (tbuf)
> 			break;
> @@ -683,6 +680,8 @@ static ssize_t n_hdlc_tty_write(struct tty_struct =
*tty, struct file *file,
> 			error =3D -EAGAIN;
> 			break;
> 		}
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> 		schedule();
> 		=09
> 		n_hdlc =3D tty2n_hdlc (tty);
> --=20
> 1.8.3.1
>=20
>=20

--
Paul Fulghum
MicroGate Systems, Ltd.
=3DCustomer Driven, by Design=3D
(512) 345-7791 x102 (Voice)
(512) 343-9046 (Fax)
Central Time Zone (GMT -5h)
www.microgate.com

