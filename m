Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B57C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0860E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549905054;
	bh=8uRcwZJwPnOimPfJFyavNGbH0OfpQCm9ZcYVcepkiX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WxB1/luJf5P2SPS6bsTDXJfs5VCOykLIZp97nIZwXel3jdUHNxsj/mni48663bMRM
	 iUMloe+Xhxyta+ijRCJoekVxj3tBP7eRqMUIh5XQywbLJuOWsMQkzaMJH2w90WE8wv
	 Oe6IcP04JNNi1kj0gC4+vv7m3kudLD4a7Vtn30aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfBKRKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:10:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37722 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBKRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:10:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so1556244pgq.4;
        Mon, 11 Feb 2019 09:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=29dzQVfMK9hg0VC5fWC+4ES2pHCwnokbgPvFubf905c=;
        b=NWf3qLlpgfAXV6rFMrwsqGt/jAPuF+Voz9MZpGSb3Y3nn7zJF1zbUOiEb+3D8ktkSV
         jl4SPELIWffUkyLOLLbV0eEaPvVwn3gfbRR27XZzzOgLVw1gSmWvvLOmijxg5M+TC0OU
         fAPaOO2Ve3aG0ZGqFv5YNBBSHRHmGlW1qllq/mIuITYUyWRACXmq6EaxJynXHkTzd5nD
         rOZ0ngP4QPDAcnictKN3nQXSUrmH10FY+5r3b0QTkdiqecPoMmiOswv71UHe89bAlm/j
         /fpnHtN1vhjymLSS5+9L2k1xhkyKB4oaZdf8dr82hmE6A+M4HqCkkSwzxhnrdwHazdI8
         e6sg==
X-Gm-Message-State: AHQUAuZtCw/XTZbyc/KxXXeZvdZOr46Xl5dKHn2PXRuRwi9tXdcAtMpB
        xpH9ugwJyCouIDRjMxijkkTTeuXbxi0=
X-Google-Smtp-Source: AHgI3IYEBki+PTyLJmBYA5RUlmDksvxBWya+1fzEG1oh8QhGMsJzmILSvCe+KxGCeBRsz5XxBuUI+g==
X-Received: by 2002:a63:ef50:: with SMTP id c16mr25721232pgk.3.1549905051229;
        Mon, 11 Feb 2019 09:10:51 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id h75sm18871841pfd.162.2019.02.11.09.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 09:10:49 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 11 Feb 2019 09:10:47 -0800
Date:   Mon, 11 Feb 2019 09:10:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the driver-core tree
Message-ID: <20190211171047.GN11489@garbanzo.do-not-panic.com>
References: <20190211074052.2407f1e3@canb.auug.org.au>
 <20190211074402.GA7356@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211074402.GA7356@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 08:44:02AM +0100, Greg KH wrote:
> On Mon, Feb 11, 2019 at 07:40:52AM +1100, Stephen Rothwell wrote:
> > Hi Greg,
> > 
> > In commit
> > 
> >   344c0152d878 ("selftests: firmware: fix verify_reqs() return value")
> > 
> > Fixes tag
> > 
> >   Fixes: a6a9be9270c87 ("selftests: firmware: return Kselftest Skip code for for skipped tests")
> > 
> > has these problem(s):
> > 
> >   - Subject does not match target commit subject
> 
> I don't understand, what is wrong with the fixes: tag here?
> 
> $ git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n" a6a9be9270c87
> a6a9be9270c8 ("selftests: firmware: return Kselftest Skip code for skipped tests")
> 
> How does that not match up?
> 
> Ah, an extra "for" in there.  Luis, you need to fix up your scripts, and
> not be forced to manually type in those lines :)

Will do.

  Luis
