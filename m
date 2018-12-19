Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3785CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020DF218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UT1zFWSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeLSF0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:26:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46553 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeLSF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:26:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so17981083otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 21:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjCpzgo0z2DvoSBkodr70hp1a2SwXaNqJ5VlPftliKI=;
        b=UT1zFWSB/8a1hvGdQWTWn1vteMr6dk2GiubywndLJfutScDJni4yE5HOvEHC1YUMPa
         XOCL8XACp6eBCtMQMzH/AWR2nBJiHiwA7fys5zwFoViTxsP9Syhdo7YeDqa6DqsNS4St
         gDoQTs6EX7ilit3LllSme80dxoU677rSicRAdc65Z9PxIK4cHWxuxkPrF1uXaBBcWfOK
         8Xb9mh0arbZhx9AsCQbAe/GiKEJrOVgVnzekfAbgH0TFNTKkoq3uXd7nDF9iF11Vwqmv
         jExsixD/y2BMLou0YK3skXl9NqrU0CpdiBO9kzvywrVDD0lzzzljdUKxMIytUrCm781D
         vxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjCpzgo0z2DvoSBkodr70hp1a2SwXaNqJ5VlPftliKI=;
        b=aMx1lU6BAwJiyfWgy6HkymhVmVM+EIN2oD5lJaeDQJsZOTVwopmbBmUXk2dacHf0ES
         iyFTMA9ylXZVXrZhgPRAhiE536fOWuW1215AL7GGRIUWtI9AR0k2bZduaVfAnuyA2xMS
         5i6P+ONaq0tvm2EifhmNo3CMPVpVkdgIXCJe1ZU0WKHC2lHZI7CCIcocutLxYVRt7S/N
         qcnA4+qbk4Qn5rAWmR7dE5LkXtzUtdzTJiB1nTPRz6J0bHZQTjFleZeEyKCIG5A0/PaW
         zymBm1J8xp8V/8piIkysGtkHmggYlxisPEDw6HkVa5dqg/HiDrfOpR6Tu+i6Nz79niQ/
         7hnA==
X-Gm-Message-State: AA+aEWZQS+bejVrBDHtBFcFwrCZC0AMQM1zL1cCxGeu3Bc+OV+vnxe94
        GauvbrSHqJZJv2CpA7vHqc5WC0QTO1ZkF+itTe16Pw==
X-Google-Smtp-Source: AFSGD/XaXuY/uEni0ppri4cDLp477pLOE0qdzH7O5Hg92ByaQTb+W2kXcJCXZUo+KyUtddArn9VOEDp2Mkz2VG3T8/8=
X-Received: by 2002:a9d:394:: with SMTP id f20mr3647750otf.98.1545197199005;
 Tue, 18 Dec 2018 21:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20181207191620.GD3293@redhat.com> <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com> <20181212214641.GB29416@dastard>
 <20181214154321.GF8896@quack2.suse.cz> <20181216215819.GC10644@dastard>
 <20181218103306.GC18032@quack2.suse.cz> <20181218234254.GC31274@dastard> <20181219030329.GI21992@ziepe.ca>
In-Reply-To: <20181219030329.GI21992@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 18 Dec 2018 21:26:28 -0800
Message-ID: <CAPcyv4h=j=Kc=uOzdbfoYvmJ54aqSq6tHra2QZQwtpE+80WkVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Jerome Glisse <jglisse@redhat.com>,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 7:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Dec 19, 2018 at 10:42:54AM +1100, Dave Chinner wrote:
>
> > Essentially, what we are talking about is how to handle broken
> > hardware. I say we should just brun it with napalm and thermite
> > (i.e. taint the kernel with "unsupportable hardware") and force
> > wait_for_stable_page() to trigger when there are GUP mappings if
> > the underlying storage doesn't already require it.
>
> If you want to ban O_DIRECT/etc from writing to file backed pages,
> then just do it.
>
> Otherwise I'm not sure demanding some unrealistic HW design is
> reasonable. ie nvme drives are not likely to add page faulting to
> their IO path any time soon.
>
> A SW architecture that relies on page faulting is just not going to
> support real world block IO devices.
>
> GPUs and one RDMA are about the only things that can do this today,
> and they are basically irrelevant to O_DIRECT.

Yes.

I'm missing why a bounce buffer is needed. If writeback hits a
DMA-writable page why can't that path just turn around and trigger
another mkwrite notifcation on behalf of hardware that will never send
it? "Nice try writeback, this page is dirty again".
