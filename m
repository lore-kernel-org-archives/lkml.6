Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7E3206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547137836;
	bh=Q4wBSFHlZ5JsYSF4PEc/HY6Lhy+R3VtJ+WOudiP0+yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JZz8Qm1nYZtDCCOKmfnwMMyCMwoTvd++TTp3DA9qmZhJZwqEfBHXkqON2GTIOFTOZ
	 82xq21BX72jNBX/ePlsBh/BXmzmhBVLvhbuz36pPuqZyo2mpnwdwerUfvfsYrglXxZ
	 tOq8/Ko4zXI8MUqQmorDiUSW1MMG5ERutF/7eq44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfAJQaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfAJQae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:30:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41DB2206B7;
        Thu, 10 Jan 2019 16:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547137833;
        bh=Q4wBSFHlZ5JsYSF4PEc/HY6Lhy+R3VtJ+WOudiP0+yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLiN80RuZ/I6YnbT47rFgagiwYVljl7/DGZ5H1jcYU7R12HMzxvO6h6WKKyq3/nvs
         HIpYsLyrfaCioI9ODvSuiM6Jc9KHAj7hc4MVBZ0y82D+9BayT9EDhtWVMcYWvVGS7E
         HH6wZkIt2YioYBecaxYpfLygWtGFihaQG0tKCcSY=
Date:   Thu, 10 Jan 2019 17:30:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for
 tty_buffer_worker
Message-ID: <20190110163030.GB19693@kroah.com>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
 <20190110101232.9398-4-o.rempel@pengutronix.de>
 <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
 <20190110151953.qpat4t7lat6plfk6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110151953.qpat4t7lat6plfk6@pengutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:19:53PM +0100, Oleksij Rempel wrote:
> > My gut feel is that if somebody still cares deeply about serial line
> > latency, they should look at trying to see if they can do some of the
> > work directly without the bounce to the workqueue. We use workqueues
> > for a reason, but it's possible that some of it could be avoided at
> > least in special cases... And yours sounds like a special case.
> 
> It is for industrial low latency RS-422 based application. The loopback
> test is just easy way to test/reproduce it without additional hardware.
> 
> What is good, mainlineable way to implement it? 

What is the real problem your systems are having?  Are they serial-port
limited?  Is latency a big issue?  Trying to tune for a fake workload
isn't the best way to solve anything :)

thanks,
greg k-h
