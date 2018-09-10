Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3150CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45E42087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBBWMlJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45E42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeIJV5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:57:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38964 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeIJV5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:57:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id i190-v6so10783547pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y00YsaRjxAjW0eHAPZP461TahLFFjq+HqGHFavsyK/M=;
        b=kBBWMlJ2cX5RendVTxsLRyS7Y76/A51a3KdYeE0rhR8tM+pJXwla5VWxdFvX6HMwvz
         c5W2LlAf1DZHRsssb9xIjiXd97XuoI7syH/TZLGuq6TIUVNET/isMf58zVPD8vmfFxxs
         zglG3dUxUQ2EjvQpZqMy/8TFILk8gmcHw/R27MxVZAJIEXBqaUqoJViCH6upYMSYI4GG
         zTzGylcIaVSsMezc5Lp4zEXksZDoUvd18arSuyA++ndCoaO3ZuK3Z7XUCxJHe8r43syb
         XZaBGxm91fq5dVpViHWD7vyesTTInc9w31lqdVqix/nENHHVY19b1mLFAJ3HyVNwwJe5
         SfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y00YsaRjxAjW0eHAPZP461TahLFFjq+HqGHFavsyK/M=;
        b=IH8UDHNVo7aBA5GBZNfeKytc6U9Icnb26ltcQhGGM1+fLoBG7H2fuPATNkWDK+kVTt
         oSS1RiM5Ifg65MMSFD/dJblbKkDgfVhPYtAp4KE9YOtBEVcXEZWyS31r5bax50IxpDUK
         xx9iHJZbPTcSd5rWlYPAddduR1oa/+K6P50ISAwFlHyef+iUF+QEXAWIrRhZrmaIA3Ec
         RmCusY5b67YfBUkJMgfNjQqJ1r/5w1w52UoFoiMnXjy1M+iV0gXniVBfi1To5Y7UcvtO
         dOU5/hcG76AavPNEQO5pxGlqffkfzKoWpeUkfI8hfPGznNMfPQwGF+5bjDaVfr7AjI9Z
         6ibg==
X-Gm-Message-State: APzg51CXXc0CLZTFiAxbpUo4gKRhdx4VmfJlga1n1nB47N5QYhwjqLmz
        n9qMYrdySupO/c9nfeqtP/ykkCD7g1pCxrS1xcpZFw==
X-Google-Smtp-Source: ANB0VdYgyZm6PRM3r/egWT1J4dSMQDAVE4yX6rZ4LfIIpw3KFzIV59TFcEwy9MB59/5Rgb8d6Gjd5UNmQ+HP0YYUEn8=
X-Received: by 2002:a63:2605:: with SMTP id m5-v6mr22883554pgm.225.1536598941369;
 Mon, 10 Sep 2018 10:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180909154731.GA20381@gmail.com> <20180910095008.GB31531@arm.com>
In-Reply-To: <20180910095008.GB31531@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Sep 2018 10:02:09 -0700
Message-ID: <CAKwvOdn3SgUhPSUBwBm26X-Y3te1iYqwS9v=nyGCzC6KVNtJ6Q@mail.gmail.com>
Subject: Re: [PATCH] arch/arm64/include/asm/jump_label.h: use asm_volatile_goto
To:     Will Deacon <will.deacon@arm.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 2:49 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Sun, Sep 09, 2018 at 05:47:31PM +0200, Miguel Ojeda wrote:
> > All other uses of "asm goto" go through asm_volatile_goto
> > (including the arm version of the same file). For consistency,
> > use it here as well.
> >
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > ---
> >  arch/arm64/include/asm/jump_label.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks, I'll pick this up as a fix.
>
> Will
>
> > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > index 1b5e0e843c3a..7e2b3e360086 100644
> > --- a/arch/arm64/include/asm/jump_label.h
> > +++ b/arch/arm64/include/asm/jump_label.h
> > @@ -28,7 +28,7 @@
> >
> >  static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
> >  {
> > -     asm goto("1: nop\n\t"
> > +     asm_volatile_goto("1: nop\n\t"
> >                ".pushsection __jump_table,  \"aw\"\n\t"
> >                ".align 3\n\t"
> >                ".quad 1b, %l[l_yes], %c0\n\t"
> > @@ -42,7 +42,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
> >
> >  static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
> >  {
> > -     asm goto("1: b %l[l_yes]\n\t"
> > +     asm_volatile_goto("1: b %l[l_yes]\n\t"
> >                ".pushsection __jump_table,  \"aw\"\n\t"
> >                ".align 3\n\t"
> >                ".quad 1b, %l[l_yes], %c0\n\t"
> > --
> > 2.17.1
> >

Yes, this should help avoid a known miscompile in gcc < 4.8.2 (at
least for x86_64; not sure how backend specific the asm goto
implementation is in gcc, but this shouldn't hurt).
https://lkml.org/lkml/2018/9/7/1628

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
