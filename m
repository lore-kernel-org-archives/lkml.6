Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2170C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B239120870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="D2GpO7WT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfAKGSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:18:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44396 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbfAKGSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:18:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so6453205pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 22:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Odd+d7FRnWKozZoyrm85E0qq1CgMg6d5XpBldOLqvE4=;
        b=D2GpO7WTBKs3z+AkN4S0bDDH5YLwW3d7KQQmMz51zjBJCbiwQfEt6xRP8eesLEHgsZ
         0aDAbn497/baah6/r9ePKiU3SneHiUCS41enMD9O470cEV9JmKcTR3IMVd5zrFWtbJcY
         1DfNLvh8jxQe6I5eo+CUjmzj7Y5UAdhYFS9wap/YeWsfdrvkyZMFL+/Zj4jqU1aTmSXN
         h0Vshg+q0qG7GzoSR8kDOzeLLZiVXQHwVJiySHuJKjDDSdb+MfrT4pKgrjNjqPiWZ1nQ
         ptdAOL0gmhS97aIzrRs0CbrlaLCwk3df5Q4qrnJYMve/6R/udziqzVgoGiynOrxJJ8YN
         lMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Odd+d7FRnWKozZoyrm85E0qq1CgMg6d5XpBldOLqvE4=;
        b=BUr4dW9AOLOcU2WhmJ0zl8raCfLjpHtfKILQtQfjO82VCuL3B2msm1Eo4UVRfiJqkd
         X4TBOZp+iEIHzWPHytVMYt6QRPlFK2ykei7Zd/G3Ao2CcPrOIaYHc7UbADIFgY8n2vN7
         NFCZQ3lC13XJUpYRxNa2ifwBNAdBChkw7fUzAuptOM+ncYEOu8UaNK3EeBogGvQ8vKe/
         jRlZsw+N4X71iEVmeE4ERH2+Q8udlsK6t9c9TB0ouPKd1z3IopPTsld0C9uIaTaJsb7Q
         7Xztyq48lTY5zxaGuic+qJDKB0QHOZZgV2X4NNInrryoHRzIAQ4jae2bsUdhY+qI951A
         4jJw==
X-Gm-Message-State: AJcUukd7NzgwczHs0VV+xdgRiahQBwp9mrFWln92CM3QSPH3ZN8sjRpP
        JME5GugvT5edG39iYb/Gmd9r3Q==
X-Google-Smtp-Source: ALg8bN7t7y2f75pxqWUVGFGf0z7L0qxYYjnGe8eBmMz51gqXGJ1hqxXM2QLa5gTxL9urnS3c3HjV7g==
X-Received: by 2002:a63:9809:: with SMTP id q9mr12261502pgd.109.1547187513063;
        Thu, 10 Jan 2019 22:18:33 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r187sm244596079pfc.63.2019.01.10.22.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 22:18:32 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Thu, 10 Jan 2019 22:18:31 -0800 (PST)
To:     Alexandre Ghiti <aghiti@upmem.com>
cc:     palmer@sifive.com, aou@eecs.berkeley.edu, catalin.marinas@arm.com,
        ndesaulniers@google.com, linux-riscv@lists.infradead.org,
        atish.patra@wdc.com, akpm@linux-foundation.org, mingo@kernel.org,
        mike.kravetz@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] riscv: Introduce huge page support for 32/64bit
 kernel
In-Reply-To: <20181210062146.24951-2-aghiti@upmem.com>
Message-ID: <alpine.DEB.2.21.9999.1901102215390.22105@viisi.sifive.com>
References: <20181210062146.24951-1-aghiti@upmem.com> <20181210062146.24951-2-aghiti@upmem.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexandre,

On Mon, 10 Dec 2018, Alexandre Ghiti wrote:

> This patch implements both 4MB huge page support for 32bit kernel
> and 2MB/1GB huge pages support for 64bit kernel.
> 
> Signed-off-by: Alexandre Ghiti <aghiti@upmem.com>

This patch introduces a few minor checkpatch and strict checkpatch 
warnings, when tested against both v4.20 and v5.0-rc1 checkpatch versions.  
Could you fix those?  The other two patches in the series look OK from 
that point of view.


- Paul
