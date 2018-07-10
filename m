Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17770C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B843E20878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcnO/Bw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B843E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbeGJUfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:35:44 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46598 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732290AbeGJUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:35:43 -0400
Received: by mail-oi0-f65.google.com with SMTP id y207-v6so45185341oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=V2smU+iuYemdHkwNaw9p0fSO87b51nhzlegfg6X24FU=;
        b=qcnO/Bw89+eU4jMfLC4RPXqdl2TAYZtPTwWWXugMCp4akSMDAa5LB79QVnRU3gL+MD
         xCLNb8PfSDuNg+m1PtzKm6Xpkt4Dy9zi+aXzPlFmQFqARjnbs2ppy0lbJL9GRAnDqV0+
         NdWPiDHTAS6Hb0mbe6m13U2cCteWmWf4W6XD6bnXS9YJoOeklHBkdIk9xNYBDK1kP2ky
         02fvcWujGY/v4ZIWgQIWnD3B2i447t97lCfJjrHCIvzN/4sB4VF5oRbZONcA3LG7h7Ae
         dZG79aaOpJSCbarN4Pq5rpOZnj/7zWbF76ZG51e6xiohcnBS8KbaleU+S5JUd5fi1xND
         AyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=V2smU+iuYemdHkwNaw9p0fSO87b51nhzlegfg6X24FU=;
        b=ZXCQwSOm/k5sHKMR04/1iUpJZlxGDJCW7h9CLevRcCOQK9W59F7rQ3uPnDG84oJwwj
         S0vCSCWo+tQBjrNW5/NyIBLk/525+0qzxchUR3E91ctjlYoy5t2N7qe4IgMnnMLYLzyI
         /2SIXhm05EgHXC/JjgcrlwCpR3Gd9+vRZaLJagxgVCz0ptWMxMt9mMa8MTKUelF8WzFL
         w1/l645EON54VaDOJpbtu1yVrKmQBIKwcmPLAlpFyo/0OGz+uND62CG/l3oqmV58e8du
         XoU4bIjWQV6vOuTDhlP2aU0UYd6WcAC7Hh1wC5DtUJ6JWjoXXFu84snYLlrGrHpUUyIB
         7/LQ==
X-Gm-Message-State: APt69E1EMhEBfiH0L5c8nMECSZYHUuBk7skKzffzjxgqYMl8jdsuz1+C
        b1bY22dnR6nr7NBnefnhc56r6mGbOLic/431wbbp1w==
X-Google-Smtp-Source: AAOMgpcQmQ7v/kywTipyOoar17wuAu4/axwe/e/bTKukTqlFjpOGH8H3QGd56wYTqApEHh4eQ2OAk7bMhzglyTa3Zzs=
X-Received: by 2002:aca:f383:: with SMTP id r125-v6mr18104386oih.6.1531254900492;
 Tue, 10 Jul 2018 13:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180707015344.146672-1-jannh@google.com> <20180707082926.66zbedgq5zqjfbjx@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20180707082926.66zbedgq5zqjfbjx@var.youpi.perso.aquilenet.fr>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Jul 2018 13:34:33 -0700
Message-ID: <CAG48ez3bFxC-MrCKSNtr9di8qWAessD-ZP+51PAMiC2TMZSXOw@mail.gmail.com>
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>, kirk@reisers.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 1:29 AM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> Re,
>
> Could you review, test, and resubmit the patch below instead?

Er... you mean, you want me to take your patch, add my Signed-off-by
below yours, and then send that?

> Samuel
>
>
> If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
> the loop to copy as much data as available to the provided buffer. If
> softsynthx_read() is invoked through sys_splice(), this causes an
> unbounded kernel write; but even when userspace just reads from it
> normally, a small size could cause userspace crashes.

This looks sane to me. I've also tested it, and it seems to work.

Some random thing I noticed, but I don't think it has anything to do
with this issue: In some runs, when the console is repeatedly printing
"Debian GNU/Linux 9 debian tty1\n\ndebian login: " in response to me
pressing enter repeatedly, /dev/softsynthu (read in 1-byte steps)
seems to return things like "Debian GNU slash Linux 9 debian tty1 \n
debi login: ". I don't understand why it sometimes says "debi login"
instead of "debian login".
> Fixes: 425e586cf95b ("speakup: add unicode variant of /dev/softsynth")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>
> --- a/drivers/staging/speakup/speakup_soft.c
> +++ b/drivers/staging/speakup/speakup_soft.c
> @@ -198,11 +198,15 @@ static ssize_t softsynthx_read(struct fi
>         int chars_sent = 0;
>         char __user *cp;
>         char *init;
> +       size_t bytes_per_ch = unicode ? 3 : 1;
>         u16 ch;
>         int empty;
>         unsigned long flags;
>         DEFINE_WAIT(wait);
>
> +       if (count < bytes_per_ch)
> +               return -EINVAL;
> +
>         spin_lock_irqsave(&speakup_info.spinlock, flags);
>         while (1) {
>                 prepare_to_wait(&speakup_event, &wait, TASK_INTERRUPTIBLE);
> @@ -228,7 +232,7 @@ static ssize_t softsynthx_read(struct fi
>         init = get_initstring();
>
>         /* Keep 3 bytes available for a 16bit UTF-8-encoded character */
> -       while (chars_sent <= count - 3) {
> +       while (chars_sent <= count - bytes_per_ch) {
>                 if (speakup_info.flushing) {
>                         speakup_info.flushing = 0;
>                         ch = '\x18';
