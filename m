Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F498C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B910920881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ABO69lqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B910920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbeGIWQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:16:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40515 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754406AbeGIWQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:16:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so22267860wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cH5Xkc/YsNxLP+RJ4AOWrVB/0MZT2ICv3bcSGShLNfI=;
        b=ABO69lqifqZEjcF4DaUKGYj9WVh1JPwNmIrQaVjr7wvUQ694ahFBM+SWURmhN6Ojk5
         7aXHDEpCJd2i/AxXj5PUXcYdkYWKj3zgzI6Pjj68ELSx7Ps0/b28F9f++rvCR0YpQUT/
         +T7UpY3o2nZjOfjoyUYrBGfKu4YHLhw6tSdI/0SnYFzbYLlOeshweHN4hGuQwFyqF0Dc
         A0ms9k2YKh03TTNscsBthctwAuwFLhkI3F1QbdnkKN9KfS3j1JYaWeYk+i07NW2LtkQl
         wvUWOR4v5htSCHxx/6NA42nAPyGP8AndfPkb6lqdejPYDuA1JHp8rau+/SSoK+DJIST/
         Hmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cH5Xkc/YsNxLP+RJ4AOWrVB/0MZT2ICv3bcSGShLNfI=;
        b=lB79KphOc5Lns/JQgNVT8kTfRSuUCs7BFDFg5XNW6ZMYwpYAvD/HBvzNM6LrJx4RtZ
         URlJoQag6qc0rSbRS5qQIF9Pny2T5Tw0amhlTNG8mmD8aUCvDN3866m/QA/qaqpW4Bh4
         OxhvvG8fH8yeg6Ea4mLIySPB2IwFTw7RsOhcUHPne8Hozq/F4MwMNrvLvc1IEUBj5QLd
         LK2UFvBU+clqH3y1RMdIyfGushs8iL4DtY60IaXO3KBDPeu+xpYYRrhUT5sj+Zby6aF/
         FRK1yRvDZAGNJ585gKABNPCGtTlAHYx3fyLNOOVTrIlm4ixCBmvt9vZ7Y6uyIXxdidv4
         sLAw==
X-Gm-Message-State: APt69E1wV5ffaWKoXIpzqLupv9+dQqP2bv70FER28cx/dImduyDcaZ2n
        t2+b33q8eUAazBg9bAqHHBwwyw==
X-Google-Smtp-Source: AAOMgpeK1MsUFWZ2Xvwa5XwNQ4IbxXYCZv2WZruFYhwJO0lE/xEnZD++fpIPb5+tAEF/QrqvCd15MA==
X-Received: by 2002:a7b:c01a:: with SMTP id c26-v6mr13771605wmb.33.1531174604683;
        Mon, 09 Jul 2018 15:16:44 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q140-v6sm21775439wmb.35.2018.07.09.15.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 15:16:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fceSV-0003jB-Kj; Mon, 09 Jul 2018 16:16:39 -0600
Date:   Mon, 9 Jul 2018 16:16:39 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] ib_srpt: use kvmalloc to allocate ring pointers
Message-ID: <20180709221639.GA14259@ziepe.ca>
References: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:51:08PM +0300, Jan Dakinevich wrote:
> An array of pointers to SRPT contexts in ib_device is over 30KiB even
> in default case, in which an amount of contexts is 4095. The patch
> is intended to weed out large contigous allocation for non-DMA memory.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-next

Thanks,
Jason
