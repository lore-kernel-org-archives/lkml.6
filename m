Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E227C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21E020833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ok9w7NUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21E020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIZC4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:56:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43403 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZC4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:56:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id q19-v6so11548438pgn.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fVcoobDrh4j8s4N20wDROGgmsRaRFegmQx2BcHth9Sc=;
        b=Ok9w7NUcFD26d7xuJ3Im0NK7jNmAgXK2RrvE9GYami49kHg9D1ineXQ1P6YCCo8rji
         +AE7V8aGzXTAreu7nOWB4dK7sbcXKSDhSbpxCrLf69eiWoGqXQSvnSvg7b01p0sTSS15
         UggcqMNYnTrlbHB1hpLxCUPJuJhImvDangsnYm/XmMyzcFtSbzy5QuUAsEyZVgk6Xjcc
         8RLZWwitwDZMmYgnBSLCCqwi5vD1gxRe7wlkLGF4z32HgD7XefjqR4QIiD9/Zux2ZKWv
         s5AVyz0UNsMfWzCbtsnCkAEaPeWIEGqzpvPJdSDoSLbyUuy73sXeXanqOTgu88u3Lehq
         qmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVcoobDrh4j8s4N20wDROGgmsRaRFegmQx2BcHth9Sc=;
        b=lTC7CQXHA2s9Y6f8JMfAbK62ydKfyVIIt7nWWkWegEpf/5C1Nwx5MfhW6XwSJ+SCwH
         dpNyFYrt2+wi7U7LTp1M8pRZvxYtuHr0QX+sGJERs9dsEkldlDY8DYi70dY9BO34d+Ht
         t+YyZejKRGBugPl1kItnQ6KrvHxH407O0oYhFzuKXLqxW1+R5MNMJiJlaOC4Ap8V/Zfj
         ThhPuQaVHiaiqsd7UAvmbHHKGhprAkOOXr8ny87TjBX8MdR+rFcmPDQ0JkW/H0RzKsmM
         1KC9YHJ5qRLv7I0LKeTV9BgIUAPlA7RfiVSOh0WO38aQUY49G8e0efksuQHaHflEl4KC
         kPAQ==
X-Gm-Message-State: ABuFfojWieOXEo8C95WgIapo2rS9Le94CfRP/Lke+ovHZvj6m4aYdOMv
        opgwBougF79V2Jgsl6rtqmkrsA==
X-Google-Smtp-Source: ACcGV62gvpr/0Q0dQ36LdZKSaC1sl/juiIv5vIdy4iBY3S7P9F2CErov+9J3gXOcaDsxxTS7pvNAZg==
X-Received: by 2002:a63:a54f:: with SMTP id r15-v6mr2583492pgu.336.1537908408726;
        Tue, 25 Sep 2018 13:46:48 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3571761pgs.89.2018.09.25.13.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:46:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g4uEJ-0006KF-JN; Tue, 25 Sep 2018 14:46:47 -0600
Date:   Tue, 25 Sep 2018 14:46:47 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] iw_cxgb4: Use proper enumerated type in c4iw_bar2_addrs
Message-ID: <20180925204647.GB24279@ziepe.ca>
References: <20180924192903.16796-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924192903.16796-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:29:03PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/infiniband/hw/cxgb4/qp.c:287:8: warning: implicit conversion
> from enumeration type 'enum t4_bar2_qtype' to different enumeration type
> 'enum cxgb4_bar2_qtype' [-Wenum-conversion]
>                                                  T4_BAR2_QTYPE_EGRESS,
>                                                  ^~~~~~~~~~~~~~~~~~~~
> 
> c4iw_bar2_addrs expects a value from enum cxgb4_bar2_qtype so use the
> corresponding values from that type so Clang is satisfied without
> changing the meaning of the code.
> 
> T4_BAR2_QTYPE_EGRESS = CXGB4_BAR2_QTYPE_EGRESS = 0
> T4_BAR2_QTYPE_INGRESS = CXGB4_BAR2_QTYPE_INGRESS = 1
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Steve Wise <swise@opengridcomputing.com>
> ---
>  drivers/infiniband/hw/cxgb4/cq.c | 2 +-
>  drivers/infiniband/hw/cxgb4/qp.c | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)

Applied to for-next

Thanks,
Jason
