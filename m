Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C787FC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D55B206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="hZRfvpFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbfAKTuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:50:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38680 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbfAKTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:50:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so7198894plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0RFvRSspj+TM4g9ZH1f9G6S3gOP73svoJzOPEnPv5t4=;
        b=hZRfvpFiL2GFU82hHdSqFcK7EDlD4eK85iHJyYQGf5ujdr1FylIalh7HkQKIgGLrkg
         tlEWyLmOAA5FCqjK1hPlrLI+JAa6U6Rq7fbsrXsU4k6MdBmju3TinXCTsSmlEPx9Xzm3
         El/+m5sQbuU6hIcKlC5YORmVoCFRMijjxAr1GH0OS/l/+58MbGFeLKxeOMTq1R6Th2vH
         84ypOYOkgSbg9toO+zu+U4z3IbqQ6inTF15sQ2INGGIK5C/lTnx5HUCosW3s5BE0QHQG
         JYdH+/E3C9d61Cs8Hv6KU+gfQblKSrvXY15ZolK78uJ04uQFjRrGwIXBOaGZ1VQF/eG3
         ocCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0RFvRSspj+TM4g9ZH1f9G6S3gOP73svoJzOPEnPv5t4=;
        b=kmA5HysULHh5KXH5byMl86B+A+bv7zUkhpId+AwIEEfjjeJQtgXnvtNa/ffINz1Xbe
         4xzycqTtPSZ4HWYzBj1cHQ2JN5aEfn3wWvruiwCt+O017vzPOYoN/uyBaCE/LJgBBVLS
         iTFGLwYJHdkDYBgl8WeyKa3Kw7WHbHt07/mscAv7Wfa104QWjoOvOcnbOTFvpymo38IN
         HogK8OkIe6upjfL0kQOt3mt0t5nXwDRDWa4+1sMfKbRxrYTZoA8EXZftewvjbGj31797
         FHSO4MdzSmQe5JGjpOo4+1w0AsBVz5tkHU8eAutHc3GEbyPqVk4S8H6onhRsYnt3GCm6
         NYOA==
X-Gm-Message-State: AJcUukc6L8PT56DdtA1VERxbXdIreKTATgCSdDT5hvxMO5DhrexD+T8K
        KclNao+k7Gv8ieFbrAg6BDloOQ==
X-Google-Smtp-Source: ALg8bN5wvfpPxQ/tEkSZlfxL11J7jcZkxXuw/qimHLz/58x/qBrlLyEIqJLrf0gl0AMo3jTY+P7f6w==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr16205516plk.282.1547236241206;
        Fri, 11 Jan 2019 11:50:41 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c69:9cc7:f9cf:ff1b])
        by smtp.gmail.com with ESMTPSA id w23sm36179695pgc.72.2019.01.11.11.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:50:40 -0800 (PST)
Date:   Fri, 11 Jan 2019 12:50:37 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, jsteckli@amazon.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, liran.alon@oracle.com,
        keescook@google.com, konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v7 07/16] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190111195037.GH4102@cisco>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
 <eba179acbfdea5a646c5548cb82138c1c3b74aa2.1547153058.git.khalid.aziz@oracle.com>
 <20190111145445.GA4102@cisco>
 <19e61a22-bbae-d0ae-8d41-158d4b46bf01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19e61a22-bbae-d0ae-8d41-158d4b46bf01@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:28:19AM -0700, Khalid Aziz wrote:
> On 1/11/19 7:54 AM, Tycho Andersen wrote:
> > On Thu, Jan 10, 2019 at 02:09:39PM -0700, Khalid Aziz wrote:
> >> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> >>
> >> If the page is unmapped by XPFO, a data cache flush results in a fatal
> >> page fault, so let's temporarily map the region, flush the cache, and then
> >> unmap it.
> >>
> >> v6: actually flush in the face of xpfo, and temporarily map the underlying
> >>     memory so it can be flushed correctly
> >>
> >> CC: linux-arm-kernel@lists.infradead.org
> >> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> >> Signed-off-by: Tycho Andersen <tycho@docker.com>
> >> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> >> ---
> >>  arch/arm64/mm/flush.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
> >> index 30695a868107..f12f26b60319 100644
> >> --- a/arch/arm64/mm/flush.c
> >> +++ b/arch/arm64/mm/flush.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/export.h>
> >>  #include <linux/mm.h>
> >>  #include <linux/pagemap.h>
> >> +#include <linux/xpfo.h>
> >>  
> >>  #include <asm/cacheflush.h>
> >>  #include <asm/cache.h>
> >> @@ -28,9 +29,15 @@
> >>  void sync_icache_aliases(void *kaddr, unsigned long len)
> >>  {
> >>  	unsigned long addr = (unsigned long)kaddr;
> >> +	unsigned long num_pages = XPFO_NUM_PAGES(addr, len);
> >> +	void *mapping[num_pages];
> > 
> > Does this still compile with -Wvla? It was a bad hack on my part, and
> > we should probably just drop it and come up with something else :)
> 
> I will make a note of it. I hope someone with better knowledge of arm64
> than me can come up with a better solution ;)

It's not just arm64, IIRC everywhere I used xpfo_temp_map() has a VLA.
I think this is in part because some of these paths don't allow
allocation failures, so we can't do a dynamic allocation. Perhaps we
need to reserve some memory for each call site?

Tycho
