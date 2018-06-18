Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D72C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507F120852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IFBx3tTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507F120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935638AbeFRR47 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:56:59 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43117 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935544AbeFRR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:56:58 -0400
Received: by mail-ot0-f195.google.com with SMTP id i19-v6so19477518otk.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rph5+Y+F6PdZUwPl1lor6KUCFbf01GvttqiPpMA/WZ8=;
        b=IFBx3tTR05nB1YuWfM6iDxmNRxKMum3ra/5uv4NmTLRTnFPoxbbNdaZ77/mxD9iZPj
         CoLZiOCBOxiidEOKzyjo1TIXbE3FO2yNI2Gl1QgKITEkr+zU3i0Yki0OC6Ro0iAW0upe
         vGHwCDgPsn3R6fwXlw8qxAzGCJj82tLTzO6/ouHgL3PG2uwVzPGMCpSCQWNrMSzdxl7r
         C/huTBcr2T2KjdiJpsbOf91jIhbqvctclsnHwbA3kFnZULYtOXsyVSsYOBqd9NgrNyk1
         o+0mR79I17KAq6wIYp1QBw+4UUOMyYdn7FvZHd4PrTWt3cn8qbkDqQBT0oV05eQ4Uel/
         9QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rph5+Y+F6PdZUwPl1lor6KUCFbf01GvttqiPpMA/WZ8=;
        b=aowx8XIgTHtewdzJR4F92BhCepSGxkoERwKXaKfCOivUCb1eu11qrA/nBd8d33wfIu
         0tQgblK4msMgq9YXrKSEOCatKSISZ+IUGOgu+iA6WgQMYcFHJeYXa5Aqy+5EbcNlcVSe
         B9wtxcuduAt8lUQqj+kVkPlODlyb/dwjyRW+MoMGT59+FkfYM86R7q4Rqmnjv6DRZOlT
         BJ7mmgZVGlHGC+GmgpTNX5k9ehoJnPOE3qp0ZdpdwD94CunfBGmEAq643goTkdRjALNm
         Nr//7v5QbuF1lCfixzUNqS14HZntK6g9hgGcp7BYLaiiKwxFPsdN85d75UkRyZy5Gr5Z
         Ue5g==
X-Gm-Message-State: APt69E2GcPRTdVK/Ww+jd/tgTL071pyLe9mx8Uub6E/F1+ZVh4sX7mn0
        ZI8yNCi/2J8jP+XGXyRwaddyCGFGgH8ky56ApFjz9g==
X-Google-Smtp-Source: ADUXVKIrSDhbS60y84JUSUka8zmq2rpN3KTFDS/p5k24ZgCguA6NFGZZ+KzBhA181B4wy6hY5JJ6PwDcrO6WS4JAxLo=
X-Received: by 2002:a9d:1076:: with SMTP id o51-v6mr7940584oto.292.1529344617722;
 Mon, 18 Jun 2018 10:56:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 10:56:57
 -0700 (PDT)
In-Reply-To: <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
References: <20180617012510.20139-1-jhubbard@nvidia.com> <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca> <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com> <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Jun 2018 10:56:57 -0700
Message-ID: <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
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

On Mon, Jun 18, 2018 at 10:50 AM, John Hubbard <jhubbard@nvidia.com> wrote:
> On 06/18/2018 01:12 AM, Christoph Hellwig wrote:
>> On Sun, Jun 17, 2018 at 01:28:18PM -0700, John Hubbard wrote:
>>> Yes. However, my thinking was: get_user_pages() can become a way to indicate that
>>> these pages are going to be treated specially. In particular, the caller
>>> does not really want or need to support certain file operations, while the
>>> page is flagged this way.
>>>
>>> If necessary, we could add a new API call.
>>
>> That API call is called get_user_pages_longterm.
>
> OK...I had the impression that this was just semi-temporary API for dax, but
> given that it's an exported symbol, I guess it really is here to stay.

The plan is to go back and provide api changes that bypass
get_user_page_longterm() for RDMA. However, for VFIO and others, it's
not clear what we could do. In the VFIO case the guest would need to
be prepared handle the revocation.
