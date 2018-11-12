Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4983C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF3E22511
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Grdmz2xD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF3E22511
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeKMAdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:33:36 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38454 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMAdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:33:36 -0500
Received: by mail-vk1-f195.google.com with SMTP id w72so2008991vkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=oxUWPhlswpgUSZKfLj7fFo/TjhItz+j8o7fcFiVa0io=;
        b=Grdmz2xD3KykmNgsD+Ef+Rdo+h7hBTlH10HNbckDUkiQY6flUvpc+ok6If3O/xXovt
         peb1eIQwkYUz5lveomi/4DiCT7qJHWtAVH7XSdiHbjci7evR8/3opYg6QK/sXye44L9U
         mOms1DjQY5GLmbriMi0b+WbtDVT4lGStFlQZ5RfGL4CRq/5uNUorNfwIwZd9HIVG8TUt
         kwqF78xZy/ps3SH8nlWxjLyPDonbj5NnPIS+CS1Bivw1/L5rS4fN3wL1NaFY7k0/UtK7
         zPqfLiCnrtrBQLPRRXGGCVJMv3tbUy0WRIm0MZ4OQLZvU7LfHE3JuClnBOMqconO0a8/
         SKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=oxUWPhlswpgUSZKfLj7fFo/TjhItz+j8o7fcFiVa0io=;
        b=tU1AXOY4FqKXELvrja7C8InFyfId9eoF0rOv+FXDK5CxKVavix+jSvRPg6CdKJpiyD
         Sg4Dc9ET4LQq4ezVzhLu6F1txRenljh/RzpJ1J3QiRN9yQewaVwk96cynBSZr5hYk1se
         JyxB4dqkvNE8LRmKOar85R3SiKzBpMyz9V4UxmtSRaVZvYW+ADjrIZp/CMv+fHv+9czK
         nl4E2UTmxokmJkKXcZmjVsgndDMXwOqoa6ztyfSUzRgBDl/Qa/tTy2aL0y+AWpAoN40O
         VJOI6gXeGiZ2n9tIrQF5kwNwFNFyxFO/xL+BWBu1vgCn6dAXFplxF3WOnmmOfY6FN/9i
         gDYA==
X-Gm-Message-State: AGRZ1gJP9IBMVaa/9XBvHwm+YBQBqqztguE3AufFxaCyVH5UymViq6rj
        KLXJuTX98ilGjaQ2RUttZ3fchxTZI2VHrZMBpg4BzA==
X-Google-Smtp-Source: AJdET5d/tyWzIS3zjyWXQ544rAWMtu1dS0pstyjgEeqaSerlHdwjAMIRdG2TLwgVJOdXnm01SKZCp5YnNTM97RXFm6I=
X-Received: by 2002:a1f:34c7:: with SMTP id b190mr492926vka.55.1542033601751;
 Mon, 12 Nov 2018 06:40:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 06:40:00
 -0800 (PST)
In-Reply-To: <20181112143506.GC7377@thunk.org>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <45cf58e0-909e-262c-5b9f-b91d62350a79@arm.com> <20181112143506.GC7377@thunk.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 12 Nov 2018 06:40:00 -0800
Message-ID: <CAKOZuevg6Bivv_E1CnhZA8OrUtSyCcwZPcNo7zE3J6+tQcEP7w@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Daniel Colascione <dancol@google.com>,
        Florian Weimer <fweimer@redhat.com>, nd <nd@arm.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 6:35 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Nov 12, 2018 at 12:45:26PM +0000, Szabolcs Nagy wrote:
>> >> A lot of the new system calls lack clear specifications or are just
>> >> somewhat misdesigned.  For example, pkey_alloc
>> > [snip]
>> >> getrandom still causes boot delays
>
> I'll note that what some people consider misdesigns, others consider
> "fix CVE's".
>
> Some people may consider it more important to avoid boot delays;
> others would consider internet-wide security problems, ala
> https://factorable.net to be higher priority.
>
> It's clear this is one area where I and some glibc developers have had
> a difference of opinion.  The bigger problem is that if a single glibc
> developer is able to veto any new system call, maybe we *do* need to
> have a kernel-provided library which bypasses glibc....

Historically speaking, the liberum veto has not led to good governance.
