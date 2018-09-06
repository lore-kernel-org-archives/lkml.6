Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E8C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604472083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604472083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeIFLWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 07:22:47 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36740 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeIFLWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 07:22:47 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so10036834wmj.1;
        Wed, 05 Sep 2018 23:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9yRHcUsun8D6OTHiT8dm6ofbPAliszO2TJlYJ7wwXrM=;
        b=G1sepFBiJFX/1S3leeEKwBgUOFQBI4XPXcuue+ENn+A3hocn2Rmq9p/qMS2mYmI/Y4
         I7vwH89JzpoCNRoq0pC6Pi4upQGn6RzZApphp63UaRxYTHS7q9cDeoypC4czwq5iR4qn
         XTmjzRc5zsQ7xycvWCf9pSN2crrSKgpmKs6b4Vnka4FF034l2wN4vnmx6OCNYUKS5t2V
         hhCKtnBPiQVogh9P+tPMTvuzhN81GUg/jkW1g1Jj2SwEQoqr4IkeUB0CwQoMIF2eIqFx
         lDBMQ+HDqlU8gk9JUS5zfJ0dVGolhdYDHHEnGopHT1Q+eNe4lmtUvm9MdeOxmIGqU+1Z
         6Lwg==
X-Gm-Message-State: APzg51AoAyoX1vwycQ9XEV8fGMixuymtErS6mAONQnSQz8kcwOg02XQX
        16U3Sk44d/By6rCelEhhKgo=
X-Google-Smtp-Source: ANB0VdYx8Zpfg6dRsyu3Cwy35mRbkl0jKlJ+b+bDvyzaD5tKavyAWig399oGmWa88yTVcfWxPD8GAg==
X-Received: by 2002:a1c:eec4:: with SMTP id j65-v6mr1130794wmi.143.1536216528494;
        Wed, 05 Sep 2018 23:48:48 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id z141-v6sm4132114wmc.3.2018.09.05.23.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 23:48:47 -0700 (PDT)
Subject: Re: [PATCH] x86/mm/pat: Fix L1TF stable backport for CPA
To:     Andi Kleen <andi@firstfloor.org>, stable@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        bernhard.kaindl@thalesgroup.com, Andi Kleen <ak@linux.intel.com>
References: <20180825135015.33547-1-andi@firstfloor.org>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2374a957-ab3c-5fad-64eb-14ce4a698715@suse.cz>
Date:   Thu, 6 Sep 2018 08:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180825135015.33547-1-andi@firstfloor.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/25/2018, 03:50 PM, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Patch for stable only to fix boot resets caused by the L1TF patches.
> 
> Stable trees reverted the following patch
> 
> Revert "x86/mm/pat: Ensure cpa->pfn only contains page frame numbers"
> 
>     This reverts commit 87e2bd898d3a79a8c609f183180adac47879a2a4 which is
>     commit edc3b9129cecd0f0857112136f5b8b1bc1d45918 upstream.
> 
> but the L1TF patch backported here
> 
>    x86/mm/pat: Make set_memory_np() L1TF safe
> 
>     commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream
> 
>     set_memory_np() is used to mark kernel mappings not present, but it has
>     it's own open coded mechanism which does not have the L1TF protection of
>     inverting the address bits.
> 
> assumed that cpa->pfn contains a PFN. With the above patch reverted
> it does not, which causes the PMD to be set to an incorrect address
> shifted by 12 bits, which can cause early boot reset on some
> systems, like an Apollo Lake embedded system.
> 
> Convert the address to a PFN before passing it to pmd_pfn()
> 
> Thanks to Bernhard for bisecting and testing.
> 
> Cc: stable@vger.kernel.org # 4.4 and 4.9
> Reported-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
> Tested-by: Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/mm/pageattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index 27610c2d1821..1007fa80f5a6 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -1006,7 +1006,7 @@ static int populate_pmd(struct cpa_data *cpa,
>  
>  		pmd = pmd_offset(pud, start);
>  
> -		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
> +		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn >> PAGE_SHIFT,
>  					canon_pgprot(pmd_pgprot))));

And what about populate_pud?
                set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
                                   canon_pgprot(pud_pgprot))));

                start     += PUD_SIZE;
                cpa->pfn  += PUD_SIZE;

thanks,
-- 
js
suse labs
