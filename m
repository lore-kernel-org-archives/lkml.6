Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DFEC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6297A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 23:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIuCNzwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfAXXqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 18:46:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35841 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfAXXqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 18:46:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so3809577pfc.3;
        Thu, 24 Jan 2019 15:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1K89zAmTGDpWm/zQQwBM9FUhIdLg5f6wQFtgDcTEk5o=;
        b=JIuCNzwIr0A36l8j7DpbDpArPgd7s4zKQbN/DwErONnFAhU+HYfBSa4oBlO12j2qNI
         5R05bcIXf9xtK8FYHqenfaCILh22dNG3hXcATI0Zf9nTVbKJPQ2PeBYWa6lZ3tmQvnjz
         pkbxkkmTGtSa+4xxOqq2JblfGSGUMDZddmWyjKw63VOXj3LZ4YG4A7AG/wNE2zBycex5
         thnnYTSpqQz2HpVZsoMBBB49+CJz0G+V/AbLsqdl9CpLEY/yjIxIRK2CBkTRCShTLLkz
         jsY+DQgQVsGz3vKunLqED3tBY6GKG+JDNskJ+RShwf0vRLhDlpzCygZenOtZ59iA8cEp
         xpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1K89zAmTGDpWm/zQQwBM9FUhIdLg5f6wQFtgDcTEk5o=;
        b=rznrmJRiaKrQGXBgG2DVkG5g6jOckgJaXRBAVq3nY766+CmOc5QFHBLjColMEbbCz1
         kpgb7EPCR9yI4O69H8ApJVxtV64PucNncmFykt3fLbhhWFRp2X4Axtk61kIafa0mzL2m
         LF3kiigDBUDYUhgg9ml+1sKP8fO/cNAuYdqwpunLS+wgKJheBExntqCEqUpSka435B9w
         qjIrt/yXAIkAHuKTuEv70EgxHdTNn0WAGfMSpPW9fhgyrtlyi3FeBkuc0wa7zK7hmVuu
         stTe/137+6dmE51KnmOgrQPNaZIB33/HxsIRlamOsfW00tP57RLam5fTVi/po6Q6nzh3
         GVRQ==
X-Gm-Message-State: AJcUukcGegNHMZqhHISOtrRpAKQ6CoYhDFnZpyZRVhMHAvKs0yKGpVii
        wC7XhP/fF0VlY2DneNbNADU=
X-Google-Smtp-Source: ALg8bN4oNDmxBGDdGFElfx7+mqkndAzdXLcG1EwiXgEr2w9rxB6Ogij5Q4547rmMt8blRAYsMvtHGg==
X-Received: by 2002:a63:413:: with SMTP id 19mr7705985pge.7.1548373561987;
        Thu, 24 Jan 2019 15:46:01 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z14sm26929263pgv.47.2019.01.24.15.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 15:46:01 -0800 (PST)
Subject: Re: [PATCH] of: Make of_node_name_eq() case insensitive
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     vivien.didelot@gmail.com, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
References: <20190124200825.2611-1-f.fainelli@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <1a19b5f3-1387-0e6d-2d84-1b61079b4efb@gmail.com>
Date:   Thu, 24 Jan 2019 15:45:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124200825.2611-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 12:08 PM, Florian Fainelli wrote:
> Since c32569e358ad ("regulator: Use of_node_name_eq for node name
> comparisons") Vivien reported the mc13892-regulator complaining about
> not being able to find regulators.
> 
> This is because prior to that commit we used of_node_cmp() to compare
> the regulator array passed from mc13892_regulators down to
> mc13xxx_parse_regulators_dt() and they are all defined in uppercase
> letters by the MC13892_*_DEFINE* macros, whereas they are defined as
> lowercase in the DTS.
> 
> Fix this by use strncasecmp() since that makes sure the comparison is
> case insensitive like what of_node_cmp() did.
> 
> Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
> Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/of/base.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 5226e898476e..ff47c86277cb 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -66,7 +66,8 @@ bool of_node_name_eq(const struct device_node *np, const char *name)
>  	node_name = kbasename(np->full_name);
>  	len = strchrnul(node_name, '@') - node_name;
>  
> -	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
> +	return (strlen(name) == len) &&
> +		(strncasecmp(node_name, name, len) == 0);
>  }
>  EXPORT_SYMBOL(of_node_name_eq);
>  
> 

Node names are case sensitive.  Please fix mc13xxx_parse_regulators_dt() to
properly handle case instead of changing of_node_name_eq().

-Frank
