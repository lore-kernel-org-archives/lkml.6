Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA761C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBF720811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MWXAw3eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBF720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeLMASq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:18:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42538 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbeLMASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:18:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so245448otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trKvHReNYo/dk54jKRABoh0JOeqpM3qo9C96CdbN7mk=;
        b=MWXAw3eIrocyUG+1GBisNHfA5B/126iTcQadagNJR+ZYnOlsyV29qOY1VncRPLr++P
         gFD7jfBBa9aytzcBC0+UtC9nY/OivouxVYX5Uv7tsOOQ6tlZ6rpslNvzrA0ywLyq3KNB
         zN6V/htav21Y7p9pDepCJaxNiEdLtJ65+gmnbWYZMV4FPGoSssThnSGzQwfT6sJQV4rg
         oAKg5fjCNo83rCaF+WW3pc9fPkxRuxTKSTE/58+NejXABa2NQjpapozTjwrfjvcIg8an
         uPCutukMuUU365RR2qcnTJlwkj6UuOyygnnedB8Zxz3h+zOo0PZP1U678ttXTIY0CqKN
         OETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trKvHReNYo/dk54jKRABoh0JOeqpM3qo9C96CdbN7mk=;
        b=D1wDjhGFe6rxiZYFBk8LwqaQorud9MyiBVliof5ipssVDljquCBD5E2F75tMX6mEZg
         ems53ink2Kl+WJ8bu5I9O3R9i05OycJd77enRF6SIFK8gi5QmJ53RWvoQ8AGq/08exaY
         a56lBsmSjPvtc6ICOBTjZ4CZjAvCkIuwRAOxHD9F0I0By+vJfCYKk4PAPADpOnrftKTL
         hYTyaMYgLxZ2Igl3JH5XjhVfwdfe1rKCXkOj1CVCS5g0Ovr/UAWt3eq5sEyJuJmC82LD
         0044UxWV/Kww3bMpR/U4jpta+KJWRvHpM2QcBa3Y2G5v0XhbRBJKpCVrtHFxHJTLvzh9
         mRLQ==
X-Gm-Message-State: AA+aEWaj3If3YRidGHc9+jeL2/btwVoPsdQpsh6FpfjLQt3a3xjg/DbG
        yQMw6RH5PbYYjJTEzjwj2N70JkFoWz00wPbxVlthoA==
X-Google-Smtp-Source: AFSGD/WNfv+wsm+e8QLHC01qWENkG0UIsRBUpP6LiKYTsH2+mSSKlDWKRG5MdDXExW5Zm0fv9VEsg+9Tr+eOEXCnwRM=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr14865456otf.98.1544660324967;
 Wed, 12 Dec 2018 16:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20181207191620.GD3293@redhat.com> <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com> <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
 <20181212213005.GE5037@redhat.com> <CAPcyv4gJHeFjEgna1S-2uE4KxkSUgkc=e=2E5oqfoirec84C-w@mail.gmail.com>
 <20181212215348.GF5037@redhat.com> <20181212233703.GB2947@ziepe.ca> <20181213000109.GK5037@redhat.com>
In-Reply-To: <20181213000109.GK5037@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Dec 2018 16:18:33 -0800
Message-ID: <CAPcyv4ii6hyrNj=fijoZ1no8w6N1Kk2jGZyWCn7hFKNKaNsyXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 4:01 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Wed, Dec 12, 2018 at 04:37:03PM -0700, Jason Gunthorpe wrote:
> > On Wed, Dec 12, 2018 at 04:53:49PM -0500, Jerome Glisse wrote:
> > > > Almost, we need some safety around assuming that DMA is complete the
> > > > page, so the notification would need to go all to way to userspace
> > > > with something like a file lease notification. It would also need to
> > > > be backstopped by an IOMMU in the case where the hardware does not /
> > > > can not stop in-flight DMA.
> > >
> > > You can always reprogram the hardware right away it will redirect
> > > any dma to the crappy page.
> >
> > That causes silent data corruption for RDMA users - we can't do that.
> >
> > The only way out for current hardware is to forcibly terminate the
> > RDMA activity somehow (and I'm not even sure this is possible, at
> > least it would be driver specific)
> >
> > Even the IOMMU idea probably doesn't work, I doubt all current
> > hardware can handle a PCI-E error TLP properly.
>
> What i saying is reprogram hardware to crappy page ie valid page
> dma map but that just has random content as a last resort to allow
> filesystem to reuse block. So their should be no PCIE error unless
> hardware freak out to see its page table reprogram randomly.

Hardware has a hard enough time stopping I/O to existing page let
alone switching to a new one in the middle of a transaction. This is a
non-starter, but it's also a non-concern because the bulk of DMA is
transient. For non-transient DMA there is a usually a registration
phase where the capability to support revocation can be validated,
