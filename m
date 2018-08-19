Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B091CC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDB520989
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LDtMArVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDB520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeHTAF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 20:05:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41276 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeHTAF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 20:05:27 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so10987193iob.8;
        Sun, 19 Aug 2018 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EIPBHTFU/qncHFleNPiWjHQqDc+z4oIh79ATXejbqw=;
        b=LDtMArVrGhmyIOk2zvNgRlQJ0U6RBur2GlybzPL0MJmRcv4jE+U7v4e06ILxFXCvsl
         UdnqQ9EDXV3VR1hsgFGw+vo50pRIVhvV19Z0b1j4wkn772r92CN5d5GkbZ3yS9At1Quo
         4McctDnuRm53j87sbQzUWofdacT592aZsw6rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EIPBHTFU/qncHFleNPiWjHQqDc+z4oIh79ATXejbqw=;
        b=R7Yip9vu2A/TONljNFAMKY1oN4miORowPTCZWXarXT7OIGgDj1iOor05k0Ci+Kyve1
         PB9Q63qWoFAdQiV5w5ejsAE7c6oePmQT2VgdkOi9Tnevm/OLVfQ3jPN4APlafSj/+znN
         VMzoLh76SXp6Yy2rYk2DasBryImNDT7HlQdUPHzZJBlDb80SFTj/3iUNC57o8IG7NZ2C
         VVrgM0j9RHzSapbYxcNk6TV4/sf/UTkzaS53zfhauMr+YbkpBB7TN5hhhT4Hxa11jTDl
         lnmfRiBlZMYOm4stlFDyZtzgCCJNhdgs2LtEvbIK1xMsdCGgXOwZDmHYTKs6D9BNr51O
         3kBg==
X-Gm-Message-State: AOUpUlGHEjHicGi8N1yAjqatwpfbgdad0iW11jNKH8SfmqcyaVqz/Yv1
        oD9fW/03ESUBgXd0jMUzS7+yjZ3GXOLQygVIf/4=
X-Google-Smtp-Source: AA+uWPx+0By7ws2P4Jrfj97J+EofT7l6j5WFBPVBoBkJIFppwZQFDSe5n3lkPok/3Ry5BqtoFo6SGx660Yav6SKM/Dg=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr24269089ioh.203.1534711959753;
 Sun, 19 Aug 2018 13:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
 <CA+55aFwbdc5172q5fErgqhUmt48ZYQCrc0ftN+Cn6O-xQ8Tfrg@mail.gmail.com> <CAKwvOdk_-vfy7f7PKUELm=FHz9aBKMdbvoMv+5_o9K7jSCG+cw@mail.gmail.com>
In-Reply-To: <CAKwvOdk_-vfy7f7PKUELm=FHz9aBKMdbvoMv+5_o9K7jSCG+cw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Aug 2018 13:52:28 -0700
Message-ID: <CA+55aFyDZQhBQKLjYP5F7xfONRuu8m+aDXeRXZvk=8kb-+N1Kw@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Hogan <james.hogan@imgtec.com>, joe@ovn.org,
        daniel.santos@pobox.com, Rusty Russell <rusty@rustcorp.com.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gbiv@google.com, James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 1:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Aug 19, 2018 at 1:28 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Well, it turns out that we effectively stopped supporting gcc < 4.6
> > during this merge window for other reasons, so..
>
> For the whole kernel (or just a particular arch)?  Which commit?  Do
> we keep track of minimal versions somewhere?

It's effectively for the whole kernel right now. See:

    https://lore.kernel.org/lkml/20180814170904.GA12768@roeck-us.net/

although it might be fixable. Nobody really *wants* to fix it, though,
because we've had that initializer issue before too, and various other
issues with old gcc versions.

So we have long had reasons why we'd _want_ to upgrade to at least gcc-4.6

The "we support gcc-3.2" in Documentation/process/changes.rst is
complete fantasy.

              Linus
