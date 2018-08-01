Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32806C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE612208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m213dBMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE612208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbeHAWk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:40:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41055 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731482AbeHAWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:40:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id y10-v6so8460731pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 13:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LR80XNkbkMsNLBnP1iRZ1SZ5lPkf9Pj8qzbArdLki64=;
        b=m213dBMqUOyE8RjiwWqohEZFELxxjz1QfedFr//F/MwoHYEeQG21bffm8h0DZt+YNR
         /uh3faj8S+V6p3HBoNKfz7jx6lr+D6tKKIATP6jI6sGBz7b4zADdovQsPaYRQ0gnJj14
         Dz5L2nsShIQXlq+VK+8wKrITmIfn7GIuziWRXvdeuZuekYY++NePRWieNDTKYm6kH/ZL
         nGLwRQSa86pQGIOnYM4NxCPLD36+bhmwS0UCHVXwOVICC2hB4BSjbGSBdEvEqPy6JdHC
         T07TQkBrj4trjwEA0pVsDpFgGmJ7wbmLaTsvZten/F3uOPMXOdv7NwZUVEACykK6Z9Uv
         PY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LR80XNkbkMsNLBnP1iRZ1SZ5lPkf9Pj8qzbArdLki64=;
        b=e2ObkHnMt2FWwcMMlE+gg0z0U5RFHr/9z/oUTVCnz/YMkEGBw8q4/5XqmsjsgZZSoF
         WmJYY1vetIOP7uRfkEIlu/hGNYfmEp2V7GCAbgQDBQWUonP/3cDfbSsYUEbQHn6uEtj7
         zUFw1nsnA2jN3J0zc+wDNTXMvKkU08PJl2D6UpfYbSqNooAD431D2XDUbBU2WC/UPbMQ
         k3UC6E1RzmJgj2ciQ/isS9IQy0LTMZ1n8GvriL4zVyGqhCgBlxwCqNdvrzGf1IzQovgf
         QCBMitx3s1k8GCKgIwFvltxFeiQUqHToh5zqLaRV1E3bE9RcH6fPWsZTmKw40qJSL9YI
         /60Q==
X-Gm-Message-State: AOUpUlHZeUyvqeFfx9/gQu/vlTZmTskfWdkNN0ZZED2IyX74GUD1G/+a
        4s8j6/Q7gxfKR2FW+kSqUQwVhFSMj/6HUwQb14POCA==
X-Google-Smtp-Source: AAOMgpd0o71ps3YfJ+3Urn2f7Oms09NPaGFNLiO8xbcVqK8koY6sWrgXv7/3pMnAGFSerAIO7uUCeAjgBvNGioITS5Y=
X-Received: by 2002:a63:d916:: with SMTP id r22-v6mr25548806pgg.381.1533156770336;
 Wed, 01 Aug 2018 13:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180801182258.17834-1-ndesaulniers@google.com> <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net>
In-Reply-To: <78c667f9-5c8b-3835-83eb-4b59e27e4f7e@bell.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Aug 2018 13:52:39 -0700
Message-ID: <CAKwvOdmdrA+UvAWyqe8sNJt5nxHXHsSwf5Yxih9HYgVL+kovxQ@mail.gmail.com>
Subject: Re: [PATCH] parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions
To:     dave.anglin@bell.net
Cc:     deller@gmx.de, jejb@parisc-linux.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        pravin.shedge4linux@gmail.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, thanks for the quick review!

On Wed, Aug 1, 2018 at 1:10 PM John David Anglin <dave.anglin@bell.net> wrote:
>
> On 2018-08-01 2:22 PM, Nick Desaulniers wrote:
> > As part of the effort to reduce the code duplication between _THIS_IP_
> > and current_text_addr(), let's consolidate callers of
> > current_text_addr() to use _THIS_IP_.
> Using the generic _THIS_IP_ results in significantly longer code than
> the parisc implementation
> of current_text_addr().

It might be worthwhile to file a bug with your compiler vendor.  It
seems like there may be a better way to generate code for this
construct.

Also, I'm curious how hot this code is? I assume in general that the C
construct may be larger than the inline assembly, but I'm curious if
this introduces a performance regression or just makes the code
larger?  Do you have stats on the size difference and performance
differences?  What's more important to me is whether the patch is
correct...

> It also results in a local label in the text.
> This breaks the unwind data
> for the function with the label in 32-bit kernels.  The implementation
> of current_text_addr()
> doesn't add a label.

... oh, I guess I'm surprised that the label ends up in the code, vs
there just being a constant generated.  Can you send me the
disassembly?  Also, I'm curious how does having the label present in
the text break the unwinder?  (I'm not familiar with how unwinding
works beyond following frame pointers).

> _THIS_IP_ should be defined using
> current_text_addr() on parisc.

I'm trying to eliminate current_text_addr() in the kernel, as it only
has 4 call sites (3 are arch specific).  What are your thoughts on
making the current parisc current_text_addr() just a static function
(or statement expression that's local to) in
arch/parisc/kernel/unwind.c?

-- 
Thanks,
~Nick Desaulniers
