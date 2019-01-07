Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6130FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5272087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0oFPjrJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfAGHPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:15:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33487 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfAGHPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:15:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so37016568otl.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 23:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jUn2L42DdrAXbf45yhwWXIPK7d0thmuwytNqiirKAlY=;
        b=0oFPjrJyxcr4REz3fl4P7aZEdmlbC2CIht3LlByZKgYU7tMbSo3h13dBHvd14fYEMX
         vZmf9+SR6jFpRrOIDxBexfnwfp5tPQCKnVmU8JxJI88rVMucq7VDMZJ5daWrnUClB7Ai
         cn1Nb9BLkdSO09NmuZvKscDKEiH3Fk7sjXqInW//rgGT3XI7Xm2QmyBoPGzPbSyJjISS
         sP0Teq8J4HwKUsnMVjR/vX9A8X5UGompgm5Tof/+3rRpdcc03FNQ1CgJwutOtxOKpeu7
         jnToX5qJ1Xatvasyk0JbvCXgLabsR5UIO9NeNpVLCDr55hdKKrN5dghapY3CGDyBY6j1
         fYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jUn2L42DdrAXbf45yhwWXIPK7d0thmuwytNqiirKAlY=;
        b=CyK7spk+YpqEgC4KuX3LyG3rt5g2urx4AnbjaLN3tBinTn7PQB2dkgxyVUSIYlC89P
         B2tMieWZz4ITEAuHfJeHmyMUe6EN11/VTiIiZRJKDhMZfYQTHahD8KlUhKX7VQRAo39D
         /lu0VZ50u5XHmr3I/nDLu1jOfk8ytGN08+8dcnUVs5HBQ93SCEovIxTiWt/pbhTxS2Zz
         e4laSwuBE2gs7fqvrME5C/sCdhJ1CP/+Z0Ywb242ZgDDCuWdsdE6m3gXgh2jg2R+PfNB
         n6Z0cWaVkH5BoU6YEKP9vZHT1zxXdPXpPRSKLZGziUWMw0IVMzMoERYiklu99cecJ96y
         pByg==
X-Gm-Message-State: AJcUukdMKPsWEupvGd84bbHVPS3OmJ2hvmVQxVitRYn3awOjAwypJEk5
        hp2kWjOIYkGBXyGfe9myfllkGJPAV0PxNPOa7hoFAg==
X-Google-Smtp-Source: ALg8bN7z4yaals0cubNfBm4CxA8IgtT+xr/ryphhHjUQLqskMm1uQT+1Uj5XiilQ4DFGIaWNkXv6Ub4e0Y/CyYVK9rA=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr43399405otn.214.1546845331922;
 Sun, 06 Jan 2019 23:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20181229124656.3900-1-jasowang@redhat.com> <20190102154038-mutt-send-email-mst@kernel.org>
 <0efd115a-a7fb-54bf-5376-59d047a15fd3@redhat.com> <20190106221832-mutt-send-email-mst@kernel.org>
 <c15a17b3-b604-a105-af44-a7e6dfd79801@redhat.com> <20190106230224-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190106230224-mutt-send-email-mst@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 6 Jan 2019 23:15:20 -0800
Message-ID: <CAPcyv4iXFy0jfoQ_jQYq2yA7cqu4_Jcap4mvQesRRrV-hahGvQ@mail.gmail.com>
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

On Sun, Jan 6, 2019 at 8:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jan 07, 2019 at 11:53:41AM +0800, Jason Wang wrote:
> >
> > On 2019/1/7 =E4=B8=8A=E5=8D=8811:28, Michael S. Tsirkin wrote:
> > > On Mon, Jan 07, 2019 at 10:19:03AM +0800, Jason Wang wrote:
> > > > On 2019/1/3 =E4=B8=8A=E5=8D=884:47, Michael S. Tsirkin wrote:
> > > > > On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
> > > > > > This series tries to access virtqueue metadata through kernel v=
irtual
> > > > > > address instead of copy_user() friends since they had too much
> > > > > > overheads like checks, spec barriers or even hardware feature
> > > > > > toggling.
> > > > > Will review, thanks!
> > > > > One questions that comes to mind is whether it's all about bypass=
ing
> > > > > stac/clac.  Could you please include a performance comparison wit=
h
> > > > > nosmap?
> > > > >
> > > > On machine without SMAP (Sandy Bridge):
> > > >
> > > > Before: 4.8Mpps
> > > >
> > > > After: 5.2Mpps
> > > OK so would you say it's really unsafe versus safe accesses?
> > > Or would you say it's just a better written code?
> >
> >
> > It's the effect of removing speculation barrier.
>
>
> You mean __uaccess_begin_nospec introduced by
> commit 304ec1b050310548db33063e567123fae8fd0301
> ?
>
> So fundamentally we do access_ok checks when supplying
> the memory table to the kernel thread, and we should
> do the spec barrier there.
>
> Then we can just create and use a variant of uaccess macros that does
> not include the barrier?
>
> Or, how about moving the barrier into access_ok?
> This way repeated accesses with a single access_ok get a bit faster.
> CC Dan Williams on this idea.

It would be interesting to see how expensive re-doing the address
limit check is compared to the speculation barrier. I.e. just switch
vhost_get_user() to use get_user() rather than __get_user(). That will
sanitize the pointer in the speculative path without a barrier.

I recall we had a convert access_ok() discussion with this result here:

https://lkml.org/lkml/2018/1/17/929

...but it sounds like you are proposing a smaller scope fixup for the
vhost use case? Something like barrier_nospec() in the success path
for all vhost access_ok() checks and then a get_user() variant that
disables the barrier.
