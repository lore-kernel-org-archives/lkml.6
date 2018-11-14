Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151B3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A6422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kx4+YPnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A6422419
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbeKOEkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:40:06 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44260 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbeKOEkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:40:05 -0500
Received: by mail-vs1-f65.google.com with SMTP id g68so10116265vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 10:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xG9XBQgbQTRXyxbdTuCiqMyDaePdt/QZjbM0mDgrRZc=;
        b=kx4+YPnj8xW7r8u8WR5tpO+OaQHtMPmwkS3kI+DkSPUj72UkNEjfxtG9FreoYFcAqP
         wG/CObSc23iDMAyb8kRuXISIpi1L5JAOQOKAJiY7BPBiKGZVWtHC5Uwucs11hIXDZhgv
         E6mVR402kf1CuFLVyGaw3kG4V6hWYHREaZ9FjxTIi8RDxDJPD3cm7IR/KxKPN/aSPqip
         XZrOU4MdPrg4ke5JTC2Tx1s+tY7+EmQXkulcjoThqc8jnBLamxoLYIT+4+yXZGT2vkj3
         LJTeM2Dj+AJsv/lgrn8+gCSFJx2bs4Rxk1y4RtQTQ+xLbTC0CrwBsk+oKUqJ6ezXRPeE
         uxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xG9XBQgbQTRXyxbdTuCiqMyDaePdt/QZjbM0mDgrRZc=;
        b=MPl1oYAOogaJUXJZHPomA7J1gnNyEuU2qwf+on2xrafFZHus+vRms2yA65liIzxCFg
         WZmzdTQRHgloEGXivAD9N4ZCxscFGCfGz85Ms72Xytrj7prNY5Q3HDxJ5Mb+gcbBGdJu
         r6MJCNGllhH9TlCmTNMGiJDI32Wte6bgVtMGyWNFFmYqCA59kbdbgQ9ClxiqhmbN+S2P
         7p7LU5CH/E+QrFhNp4D4a6puKLkce6CJPMxY4wd7x0BvuWqCv/MP4rUlSzKqKOKRym6t
         B0eMEPtQP9RmVON1OzFNPxvwQEidQLUs83nGngT6J5U5FUU4yIa6kwqt8Pb7xcgms9Ab
         1ipg==
X-Gm-Message-State: AGRZ1gJYI+BC/YlckizYctbr8tmqd/EFePsAdukTBOwmxrRBFsFK6XtY
        iOSGiP1u6KMk23lY2gQGsyxelcyJP2yikHbWnD00iw==
X-Google-Smtp-Source: AJdET5fdiLPjnwwM4AT2qv/rKFor4pI4/wZ8vIJhuyeIgpzYaL8xZ1uaSAiw2pnkSVP6aBIHEoJ6San5bQTpOvJ9Bqo=
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr1347124vsc.149.1542220543757;
 Wed, 14 Nov 2018 10:35:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 14 Nov 2018 10:35:42
 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1811141741000.16571@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <20181113193859.GJ3505@e103592.cambridge.arm.com> <5853c297-9d84-86e5-dede-aa2957562c6b@arm.com>
 <CAKOZuesta_V=doXsVLc2E6WCQvywdur3F+u2pFKaPN+CEQd+ZQ@mail.gmail.com> <alpine.DEB.2.21.1811141741000.16571@digraph.polyomino.org.uk>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 14 Nov 2018 10:35:42 -0800
Message-ID: <CAKOZuetCGCfNdJ2QM0phu3_3Q29f5Yeh=NHiM_A9MhHsCjK48A@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>, nd <nd@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
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

On Wed, Nov 14, 2018 at 10:15 AM, Joseph Myers <joseph@codesourcery.com> wrote:
> Any
> feature (e.g. syscall library) with a design coming solely from the kernel
> rather than a cooperative process is also likely to have an unsuitable
> design meaning it doesn't get used.

Is that so? membarrier came directly from the kernel. It gets used and
appears to have a suitable design. That something isn't used by libc
doesn't mean that it doesn't get used in general.

>  Once we have sufficient communication
> to design suitable interfaces *together*, "avoiding the need to
> communicate" becomes irrelevant as a design criterion anyway.

If that approach is going to go work, the libc maintainership needs to
be more pragmatic, less idealistic, and less likely to block work on
purity grounds, e.g., we shouldn't do X because the dynamic linker
really should be out-of-process, we can't do Y because nobody should
be using signals, and we can't do Z because the kernel uses IDs that
have such-and-such ugly properties.

A good demonstration of a new commitment to pragmatism would be
merging the trivial wrappers for gettid(2).
