Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8106AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0CB2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="lUptStrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0CB2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755363AbeFRUEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:04:39 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36057 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754227AbeFRUEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:04:37 -0400
Received: by mail-ot0-f194.google.com with SMTP id c15-v6so19956006otl.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ycvtm2IqbrzlFlVDk0CAc/Jo5GRhSVfrpXFFv/YbED8=;
        b=lUptStrVk9B4FXgZIzMmiGeC1afJzwr6tF1TD2GVOsBiUjB4SXjTjBAKyV26uivhPM
         CVz6RBVii3ASOHW34VcylbpPGoWM9CZ5vt2LUreeXkPDAaKjp8CfRQdl2WiFRB1u6qqc
         rFBelp0h9UI3bkjA2mKpz/6oUIQtQ7jEf74YISE5nyhCplda3Lom964/x7y2XuOvMIqC
         OGxdHJf1F4jNgJ/wt1Ypfu+a3aNw9VD4mr8ny1VB+kwmULyDjN0S57z2Ave3i7+IoTyQ
         zSEEiWl0yW8xuWQJFwxD9KoezqcJ+yslavZM0+R0a5ClaA9VoeZu2Pf96v94W0E7Tigh
         mW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ycvtm2IqbrzlFlVDk0CAc/Jo5GRhSVfrpXFFv/YbED8=;
        b=VUH2fPRh5l69WaAp9R90eGOm0Gb1eV6pAtMw0oaFtwEJ/4Jj0eZbVynPiAgT+Mayyq
         J55gSdXquaUqxHHTwi3/tbdYxv1hiqgpFriOQZkMXWqgxegPs7jrc1wWWZUg/dH9F4Z7
         aR+DO2nX4mTTp7hpr7EDf+07wUCVCnae6S76KmMkVwFjCb/a9FF9gAnLcI1Cq8ta3FIg
         8RK8XWE0nH9/buEQDs7+PZKtkBLt8rlmVlerPVzRSOxKetn1oxRSInSf/qyQ4KCD0o7R
         kWZ/EvoQwOX4GP/quV/64D5XQT1VNGdfEBa0X2vmCTdEXgzgyeuY4DYQDC20QJyjLEjJ
         2FPg==
X-Gm-Message-State: APt69E3+7Pro15C+09Sg7jR3d926+p2aUhFpDqteIV3GoVZc6C96jWbp
        AtQiG3WS3tGhRvt67HNzjkWbvtxxOuVf7hyRmN3ZXg==
X-Google-Smtp-Source: ADUXVKLB/VHpPimb0p7m35ECTXgluou6mvc/xnv8hEJH0Zra5K3xTMl4rsOGUMaAmWv20WADYkkEsjL4jxlDlO3kbPs=
X-Received: by 2002:a9d:7311:: with SMTP id e17-v6mr8239361otk.162.1529352277101;
 Mon, 18 Jun 2018 13:04:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:04:36
 -0700 (PDT)
In-Reply-To: <20180618193158.GE6805@ziepe.ca>
References: <20180617012510.20139-3-jhubbard@nvidia.com> <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca> <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com> <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com> <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com> <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <20180618193158.GE6805@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Jun 2018 13:04:36 -0700
Message-ID: <CAPcyv4jbwtOqG_473SeK12LKghMo6mCDWRuTxqYVP6R-sLhpoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:31 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Mon, Jun 18, 2018 at 12:21:46PM -0700, Dan Williams wrote:
>> On Mon, Jun 18, 2018 at 11:14 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>> > On 06/18/2018 10:56 AM, Dan Williams wrote:
>> >> On Mon, Jun 18, 2018 at 10:50 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>> >>> On 06/18/2018 01:12 AM, Christoph Hellwig wrote:
>> >>>> On Sun, Jun 17, 2018 at 01:28:18PM -0700, John Hubbard wrote:
>> >>>>> Yes. However, my thinking was: get_user_pages() can become a way to indicate that
>> >>>>> these pages are going to be treated specially. In particular, the caller
>> >>>>> does not really want or need to support certain file operations, while the
>> >>>>> page is flagged this way.
>> >>>>>
>> >>>>> If necessary, we could add a new API call.
>> >>>>
>> >>>> That API call is called get_user_pages_longterm.
>> >>>
>> >>> OK...I had the impression that this was just semi-temporary API for dax, but
>> >>> given that it's an exported symbol, I guess it really is here to stay.
>> >>
>> >> The plan is to go back and provide api changes that bypass
>> >> get_user_page_longterm() for RDMA. However, for VFIO and others, it's
>> >> not clear what we could do. In the VFIO case the guest would need to
>> >> be prepared handle the revocation.
>> >
>> > OK, let's see if I understand that plan correctly:
>> >
>> > 1. Change RDMA users (this could be done entirely in the various device drivers'
>> > code, unless I'm overlooking something) to use mmu notifiers, and to do their
>> > DMA to/from non-pinned pages.
>>
>> The problem with this approach is surprising the RDMA drivers with
>> notifications of teardowns. It's the RDMA userspace applications that
>> need the notification, and it likely needs to be explicit opt-in, at
>> least for the non-ODP drivers.
>
> Well, more than that, we have no real plan on how to accomplish this,
> or any idea if it can even really work.. Most userspace give up
> control of the memory lifetime to the remote side of the connection
> and have no way to recover it other than a full teardown.
>
> Given that John is trying to fix a kernel oops, I don't think we
> should tie progress on it to the RDMA notification idea.
>
> .. and given that John is trying to fix a kernel oops, maybe the
> weird/bad/ugly behavior of ftruncte is a better bug to have than for
> unprivileged users to be able to oops the kernel???

Trading one bug for another is not a fix. We did not fix the
DAX-dma-vs-trruncate bug by breaking truncate() guarantees.
