Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5962145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545061496;
	bh=3Am+O8bzLsX4lIsKqURhb2ZJECS0Dx436+AH/N21rPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BkjVZC/C1DI8uHBtwFmHUp28gxKxYWrlswhiC30WMaaDu8G7a0FWp1xFzD2zWVHG/
	 mQIE6co9w8yxg8FZEO4+IysMoHDMYufE8EcgKjUrkMoljxI2rdSvDxIyu9K7uWl7cC
	 kZq0kymu/oEDypWlAGbeDvmXYCcbeEfdaPiSYJfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbeLQPo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:44:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733059AbeLQPoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:44:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3952133F;
        Mon, 17 Dec 2018 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545061495;
        bh=3Am+O8bzLsX4lIsKqURhb2ZJECS0Dx436+AH/N21rPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvErTHEpWe0SUJryIKhiE9oTwhlveJRcKB5qgtc262n6OWWG6BwlUjl0NsAM3PcPT
         ZJx6PYi5OVOZDUGDVKsFENWl4wFF6rkR3hAblUOXU+rS+2SfWFfMWWhp2Ewj+2KDwN
         VgP/LVcUzTbni2hTEIFD3c67+m4MLX/uaOM5IYZo=
Date:   Mon, 17 Dec 2018 16:44:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: uartps: Add the device_init_wakeup
Message-ID: <20181217154452.GA9844@kroah.com>
References: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
 <20181217151520.GA12453@kroah.com>
 <333f4be8-a4ae-4276-e2ac-725d1ae4c9b0@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <333f4be8-a4ae-4276-e2ac-725d1ae4c9b0@xilinx.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:29:56PM +0100, Michal Simek wrote:
> On 17. 12. 18 16:15, Greg Kroah-Hartman wrote:
> > On Wed, Dec 05, 2018 at 02:20:11PM +0100, Michal Simek wrote:
> >> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >>
> >> Initialise the device wakeup.
> > 
> > Why?  This says what happened, which you can see from the patch itself,
> > but it does not say why this is needed at all.
> 
> We will fix this.
> 
> > 
> > Also, you sent 4 patches, without any numbering, so I have no idea what
> > order to apply them in.
> >
> > Please fix the changelog entries up and send this as a patch series so
> > that I can correctly apply them.
> 
> They are all independent that's why I have sent them separately as
> single patches.

But when you modify the same file, how am I supposed to know that?

thanks,

greg k-h
