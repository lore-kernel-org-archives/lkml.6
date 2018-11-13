Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBC8C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C765224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C765224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbeKMOUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:20:02 -0500
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:58479 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726103AbeKMOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:20:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6D985181D3368;
        Tue, 13 Nov 2018 04:23:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stop40_37c6c08f7d1c
X-Filterd-Recvd-Size: 2623
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Nov 2018 04:23:43 +0000 (UTC)
Message-ID: <b03fda08ee4ca4b488c6f67e64bfc94f49be4e83.camel@perches.com>
Subject: Re: [PATCH] xfs: Remove noinline from #define STATIC
From:   Joe Perches <joe@perches.com>
To:     Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Nov 2018 20:23:42 -0800
In-Reply-To: <20181113030926.GQ19305@dastard>
References: <7302f4a13c1cbf62b07f636878ce25fcca84b6c4.camel@perches.com>
         <6420cf91-89c8-a876-7a0d-25ab8ba428b8@sandeen.net>
         <20181112214515.GN19305@dastard>
         <bd3806ccc911989c7ef1fed9e8d26a4a5ad347a9.camel@perches.com>
         <20181113011804.GP19305@dastard> <20181113015410.GB30750@thunk.org>
         <20181113030926.GQ19305@dastard>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 14:09 +1100, Dave Chinner wrote:
> On Mon, Nov 12, 2018 at 08:54:10PM -0500, Theodore Y. Ts'o wrote:
> > On Tue, Nov 13, 2018 at 12:18:05PM +1100, Dave Chinner wrote:
> > > I'm not interested in making code fast if distro support engineers
> > > can't debug problems on user systems easily. Optimising for
> > > performance over debuggability is a horrible trade off for us to
> > > make because it means users and distros end up much more reliant on
> > > single points of expertise for debugging problems. And that means
> > > the majority of the load of problem triage falls directly on very
> > > limited resources - the core XFS development team. A little bit of
> > > thought about how to make code easier to triage and debug goes a
> > > long, long way....
> > 
> > So at least in my experience, if the kernels are compiled with
> > CONFIG_DEBUG_INFO and/or CONFIG_DEBUG_INFO_REDUCED,
> > scripts/decode_stracktrace.sh seems to do a very nice job with inlined
> 
> That doesn't help with kernel profiling and other such things that
> are based on callgraphs...

If that's really the case:

I rather suspect the xfs static v STATIC function marking is not
particularly curated and the marking is somewhat arbitrary.

So perhaps given the large number of static, but not STATIC
functions, perhaps a sed of s/static/STATIC/ should be done
when it's not inline for all xfs functions.

