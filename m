Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC90C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F34920675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX7tn7U6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbfAJTHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:07:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36811 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfAJTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:07:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so123310wmc.1;
        Thu, 10 Jan 2019 11:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cnC3q5wEDn7iU+sBMLKOlQl4geRnkWz5Fe1AUw7NxmU=;
        b=TX7tn7U6y7zPtlaqPq1y0JZ0WjOe/Sz40P6FWd72Xe5N2n37NRaOPlmEXXg6oaWyhV
         WYEOw/LlZq4gzSzrwHCjzatxlYhQSHdPP1A733SJIBtY3L/H6aON5tzracwIsYiH4EeG
         JFjdRQZm7HY7ZjVj3GYbP0jynb4E4OUNbItLEgBHbtn2vsmBuIRb3boi23Fakrqp38l0
         f/9tCIyDa33qUY7jw27wnyCnGbig8pcI4r9fq4Gv0bJlTIYFdr23Wlw6C661a1n1InW1
         LyiShoHc8uBIR/SmwmnVPKhBtvW09LWVrIVZVjrCVm6rhEwl+cWkLJig/8GJi5MFfCry
         3wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cnC3q5wEDn7iU+sBMLKOlQl4geRnkWz5Fe1AUw7NxmU=;
        b=ZGea+9gQnE6SIhGgT+M5qyEsyb3cqzELFjDsOwh8hhNg3jYoICnUVd3AWCRH2MTMtB
         oJmk65pVuaWw4MIkzsfunH9WvEDcUHK0cS8Mw9JrChUYqvC8xZOyrZldKGP/GDNgiM1k
         SLlkj0BhdQZUgwQvUMX9smPEueSDkwQoP9T5iIxjwyx7Dmcic45K8kBpNOZRKNA15Y15
         WGfvoWx5BW9ms9gz7XnX1DJvrOc37x/rSdtAxRkHMw67m9g5RM5rXn9rURConEVZKrcu
         Wf4biIiE/3/iXfgArLjG05pxuJc7QWKFbZyy3TKBmDGFIP8vOGI6q2IdJHoI/y8x1TQ4
         KeHQ==
X-Gm-Message-State: AJcUukf8Yj8xdN7wvmc+9AQG4jK3pfeGU7ZIsBGDwMD/d3B1E/h4WfHk
        EE6JSY41/Kwm5URb9G9FSyA=
X-Google-Smtp-Source: ALg8bN4ahFtAuEOjdO7ypgNOIXrvv/GpLcBiwdxWJswe+vKTePdlXwhFMITMLiNTcZ6/IvE6paZAZg==
X-Received: by 2002:a1c:60c3:: with SMTP id u186mr65208wmb.66.1547147237640;
        Thu, 10 Jan 2019 11:07:17 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c14sm16973607wme.13.2019.01.10.11.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 11:07:17 -0800 (PST)
Date:   Thu, 10 Jan 2019 12:07:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] iavf: Use printf instead of gnu_printf for iavf_debug_d
Message-ID: <20190110190715.GA18881@flashbox>
References: <20190110042157.8445-1-natechancellor@gmail.com>
 <CAKwvOdk=GZUG3FdP1gDg30H_Tt52cPXrZC-4Na8ZfD0h=jbU8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk=GZUG3FdP1gDg30H_Tt52cPXrZC-4Na8ZfD0h=jbU8g@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:54:46AM -0800, Nick Desaulniers wrote:
> On Wed, Jan 9, 2019 at 8:22 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > In file included from drivers/net/ethernet/intel/iavf/iavf_main.c:4:
> > In file included from drivers/net/ethernet/intel/iavf/iavf.h:37:
> > In file included from drivers/net/ethernet/intel/iavf/iavf_type.h:8:
> > drivers/net/ethernet/intel/iavf/iavf_osdep.h:49:18: warning: 'format' attribute argument not supported: gnu_printf [-Wignored-attributes]
> >         __attribute__ ((format(gnu_printf, 3, 4)));
> >                         ^
> > 1 warning generated.
> >
> > We can convert from gnu_printf to printf without any side effects for
> > two reasons:
> >
> > 1. All iavf_debug instances use standard printf formats, as pointed out
> >    by Miguel Ojeda at the below link, meaning gnu_printf is not strictly
> >    required.
> >
> > 2. However, GCC has aliased printf to gnu_printf on Linux since at least
> >    2010 based on git history.
> 
> Thanks for this fix!
> FWIW, using godbolt to see which version something was added in is
> better than giving a year of the commit.  I don't think it matters for
> this case, as the kernel already makes use of `printf` as you do in
> this change, but food for thought for next time.
> 

Yes that is a good point, I need to be taking advantage of that site
more.

Thank you for the review!
Nathan

> >
> >    From gcc/c-family/c-format.c:
> >
> >    /* Attributes such as "printf" are equivalent to those such as
> >       "gnu_printf" unless this is overridden by a target.  */
> >    static const target_ovr_attr gnu_target_overrides_format_attributes[] =
> >    {
> >      { "gnu_printf",   "printf" },
> >      { "gnu_scanf",    "scanf" },
> >      { "gnu_strftime", "strftime" },
> >      { "gnu_strfmon",  "strfmon" },
> >      { NULL,           NULL }
> >    };
> >
> > The mentioned override only happens on Windows (mingw32). Changing from
> > gnu_printf to printf is a no-op for GCC and stops Clang from warning.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/111
> > Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_osdep.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_osdep.h b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> > index e6e0b0328706..c90cafb526d0 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
> > @@ -46,7 +46,7 @@ struct iavf_virt_mem {
> >
> >  #define iavf_debug(h, m, s, ...)  iavf_debug_d(h, m, s, ##__VA_ARGS__)
> >  extern void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
> > -       __attribute__ ((format(gnu_printf, 3, 4)));
> > +       __printf(3, 4);
> 
> And you make use of the __attribute__ wrapper from
> include/linux/compiler_attributes.h, cool.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> -- 
> Thanks,
> ~Nick Desaulniers
