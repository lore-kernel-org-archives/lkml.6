Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD7621EA4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD7621EA4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934269AbeGFRwO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:52:14 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57678 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933775AbeGFRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:52:13 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 12277805-1500050 
        for multiple; Fri, 06 Jul 2018 18:51:00 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <48904284-14d7-45c2-cf41-0c0b311ccf7e@infradead.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20180706094458.14116-1-chris@chris-wilson.co.uk>
 <48904284-14d7-45c2-cf41-0c0b311ccf7e@infradead.org>
Message-ID: <153089946144.7594.5374061827926275070@cwilso3-mobl.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [PATCH] bitops: Introduce BITS_PER_TYPE
Date:   Fri, 06 Jul 2018 18:51:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2018-07-06 18:48:55)
> 
> On 07/06/18 02:44, Chris Wilson wrote:
> > net_dim.h has a rather useful extension to BITS_PER_BYTE to compute the
> > number of bits in a type (BITS_PER_BYTE * sizeof(T)), so promote the
> > macro to bitops.h, alongside BITS_PER_BYTE, for wider usage.
> > 
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Andy Gospodarek <gospo@broadcom.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > ---
> >  include/linux/bitops.h  | 3 ++-
> >  include/linux/net_dim.h | 1 -
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> > index 4cac4e1a72ff..091cb17d1a9b 100644
> > --- a/include/linux/bitops.h
> > +++ b/include/linux/bitops.h
> > @@ -11,7 +11,8 @@
> >  #define BIT_ULL_MASK(nr)     (1ULL << ((nr) % BITS_PER_LONG_LONG))
> >  #define BIT_ULL_WORD(nr)     ((nr) / BITS_PER_LONG_LONG)
> >  #define BITS_PER_BYTE                8
> > -#define BITS_TO_LONGS(nr)    DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> > +#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
> > +#define BITS_TO_LONGS(nr)    DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
> >  #endif
> >  
> >  /*
> 
> doesn't <linux/net_dim.h> need to #include <linux/bitops.h> ?

It already has to in order to obtain BITS_PER_BYTE. Just doesn't do so
directly.
-Chris
