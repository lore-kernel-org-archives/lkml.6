Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3871C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C24206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtC1+bTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C24206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeK2X2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeK2X2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:28:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19D6205C9;
        Thu, 29 Nov 2018 12:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543494220;
        bh=V0SXK2plQ/j79HA/ek6TF09JvaDSKUCGyaJS+Yh6Z4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtC1+bTN5NH45JIOSOPmL8eANZLaHqgE5g/m6qZTK77k8vXt7LTkJlUhwrRBqVGOk
         e+SoXaYe7FICDdTnBA6pa7PUGM+HwEp1Hhs+jKpploXY3G//RbsoqlM6o/QD1GFS6l
         IritARfBYALVrQ9k8kY3NOAPzlmXAC7SQli6NNPY=
Date:   Thu, 29 Nov 2018 13:23:38 +0100
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
Message-ID: <20181129122338.GD3149@kroah.com>
References: <20170309101842.1449d49a@gandalf.local.home>
 <46a07263-3327-94b6-f6b8-a0a17ae7bfee@broadcom.com>
 <20181119151311.GA5340@kroah.com>
 <20181119104654.47623a42@gandalf.local.home>
 <20181119162432.GB13065@kroah.com>
 <20181119113537.3aa4f05e@gandalf.local.home>
 <06f2927d-5d5d-aca5-6a2e-e48836e4782c@gmail.com>
 <20181119142756.057ad784@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119142756.057ad784@gandalf.local.home>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:27:56PM -0500, Steven Rostedt wrote:
> On Mon, 19 Nov 2018 11:09:50 -0800
> Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> 
> > > I did the change against v4.2.8 below.  
> > 
> > Thanks Steven! Here is the local 4.9 backport:
> 
> Yours even updates the comment.
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Now applied, thanks.

greg k-h
