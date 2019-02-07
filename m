Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B664C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03E32173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f+z/qYP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGR0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:26:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44494 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGR0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:26:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so218637pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZU6LvkaN2jhCFSZgIMgr5MnScYaXECe3XEiWuxzLMs=;
        b=f+z/qYP9N5eaLh+NtbAraU7ZdjWZ0fB9Nzko1J1OmZEZs6YBM0Ju6sCeAdaQ/S8xX+
         +dBlR0k5ymDXQOLJI3gZf0KA7i1Mr2rGj8G+FHl/556LaWylKN6nOnvF2ykEVGb/HLct
         FUJzV+UfUnmzGhcX6gd58Wcv/a+wanY1UfAgvSo90KcUWga6TpNrD877sQ/IfzPELco7
         Ypn8GPPRUE6rxfRjmbuHRW7NqrCR8UFnbowCsXW4NGu5RfyktcjXbs6OGEeScgrOscYS
         cPyiMhashnNjp/FUWKi1zMsXPcK2T96DIZyIswM27F/SQQWVrQOReIfX36euoDgDRSAD
         6IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZU6LvkaN2jhCFSZgIMgr5MnScYaXECe3XEiWuxzLMs=;
        b=SM//d6VIESipbbTZjJRtdelABFp0x19abGoBwuYcRVPyiW2KCU3FFv8KL8U6xFHzmw
         Q3RyuIxINobI+L+Vjd1Z+Jtivv5BP9GaQDV74z93F2qoVgDpiUM8FMlYtf6bLjHS9t/j
         Ild/gFGMO1a1TlKLH6rWtbIPGiLjwUdZZt8+7j4ctFqvm1E3HK9viUyqmdQc+sj4ji/0
         9UREObinvaY/FzKPqkZx6N9cY0+nxZDt4o34yrJZPn3lNYJZ29ZD1d/BG4mSV1y1z8Fv
         Kp/avBOb91SwJyZK90eyGFm1zow5jvkcChDjo3ZkoYzq9fLf7MTS/pjrU0DUQFfe3CwX
         1Gvw==
X-Gm-Message-State: AHQUAub8PUg8XdtrSwoXRFTGL7z+zIwf09GaYRmOS2ydZ/Z/HKV+9UkJ
        CxZ8APswyt+y57RZ4ClF46V35Q==
X-Google-Smtp-Source: AHgI3IZCSHH2roxErEcrj1a3hl5oVQyNWv7+FysWSWfK6w7as45SE1HFpz9K7/grMKXoyXDTuN5fDw==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr17130708pfe.152.1549560383655;
        Thu, 07 Feb 2019 09:26:23 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 15sm16445723pfs.113.2019.02.07.09.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 09:26:23 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1grnRO-0001pT-Gm; Thu, 07 Feb 2019 10:26:22 -0700
Date:   Thu, 7 Feb 2019 10:26:22 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190207172622.GF22726@ziepe.ca>
References: <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard>
 <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <20190207172405.GY21860@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207172405.GY21860@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:24:05AM -0800, Matthew Wilcox wrote:
> On Thu, Feb 07, 2019 at 11:25:35AM -0500, Doug Ledford wrote:
> > * Really though, as I said in my email to Tom Talpey, this entire
> > situation is simply screaming that we are doing DAX networking wrong. 
> > We shouldn't be writing the networking code once in every single
> > application that wants to do this.  If we had a memory segment that we
> > shared from server to client(s), and in that memory segment we
> > implemented a clustered filesystem, then applications would simply mmap
> > local files and be done with it.  If the file needed to move, the kernel
> > would update the mmap in the application, done.  If you ask me, it is
> > the attempt to do this the wrong way that is resulting in all this
> > heartache.  That said, for today, my recommendation would be to require
> > ODP hardware for XFS filesystem with the DAX option, but allow ext2
> > filesystems to mount DAX filesystems on non-ODP hardware, and go in and
> > modify the ext2 filesystem so that on DAX mounts, it disables hole punch
> > and ftrunctate any time they would result in the forced removal of an
> > established mmap.
> 
> I agree that something's wrong, but I think the fundamental problem is
> that there's no concept in RDMA of having an STag for storage rather
> than for memory.
> 
> Imagine if we could associate an STag with a file descriptor on the
> server.  The client could then perform an RDMA to that STag.  On the
> server, we'd need lots of smarts in the card and in the OS to know how
> to treat that packet on arrival -- depending on what the file descriptor
> referred to, it might only have to write into the page cache, or it
> might set up an NVMe DMA, or it might resolve the underlying physical
> address and DMA directly to an NV-DIMM.

I think you just described ODP MRs.

Jason
