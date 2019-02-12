Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EB8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20622083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549957918;
	bh=h89bIy1gGz7dIVCWOHNe045YFf+I4lu0bKInGIHUIb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oVm8PET6TnZOITR/5O1Jbf5IR1wRQopAo5SH3S99LPN8txaEyReScVaccIWNvu/iw
	 vP8xTiFK6kg1Pu0SLoTUH6h5vsgJgCFys27JMDxMFC1CYPwM7GROUuz/ZDQd8RDnYK
	 H7hB8bT7OniBY8FxrTndyZrCHHRr3hBqj+hDuom0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfBLHvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfBLHvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:51:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8A1206BA;
        Tue, 12 Feb 2019 07:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549957914;
        bh=h89bIy1gGz7dIVCWOHNe045YFf+I4lu0bKInGIHUIb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IiaCK30Wb20+z9z3x+HNzTWJ+3hN9Z2BL3isJkjAKhYKVEJq1J0wm/4nFWo2LVYxY
         TMSFRvCl01kWyVR5SJFhctqGnMGRn/TVLNNmIwRcDHc2o7JajtsV+kQGudkoTndeqq
         t/qfUzXiu9FrjHwhEA8jJhoySordsk2fc13WV6gA=
Date:   Tue, 12 Feb 2019 08:51:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC: drop ISA support in the synlink tty driver?
Message-ID: <20190212075151.GA7588@kroah.com>
References: <20190211132534.29407-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211132534.29407-1-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:25:33PM +0100, Christoph Hellwig wrote:
> Hi Greg and Jiri,
> 
> I've been working hard to get rid of the remaining callers the pass a
> NULL struct device to the DMA mapping functions and am almost done.
> 
> The only non-trivial driver is the synclink driver, which has legacy
> early 90s style ISA support that doesn't use the device model at all.
> 
> In theory we could convert it to an isa_driver, but without testing
> that seems rather dangerous.  So for now I would suggest that we
> remove the ISA support in this driver - if anyone cares enough we
> can resurrect it from the git history and convert it to use the driver
> model.

No objection from me at all, I'll go queue this up now, thanks.

greg k-h
