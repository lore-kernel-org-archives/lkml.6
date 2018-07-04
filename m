Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7976C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534502445F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj87bv7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534502445F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeGDHXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:23:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40137 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbeGDHXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:23:13 -0400
Received: by mail-pl0-f67.google.com with SMTP id t6-v6so2252520plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5vRPln3MDD8qIV2NgCozI2vEnYPvdcO3bw2YELlV6k=;
        b=bj87bv7GuKayHQTNs7sADTJuz4mwW4E3A1UsFF4JMpvUXgBuCnn5JSxJFYjsrv4hnc
         6tTgwwSxmiwgnUxUdmdUaD29rMKU6RjXi1dIqsGRxNxT/f2gk7ld739/TK0ocFKtB+zj
         nW3sUrop3H79g0+ssKYM9NdcIqSGH0KK3vhzruGYSX882IzSgzSYMPIhIU/VO+vttz0Q
         6ZJ36/TNTaF2k3BF+y8yGHM2mLlSAcQdu8BHHfX+k+dMC8fuuKvq+1GLYZAdbEm2bUxF
         DvzZG7ljd1X2T/RnX1M19BKEewA4lRkYZTlHLpXFRrShUg7D8ANcwfRuGXi3CugNRQzp
         2lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5vRPln3MDD8qIV2NgCozI2vEnYPvdcO3bw2YELlV6k=;
        b=JLbgwgt/0Advkh72TLOY68moKD3Mp5l8j/wIr10RSMXVPGgvVHD8NC42TtUTI/gXEG
         AVfgzmiGUVdB61OmI/eiTqN1S3jBDiMKkflfLCqDGuFAYgKXXZeHkx1Z6zVg96hD4Jdn
         gBB39Xez3uAprVQMSyqjaczh2rc9eihHymCBcawVemOQPIPVJHQqXfL6OMRH9lKRasZa
         /7H3ciYNnjvQe64uQLr53CMqlOEdsQDoW+3nNugFBl+rkQ5wkx9kK2DPKQExibcj1ttP
         ldjihAqNPCs0wgBOr/IDbl6Fr+AkcdNrhQZT0QfqDjQf7sGlqAa8k87iUDAhI3bVLKX6
         SZJg==
X-Gm-Message-State: APt69E2Nvsfe82lJwAG+h/KS9ryDZVpU5v8TSRZfAg65RemQC78T0RHb
        2IU7aZ5/QyiEPUqOR1eVK/0=
X-Google-Smtp-Source: AAOMgpdXnuD9Dn9uPVxYVL/YZOBX7XQClWVZRCOz+XH78QvMGXJnrceBVg8BIzEwBwKIXtTjNMHX8A==
X-Received: by 2002:a17:902:112b:: with SMTP id d40-v6mr968169pla.123.1530688992965;
        Wed, 04 Jul 2018 00:23:12 -0700 (PDT)
Received: from localhost ([175.223.14.150])
        by smtp.gmail.com with ESMTPSA id y22-v6sm9239234pfi.166.2018.07.04.00.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:23:11 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:23:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
Message-ID: <20180704072308.GA458@jagdpanzerIV>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
 <063c785caa11b8e1c421c656b2a030d45d6eb68f.camel@perches.com>
 <20180704070305.GB4352@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704070305.GB4352@rapoport-lnx>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/04/18 10:03), Mike Rapoport wrote:
> > %p[Ff] got deprecated by commit 04b8eb7a4ccd9ef9343e2720ccf2a5db8cfe2f67
> > 
> > I think it'd be simplest to just convert
> > all the %pF and %pf uses all at once.
> > 
> > $ git grep --name-only "%p[Ff]" | \
> >   xargs sed -i -e 's/%pF/%pS/' -e 's/%pf/%ps/'
> > 
> > and remove the appropriate Documentation bit.
> > 
> 
> Something like this:
> 
> From 0d3e7cf494123c2640b9a892160d2e2430787004 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Date: Wed, 4 Jul 2018 09:55:50 +0300
> Subject: [PATCH] treewide: retire '%pF/%pf'
> 
> %p[Ff] got deprecated by commit 04b8eb7a4ccd9ef9343e2720ccf2a5db8cfe2f67
> ("symbol lookup: introduce dereference_symbol_descriptor()")
> 
> Replace their uses with %p[Ss] with
> 
> $ git grep --name-only "%p[Ff]" | \
>   xargs sed -i -e 's/%pF/%pS/' -e 's/%pf/%ps/'


Sorry, NACK on lib/vsprintf.c part

I definitely didn't want to do this tree-wide pf->ps conversion when
I introduced my patch set. pf/pF should have never existed, true,
but I think we must support pf/pF in vsprintf(). Simply because it
has been around for *far* too long. People tend to develop "habits",
you know, I'm quite sure ppc/hppa/etc folks still do [and will] use
pf/pF occasionally.

	-ss
