Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60B5ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7043F2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kx5AME7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7043F2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbeITX4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:56:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46628 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeITX4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:56:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id t20-v6so1280689ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWvJ1QZi3se/QefXMjCzCIvWR1+8u5LY+UwTnG7VS78=;
        b=Kx5AME7zDVDRp84ZqXVX5cviwxUuzqLvG68puoIlnTfZnm6Osm0eOTB2oQFAnhOq5T
         kEaSXxiAHVGe+THFWKeXX6XmFg46mdzqzuVLocNj25KuikqSeF9V29d6HHR/WL1IJt72
         RPQpbV7YAYGMKpmEYc4C9+BoXvoQO6ikD+1RiQgeveipR6HFpX8DOTB+H1EmUhCm7yTs
         S555dKFL3HQuHUyH9mtLV5HNhqFNxnIJMdHtY1Wxd4xEi8jfSPLrSrmXJlRXGvN4NJVr
         TEI0WB5hwNx3ul1L6VSeTLntFHIuQ5B7jvF8yV6mb4dv1Z8hF/R1IlYKtkWTSzH+PTY0
         fN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWvJ1QZi3se/QefXMjCzCIvWR1+8u5LY+UwTnG7VS78=;
        b=ps874yOHPm8A7n3eHkZjO9jQ6WrzHbEI1y2xKFBJqj+lo8G28WlEFZLUMDByWNr0gn
         I/4/zYP/DoU8zaUfmWrvliCPRQeGvbCGml+DxX5Xquj0Kn6JaKfyjfNfqLKDYpcNOKfS
         cQtSEq4DjZoYanrSCWg6ohbC+/RTwgR35C9LDe6OVrdv8VYfourk5dq8/ciMq4b3pWfK
         O8dzezPud4vYcJ/2ctodYqTCfzCBw0PY47mhQ8ElFuYHhMwe0xfMdmu1km5H3fxD0DMk
         8o9TGkW0PY2xogLrni7Yl4Fo//TIp5+wZ2SiKHGa71zSVgfZbJT7PAcGs25veuHsdeR7
         yZ4w==
X-Gm-Message-State: APzg51Dj2DmBwBWGuRswQXaWDEt7P5qTwc6nGkLoPq5Fr7QTGqr4I26G
        04DJfspAkujdMX1eF64Yvxy0mbeZP0Z0iVVGJgSIPg==
X-Google-Smtp-Source: ANB0VdY2ZdOUjWSRXheJQlgPQFPextm3KRd32uuhC+TGsxZt4QL1VC9bHI7hIPNcDkMDpWdDQFvBWweaaLYWQ+6/oiU=
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr40327096plf.320.1537467107987;
 Thu, 20 Sep 2018 11:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com> <20180920172301.21868-15-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-15-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Sep 2018 11:11:36 -0700
Message-ID: <CAKwvOdnSNezyMQuj4bT3HeEM8hp+YSZbUKO_u_C+jd2C0sRJ3g@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] Compiler Attributes: auxdisplay: panel: use __nonstring
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, adilger.kernel@dilger.ca,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org,
        mchehab+samsung@kernel.org, olof@lxom.net,
        konstantin@linuxfoundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        sandipan@linux.vnet.ibm.com,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        paul.burton@mips.com, David Rientjes <rientjes@google.com>,
        w@1wt.eu, msebor@gmail.com, sparse@chrisli.org,
        Jonathan Corbet <corbet@lwn.net>, tytso@mit.edu,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, joe@perches.com,
        Arnd Bergmann <arnd@arndb.de>, asmadeus@codewreck.org,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:23 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Let gcc know these arrays are not meant to be NUL-terminated
> by annotating them with the new __nonstring variable attribute;
> and remove the comment since it conveys the same information.
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  drivers/auxdisplay/panel.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> index 3b25a643058c..21b9b2f2470a 100644
> --- a/drivers/auxdisplay/panel.c
> +++ b/drivers/auxdisplay/panel.c
> @@ -155,10 +155,9 @@ struct logical_input {
>                         int release_data;
>                 } std;
>                 struct {        /* valid when type == INPUT_TYPE_KBD */
> -                       /* strings can be non null-terminated */
> -                       char press_str[sizeof(void *) + sizeof(int)];
> -                       char repeat_str[sizeof(void *) + sizeof(int)];
> -                       char release_str[sizeof(void *) + sizeof(int)];
> +                       char press_str[sizeof(void *) + sizeof(int)] __nonstring;
> +                       char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
> +                       char release_str[sizeof(void *) + sizeof(int)] __nonstring;
>                 } kbd;
>         } u;
>  };
> --
> 2.17.1
>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
