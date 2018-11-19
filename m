Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEEEC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8FD2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LvzdXXuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8FD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbeKTFwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:52:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34687 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeKTFwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:52:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so15059086plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ffcji7ue/Hp1t56ByEEtf4/Un+Z9yLMJa/K23r0V5M=;
        b=LvzdXXuvmL5fUmhM6yyZTTPALf1vCGtJyXmdhJbPk97i+ZlbeVUy4iOYXXDO9SwHy9
         Gw9yV8Ami4AygT5rxImw7SGSBhVb1kmXEkZE75WtQvP8v45zqhFLk6Dmv/DHZ7VVSNId
         TMjoxv2yPIluRAHcA8O+Kws0RqNUUWxwFTvf8Ktqo0xGA2VrqeuBUxab3u3OY0037KZ2
         cKOG6Lne6BRXkd/b2pz6XjeHW+yKdfOIeD7yPYGdf/mKmfj6/JTlAKwqKIoKL80YWIg7
         liIhF9q5yAI9s8gP0hWHOBGFu7h2F9+KWkaDg7/i6agn0Gsk8lvChlcpoxRCDO9YJty/
         Y10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ffcji7ue/Hp1t56ByEEtf4/Un+Z9yLMJa/K23r0V5M=;
        b=WuoHOiWbmk3wQ9ZIB7AfGp8Xo52yIP5Cgzsv/Lc7gTRP7e388YzlAbVyZsv1CGrHfm
         PAkgmIfxscz92hqMRN541GrqpKr7Mw5q32l8JgXytu6Zeup43+FMD2PRn1UmU0JHtsUJ
         /zL44PFXNXRGdmAbLKWuVzLUvrLe8/Pbqk0Ds+NQQLIwm50pzVsRooY5WFK2fyW4TcF5
         oOMfvN4RpIq7z3Hg9xd8mqT6Tv6Nr3jZaotZi50xU7dDML5fJVJpkeT0rseF8tUc4HJt
         kgDPcaTD/dUUOZA2rq5FcNmSqSXvhqFVt4p4LPEmCUjN1o+e9efSHvUeQR4GBRuaxsQr
         9gQw==
X-Gm-Message-State: AGRZ1gLokXM8et4AyYO2cYN9PQKmtIQvBycWALaDN9wGO9IS9as6lx+E
        2U61AJ24UxWCDgxVRkxazNKTTw==
X-Google-Smtp-Source: AJdET5c0wjw3sPz8jZzUPLW05tqalhB+6eLU29AwDwGwpTyAb6ax81a2k5dus3poWvEbdFey23xV9Q==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr19521515plq.84.1542655624079;
        Mon, 19 Nov 2018 11:27:04 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id w5sm9126864pfn.89.2018.11.19.11.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 11:27:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOpCI-0005Wy-63; Mon, 19 Nov 2018 12:27:02 -0700
Date:   Mon, 19 Nov 2018 12:27:02 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Zaibo Xu <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com,
        linuxarm@huawei.com, haojian.zhuang@linaro.org,
        Christoph Lameter <cl@linux.com>,
        Hao Fang <fanghao11@huawei.com>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Kershner <david.kershner@unisys.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, guodong.xu@linaro.org,
        linux-netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-crypto@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
Message-ID: <20181119192702.GD4890@ziepe.ca>
References: <20181115085109.GD157308@Turing-Arch-b>
 <20181115145455.GN3759@mtr-leonro.mtl.com>
 <20181119091405.GE157308@Turing-Arch-b>
 <20181119091910.GF157308@Turing-Arch-b>
 <20181119104801.GF8268@mtr-leonro.mtl.com>
 <20181119164853.GA4593@redhat.com>
 <20181119182752.GA4890@ziepe.ca>
 <20181119184215.GB4593@redhat.com>
 <20181119185333.GC4890@ziepe.ca>
 <20181119191721.GC4593@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119191721.GC4593@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:17:21PM -0500, Jerome Glisse wrote:
