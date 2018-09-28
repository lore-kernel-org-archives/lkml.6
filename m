Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28875C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CCE20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eS/Nkquo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CCE20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeI1WjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:39:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33314 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1WjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:39:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so4833669pge.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yJE5Ja5b2motHavY8mzCUnPnLz2FrTaFRT2dVaQHB6I=;
        b=eS/Nkquo4CORFfa0uS22MOPhdZDy/dg9ORAZDcfZkgWrBEkEsKVhif4rSm8TVHSRIb
         7Z+UAPu6J/EcNPHb7oXPrQU7NQVDDGs4F59iC0tJ/GFS1HmqxYNxxEWCCGk5RsiVEYb3
         bIyOUukPOv8gEevyIihA5aGoRtfYowcIO5M3wuv5jBFsHIdgwSeE6C8d0x+zGnJDJmzH
         gfUjXfpnIiQgvQg1BhJlfwDK6QkdZMyzQ3gp6DGrWZzPeKjZkyJMOvLaHE3cdn3nzbmk
         dOLqTlJekfUPy/avcLuail/wqOGS4XSzeWVsEIdmgxgVD9A7Mg3YMMsKmXnBq0vW/yTh
         jOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yJE5Ja5b2motHavY8mzCUnPnLz2FrTaFRT2dVaQHB6I=;
        b=r803f7i9fe49T9i120F27c4K1mRte6mBr00X08ufIWwf6amy99faP8SKwOpiVQxrPY
         wB2QI2eCHubr0I1gMPcSnIpdOI/q9LacWcEtjALD2ctH+T+PTVNF93pOS29lsTVEl/CK
         BEBjCf0Bvjm7PIwPOAmvhnqmUXrdFRKzqQgweUU9lf/p0i0CW0c/+B2ChbA02yBg8/ND
         +QPt6L5WPIhv7NLxiIGvbrW8udXVtONEl7N3Cf9W/9NkM6z3muh+rBLKXQ2G1eLBQkWB
         HePmI0W9ZOPXGZWz6PECyRAFjYrOlhVFhWfCIAptubBgdN0nEazT0+YrdUXP3t0Yyo8E
         PfaQ==
X-Gm-Message-State: ABuFfojV3LAFUSXvJgZRDHsKUDvmjrYIuMnTUjhKp9DJDqnq3QyxNP8z
        PlxoepVrKWqTrCKiHADPdgOFrg==
X-Google-Smtp-Source: ACcGV63IKv7ygYkkWszugak9p0lPHZSK83xEOE+dwbidKScaQ6CoP8X5cR8NTUk6ZTL3T25W1rCkvA==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr2383657pgq.421.1538151274932;
        Fri, 28 Sep 2018 09:14:34 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u77-v6sm11841710pfj.40.2018.09.28.09.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 09:14:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5vPV-0006Oa-KT; Fri, 28 Sep 2018 10:14:33 -0600
Date:   Fri, 28 Sep 2018 10:14:33 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] RDMA/qedr: Remove enumerated type qed_roce_ll2_tx_dest
Message-ID: <20180928161433.GC24524@ziepe.ca>
References: <20180927011820.13608-1-natechancellor@gmail.com>
 <20180927205557.32026-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927205557.32026-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:55:58PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is explicitly converted to another.
> 
> drivers/infiniband/hw/qedr/qedr_roce_cm.c:198:28: warning: implicit
> conversion from enumeration type 'enum qed_roce_ll2_tx_dest' to
> different enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
>         ll2_tx_pkt.tx_dest = pkt->tx_dest;
>                            ~ ~~~~~^~~~~~~
> 1 warning generated.
> 
> Turns out that QED_ROCE_LL2_TX_DEST_NW and QED_ROCE_LL2_TX_DEST_LB are
> only used once in the whole tree and QED_ROCE_LL2_TX_DEST_MAX is used
> nowhere. Remove them and use the equivalent values from qed_ll2_tx_dest
> in their place.
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Michal Kalderon <michal.kalderon@cavium.com>
> ---
> 
> v1 -> v2:
> 
> * Rather than using an explicit cast, just convert the uses to the
>   appropriate values and delete the duplicated enum.

Applied to for-next, thanks

Jason
