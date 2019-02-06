Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6001C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CE5218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VrEBiF/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBFVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:05:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41582 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfBFVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:05:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so14485538otk.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tln1vBiQeKwSmWLEy4Y/wGxdB8A98ek27z5oOhyQLgA=;
        b=VrEBiF/nY0BRkKbELA8YzJ7IN0MCmwGWeP8qEGlxO6zA425I51oG4Sx/5gG8fnO61F
         MyKBWmhcqncgDlOOq+iUihs43ijgFAZqMYYJttETe6AhtQOq+UTWWqBNggUo385bV+9r
         ub9KiMpezLEqr3woQgo9Y09iOoaNs/MaQCy14kWqDTdzxg7zRXMRrtyvVmIs5ERUBuRy
         ZcEaQVS0ymH+Dipc8hCKCOHfeCpGDEq4YdM1p2IZNt3bk0KVtWcwb+X7dUAMrE+sDB+W
         gyowMVU33isZFYYwoJi17/V1JFHCl7yssHiSM0p5Q7/10kTm9kL2vaIvdbTFHosAwCHT
         xBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tln1vBiQeKwSmWLEy4Y/wGxdB8A98ek27z5oOhyQLgA=;
        b=sLY/51dVXG5sZDhpC/imYPyisM6M7nF7F5bkhJ4KDc+vyURqkyeg2y/lloiVf3SOT5
         LyzwH7yJdmfshLI6NVkvGGtCbi6ZXBvAzZCztr6pefymDuh72n3T7uOit4NaAdgkxTno
         pe7/LDE9jzKyjPcH0kUyzCtQ5ykqS+18104gvhKUqZ/I8r2BjJ4txIXbr1WPNu4rtVLY
         M0A1KXjq10nUbNZvjIf0qrTS201G0z+pM4c5H7hANDPeuswyOAbNkxFUXoBv/gTzgzeS
         9DHBAwb8o0zKu2gkwQ6v9d7xO8wwZm1MqJuuDSA2p712D9PMK3X4bXYEvv6VXZEbjqkb
         IThg==
X-Gm-Message-State: AHQUAubXLi380s05qPzzIY4n+Vu37KgkU0UP4EMDZQhX5tCMxpGlrd1R
        WYOWJG0okEQBlyh6M+9awUnQm4ZKfCRzThEeMJeCwQ==
X-Google-Smtp-Source: AHgI3IY5Sf4Cfy+fW6IBS156GRZUo4fehxu0u1cov625T4vkimXmry6pTIglZ0NOmMcIGuv/4D02xrG6vTD+irmRQ+4=
X-Received: by 2002:aca:240a:: with SMTP id n10mr645661oic.73.1549487109886;
 Wed, 06 Feb 2019 13:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <20190206183503.GO21860@bombadil.infradead.org> <20190206185233.GE12227@ziepe.ca>
 <CAPcyv4j4gDNHu836N4RfgQsE+eZU9Wt0N9Y09KQ43zV+4mK-eg@mail.gmail.com> <671e7ebc8e125d1ebd71de9943868183e27f052b.camel@redhat.com>
In-Reply-To: <671e7ebc8e125d1ebd71de9943868183e27f052b.camel@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 13:04:57 -0800
Message-ID: <CAPcyv4id2rzJVUZw98PfJ-k05BvD-opwj0XhOWPKZQicmhXJ=g@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 12:14 PM Doug Ledford <dledford@redhat.com> wrote:
>
> On Wed, 2019-02-06 at 11:45 -0800, Dan Williams wrote:
> > On Wed, Feb 6, 2019 at 10:52 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Wed, Feb 06, 2019 at 10:35:04AM -0800, Matthew Wilcox wrote:
> > >
> > > > > Admittedly, I'm coming in late to this conversation, but did I miss the
> > > > > portion where that alternative was ruled out?
> > > >
> > > > That's my preferred option too, but the preponderance of opinion leans
> > > > towards "We can't give people a way to make files un-truncatable".
> > >
> > > I haven't heard an explanation why blocking ftruncate is worse than
> > > giving people a way to break RDMA using process by calling ftruncate??
> > >
> > > Isn't it exactly the same argument the other way?
> >
> >
> > If the
> > RDMA application doesn't want it to happen, arrange for it by
> > permissions or other coordination to prevent truncation,
>
> I just argued the *exact* same thing, except from the other side: if you
> want a guaranteed ability to truncate, then arrange the perms so the
> RDMA or DAX capable things can't use the file.

That doesn't make sense. All we have to work with is rwx bits. It's
possible to prevents writes / truncates. There's no permission bit for
mmap, O_DIRECT and RDMA mappings, hence leases.

> >  but once the
> > two conflicting / valid requests have arrived at the filesystem try to
> > move the result forward to the user requested state not block and fail
> > indefinitely.
>
> Except this is wrong.  We already have ETXTBSY, and arguably it is much
> easier for ETXTBSY to simply kill all of the running processes with
> extreme prejudice.  But we don't do that.  We block indefinitely.  So,
> no, there is no expectation that things will "move forward to the user
> requested state".  Not when pages are in use by the kernel, and very
> arguably pages being used for direct I/O are absolutely in use by the
> kernel, then truncate blocks.
>
> There is a major case of dissonant cognitive behavior here if the
> syscall supports ETXTBSY, even though the ability to kill apps using the
> text pages is trivial, but thinks supporting EBUSY is out of the
> question.

It's introducing a new failure mode where one did not exist before.
It's especially problematic when the only difference between the case
when it fails and one where it doesn't comes down to the
idiosyncrasies of DAX mappings and whether or not the RDMA device has
capabilities like ODP.
