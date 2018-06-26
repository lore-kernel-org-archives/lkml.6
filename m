Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED93C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134D1264BE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134D1264BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935232AbeFZD4u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:56:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935130AbeFZD4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:56:47 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A2087CB1;
        Tue, 26 Jun 2018 03:56:44 +0000 (UTC)
Date:   Tue, 26 Jun 2018 11:56:40 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Whitmore <arigead@gmail.com>
Cc:     Justin Skists <justin.skists@juzza.co.uk>,
        devel@driverdev.osuosl.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH v3 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
Message-ID: <20180626035640.GA29538@kroah.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-4-johnfwhitmore@gmail.com>
 <CAHp75VegybTJJ8GruGORxB3NChgsEKN+kJF55UjU0OvP2svuQQ@mail.gmail.com>
 <20180625123559.pvjrpmbtk6z24uew@xux707-tw>
 <848175111.798938.1529931904819@email.1and1.co.uk>
 <20180625195025.xfbrlj7citq3qx6s@xux707-tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625195025.xfbrlj7citq3qx6s@xux707-tw>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 08:50:26PM +0100, John Whitmore wrote:
> On Mon, Jun 25, 2018 at 02:05:04PM +0100, Justin Skists wrote:
> > 
> > > On 25 June 2018 at 13:36 John Whitmore <arigead@gmail.com> wrote:
> > > 
> > > 
> > > On Mon, Jun 25, 2018 at 12:06:30PM +0300, Andy Shevchenko wrote:
> > > > On Sun, Jun 24, 2018 at 6:34 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> > > > > Replaced memory initialising loop with memset, as suggested by Andy Shevchenko
> > > > >
> > > > 
> > > > Suggested-by ?
> > > >
> > > 
> > > Em, not sure how to respond, it certainly wasn't my idea. I was just making
> > > coding style changes, badly. ;)
> > 
> > Suggested-by is a tag for patches, to give credit. For example:
> > 
> > https://elixir.bootlin.com/linux/v4.18-rc1/source/Documentation/process/submitting-patches.rst
> > 
> > See section "13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:"
> > 
> > Hope that helps,
> > Justin.
> 
> Oops... that helps thank you. I have to re-read that document, it obvioiusly
> didn't all sink in :(

I've dropped this patch, can you fix it up and resend?

thanks,

greg k-h
