Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C888FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84357217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtYLwGPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeLSSWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:22:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43378 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeLSSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:22:05 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so15756003lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IeYs86iDq7cyOihStjMvz4mBBZbg0DAkNumcXcY+CM=;
        b=RtYLwGPNskfIKa/EMDkwMB+PIWKALxrop3oFU30S3La5SyWNrVAUKmBBlViQdbC/Gt
         xk6ZrXKRUXvXOLmC90uLdeB2WQAzD1cKAqseMtfqYmpVwtav+zdQgQHTl0Qdt1/iot1E
         FKER+UjtOUtGoSTlJKEnL8sQ6P+Qr6tFzlUcv03FRleyhQcpkmrGOOeOiMqMoj0WE6tR
         d/0vN//vacbeqObuZnqk+XSM5Wm/7/ueFq+k8q3QRN8Qf8KhMBc7yiXWW72cXCieR0wq
         FY/gX0UvKKshN5Omm9pnfA/9ASBHjyTwtqRarUsEQq+TuuPxl15a8HmuMKqiAoXc/Lsc
         QQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IeYs86iDq7cyOihStjMvz4mBBZbg0DAkNumcXcY+CM=;
        b=Ns6ywGMDsFsi0C0Fquh5k46KyeYkTJoPYEdDU4YZQdy3OHjwbLMr+WgxCgo9Syoq46
         KPRANVpLDqLmoP3vLi9Ygh+l1+tvU9ISQ209gga+Fcp5g+2u6s1u0djdpiaZZIbLGOFQ
         GzdUfv8I24y96jTYkxjIu2/PBIbOsmJvwl8a/TAHxN1gCCZVws3NgHrQSrrbbXpQWAmn
         U3FTkSQ1kKNoqZD7VL/S0wXcIzeQ2dwyoNUa61Vnuvx0sXE+5ZM9Olt7R0VAYwmQCXq5
         agSK3ZCvGJiTQtle/dWscmsEMbQF9J2me6ec0Y+wxFKoAvPh1YweG0t0I2ouaUNWzb9E
         0pPA==
X-Gm-Message-State: AA+aEWZK/Ulfuc2Cnze/gR3wPPaES01zGiGKI+wToI68qfrDlnIYqhUD
        dzJ6Q8NR0fUjxhEMk7i6y1EWttlAEzH18NYxwv8=
X-Google-Smtp-Source: AFSGD/U4+etkcpwZmgu05EWcSRzsjyWLwn4L4YHtoom7ZiPxNh1XffCyXndSvLZWTDGNMKTez2MJTiOQOhQiBGD5ETs=
X-Received: by 2002:a19:d90c:: with SMTP id q12mr12688363lfg.24.1545243722628;
 Wed, 19 Dec 2018 10:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk> <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk> <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
 <20181218130146.GO26090@n2100.armlinux.org.uk> <CAFqt6zYnn76OdprSvA2Bj0v=xQqtJ6xJse6+iB+-=u3WsEv3pA@mail.gmail.com>
 <20181219093230.GS26090@n2100.armlinux.org.uk> <CAFqt6zbLrw5HENBiLXxPFqo7kk8uBJd3z-+C9Fnkej7u3W2i1w@mail.gmail.com>
 <20181219120623.GU26090@n2100.armlinux.org.uk>
In-Reply-To: <20181219120623.GU26090@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 19 Dec 2018 23:55:45 +0530
Message-ID: <CAFqt6zaHuN3ZrYKAEFKY+Vqxz+pBDbLbeopc5ORos=MotyG=sQ@mail.gmail.com>
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

