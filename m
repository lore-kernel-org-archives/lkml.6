Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15566C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F3520831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xlcFVbMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F3520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbeKTCsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:48:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbeKTCsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:48:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 222932086A;
        Mon, 19 Nov 2018 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542644674;
        bh=fkZlXOd8PT+0EzePaNTDA5tRwWCszJAg8UHsM4aFl2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlcFVbMZIaJRthOsdFmqqYFSmAgyNMResCdFDBTiwo7peA6Qzc9TVij688xyp4sIO
         qmlsNgfMw3YWLlp0f2YiULcMQJEooByiABziVY5M5gtYGi6CWSQXzeQZIxD89eV0Ky
         Y2kr7eExsOqL6l6saewtx8iUb64CeGTT6JZX4EmY=
Date:   Mon, 19 Nov 2018 17:24:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Andrew Morton <akpm@osdl.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Do not bug in __sched_setscheduler() when pi is
 not used
Message-ID: <20181119162432.GB13065@kroah.com>
References: <20170309101842.1449d49a@gandalf.local.home>
 <46a07263-3327-94b6-f6b8-a0a17ae7bfee@broadcom.com>
 <20181119151311.GA5340@kroah.com>
 <20181119104654.47623a42@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119104654.47623a42@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 10:46:54AM -0500, Steven Rostedt wrote:
> On Mon, 19 Nov 2018 16:13:11 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > Can this patch also be applied to the stable trees? The offending commit
> > > was first introduced in 4.2.  
> > 
> > What is the git commit id of this patch in Linus's tree?
> 
> 896bbb2522587e3b8eb2a0d204d43ccc1042a00d
> 
> The subject was changed when it was applied.

Ah, that helps.

But why is this really needed in the older kernels?  You want to crash
your machine if someone got things wrong?  Given that I doubt this is
being hit anymore, why is it needed in 4.9.y and 4.4.y?

Also, it doesn't apply there so someone needs to do the backport...

thanks,

greg k-h
