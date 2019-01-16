Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C82C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D5420652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvTM1ioh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfAPWil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:38:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38351 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733147AbfAPWil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:38:41 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so6238442lfk.5;
        Wed, 16 Jan 2019 14:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjSqqJgQvXGU50nYAN5RNHtcgtnWgL+nRDexMY6xjSc=;
        b=WvTM1ioh3aKjPMQXu0Qa49290aUNMCq3ZvVUtNZnTvR7ZxIh8536bWT40xjiaYVKHr
         drZKQWshN2LpYU1uuf2Y/Yq+RQ7iQylnUo8E5W9fAJiTIZYJd2utFVOXnWKXDXEDznjR
         yatE53/CSPc5DxfJNKecieNYXv8bplrGn4BWqxdI/CWXNu8b72gbwaAcQzj7Z+nyt8FN
         8Ra+HfnuAIR920XTDcD1xI77rIF0CkmuPwurbmOg/ZTjJxXU/LjtZ2qYPJfTE9oiCa4a
         jm+AS6nLDPjAezEkQWvaTsTWif4yR10jCUK4jGYdyL+49tjh0+eF8L8ujdxcCbgEqAaU
         zpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjSqqJgQvXGU50nYAN5RNHtcgtnWgL+nRDexMY6xjSc=;
        b=GZUMKJsiq9XMjdYNW4tCwJweiwZQiDiROF8z0BG8Uo+PkI1MjEaG4906HZMfq08Yk/
         8lYq/44iPEBl2QTFE1fu6FWqoQtmkNJ6rO/alrxUwAtSdAHIu+g8HK6DnBJO0G9f0yxk
         LktnIJXp8Mf+6APnFCDMV/JAGHtE0TeGCo8qb/2tJtykw6xL7SWXF8xwR/KarUr/m5om
         LEKJR3/ChClZZFUtPRWHxq8AAlarEftmzdho81KNktcsQ6D0zV+F4IAO+V4qqAgdRkzS
         xNB76lQKICzheOrMR+aOW5OH2ORfyo+AuljHWiGB9YBsWGQn71KocacnTiYhqsWqal/I
         SB3w==
X-Gm-Message-State: AJcUukccUsVlnOjaId6N7atA5Q4dLMiTSIu+DTFgcOShHGUjBx44cP0K
        ScaFfPRe2gCL25gTYggNB4uO+99MVV93oj+Lpfo=
X-Google-Smtp-Source: ALg8bN4UYz9ovHfmOolWdPx5MT9AKbfL8O5Vdv73Fq9NL82pGKvBDIcZZhh93GWs3FY2wPpdPgGo50Qd29voZRMlXek=
X-Received: by 2002:a19:d619:: with SMTP id n25mr8301103lfg.91.1547678318922;
 Wed, 16 Jan 2019 14:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20190110042157.8445-1-natechancellor@gmail.com>
In-Reply-To: <20190110042157.8445-1-natechancellor@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 16 Jan 2019 23:38:27 +0100
Message-ID: <CANiq72kO233qL0Yqv4iSW7_4MGxmijrLF8bRwzKacsMVyOLKQA@mail.gmail.com>
Subject: Re: [PATCH] iavf: Use printf instead of gnu_printf for iavf_debug_d
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Thu, Jan 10, 2019 at 5:22 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> In file included from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
> In file included from drivers/net/ethernet/intel/iavf/iavf.h:37:
> In file included from drivers/net/ethernet/intel/iavf/iavf_type.h:8:
> drivers/net/ethernet/intel/iavf/iavf_osdep.h:49:18: warning: 'format' attribute argument not supported: gnu_printf [-Wignored-attributes]
>         __attribute__ ((format(gnu_printf, 3, 4)));
>                         ^
> 1 warning generated.
>
> We can convert from gnu_printf to printf without any side effects for
> two reasons:
>
> 1. All iavf_debug instances use standard printf formats, as pointed out
>    by Miguel Ojeda at the below link, meaning gnu_printf is not strictly
>    required.
>
> 2. However, GCC has aliased printf to gnu_printf on Linux since at least
>    2010 based on git history.
>
>    From gcc/c-family/c-format.c:
>
>    /* Attributes such as "printf" are equivalent to those such as
>       "gnu_printf" unless this is overridden by a target.  */
>    static const target_ovr_attr gnu_target_overrides_format_attributes[] =
>    {
>      { "gnu_printf",   "printf" },
>      { "gnu_scanf",    "scanf" },
>      { "gnu_strftime", "strftime" },
>      { "gnu_strfmon",  "strfmon" },
>      { NULL,           NULL }
>    };
>
> The mentioned override only happens on Windows (mingw32). Changing from
> gnu_printf to printf is a no-op for GCC and stops Clang from warning.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/111
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I forgot, in case you wanted it:

    Reviewed-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Thanks for taking care of writing the patch!

Cheers,
Miguel