On Wed, Dec 19, 2018 at 5:36 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Wed, Dec 19, 2018 at 05:16:09PM +0530, Souptick Joarder wrote:
> > On Wed, Dec 19, 2018 at 3:02 PM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Dec 19, 2018 at 09:01:09AM +0530, Souptick Joarder wrote:
> > > > On Tue, Dec 18, 2018 at 6:31 PM Russell King - ARM Linux
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Tue, Dec 18, 2018 at 06:24:29PM +0530, Souptick Joarder wrote:
> > > > > > On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
> > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > >
> > > > > > > On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > > > > > > > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > > > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > > > > This looks like a change in behaviour.
> > > > > > > > >
> > > > > > > > > If user_count is zero, and offset is zero, then we pass into
> > > > > > > > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > > > > > > > nothing and returns zero.
> > > > > > > > >
> > > > > > > > > However, as we can see from the above code, the original behaviour
> > > > > > > > > was to return -ENXIO in that case.
> > > > > > > >
> > > > > > > > I think these checks are not necessary. I am not sure if we get into mmap
> > > > > > > > handlers of driver with user_count = 0.
> > > > > > >
> > > > > > > I'm not sure either, I'm just pointing out the change of behaviour.
> > > > > >
> > > > > > Ok. I think feedback from Heiko might be helpful here :)
> > > > > >
> > > > > > >
> > > > > > > > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > > > > > > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > > > > > > > pages (user_count = 6), then we call vm_insert_range() with a
> > > > > > > > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > > > > > > > end up inserting four pages.
> > > > > > > >
> > > > > > > > Considering the scenario, user_count will remain 8 (user_count =
> > > > > > > > vma_pages(vma) ). ? No ?
> > > > > > > > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > > > > > > > a pages_count
> > > > > > > > of 8 - 2 = 6. So we end up inserting 6 pages.
> > > > > > > >
> > > > > > > > Please correct me if I am wrong.
> > > > > > >
> > > > > > > vma_pages(vma) is the number of pages that the user requested, it is
> > > > > > > the difference between vma->vm_end and vma->vm_start in pages.  As I
> > > > > > > said above, "the user requests mapping 6 pages", so vma_pages() will
> > > > > > > be 6, and so user_count will also be 6.  You are passing
> > > > > > > user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> > > > > > > in my example.  This is two pages short of what the user requested.
> > > > > > >
> > > > > >
> > > > > > So, this should be the correct behavior.
> > > > > >
> > > > > >                  return vm_insert_range(vma, vma->vm_start,
> > > > > > rk_obj->pages + offset,
> > > > > >                                                           user_count);
> > > > >
> > > > > ... and by doing so, you're introducing another instance of the same
> > > > > bug I pointed out in patch 2.
> > > >
> > > > Sorry but didn't get it ? How it will be similar to the bug pointed
> > > > out in patch 2 ?
> > >
> >
> > Thanks for the detail explanation.
> >
> > > Towards the top of this function, you have:
> > >
> > >         unsigned long user_count = vma_pages(vma);
> > >
> > > So what you are proposing does:
> > >
> > >         return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
> > >                                vma_pages(vma));
> > >
> > > Now if we look inside vm_insert_range():
> > >
> > > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > > +                       struct page **pages, unsigned long page_count)
> > > +{
> > > +       unsigned long uaddr = addr;
> > > +       int ret = 0, i;
> > > +
> > > +       if (page_count > vma_pages(vma))
> > > +               return -ENXIO;
> > > +
> > > +       for (i = 0; i < page_count; i++) {
> > > +               ret = vm_insert_page(vma, uaddr, pages[i]);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +               uaddr += PAGE_SIZE;
> > > +       }
> > >
> > > So, page_count _is_ vma_pages(vma).  So this code does these operations:
> > >
> > >         if (vma_pages(vma) > vma_pages(vma))
> > >                 return -ENXIO;
> > >
> > > This will always be false.  I've already stated in my reply to patch 2
> > > in paragraph 3 about the uselessness of this test.
> >
> > Agree, this will be always false for this particular/ similar instances.
> > But there are places [3/9], [6/9], [9/9] where page_count is already set
> > and it might be good to just cross check page_count > vma_pages(vma).
> >
> > This was discussed during review of v3 [1/9].
> > https://patchwork.kernel.org/patch/10716601/
> >
> > We can discuss again and if not needed it can be removed in v5.
> >
> > >
> > >         for (i = 0; i < vma_pages(vma); i++) {
> > >                 ret = vm_insert_page(vma, uaddr, pages[i]);
> > >
> > > So the loop will iterate over the number of pages that the user requested.
> > >
> > > Now, taking another example.  The object is again 8 pages long, so
> > > indexes 0 through 7 in its page array are valid.  The user requests
> > > 8 pages at offset 2 into the object.  Also as already stated in
> > > paragraph 3 of my reply to patch 2.
> > >
> > > vma_pages(vma) is 8.  offset = 2.
> > >
> > > So we end up _inside_ vm_insert_range() with:
> > >
> > >         if (8 > 8)
> > >                 return -ENXIO;
> > >
> > > As stated, always false.
> > >
> > >         for (i = 0; i < 8; i++) {
> > >                 ret = vm_insert_page(vma, vaddr, rk_obj->pages[2 + i]);
> > >
> > > Which means we iterate over rk_obj->pages indicies from 2 through 9
> > > inclusive.
> > >
> > > Since only 0 through 7 are valid, we have walked off the end of the
> > > array, and attempted to map an invalid struct page pointer - we could
> > > be lucky, and it could point at some struct page (potentially causing
> > > us to map some sensitive page - maybe containing your bank details or
> > > root password... Or it could oops the kernel.
> >
> > Consider the 2nd example.
> > The object is again 8 pages long, so indexes 0 through 7 in
> > its page array are valid.  The user requests 8 pages at offset 2
> > into the object.
> >
> > The original code look like -
> >
> >              unsigned long user_count = vma_pages(vma); // 8
> >              unsigned long end = user_count + offset // 8 + 2 = 10
> >               ...
> >               for (i = offset (2) ; i < end ( 10) ; i++) {
> >                   ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> >                   if (ret)
> >                      return ret;
> >                   uaddr += PAGE_SIZE;
> >               }
> >
> > we iterate over rk_obj->pages indices from 2 through 9.
> > Does it indicates the actual code have a bug when *offset != 0*.
>
> Please look at _all_ of the original code.
>
> Just like in your patch 2, you removed the tests that protect against
> this overflow:
>
> -       unsigned int i, count = obj->size >> PAGE_SHIFT;
>         unsigned long user_count = vma_pages(vma);
> -       unsigned long uaddr = vma->vm_start;
>         unsigned long offset = vma->vm_pgoff;
> -       unsigned long end = user_count + offset;
> -       int ret;
> -
> -       if (user_count == 0)
> -               return -ENXIO;
> -       if (end > count)
> -               return -ENXIO;
>
> 'count' will be 8.  'end' will be 10.  The existing code would have
> therefore returned -ENXIO.
>
> This is what I'm pointing out in my reviewed of your patches - they
> remove necessary tests and, by doing so, introduce these array
> overflows.

I change the code accordingly. Does it looks good ?

@@ -221,26 +221,18 @@ static int
rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
                                              struct vm_area_struct *vma)
 {
        struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
-       unsigned int i, count = obj->size >> PAGE_SHIFT;
+       unsigned int count = obj->size >> PAGE_SHIFT;
        unsigned long user_count = vma_pages(vma);
-       unsigned long uaddr = vma->vm_start;
        unsigned long offset = vma->vm_pgoff;
        unsigned long end = user_count + offset;
-       int ret;

        if (user_count == 0)
                return -ENXIO;
        if (end > count)
                return -ENXIO;

-       for (i = offset; i < end; i++) {
-               ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
-               if (ret)
-                       return ret;
-               uaddr += PAGE_SIZE;
-       }
-
-       return 0;
+       return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
+                               user_count);
