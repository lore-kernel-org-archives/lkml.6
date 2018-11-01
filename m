Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A136A20664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWa8EyKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A136A20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeKALM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:12:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40201 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKALM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:12:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id o14-v6so8266494pgv.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 19:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IWTITxQUs3mY/WFqqTf6Pi0VA0lAHGSuLhpSq+uGhog=;
        b=XWa8EyKG7iy2FlAeLJIG0rSkj1lwcDtmCvci+l9tb4DOLG5w9qYvIEs6MP01sNSrcy
         SndQd7kPzGIKpfOs3+yPXn6hoq01RXMcMceNDPzGC45V7ii5Gtyu0fieIbH7vOnPhwDq
         2bH3Fljrv/Qb5i8khQ2on7sTGayQrBIQIi/aW/Y3BuflNyccGhLgWL2sLmF81vBLplZs
         vsIVLn+SsDp4HgbD+ffNP+kSpaAWbD0px8MHeEG8N0vRLL27/dRM2yE+Tb6uHDp/zOEH
         5lnGQjn3aaJVbqnmfzYIexi6Vvza7E5ASBiAQOGbMNo3Zw65xID8hJ0WAxt4eClcjMRu
         fVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IWTITxQUs3mY/WFqqTf6Pi0VA0lAHGSuLhpSq+uGhog=;
        b=tO/Gy1p12YMgvAX2kGVaXPT43meUn8idFlFGHoEuR9lmXJNRztEnujcmIPdFVvav1Z
         M1bqoLcFrnerEMWYK31QXGNsYwBEK0fmV/TOIsEriYyZi1jealY46H7j1K6jqCqXiagm
         hrDpKUKxIpOJjzO+sRO+GIOT8sjkhPOaer1wHh61/u8BSel0Q0GgyucG/GqPWhz2fw8i
         c+lvwIIUADSAWq6+gwicUKvv6JqGG9m5kovb6ZGSclUU6t2kjnbgxXnkT9S+MMW028N+
         WgH6Dveqc5fEq5lVv92DXaMIVJVllarHkX3IG7r8L3NaBXKS5sbGsQMqtiZ/dSMNGKXz
         9Jdw==
X-Gm-Message-State: AGRZ1gJvl5EvmTa7U7YuJpwEFLVAlYCWVjV6lT1TX/p3TQMOeTnMXBfs
        p8wQgpV8IjM/7E3mNl40lAU=
X-Google-Smtp-Source: AJdET5e6GKP3z+Rnfrv0NWBn5ZRSx+luub/qggKtC75Y7ySH8K4aILo3VFhVi59KgVNqaVTDfvqfXw==
X-Received: by 2002:a63:8043:: with SMTP id j64mr5526132pgd.405.1541038326171;
        Wed, 31 Oct 2018 19:12:06 -0700 (PDT)
Received: from localhost (c-24-4-232-171.hsd1.ca.comcast.net. [24.4.232.171])
        by smtp.gmail.com with ESMTPSA id h128-v6sm4129648pfb.52.2018.10.31.19.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 19:12:05 -0700 (PDT)
Date:   Wed, 31 Oct 2018 19:12:03 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        cristian.marinescu@omicronenergy.com, Manfred.Rudigier@omicron.at
Subject: Re: [patch 8/9] posix-clocks: Remove license boiler plate
Message-ID: <20181101021203.6twk2pucmn42cu6z@localhost>
References: <20181031182107.726051323@linutronix.de>
 <20181031182253.385909804@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031182253.385909804@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 07:21:15PM +0100, Thomas Gleixner wrote:
> The SPDX identifier defines the license of the file already. No need for
> the boilerplate.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Richard Cochran <richardcochran@gmail.com>
> ---
> 
> @Richard: This file is (C) OMICRON, but I don't have a contact
> anymore. That Cochran dude is not longer working there :)
> 
> Do you have a contact? If so, can you please reply to this mail and Cc
> him/her.

@Cristian and Manfred:

We want to replace the license boilerplate with SPDX tags.  The file,
kernel/time/posix-clock.c, is copyrighted by omicron, and so we need
your okay.  All that is needed is a reply to this email with an
omicron Acked-by tag, like this:

Acked-by: Richard Cochran <richardcochran@gmail.com>

Thanks,
Richard

> 
> ---
>  kernel/time/posix-clock.c |   14 --------------
>  1 file changed, 14 deletions(-)
> 
> --- a/kernel/time/posix-clock.c
> +++ b/kernel/time/posix-clock.c
> @@ -3,20 +3,6 @@
>   * Support for dynamic clock devices
>   *
>   * Copyright (C) 2010 OMICRON electronics GmbH
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  #include <linux/device.h>
>  #include <linux/export.h>
> 
> 
