Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F3FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E562064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E562064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbeGZROW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:14:22 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55166 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbeGZROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:14:22 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1fiiab-0007bR-00; Thu, 26 Jul 2018 15:54:05 +0000
Date:   Thu, 26 Jul 2018 11:54:05 -0400
From:   Rich Felker <dalias@libc.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Jiri Kosina <jikos@kernel.org>, Alan Cox <alan@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: cpu_no_speculation omissions?
Message-ID: <20180726155405.GX1392@brightrain.aerifal.cx>
References: <20180716160513.GA6080@brightrain.aerifal.cx>
 <alpine.DEB.2.21.1807161851290.1693@nanos.tec.linutronix.de>
 <193fb2f5-8f6c-8fe6-298f-a6af4fae862a@linux.intel.com>
 <1531767303.4364.109.camel@linux.intel.com>
 <alpine.LRH.2.00.1807261529020.1881@gjva.wvxbf.pm>
 <20180726141842.56ppkwy3d3hwr56p@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726141842.56ppkwy3d3hwr56p@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:18:42PM +0200, Joerg Roedel wrote:
> On Thu, Jul 26, 2018 at 03:29:53PM +0200, Jiri Kosina wrote:
> > On Mon, 16 Jul 2018, Alan Cox wrote:
> > > The pre Silvermont atom cores are in order. When I did the original
> > > list I didn't bother with all the 32bit cores as we didn't have any
> > > 32bit mitigations then.
> > 
> > Now that 32bit PTI is in tip, I believe refresh of that list would be 
> > justified. CCing Joerg.
> 
> Agreed, PTI for x86-32 is in -tip now and will likely make it into
> v4.19. In-order cores (which should not be not affected by Meltdown)
> should be on the list, otherwise they will get a huge performance hit.

Does anyone have a complete list of pre-speculation Atom models? Mine
is one of the few 64-bit ones, but there are lots of 32-bit Atoms that
PTI would hit hard.

Rich
