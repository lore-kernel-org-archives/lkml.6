Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4706C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B802206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Quws+qHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B802206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeILBqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:46:03 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55818 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeILBqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:46:02 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so76140itj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ybhHlz6fUea5FCwSml+iCw8bY99WIf9EqxxM0rytOmM=;
        b=Quws+qHYJtcXaPGvldNABypRdEuopny2hoxyjRmNxgF96uyUOxkmO1YVE3618dnrKM
         a7DMaGJbYFskOlCH/2fm+vhxRNx7S9kElnmKG+gxvVdTsiy9mxFlRFCY+0/uqYC8NeFr
         oI3HI/AtQk6CIv3JnKqifsTiRl6xMuTBnQwzgq2ms8YktlWLfUKCDhaDsvEcBdDumnaG
         lSKWCPxayuXrm33zsujC2JAFMlYMe7mBLuOXn9cJfcbtvC5M8Rqh9ZtMK9R901yZn2RJ
         FtS7vrtPj1oe8KdOevTjz/qJMYhXVUnQmb+PGU8Ni7taoJeBehTspmD+X6eagJxpF0/u
         N6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ybhHlz6fUea5FCwSml+iCw8bY99WIf9EqxxM0rytOmM=;
        b=dJGQoS5y6fSaJZyA161pCWhCZf+O7ON7Jhyme4CrYivYd3JGg2Eb4MB+5Xz4eJLS42
         SABKCBDW+N1eOWZV5OXTLtqDVJUy4F2iwSvgaq2D2ep4WLTU9/uEcWe073SeTWGqDN1+
         B2vKNz/VbOU3riagaV5LoY6fwcjJfS0y98iKC51yRC/UG3ffsPCG2KMmzM3MXRK3JbNe
         bg4g6WqkZDpCtQkyy2848FY1B++k/0k+sChnKfTFQv00SetHGvSBHJG9nO2P8B7lt+Cq
         zJWA1APW0MHJpwdcoQsnpey0sU+2RplU5hCHDPEFRACoiY6gBkbZpWbzfYkvE4PfMhIx
         FpCQ==
X-Gm-Message-State: APzg51DOYE04xDanNvKETDICtQeVIQhoV2A7X6S9DRG7u/cng3Q7IMab
        gEK55FKu4NOgMDwFXrovELKgag==
X-Google-Smtp-Source: ANB0VdYJf4VlVf6x01nztVZcI/XALprgvwhPBb6FI0YsEWHh4zHNAQnFYOXUtoCJdajBBC3lIKr5aw==
X-Received: by 2002:a24:bdc5:: with SMTP id x188-v6mr3093741ite.37.1536698699865;
        Tue, 11 Sep 2018 13:44:59 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id f24-v6sm6416223ioc.52.2018.09.11.13.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:44:58 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:44:56 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "ASoC: Intel: Skylake: Acquire irq after RIRB
 allocation"
Message-ID: <20180911204456.GA18086@google.com>
References: <20180910211718.200802-1-yuzhao@google.com>
 <s5hd0tk3712.wl-tiwai@suse.de>
 <20180911163636.GC10123@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911163636.GC10123@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 05:36:36PM +0100, Mark Brown wrote:
> On Tue, Sep 11, 2018 at 08:03:21AM +0200, Takashi Iwai wrote:
> > Yu Zhao wrote:
> 
> > > Will fix the problems in the following patches. Also attaching the
> > > crash for future reference.
> 
> > > [   16.950887] RIP: 0010:snd_hdac_bus_update_rirb+0x19b/0x4cf [snd_hda_core]
> > > [   16.950889] RSP: 0000:ffff88015c807c08 EFLAGS: 00010003
> > > [   16.950891] RAX: 0000000000000101 RBX: 000000000000080c RCX: 1ffff10026822185
> 
> > Please try to rip off uninteresting hex values and other stuff there.
> 
> Right:
> 
> Please think hard before including complete backtraces in upstream
> reports, they are very large and contain almost no useful information
> relative to their size so often obscure the relevant content in your
> message. If part of the backtrace is usefully illustrative then it's
> usually better to pull out the relevant sections.

Thanks, will do in v2.
