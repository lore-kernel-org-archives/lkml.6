Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B59220840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="k305i34X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B59220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeKJJyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:54:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41644 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbeKJJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:54:17 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so4761588qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 16:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J5Jvj73F2OJxF8pYqHlzYl8k/fLkRvGWTuiq9gfQ9SQ=;
        b=k305i34XHAzBF/fXeIjdUMxlXdKD/NLhksmeRQvwjynJvjtcGV4uTxe2HXS8yDSJjR
         n8tFFzTekbIW+xql2fhwSdKq4tFjRfKlsVvRpGtzdHHlCsAm6XdN+VTSPnyZwN0W5MwB
         Rcq7/eP9PXm9B975gNngeEU8rU6eBDTGuTzrX6EvuvPC2gC1LMbrswvVz6uWxeH3EJPq
         n4Yt1u+HejCzvE1SLyPFEGVM3B7RZHJgB8GBHaLGM04OhBcieWRZ8Gvqa1MKoOR6h7jL
         cL/dU4Ul1iKMl0qZCDsKtThwheX11RL73I37n8dxyx/2l5qHDclEOYhhVrE7waKOvCig
         2vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J5Jvj73F2OJxF8pYqHlzYl8k/fLkRvGWTuiq9gfQ9SQ=;
        b=nzlT0vVAKcw0g2rta0S7912Y3Wrbo6jZt7cNw93nu7ofd6/RtRnjGfTZ4lUF2JnOOL
         c9w2umtwz9+zISdbxdLPS0KlqG6QYUCde4UXhjTD/0o2CW/2iiQ47gEGlxBjA2miF8Qh
         +oonU0RCmCa9Odpawkw55SBIkpdF9eIGfj62278P6ooxYBF1vTEJGWr94XkvQvA40Npr
         KkJw8BFVXYAZjRPWm83vG8bICPK9mgEf83DXOwH/TxIGMBAsjC4bfQyxuLXtCRHZ7AvV
         j90aCAyk5to+7CyXJEePlqz+83LkgYVci997s1ytbJ+Ap7JHyCmYZcw+083bqsXeiifg
         niaw==
X-Gm-Message-State: AGRZ1gLoCUrtIIEHZaE0J+sT0WAXxPW8pYI9lpNNrqJKH3fegjp060L9
        4BahXMJjSKOow0kpQ7/bgXm/EQ==
X-Google-Smtp-Source: AJdET5c3yY2JgI0+1l2l/dhmr5z5k/2uvrtyy2nXRPzQPpRyM3kSu8vDmg4956Hr333u5onn7Ed7Ow==
X-Received: by 2002:ac8:74d7:: with SMTP id j23mr10841803qtr.369.1541808679457;
        Fri, 09 Nov 2018 16:11:19 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u199-v6sm4844999qka.47.2018.11.09.16.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 16:11:18 -0800 (PST)
Date:   Fri, 9 Nov 2018 19:11:16 -0500
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 3/7] mm: Implement new zone specific memblock
 iterator
Message-ID: <20181110001116.gtg7vxz2erbrnxc2@xakep.localdomain>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <154145278071.30046.9022571960145979137.stgit@ahduyck-desk1.jf.intel.com>
 <20181109232654.bi37bdkrqbogbdcx@xakep.localdomain>
 <d511ee6a18da13b9543557db783e6ff3327ca87b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d511ee6a18da13b9543557db783e6ff3327ca87b.camel@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +		unsigned long epfn = PFN_DOWN(epa);
> > > +		unsigned long spfn = PFN_UP(spa);
> > > +
> > > +		/*
> > > +		 * Verify the end is at least past the start of the zone and
> > > +		 * that we have at least one PFN to initialize.
> > > +		 */
> > > +		if (zone->zone_start_pfn < epfn && spfn < epfn) {
> > > +			/* if we went too far just stop searching */
> > > +			if (zone_end_pfn(zone) <= spfn)
> > > +				break;
> > 
> > Set *idx = U64_MAX here, then break. This way after we are outside this
> > while loop idx is always equals to U64_MAX.
> 
> Actually I think what you are asking for is the logic that is outside
> of the while loop we are breaking out of. So if you check at the end of
> the function there is the bit of code with the comment "signal end of
> iteration" where I end up setting *idx to ULLONG_MAX, *out_spfn to
> ULONG_MAX, and *out_epfn to 0.
> 
> The general idea I had with the function is that you could use either
> the index or spfn < epfn checks to determine if you keep going or not.

Yes, I meant to remove that *idx = U64_MAX after the loop, it is
confusing to have a loop:

while (*idx != U64_MAX) {
	...
}

*idx = U64_MAX;


So, it is better to set idx to U643_MAX inside the loop before the
break.

> 
> > 
> > > +
> > > +			if (out_spfn)
> > > +				*out_spfn = max(zone->zone_start_pfn, spfn);
> > > +			if (out_epfn)
> > > +				*out_epfn = min(zone_end_pfn(zone), epfn);
> > 
> > Don't we need to verify after adjustment that out_spfn != out_epfn, so
> > there is at least one PFN to initialize?
> 
> We have a few checks that I believe prevent that. Before we get to this
> point we have verified the following:
> 	zone->zone_start < epfn
> 	spfn < epfn
> 
> The other check that should be helping to prevent that is the break
> statement above that is forcing us to exit if spfn is somehow already
> past the end of the zone, that essentially maps out:
> 	spfn < zone_end_pfn(zone)
> 
> So the only check we don't have is:
> 	zone->zone_start < zone_end_pfn(zone)
> 
> If I am not mistaken that is supposed to be a given is it not? I would
> assume we don't have any zones that are completely empty or inverted
> that would be called here do we?


if (zone_end_pfn(zone) <= spfn) won't break

Equal sign in <= here takes care of the case I was thinking. Yes, logic looks good.

Thank you
Pasha
