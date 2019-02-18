Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31884C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99BD21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5uN4rKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfBRFqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 00:46:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40687 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfBRFqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 00:46:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so7965810pfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 21:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yn9hWHB55hBIFTQkiQ7zlHrAL86VOVnr/MNJy6IuYXg=;
        b=B5uN4rKWQPW7DGKXDkYNcW8cEpsC0UVJ7zkN6sJoZrJupZaysMq15KMTHtMdVaGjvT
         V0tx1ddKMq/3Mp65pz8n/gcFFIxl2ARKfQNkKhoN6wbQk2xKwfMLZy6YVhWxfdk2DLyP
         pagAIplMmgFRI7V1BlBnTht6zPMdZ4xY5oOQc8hqEOmlSefi1ID0oCrHPxHD1c/xrP+1
         1sTW13leHCV08ulYlJ6ixNvBqRcbRe3V68REntl6CbtsAyv849OCEe0rV5e/CWXUE0ve
         Ny80BRSE87gtafUYC0Nj2HRl0F9mDeJXHVlgUDPqfhXRaVMfTcph9wtmy3s2L1d8WEWv
         4ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yn9hWHB55hBIFTQkiQ7zlHrAL86VOVnr/MNJy6IuYXg=;
        b=WCRglSyAcLu4fOqeAhsUcWh+sSWQUECei+ZsfnIUG/Aps3B8r9tjdVeLOkc1N4jFjL
         WDfLlYgKvayGOah9MburQ/27SB3HhAtfaJOHSUoY5qBn6eiTdnZSgF7feVOMHtwYuOXs
         dzDlfEEYnLahaClczliUxC6FQS43PzAxwXj0WipkJzk6jurDK5IFuqMw8845q+SjPBNw
         xuh8fqeZkORLAAcaZpy6e/QZiHBqIeihZbSKrHwzGubIk1X02liu8yPud3+5HJudSHi0
         l/qhaAZmU2Vq+fcr0B7q8z8rLMGvzv7Qq5e2WcbQ+QAgNnZcbYtSW7nGNgqiXhSBXWVC
         88zA==
X-Gm-Message-State: AHQUAubC8I7fa6sGGoWC6kMseIwRMFbrJYIkS/XJPDwEsLjDs85dh1xN
        i19Oi9iABfmsoiPQ+zTvtng=
X-Google-Smtp-Source: AHgI3IbWRT4HYgM5zNt5zBd/bvNTJ2b0J17nGNQ29a+qP0sQ24JvxRXvjj5kB/Ips/v3hX/7qTY+Aw==
X-Received: by 2002:a62:574d:: with SMTP id l74mr16991972pfb.9.1550468813531;
        Sun, 17 Feb 2019 21:46:53 -0800 (PST)
Received: from localhost ([39.7.51.148])
        by smtp.gmail.com with ESMTPSA id 11sm15565331pfh.131.2019.02.17.21.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 21:46:52 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:46:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Yao HongBo <yaohongbo@huawei.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in console_unlock
Message-ID: <20190218054649.GA26686@jagdpanzerIV>
References: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
 <20190216072127.GA1945@tigerII.localdomain>
 <20190216073856.GA9979@tigerII.localdomain>
 <71b097a7-03c5-8a65-76fa-24312b452b51@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b097a7-03c5-8a65-76fa-24312b452b51@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (02/16/19 15:59), Yao HongBo wrote:
> > GFP_NOWARN is probably the best option for now. Yes, it, maybe,
> > will not work for fault-injection cases; but printk_safe approach
> > is harder to push for, especially given that printk_safe maybe will
> > not even exist in the future.
> 
> I have tried GFP_NOWARN, but the problem still exists.
> Only print_safe contexts for tty locks can solve the problem.
> My test scenario is falt-injection.

Oh, I see. Yes, fault-injection is special.

I suspect that this patch series can be helpful then
https://lore.kernel.org/lkml/20181016050428.17966-1-sergey.senozhatsky@gmail.com/T/#u

but first we need to figure out if printk_safe will
stay in the kernel (this will take some time).

	-ss
