Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA16C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCCF2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="v2SmmsxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbfBKT67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:58:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34539 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfBKT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:58:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id 98so323151oty.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiCrOaqvqc6IXkmSpeBibC6k7Dt5ORUBY+Yth87tg8g=;
        b=v2SmmsxYbVz7eajzqaw1KE0S7eRG0vZw4fSOQMdWssxdYjWlIBUN/cdSMhrRO2Oitk
         ce0cr7TXBTH440tREOOROwN6aGzf0N0dK4YcxZbUDZxm8RsViTMLBKq5smoz1WnY93NS
         oQR4kw6bT14+qy26LgFr1aO0SNt82fha5GlY5Qi3ogUWx/2pP48/typtmKY+rDAX8Lv1
         F+/dJB7h3xKZs31nObrffQ/AvUKRhukK8lsADOxWW1EmvCCpE1S283Z4enFVd2DVpUEb
         Ma0S29ugwJQDvFOs3J8JSPV9d4SwIbvkitbF1yEKwKQi+RsWEbn7PTdayZRFQFB5jyqt
         Sa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiCrOaqvqc6IXkmSpeBibC6k7Dt5ORUBY+Yth87tg8g=;
        b=OiT5i+LkGwGuhC/OE+UEST7m513R+/Tv6HoG1DRNu9CWtj2fOvzshf6F3rVkd6t+YV
         rj3IepEf0G2GyUbGYFrMg9hrspyQarIIZYm6bymzSzZWc19IBOAnIXV/bz8MPWVN68co
         0xQPKiwq9Y9gg1CcEEevP5nWvZvpXSX1ZiC5jPrjZRLcqDFyOVl/Ye6n68Qbsvd3JtsJ
         B+z5dCmReTEatjjjDZuq+Gi6z7nZVbYfFcOJGu0FMOMOHxdcGsTcYa/6N5hiKLEEgp7B
         OK2gpxqB5N1U0QzFP+ZVp5Rdr2Km9h88MmHIEBd3PFZ28MeUg/1prbTTfn3/TaFeJAkb
         u+oA==
X-Gm-Message-State: AHQUAuZAfpWGVAeCh2x8Vzi/0j5F0c3K96jZ63zxLES/V2k1pQLVGYTu
        7YBSkyU/xgdWVUa5FpjCuhP5q/6JLPWty/tJQM/hoQ==
X-Google-Smtp-Source: AHgI3IZz5K9TqTpU5mfrAWqX17LGBxJt/PQR8+mBd04rCm+lHgw/p2iUDBeXhmYO4CyNzWTMaYVOQ2s59VGZwx2eYiI=
X-Received: by 2002:a9d:7493:: with SMTP id t19mr16664268otk.98.1549915138337;
 Mon, 11 Feb 2019 11:58:58 -0800 (PST)
MIME-Version: 1.0
References: <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard> <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz> <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca> <20190211181921.GA5526@iweiny-DESK2.sc.intel.com>
 <20190211182649.GD24692@ziepe.ca> <20190211184040.GF12668@bombadil.infradead.org>
In-Reply-To: <20190211184040.GF12668@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Feb 2019 11:58:47 -0800
Message-ID: <CAPcyv4j71WZiXWjMPtDJidAqQiBcHUbcX=+aw11eEQ5C6sA8hQ@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Ira Weiny <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:40 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 11, 2019 at 11:26:49AM -0700, Jason Gunthorpe wrote:
> > On Mon, Feb 11, 2019 at 10:19:22AM -0800, Ira Weiny wrote:
> > > What if user space then writes to the end of the file with a regular write?
> > > Does that write end up at the point they truncated to or off the end of the
> > > mmaped area (old length)?
> >
> > IIRC it depends how the user does the write..
> >
> > pwrite() with a given offset will write to that offset, re-extending
> > the file if needed
> >
> > A file opened with O_APPEND and a write done with write() should
> > append to the new end
> >
> > A normal file with a normal write should write to the FD's current
> > seek pointer.
> >
> > I'm not sure what happens if you write via mmap/msync.
> >
> > RDMA is similar to pwrite() and mmap.
>
> A pertinent point that you didn't mention is that ftruncate() does not change
> the file offset.  So there's no user-visible change in behaviour.

...but there is. The blocks you thought you freed, especially if the
system was under -ENOSPC pressure, won't actually be free after the
successful ftruncate().
