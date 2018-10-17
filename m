Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55464ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0259F2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIt0EM8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0259F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeJQUWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:22:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44596 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJQUWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:22:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id p23so25921499otf.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DlE7FHtsAwfJIw+siIZhRS7ZbZA56j0dZVqXrInqO9M=;
        b=fIt0EM8OIRXaAsDnmEaqV+yEyOEPajrAYrCLe0m5oC4mJGhq64YwDswCfX69PS9RCK
         8HJc80Iwewl2k2hABayiEY6y0IonSZuKSEOrrdi/I2JQqqgqqI1J2BEXkoOksBNKYUJ1
         zhn5koaBGiu/+LQXp80ElF78qhc0hpYyr10D/vHkDsS+hsYYdnuJmFeymRWMVfAuEpBt
         oulhnTj8Hn2oU1K+m+lwtU2POO9yk5+LV+NAlpKFrIWnj3eF3WmYQc1n3n0y7jXNcAgK
         G1TGVMGtCNHZN7jXko4/g78JSSEElCW6EOpOHUAQ8QpbpwtKq0xa22CBk3aCrpXFzWC7
         TOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DlE7FHtsAwfJIw+siIZhRS7ZbZA56j0dZVqXrInqO9M=;
        b=A94U6ELWsopO+BucWD6Qqu7B60YFVzbNyKYEeiqPUyZWyog6MmbPOZu3L8M3uiSyoL
         jQ2paOlVMAzX5RMQ4mMoL7NGPaFfbFmJICKPfakcPtANblFEp9wGd6NiMiVruLPBrj+s
         wjFuFN32X6eUycfaoPFN7OOPrYm5BOMLDZDs/JM7dF8HRcTHvCHfyA2597lZNp2nH2cc
         vsl8MsTiUfwVFEabe0r6tsiEiYkO/rmGZ9oaTQSqBRa5UPpIoq5/Wij0aNJ2wD1BizzY
         joAchtem13bR3W0net+9fu3FJXFvBWjGlW24zI2aFQJ6qtnRoGm0oipkSmpAHlpO1W98
         f8rw==
X-Gm-Message-State: ABuFfogjL2VQ5sgfud3PPdlO2sbJC7xGInwxkx4PBvngZHL2XcjiuLA5
        ldQuiyo4sKzBVNOWIHvXV7xuOE2taujkAtERFqZWOlCiZO8=
X-Google-Smtp-Source: ACcGV63NbD0cTiYnlNoZbGo8D112ONuuoSXoyZMRiWsp4Aurv0J3oMvHB9+j08DgU6MBWV8MPo1fj6lgpcl1sRoh7vA=
X-Received: by 2002:a9d:2641:: with SMTP id a59mr17342136otb.35.1539779223859;
 Wed, 17 Oct 2018 05:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181017121000.30240-1-mpe@ellerman.id.au>
In-Reply-To: <20181017121000.30240-1-mpe@ellerman.id.au>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 17 Oct 2018 14:26:37 +0200
Message-ID: <CAG48ez2W8HeJcuPwA25vSqTco3B=CRzycSA0=--pG=7jWi3pPw@mail.gmail.com>
Subject: Re: [PATCH] seq_buf: Make seq_buf_puts() NULL terminate the buffer
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 2:10 PM Michael Ellerman <mpe@ellerman.id.au> wrote=
:
> Currently seq_buf_puts() will happily create a non NULL terminated
> string for you in the buffer. This is particularly dangerous if the
> buffer is on the stack.
>
> For example:
>
>   char buf[8];
>   char secret =3D "secret";
>   struct seq_buf s;
>
>   seq_buf_init(&s, buf, sizeof(buf));
>   seq_buf_puts(&s, "foo");
>   printk("Message is %s\n", buf);
>
> Can result in:
>
>   Message is foo=C2=AA=C2=AA=C2=AA=C2=AA=C2=AAsecret
>
> We could require all users to memset() their buffer to NULL before
> use. But that seems likely to be forgotten and lead to bugs.
>
> Instead we can change seq_buf_puts() to always leave the buffer in a
> NULL terminated state.
>
> The only downside is that this makes the buffer 1 character smaller
> for seq_buf_puts(), but that seems like a good trade off.

After this, you can also simplify rdt_last_cmd_status_show(), right?

> ---
>  lib/seq_buf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> I recently merged a patch which actually hit this behaviour. I worked
> around it by using seq_buf_printf(), but it would be good to fix the
> problem at the source.
>
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 11f2ae0f9099..b1570204cde3 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -144,9 +144,13 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
>
>         WARN_ON(s->size =3D=3D 0);
>
> +       /* Add 1 to len for the trailing NULL which must be there */

Nit: In the comments, I would prefer either "null byte" or "NUL"
instead of "NULL" when talking about something that is not a pointer.

> +       len +=3D 1;

It looks like you're using an "unsigned int" for the length, meaning
that this can in theory (e.g. when operating on a string from a big
vmalloc buffer) overflow. You should be using size_t here.

>         if (seq_buf_can_fit(s, len)) {
>                 memcpy(s->buffer + s->len, str, len);
> -               s->len +=3D len;
> +               /* Don't count the trailing NULL against the capacity */
> +               s->len +=3D len - 1;
>                 return 0;
>         }
>         seq_buf_set_overflow(s);
> --
> 2.17.1
>
