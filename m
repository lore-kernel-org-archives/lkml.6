Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C9C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8956206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK+acRoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8956206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeI2UBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 16:01:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41681 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeI2UBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 16:01:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3-v6so6392702pgv.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=umsEOXG6JnqgdRLKosFS2sGmU6Tmf0qSk9HRBZoFMeU=;
        b=QK+acRoLBxaGoBfxqnJTp1e2tVnUvhScyKSRrWHxeEUJP66q9Yl0QmarSYDc6UmgIA
         bnUOjDbVMGkmmdRMnQvbJVyyobrCHhp2YrvLLqnfOIHfafe01UDwJpd0y2jKazF5SZsn
         mv8ITJU08hLbWSDXHyuBL3dm7fpIHOw587JMZHurrzGKO5E7GeRWishi4mu3iVtAeIHG
         DYK/b2jrfBquUXZ6pOeM++aNKlvqXvWB88ow8EK16+ShLIN2ls3+l1lJF/RVMx8xtB8/
         bYTzrqplqGpo7IiTNKn3dsWfIPKmwybDh4h/TuU5QWns7BsZG4vGrZnCybZL1Cnp594x
         Iy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=umsEOXG6JnqgdRLKosFS2sGmU6Tmf0qSk9HRBZoFMeU=;
        b=th2qZOVaDYI4qJExfFhSxZrndF+WDX+2nT43f+V5Y3CKSd6vNYArIqQ3AVcdgBfqy3
         mY2rpVcZwB2f5UYs5QoVGEUb1662oJE1lbqc4HbliNVZFe1+C7r2xUGPNT0BlqewU1aw
         lR9SY6JRYU2vPqW//SfE7zhg31cSMT9PNi+jMgB2GbD765xoY32x2NqgScE9oN5icTJb
         nmQIu6WJIGgB1NcLnBMs6KPW3vIRlPHDmukUV3Pg5jl40Wd/Y8hwR3QoR+6mZskNQwfH
         qGiPgWzcZEhItuGDV/PKZADdnkaX3KdYqIvexTigC7uHpFKAaHXuw+VUEj7kSyGkNjU5
         8woQ==
X-Gm-Message-State: ABuFfoi9S0ggPIxCHWQcAA4ven8W3bMuWb6ZQQO+rEI2A2kjMeGhejTb
        3mohIVs7K2zpCNXY9xj7k28=
X-Google-Smtp-Source: ACcGV60+qz5iJMKTpFX2ZKLeEofXe3kli592uFYPJEn/lmdlvLn4VHzPyHnmgH3fc2ZxXp7DWky/0Q==
X-Received: by 2002:a17:902:b78c:: with SMTP id e12-v6mr3272243pls.67.1538227970504;
        Sat, 29 Sep 2018 06:32:50 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id h63-v6sm10483866pge.48.2018.09.29.06.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 06:32:50 -0700 (PDT)
Date:   Sat, 29 Sep 2018 19:02:43 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3] staging: mt7621-mmc: Remove #if 0 blocks and fix
 macros in sd.c
Message-ID: <20180929031708.GA4120@nishad>
References: <20180927154053.GA3526@nishad>
 <20180928123025.GA26516@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928123025.GA26516@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 02:30:25PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 27, 2018 at 09:10:57PM +0530, Nishad Kamdar wrote:
> > This patch removes #if 0 code blocks and usages of the
> > functions defined in the #if 0 code block. It removes
> > the macro msdc_irq_restore() and replaces its usage
> > with call to the function called in the macro definition.
> > Issue found by checkpatch.
> 
> When you have to start listing all of the different things your patch
> does, that's a huge hint it needs to be broken up into smaller pieces.
> 
> Please make this a patch series, only doing on "logical" change at a
> time.  You are doing too many different things here all at once.
> 
> thanks
> 
> greg k-h

Ok I'll do that.

thanks for the review.

regards,
nishad
