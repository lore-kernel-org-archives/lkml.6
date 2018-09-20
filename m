Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEB3ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A692C21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Il+eZW1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A692C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbeIUAB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:01:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33002 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUAB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:01:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so1506057pge.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mh+EYBHnUkz4ClbZx5Wz1Ay+kDl2weo/gfbdbgGnZEo=;
        b=Il+eZW1SjlkAsKADcpiWN7WlIfOJ85jbgiJRw/KQNCYi4ts8YBQe/ilBNdnARE4jwA
         MMJ9hMhDSXUNRIuZQeqb8RkGr1sz7Dk7NzfGyArYFviJo2dq7xlOpi7QsmwT/gcTHqHv
         Qc8TgI0FOaIZEb7IyzEphSnXV1W6UrWARsO4ohhKvDfcxbfQe5hE4Swpyl8lPxxubjrF
         9T4ll+2CpCszhcfT9XwAN6kEd3OHpsBgcpEqCb8iK3TsRmhp5nGMwsO0nb3VejwQIzWD
         g0MPHoR8O1tplVu94BtUxzA/6rFPpseQSyL4c6YQr1csK+aLK7XKBRmbTasfW8uZtZ7b
         5IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mh+EYBHnUkz4ClbZx5Wz1Ay+kDl2weo/gfbdbgGnZEo=;
        b=esfnLMYusJeVDd++itqZofpHfq4o3CSB4xXjWOkHwQDpg1jTQLHNLeZJgf24gXUGHJ
         8tChyQg21j1WvWGCQKRULp3vWRvIP7LuQZ+Fi8bI7NxoR6gim49DapJv1x0JP4D2wEGE
         2raW53wXGX05r9aPvjnT4/iBZIv7uPnDDg+UlmeEKI2bKU8R2XF6/ms51H1p8G4MjKDv
         D2OqjnGmLpn4ZQv4j66xVZ8LmFQhsyvuG+dMlgo3TWEREb+ueaL/M9ifC9sDKw0wTkD4
         qjdgdmtyQZDWyvrwzlj/XEHUMrxEz85fdZYhoQe22y9VOspciw9xhGg3IbkRZi3vuoBK
         hH3Q==
X-Gm-Message-State: APzg51D1gSNUAiZD7T6clvF10h/xRMntm9DDlQnldYSYAjU6Q0utNGDd
        ovEcsYYeiTLbKlYfVuRymihmOXuMdtNtZ1l4kSQUKQ==
X-Google-Smtp-Source: ANB0VdaAlyMrda7H3GqCdir9mRx2bmHVM3fwb2iFW/0hZU/L1qfEzskg/z78/jCHnUdO72nBsBlS07cFnwdKhxQxlPM=
X-Received: by 2002:a63:1363:: with SMTP id 35-v6mr38041853pgt.202.1537467403525;
 Thu, 20 Sep 2018 11:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com> <20180920172301.21868-14-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-14-miguel.ojeda.sandonis@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Sep 2018 11:16:31 -0700
Message-ID: <CAKwvOdmVfqMSox3nR57i=5GzSfV8szeaK1REs2X_gtmv7x1f4Q@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] Compiler Attributes: enable -Wstringop-truncation
 on W=1 (gcc >= 8)
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
> Commit 217c3e019675 ("disable stringop truncation warnings for now")
> disabled -Wstringop-truncation since it was too noisy.
>
> Having __nonstring available allows us to let GCC know that a string
> is not meant to be NUL-terminated, which helps suppressing some
> -Wstringop-truncation warnings.
>
> Note that using __nonstring actually triggers other warnings
> (-Wstringop-overflow, which is on by default) which may be real
> problems. Therefore, cleaning up -Wstringop-truncation warnings
> also buys us the ability to uncover further potential problems.
>
> To encourage the use of __nonstring, we put the warning back at W=1.
> In the future, if we end up with a fairly warning-free tree,
> we might want to enable it by default.
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8d5357053f86..b8f36f5f43f2 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -29,6 +29,7 @@ warning-1 += $(call cc-option, -Wmissing-include-dirs)
>  warning-1 += $(call cc-option, -Wunused-but-set-variable)
>  warning-1 += $(call cc-option, -Wunused-const-variable)
>  warning-1 += $(call cc-option, -Wpacked-not-aligned)
> +warning-1 += $(call cc-option, -Wstringop-truncation)
>  warning-1 += $(call cc-disable-warning, missing-field-initializers)
>  warning-1 += $(call cc-disable-warning, sign-compare)
>
> --
> 2.17.1
>

I was sad to see these go in the first place.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
