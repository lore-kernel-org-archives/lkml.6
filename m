Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0493C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D28F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GxvbfjUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D28F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeJWR6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:58:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34145 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeJWR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:58:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so380910pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SOwbrMWkrYb7j2jMIP6h9f2kkTsVFHKRu1DgJ7Zd3jQ=;
        b=GxvbfjUO6Z+ktgPzghSbCOzh0wnoTDncH7HuyxNrJlDMdp1eVYNHcuw2pucedRD1Ih
         oq4ud3wVJwoiQ1IV0fbni2nz3pf1b3hMWjM33ciGVzrQIgtOHAVlV5gn9Y4zYff3RX8R
         9jftVrRASrZ1a9VjAjRJr+71u6TtqLo3/WQwuIQGt7pPA45SGff64NUTzmJF93qTKOmA
         fwwGhYNacujaawjYq4hbwL6NXSFnUx+uHTZrRRwIkxn7dW+D3SifyJYnbjxV0xz8+XGc
         o7csKtwUN7vrcoTzRJVlIMl4N789YEFkVp+1R0n5Fa5uB7+0eeiLAG/+vDiDpWhUX46z
         uSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOwbrMWkrYb7j2jMIP6h9f2kkTsVFHKRu1DgJ7Zd3jQ=;
        b=Cw3kfBwSLXfldEOYvGuUYCbagWycejdZ0y0wzUmcFt8aaPLGQAJ5ga0WgU9MWsuDpB
         9sIfA8PBh+6qaJcZXMzA/XLeSm2EHfhNGtuqb2WdiOedrCcJCOiKh+UTbOYSfk7aR99G
         /bl6Fy/CR7Fy16bF0uqkVKsZHEjlTur/wX5yKOpZd6bTNO3zOGhaPiE+kMIrFDn4jP8b
         4jiFhBOkAIGzNCJFXRf222iV4Q2Txro96sTgOiTvj2Ld/tkG+gmq49SvS8U2BW17OZwP
         L0AqyQSl5/2ij9oFCHnIPq9/2XAT7hcQSzhDlvSKp83LPnm3hj/8UZt8wOb8KDHiiY1b
         J4qA==
X-Gm-Message-State: ABuFfoirYbdpZ/vAkCuMpPpc7a0qHdpoQKpzXjQVn/sj0811m8miBh7U
        FJwrKETEhEs5uGsXy3I/UjIWLg==
X-Google-Smtp-Source: ACcGV607BPAGvF6PeF8vG5xdd89HnLMvTkNyfquj4RX+N+3DwO5Wt1VMTOvYiZAACjLOzq/vTMucDg==
X-Received: by 2002:a65:56cc:: with SMTP id w12-v6mr22852028pgs.224.1540287326711;
        Tue, 23 Oct 2018 02:35:26 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id e3-v6sm2248823pgc.71.2018.10.23.02.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 02:35:25 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 19D3A3065E5; Tue, 23 Oct 2018 12:35:22 +0300 (+03)
Date:   Tue, 23 Oct 2018 12:35:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
 <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:10:47AM +0100, Linus Torvalds wrote:
> So I feel that he automation model is just not good. The reply should
> go to the actual pull request, not to the git history. People who want
> just _that_ could already automate the git history thing without me
> even doing anything at all, either scripting it themselves or by using
> some filtering on the kernel commit mailing list..

Can you tag merge commit with message-id of the pull request?
Automation machinery can reply to the pull request with proper CC list
obtained from the archive?

-- 
 Kirill A. Shutemov
