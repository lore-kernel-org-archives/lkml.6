Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68949C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F4E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Di749je4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfAJSzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:55:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37532 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfAJSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:54:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so5725115pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 10:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91NdRB6RjrgweUCBrbIPbKzXH7MrtaY+0SUQSeQWhjk=;
        b=Di749je4HdGfRu1u8W8iOC/wRwg1VNomJmmp0UhF3lMWoJEdAZyzm8gX3HZfDbhoK+
         THEhHIour+4O2Sy/ftApV9raGwp1IuBHiZYmBGnciOabQ+SNhbGykJxlD3eyHc7YnHkX
         Nd7BxBf31ReYP+8w56vj8AncrGHR9zBRqv5VJrU4BzcdL2eBXwltShxB298quwcXCiP4
         VbIHAtbwnNAgy1CLrQ8X2YOBabCIItsrofXssZdoC/sqgudX1RIIYY+RLqRqcuU1Flvs
         /V1r9JotsxK/whn3O8oxtmWylABYLNGldH8L3ETJ1icJjXgr7p2ZWOpK1dGSh6YaDS5R
         fpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91NdRB6RjrgweUCBrbIPbKzXH7MrtaY+0SUQSeQWhjk=;
        b=EuMh2uhJz6wz4CxZbRlXk88qC2HBxRPJDeRtmLErpefOLe/JxjGmxHwMhJSEbuXGJd
         7/oda7PtcBmVQbAuIZiyQPWA8e8Ulzzjrq7Ql3UqGIX5FItdgoc9qjZ809v5KAhZZAO5
         QYa0ScVnCUGHRUHeWFsm9V7JBRE6/pct4gRloKuxXgqx6m6tnAooM5o6zj6P0Mw8LtW1
         uDR7DbOdeyTHYb0iZ1F3Id+2TyaV+GLqSWFZeB1t3jhGIE1+zKBYfxzPZ0WaPf1vB88e
         77B0ziuRRnh/xRgpYzaH3TaOXmEke+pep3NMfDXazv+MtVhemGfMU6YY9RChvUdvEZyC
         ZzWw==
X-Gm-Message-State: AJcUukejuFfC1OO93Sy0Qxchd9Seu+cwc3L7+5HKjwBCVtc4izNFmcR9
        K7sZKmueA6uzy9SwhIO91ihpkJKsv9p9oDaI/WeVHA==
X-Google-Smtp-Source: ALg8bN6t+YXpQ6qV9ZFsWxadKVHZPhegnK60zA8Nfk9Zxdb8XjqgjWlD/jIv2HphA2/2DQ+BR+U1pS/WeSWj4MvkN04=
X-Received: by 2002:a63:a064:: with SMTP id u36mr328035pgn.145.1547146497217;
 Thu, 10 Jan 2019 10:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20190110042157.8445-1-natechancellor@gmail.com>
In-Reply-To: <20190110042157.8445-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Jan 2019 10:54:46 -0800
Message-ID: <CAKwvOdk=GZUG3FdP1gDg30H_Tt52cPXrZC-4Na8ZfD0h=jbU8g@mail.gmail.com>
Subject: Re: [PATCH] iavf: Use printf instead of gnu_printf for iavf_debug_d
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 8:22 PM Nathan Chancellor
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

Thanks for this fix!
FWIW, using godbolt to see which version something was added in is
better than giving a year of the commit.  I don't think it matters for
this case, as the kernel already makes use of `printf` as you do in
this change, but food for thought for next time.

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
> ---
>  drivers/net/ethernet/intel/iavf/iavf_osdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_osdep.h b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> index e6e0b0328706..c90cafb526d0 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> @@ -46,7 +46,7 @@ struct iavf_virt_mem {
>
>  #define iavf_debug(h, m, s, ...)  iavf_debug_d(h, m, s, ##__VA_ARGS__)
>  extern void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
> -       __attribute__ ((format(gnu_printf, 3, 4)));
> +       __printf(3, 4);

And you make use of the __attribute__ wrapper from
include/linux/compiler_attributes.h, cool.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
