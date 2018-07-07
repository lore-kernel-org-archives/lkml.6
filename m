Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFBFC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B33521A72
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/3uhpeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B33521A72
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbeGGIXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:23:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37383 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeGGIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:23:20 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so27657017oib.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 01:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1kQhWf6wcAxnbXg2tkIAqX9L2qKCRWaIGDggFEKLUf4=;
        b=p/3uhpeXrXJ67OfxDgfd6PVO2xHZ8PD2jAMkJ0kzFH9XNWgUxvLPvloJH1IIDkA74w
         p51fXhuz/NwNwgBlc4JcEE1Erbpca8ohNmVdsPqbK+ugUIREwWU1IyZkIzxlz6rIxQUO
         FRXnifLAGmvo4xwFG5FjV1KkU5kp/agmnpot4qEN0AhoC2yPfKE12c33m3qn1uAfRCfh
         OszVhSjqcIbrEJ6VZlvS0KD/ibYJY9EhB8OrFMzjXMtQu6c8UQ4VITPd5OUp0z2wAvsY
         tsqDlJ7T3iUE0jRdgkPbDuzLRerT9UyJ6tU8xAqKpvl1z9js0fpdaJYQEb2S1+UrZNJn
         HJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1kQhWf6wcAxnbXg2tkIAqX9L2qKCRWaIGDggFEKLUf4=;
        b=gJ9EvqxbuWn/ZA6tKT8zj+bRHgB/oBMxl3XSwRlTptvjVk1RpsKyUPAcJrYHqXgrBQ
         vCZrNqk564Vht63KRoJ8HR0UFqL2FXDzzEslJO7gYJ3Cob8MAkKvX1IVygWIlIPZ01By
         gxlITJ3RxXeVdCTYgZk5/E8VrCPQRu8qBTUj8AzuEsTSIQ9Y3BQ83TyVixekiKx1cDYr
         /mzrCs7cFd2VnUiILY3rzC5AAEp4wv3ul+JWWYRdcN9xj4KDauv376ghlQBtTqnvbgJ3
         w2vbkiFXhlPS1cneMWOrNEpRjejrvq4UmCJ9jQ9I448SznFZ3tMBrv+Lk+7iySudDzBQ
         ZmIQ==
X-Gm-Message-State: APt69E2VtXblqZRGtZH8ZOuFOr2Fzmuxz80DOCPZed9cCXeBqpIhqkpV
        iZfaAHbCEa3fd6WwHIt/IYkh2gWNjejJbkJDGVxBrw==
X-Google-Smtp-Source: AAOMgpeH1ehD8ouJpqh9XjMjHsV80+P4lwuO/PxCn+HNvyzgjI5zXVicc9W1sz3zHG0z8BvnYKYPhGYMrGuXPxcqsY8=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr13394972oiy.219.1530951799119;
 Sat, 07 Jul 2018 01:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180707015344.146672-1-jannh@google.com> <20180707081347.czde44j6rjepjpkf@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20180707081347.czde44j6rjepjpkf@var.youpi.perso.aquilenet.fr>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 7 Jul 2018 10:22:52 +0200
Message-ID: <CAG48ez3pPcrA8B9bLwuht1Az8EXbDZa1fGmx73esvZBpmwifpg@mail.gmail.com>
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
To:     samuel.thibault@ens-lyon.org, w.d.hubbs@gmail.com,
        chris@the-brannons.com, kirk@reisers.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 10:13 AM Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> Jann Horn, le sam. 07 juil. 2018 03:53:44 +0200, a ecrit:
> > @@ -257,6 +257,8 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
> >                               0x80 | (ch & 0x3f)
> >                       };
> >
> > +                     if (chars_sent + 2 > count)
> > +                             break;
> >                       if (copy_to_user(cp, s, sizeof(s)))
> >                               return -EFAULT;
>
> Err, but then we have lost 'ch' that was consumed by the
> synth_buffer_getc() call, so the fix seems wrong to me.

Oh. Whoops.

So that means I'd need to first synth_buffer_peek(), then
synth_buffer_get() afterwards (and discard the result that time)? But
there are also no locks held at the moment the code is in there, which
could cause that approach to lead to inconsistent results... do you
want me to resend with synth_buffer_peek() and an additional mutex
that is held throughout softsynthx_read()? Or should I rewrite the
patch to be simple and just bail out on `count < 3`?
