Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D67C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55962070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jg0udTxA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfAHRuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:50:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33683 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfAHRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:50:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so2254635plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A6A8srFzrHU/2gOv+trj4p2i8UWay162svkIQcYVq5Q=;
        b=jg0udTxAhGKh82W6h1G40RVHAaXGxIUt7DMcDwpHUbVxj4JGxzeBT2QhJ6fFpkNQLd
         At0z3hxQya3EoZDDxR0kEnUG/19oCRB4Tzu2jdMydIEVjjaSgZmER+rXcvAQn00voMlH
         eZgHhbQbNB6CkToB40aFxBB2yBhiHOFHntybxForkZdnSZCHgBpExswwPLhjx/o6M++I
         7xtAdFwe4je1X+TJtIiDicoz4BtJMGERKOsiuA9ECw44EKBYh+489oacaxFATE5DqCZu
         ZgbTnrfr+tfYMczEYjnhIB647Pgbuo7YzAqPrqkNjv/lsO2kAwhVvxeXNbzZ6rR7GLvQ
         vs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A6A8srFzrHU/2gOv+trj4p2i8UWay162svkIQcYVq5Q=;
        b=fpwSmVi+H6mL3pZbei/w6QOLMEZvTo9XDUaMidYmQgnCczDv/GzCjN5xbMB4EI2/vk
         jULtqKwLsnvUMVDzdqofANIM+LGmMu0Mt2RpgRdSJKiIBVEEa+8owzVsVuvBYM3S16NI
         YV+Ob4q5M6hKUxWqfgBNz0izxe1GvLbA7lBtKtitws41b792+k7dGpeVPcC8EVZcyr4z
         t9J8eiJW0r1cMRPLKbmI3tLreWLdBM/KmfIKUtkx8awsCWwXaMiMTQ3tow0OrhAgG11U
         7UjYB9TNq6A7NxsHLlknL0Y+jmnVa1VVqkvovtn3QCJdvu2gO7iKdEstuKoJy5KVmb5V
         IE/w==
X-Gm-Message-State: AJcUukfMHXMhqJVIhvN9q2hfPIWXED8IZaJ88MsVWGTWodYl0KmZqu7G
        s9KvPjNV1J+KORO5HlLw+Tho5aXqMtz1lwrdVHEZbIA4q3IfvQ==
X-Google-Smtp-Source: ALg8bN6qy+qOhOh8fKOVM8HhCA/Hm/+fJRsdvy+8nFDBizCyUyH6we48JJm/ceNyG2yZjnEhrYgMm+9OGDOk1xF8o3E=
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr2707224plb.217.1546969850456;
 Tue, 08 Jan 2019 09:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20190108050649.9962-1-natechancellor@gmail.com>
In-Reply-To: <20190108050649.9962-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Jan 2019 09:50:39 -0800
Message-ID: <CAKwvOdmaZ6bbnkPGqEeaB6MMnLm+7Q14MUbbq_kNz5usgcU0bA@mail.gmail.com>
Subject: Re: [PATCH] isdn: avm: Fix string plus integer warning from Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 9:07 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> A recent commit in Clang expanded the -Wstring-plus-int warning, showing
> some odd behavior in this file.
>
> drivers/isdn/hardware/avm/b1.c:426:30: warning: adding 'int' to a string does not append to the string [-Wstring-plus-int]
>                 cinfo->version[j] = "\0\0" + 1;
>                                     ~~~~~~~^~~
> drivers/isdn/hardware/avm/b1.c:426:30: note: use array indexing to silence this warning
>                 cinfo->version[j] = "\0\0" + 1;
>                                            ^
>                                     &      [  ]
> 1 warning generated.
>
> This is equivalent to just "\0" so fix it to clean up the warning.

Hard to tell what the intent of this was.  I also assume that they
meant to set all version strings to the empty string.  I think just `=
""` would be better, as otherwise that creates a new data section
containing two zero bytes vs the empty string which already probably
exists throughout the kernel and can be deduplicated by the linker.
https://godbolt.org/z/qf3Rn8
Sorry I gave the quick LGTM in
https://github.com/ClangBuiltLinux/linux/issues/309#issuecomment-452106468,
that was my mistake.  Assuming there's no other comments (maybe from
the maintainers) on what the intent of this code actually is, would
you mind sending a V2?  (Sorry again for the quick LGTM on this
version).

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/309
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/isdn/hardware/avm/b1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
> index 4ac378e48902..7fa8141e2019 100644
> --- a/drivers/isdn/hardware/avm/b1.c
> +++ b/drivers/isdn/hardware/avm/b1.c
> @@ -423,7 +423,7 @@ void b1_parse_version(avmctrl_info *cinfo)
>         int i, j;
>
>         for (j = 0; j < AVM_MAXVERSION; j++)
> -               cinfo->version[j] = "\0\0" + 1;
> +               cinfo->version[j] = "\0";
>         for (i = 0, j = 0;
>              j < AVM_MAXVERSION && i < cinfo->versionlen;
>              j++, i += cinfo->versionbuf[i] + 1)
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
