Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DCF2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mw3KCraA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfBSVTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:19:21 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45238 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfBSVTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:19:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so36714421ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ivTKQNMtP2X3qCK3twrbZPzFwkoeeZNha+qut1LdGoU=;
        b=mw3KCraAh6U31DL397Vc95iRYXQapjrxWfVJNHMKSffaMwJrRHlKsIkWehqf1oB1rB
         6We2AazkMPhkraX7atDrshsNSGfNReBFNVXTQ9l61c0z/6PnNYd8K2VR4n7la7Upv2Ag
         jqnknScKG+/99v4FDg+RcEU0Xnc9flzu8A39Wcr/qCGXj6+m1cif5A/UvdD6nR4GoN8c
         l7y73quixJ1jqGTnxyOfRh65KvtD/vrgVinwbUwjkocUhTW2VpUD/Fbt5Qerk5kl+enS
         gWeky1JxEobjI6fci9qZcPPGtxRlAXPug2eETyzHVLoQXHuEwDq6hCe2Ju7Ek056pfIw
         jymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ivTKQNMtP2X3qCK3twrbZPzFwkoeeZNha+qut1LdGoU=;
        b=OtkcnMGVHEcJD1m6gkbAVeQkPjxhNmq3qS47RtPVjCl0jC917H16m/Sdz+dPFMdMmr
         6/LrJxJXANlW2o8vrmHi6CpEc54ht2jA9fGWJ2QYkG+EWF7xohxWDk+LAM1P9xg2BGAi
         c2IdMXU8iuYxMZMnkYsJOt+SkezsYnMKqdNKnMuIcEQvOs+sQf2/HfvLuQ4CXQByaXpu
         6zTcaNHYOyeqgyBR/6SBFWyDYjU9fwonUNRSaWd6yOHBHkywnJcv9Kawk7FNc6dF0AXz
         3v7dO/xbmZGOJA0qXi4fYBqb2UzRh3jzdnWIunTy4BXyqDCbr9WOBqstW6DtbymwWKzh
         m21g==
X-Gm-Message-State: AHQUAuae5QZ/szcPzgFdTSxqoJjrFzd9xo95ZzfSabPZ/he9aGPUfjs5
        /5ZsbaDNiD9SWLadhA3yc0si7aOPBORPKhuApkKwhw==
X-Google-Smtp-Source: AHgI3IbgJChOmrYGePyVfdKLtY6nJfYpTxrsBj/auowQtodHJ+dFuWWDIrwwUilMXIUwWa8TcHS8qqUI681XOYGd2G0=
X-Received: by 2002:a9d:7a87:: with SMTP id l7mr11513781otn.98.1550611159926;
 Tue, 19 Feb 2019 13:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20190219200430.11130-1-jglisse@redhat.com> <CAPcyv4gq23RXk3BTqP2O+gi3FGE85NSGXD8bdLk+_cgtZrn+Kg@mail.gmail.com>
 <20190219203032.GC3959@redhat.com> <CAPcyv4gUFSA6u77dGA6XxO41217zQ27DNteiHRG515Gtm_uGgg@mail.gmail.com>
 <20190219205751.GD3959@redhat.com>
In-Reply-To: <20190219205751.GD3959@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Feb 2019 13:19:09 -0800
Message-ID: <CAPcyv4hCNSsk5EP7+BcnVp-zJjQyQ701U3QXkQyUteQZr-ZumA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mmu notifier provide context informations
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        KVM list <kvm@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:58 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Feb 19, 2019 at 12:40:37PM -0800, Dan Williams wrote:
> > On Tue, Feb 19, 2019 at 12:30 PM Jerome Glisse <jglisse@redhat.com> wro=
te:
> > >
> > > On Tue, Feb 19, 2019 at 12:15:55PM -0800, Dan Williams wrote:
> > > > On Tue, Feb 19, 2019 at 12:04 PM <jglisse@redhat.com> wrote:
> > > > >
> > > > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > > >
> > > > > Since last version [4] i added the extra bits needed for the chan=
ge_pte
> > > > > optimization (which is a KSM thing). Here i am not posting users =
of
> > > > > this, they will be posted to the appropriate sub-systems (KVM, GP=
U,
> > > > > RDMA, ...) once this serie get upstream. If you want to look at u=
sers
> > > > > of this see [5] [6]. If this gets in 5.1 then i will be submittin=
g
> > > > > those users for 5.2 (including KVM if KVM folks feel comfortable =
with
> > > > > it).
> > > >
> > > > The users look small and straightforward. Why not await acks and
> > > > reviewed-by's for the users like a typical upstream submission and
> > > > merge them together? Is all of the functionality of this
> > > > infrastructure consumed by the proposed users? Last time I checked =
it
> > > > was only a subset.
> > >
> > > Yes pretty much all is use, the unuse case is SOFT_DIRTY and CLEAR
> > > vs UNMAP. Both of which i intend to use. The RDMA folks already ack
> > > the patches IIRC, so did radeon and amdgpu. I believe the i915 folks
> > > were ok with it too. I do not want to merge things through Andrew
> > > for all of this we discussed that in the past, merge mm bits through
> > > Andrew in one release and bits that use things in the next release.
> >
> > Ok, I was trying to find the links to the acks on the mailing list,
> > those references would address my concerns. I see no reason to rush
> > SOFT_DIRTY and CLEAR ahead of the upstream user.
>
> I intend to post user for those in next couple weeks for 5.2 HMM bits.
> So user for this (CLEAR/UNMAP/SOFTDIRTY) will definitly materialize in
> time for 5.2.
>
> ACKS AMD/RADEON https://lkml.org/lkml/2019/2/1/395
> ACKS RDMA https://lkml.org/lkml/2018/12/6/1473

Nice, thanks!

> For KVM Andrea Arcangeli seems to like the whole idea to restore the
> change_pte optimization but i have not got ACK from Radim or Paolo,
> however given the small performance improvement figure i get with it
> i do not see while they would not ACK.

Sure, but no need to push ahead without that confirmation, right? At
least for the piece that KVM cares about, maybe that's already covered
in the infrastructure RDMA and RADEON are using?
