Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27152C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD051206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X4y+1Y0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfBVSSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:18:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35173 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfBVSSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:18:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id p19so1456997plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XvH0hKFiegkEa7My+HGrtE9xRd3iiV+9MpkunJwzduI=;
        b=X4y+1Y0HlLzaRqcwDnW/IgGWlWm5BThIee+t1Gqp5wKrGe1DsOeYbuLc3UBNbNB2JY
         9eRB6pnoCwQ6y7qU9bV/qCeSoS7MWHFYXETUkqeVQSYE2hgCX5xCSN3rrvj+WZyWybLh
         dJIup3Q1lY5Lb9QZqXrjdEkDFzAHDjbtuxp2gHOj8S9Jpi+CQuLUxuECK8i+EiyZj0QY
         n1aH1bnDPG4LjRb33iFlgBfY09e/Lu8IQFT/EsGrbdz31mfxAQfIPIXqgl/5yQ9Owjyi
         yGt8T2+aISUB/PQKQEPSBn2y1OWDqA1CVhbnHoEZ3ufyDQIlsJzXa+VLL6imB+hbfsqL
         IZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XvH0hKFiegkEa7My+HGrtE9xRd3iiV+9MpkunJwzduI=;
        b=VbzKThyy5tRm35VNYPuHobWRa+EECV8R7/drCliyTRg2zSNyxPR34T12MUo1whWefK
         NyV+u7fOhu3R5aJJ1NkZ8dRL+7v4AmpDUmCx9wZs3lFTaNmHMH3o+h9ECE+xtCYW2+nC
         KjnNQ0pwSrjshCqEaJzLaQ22T1eAqF48maO4amhS/IUZQjhiLhtm0BSwzdAOJhnnfdb6
         t8Z77a5O9YpJLIQKWicUGDQWEEYnPVhC1ZrU5c79wJWphFjNSM3jOeymovi0f0DUyzQ7
         UAh09ovpixsuCyiYh4nVW+IxF5ImVUHCNP556A6tTUSE5DY/hY4PAS3ipzMVSadtL1j6
         zebA==
X-Gm-Message-State: AHQUAuYNfL0Ad1Y8H43lRtr+pZDdnXo/pabPJOBTf8TZbpYQYnLKvKac
        rFpuHhomcUiU1ySdEFaXnGw7jg==
X-Google-Smtp-Source: AHgI3IZzr6MtuSiojjcfYX5L5bAPDF/ZcD+hoxNOvaAeNpLQJRhDjhdxT3eh2iuZp0V1EOstkoUh1Q==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr5348763plh.99.1550859482188;
        Fri, 22 Feb 2019 10:18:02 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id n74sm3769900pfb.188.2019.02.22.10.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:18:01 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gxFOa-0002U2-Qa; Fri, 22 Feb 2019 11:18:00 -0700
Date:   Fri, 22 Feb 2019 11:18:00 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, jackm@dev.mellanox.co.il,
        majd@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] IB/mlx4: Increase the timeout for CM cache
Message-ID: <20190222181800.GA9524@ziepe.ca>
References: <20190217144512.1171546-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190217144512.1171546-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 03:45:12PM +0100, Håkon Bugge wrote:
> Using CX-3 virtual functions, either from a bare-metal machine or
> pass-through from a VM, MAD packets are proxied through the PF driver.
> 
> Since the VF drivers have separate name spaces for MAD Transaction Ids
> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> in a cache.
> 
> Following the RDMA Connection Manager (CM) protocol, it is clear when
> an entry has to evicted form the cache. But life is not perfect,
> remote peers may die or be rebooted. Hence, it's a timeout to wipe out
> a cache entry, when the PF driver assumes the remote peer has gone.
> 
> During workloads where a high number of QPs are destroyed concurrently,
> excessive amount of CM DREQ retries has been observed
> 
> The problem can be demonstrated in a bare-metal environment, where two
> nodes have instantiated 8 VFs each. This using dual ported HCAs, so we
> have 16 vPorts per physical server.
> 
> 64 processes are associated with each vPort and creates and destroys
> one QP for each of the remote 64 processes. That is, 1024 QPs per
> vPort, all in all 16K QPs. The QPs are created/destroyed using the
> CM.
> 
> When tearing down these 16K QPs, excessive CM DREQ retries (and
> duplicates) are observed. With some cat/paste/awk wizardry on the
> infiniband_cm sysfs, we observe as sum of the 16 vPorts on one of the
> nodes:
> 
> cm_rx_duplicates:
>       dreq  2102
> cm_rx_msgs:
>       drep  1989
>       dreq  6195
>        rep  3968
>        req  4224
>        rtu  4224
> cm_tx_msgs:
>       drep  4093
>       dreq 27568
>        rep  4224
>        req  3968
>        rtu  3968
> cm_tx_retries:
>       dreq 23469
> 
> Note that the active/passive side is equally distributed between the
> two nodes.
> 
> Enabling pr_debug in cm.c gives tons of:
> 
> [171778.814239] <mlx4_ib> mlx4_ib_multiplex_cm_handler: id{slave:
> 1,sl_cm_id: 0xd393089f} is NULL!
> 
> By increasing the CM_CLEANUP_CACHE_TIMEOUT from 5 to 30 seconds, the
> tear-down phase of the application is reduced from approximately 90 to
> 50 seconds. Retries/duplicates are also significantly reduced:
> 
> cm_rx_duplicates:
>       dreq  2460
> []
> cm_tx_retries:
>       dreq  3010
>        req    47
> 
> Increasing the timeout further didn't help, as these duplicates and
> retries stems from a too short CMA timeout, which was 20 (~4 seconds)
> on the systems. By increasing the CMA timeout to 22 (~17 seconds), the
> numbers fell down to about 10 for both of them.
> 
> Adjustment of the CMA timeout is not part of this commit.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Acked-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> ---

Applied to for-next

Thanks,
Jason
