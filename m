Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9660C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0CB20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0CB20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbeGZPfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:35:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729923AbeGZPft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:35:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A0D4AFC6;
        Thu, 26 Jul 2018 14:18:44 +0000 (UTC)
Date:   Thu, 26 Jul 2018 16:18:42 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Alan Cox <alan@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: cpu_no_speculation omissions?
Message-ID: <20180726141842.56ppkwy3d3hwr56p@suse.de>
References: <20180716160513.GA6080@brightrain.aerifal.cx>
 <alpine.DEB.2.21.1807161851290.1693@nanos.tec.linutronix.de>
 <193fb2f5-8f6c-8fe6-298f-a6af4fae862a@linux.intel.com>
 <1531767303.4364.109.camel@linux.intel.com>
 <alpine.LRH.2.00.1807261529020.1881@gjva.wvxbf.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1807261529020.1881@gjva.wvxbf.pm>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 03:29:53PM +0200, Jiri Kosina wrote:
> On Mon, 16 Jul 2018, Alan Cox wrote:
> > The pre Silvermont atom cores are in order. When I did the original
> > list I didn't bother with all the 32bit cores as we didn't have any
> > 32bit mitigations then.
> 
> Now that 32bit PTI is in tip, I believe refresh of that list would be 
> justified. CCing Joerg.

Agreed, PTI for x86-32 is in -tip now and will likely make it into
v4.19. In-order cores (which should not be not affected by Meltdown)
should be on the list, otherwise they will get a huge performance hit.


Regards,

	Joerg
