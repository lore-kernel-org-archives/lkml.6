Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033643AbeBOO6h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033103AbeBOO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:58:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A16217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 15 Feb 2018 11:58:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 1/2] perf tools: inject capabilitity for CoreSight traces
Message-ID: <20180215145833.GF30974@kernel.org>
References: <1518011845-24063-1-git-send-email-robert.walker@arm.com>
 <1518011845-24063-2-git-send-email-robert.walker@arm.com>
 <CANLsYkz7c7vTFn3M17-=57C__yxcXbTyRLjgjLVBDvoQm6RV7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkz7c7vTFn3M17-=57C__yxcXbTyRLjgjLVBDvoQm6RV7w@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 13, 2018 at 03:18:02PM -0700, Mathieu Poirier escreveu:
> On 7 February 2018 at 06:57, Robert Walker <robert.walker@arm.com> wrote:
> > Added user space perf functionality to translate CoreSight traces into
> > instruction events with branch stack.
> >
> > To invoke the new functionality, use the perf inject
> > tool with --itrace=il. For example, to translate the ETM trace from
> > perf.data into last branch records in a new inj.data file:
> >
> >     $ perf inject --itrace=i100000il128 -i perf.data -o perf.data.new
> >
> > The 'i' parameter to itrace generates periodic instruction events.  The
> > period between instruction events can be specified as a number of
> > instructions suffixed by i (default 100000).
> > The parameter to 'l' specifies the number of entries in the branch stack
> > attached to instruction events.
> > The 'b' parameter to itrace generates events on taken branches.
> >
> > This patch also fixes the contents of the branch events used in perf report
> > - previously branch events were generated for each contiguous range of
> > instructions executed.  These are fixed to generate branch events between
> > the last address of a range ending in an executed branch instruction and
> > the start address of the next range.
> >
> > Based on patches by Sebastian Pop <s.pop@samsung.com> with additional fixes
> > and support for specifying the instruction period.
> >
> > Originally-by: Sebastian Pop <s.pop@samsung.com>
> > Signed-off-by: Robert Walker <robert.walker@arm.com>
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Arnaldo - this should probably go through your tree but let me know if
> you want to proceed otherwise.

I can pick it, but now I'm waiting for Robert to address your comments,
so haven't processed none of these two.

- Arnaldo
 
> Robert - the work in coresight.txt should likely be published on its
> own.  That way Arnaldo doesn't have to worry about it.
