Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC17C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAE320837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUKlyr4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAE320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIAUbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 16:31:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46398 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeIAUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 16:31:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so12292749ljj.13;
        Sat, 01 Sep 2018 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RNNvbSLP+hmUmA/0WWWoUXUBQGPIV70EAOZPA66ceyY=;
        b=TUKlyr4Ey0yDkLoUvP7GerMXI7SzSFQoxgbSvUGP0Kjx+rv7AaLebBNm360P0Fo7yG
         5c+lwUOlO8p4W/99lzIyIOAa3e46bz7VFJTSu1SeOLXGqEEEP2Xx2bXYfynen/YHesCo
         ADWP25AS3BFlsmSn8bkU1fXxeP+4ekqOHDqRrMXsX0EzIWZwbmcZZE8rT2LTjcVnb0gM
         NTlakphpEMmqyb6sso8+Bm+Scxm6vosRtApRmPy0EmsUXBpkyfoC3aRfi7um4LFDS2Kk
         VNU9hW1Ftv0BF4Lwi3KYcgkgRyRmhMEPBI/x8yDmNI5zsGXtjYZVw0GjMmZaF68S6QDa
         1qaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RNNvbSLP+hmUmA/0WWWoUXUBQGPIV70EAOZPA66ceyY=;
        b=gHGF0uKk6X8pOQxdKN1ltsc7AzuJhsv7zG+ZffvymF54NnvqUaZu7otdwbYDygREF7
         8N9NHUBHWhK7tgFT0QZqZulUz2sA3emLxYNhGOwbSGXVoy6YMlvd4O4/OHbzGZQ0WW/b
         Vzd51dzRD1dOtAlTZw1/GNe9M8gUvXuXovdvYsWtixL1HaXcl8a3M73BIkKbmvr5vg/f
         SM62wdzLUxkRQU5tTLpgQa03V1a/nBwGVdscs0GKGvTvMwgEsSVQfvWv9dkePyTy4PIp
         jvszIfuyCrJoV5YmV+lw/xb0ZQ740IK+acJysySWiXeUthC0Bg2MLthF7gTKw2kmVlH1
         u9tA==
X-Gm-Message-State: APzg51D+AMz3JF7FiHKf8YDYbm6QxNAKxHPIhySaw4csEwx014SSyzpW
        YINx12bgSmZ+cirS57HAwpEbem1fDZmdRiBSJDM=
X-Google-Smtp-Source: ANB0VdanzIE4t0fD7tr/2pUYi9Y4q+332MRag2QGsz8hHxUyjJGYOxSVdtdugf4FTllEUB/jcAmiF018g+WF0da5tdE=
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr12956887ljb.86.1535818717857;
 Sat, 01 Sep 2018 09:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
 <20180830163521.728f3ff2fd3cc93b52a5dcc0@linux-foundation.org> <20180831165844.GB3303@thunk.org>
In-Reply-To: <20180831165844.GB3303@thunk.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 1 Sep 2018 21:51:28 +0530
Message-ID: <CAFqt6zY=-fEDR606Ae-Opg3Dn+jyZ9NdAKAshuF0PmmgimhHRQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Al Viro <viro@zeniv.linux.org.uk>, adilger.kernel@dilger.ca,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, the fact that the patch series involves multiple file system is
> a massive pain.  It means I'm going to have to do a separate
> regression test --- or preferably, I would ask *you* to run a file
> system regression test[1] --- to make sure what is *not* a trivial
> patch doesn't break things.  Also, it means that this patch series is
> going to get more complicated to get into kernel, and we may have to
> deal with patch conflicts if this goes in via some third party tree
> (such as Andrew's tree).
>
> [1] https:/thunk.org/gce-xfstests

Sure, I will run the regression.

>
> One way to make life easier is to add the new function with the new
> interface first, and then wait a release cycle, and then move file
> systems over in independant patches.

In last review, you left it to me either to add new function or modify the
input parameters of block_page_mkwrite() to return err to caller.
As block_page_mkwrite() is getting called from 2 places in ext4 & nilfs,
I choose to add new input argument in block_page_mkwrite() rather than
introducing new function and put everything in a single commit.
