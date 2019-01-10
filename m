Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB6120675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n6fAPMd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfAJS54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:57:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46101 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfAJS54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:57:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so5700588pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sf8nYcm0bUrRFdr6g8oNTGFSuvJBY7iJ8mE5wljL+AA=;
        b=n6fAPMd72BjKlvc3za1GUExf7hfLoM7Ow9Fnko6UpTNS0KsBe40gm+0tt1/nip/JwU
         kDxpYBkEkC2pSOWi/dOvDQc7xNs8e0LY6anaFgoyyRnBfKO1d+wv6Xy4pbhCK9sjgBsb
         uchvPBkGYHO/z121gA35m18xNBlnWREXyjwj5yw2tt3vrHVrzNGMTU2x1Enwke7kpZe6
         bmCU8Wd6mvtlu46vwI92yutoLpP/Xfk5kzAm14VcW4qI3JorbBNVJzqRWdcpP6bRPz64
         sfhu522AJ9hpDnH2qYcIAoiinCYvm2JQJeQH1nL9NTa5DxJqNFaILr/4S5Ry3u8jsuJs
         YatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sf8nYcm0bUrRFdr6g8oNTGFSuvJBY7iJ8mE5wljL+AA=;
        b=mipSYdnoWkiDbc3oPOyjHZgC2A3NgDdzVLhCxIOwJt8ULzif4KR977NNeRKmq30A+t
         ctqGsu5QeglJqymuto/O/X7sX6+ySLm2s7A+R4qHvONLrKUBlHyzOm3yIZP9ojliRCrj
         vhRe1D91D0AmTtTdgQxRyBo/oOXQuUOUGNbgiYC5G2QIWJwFRofmqLL64agc1HhNT9RU
         8ymqs4jxqOlJiuaxanpuYHAqpzfVxX2EilSIWOEbNMUsfbrl9aH7XjKwdLbmK4bWJ9FN
         Uo/iZCx9yxlmCqqYJVWcv+Liw1h2e++ks+MnTFaJ4hN4yi3Ml2fu/+OhPHamXCj8f821
         8mMA==
X-Gm-Message-State: AJcUuke6mzl/YPL3zInRN7wJhzEFWYCRrApwG4lLax7XoqjTSniXNrq4
        7lmtgQfbxc2zvlCdQMGPqPuODdZN0uI/32aM0GB6TA==
X-Google-Smtp-Source: ALg8bN6EuydCRGoYFJOzlKAz1yeqnP3TpvUGLBKpAGzv9Kp9gUdksCOCkkv3CrewTG/y2USXm7e5jvzmxg+Os7oPMJQ=
X-Received: by 2002:a62:7e13:: with SMTP id z19mr11289629pfc.94.1547146675097;
 Thu, 10 Jan 2019 10:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20190108050649.9962-1-natechancellor@gmail.com> <20190110054107.6069-1-natechancellor@gmail.com>
In-Reply-To: <20190110054107.6069-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Jan 2019 10:57:44 -0800
Message-ID: <CAKwvOdnyhpho0x-fi03RQOrqqBFYfKdScSj9FDWPFOvg2DrGsg@mail.gmail.com>
Subject: Re: [PATCH v2] isdn: avm: Fix string plus integer warning from Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 9:42 PM Nathan Chancellor
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
> This is equivalent to just "\0". Nick pointed out that it is smarter to
> use "" instead of "\0" because "" is used elsewhere in the kernel and
> can be deduplicated at the linking stage.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/309
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for sending the v2.  I'll leave review to the maintainers to
confirm my suspicions about the code's intent.

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Use "" instead of "\0", as they are equivalent, but "" can be
>   deduplicated by the linker, as pointed out by Nick.
>
>  drivers/isdn/hardware/avm/b1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
> index 4ac378e48902..40ca1e8fa09f 100644
> --- a/drivers/isdn/hardware/avm/b1.c
> +++ b/drivers/isdn/hardware/avm/b1.c
> @@ -423,7 +423,7 @@ void b1_parse_version(avmctrl_info *cinfo)
>         int i, j;
>
>         for (j = 0; j < AVM_MAXVERSION; j++)
> -               cinfo->version[j] = "\0\0" + 1;
> +               cinfo->version[j] = "";
>         for (i = 0, j = 0;
>              j < AVM_MAXVERSION && i < cinfo->versionlen;
>              j++, i += cinfo->versionbuf[i] + 1)
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
