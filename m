Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5761C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8347C20847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASXI/vc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8347C20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933449AbeGDJnx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:43:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37522 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932745AbeGDJnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:43:49 -0400
Received: by mail-pg0-f66.google.com with SMTP id n15-v6so2284573pgv.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n4nobLy10JvLo8uKhE4ZaAMSAxViYnZzUNnRho1AQfM=;
        b=ASXI/vc2AQpsvu2GYQwo5sMFVK3VXjF/TcAufZ5B+FO7/NzFx3yzUqNqsHIb4mHAAm
         9CbHLHAFhd75jtgNQwCC/KCkahCgALsBOdb+gUZnKgTT9r5tTgwX8pTKnKg5XgSby18U
         ujKM9DYjWYQbOmHRitGFerpvNrhUUHAzP/o/aqJBdrORnmWJA1PwDCG4ltk94RwQP9TW
         3Osr692FGi+PwCTBAQNGsKtb48zKug/wTlIGqhRRPES/OM9+ESrEerQDCXQ2SXJBE8+0
         TOgYKW2IGWjM9dX5ou+TONugfizig1zfFgAq/5HI+M47NH+EKhz6+QMvhMRAfZpTe692
         a3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n4nobLy10JvLo8uKhE4ZaAMSAxViYnZzUNnRho1AQfM=;
        b=FGH0LkvExIUj0TIs4YyMC5Urx5op+DqCIAidstwAU9FW4si3JbEReEUSwRi+wsU1gM
         rLEGQd6BntskiYuCTN2furwSgOov9O9KG8hPzX57+a/ALw4jGjw2N5vkkxaN0myFySdO
         9LcfbLdzijtO0iLEAW+cSCluUaO01kfCOL0ypgycQ54Htca1IISK+6F5bZ9/NNuCki+R
         ifhsUnNyZe+SxgcOQ/iLWx2aKD3YO+l6S9aM8nyYQhFY95UWW2tZkxyKM9Z9ev2y25IO
         0BRPH8woH4fruLnlIDWx6R2km605c6jgxHli+7LP0Abc+k5zw1zLkJLKZkfQtGLmpXWa
         K04g==
X-Gm-Message-State: APt69E3kX0oE58tEPR/ZWbZ6ETiua2g/dfn3tYaMJ3lQYXR6Fy4hDQFX
        Zcm5RbZLK2Vgt/2N8fwFqC4=
X-Google-Smtp-Source: AAOMgpd/1Y6aAD8hy+IjNQK29YXoLlD6OHfhUa9xw+zMzd00AOEIKwhwFmIo8anx4TfXWc2zwOkgdA==
X-Received: by 2002:a62:9c17:: with SMTP id f23-v6mr1404186pfe.209.1530697429362;
        Wed, 04 Jul 2018 02:43:49 -0700 (PDT)
Received: from localhost ([175.223.14.150])
        by smtp.gmail.com with ESMTPSA id m86-v6sm7710428pfi.47.2018.07.04.02.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 02:43:47 -0700 (PDT)
Date:   Wed, 4 Jul 2018 18:43:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
Message-ID: <20180704094344.GD458@jagdpanzerIV>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
 <063c785caa11b8e1c421c656b2a030d45d6eb68f.camel@perches.com>
 <20180704070305.GB4352@rapoport-lnx>
 <20180704072308.GA458@jagdpanzerIV>
 <8dc61092669356f5417bc275e3b7c69ce637e63e.camel@perches.com>
 <20180704092042.GC458@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704092042.GC458@jagdpanzerIV>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/04/18 18:20), Sergey Senozhatsky wrote:
> > There's this saying about habits made to be broken.
> > This is one of those habits.
> > 
> > I'd expect more people probably get the %pS or %ps wrong
> > than use %pF.
> > 
> > And most people probably look for examples in code and
> > copy instead of thinking what's correct, so removing old
> > and deprecated uses from existing code is a good thing.
> 
> Well, I don't NACK the patch, I just want to keep pf/pF in vsprintf(),
> that's it. Yes, checkpatch warns about pf/pF uses, becuase we don't want
> any new pf/pF in the code - it's rather confusing to have both pf/pF and
> ps/pS -- but I don't necessarily see why would we want to mess up with
> parisc/hppa/ia64 people using pf/pF for debugging purposes, etc. I'm not
> married to pf/pF, if you guys insist on complete removal of pf/pF then so
> be it.

And just for the record - I think the reason why I didn't feel like
doing a tree wide pf->ps conversion was that some of those pf->ps
printk-s could end up in -stable backports [sure, no one backports
print out changes, but a print out can be part of a fix which gets
backported, etc]. So I just decided to stay away from this. IIRC.

	-ss
