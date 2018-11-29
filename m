Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C73C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53D02086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ayU39Uxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53D02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeK2OOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:14:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39092 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeK2OOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:14:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id g27so436558oth.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 19:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jNsdM36l1+JI+7oiCxL2M0sP9qzuFp1JavkYYubow+o=;
        b=ayU39UxmQLXBvPiKWDfDvYNLuvJSnwFHc6HyiKXfGfjvTqXyS8wAtV2jImW9NcBwr4
         +mFRaMtTquEm6NGpToEJk13v/y4it/YpoWed3LN8nEPk3fwy7BoavvltdXElH2xsWMPL
         LfAsp0J9t4HGfU3q60itVJ/DCIxS+9TXYI6LDR8nfR4nskwJsN64Kk3BVYNu+Pb2EMzt
         ZxoSseby/y4aA08g2ufY/3f/KsesGmhmUgW0z3a/oOkEtOUP6pjUkE4513OtSpw+UbuZ
         HtCchWNzL8OzO/WVtYsqUMKFzOHHME8uEYSLuo7dwhi27x/N3pyAoMO8moQOnUVr+h2k
         3oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jNsdM36l1+JI+7oiCxL2M0sP9qzuFp1JavkYYubow+o=;
        b=HGYY3PChUGKC7DR5MBK66Pc0EQWB6VTAqi2AyasNWxeHrxUvXPbk4WzpReBx04g9Pu
         iKAn0TelOyJQrIVtwPlzmBHKPVxowt6R87L+ts1pdLLx8SJ0vXQwJt/YmMvg7JRlSHEQ
         TxvtijE2NXz0ceGIrIr+bf99TgVSbJgzJ89ByQIkGyveSDwDQue5lY/O6HpO71jo0Zdn
         X90vqLlRhbHXuZqiqiaLUV9sNn15LmIPIBnm0tAwkIWqnU9kWwcoG5yZq7+D/B4nzQdt
         ZKjy2C0F9sNR8fWOx0bNa8PFegDft04GnJ6QDHSuQy7/eY0dVGqhoR4T5sI+gFJtxa5V
         5QAQ==
X-Gm-Message-State: AA+aEWamV0toUbzGM8bI8yEDXsGawEmmeuAaq2jpqUodOuGPYOoYtHo/
        xm04rXnfH/dh5X240okLjT9ybpvQ3eomNO4o4EeIgQ==
X-Google-Smtp-Source: AFSGD/XkQNXnH1leUoXGfVBvHNdLtndpBHs28PVijJeeED2WETZhKcWyupoB8tOs9kcpABRbRiMZmv/F20VAuOxOFQc=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr20969475otl.32.1543461046918;
 Wed, 28 Nov 2018 19:10:46 -0800 (PST)
MIME-Version: 1.0
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com>
 <6875ca04-a36a-89ae-825b-f629ab011d47@deltatee.com>
In-Reply-To: <6875ca04-a36a-89ae-825b-f629ab011d47@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 28 Nov 2018 19:10:35 -0800
Message-ID: <CAPcyv4i9QXsX9Rjz9E3gi643LQbSzaO_+iFLqLS+QO-GmrS0Eg@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mm, devm_memremap_pages: Fix shutdown handling
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 1:44 PM Logan Gunthorpe <logang@deltatee.com> wrote=
:
>
> Hey Dan,
>
> On 2018-11-20 4:13 p.m., Dan Williams wrote:
> > The last step before devm_memremap_pages() returns success is to
> > allocate a release action, devm_memremap_pages_release(), to tear the
> > entire setup down. However, the result from devm_add_action() is not
> > checked.
> >
> > Checking the error from devm_add_action() is not enough. The api
> > currently relies on the fact that the percpu_ref it is using is killed
> > by the time the devm_memremap_pages_release() is run. Rather than
> > continue this awkward situation, offload the responsibility of killing
> > the percpu_ref to devm_memremap_pages_release() directly. This allows
> > devm_memremap_pages() to do the right thing  relative to init failures
> > and shutdown.
> >
> > Without this change we could fail to register the teardown of
> > devm_memremap_pages(). The likelihood of hitting this failure is tiny a=
s
> > small memory allocations almost always succeed. However, the impact of
> > the failure is large given any future reconfiguration, or
> > disable/enable, of an nvdimm namespace will fail forever as subsequent
> > calls to devm_memremap_pages() will fail to setup the pgmap_radix since
> > there will be stale entries for the physical address range.
> >
> > An argument could be made to require that the ->kill() operation be set
> > in the @pgmap arg rather than passed in separately. However, it helps
> > code readability, tracking the lifetime of a given instance, to be able
> > to grep the kill routine directly at the devm_memremap_pages() call
> > site.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...=
")
> > Reviewed-by: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> > Reported-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I recently realized this patch, which was recently added to the mm tree,
> will break p2pdma. This is largely because the patch was written and
> reviewed before p2pdma was merged (in 4.20). Originally, I think we both
> expected this patch would be merged before p2pdma but that's not what
> happened.

Indeed, sorry I missed this.

>
> Also, while testing this, I found the teardown is still not quite
> correct. In p2pdma, the struct pages will be removed before all of the
> percpu references have released and if the device is unbound while pages
> are in use, there will be a kernel panic. This is because we wait on the
> completion that indicates all references have been free'd after
> devm_memremap_pages_release() is called and the pages are removed. This
> is fairly easily fixed by waiting for the completion in the kill
> function and moving the call after the last put_page(). I suspect device
> DAX also has this problem but I'm not entirely certain if something else
> might be preventing us from hitting this bug.
>
> Ideally, as part of this patch we need to update the p2pdma call site
> for devm_memremap_pages() and fix the completion issue. The diff for all
> this is below, but if you'd like I can send a proper patch.

Yes, please send a proper patch. Although, I'm still not sure I see
the problem with the order of the percpu-ref kill. It's likely more
efficient to put the kill after the put_page() loop because the
percpu-ref will still be in "fast" per-cpu mode, but the kernel panic
should not be possible as long as their is a wait_for_completion()
before the exit, unless something else is wrong.

Certainly you can't move the wait_for_completion() into your ->kill()
callback without switching the ordering, but I'm not on board with
that change until I understand a bit more about why you think
device-dax might be broken?

I took a look at the p2pdma shutdown path and the:

        if (percpu_ref_is_dying(ref))
                return;

...looks fishy. If multiple agents can overlap their requests for the
same range why not track that simply as additional refs? Could it be
the crash that you are seeing is a result of mis-accounting when it is
safe to assume the page allocation can be freed?
