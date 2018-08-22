Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC6EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6E3217DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GcBMiVvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6E3217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeHVGlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:41:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40684 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHVGlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:41:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so139844pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 20:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jLe1wxMc0hybNzXysvVg9q68AaZflLMDCGcGchCWQpA=;
        b=GcBMiVvFvr8mkY0lYQZM3mhyiPxpqZIEPmnNMHSB1RZjpSaGc+bXTyk4zCZSg2lI7P
         tHScmZqj46rKelHl4YksZyMNKaBRXky2ODiJ5cpH+LXFqEZdzM3Lp/DBXPGdkVeWY7MC
         ZVNUPxfTCnNw7yBj6gMHp6r+AOqPqpY8zelUpWJiQOV5kK6cdzv7TCYkRVpGjsflvlqR
         C3eh0WHqsQ95KssmssMh40GRQVH7LnVcVfd6qUWKQF6o10qjSwIG6uVZcIaLptxGO9UQ
         KBtRqqnewAhJgqnIFZUoGS396g3jZO5pO0cU+Z2VqAJsERV9PBc2ZHkOaQzQgTLLfDcc
         4Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jLe1wxMc0hybNzXysvVg9q68AaZflLMDCGcGchCWQpA=;
        b=MFyw5oGB5329TmGIjrM+Xap+ikciH5lojKqG9mH3bxCTOn8HeE+umJDw4Xt3hp47So
         6trcn7bylHDh0f4oRhH13I/EtC+SRRpNbCko+XHOqQjIyeBHcnUEcpfz5/yhYV4gQEh6
         S2TlFW36nfb/YGDgLBS6D3EEzaYn8vYZF9CmEeQ/0Sy5SWykvc/DBfJdHENIuN8oQqIn
         Hm37fJ3huSRoLsTt5bG46g/ji3D7ysdjOZeiByCmZTwdi7Q7JrwMndQvDGeZS/iKL3+6
         3Q3GgaE7Dqac6lX2z6eHu8e4ceYGd/p34Y6AZ6RzyAcHydzgbGMVLb6heSoi85XKJaRC
         wq7w==
X-Gm-Message-State: AOUpUlGi97rLtmzR79fKgZDt2P7oBYfSwfJdbtR26EAZUeLrKofiLkQq
        PysUSiHAGUgBuc9tUjB7L91vGg==
X-Google-Smtp-Source: AA+uWPzRKXtMOazConaHNAa8pGTvsHR/OsspXT3tGzrdJhAUr8GPwZDTNt4r8UlVaRtk0P9BjbVEQA==
X-Received: by 2002:a63:9a42:: with SMTP id e2-v6mr23702344pgo.263.1534907894559;
        Tue, 21 Aug 2018 20:18:14 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t9-v6sm345573pgi.87.2018.08.21.20.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 20:18:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fsJev-0000M2-3c; Tue, 21 Aug 2018 21:18:13 -0600
Date:   Tue, 21 Aug 2018 21:18:13 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/ucm: fix UCM link error
Message-ID: <20180822031813.GA1313@ziepe.ca>
References: <20180821142100.2250647-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821142100.2250647-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 04:20:44PM +0200, Arnd Bergmann wrote:
> Building UCM with CONFIG_INFINIBAND_USER_ACCESS=m results in a
> set of link errors including:
> 
> drivers/infiniband/core/ucm.o: In function `ib_ucm_event_handler':
> ucm.c:(.text+0x6dc): undefined reference to `ib_copy_path_rec_to_user'
> drivers/infiniband/core/ucma.o: In function `ucma_event_handler':
> ucma.c:(.text+0xdc0): undefined reference to `ib_copy_ah_attr_to_user'
> 
> To get it to build-test again, this makes the option itself a
> tristate, which lets Kconfig figure out the dependency correctly.
> 
> Fixes: 486edfb1039d ("IB/ucm: Fix compiling ucm.c")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc

But that fixes line isn't right is it?

Should it be

commit 7a8690ed6f5346f6738971892205e91d39b6b901
Author: Leon Romanovsky <leonro@mellanox.com>
Date:   Wed May 23 08:22:11 2018 +0300

    RDMA/ucm: Mark UCM interface as BROKEN

Which added the config in the first place??

Thanks,
Jason

> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 1d6f5710d1df..176b943dfec9 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -35,7 +35,7 @@ config INFINIBAND_USER_ACCESS
>  	  rdma-core <https://github.com/linux-rdma/rdma-core>.
>  
>  config INFINIBAND_USER_ACCESS_UCM
> -	bool "Userspace CM (UCM, DEPRECATED)"
> +	tristate "Userspace CM (UCM, DEPRECATED)"
>  	depends on BROKEN || COMPILE_TEST
>  	depends on INFINIBAND_USER_ACCESS
>  	help
