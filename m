Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967159AbeEYQWN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966854AbeEYQWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:22:12 -0400
Date: Fri, 25 May 2018 18:21:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Schmaus <flo@geekplace.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] driver-core: return EINVAL error instead of
 BUG_ON()
Message-ID: <20180525162154.GA20197@kroah.com>
References: <20180516160816.20251-1-flo@geekplace.eu>
 <20180523155913.29679-1-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523155913.29679-1-flo@geekplace.eu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 05:59:10PM +0200, Florian Schmaus wrote:
> This patch series makes driver_register() emit an error message and
> return a failure code instead of triggering a BUG_ON().
> 
> The first patch will cause driver_register() to fail gracefully if the
> driver's bus was not initialized while printing out the name of the
> faulty driver *and* the name of the involved bus. The second patch
> records the error code if bus_register() fails. The third and final
> patch of the series extends the first patch so that the recorded error
> code is also print out if non-zero. Otherwise, if drv->bus->p is NULL
> but the error code is zero, then probably bus_register() was never
> called before.
> 
> Greg questioned [1] whether [2/3] and [3/3] are necessary:
> 
> > And really, when has this ever happened?  Why would a bus registration
> > fail and later allow a driver to be registered?
> 
> I initially assumed that this is what cause me hitting the BUG_ON()
> which [1/3] replaces: The bus registration failed and then the driver
> attempts to register itself. But I did not had a chance to verify
> that. I'll try to do so after my vacation. Meanwhile I hope that at
> least [1/3] is considered an improvement of the kernel. If so, feel
> free to pick it up.

I've picked up patch 1, I don't think patches 2 or 3 are needed, due to
the extreme unfrequency that this problem ever happens :)

thanks,

greg k-h
