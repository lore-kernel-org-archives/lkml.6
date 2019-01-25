Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048D1C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C101E218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wlt9/t3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfAYBUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:20:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46887 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfAYBUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:20:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so3448982pgp.13;
        Thu, 24 Jan 2019 17:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nKiwnk5Rh0auXyU95dhs5g89Dyq0dht87Z5qnVX942k=;
        b=Wlt9/t3JYDNyp7pVifdMKeaY39WlKfPC2NxYuyzrhyNw52CVLQX2sU8UpvdR2k4LRk
         eK8Atw/249waCMtFUvJvMiGZum+Z+e1KEkBHY7VAUlmRfi+g8Ni9m60aqRyIkEFSW1uC
         D/cjAPKCKf70hhuz1T5g/CEzj5ARyj/Sy+1TZwIR9FvAL1jOGrzGVw9+Pp3/4+kXlyhM
         MoXam51DLMkcjoB5M1roJlhjGl1ELrYnuOCrHtvVyqpfXQrHGyPGaXxgOCvmgYnOtBqD
         zKT8ErSfrxcN/ypT5mD3/bCYJ0JtXQW55syega2RTacSlPv8oX9YxY8XDU61fTuGSkhJ
         eMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nKiwnk5Rh0auXyU95dhs5g89Dyq0dht87Z5qnVX942k=;
        b=tXpOKG5lEThmwwTXLatJa+5mrS7RObZ97VADiS8kEseHWWiQUXcKmjCw3c480/Iw9g
         WISo4AtSX8Vf2QfZ1cr/naRbgAu1XWeb+QIMNfvi/+7FJnaOEIgdQshSRbO4ihFLqlHd
         mDoEe58PQpVJMf49pLUP/n18W+gGTEKi42K4AbnjNQQ/kJx4vzTzkBsYlIhTY6XARrTx
         OFT8SGgqy1BNxeHQcGytDImeVibzpwL2WMBpl+wLuZSxeUw0unsZegdDuhRpX30IZLWC
         zLLNJ4pphR6m16JGPvD7h5ijNqC1jYQRAqpjOKIr1uYnJf+S+yHAuX5VNmR51C+wOkjc
         kvCA==
X-Gm-Message-State: AJcUukc9QT9hGhKqLIkGIwTNgIi1Ky+gE4wQKJrupZQdlGE+TLkENk7E
        0b0AniLmTnxRDJ0oJDQiBI3tDD9x
X-Google-Smtp-Source: ALg8bN63f6hqc6Rg2B3gcLkJLNMyr+aoVarxK/gobmp+Li9+w+jbpTJFCg+50za7ywE2eyrriaKunw==
X-Received: by 2002:a63:9a09:: with SMTP id o9mr7770627pge.94.1548379210163;
        Thu, 24 Jan 2019 17:20:10 -0800 (PST)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id 184sm32957162pfe.106.2019.01.24.17.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 17:20:09 -0800 (PST)
Subject: Re: [PATCH] of: Make of_node_name_eq() case insensitive
To:     Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org
Cc:     vivien.didelot@gmail.com, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
References: <20190124200825.2611-1-f.fainelli@gmail.com>
 <1a19b5f3-1387-0e6d-2d84-1b61079b4efb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3e63d0c3-cb92-5caa-c0db-a04ef8fb5393@gmail.com>
Date:   Thu, 24 Jan 2019 17:20:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1a19b5f3-1387-0e6d-2d84-1b61079b4efb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/19 3:45 PM, Frank Rowand wrote:
> On 1/24/19 12:08 PM, Florian Fainelli wrote:
>> Since c32569e358ad ("regulator: Use of_node_name_eq for node name
>> comparisons") Vivien reported the mc13892-regulator complaining about
>> not being able to find regulators.
>>
>> This is because prior to that commit we used of_node_cmp() to compare
>> the regulator array passed from mc13892_regulators down to
>> mc13xxx_parse_regulators_dt() and they are all defined in uppercase
>> letters by the MC13892_*_DEFINE* macros, whereas they are defined as
>> lowercase in the DTS.
>>
>> Fix this by use strncasecmp() since that makes sure the comparison is
>> case insensitive like what of_node_cmp() did.
>>
>> Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
>> Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/of/base.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 5226e898476e..ff47c86277cb 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -66,7 +66,8 @@ bool of_node_name_eq(const struct device_node *np, const char *name)
>>  	node_name = kbasename(np->full_name);
>>  	len = strchrnul(node_name, '@') - node_name;
>>  
>> -	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
>> +	return (strlen(name) == len) &&
>> +		(strncasecmp(node_name, name, len) == 0);
>>  }
>>  EXPORT_SYMBOL(of_node_name_eq);
>>  
>>
> 
> Node names are case sensitive.  Please fix mc13xxx_parse_regulators_dt() to
> properly handle case instead of changing of_node_name_eq().

Fair enough, should we issue a warning if np->full_name contains upper
case while name does not (and vice versa) to help troubleshoot cases
like the one we found with Vivien?
-- 
Florian