> On Mon, Nov 19, 2018 at 11:53:33AM -0700, Jason Gunthorpe wrote:
> > On Mon, Nov 19, 2018 at 01:42:16PM -0500, Jerome Glisse wrote:
> > > On Mon, Nov 19, 2018 at 11:27:52AM -0700, Jason Gunthorpe wrote:
> > > > On Mon, Nov 19, 2018 at 11:48:54AM -0500, Jerome Glisse wrote:
> > > > 
> > > > > Just to comment on this, any infiniband driver which use umem and do
> > > > > not have ODP (here ODP for me means listening to mmu notifier so all
> > > > > infiniband driver except mlx5) will be affected by same issue AFAICT.
> > > > > 
> > > > > AFAICT there is no special thing happening after fork() inside any of
> > > > > those driver. So if parent create a umem mr before fork() and program
> > > > > hardware with it then after fork() the parent might start using new
> > > > > page for the umem range while the old memory is use by the child. The
> > > > > reverse is also true (parent using old memory and child new memory)
> > > > > bottom line you can not predict which memory the child or the parent
> > > > > will use for the range after fork().
> > > > > 
> > > > > So no matter what you consider the child or the parent, what the hw
> > > > > will use for the mr is unlikely to match what the CPU use for the
> > > > > same virtual address. In other word:
> > > > > 
> > > > > Before fork:
> > > > >     CPU parent: virtual addr ptr1 -> physical address = 0xCAFE
> > > > >     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE
> > > > > 
> > > > > Case 1:
> > > > >     CPU parent: virtual addr ptr1 -> physical address = 0xCAFE
> > > > >     CPU child:  virtual addr ptr1 -> physical address = 0xDEAD
> > > > >     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE
> > > > > 
> > > > > Case 2:
> > > > >     CPU parent: virtual addr ptr1 -> physical address = 0xBEEF
> > > > >     CPU child:  virtual addr ptr1 -> physical address = 0xCAFE
> > > > >     HARDWARE:   virtual addr ptr1 -> physical address = 0xCAFE
> > > > 
> > > > IIRC this is solved in IB by automatically calling
> > > > madvise(MADV_DONTFORK) before creating the MR.
> > > > 
> > > > MADV_DONTFORK
> > > >   .. This is useful to prevent copy-on-write semantics from changing the
> > > >   physical location of a page if the parent writes to it after a
> > > >   fork(2) ..
> > > 
> > > This would work around the issue but this is not transparent ie
> > > range marked with DONTFORK no longer behave as expected from the
> > > application point of view.
> > 
> > Do you know what the difference is? The man page really gives no
> > hint..
> > 
> > Does it sometimes unmap the pages during fork?
> 
> It is handled in kernel/fork.c look for DONTCOPY, basicaly it just
> leave empty page table in the child process so child will have to
> fault in new page. This also means that child will get 0 as initial
> value for all memory address under DONTCOPY/DONTFORK which breaks
> application expectation of what fork() do.

Hum, I wonder why this API was selected then..

> > I actually wonder if the kernel is a bit broken here, we have the same
> > problem with O_DIRECT and other stuff, right?
> 
> No it is not, O_DIRECT is fine. The only corner case i can think
> of with O_DIRECT is one thread launching an O_DIRECT that write
> to private anonymous memory (other O_DIRECT case do not matter)
> while another thread call fork() then what the child get can be
> undefined ie either it get the data before the O_DIRECT finish
> or it gets the result of the O_DIRECT. But this is realy what
> you should expect when doing such thing without synchronization.
> 
> So O_DIRECT is fine.

?? How can O_DIRECT be fine but RDMA not? They use exactly the same
get_user_pages flow, right? Can we do what O_DIRECT does in RDMA and
be fine too?

AFAIK the only difference is the length of the race window. You'd have
to fork and fault during the shorter time O_DIRECT has get_user_pages
open.

> > Really, if I have a get_user_pages FOLL_WRITE on a page and we fork,
> > then shouldn't the COW immediately be broken during the fork?
> > 
> > The kernel can't guarentee that an ongoing DMA will not write to those
> > pages, and it breaks the fork semantic to write to both processes.
> 
> Fixing that would incur a high cost: need to grow struct page, need
> to copy potentialy gigabyte of memory during fork() ... this would be
> a serious performance regression for many folks just to work around an
> abuse of device driver. So i don't think anything on that front would
> be welcome.

Why? Keep track in each mm if there are any active get_user_pages
FOLL_WRITE pages in the mm, if yes then sweep the VMAs and fix the
issue for the FOLL_WRITE pages.

John is already working on being able to detect pages under GUP, so it
seems like a small step..

Since nearly all cases of fork don't have a GUP FOLL_WRITE active
there would be no performance hit.

> umem without proper ODP and VFIO are the only bad user i know of (for
> VFIO you can argue that it is part of the API contract and thus that
> it is not an abuse but it is not spell out loud in documentation). I
> have been trying to push back on any people trying to push thing that
> would make the same mistake or at least making sure they understand
> what is happening.

It is something we have to live with and support for the foreseeable
future.

> What really need to happen is people fixing their hardware and do the
> right thing (good software engineer versus evil hardware engineer ;))

Even ODP is no pancea, there are performance problems. What we really
need is CAPI like stuff, so you will tell Intel to redesign the CPU??
:)

Jason
