Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1E1CBC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C370D2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FesqvtWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C370D2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754411AbeFLUig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:38:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44027 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754325AbeFLUie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:38:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so356741wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z432vuSKJQmbmG0J1IBk7+FGFTocRKF90+w5tJ26MC8=;
        b=FesqvtWxWnqvsWQLN1uXJ/lEZI2+o/Yr7UDgAhsQ94cEqOV87ViEa/rQg4Egq6FVux
         3PCYP1e8p7iwsjpguoXxti4gpNqZZQi85aQdo3ePJsAeKMhhpRUKgSyxppio8Oa1V9Jr
         gp1PM8GzC36bO4/8B4sSj0vP+wQwo8teC3QjunsqaDV8CkhXXf+gaX7a5yWUas2/sLSd
         HiGJyYiDc5saFj8PYzbi2BswZ3m8gOp5ye5v7K+iEzzamEDtAD4LST3uXi12oYT2mLcp
         wXyeC0PAwAceeDaO9mmUg4HhL1foL4JHpJ1TL1YFEyF8fYIa94vIOfrWrjVkDvJNJE72
         ZrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z432vuSKJQmbmG0J1IBk7+FGFTocRKF90+w5tJ26MC8=;
        b=tdcvFVc0V34m8u99R3PthC4KQs5fvUm+PTkB4fiU0fN53Akl52B0o3YYZPHvjh+B7o
         BlGgRwKDxI5vKViD8OO6gDGlRSn7DTelE9S54XTNfK91HmWLgXvDcPwCh7dhytPyvgJ3
         1QoEc7czb5ETKJwzUwe6a6Rhm6p3dLBvtadWvTz9GYsUJgUhcSJMisXqFLAN0sHsGKST
         sHA6AtlN1ZmAx9i9XN46Nle8+lKwmLmErJPMYeLIDOkBnrkRG8u3tNbIEoQgM9yO31jz
         kfRQSiUAUMGfNLQ+aEc5fphayv4Nzev70lRvOLTBJ3rgjR3oBsoWuZqsNRTmIJVWkEsL
         E9Dw==
X-Gm-Message-State: APt69E3BtKX8Sjf8dVcsVpar24Ohh+s77GvjYjwF95ObW/zi28BrYzYt
        RW8tCCUaL26GoeRNZNEnzPb08w==
X-Google-Smtp-Source: ADUXVKInT0aJ/ZMZ6BKrVYpFyr80jXLXRbuxbEB6d1vQU/tiaHX0RhQI8HWhOWE6J59gYvfcnVezhA==
X-Received: by 2002:adf:e644:: with SMTP id b4-v6mr1928684wrn.254.1528835913460;
        Tue, 12 Jun 2018 13:38:33 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u108-v6sm2041503wrc.40.2018.06.12.13.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:38:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fSq3g-0008LD-Rd; Tue, 12 Jun 2018 14:38:28 -0600
Date:   Tue, 12 Jun 2018 14:38:28 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] IB/mad: Agent registration is process context only
Message-ID: <20180612203828.GH6314@ziepe.ca>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608174218.32455-2-willy@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 10:42:17AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Document this (it's implicitly true due to sleeping operations already
> in use in both registration and deregistration).  Use this fact to use
> spin_lock_irq instead of spin_lock_irqsave.  This improves performance
> slightly.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  drivers/infiniband/core/mad.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

In the mean time, this patch is straightfoward, applied to the interm
for-next..

Jason
