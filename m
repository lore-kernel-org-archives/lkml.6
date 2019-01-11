Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D963C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E483F2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547214823;
	bh=m+wK3QaFLTBJDMtXCvxO/AElSCcMDLOGm7LHC+Owrw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hlf5OM35+g2wgZRgdI338OXYAQHAEETSb6rONrqVi7anBtCrzWzu3OGPuIRaDzhMI
	 mOWgTrRkvGVL9fxWIG5jiLUteUzrGQS1ER8E/8pFX4sfJhpssVzcMRGFi/ei5D4l1k
	 1u4Yt1L1uaCzl3P4xfY34of5wFweAZqJCsZMVhVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbfAKNxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbfAKNxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:53:41 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C6320870;
        Fri, 11 Jan 2019 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547214821;
        bh=m+wK3QaFLTBJDMtXCvxO/AElSCcMDLOGm7LHC+Owrw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDJVc+v+F40iStrZIoAzhHGvyP268Bawb0NNcb/1cVMApKqz27e/K5fF3HcSUtaII
         nSMzBHeUmTE3akftizU/RCyznEJS7zZctlHs8tSE8IrWE1ihsmYD3TkSEQPZcKOjYq
         Id/8Uncycdamqg0o8gR1fQDeRmCdOX6aiz5dqA28=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC00E41AB5; Fri, 11 Jan 2019 10:53:38 -0300 (-03)
Date:   Fri, 11 Jan 2019 10:53:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
Subject: Re: [PATCHv2 0/6] perf session: Add reader object
Message-ID: <20190111135338.GU22483@kernel.org>
References: <20190110101301.6196-1-jolsa@kernel.org>
 <20190111013115.GA557@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111013115.GA557@sejong>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 11, 2019 at 10:31:16AM +0900, Namhyung Kim escreveu:
> Hi Jirka,
> 
> On Thu, Jan 10, 2019 at 11:12:55AM +0100, Jiri Olsa wrote:
> > hi,
> > this patchset adds reader object to interface event
> > processing for any data. It's defined as:
> > 
> >   struct reader {
> >         int fd;
> >         u64 data_size;
> >         u64 data_offset;
> >   };
> > 
> > Now we can simply define reader object for arbitrary file
> > data portion and pass it to reader__process_events function
> > to process its data.
> > 
> > It's preparation for multiple file storage under perf.data
> > directory.
> 
> I'm looking forward to seeing it soon! :)
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, baby steps, prepping the stage for using multiple readers, one
per thread, etc, applied.

- Arnaldo
