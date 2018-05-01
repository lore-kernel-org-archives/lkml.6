Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755539AbeEANWP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:22:15 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33126 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754243AbeEANWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:22:14 -0400
X-Google-Smtp-Source: AB8JxZpIhfoxcRYYuStK3x2mKF4hfL4GHwfYkzbIeCROPw6quHG39gUgM5Sjy/YAO2AWmKDJykpqag==
Date: Tue, 1 May 2018 14:22:11 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180501132211.GN5147@dell>
References: <20180501094553.31545-1-lee.jones@linaro.org>
 <54e604bd-61cd-63a8-1d35-864137a5b19a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54e604bd-61cd-63a8-1d35-864137a5b19a@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 May 2018, Robin Murphy wrote:

> On 01/05/18 10:45, Lee Jones wrote:
> > The COMP1 and COMP2 elements are in 0 and 1 respectively so this code is
> > accessing the wrong elements and one space beyond the end of the array.
> > 
> > The "id" variable is never COMP (0) so that code can be removed.
> > 
> > Fixes: 6851ad3ab346 ("TPS65911: Comparator: Add comparator driver")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > 
> > History:
> > 
> > Dan was the originator of this patch and the author of the commit log,
> > but produced 2 code solutions which I wasn't happy with.  The first
> > submission [0] introduced a COMP device, which after a quick check of
> > the datasheet [1] appeared to be fictitious.  A subsequent submission
> > [2] conducted arithmetic in array indexes.
> > 
> > It is my belief that the correct solution is to roll which the
> > situation the hardware engineers presented us with and define COMP1
> > at position 0 and COMP2 at position 1 such that we can use the
> > simplest code possible to select them.
> > 
> > Dan wasn't happy to put his name to this, which I completely
> > understand.  Calling SOMETHING1 0 (zero) is a little unnatural.
> > 
> > However, since I have no shame, I offered to submit it.
> 
> As an idly-curious passer-by, this looks perfectly reasonable to me - I
> don't see why a mapping between names and indices should have to be
> artificially constrained just because the names happen to contain numerals.

Right.  This was my thinking too.

> If it's really that abhorrent, then I guess they could be named something
> like COMPn_ID for even more clarity.
> 
> That said, now that I've gone and looked, the whole business seems
> ridiculously over-engineered. AFAICS it would be infinitely simpler to just
> pass the register address directly where id is currently passed, statically
> define UV_MAX, and get rid of the otherwise-pointless struct comparator
> entirely. The current abstraction doesn't look like it could actually scale
> to support different chips without major surgery anyway.

Sounds good.  Patches always welcome. ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
