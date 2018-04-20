Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeDTIjP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:39:15 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:43945 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753918AbeDTIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:39:13 -0400
X-Google-Smtp-Source: AIpwx4/46dPh0DlP5s2tmH3GNV8Rf6hA31Pr/lnVPUNX0SykqoF4NKvMGRpfWpJDd4lsYiG98kyVmg==
Date: Fri, 20 Apr 2018 09:39:09 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: tps65911-comparator: Fix an off by one bug
Message-ID: <20180420083909.66a6t63s5q6vpwp7@dell>
References: <20180419134634.GA19793@mwanda>
 <20180420080943.jdbf7vtnkc33vbvd@dell>
 <20180420082150.u2oovqr4b4fd6vrq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420082150.u2oovqr4b4fd6vrq@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018, Dan Carpenter wrote:

> On Fri, Apr 20, 2018 at 09:09:43AM +0100, Lee Jones wrote:
> > On Thu, 19 Apr 2018, Dan Carpenter wrote:
> > 
> > > The tps_comparators[] array is used in two places.  We only access the
> > > COMP1 (1) and COMP2 (2) elements.  Unfortunately, we're accessing the
> > > wrong elements and also one element beyond the end of the array.  There
> > > was supposed to be a zero element at the start of the array which is
> > > isn't accessed but makes the math work out nicely.
> > 
> > I normally just apply patches from you, but this is a hack, right?
> 
> I liked it, I thought it was nice.  It uses 32 bytes but any fix was
> going to use *some* memory.  I don't have strong feelings about it
> though, if you want to write a different patch I can do that instead.

#define COMP                                    0
#define COMP1                                   1
#define COMP2                                   2

It's unclear what the defines mean, but if COMP really does exist (is
there a datasheet for this device?) then your solution is a suitable
one.  However, if there is a COMP, then why isn't it used?

If it doesn't actually exist then this would be more appropriate
change I think:

#define COMP1                                   0
#define COMP2                                   1

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
