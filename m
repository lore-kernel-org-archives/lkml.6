Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835B8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D02021873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQjLNi60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeLSDbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:31:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41463 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSDbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:31:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so13901870lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 19:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyoE9cQYj2vKKeNaKbEZn+1/rj10Ta2+2thIX+qo1mM=;
        b=XQjLNi60OQMSNl8uGp8JWoIVDx7+LLcQ46BFKojokG5wz4nId2PwPWwcYXF5ewHn3J
         EcIbxmYeWA4HepLPpx4EPwnahRNcOFM/gb/YtjrlmkiGbWKogwhtsCSNmG6+zmyNMq64
         cZMXW2seVxU61ZS9BxO1qv/KMIwEGFmTcLUJH+1CX1hXFo5/KZSIXcBORrgh/kWEa2aZ
         xRhd5+UeLSPi1AVXhaH4zM5axZtfevgWIlDx+ZaH7e2KaZlSWdrEBjWuN1ZqEXuyI13U
         YW0Thnebflvl6Xbj7DGnoCBE+iNrtmHWTjBXZGgZKDJyzOXYb59SpOLpy+EvdrS+AqZ3
         6P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyoE9cQYj2vKKeNaKbEZn+1/rj10Ta2+2thIX+qo1mM=;
        b=af3s8TIWRjYEpP64vEWUSXd5btUwK+QclAezkwb2FBPyQoo59tHtXFMZL5x3Hpu1AA
         AOkjDCxNLDZBj1y9/1ldxtWdDaKDrFYRMLc8Hx77gWQa1btCZdx3BbMKTfvsY9zgmJEz
         As5Tfxa4kXZAES+QX2l/sGmuZt21FRTOFWXiT/8R1t9st1YZkYvSHJwMK/Ic9XCNq0d9
         xGosNx0bnrN8nlfzMhENou8S/mB3JnY83n7wCn+esgd76NN5fI5OgFB0Spkm/oQ/KYGN
         YkaNg93f7w3xViuDoqZM+qJetyPqirubgOIAzl9GZQuVDe3tkmHkZjzNna/waAQxPszF
         GBZA==
X-Gm-Message-State: AA+aEWZ9FThdJ+lHf++E7lnarSECwg4iTcTTKpX6eEphU5LnyShBRUbj
        i6XL9KV351AuGcPDI1uHXq5JZAVBNRLFIFuVxX8=
X-Google-Smtp-Source: AFSGD/XDXGEZjKZkD8gg6Kij5vdAu+Ms/qjx9Bu+i/tMgaufVgBZNtC0be8I7TrS0bbJWAI6cFCaXaYleSRgNHg75Qo=
X-Received: by 2002:a19:24c6:: with SMTP id k189mr11910717lfk.77.1545190280199;
 Tue, 18 Dec 2018 19:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk> <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk> <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
 <20181218130146.GO26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218130146.GO26090@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 19 Dec 2018 09:01:09 +0530
Message-ID: <CAFqt6zYnn76OdprSvA2Bj0v=xQqtJ6xJse6+iB+-=u3WsEv3pA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
        Linux-MM <linux-mm@kvack.org>, airlied@linux.ie,
        hjc@rock-chips.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 6:31 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 06:24:29PM +0530, Souptick Joarder wrote:
> > On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > > > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > > > <linux@armlinux.org.uk> wrote:
> > > > > This looks like a change in behaviour.
> > > > >
> > > > > If user_count is zero, and offset is zero, then we pass into
> > > > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > > > nothing and returns zero.
> > > > >
> > > > > However, as we can see from the above code, the original behaviour
> > > > > was to return -ENXIO in that case.
> > > >
> > > > I think these checks are not necessary. I am not sure if we get into mmap
> > > > handlers of driver with user_count = 0.
> > >
> > > I'm not sure either, I'm just pointing out the change of behaviour.
> >
> > Ok. I think feedback from Heiko might be helpful here :)
> >
> > >
> > > > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > > > pages (user_count = 6), then we call vm_insert_range() with a
> > > > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > > > end up inserting four pages.
> > > >
> > > > Considering the scenario, user_count will remain 8 (user_count =
> > > > vma_pages(vma) ). ? No ?
> > > > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > > > a pages_count
> > > > of 8 - 2 = 6. So we end up inserting 6 pages.
> > > >
> > > > Please correct me if I am wrong.
> > >
> > > vma_pages(vma) is the number of pages that the user requested, it is
> > > the difference between vma->vm_end and vma->vm_start in pages.  As I
> > > said above, "the user requests mapping 6 pages", so vma_pages() will
> > > be 6, and so user_count will also be 6.  You are passing
> > > user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> > > in my example.  This is two pages short of what the user requested.
> > >
> >
> > So, this should be the correct behavior.
> >
> >                  return vm_insert_range(vma, vma->vm_start,
> > rk_obj->pages + offset,
> >                                                           user_count);
>
> ... and by doing so, you're introducing another instance of the same
> bug I pointed out in patch 2.

Sorry but didn't get it ? How it will be similar to the bug pointed
out in patch 2 ?


>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
