Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C35C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B204B2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760252;
	bh=lygH+9IvdX+EVzvgoF0x5r7xux7js+JVyLHtNFF4oDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JU0WBkGWE6uF9yRmegujrsNPqAFQcLXdh6JbMqbCanlSQxGtlrEPygI/JDMyjbw5X
	 yxa8w65BzZTBpZaZTAffi+RynMsoDkJAZrOwgfNWUNjAtB/uFp40jTjCNDQ6YZ5aST
	 +W27xY/2rRkSKMNElCSGtHWbGbatAnGLx8y0MqUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfBUOoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729840AbfBUOoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:44:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737D920700;
        Thu, 21 Feb 2019 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760248;
        bh=lygH+9IvdX+EVzvgoF0x5r7xux7js+JVyLHtNFF4oDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1V8Od66LxZdNXyrOa9mJULNSrOOSIvdmpx8NDtP9YeDlLaVArx1+zN1IMT0jJHD7m
         66pSxKWM8j9LZWRdwG/vIHXCzy9P3KlSct4zJQCYqISkjpWk7WoT4P6pkpwKOYXLgQ
         I76MwBrUK+xrnQe2eLKIElzGtUZoTRvsyKkjq1bk=
Date:   Thu, 21 Feb 2019 15:42:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Zhi Jin <zhi.jin@intel.com>
Subject: Re: [GIT PULL 6/7] stm class: Fix an endless loop in channel
 allocation
Message-ID: <20190221144217.GB9283@kroah.com>
References: <20190221134959.15121-1-alexander.shishkin@linux.intel.com>
 <20190221134959.15121-7-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221134959.15121-7-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:49:58PM +0200, Alexander Shishkin wrote:
> From: Zhi Jin <zhi.jin@intel.com>
> 
> There is a bug in the channel allocation logic that leads to an endless
> loop when looking for a contiguous range of channels in a range with a
> mixture of free and occupied channels. For example, opening three
> consequtive channels, closing the first two and requesting 4 channels in
> a row will trigger this soft lockup. The bug is that the search loop
> forgets to skip over the range once it detects that one channel in that
> range is occupied.
> 
> Restore the original intent to the logic by fixing the omission.
> 
> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System Trace Module devices")
> Signed-off-by: Zhi Jin <zhi.jin@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

This should have a cc: stable in it, right?

thanks,

greg k-h
