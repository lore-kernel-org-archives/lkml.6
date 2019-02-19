Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C009C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4613121479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YumcioM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfBSUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:49:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39130 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfBSUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:49:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so36641163otl.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vTwMs7LhCBRIWokSUAo3LAC/sg2rWNPJOXIoqkEFMek=;
        b=YumcioM4qmHVdnvpAAkSBzS5KKalQVl9aUwWD7tjIFoZktrmgw5R2dpVKI+c3AXdrn
         5C25ZgJEJYtn1IOhlL2Bbj10da7+HXls8zmr8vqjVZDXuOge7VqWmIrCadgPyTtu3fSG
         gc9mhS/E0LiYOmVm58yxwsMY738icUQ6jTCFRYJoqTWMdsqxzYb2KJGKP9uWCW/YPG8V
         IHmBIdqSJ2EyWJYWd1N8KA2TRUt44I8XyuoXB5sw7zDzO4/RJvMeTA/GvIZYCHPxrWsu
         wEAjzdpnMdDVg59Ek1qf4F9cuSF7ptRBRSqx5utCRrujMrfT9629rlkJno2IT9JM4mUg
         Rsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vTwMs7LhCBRIWokSUAo3LAC/sg2rWNPJOXIoqkEFMek=;
        b=pEMPRB5MEb1oRr349ePEUmgqqchQQ9MDxwe3UJK3EZjwJp3fG5VSNxqNdVnAXVHTwb
         IjkqKTB+yCL3yH5bKDCGf2luLXuUY5qTCp46CAvhi5geaGChORxO8wF3jcbwGJDdLu3P
         SZbbs6aYuvaNvj+Q43X3mlWsKSpIWRg3EK/mD3oD4mkL9xv7qx6KkXOtooqSgcd5FbEh
         bDCc2T94CDzjeBM/1KAZ+sG/oobqM+F1Bs+KKxpdP0LaPRDiOnwk7opwTksMMlUW/Ga5
         pzy3qYlT8At85GokfPnRNsD31nSKVt5CYfOX8pTTiLhFNr30ocD379sTQqRlMoHsdiMq
         j3pQ==
X-Gm-Message-State: AHQUAuYT7JlIjomFfUQmbmipviJv4ho6UpOWPAucma0E16ZsdgErBiQk
        RHCpNUc2DyvIuouGUDD+qiBpOEq1ocpImIVMoSME4w==
X-Google-Smtp-Source: AHgI3IZVGH/kGTid9uP882/dFlhil2xpi85z7X5itIZnkAkdaIaaAhjJuIIoTqjGmZ/y+RZaHUaqk00k8RcuCUYw6z8=
X-Received: by 2002:aca:fc06:: with SMTP id a6mr3841379oii.0.1550609387267;
 Tue, 19 Feb 2019 12:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20190219200430.11130-1-jglisse@redhat.com> <CAPcyv4gq23RXk3BTqP2O+gi3FGE85NSGXD8bdLk+_cgtZrn+Kg@mail.gmail.com>
 <20190219203032.GC3959@redhat.com> <20190219204017.GP738@mellanox.com>
In-Reply-To: <20190219204017.GP738@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Feb 2019 12:49:36 -0800
Message-ID: <CAPcyv4gZ=aJSixVwOCrxAf_fn4emx68_80SSFQdzGvvN0mHLGg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] mmu notifier provide context informations
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
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

On Tue, Feb 19, 2019 at 12:41 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Tue, Feb 19, 2019 at 03:30:33PM -0500, Jerome Glisse wrote:
> > On Tue, Feb 19, 2019 at 12:15:55PM -0800, Dan Williams wrote:
> > > On Tue, Feb 19, 2019 at 12:04 PM <jglisse@redhat.com> wrote:
> > > >
> > > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > >
> > > > Since last version [4] i added the extra bits needed for the change=
_pte
> > > > optimization (which is a KSM thing). Here i am not posting users of
> > > > this, they will be posted to the appropriate sub-systems (KVM, GPU,
> > > > RDMA, ...) once this serie get upstream. If you want to look at use=
rs
> > > > of this see [5] [6]. If this gets in 5.1 then i will be submitting
> > > > those users for 5.2 (including KVM if KVM folks feel comfortable wi=
th
> > > > it).
> > >
> > > The users look small and straightforward. Why not await acks and
> > > reviewed-by's for the users like a typical upstream submission and
> > > merge them together? Is all of the functionality of this
> > > infrastructure consumed by the proposed users? Last time I checked it
> > > was only a subset.
> >
> > Yes pretty much all is use, the unuse case is SOFT_DIRTY and CLEAR
> > vs UNMAP. Both of which i intend to use. The RDMA folks already ack
> > the patches IIRC, so did radeon and amdgpu. I believe the i915 folks
> > were ok with it too. I do not want to merge things through Andrew
> > for all of this we discussed that in the past, merge mm bits through
> > Andrew in one release and bits that use things in the next release.
>
> It is usually cleaner for everyone to split patches like this, for
> instance I always prefer to merge RDMA patches via RDMA when
> possible. Less conflicts.
>
> The other somewhat reasonable option is to get acks and send your own
> complete PR to Linus next week? That works OK for tree-wide changes.

Yes, I'm not proposing that they be merged together, instead I'm just
looking for the acked-by / reviewed-by tags even if those patches are
targeting the next merge window.
