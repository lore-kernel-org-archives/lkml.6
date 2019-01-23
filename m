Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66639C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27269217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548247209;
	bh=oVfxRd3cEBBk1LwgQIYuku2qf7twIi/p57MhdT3lNAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wn+SCyFCgG1iop6B6+IjpUWiVnJSgIlHVzZtFfnxxmW/SHGhpxb9EN+w2yngLLZ56
	 OxwxMzqbWHngm5CsiWI+DWYUE6h3UGcLaeXf+e25LyDfxxz6wljW6LWgLnuNS2uQUX
	 XSLV8dQ3WCYVNH8ZIJm4OkIXhf4dFGkzBwDiAwwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfAWMkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfAWMkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:40:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E291421019;
        Wed, 23 Jan 2019 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548247206;
        bh=oVfxRd3cEBBk1LwgQIYuku2qf7twIi/p57MhdT3lNAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVzM2u0agqPT0uGuTYGuf3rzou0huNlyMRUdageed85p1O7ViJFpSN48K4zcExJjn
         E5OfApae6vXp7Ej8F5MEdddcy9OA0VKM3HjrUVfNrWYzrthaMNm3ncfmGbsmqbVO3a
         iW3CR/AcUL8lIC1c7fIgBwRXXESmsb9IDXJuvXig=
Date:   Wed, 23 Jan 2019 13:40:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
Message-ID: <20190123124004.GA19703@kroah.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-2-oded.gabbay@gmail.com>
 <20190123122804.GB2194@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123122804.GB2194@rapoport-lnx>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:28:05PM +0200, Mike Rapoport wrote:
> On Wed, Jan 23, 2019 at 02:00:43AM +0200, Oded Gabbay wrote:
> > +/**
> > + * hl_device_release - release function for habanalabs device
> > + *
> > + * @inode: pointer to inode structure
> > + * @filp: pointer to file structure
> > + *
> > + * Called when process closes an habanalabs device
> > + */
> 
> It's nice to see docs coming along with the codei
> I have some comments for the formatting.
> 
> kernel-doc won't be happy about missing return value descriptions, and
> although they are sometimes redundant or too obvious their absence makes
> 'make V=1 htmldocs' really noisy.
> 
> In general, it would be nice if you could link hanabnalabs driver
> kernel-doc somewhere in Documentation/ run 'make V=1 htmldocs'.
> 
> > +static int hl_device_release(struct inode *inode, struct file *filp)

There's no need for kerneldoc comments for static functions, as no one
can call them and they are not part of any api.

So what would be better here is to just drop the /** line and use /*

thanks,

greg k-h
