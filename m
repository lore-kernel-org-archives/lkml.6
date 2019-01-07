Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C535C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FCD2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GhlypQwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfAGVj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:39:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39585 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAGVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:39:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so1701335otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 13:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z80/EW7jP2Dozhf7u2HjEJ4g+Xakfs/46qXiw6dX/nw=;
        b=GhlypQwjXhohSLGhE6FzdxmuWNWfYYx2C4AhEoa88lEbvIE82MDIof40uHJWHN+EKW
         zKH8HNfSrblg1EYvFiLUaO5ecCKmAK7IVzGGfG5sMQmKPgT0zx6kq9V9bf3Dcbl73CzU
         ixCTxYJPugy0IAq98kSb0sdmWxKJIlEFoSG+KRvqw5OxCPJTrbxmz8jWB7yvtNA5dth8
         mbqA9P5WJDrKNZxS20jwirJonpDRU5W94Y7qpIbClqC5ccsT8Qh9tiMOpwkt+yK5CGlr
         +eYE4vSKHMXpTag1Lof/K9J4VHGZrFN9RJQ6Imy2RDFGAS6qaHCphjVTKuC1Pqmi9EF9
         YWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z80/EW7jP2Dozhf7u2HjEJ4g+Xakfs/46qXiw6dX/nw=;
        b=XTZ5F9cNwQ5SywbI5qyV17WHCtQx80dGu0o7+giRk8zEYcwbzPLmvt9LkltgxITFY/
         NU1ohcXPwwGk9qD0MPttMNEEqRjtToeByro68MNWFNFtzoqunAyxarHYxaMhqd4/zze4
         Xl+lL8/YGfxz8U0XlF6us7Iy91+5LdLlox9HzyVJOWbWdjcWdQrqvEeEsH0FGbv0uqxN
         bccb5DG6iG6a43UiYcY+sNuH3r0RDCXTtZ4uvVgtPGVQcsbFZmSclZYhkdEB3AMiHnt2
         JMGTsO23/9wTenDj42z1RFyB6ficpGAwEXxn2SXyjU3F/io+0+vP9Cqlc+6Pdd4pzvxA
         Nq4Q==
X-Gm-Message-State: AJcUukdPY2RgTDPv7OAmFCXKMgl/Y1p2Eam7xmlQ8rZeg3PjtyOhOhRY
        HLW9Avk1xnDp7sx30Yrx/zgyxEyOolbtab5xAunuVkDt
X-Google-Smtp-Source: ALg8bN6QtXhp4hj05RY8MqQl9FF5gwnly7FfIqLbx0wzHU7uU/8NJx9ijRhdWgTQ3fvInUlzmmWW7FZMTmuAZ8XqUQ4=
X-Received: by 2002:a9d:3a0a:: with SMTP id j10mr42788949otc.229.1546897166580;
 Mon, 07 Jan 2019 13:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20181229124656.3900-1-jasowang@redhat.com> <20190102154038-mutt-send-email-mst@kernel.org>
 <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com> <20190106221832-mutt-send-email-mst@kernel.org>
 <c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com> <20190106230224-mutt-send-email-mst@kernel.org>
 <CAPcyv4iXFy0jfoQ_jQYq2yA7cqu4_Jcap4mvQesRRrV-hahGvQ@mail.gmail.com> <20190107084853-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190107084853-mutt-send-email-mst@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Jan 2019 13:39:15 -0800
