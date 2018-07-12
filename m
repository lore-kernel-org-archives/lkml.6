Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E7AECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C42F20842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jv2sWVTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C42F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbeGLXYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:24:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40379 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbeGLXYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:24:52 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so58921124oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oSs5UYCNMeiEBlN6QkhbOXRCeOwR0rDlPf/zXQ7SVU=;
        b=Jv2sWVTaNMh0AYjkBxz4kmat+0lHYv7aNIPVrIGBb4DJyfS2q3G2e6ueNLgdAsMy5U
         lhGlckzoyErqT/qzebv8z1lOEkpvggVD4eATdCcZmbuY+ittJd0M9+s6wzld6nC/fFLP
         9Katp5oyQtOI1k6QAgW3rAUNyrqBeRwmHV/Hq2f3eFcX/YG3A/QeeDSIgzi3ZJq8hTcw
         6GNmlLxcse2UFQxlYF+FRVOKh+5z+EdbG8fsPUxoqzk1gIte0q4QzukkI1jXDNYtf+Z+
         DQ+OjQaXt1g2iOoZH//kAGz6NAERpJD/L5qFphVrAQMnmIEm2r4nMZpVh7IMb58clWbB
         n2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oSs5UYCNMeiEBlN6QkhbOXRCeOwR0rDlPf/zXQ7SVU=;
        b=QdqJ4GZIHeiLrYmt87dINk1z7L7K1HO01Smkk+JiUbxaiEHoeWu7xPJt/DwQF61UQ3
         4CFUPFEA52/bfe4g3Hu+UEsbWjZS0s+hZCQIHCFELeWzX3PLwz6zjttIPWdSR55FQx6Z
         kBJacnspMv7PhTPNtGCsQVLZiY/x673sfCnq/5dXDf/m2c7eu/ugITgslEncRnBidcms
         ezxSlgXqLgz9h4E2vfcayyizjH7OJHtfldTa+AmJ1E/ymw6cX+E/LbZ0IVULZs2UgXL2
         JSGGOXcumRK6YXW9aToXitUKA1hVV6J/mu3/51JTd1uao7n+SCy6oYZt2x6zkan9HzAQ
         iohw==
X-Gm-Message-State: AOUpUlEG8yrDPXIAdzFK44utjrf/VO+EK7gvkMYW1SHcqZdpXkj+s8eX
        g+lJOupkUIKz1Irr/zSDkXyrjOHGzDKaIl9oFs05/A==
X-Google-Smtp-Source: AAOMgpcnQp3KP2ZpzLUTgUQjpxetvsVfylrIAZmO+7vmEODE4coCxHihmQDF16C3LrSjBdLcON1TEZX6c8FTcJ67y7s=
X-Received: by 2002:aca:d015:: with SMTP id h21-v6mr4812791oig.142.1531437185883;
 Thu, 12 Jul 2018 16:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180712222935.257776-1-jannh@google.com> <20180712224753.GE30522@ZenIV.linux.org.uk>
In-Reply-To: <20180712224753.GE30522@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 12 Jul 2018 16:12:39 -0700
Message-ID: <CAG48ez0ZLzh1L8HieUJ+UmbQewRMc_0hwJG7-MB=WR1h=VagZA@mail.gmail.com>
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>, kirk@reisers.ca,
        kernel list <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 3:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jul 13, 2018 at 12:29:36AM +0200, Jann Horn wrote:
> > From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> >
> > From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> >
> > If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
> > the loop to copy as much data as available to the provided buffer. If
> > softsynthx_read() is invoked through sys_splice(), this causes an
> > unbounded kernel write; but even when userspace just reads from it
> > normally, a small size could cause userspace crashes.
>
> Or you could try this (completely untested, though):

I think this has the same problem as my original buggy patch: At the
point where you notice that you'd overflow the buffer, you've already
consumed a character from the synth buffer. You'd have to put it back,
and since the spinlock protecting it has been dropped, that's a bit
weird.

Also, I'm not sure whether Greg prefers fixes for stable kernels that
don't also contain cleanup?

> diff --git a/drivers/staging/speakup/speakup_soft.c b/drivers/staging/speakup/speakup_soft.c
> index a61bc41b82d7..198936ed0b54 100644
> --- a/drivers/staging/speakup/speakup_soft.c
> +++ b/drivers/staging/speakup/speakup_soft.c
[...]
> @@ -224,11 +221,14 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
>         }
>         finish_wait(&speakup_event, &wait);
>
> -       cp = buf;
>         init = get_initstring();
>
>         /* Keep 3 bytes available for a 16bit UTF-8-encoded character */
> -       while (chars_sent <= count - 3) {
> +       while (iov_iter_count(to)) {
> +               u_char s[3];
> +               int l, n;
> +               u16 ch;
> +
>                 if (speakup_info.flushing) {
>                         speakup_info.flushing = 0;
>                         ch = '\x18';
> @@ -244,60 +244,47 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
>                 spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>
>                 if ((!unicode && ch < 0x100) || (unicode && ch < 0x80)) {
> -                       u_char c = ch;
> -
> -                       if (copy_to_user(cp, &c, 1))
> -                               return -EFAULT;
> -
> -                       chars_sent++;
> -                       cp++;
> +                       s[0] = ch;
> +                       l = 1;
>                 } else if (unicode && ch < 0x800) {
> -                       u_char s[2] = {
> -                               0xc0 | (ch >> 6),
> -                               0x80 | (ch & 0x3f)
> -                       };
> -
> -                       if (copy_to_user(cp, s, sizeof(s)))
> -                               return -EFAULT;
> -
> -                       chars_sent += sizeof(s);
> -                       cp += sizeof(s);
> +                       s[0] = 0xc0 | (ch >> 6);
> +                       s[1] = 0x80 | (ch & 0x3f);
> +                       l = 2;
>                 } else if (unicode) {
> -                       u_char s[3] = {
> -                               0xe0 | (ch >> 12),
> -                               0x80 | ((ch >> 6) & 0x3f),
> -                               0x80 | (ch & 0x3f)
> -                       };
> -
> -                       if (copy_to_user(cp, s, sizeof(s)))
> -                               return -EFAULT;
> -
> -                       chars_sent += sizeof(s);
> -                       cp += sizeof(s);
> +                       s[0] = 0xe0 | (ch >> 12);
> +                       s[1] = 0x80 | ((ch >> 6) & 0x3f);
> +                       s[2] = 0x80 | (ch & 0x3f);
> +                       l = 3;
>                 }
> -
> +               n = copy_to_iter(s, l, to);
> +               if (n != l) {
> +                       iov_iter_revert(to, n);
> +                       spin_lock_irqsave(&speakup_info.spinlock, flags);
> +                       break;
> +               }
