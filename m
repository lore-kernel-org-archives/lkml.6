Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A376C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11C0214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7Lul/d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11C0214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbeKVAaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:30:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbeKVAap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:30:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F492146F;
        Wed, 21 Nov 2018 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542808574;
        bh=lXULnIjOp74TaJbzJ+owWqy1ehDHJ4u0UjoSMUW/uhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7Lul/d3Jbc/L68tntV3Wl3hj1WJBYs7NKUhMAFFyZ+SUloIqIIWnWp8cQMOB8qfZ
         SMOi8dD/99ziySXXo2vag1lYVdeyRWoelLVGmYCtjlVejRRxa1x88sUJCfe2zuD5Df
         i86QZR/HDZAvWhaQn9SwLATW0qghdEJbXlDWB8lw=
Date:   Wed, 21 Nov 2018 14:56:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        WoodhouseDavid <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        SchauflerCasey <casey.schaufler@intel.com>
Subject: Re: [PATCH 4.19 041/361] x86/speculation: Enable cross-hyperthread
 spectre v2 STIBP mitigation
Message-ID: <20181121135611.GA26411@kroah.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221625.598298393@linuxfoundation.org>
 <alpine.LRH.2.00.1811211420130.18805@gjva.wvxbf.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1811211420130.18805@gjva.wvxbf.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 02:21:15PM +0100, Jiri Kosina wrote:
> On Sun, 11 Nov 2018, Greg Kroah-Hartman wrote:
> 
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> Greg, please drop this patch from all -stable for now. Version that 
> wouldn't have such performance impact is being worked on.

Is it reverted in Linus's tree?  If not, then anything that comes "later
on" will not apply here, right?

I see the thread asking about this, but I got really conflicting
messages here, and now it's in all of the latest releases, and no
testing seems to have uncovered issues.  Is it just a "slow down"
problem?

thanks,

greg k-h
