Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6077AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D10A20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U4iDE/zN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D10A20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeKJPae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:30:34 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38585 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeKJPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:30:33 -0500
Received: by mail-qk1-f195.google.com with SMTP id d19so5460178qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 21:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GZrRQNmc0CcAEYibhaFhftqFXp9A9dpxYkqN60c2KB8=;
        b=U4iDE/zNfXmY6syeyS3bJfbta4+pnFrIPPX9j+/37TqKWEq3b6hyVPRQz8du9ESUBF
         BUP0bY9JaL+W+Sbfu6neyjvBTyP3XhHcLfF1AgV/rW2LSGiEi0WLmUWWOOyiOEKab/e5
         +qpcqo8v4Mav8RKQY9Dbvjig2tKMB5qidnkugLyQBqfvw6a0xgNRvt4Q1iIb5m4CGzYB
         FL56oxVfwBjxjSfrw/6QBMTZx6cJPVtZ1gKop+NKjkZ8zzJUV0J4TBlwm803d5uvFtQp
         6PhcZUlgIM+mGQwLQ7NEHX13lMBAehmKch+hui++616aMHvEeGsD+cOqInLobR2BUWpf
         W1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZrRQNmc0CcAEYibhaFhftqFXp9A9dpxYkqN60c2KB8=;
        b=Ix9lfXDZZy7XbvWZFeNaw/Xm9FC1FyjHgnQwj1lr7362Fgkz5Gy4kEZg5LjwM/uox4
         VvTEstYFEzb+R1A5GaXXkV+vJqNSNhqNxFE777KQv+RBHwqC44uPseUFBvjqnPzB0gth
         uy/Hcra3Oi2kbF9tRc6xoqaz3Px5x6MqgXHIdAIv3WFmYxWKERvhKuSg7gvu9vYfiy6E
         KW6755ZQy7E0sssTOESnbPQ6gda40aTxsYVbr4kPLqlzDCK3x1K3ClC+4SRzLvaFoKOG
         YgGdc12/2SzzGq9BCbUg3RPpS32KhaPRiCZIEtN+StGUvBDUrnstJ2MZL3SaJYB6PiCM
         qN+Q==
X-Gm-Message-State: AGRZ1gKTroeEuegJRGQx4LCI2ZExNshz9fSsVy5Z36S/Tib47Sm5YEj5
        dRSOexBsdi/LF/wwD5jo1xNBRxS6Nm0=
X-Google-Smtp-Source: AJdET5eQlKXjhsdMEEbBHFIcP+MZmyPZiKkzgfCp6qWZdrxmxh4AtdSe4JpbOSEZuCZkpnLVHIurqw==
X-Received: by 2002:ac8:7518:: with SMTP id u24mr11362572qtq.75.1541823221247;
        Fri, 09 Nov 2018 20:13:41 -0800 (PST)
Received: from xakep.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p3sm6966136qkp.48.2018.11.09.20.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 20:13:40 -0800 (PST)
Date:   Fri, 9 Nov 2018 23:13:38 -0500
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
Subject: Re: [mm PATCH v5 7/7] mm: Use common iterator for
 deferred_init_pages and deferred_free_pages
Message-ID: <20181110041338.7ttram7po7a2ssz7@xakep.localdomain>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <154145280115.30046.13334106887516645119.stgit@ahduyck-desk1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154145280115.30046.13334106887516645119.stgit@ahduyck-desk1.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-05 13:20:01, Alexander Duyck wrote:
> +static unsigned long __next_pfn_valid_range(unsigned long *i,
> +					    unsigned long end_pfn)
>  {
> -	if (!pfn_valid_within(pfn))
> -		return false;
> -	if (!(pfn & (pageblock_nr_pages - 1)) && !pfn_valid(pfn))
> -		return false;
> -	return true;
> +	unsigned long pfn = *i;
> +	unsigned long count;
> +
> +	while (pfn < end_pfn) {
> +		unsigned long t = ALIGN(pfn + 1, pageblock_nr_pages);
> +		unsigned long pageblock_pfn = min(t, end_pfn);
> +
> +#ifndef CONFIG_HOLES_IN_ZONE
> +		count = pageblock_pfn - pfn;
> +		pfn = pageblock_pfn;
> +		if (!pfn_valid(pfn))
> +			continue;
> +#else
> +		for (count = 0; pfn < pageblock_pfn; pfn++) {
> +			if (pfn_valid_within(pfn)) {
> +				count++;
> +				continue;
> +			}
> +
> +			if (count)
> +				break;
> +		}
> +
> +		if (!count)
> +			continue;
> +#endif
> +		*i = pfn;
> +		return count;
> +	}
> +
> +	return 0;
>  }
>  
> +#define for_each_deferred_pfn_valid_range(i, start_pfn, end_pfn, pfn, count) \
> +	for (i = (start_pfn),						     \
> +	     count = __next_pfn_valid_range(&i, (end_pfn));		     \
> +	     count && ({ pfn = i - count; 1; });			     \
> +	     count = __next_pfn_valid_range(&i, (end_pfn)))

Can this be improved somehow? It took me a while to understand this
piece of code. i is actually end of block, and not an index by PFN, ({pfn = i - count; 1;}) is
simply hard to parse. Why can't we make __next_pfn_valid_range() to
return both end and a start of a block?

The rest is good:

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