Message-ID: <CAPcyv4jf-4=2oGJrdvMBeRiAJnQoKbYhwZDD+5ZEH+xgDaOzRQ@mail.gmail.com>
Subject: Re: [RFC PATCH V3 0/5] Hi:
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 6:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Jan 06, 2019 at 11:15:20PM -0800, Dan Williams wrote:
> > On Sun, Jan 6, 2019 at 8:17 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > >
> > > On Mon, Jan 07, 2019 at 11:53:41AM +0800, Jason Wang wrote:
> > > >
> > > > On 2019/1/7 =E4=B8=8A=E5=8D=8811:28, Michael S. Tsirkin wrote:
> > > > > On Mon, Jan 07, 2019 at 10:19:03AM +0800, Jason Wang wrote:
> > > > > > On 2019/1/3 =E4=B8=8A=E5=8D=884:47, Michael S. Tsirkin wrote:
> > > > > > > On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
> > > > > > > > This series tries to access virtqueue metadata through kern=
el virtual
> > > > > > > > address instead of copy_user() friends since they had too m=
uch
> > > > > > > > overheads like checks, spec barriers or even hardware featu=
re
> > > > > > > > toggling.
> > > > > > > Will review, thanks!
> > > > > > > One questions that comes to mind is whether it's all about by=
passing
> > > > > > > stac/clac.  Could you please include a performance comparison=
 with
> > > > > > > nosmap?
> > > > > > >
> > > > > > On machine without SMAP (Sandy Bridge):
> > > > > >
> > > > > > Before: 4.8Mpps
> > > > > >
> > > > > > After: 5.2Mpps
> > > > > OK so would you say it's really unsafe versus safe accesses?
> > > > > Or would you say it's just a better written code?
> > > >
> > > >
> > > > It's the effect of removing speculation barrier.
> > >
> > >
> > > You mean __uaccess_begin_nospec introduced by
> > > commit 304ec1b050310548db33063e567123fae8fd0301
> > > ?
> > >
> > > So fundamentally we do access_ok checks when supplying
> > > the memory table to the kernel thread, and we should
> > > do the spec barrier there.
> > >
> > > Then we can just create and use a variant of uaccess macros that does
> > > not include the barrier?
> > >
> > > Or, how about moving the barrier into access_ok?
> > > This way repeated accesses with a single access_ok get a bit faster.
> > > CC Dan Williams on this idea.
> >
> > It would be interesting to see how expensive re-doing the address
> > limit check is compared to the speculation barrier. I.e. just switch
> > vhost_get_user() to use get_user() rather than __get_user(). That will
> > sanitize the pointer in the speculative path without a barrier.
>
> Hmm it's way cheaper even though IIRC it's measureable.
> Jason, would you like to try?
> Although frankly __get_user being slower than get_user feels very wrong.
> Not yet sure what to do exactly but would you agree?

Agree. __get_user() being faster than get_user() defeats the whole
point of converting code paths to the access_ok() + __get_user()
pattern.

>
>
> > I recall we had a convert access_ok() discussion with this result here:
> >
> > https://lkml.org/lkml/2018/1/17/929
>
> Sorry let me try to clarify. IIUC speculating access_ok once
> is harmless. As Linus said the problem is with "_subsequent_
> accesses that can then be used to perturb the cache".
>
> Thus:
>
> 1. if (!access_ok)
> 2.      return
> 3.  get_user
> 4. if (!access_ok)
> 5.      return
> 6.  get_user
>
> Your proposal that Linus nacked was to effectively add a barrier after
> lines 2 and 5 (also using the array_index_nospec trick for speed),
> right? Unfortunately that needs a big API change.
>
> I am asking about adding barrier_nospec within access_ok.
> Thus effectively before lines 1 and 4.
> access_ok will be slower but after all the point of access_ok is
> to then access the same memory multiple times.

If the barrier is before lines 1 and 4 then it offers no real
protection as far I can see. It will start speculating again on the
user controlled pointer value after the barrier resolves.

> So we should be making __get_user faster and access_ok slower ...

I agree, but then the barrier always needs to be after the access_ok()
check unconditionally called in the return path from access_ok(). At
that point it's back to the implementation that Linus nak'd, or I'm
missing some other detail.

...but maybe if it is limited to a new access_ok_nospec() then the
concern is addressed? Then rename current __get_user() to
__get_user_nospec() and make a new __get_user() that is back to being
optimal.
