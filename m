Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C86C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B13821736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5J6CgjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbfBROec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:34:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42443 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387866AbfBROea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:34:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so2833342pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UO28q0o4LdLM2x/aMQOHpgFb3OecMY5DuadUDq1BpVA=;
        b=f5J6CgjW+J8BzyHg9H0XytNOOzRVyFxgm1snak3AEMpjfWzhdIen6JbsKchvuYvbhN
         sGiv9OctSKwF7NEQtPAV5I9fVCj9CBZVYXUBqN01/WstP7zxygC+IE+6QxD0zYOplhrI
         jtFTcnusv/TrYo6TmT1XjYDz7ZAoJ8Uu+uRDymTzWdwyTbQ0Z7E6sujytBKCeuu8aNYD
         6/FE2NTCBPUc2ufHk1WlV/mHltcYPqKaLexYABr4ybMMXOEwcTYAr7KzkfFn2AbP2YZ1
         9FZGhSQylrLCXs64UoXEzw9z92ceumKBmCoklHvlI8/rzXs20R0V4s6tsEWa5YJ/fJQN
         WNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UO28q0o4LdLM2x/aMQOHpgFb3OecMY5DuadUDq1BpVA=;
        b=aVPf+FwGvF4D1yffSdH2pt2hW3/kCi9QplPWql0yyQlgLq53FPl5UsEGC4PXEe0VGS
         ULNbcMVhat6Ip4UYbKD2amCJIbYnePHbE7+NuCcoQcQUcguRnZ9w5RHzx1e4dYX3q58u
         pUGYIPMB+GEvHq34Xkdcqo06yDzQYfhhWTCqmHIILV89IplcOuPTRPOP3ai+yGT3GSAJ
         OoDbLHYutPqqs12dVQgkqXdAIM7e/h/5DOIn4FLdHvTk1xw20/MK08azsOdKZfanCymD
         KTpHGhr2OaEs3TDk8hNtSQ18mwspVDJOJcstIAkNeEqpuEDyD5gWBKrZL/9b4aQThH4W
         D4AA==
X-Gm-Message-State: AHQUAuZTHZZq+Jm1WiNJk4YGD3m2PQPqor5EjDbaqWLwMrLXrVJTz5ti
        AmxQmp6ADaWVVvEvHm9JVqtgo8Vq1Ls=
X-Google-Smtp-Source: AHgI3IZiS5j4gUR7VkEVsWf2wVvEY7k+oYe5vdnQSwtyLVCeIbLdHR19hvyPeD+t02VOiaibBfe7qw==
X-Received: by 2002:a63:5b65:: with SMTP id l37mr19304031pgm.395.1550500469536;
        Mon, 18 Feb 2019 06:34:29 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id t3sm14905559pgp.5.2019.02.18.06.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 06:34:28 -0800 (PST)
Date:   Mon, 18 Feb 2019 20:04:22 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use the correct style for SPDX License Identifier in all
 header files across the kernel
Message-ID: <20190218143420.GA4243@nishad>
References: <20190216103356.GA10673@nishad>
 <20190216194507.GA10104@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216194507.GA10104@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 08:45:07PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Feb 16, 2019 at 04:04:02PM +0530, Nishad Kamdar wrote:
> >  816 files changed, 970 insertions(+), 970 deletions(-)
> 
> You have to break this up into subsystems at the very least, no one
> person can take this patch, sorry.
> 
> greg k-h

Ok, no problem. I'll do that.

Thanks for the review.

Regards,
Nishad
