Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1947EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB8423FD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB8423FD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeGFOjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:39:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeGFOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:39:24 -0400
Received: from localhost (unknown [37.170.89.196])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EEF1CF7;
        Fri,  6 Jul 2018 14:39:22 +0000 (UTC)
Date:   Fri, 6 Jul 2018 16:39:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v2] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180706143919.GA2344@kroah.com>
References: <20180628120542.GA4065@kroah.com>
 <20180629102446.11189-1-tycho@tycho.ws>
 <20180629164330.GL27027@cisco.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629164330.GL27027@cisco.cisco.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 10:43:30AM -0600, Tycho Andersen wrote:
> On Fri, Jun 29, 2018 at 04:24:46AM -0600, Tycho Andersen wrote:
> > v2: switch to locking uport->lock on allocation/deallocation instead of
> >     locking the per-port mutex in uart_put_char. Note that since
> >     uport->lock is a spin lock, we have to switch the allocation to
> >     GFP_ATOMIC.
> 
> Serge pointed out off-list that we may want to do the allocation
> before the lock so that it's more likely to be successful. I'm happy
> to send that change to this if it's what we want to do, I don't have a
> strong preference.

That sounds like a much better thing to do.

thanks,

greg k-h
