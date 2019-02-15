Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BCD222DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aC851/E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbfBOWAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:00:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34108 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbfBOWAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:00:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so5594154plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsHka/kK1Hc1xjCHVh5Lpzl6dCeI0g7HTo9LL4LV7v8=;
        b=aC851/E4mady6LQaldgvGYPai38QXy26mlgQMnBDqRtYx4sMmjhU5EAJdHh23umudw
         l3OCVLiijDnfppfLru7s5ESK6O1Jmtm19v4EOlfVj2MaC9u5cJk/EKoiGKGRGER5x4AN
         NUmhLgBvYNvr4wTZgHB/+BkA23fV6GuUXhUN/BzoWh1+uwwv81E5u/73Oqnlr92C5ELJ
         JGWhpsAOmFAX6W+6bhZzMuMiSk5VUydE9KKArkm83h9nKv4Rto7UdLmGyPkjwLi8Bq1F
         t4dM93ZaiTH3XY9Hk+Ew8j+TxpsDLeM4R4GZy4Yo9leexXMkv6gZBrLOZFeyoT8sFbd5
         7zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsHka/kK1Hc1xjCHVh5Lpzl6dCeI0g7HTo9LL4LV7v8=;
        b=l/FqVGzuDZ8J4lRyDyu0AjHbI8+Z76CYjQu7aR0ndkCfzEPsmigr3o0ku/UTYmSY1v
         tx+5rwGy280+lSYye04shyK16g83jHdVvNzSGOu9ZqXKPTLa8dik/BlY08AX6Nuneygp
         8csYQI7+/X4ay75a35Wxs/1SrHLZtme6M5LfG4MDQu9Fl5bG9/jXNzYaiipKBdsdToQt
         YCGsk3bnxruJnUlLVGCUGvsB3PcPCoYsLCJ58r0JscVX/3G/SB6XKmf85lHJzXR99R15
         wDEJoQ+77mb5j+EiQTIi8OmQ3F/jSGI9mrd4VRmomt+S0yNuN3hxqD4QgyABn546eb+/
         TfLg==
X-Gm-Message-State: AHQUAuZIKeYRHq9QfMonQbZ3FhlQVEuo9k1X2AubU3Xd5pJXeFhnOOXt
        23f0o37ytEp6cfR48ZYrO+dL/Q==
X-Google-Smtp-Source: AHgI3IZdk55m0XUf5MkveAV8ukx2l8BlNFGqlus+3mIgurgngv1IVfVo9qirGnqTm6hZAZJmXRoUYw==
X-Received: by 2002:a17:902:1022:: with SMTP id b31mr12244861pla.141.1550268032901;
        Fri, 15 Feb 2019 14:00:32 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g10sm7663129pgo.64.2019.02.15.14.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 14:00:32 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gulX5-0001Sw-ML; Fri, 15 Feb 2019 15:00:31 -0700
Date:   Fri, 15 Feb 2019 15:00:31 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christopher Lameter <cl@linux.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190215220031.GB8001@ziepe.ca>
References: <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
 <20190214202622.GB3420@redhat.com>
 <20190214205049.GC12668@bombadil.infradead.org>
 <20190214213922.GD3420@redhat.com>
 <20190215011921.GS20493@dastard>
 <01000168f1d25e3a-2857236c-a7cc-44b8-a5f3-f51c2cfe6ce4-000000@email.amazonses.com>
 <20190215180852.GJ12668@bombadil.infradead.org>
 <01000168f26d9e0c-aef3255a-5059-4657-b241-dae66663bbea-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01000168f26d9e0c-aef3255a-5059-4657-b241-dae66663bbea-000000@email.amazonses.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 06:31:36PM +0000, Christopher Lameter wrote:
> On Fri, 15 Feb 2019, Matthew Wilcox wrote:
> 
> > > Since RDMA is something similar: Can we say that a file that is used for
> > > RDMA should not use the page cache?
> >
> > That makes no sense.  The page cache is the standard synchronisation point
> > for filesystems and processes.  The only problems come in for the things
> > which bypass the page cache like O_DIRECT and DAX.
> 
> It makes a lot of sense since the filesystems play COW etc games with the
> pages and RDMA is very much like O_DIRECT in that the pages are modified
> directly under I/O. It also bypasses the page cache in case you have
> not noticed yet.

It is quite different, O_DIRECT modifies the physical blocks on the
storage, bypassing the memory copy. RDMA modifies the memory copy.

pages are necessary to do RDMA, and those pages have to be flushed to
disk.. So I'm not seeing how it can be disconnected from the page
cache?

Jason
