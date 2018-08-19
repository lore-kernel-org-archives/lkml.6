Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F26CC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 20:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A1F20C0C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 20:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCZw+8e+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A1F20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeHSXtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 19:49:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33521 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeHSXtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 19:49:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id r64-v6so4573916pgr.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRjLZRZgU1pwG7gLg8cPx6Tq10JlSBo0YCD9HXxKZhI=;
        b=WCZw+8e+awtesT7LDl+mufhIjd7HZjHfIUC1GTSvjgomta7Sqd135xOn8KRpWJR1uN
         mMnLEDqWSGVahW3JRUWUO2obFyRMvaNsZLkb9gdbVq5alwkf8qhKimMZHhHGYZyxT8PZ
         Zar/v4kQCb89fRT2HZF3foWqE8ooAxNmY+Fr4+62QTXlNUFLG/hAXry6dwZ/kInMkcvq
         jsyTujsVqtHZ+/CCpx0M904PnJdBFGeKabN41RL7JG4rWo1jLfnkIPdbmnf9x1DUc6IZ
         Kj+13Js8V+dvx7Rl1R5akiNhYSxCzYwRzG7lcGF6SQamI3a8blEkpo2LPawvAHqFInfC
         SyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRjLZRZgU1pwG7gLg8cPx6Tq10JlSBo0YCD9HXxKZhI=;
        b=VXcUW8Sxt2qmS+WswoRPSo2UeOVtCTfGmseiNRsA3RfigI4d5Lv88ljquNr0zIJs1l
         6uREJgL2AlcF0hKCiczM6KBH3hjUVikHRYSyFFSVkV/dcLw2h2miEL0mFi/R3yZd23vB
         tmf+3/9mCqzVf5TjNd3gbWDMuOv9WZdNhZ3X1iClnXMYdcunYmaeUebsUNfZld5OtQgx
         NyetliYVophUVIDALd3eBD+ZLaTID73vXBWoDyOJiBCNKju7/qDvvdygOSQ1Q+vIUMzi
         0Xu/mvZu5vVoJuMG99kSrGq5YX8CA+h5p+/ZouQUORdLGWYgK140ld++whlfaeaj6USq
         3L2Q==
X-Gm-Message-State: AOUpUlE9Wz0cD7HuPQUkBKr/8vijRazAr++T4cg49ljRUrb1rdcY/9Jt
        qej4H1SwwoLuq13QH1SPShxb4+33+4MheJuDaPyhyQ==
X-Google-Smtp-Source: AA+uWPwcPARnp562gY1g5/4SGTceD6B7gm1nE4oeb2wCTueqk4RbSd63+iIJcVg7OLJZmFpo74lbqGvZWDbt6EYHa28=
X-Received: by 2002:a63:190e:: with SMTP id z14-v6mr4116185pgl.302.1534711010612;
 Sun, 19 Aug 2018 13:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com> <CA+55aFwbdc5172q5fErgqhUmt48ZYQCrc0ftN+Cn6O-xQ8Tfrg@mail.gmail.com>
In-Reply-To: <CA+55aFwbdc5172q5fErgqhUmt48ZYQCrc0ftN+Cn6O-xQ8Tfrg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sun, 19 Aug 2018 13:36:39 -0700
Message-ID: <CAKwvOdk_-vfy7f7PKUELm=FHz9aBKMdbvoMv+5_o9K7jSCG+cw@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        james.hogan@imgtec.com, joe@ovn.org, daniel.santos@pobox.com,
        Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        George Burgess <gbiv@google.com>,
        James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 1:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Aug 19, 2018 at 1:25 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > + gbiv who wrote this cool paste (showing alternatives to
> > _Static_assert, which is supported by both compilers in -std=gnu89,
> > but not until gcc 4.6): https://godbolt.org/g/DuLsxu
> >
> > I can't help but think that BUILD_BUG_ON_MSG should use
> > _Static_assert, then have fallbacks for gcc < 4.6.
>
> Well, it turns out that we effectively stopped supporting gcc < 4.6
> during this merge window for other reasons, so..

For the whole kernel (or just a particular arch)?  Which commit?  Do
we keep track of minimal versions somewhere?
Documentation/process/changes.rst mentions gcc 3.2 (eek), but I assume
there's a compiler version check somewhere (if you're using gcc and
it's version is less than X, abort. Ditto for clang.)
-- 
Thanks,
~Nick Desaulniers
