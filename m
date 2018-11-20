Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C8CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1289520831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZH8BG3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1289520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeKTUSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeKTUSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:18:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74C820851;
        Tue, 20 Nov 2018 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542707397;
        bh=+keEA34xmi9AaCRHIfDY16RUCuw/P74QJTxckHX9Axk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZH8BG3o8v2lR0Aye9PkPiyeStkbF8jkIp8sQzJfBIhoQhQLfaZ+UuvtiUdE+ZRXR
         BmTr1ziORuY9DZFNkscOGXofgb8zZRg5ftVByNEkDr4EwYWMV/TjAEzj1f/X8svYnp
         c0TYXKcyUypV/z10REnkm4VQGLvaQL+7iSkb9CbA=
Date:   Tue, 20 Nov 2018 10:49:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org,
        Alex Elder <elder@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] staging: greybus: arche-platform: Switch to the gpio
 descriptor interface
Message-ID: <20181120094954.GC8089@kroah.com>
References: <20181116151740.GA12250@nishad>
 <20181116160622.GQ19900@localhost>
 <20181117071109.GA14187@nishad>
 <20181117154027.GV19900@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117154027.GV19900@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 04:40:27PM +0100, Johan Hovold wrote:
> On Sat, Nov 17, 2018 at 12:41:11PM +0530, Nishad Kamdar wrote:
> > On Fri, Nov 16, 2018 at 05:06:22PM +0100, Johan Hovold wrote:
> > > On Fri, Nov 16, 2018 at 08:47:44PM +0530, Nishad Kamdar wrote:
> > > > Use the gpiod interface instead of the deprecated
> > > > old non-descriptor interface.
> > > > 
> > > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > > ---
> > > 
> > > Always include a change log here after the cut-off line so we know what
> > > changed since previous versions.
> > > 
> > > Also include the patch revision in the Subject (e.g. "[PATCH v3]
> > > staging: greybus: ...").
> > > 
> > 
> > Ok, but this is the first patch version that I submitted
> > for greybus: arche-platform.
> 
> Ah, sorry. I thought this was an update of the arche-apb-ctrl patch.

Me too.

I am totally confused as to what is, and is not, the latest versions of
all of these patches :(

Nishad, can you resend all of your pending greybus patches, as a patch
series, as "v3" so that I know which to properly review?  I've dropped
all of your others from my review queue now.

thanks,

greg k-h
