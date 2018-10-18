Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03334C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE6621473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqZZJbQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE6621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeJROgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:36:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41964 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbeJROgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:36:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id 23-v6so18088681qkh.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDJxdwTT12yhYvKmZG807JFrk96W5iVgM7oN/C3R7WI=;
        b=XqZZJbQgBQmgjNUsTPGprcySLmyTfJPghXHSMrIl4A/M0oaa30Q6YC8jGOxVcvWJAE
         2Ybk7kh75eDVsIumeHju7c+rTjaZC+1CKZPr/+StxYW42OmLrebqpBd9ZrS7M0Lh3VIz
         5uEM0NaU/1H/EQdbkXhBtwspQvmTanQw0E1wDgBxJPHMvhLqUaR3lw0r+4sDv//YzIwB
         tJ/yFphazz9yT8j48zcf7rJJQLQkOOlIqASsGkeUPMf8rmllHkextw/aP/5hPyslJcIn
         WDDFSUvaqJPkyRKKQDFVxqE7cVhd8Si7+CoEYYxkmLnwgpP5vSirLnp4PEedrlA8SfNN
         KBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDJxdwTT12yhYvKmZG807JFrk96W5iVgM7oN/C3R7WI=;
        b=PjUlm+VWccOI/RS/kvk8hIK3/1PjVJzK/2oQDv52LbypIGqcV3MOnXwGJzxJDQ7BUA
         ypmH700iXYntjIuVvlyR33q8/4grSbakPB607xYjV7jrZ+zmCCXlk6X19vRkDTkxZovL
         Y2kwp1HvlwJfrnizWqk+KKmVcOi6R0DGEagMgz8/VIFKBcQ1J3ICfM/SRjH0xkVE6oYI
         JM0Z0T1DlFBOND6K8BhWnc4goaj5+Dd8lhsLEhJl2WLeepaDPloQH5O0SJ5gQxDwpqGy
         kzWoSn8HCjGGWFXE4YN9ZensBVLdYlVEfeDroh8y28D8jayCxlzGc01eakZrpEYfDWov
         j+iw==
X-Gm-Message-State: ABuFfogsp7y19b5sFiNHMeNMseyUyglFiKHsppCN2ldbPTJWYqdOb3oY
        en0FP8u+b1TXLBQq/6srZA9AhCjMY8lL7IgtlNA=
X-Google-Smtp-Source: ACcGV61ZwJFCCjLDGqg8de0+5ZKZcTbpqMzExlA45jotSPXe489VVr+9xZoJZFyRW0OKTLVYGZIiNovDT0hL1/rUR/c=
X-Received: by 2002:a37:195c:: with SMTP id k89-v6mr26162127qkh.344.1539844627787;
 Wed, 17 Oct 2018 23:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181001103222.11924-1-kraxel@redhat.com> <20181001103222.11924-8-kraxel@redhat.com>
 <CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com> <20181018061059.d32xhg6ijlvpqyvi@sirius.home.kraxel.org>
In-Reply-To: <20181018061059.d32xhg6ijlvpqyvi@sirius.home.kraxel.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 18 Oct 2018 16:36:55 +1000
Message-ID: <CAPM=9tzwcPtOfNuoKdbSY0=EBsbsKgM04HZpzAazPEmDbQOXSw@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach, detach} calls.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 at 16:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Oct 18, 2018 at 11:41:52AM +1000, Dave Airlie wrote:
> > On Mon, 1 Oct 2018 at 20:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Remove the virtio_gpu_object_{attach,detach} calls from move_notify()
> > > callback.  Add them to the ttm_tt_{populate,unpopulate} callbacks, which
> > > is the correct place to handle this.
> > >
> > > The new ttm_tt_{populate,unpopulate} callbacks call the
> > > ttm_pool_populate()/unpopulate() functions (which are the default
> > > implementation in case the callbacks not present) for the actual ttm
> > > work.  Additionally virtio_gpu_object_{attach,detach} is called to
> > > update the state on the host.
> >
> > This to me feels more like a bind/unbind operation rather than a
> > populate/unpopulate operation,
> >
> > bind is " Bind the backend pages into the aperture in the location"
> >
> > whereas populate is
> >
> > allocate pages for a ttm.
>
> I ran into that trap too ;)
>
> My first attempt was to map this to bind/unbind.  But this is not
> correct and therefore didn't work very well.
>
> virtio_gpu_object_attach() will send a scatter list of the pages
> allocated for the object to the host (so the host knows where to
> copy from/to when processing the transfer_from/to calls).  So IMO
> it should be done on population not when binding.

Well bind on AGP is the same thing, we'd fill the AGP GART table on
bind, so that the AGP GPU could access the pages.

So I'm interested in why using bind/unbind failed if you have some more info?

Dave.
