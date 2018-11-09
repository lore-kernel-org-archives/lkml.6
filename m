Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B0C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D414F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4XU8ewW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D414F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeKJF3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:29:45 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34792 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeKJF3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:29:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so2714224otk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BKYMu4/Vja5epBBtzMUUa0Ap2qbn150hsVACybBjsFE=;
        b=F4XU8ewW1rZr2ayXyFj2C7Nw4nMxAgNS2492P2hE8nPgHU16av1XLPFewEt7fTsY+L
         HWKNvOiWZoikAo83W4sYZv7vSAJ2DebOlsWNWjljAXcz9Fr47qLSiAhyBXhUrIGJuJ5R
         WdnVX8eL4UaLNxSZ2aounOkTFAGuzyY36oJFgjQMW1/Fr9mxF7pP9478G4Q/VLEbeTVw
         QdF5QdmHX2ldmZsNlWmgXWwihmocnwpyVEqKJxg2WISO3vsxT6q3exxuu9vLdie0FIz3
         iuDQWXPg6IY+sTb5GHwDsEIXAILLs7oGFWB5VszR4jaCwSNM5lwoUU20kb/az83tdnGT
         wmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BKYMu4/Vja5epBBtzMUUa0Ap2qbn150hsVACybBjsFE=;
        b=kzAFmEFc+guzmDPPI5KFFpxAjJkvgdoJB9zpRwM6RJWk8UATS58hlZ+GAu4R51vGNc
         JAww4VNrVPR1tmp2HpzXruvLvQCJBBIVtv7Z1ztqJCl43O5CgIUmUp2RYmEaPTUU8Edf
         3PXCWoZ7DgZvefa3Y+Cr/vrcFmAWDz+v3xID7Ac19sYYOnytiA3fJzKC+H/sIlqhswY8
         ccqXeC51CMj6SlCEkTG8Gx5zO8Iq7kl/rpzgS64axeZWFrxnvT8M2XwpY68qlyflANzh
         SzmyNVTyhvSjeBeJyl7PGB0NcoEUqlhaC6BU/l5cLbcm1gbrrRZHX/fnyaKZFkI1SzEc
         bsMg==
X-Gm-Message-State: AGRZ1gIC9rJcdQVzH3zDgfb1YfQUxdL24gL7Ljm8rC5iIBYe7x4WD1vw
        ++77aKKfr7/2Gc4DPEyfkZI=
X-Google-Smtp-Source: AJdET5dEN8fCbw+u3gekFa6waPjZwHYzj0Nr7e/RszDKI8BNvwy0dxdn96bADD8WlAema3eu1E1p3Q==
X-Received: by 2002:a9d:645:: with SMTP id 63mr6397671otn.125.1541792861503;
        Fri, 09 Nov 2018 11:47:41 -0800 (PST)
Received: from simulacrum.agostinelli.home.saggio.net (cpe-66-68-97-1.austin.res.rr.com. [66.68.97.1])
        by smtp.gmail.com with ESMTPSA id u143-v6sm3690290oie.38.2018.11.09.11.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 11:47:40 -0800 (PST)
Date:   Fri, 9 Nov 2018 13:47:38 -0600
From:   "Darryl T. Agostinelli" <dagostinelli@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
Message-ID: <20181109194738.GA18649@simulacrum.agostinelli.home.saggio.net>
References: <20181105204000.129023-1-bvanassche@acm.org>
 <62188a351f2249188ce654ee03c894b1@AcuMS.aculab.com>
 <e44e6c8b-e4e4-e7cb-a5ca-88e9559eb0d7@suse.cz>
 <3c9adab0f1f74c46a60b3d4401030337@AcuMS.aculab.com>
 <60deb90d-e521-39e5-5072-fc9efb98e365@suse.cz>
 <9af3ac1d43bb422cb3c41e7e8e422e6e@AcuMS.aculab.com>
 <cbc1fc52-dc8c-aa38-8f29-22da8bcd91c1@suse.cz>
 <20181109110019.c82fba8125d4e2891fbe4a6c@linux-foundation.org>
 <b8ffd59b-0d15-9c98-b9ea-ad71e4c0c734@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ffd59b-0d15-9c98-b9ea-ad71e4c0c734@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:16:07PM +0100, Vlastimil Babka wrote:
> On 11/9/18 8:00 PM, Andrew Morton wrote:
> > On Fri, 9 Nov 2018 09:12:09 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:
> > 
> >> Multiple people have reported the following sparse warning:
> >>
> >> ./include/linux/slab.h:332:43: warning: dubious: x & !y
> >>
> >> The minimal fix would be to change the logical & to boolean &&, which emits the
> >> same code, but Andrew has suggested that the branch-avoiding tricks are maybe
> >> not worthwile. David Laight provided a nice comparison of disassembly of
> >> multiple variants, which shows that the current version produces a 4 deep
> >> dependency chain, and fixing the sparse warning by changing logical and to
> >> multiplication emits an IMUL, making it even more expensive.
> >>
> >> The code as rewritten by this patch yielded the best disassembly, with a single
> >> predictable branch for the most common case, and a ternary operator for the
> >> rest, which gcc seems to compile without a branch or cmov by itself.
> >>
> >> The result should be more readable, without a sparse warning and probably also
> >> faster for the common case.
> >>
> >> Reported-by: Bart Van Assche <bvanassche@acm.org>
> >> Reported-by: Darryl T. Agostinelli <dagostinelli@gmail.com>
> >> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> >> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> >> Fixes: 1291523f2c1d ("mm, slab/slub: introduce kmalloc-reclaimable caches")
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  include/linux/slab.h | 24 ++++++++++++------------
> >>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> index 918f374e7156..18c6920c2803 100644
> >> --- a/include/linux/slab.h
> >> +++ b/include/linux/slab.h
> >> @@ -304,6 +304,8 @@ enum kmalloc_cache_type {
> >>  	KMALLOC_RECLAIM,
> >>  #ifdef CONFIG_ZONE_DMA
> >>  	KMALLOC_DMA,
> >> +#else
> >> +	KMALLOC_DMA = KMALLOC_NORMAL,
> >>  #endif
> >>  	NR_KMALLOC_TYPES
> >>  };
> > 
> > I don't think this works correctly.  Resetting KMALLOC_DMA to 0 will
> > cause NR_KMALLOC_TYPES to have value 1.
> 
> Doh, right! Thanks for catching this.
> 
> This? Not terribly elegant, but I don't see a nicer way right now...
> 

How about the solution I proposed yesterday? 

https://lkml.org/lkml/2018/11/9/750

It doesn't involve any tricks. 

As it is, this sparse warning is begging for a trick. Let's not 
oblidge it to much.

