Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D049FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBA020867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBA020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeIYPCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:02:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeIYPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:02:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96A1B10F7;
        Tue, 25 Sep 2018 08:56:00 +0000 (UTC)
Date:   Tue, 25 Sep 2018 10:55:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 3.18 104/105] IB/nes: Fix a compiler warning
Message-ID: <20180925085558.GA22609@kroah.com>
References: <20180924113113.268650190@linuxfoundation.org>
 <20180924113123.002918395@linuxfoundation.org>
 <6f7ca3c205bada768c3918b1feacbbd5ce23a64d.camel@perches.com>
 <20180924175902.GB19402@kroah.com>
 <6d6f31c87b0c9b1a551d352439183c8c9c4df04c.camel@perches.com>
 <20180924223952.GA9157@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924223952.GA9157@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:39:53PM +0000, Sasha Levin wrote:
> On Mon, Sep 24, 2018 at 11:03:25AM -0700, Joe Perches wrote:
> >On Mon, 2018-09-24 at 19:59 +0200, Greg Kroah-Hartman wrote:
> >> On Mon, Sep 24, 2018 at 09:38:26AM -0700, Joe Perches wrote:
> >> > On Mon, 2018-09-24 at 13:34 +0200, Greg Kroah-Hartman wrote:
> >> > > 3.18-stable review patch.  If anyone has any objections, please let me know.
> >> >
> >> > Why should this sort of change be applied to a stable release?
> >>
> >> Originally I was just going to drop this as it's not fixing something.
> >>
> >> But it might be, if that macro is used in a if() statement, or something
> >> like that, it could be doing something unintended.
> >
> >No it couldn't.
> >An empty macro is equivalent to a single statement.
> >
> >> So I don't feel like auditing all 500+ instances where this is used,
> >> it's easier to just accept the patch.
> >
> >It's not a bug fix.
> 
> This question came up a few months ago. Greg suggested that we should be
> pulling in warning fixes to get the stable kernels warning-free similar
> to upstream.
> 
> The reasoning behind it was similar to the "no warnings" reasoning of
> upstream: there might be real issues hiding in the sea of "harmless"
> warnings, so we want to get rid of all of them to catch real issues.

No warnings is great, but not when you add the "W=1" option.  That way
lies madness and is not something anyone does on stable kernels.  They
do it on mainline when they want to try to find something to clean up
and get a coding style fix merged :)

thanks,

greg k-h
