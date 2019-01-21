Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA67C2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEB120879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgC3MkoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfAUPjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:39:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45656 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfAUPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:39:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so14822234oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhijNiNOCkGzMTLzeq4IQBBDViImJ39fHjaMWi0movs=;
        b=CgC3MkoNtfXvAAdDnuEAASNWLtOxt6cvOTSXGOzcNKQtYsBCMLN65W8LA1PGc+nziR
         xd4XYeYX88E7zYy1Gq6+Pp6aLHAUsooduif8kEK7IlloPrLNqC0zfKV4Y411/5NOcT3e
         Eggi55sQK4BL7UE8bYi1lSnUUn3eGkmeUZtplfHVZD0YkE5TKz8jEYaAi8ReFHoieNT+
         0VfV2B5F3uk1gp27f1UzhsIkpkZnzn3fMDwo4XCq0+W6yBWjQ/h6PJvS9Oc6OqLfAtH9
         LG18H4RatFX56moHnrcXJZo/1Rbi3LVqgUtJL3wZFWiCMLkywqT1228sKbZnuobfBiUM
         /NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhijNiNOCkGzMTLzeq4IQBBDViImJ39fHjaMWi0movs=;
        b=W/DcIygBUkdpMTPwMLDujSDn7v9rfaM7/CZFh7HaHFU57xswqttzJnw05N5INA5mac
         FIKrubAjGe5b6x7Gy1dzHlyRptWzEpP+lTSf37DT9tU2wMx+LXYwv3iZ64vtBIQ7oMb6
         fPkkJI38pC+TVzuEExzZ74bnqzwLsadzkgBcbi8bwMVSGwxcZLdSmIaozhm2YPCMWsmn
         27ZCf2lbsPR1WaIHOe+t0Y2SAXvlkI+D8lu1rvxlEJV1Cv9EIcpBNwZJ20+3kEeo54PZ
         VSIOF3aadolQ183tk8tzQMsbbAJNrN31f4ENOSAacUebxvyy1HR5WgYvuMZ87JhvlSfw
         QriA==
X-Gm-Message-State: AJcUukdDQtIWrxKTusnrCDfsuUPcjmyLZE8iqVuRtbyzbJ3y1IGjCxMm
        wR601kNU/YyeCs/UY1eFI1R+FWrQAV8bjUl3woY750QzqLJqmA==
X-Google-Smtp-Source: ALg8bN5PcgAYujxX4nrJwoGgMFBUpNk4CyVqDTLBCuNpprCB1EItV4vRNe/WKUQh5B1Ikhsrw6zmCbxATHuEJf1ym6Q=
X-Received: by 2002:aca:3c06:: with SMTP id j6mr5813488oia.126.1548085139791;
 Mon, 21 Jan 2019 07:38:59 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez06mDExELyTYN7MZQ3FjGcLx9ASc5HnxW8NQbfTAPX=Qg@mail.gmail.com>
 <20190119091108.GF10836@kroah.com> <20190120095205.GB28267@kroah.com>
In-Reply-To: <20190120095205.GB28267@kroah.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Jan 2019 16:38:33 +0100
Message-ID: <CAG48ez0=Mcgk15EWBfVw-X7gB2hMJFULRA_w429-uyPZotdqNA@mail.gmail.com>
Subject: Re: [BUG] tiocsti() NULL dereference if ld->ops->receive_buf==NULL
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 10:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jan 19, 2019 at 10:11:08AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Jan 18, 2019 at 08:09:07PM +0100, Jann Horn wrote:
> > > Hi!
> > >
> > > When a line discipline doesn't have a ->receive_buf handler, tiocsti()
> > > attempts to call a NULL pointer. Both tty_n_tracesink and
> > > spk_ttyio_ldisc_ops don't have such a handler.
> > >
> > > To reproduce, build a kernel with CONFIG_SPEAKUP=y and
> > > CONFIG_SPEAKUP_SYNTH_SOFT=y, set speakup.synth=soft in the kernel
> > > command line, and run the following code as root:
> >
> > <snip>
> >
> > Ugh, thanks for finding this.  I'll look at it later this afternoon...
>
> It looks to be a simple change.  We can't really "fail" this ioctl if
> there's nothing wrong with the structure of the call, so we can just
> quietly "eat" the character, given that the line discipline doesn't care
> about it.
>
> So, any objections to the patch below?

No objection from me.

(spk_ttyio_ldisc_ops has a receive_buf2 handler, but I don't know
whether that should be invoked here or not.)

> -----------------
>
> Subject: [PATCH] tty: Handle problem if line discipline does not have receive_buf
>
> Some tty line disciplines do not have a receive buf callback, so
> properly check for that before calling it.  If they do not have this
> callback, just eat the character quietly, as we can't fail this call.
>
> Reported-by: Jann Horn <jannh@google.com>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/tty_io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 23c6fd238422..21ffcce16927 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2189,7 +2189,8 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
>         ld = tty_ldisc_ref_wait(tty);
>         if (!ld)
>                 return -EIO;
> -       ld->ops->receive_buf(tty, &ch, &mbz, 1);
> +       if (ld->ops->receive_buf)
> +               ld->ops->receive_buf(tty, &ch, &mbz, 1);
>         tty_ldisc_deref(ld);
>         return 0;
>  }
> --
> 2.20.1
>
