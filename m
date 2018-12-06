Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C49C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65251214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iai2qTMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65251214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeLFBQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:16:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43793 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFBQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:16:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id 83-v6so20120277ljf.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 17:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIARKccRROJyBU5Mh9PmrAjL909xKUQSNocjbfI8E6E=;
        b=iai2qTMtOM8VOZ7kMdaTQD3Hsu/UFlS16DiPdoN35yz7UjPUzt7t/FcI+M2m9JtvjX
         YQW1og1PWWwh38b8qJsrKywGewkXHwfHpInp/oqHKlGfW4iiLWmXGeap2Y4zD858x7In
         KUbDvkbqY0VVV4vr+MN/kijZ6rsNqKa/bh1ISdlQk0pszzl3qApaFOp5WAucRVC+S71H
         TDfPd7vKZKm7Z2ApMfDqpNlDp9x4VQcfZ+grIrBEA/ksbkbUdNePWpPeTJc+CLacZ9wD
         erw+0cze30tbUqMtreQAbHoVq9b4ljnsbrXyoNMymEhV9u3hQf0GYUkCdTP9rd+FrKkH
         ogYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIARKccRROJyBU5Mh9PmrAjL909xKUQSNocjbfI8E6E=;
        b=URKEgBe/3Yolnh8wX8g/CNBIFZalr14YZRAFsBmAu4qPEIDF5iKE0W/StR9ZHBJTsS
         zFUctxj2cc8rwqEvGZaywoKIdOdasuw85btL5UzPbokAiAbSy/M/8jUulody1BV2XAd1
         PW8h7973w9G5/flyrma7vUvU8YN99nxovqNJ5C9f1aZdq/ncqN4p0p809gq2RouHBNPx
         M67yMDV35HIQ7PyR9JJsZv5L3yz23jQqwMJl5c3IgbRv3xFxTuZ6TRt+QbIRhzq2UAwe
         qfr5+1+sNUMLtxngq53J7hiA2wEwMjn9/yEx6f/4mkyR785cw5KDdTEq4EgTNWW77ezA
         kXJg==
X-Gm-Message-State: AA+aEWaiVmtuukKxOObL8D/VjplYaNnRsfVFmLUCFZ+peXqllD52jJP0
        Fy0WZMLRPu1tH6KJzkd98TfU6bpRDY4tuEMy6uNGSA==
X-Google-Smtp-Source: AFSGD/XTqaeYVYfEds0q45DegGqszHDqy/HMkyKZ1m9ih8VmpmUUE5NfcDRjkQKbIAeTBHYpJevxMypHjXnYmqKOjlo=
X-Received: by 2002:a2e:890b:: with SMTP id d11-v6mr16667579lji.113.1544059011201;
 Wed, 05 Dec 2018 17:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20181205211601.75856-1-tkjos@google.com> <20181205220035.GX2217@ZenIV.linux.org.uk>
 <CAHRSSEwpYw312kBU4WGHs_P+xqx8cP+iripYVHxpV6pJBbH9Mw@mail.gmail.com> <20181206004037.GY2217@ZenIV.linux.org.uk>
In-Reply-To: <20181206004037.GY2217@ZenIV.linux.org.uk>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 5 Dec 2018 17:16:39 -0800
Message-ID: <CAHRSSEzLKc4dv0+4waD4fOiwoEO6j+PTYoHOBh-MJQgHR7+YbA@mail.gmail.com>
Subject: Re: [PATCH v2] binder: fix use-after-free due to fdget() optimization
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>, joel@joelfernandes.org,
        Android Kernel Team <kernel-team@android.com>,
        Jann Horn <jannh@google.com>, Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 4:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Dec 05, 2018 at 04:21:55PM -0800, Todd Kjos wrote:
>
> > > How about grabbing the references to all victims (*before* screwing with
> > > ksys_close()), sticking them into a structure with embedded callback_head
> > > and using task_work_add() on it, the callback doing those fput()?
> > >
> > > The callback would trigger before the return to userland, so observable
> > > timing of the final close wouldn't be changed.  And it would avoid the
> > > kludges like this.
> >
> > I'll rework it according to your suggestion. I had hoped to do this in a way
> > that doesn't require adding calls to non-exported functions since we are
> > trying to clean up binder (I hear you snickering) to be a better citizen and
> > not rely on internal functions that drivers shouldn't be using. I presume
> > there are no plans to export task_work_add()...
>
> Er...  Your variant critically depends upon binder being non-modular; if it
> *was* built as a module, you could
>         * lose the timeslice just after your fput()
>         * have another process hit the final fput() *and* close the struct file
>         * now that module refcount is not pinned by anything, get rmmod remove
> your module
>         * have the process in binder_ioctl() regain the timeslice and find the
> code under it gone.
>
> That's one of the reasons why such kludges are brittle as hell - normally you
> are guaranteed that once fdget() has succeeded, the final fput() won't happen
> until fdput().  With everything that guarantees in terms of code/data not going
> away under you.  This patch relies upon the lack of accesses to anything
> sensitive after that fput() added into binder_ioctl().  Which is actually
> true, but only because the driver is not modular...
>
> At least this variant (task_work_add()-based) doesn't depend on anything
> subtle - the lack of exports is the only problem there (IOW, it would've
> worked in a module if not for that).

Thanks for the detailed responses. I'll rework it for v3.
