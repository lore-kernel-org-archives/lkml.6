Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F07C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C24218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KiSEO6jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfBKUrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:47:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41932 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfBKUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:47:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so109554pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=admqwkaG5lh1FTkEW/ac1GyngyGSIJLfPe49QQhkzz4=;
        b=KiSEO6jfK2JelDa6U7k4363ALxDhEZlUnqZvgtQW7SRLQ0XMhao/9CobgakB2ixce+
         YTKZq2kQztlGUmbj7oErod+2ihv08HydvRRbYNTazMqgWC72nH0BokMrdH3BI6YOXrKo
         GjD8tAbPjEjR7IQKdVjaOATb10nU1ec2MP57uoqdSf3E3I0a3Eoyqn7cy8Y3poEQl0FF
         kV9tgQbOhF0KlUNVtT3CmnPXVyxEechT9ybLIX552cHRmlxtwPfIKQHqao+7XSxakuib
         R5H7ZpFt7LTOd64tRxhQHC3qib+V8DFW9IK7fwCAUEo6QIC0jOWuecmUolrvRkfgrg0i
         V94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=admqwkaG5lh1FTkEW/ac1GyngyGSIJLfPe49QQhkzz4=;
        b=eBkTzxRdMoHKdK1yvZBmYLJODv/rZuAY0QTuTXWGK4RQZCLq1X+1K+fJAcdrNNjmst
         r8WcEfPgsoFH3A3z/mIugh0y2hKqPm1fiNTk2CuoCBR25GZ/R4taf452bQCteDOht5Yj
         0HvY1LU7xxvZg0CbYDppnyVQSCtes2dIXRqAbARGhz590rp8P+KhOPq2vaKCJCAZV5RE
         r//KCLlDC/k6QgUJD2bfTPAJ0DN9WmzKoIqU/r/7o4326kBzQL+YMzAgfN+DNgJnc1PZ
         VQ9egCraQJ/6XfBU0ebTIlwfksZiryVIlRw0pSLOcQZ2Gv32Ak9UHdfnRcNHCw04X34/
         p6xA==
X-Gm-Message-State: AHQUAuZjMEBPYLi9qoEIZ8SA7WYO2YSbor28mcWuy4OSrSe+2bY/OpYu
        SJzEgc7yY/jhWEWstjDw0UPU5A==
X-Google-Smtp-Source: AHgI3IbTBLlyiHtm7kKZnIRDGk6I9TyTIGu8eAgsVFw8Xec+BkLFkF9vWnH5PI7IwRFREdlVsHqkew==
X-Received: by 2002:a63:4d:: with SMTP id 74mr147404pga.248.1549918032115;
        Mon, 11 Feb 2019 12:47:12 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id s12sm8407652pfm.120.2019.02.11.12.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:47:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtITu-0000ni-Po; Mon, 11 Feb 2019 13:47:10 -0700
Date:   Mon, 11 Feb 2019 13:47:10 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] Add gup fast + longterm and use it in HFI1
Message-ID: <20190211204710.GE24692@ziepe.ca>
References: <20190211201643.7599-1-ira.weiny@intel.com>
 <20190211203417.a2c2kbmjai43flyz@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211203417.a2c2kbmjai43flyz@linux-r8p5>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:34:17PM -0800, Davidlohr Bueso wrote:
> On Mon, 11 Feb 2019, ira.weiny@intel.com wrote:
> > Ira Weiny (3):
> >  mm/gup: Change "write" parameter to flags
> >  mm/gup: Introduce get_user_pages_fast_longterm()
> >  IB/HFI1: Use new get_user_pages_fast_longterm()
> 
> Out of curiosity, are you planning on having all rdma drivers
> use get_user_pages_fast_longterm()? Ie:
> 
> hw/mthca/mthca_memfree.c:       ret = get_user_pages_fast(uaddr & PAGE_MASK, 1, FOLL_WRITE, pages);

This one is certainly a mistake - this should be done with a umem.

Jason
