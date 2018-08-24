Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16995C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C479E20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C479E20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeHXTbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:31:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXTbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:31:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D53FD8B;
        Fri, 24 Aug 2018 15:55:47 +0000 (UTC)
Date:   Fri, 24 Aug 2018 17:55:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Matthias B." <matthias@winterdrache.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to report kernel panic in 4.4.x
Message-ID: <20180824155545.GA6066@kroah.com>
References: <20180824142408.6340d052@ninja>
 <20180824125950.GA29673@kroah.com>
 <20180824154344.1c53a68c@ninja>
 <20180824141254.GB31555@kroah.com>
 <20180824163338.4bd9db8f@ninja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824163338.4bd9db8f@ninja>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:33:38PM +0200, Matthias B. wrote:
> On Fri, 24 Aug 2018 16:12:54 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > 
> > All of the stable trees are here:
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> > you want the linux-4.4.y branch to work off of.
> > 
> > All of the kernels releases are tagged, so you can start with v4.4.147
> > as the good entry for 'git bisect'.
> 
> I've never used git bisect on the kernel. Can I simply do "make" for
> each step or do I need to "make mrproper" every time?

'make oldconfig' and then 'make' should be just fine.  But add '-j10' or
so (the number of your cpus*2), so the build goes faster.

thanks,

greg k-h
