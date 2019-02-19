Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C5CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A37C21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zHFthObN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfBSUku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:40:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34125 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSUku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:40:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id 98so36707031oty.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6e/PhI+bFWIx+Lv7REz9NfhuoKNC/7yafPmR49v56Ec=;
        b=zHFthObNzMO6Wc7YyDhk+tFHqf2fA8+AsQR1C0Uk7/H4vLUX1k0uvtaDJsKnxkxgcj
         IUfkg9gFC/+5cq5+xvTB293oS25yYNO8YJmq9EhXhShCHaFvYaJoivoa8Gv7oe2GA/Le
         9pvroJIvfoYYDytdtguqQ+TzMFwud3UFetr1OC2HUvWEzMy1rolPY4zN3IRWUqdpykDP
         0vU+KmwMUXGrMyiwW80eyEd0CnPXnvsoKD3vhRYyhkxVC3a3SVg/vqPGrGjKNOxJDrwp
         5P+5iKmDVutU1C5Ozs+45KVHEwPFm+bIq8q+2kRdZG2OpCqIrlpOnjHsKcEfsJIqwi7k
         u/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6e/PhI+bFWIx+Lv7REz9NfhuoKNC/7yafPmR49v56Ec=;
        b=ZulZnE0mvmpygsNNg01HZg94adRZC+wsHKqCSeDoALNr1SCKROkAuOsvNfpQ1oPM25
         3ek27Gh8roXEt2jkTTcYQICBPOMVRd/z5gLBXHMlaZeYC+AgqdmV7L/AlMzTO5V2+jyb
         eu16oKQFE6LLBnZXetcqZY7TPfN9Xs7evaLoTQY/9Ip7pG3KsVbz31iZjpe/TMulztFe
         PQPT6/CvWff953SYyYAL6Rv62ClYSqAUplg1ZWhYXvdMLJs6Ybv9IUpyPOLD9VNV4K4r
         CeyQkpjqDQdEjxpw8pcZlkZYSr9zQs5egyvvX5+8YPsNfZNQXOlwsLTYw9T5JRQpzTBP
         sWlw==
X-Gm-Message-State: AHQUAuYdiO/LLDoeEHCb2xK4KIrAaY5K/cHVeQNdsGVdIeXiEQT6MvGy
        uiUoLbgNws51tDjzlSXMnuS/8m/7SHSwbOjEW57VQQ==
X-Google-Smtp-Source: AHgI3IYo5ZwqtOq1nvE1yY2DRXShXZdfdFXpQ5b/aJzu9kNF3d06i32LdvtUyG3xjt4DVHKYvUqI7LjdHhbceRUPRa8=
X-Received: by 2002:a05:6830:1c1:: with SMTP id r1mr9992906ota.229.1550608849540;
 Tue, 19 Feb 2019 12:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20190219200430.11130-1-jglisse@redhat.com> <CAPcyv4gq23RXk3BTqP2O+gi3FGE85NSGXD8bdLk+_cgtZrn+Kg@mail.gmail.com>
 <20190219203032.GC3959@redhat.com>
In-Reply-To: <20190219203032.GC3959@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Feb 2019 12:40:37 -0800
Message-ID: <CAPcyv4gUFSA6u77dGA6XxO41217zQ27DNteiHRG515Gtm_uGgg@mail.gmail.com>
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

On Tue, Feb 19, 2019 at 12:30 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Feb 19, 2019 at 12:15:55PM -0800, Dan Williams wrote:
> > On Tue, Feb 19, 2019 at 12:04 PM <jglisse@redhat.com> wrote:
> > >
> > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > >
> > > Since last version [4] i added the extra bits needed for the change_p=
te
> > > optimization (which is a KSM thing). Here i am not posting users of
> > > this, they will be posted to the appropriate sub-systems (KVM, GPU,
> > > RDMA, ...) once this serie get upstream. If you want to look at users
> > > of this see [5] [6]. If this gets in 5.1 then i will be submitting
> > > those users for 5.2 (including KVM if KVM folks feel comfortable with
> > > it).
> >
> > The users look small and straightforward. Why not await acks and
> > reviewed-by's for the users like a typical upstream submission and
> > merge them together? Is all of the functionality of this
> > infrastructure consumed by the proposed users? Last time I checked it
> > was only a subset.
>
> Yes pretty much all is use, the unuse case is SOFT_DIRTY and CLEAR
> vs UNMAP. Both of which i intend to use. The RDMA folks already ack
> the patches IIRC, so did radeon and amdgpu. I believe the i915 folks
> were ok with it too. I do not want to merge things through Andrew
> for all of this we discussed that in the past, merge mm bits through
> Andrew in one release and bits that use things in the next release.

Ok, I was trying to find the links to the acks on the mailing list,
those references would address my concerns. I see no reason to rush
SOFT_DIRTY and CLEAR ahead of the upstream user.
