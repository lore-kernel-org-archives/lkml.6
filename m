Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E270CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822D220890
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDr9wjH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822D220890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIKVCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:02:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33151 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKVCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:02:44 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so48223177oip.0;
        Tue, 11 Sep 2018 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z8un5poNynW9nk3OSiZNF95fwbQEXI2dh5fivhzcI6Q=;
        b=YDr9wjH5/EbyJlwpN6A0MoE8FmX1m+GQQZ5kFnbHuYpGOYu2SCRCIaB/mLoa8pcOKu
         TEMz52lGR+PrH0eopfLUOlWNJ3h1LSAL83F9mKcvKlpK14Y47Ks6iOIw/3zvskxB7GhK
         0F05ZMHikzH/3GZ5+qQZGCCInpJRvrAz8z8IYDy/63qTSe8NjilTHtWgi3CbWES5Tyd1
         E961Pw7E3cJfUeNAn+FunrMAkZseMiCag6/NDtqi7ZaUmpQnlNqy+AQ76UOIepqNclOU
         QtGVCYJKKbz8OrU/NbAvtm5Bhar/kJf1Rqcj+3aBcCjaiH4Tai3d89bzopcBrmCEZu0t
         0RMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z8un5poNynW9nk3OSiZNF95fwbQEXI2dh5fivhzcI6Q=;
        b=C0710ethZdgtrTHiZFnzQJU9Ii9wGwZYqsJ4gFNvmPxhERTuMg5ZsVo8sP3A/mupaW
         O52eyERxANN6c77Mej6gjaI4gODwL0koF2S8ZsY+mSXDG+eXDI1DZ1irSI/iJrwMlG0J
         MeSRuQihSMiybWnDnA07YNV/yvZMhmVoDATaVApBQX4CBLr5XHiRQ2g3NHfUMm9RjIT6
         WfxzMU7fx6EKiI5QJyE9uLlAtqMUMRsn0l21DSZHZEBE7kfbG5VmYZqBb/3u/dcTxbs6
         YU3GT/HXBe67GKriG26gjmue0sr9EMMGcHeeER7f7v2wln1zuOu4NqonyuyPT/jTbX6S
         smKg==
X-Gm-Message-State: APzg51DtXBdJzVO51ULoKhqIdQwbPfy6FJZG0I/LRMgnwu4sL1Lmee5f
        joHXvG8+1u+yy4DTxjVpsDA=
X-Google-Smtp-Source: ANB0VdayuHq3KlJ20PsPbIh+JmU8m7wtjxeQyXo9Kvr2LwrPd2WS7cd3Ft2TJll1gcDH2NFy6bKFtQ==
X-Received: by 2002:aca:305:: with SMTP id 5-v6mr25393388oid.84.1536681766593;
        Tue, 11 Sep 2018 09:02:46 -0700 (PDT)
Received: from [192.168.0.113] (47-208-214-43.trckcmtc01.res.dyn.suddenlink.net. [47.208.214.43])
        by smtp.gmail.com with ESMTPSA id q124-v6sm19932760oif.8.2018.09.11.09.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:02:46 -0700 (PDT)
Subject: Re: [PATCH] of: fix phandle cache creation for DTs with no phandles
To:     Rob Herring <robh@kernel.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
References: <20180911145607.6009-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0ecd44b5-3faa-6b30-d47f-dd06efbcadd6@gmail.com>
Date:   Tue, 11 Sep 2018 09:02:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911145607.6009-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/18 07:56, Rob Herring wrote:
> With commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
> of_find_node_by_phandle()"), a G3 PowerMac fails to boot. The root cause
> is the DT for this system has no phandle properties when booted with
> BootX. of_populate_phandle_cache() does not handle the case of no
> phandles correctly. The problem is roundup_pow_of_two() for 0 is
> undefined. The implementation subtracts 1 underflowing and then things
> are in the weeds.
> 
> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
> Cc: stable@vger.kernel.org # 4.17+
> Reported-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Here's a formal patch of what Stan tested. Will send to Linus this week.
> 
> Rob
> 
>  drivers/of/base.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index a055cd1ef96d..17ae594b7014 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -140,6 +140,9 @@ void of_populate_phandle_cache(void)
>  		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
>  			phandles++;
>  
> +	if (!phandles)
> +		goto out;
> +
>  	cache_entries = roundup_pow_of_two(phandles);
>  	phandle_cache_mask = cache_entries - 1;
>  
> 


Reviewed-by: Frank Rowand <frank.rowand@sony.com>
