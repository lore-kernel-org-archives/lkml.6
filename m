Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADA4C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35C22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LHOK2FHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfARUoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:44:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35594 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfARUoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:44:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so6604781pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GjchyRdYhLAWsw5KQxaMj7ccbSp+3qcEIdr5776TWsc=;
        b=LHOK2FHSeR4niUoa2jt0heKMjyOjyS7diRaX/xa2GWUj32L6oIios6dEsNCgJVaMGq
         98Kk+Ws17asA+dbwF05ch6LxdP2D2dO166edj38RocwjvxhsfVh160XcHfDrQHAS9HS7
         6pA3d1+ZfdxSQ+4GyWQ4UpINnk/Mcy9e+By0qrF+kDX/I0boHWu+NIHg8QE93Wi3PpSa
         uwFXbWWohIL284go/cg/o7RcKPBhcz4ZtMYBDeIKgm/+qm4ui0+wVRZkDUvF0a/85lrE
         EOqLarFcfTtRVyo8gqoa4jsQLA4mvirOyrNH68WeD7qPgkGHMY+B/xH4SSQ6nMMQUo/6
         4+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjchyRdYhLAWsw5KQxaMj7ccbSp+3qcEIdr5776TWsc=;
        b=X6m897A+HB+WKD470FjVk/AkzWrsG0AXPfJDHXk4UtPDZ5/q3R6wyXJ88iIrqOMayw
         Mfbd2jMe+uydKQNwveijdpWbUzlLPrNJprNm1/+9edfOgeYyDOAcx8xEZbjIz/klaScM
         ZuPAx/Ijn2/eyJhj/RFD7fA5HCwGsPlVyQ3H8QNJmrz+5z7ssm8Ep7NlN4yXcYL+pUyu
         ATNt+bE25uGlV4nbBfznAiN3N2zxAaVaJPGZTVE4Ew2yCTAnCCluIFleSw9fRFktwtle
         3Dn+f1AX4tWOkzcIbxnHZV+dvtLmAn9nDAvif/eF6l1ZTuIaGzkywbbAn2jeovVqD/g+
         RznQ==
X-Gm-Message-State: AJcUukfTBGCU6ZnHnbxap+dbMqskYuMk0AkQ4Zi7CZ6Ova+OGiGptl8Y
        NUvFi1gbfVB6+tUg1rggkK4LCA==
X-Google-Smtp-Source: ALg8bN75d2A7vFU5PncOyJAf1X4eKFFRRVfxaiJyiqLoqeCDwgIRUbEIoG0wQZ4t3/b407jH8EBGyA==
X-Received: by 2002:a63:f515:: with SMTP id w21mr19062235pgh.220.1547844258032;
        Fri, 18 Jan 2019 12:44:18 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m3sm12784083pfi.102.2019.01.18.12.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 12:44:17 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gkazw-0002f7-Hn; Fri, 18 Jan 2019 13:44:16 -0700
Date:   Fri, 18 Jan 2019 13:44:16 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups <cgroups@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/core: Simplify rdma cgroup registration
Message-ID: <20190118204416.GA7101@ziepe.ca>
References: <20190117181415.28566-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117181415.28566-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 08:14:15PM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> RDMA cgroup registration routine always returns success,
> so simplify function to be void and run clang formatter
> over whole CONFIG_CGROUP_RDMA art of core_priv.h.
> 
> This reduces unwinding error path for regular registration and
> future net namespace change functionality for rdma device.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/infiniband/core/cgroup.c    |  5 ++---
>  drivers/infiniband/core/core_priv.h | 17 +++++++++++------
>  drivers/infiniband/core/device.c    |  8 +-------
>  include/linux/cgroup_rdma.h         |  2 +-
>  kernel/cgroup/rdma.c                |  5 +----
>  5 files changed, 16 insertions(+), 21 deletions(-)

Applied to for-next

Thanks,
Jason
