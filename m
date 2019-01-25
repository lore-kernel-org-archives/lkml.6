Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1855CC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC08C218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chPPYpuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfAYCG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:06:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33183 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfAYCG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:06:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so3802534plo.0;
        Thu, 24 Jan 2019 18:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vOwWShLil003XRkyCNILWvuOylGm/pnsXF6CwkXQl5Y=;
        b=chPPYpuU0n1xHQlCeOMeRkvxU0ZxpckDGUSQJ+5B6gz2RX64PVVsLfDAPEWFKTWsgv
         vEV9mM7FDqBzthIGxNcFrUQ8OKnedNRLGGhfZlIvbdRiNKcRSadc97ZjTTbtNz92mjWD
         V0Df2sRVguNKgacYhTvRs8MMl214gsXVdS+M/o5/jOc28Zkv4gGWGlYSS81gvEXyT1us
         OGd6Vs3DPndXOeD+2a+G6EHCPT9NCvxgqdYWotVke+L92zqCEeONErNgcBXRVREfI7WM
         BHY62AvW7MTpeHNLd1YEj8LEqkHDKR6ffQoH5wUcbhlaG4zVOuG9bGGjDi5xuLTfUIlh
         G+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vOwWShLil003XRkyCNILWvuOylGm/pnsXF6CwkXQl5Y=;
        b=DWYhtnQJgQb2FQQJv0vzt9Qm+C4I6ZIF476ZPFdP2Cg8PLxcWjAWKAT6hVig4+fQCz
         J53eCn8DwzdquVWI1WVQ9Vj55n+zSHX3qr2hnS3H8Xw4yScesyxntNp3r3bv9y6/px3F
         Fs4JWIHUAEAICBQf6ELsb+jkPCDzyKi73ZDAblalW/g4MqouZwRSZ002+MG2NZ3nHm2W
         l4oasd9HtuHqZBeqxn8j2Us8ew+/NFrpLVTq1YCTRNBKAkRNPt2TEwC5ct/ErZpef7zF
         eD1f6l09YzDh2Y4JJsDc3sDexBxGPZqx5F9+wKh9lCYsnwDAljEYrjq6ahV+GnV7JAxF
         ss3Q==
X-Gm-Message-State: AJcUukf5EJ3MR42PWe858gt0NRX1CHc4g/WMu9EBZ5/hZh6witH5ZIYC
        llYvCNPComL32R8RNWWYiSs=
X-Google-Smtp-Source: ALg8bN4Ibavg7gZju5xlyNLjDjsc/PfXH0qxpM3mYeL21d7uwilxJSJ5iYPKjNKGrBB3v5rbdSr59A==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr9155279pll.51.1548382016804;
        Thu, 24 Jan 2019 18:06:56 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u137sm42025146pfc.140.2019.01.24.18.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 18:06:56 -0800 (PST)
Subject: Re: [PATCH] of: Make of_node_name_eq() case insensitive
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     vivien.didelot@gmail.com, Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>
References: <20190124200825.2611-1-f.fainelli@gmail.com>
 <1a19b5f3-1387-0e6d-2d84-1b61079b4efb@gmail.com>
 <3e63d0c3-cb92-5caa-c0db-a04ef8fb5393@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <04286c55-b995-3c5b-dc03-9f3c46d6376b@gmail.com>
Date:   Thu, 24 Jan 2019 18:06:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3e63d0c3-cb92-5caa-c0db-a04ef8fb5393@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 5:20 PM, Florian Fainelli wrote:
> 
> 
> On 1/24/19 3:45 PM, Frank Rowand wrote:
>> On 1/24/19 12:08 PM, Florian Fainelli wrote:
>>> Since c32569e358ad ("regulator: Use of_node_name_eq for node name
>>> comparisons") Vivien reported the mc13892-regulator complaining about
>>> not being able to find regulators.
>>>
>>> This is because prior to that commit we used of_node_cmp() to compare
>>> the regulator array passed from mc13892_regulators down to
>>> mc13xxx_parse_regulators_dt() and they are all defined in uppercase
>>> letters by the MC13892_*_DEFINE* macros, whereas they are defined as
>>> lowercase in the DTS.
>>>
>>> Fix this by use strncasecmp() since that makes sure the comparison is
>>> case insensitive like what of_node_cmp() did.
>>>
>>> Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
>>> Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>  drivers/of/base.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index 5226e898476e..ff47c86277cb 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -66,7 +66,8 @@ bool of_node_name_eq(const struct device_node *np, const char *name)
>>>  	node_name = kbasename(np->full_name);
>>>  	len = strchrnul(node_name, '@') - node_name;
>>>  
>>> -	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
>>> +	return (strlen(name) == len) &&
>>> +		(strncasecmp(node_name, name, len) == 0);
>>>  }
>>>  EXPORT_SYMBOL(of_node_name_eq);
>>>  
>>>
>>
>> Node names are case sensitive.  Please fix mc13xxx_parse_regulators_dt() to
>> properly handle case instead of changing of_node_name_eq().
> 
> Fair enough, should we issue a warning if np->full_name contains upper
> case while name does not (and vice versa) to help troubleshoot cases
> like the one we found with Vivien?

It seems like a lot of work to detect that specific case.  If anything,
maybe just add some text to the existing "Unknown regulator: ..." warning
in mc13xxx_parse_regulators_dt() to mention that case matters.

-Frank

