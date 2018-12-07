Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D2FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1BA20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBqy2lvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1BA20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbeLGQZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:25:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39869 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLGQZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:25:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so3446175lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmdf3qUYsp8xNI177iO8uoCsXACQPDYdXXxhoUQuN1k=;
        b=XBqy2lvriByN2Mbr1tAGRuH5cmHq1xDm6vRlw9JrpBkK+X+DbOImZcKjbMnNMhDqjg
         xIEOiwPj46suzDAw75Hv9nTg2vgHIGIoLA8GvIaZaJRijZWw1MktA5I6d7Rj5Qq0G6eE
         UVDfMa3ARprC3O92Ll/p5M2VNhx+O6qUG3qkoYyxafdEplxPG/wpjvTwVpX9X+qbySm2
         wLs6HWaz+wOlO9JmatQUC8fn/NKRfvXvjBlAQxRepObIZqiLD1Y7ZyIBak7JvObRhlxG
         mXNI/AwJ4CUsvToQltoEVna1wf8dD4/yvK40FwF7JRKMs/NVEvsYLBlPDHGM9JdPVQOH
         DB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmdf3qUYsp8xNI177iO8uoCsXACQPDYdXXxhoUQuN1k=;
        b=cQOD6M6HvcVQbsSff/DlTZgLVWZJR7L38cr69x7HdY3v4IufccnHSBkbqgh8jxpAzF
         +66nEIjacQup9gNGYsFOuLmAP2hY2UThbaYJLMuXH12WwpCnek/7FZ5ChVrISPvXjdFd
         IzfnKU5QaE1N2MpvC0TSVKaOV8Tj4tylIyFlh8r15jDRBBNL9GxFFb6quvKPBhBsHCC/
         7aMhsfmQjnTqXz5KEvMtad2seSsZ7AcZsaQRPAdulrSHjQ2mNA7EafXxtV90slrLtv6a
         1jCtxWnMlUgamUP2L2uNPgnPBsoTxG/nZ9biAv/PAqcd3vEYTGoQVKlpfMW+onT8U3IW
         X24w==
X-Gm-Message-State: AA+aEWbrSUoJ44Ilt3yLsS5mH+aIG8qai8GvReHIan47xzO0q3vwxuXb
        Tr4/rTm2qytwm8IBoDgV3EC08RebafgXZHkhWdq4Ng==
X-Google-Smtp-Source: AFSGD/XtV46Tfg8qkCcfq9/o1qWpWmKvvVCdLEB0wcLx+o2UiIM2njndn64JmrRoTqEgLbv+KY64NhER39C4oZASBQU=
X-Received: by 2002:a19:280f:: with SMTP id o15mr1707331lfo.0.1544199947010;
 Fri, 07 Dec 2018 08:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20181205231926.45928-1-tkjos@google.com> <20181206144408.GA24078@kroah.com>
 <CAHRSSExQzgVZdk09rxoow-OTbEq0fhgW+MgemToEPEN=TiwWLA@mail.gmail.com> <20181207070828.GA8802@kroah.com>
In-Reply-To: <20181207070828.GA8802@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 7 Dec 2018 08:25:35 -0800
Message-ID: <CAHRSSExoDxyJNnxgWEbb_yM1ff5Rvf-5fhFSsXNqDVa7FPHrnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binder: fix sparse warnings on locking context
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:08 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
...
> But I thought I applied this back on November 26:
>         https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=char-misc-testing&id=324fa64cf4189094bc4df744a9e7214a1b81d845
>
> You should have gotten an email from my scripts at that time.
>
> or is this somehow a different patch with the same commit log?
> Or a v2 that changed from the one that I had applied?  Do I need to
> revert this one and apply your new one?

Sorry, you are right, you already applied it. I was thrown off by a
subsequent mail (https://lkml.org/lkml/2018/12/5/1042) in which you
said "Ok, no need for numbering them, but they do need to be resent
based on the feedback I gave.  I've dropped them all from my queue
because of that.".

So I thought it had been dropped. Anyway, glad its there and no need
for further action on it.

-Todd
