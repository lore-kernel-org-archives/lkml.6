Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C24C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32B32175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja/qL1ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32B32175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbeKLPiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731062AbeKLPiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:38:07 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1668721780
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542001587;
        bh=GHnV4foAnRKJnwh5dpXkEzHGzUq4za6A+/kQnqR/OCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ja/qL1llhN/taiSECIjp+pY7xDey/UCVgPjuxI9OV6ggXN+g9rqKMKC2snrcVCzK9
         QyFLxmt/l2hSDKQm9g/+l11FyVFh/oCX+XGsWDCJXO5GHX4zfmucEnyC6xb+kx3nfI
         Hc2IK2MwRC/SObXABi3guudsJ+IkpON2erle2vuo=
Received: by mail-wm1-f54.google.com with SMTP id r11-v6so7147627wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:46:26 -0800 (PST)
X-Gm-Message-State: AGRZ1gJzv9qwg432M+NaB1jx6KCwcz/OxgPWYKCZE5nzDdn5c3U1GOWr
        y7D45vD/8DVW3h2oMueRAXtbVAomg4uFtbWpcNZU3w==
X-Google-Smtp-Source: AJdET5c8rm+TddIf3z6T/xNEp1mIIJzkj3ffzMtANaZzc5OxCUtlSFrnvfnvh0acKG6wtrVdSBYOdfADxenEpQ2KbHI=
X-Received: by 2002:a1c:410a:: with SMTP id o10-v6mr6583229wma.19.1542001585513;
 Sun, 11 Nov 2018 21:46:25 -0800 (PST)
MIME-Version: 1.0
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <20181110192027.GA29892@kroah.com> <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
In-Reply-To: <cd4717c4-4950-7513-726d-2e1873aeceb5@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 11 Nov 2018 21:46:13 -0800
X-Gmail-Original-Message-ID: <CALCETrWuW3f=c5V0W2CaLGD63MbbsYAeDwz04B+n7iRyQn7vQw@mail.gmail.com>
Message-ID: <CALCETrWuW3f=c5V0W2CaLGD63MbbsYAeDwz04B+n7iRyQn7vQw@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     "Carlos O'Donell" <carlos@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel Colascione <dancol@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 6:24 PM Carlos O'Donell <carlos@redhat.com> wrote:
>
> On 11/10/18 2:20 PM, Greg KH wrote:
> > Also, what about the basic work of making sure our uapi header files can
> > actually be used untouched by a libc?  That isn't the case these days as
> > the bionic maintainers like to keep reminding me.  That might be a good
> > thing to do _before_ trying to add new things like syscall wrappers.
> I agree completely. There are many steps in the checklist to writing
> a new syscall, heck we should probably have a checklist!
>
> Socially the issue is difficult because the various communities only
> marginally share the same network of developers, care about different
> features, or the same features with different priorities.
>
> That doesn't mean we shouldn't try to integrate better. As was pointed
> out, various people from the userspace and toolchain communities are
> going to LPC to do just this.
>

if you all want my two cents, I think that we should approach this all
quite differently than trying to get glibc to add a wrapper for each
syscall.  I think the kernel should contain a list or list of syscalls
along with parameter names, types, and numbers, and this should get
processed during the kernel build to produce a few different
artifacts:

 - A machine-readable version of the same data in a stable format.
Tools like strace should be able to consume it.

 - A library called, perhaps, libinux, or maybe a header-only library.
It should have a wrapper for *every* syscall, and they should be
namespaced.  Instead of renameat2(), it should expose
linux_renameat2().  Ideally it would use the UAPI header types, but
void * wouldn't be so bad for pointers.

P.S. Does gcc even *have* the correct asm constraints to express
typeless syscalls?  Ideally we'd want syscalls to have exactly the
same pointer escaping semantics as ordinary functions, so, if I do:

struct timeval tv;
/* typed expansion of linux_gettimeofday(&tv, NULL); */
asm volatile ("whatever" : "+m" (tv) : "D" (&tv));

it works.  But if I want to use a generic wrapper that doesn't know
that the argument is a pointer, I do:

asm volatile ("whatever" :: "D" (&tv));

then gcc seems to not actually understand that the value pointed to by
&tv is modified by the syscall.  glibc's syscall() function works
AFAICT because it's an external function, and gcc considers &tv to
have escaped and can't see the body of the syscall() function.
