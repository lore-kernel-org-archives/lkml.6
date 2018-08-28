Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6785FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8E5208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9jLtIIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8E5208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeH1KIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:08:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33413 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeH1KIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:08:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so409454ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 23:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3ZxWAHf0lKc/N/XG2kkanZL5s9Nsv0yUQTkx+Mg4aU=;
        b=C9jLtIIrFlqSICJk5vhFh5dsreD2IGx9lYS/ds+Xgw9jajR53CKMnzNfrXTztuAE85
         //4DJR/M3aZJLdRNtmw7ztpOux3C66wnmGScOVJI18RC/q+Ev0wx9PJBaWjyIygUIBks
         OeFDMlH8H4TvWxXv+kQUWIi1h/KwUTbG3/stwFwiCUcPez9ACB82AUYcBg3XZQTdUyWv
         MTmSfrNulMtwkzsPig26+7DvHd78LvN7aLE+1g1Vppi0of5H+5Geipt0xFw6MqK5vLFp
         nY9dGWmlasU1d6qSlXIKK4c+PzrjvV2IQmiH+i+cUTFn7gAqq/AV5K//gk0AhL3Vnrid
         BASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3ZxWAHf0lKc/N/XG2kkanZL5s9Nsv0yUQTkx+Mg4aU=;
        b=hucpUPdgpafnEUxIKOOKpYzEwSi3/nRaVtogX/uWMSeivJN8qU/EAye9juN3zLUCsB
         5hNwKtFwCa2/WEQBkTAVHiWiGAIU60nDzKLbi/2nPpiSF8ac7Gj8Yj96TKeGCS/CAQec
         zF4DLwJUoc6LwH6DD7F82A4MQmLclRfhN1fG/huFuFbAog0NGfbNqiRQAn+y5F2ffCbd
         DzQcbLkMtv6yTxIGbH2LbDAnNkYdiH5fHQoPYrJVo5aZDCGqhRG7bhB5rGypHvabs300
         UMCfM5UM25gucSTZTCtQpXDlax4Ae7AXaKesgNH/WDAjGeJ/T4r4CCD00brmPZCkShFa
         rpKw==
X-Gm-Message-State: APzg51DNwYlzsuEuKwC+IxyjJgXX66uKaXpHIKKrzoAXA8YRO3nPWRLC
        /uAJxniB7BRVcRekUPdmYrbS3fVIJ33kVs9hBkygaXUu
X-Google-Smtp-Source: ANB0VdaY1zdp6b/L9zZOl27d3av7Gnua7aImgt9uJ1D+wMgXgFZID7BamdlWCNNlggTtYfU6JQGLsTabzov53yifK+c=
X-Received: by 2002:a2e:5201:: with SMTP id g1-v6mr125509ljb.144.1535437104511;
 Mon, 27 Aug 2018 23:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180703123910.2180-1-willy@infradead.org> <20180703123910.2180-2-willy@infradead.org>
 <alpine.DEB.2.21.1807161116590.2644@nanos.tec.linutronix.de>
 <CAFqt6zbgoTgw1HNp+anOYY8CiU1BPoNeeddsnGGXWY_hVOd5iQ@mail.gmail.com>
 <alpine.DEB.2.21.1808031503370.1745@nanos.tec.linutronix.de>
 <CAFqt6zbJq9kca8dHDVAs-MOWNZgo2C=id3Cp4M0C76MQDXevJg@mail.gmail.com> <20180827180544.GA24544@bombadil.infradead.org>
In-Reply-To: <20180827180544.GA24544@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 28 Aug 2018 11:48:12 +0530
Message-ID: <CAFqt6zZ+4aTiOK13a61hCHKY9p=GkaNiagV6zQ4zVZRM1fHq5g@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: Convert vdso to use vm_fault_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:35 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 27, 2018 at 09:01:48PM +0530, Souptick Joarder wrote:
> > On Fri, Aug 3, 2018 at 6:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > On Fri, 3 Aug 2018, Souptick Joarder wrote:
> > > > On Mon, Jul 16, 2018 at 2:47 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > On Tue, 3 Jul 2018, Matthew Wilcox wrote:
> > > > >
> > > > >> Return vm_fault_t codes directly from the appropriate mm routines instead
> > > > >> of converting from errnos ourselves.  Fixes a minor bug where we'd return
> > > > >> SIGBUS instead of the correct OOM code if we ran out of memory allocating
> > > > >> page tables.
> > > > >>
> > > > >> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > > > >
> > > > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > > >
> > > >
> > > > Thomas, are these 3 patches part of this series will be queued
> > > > for 4.19 ?
> > >
> > > I don't know. I expected that these go through the mm tree, but if nobody
> > > feels responsible, I could pick up the whole lot. But I'd like to see acks
> > > from the mm folks for [1/3] and [3/3]
> > >
> > >   https://lkml.kernel.org/r/20180703123910.2180-1-willy@infradead.org
> > >
> > > Thanks,
> > >
> > >         tglx
> > >
> >
> > Any comment from mm reviewers for patch [1/3] and [3/3] ??
> >
> > https://lkml.kernel.org/r/20180703123910.2180-1-willy@infradead.org
>
> I think at this point, it would probably be best to ask Andrew to pick
> up all three of these patches.

Do we need to repost these three patches or lkml link
https://lkml.kernel.org/r/20180703123910.2180-1-willy@infradead.org
is fine to request Andrew ??


> In addition to these three, I see the following places that need to be changed:
>
> Documentation/gpu/drm-mm.rst:300:               int (*fault)(struct vm_fault *vmf);
ok, I will add this.

>
> drivers/gpu/drm/virtio/virtgpu_ttm.c:117:static int virtio_gpu_ttm_fault(struct vm_fault *vmf)
>  - #if 0 code.  convert anyway.

https://lkml.org/lkml/2018/7/2/795
Gerd Hoffmann, agreed to remove this dead code, but queued for 4.20.
I think, this shouldn't be a blocker for us.

>
> drivers/gpu/drm/vkms/vkms_drv.h:68:int vkms_gem_fault(struct vm_fault *vmf);
> drivers/gpu/drm/vkms/vkms_gem.c:46:int vkms_gem_fault(struct vm_fault *vmf)

This was not queued for 4.19. Would you like to see this patch in 4.19-rc-x ?
https://lkml.org/lkml/2018/7/30/767

>
> fs/ext4/ext4.h:2472:extern int ext4_page_mkwrite(struct vm_fault *vmf);
> fs/ext4/ext4.h:2473:extern int ext4_filemap_fault(struct vm_fault *vmf);
> fs/ext4/inode.c:6154:int ext4_page_mkwrite(struct vm_fault *vmf)
> fs/ext4/inode.c:6251:int ext4_filemap_fault(struct vm_fault *vmf)

I have this patch ready in my local tree based on review comment
from Ted. Ted was planning to take it in next merge window.
I will post it on mailing list.

>
> fs/iomap.c:1059:int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
> include/linux/iomap.h:144:int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops);
>  - I saw you just resent this patch.

Now added to mm-tree.

> mm/filemap.c:2751:int filemap_page_mkwrite(struct vm_fault *vmf)
>  - This is the NOMMU case, so I suspect your testing didn't catch it.
Sorry, I missed it.
