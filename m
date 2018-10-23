Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF71AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A608E20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsE6RXrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A608E20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJWVjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:39:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37718 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:39:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so1101671lfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsozTsWSujPDLKdeFoI7jJg6FEdZo7yl/LDEVwA3/3E=;
        b=lsE6RXrYGOswMC7OlkGgKxGRgDr6al4h/xpfgybAJlU3/MHu1TcCokgkf0V0+blqSU
         WIMYPirCIMrcjn/kqnymWaCTIU1OymfG+Gl+W52DsgrdrmJ89QiKo+/joziMS1Uz/dz8
         o0tpYIWi0bwR0k6QxNooC06xPg+UV8Y6ett3FoqKQgvJGusQnLUqdchiUcjKzB+Fdsby
         wb0NpiGDt9rNO1LunsjYRfKz/yzzwtuxm5hyos2wqwoBE+KCna3bvexq2POCpN5peXhp
         5VAFerkkSyWaQ/TTZuT4ioQxuGjyzs8afxOdVJ60lSCDglznct4liUoLRT3yIpR8lbOy
         rlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsozTsWSujPDLKdeFoI7jJg6FEdZo7yl/LDEVwA3/3E=;
        b=BfByHRKCNIt2G3QVBKxLRZWBK56NAgwkh8q2FT8dCu/QPGHELZvZkfxiTixhpN2O8v
         v5qzS5v8pTX22DAl5gzZedci19VmCvGvXQkp0OYZ0Z4G4uT6obUTC6BbOQKZjoXF4Rkm
         EkUP75J0RzqIxTtb7bZiQl5er3RHP4kpd6ow4pv/LIOltd/OjpJS9LVqdqssN53bNlKf
         CCSp2hmp6GDreVhvygKeb4bhnvOijk9Mm6YhY5T2qnJQ+w62dHhr3eJKWM1lsYP7O5qk
         YsflNBFlXUzWZnHJmy9D+wYoGf7ykIFG85EEj/vXE5farDDo34JHxR0fbuYohV0MmFNe
         JfOA==
X-Gm-Message-State: ABuFfohvr1vvsR+b8ofEco8g8M6vfsAM7t9g42VemBvUw5YNygMBfGSm
        WT9oM0JBKF6hWyMMROvkZ0UJQGxPQfdvWFS0SXc=
X-Google-Smtp-Source: ACcGV63KIU3ooTCFMj6zP2eYKY5IHpOUuHlbOkt3PdGohseAfiyPs+4w9WJTcCZ+cmx7now+gYtRkcyWz2PsKj9e4WM=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr3697137lfb.72.1540300569468;
 Tue, 23 Oct 2018 06:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
 <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
 <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
 <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
 <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
 <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com>
 <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
 <CAFqt6zZ2yHkVcbYtK1dxr9B3K5WVYGboavjP1ibmYei0u4zFbQ@mail.gmail.com>
 <20181023122435.GB20085@bombadil.infradead.org> <CAFqt6zZp=UsSGH148=tPWLnSxC51EGdR0Vv4f5tP58MO-6OS_w@mail.gmail.com>
 <20181023125928.GC20085@bombadil.infradead.org>
In-Reply-To: <20181023125928.GC20085@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 23 Oct 2018 18:45:56 +0530
Message-ID: <CAFqt6zYhXDG8276VfnzrBNM9JZnBsk0YeHP+yMAELB9e+Kt8uA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin@protonic.nl, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kees Cook <keescook@chromium.org>, treding@nvidia.com,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, aryabinin@virtuozzo.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, tchibo@google.com,
        riel@redhat.com, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, ak@linux.intel.com,
        rppt@linux.vnet.ibm.com, linux@dominikbrodowski.net,
        Arnd Bergmann <arnd@arndb.de>, cpandya@codeaurora.org,
        hannes@cmpxchg.org, Joe Perches <joe@perches.com>,
        mcgrof@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 6:29 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 23, 2018 at 06:03:42PM +0530, Souptick Joarder wrote:
> > On Tue, Oct 23, 2018 at 5:54 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Tue, Oct 23, 2018 at 05:44:32PM +0530, Souptick Joarder wrote:
> > > > Instruction from Matthew  Wilcox who is supervising the entire vm_fault_t
> > > > migration work :-)
> > >
> > > Hang on.  That was for the initial vm_fault_t conversion in which each
> > > step was clearly an improvement.  What you're looking at now is far
> > > from that.
> >
> > Ok. But my understanding was, the approach of vm_insert_range comes
> > into discussion as part of converting vm_insert_page into vmf_insert_page
> > which is still part of original vm_fault_t conversion discussion.  No ?
>
> No.  The initial part (converting all page fault methods to vm_fault_t)
> is done.  What remains undone (looking at akpm's tree) is changing the
> typedef of vm_fault_t from int to unsigned int.  That will prevent new
> page fault handlers with the wrong type from being added.

Ok, I will post the final typedef of vm_fault_t patch.

>
> I don't necessarily want to get rid of vm_insert_page().  Maybe it will
> make sense to do that, and maybe not.  What I do want to see is thought,
> and not "Matthew told me to do it", when I didn't.

I didn't mean it in other way. Sorry about it.
I will work on it.
