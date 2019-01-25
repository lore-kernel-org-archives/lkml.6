Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F29C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44841218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ00+u18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfAYFAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 00:00:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35555 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbfAYFAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 00:00:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so6417603edx.2;
        Thu, 24 Jan 2019 21:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aLcCV0MXqIl/S8eIZuDNMZ0u+c/SHLCQGxKeftRIqk8=;
        b=mJ00+u18uIHSoQD/GIguJ/eWN1uzQe58wX2TZepVVZAlKgE7vUnPsO/4AVip18nBv5
         +DCBucKCSCZp6JfjmIGOF7OisaK/g0xhgv0ySPllif22+FQReM6/fmhalHJMGGc8UsQ0
         wVVNhFLVYG7ZwDJloFRBVN+vXOD7gfqhmVnEGOI+yudZqMTrckgU4Nb84g7TDnTC9O+E
         o6f0SKcT6CxiRF00lJMx4srbB7KOufpyPzU07nEAN+fX510ZdSHcyad01dxzodUKKTrV
         WlrlHkZ1wayrofnIohfD/LmdGOvyzrRhTW6IMGJtT+cxA1LiDznucjsD5SrB896RYfIj
         MxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aLcCV0MXqIl/S8eIZuDNMZ0u+c/SHLCQGxKeftRIqk8=;
        b=LyhMwJJ5rBlD7SnUA50w3U+G+WNvKNMczlborNJPTal919RWVc/BR+RaCbzxXJMVYQ
         OTnRkIWjviozGOnyZdxObrOCQOKR3/jEwgm5yaib/qBb/G2Aciajhe+i9EXPYI1R3dk6
         p7P2lHEl/DF0W4/zsI6/+SSUuiUFCF3nZI8qrNXrsKvptGOYhDu7oGVbwn4TbslLIxjI
         fzbqwkYGqwkFmNyZgH6L0iLLHjXfAQo9/fR3Hxk+ne4Qw8gn8lkDweS9J+e4oyVVnXks
         zakYM4g+2pfByCbdukmNkW1dPYpZtNYgE1cT9dqhM4TCyqRr84j17JW7kF2ySOgo14Br
         +KnA==
X-Gm-Message-State: AJcUuke8jRU+x5uh4uhRB7nAmnq9DxVOPedgY/yh8ywnwQCxxgairiZl
        fyMG7we9R2fCZbfcQCH0Gy/68lfp
X-Google-Smtp-Source: ALg8bN7trFvhiVRMlSNb+ZbU9kT3BLYk1mF2oWyllbd6oaeFFRtdZAuXsYWwD+eJGrgSWpH41w7AtQ==
X-Received: by 2002:a17:906:b294:: with SMTP id q20mr3610336ejz.179.1548392440408;
        Thu, 24 Jan 2019 21:00:40 -0800 (PST)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id y53sm11665312edd.84.2019.01.24.21.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 21:00:39 -0800 (PST)
Subject: Re: [PATCH] of: Make of_node_name_eq() case insensitive
To:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     vivien.didelot@gmail.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
References: <20190124200825.2611-1-f.fainelli@gmail.com>
 <1a19b5f3-1387-0e6d-2d84-1b61079b4efb@gmail.com>
 <3e63d0c3-cb92-5caa-c0db-a04ef8fb5393@gmail.com>
 <04286c55-b995-3c5b-dc03-9f3c46d6376b@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bb238bed-0183-18b4-0182-fac4a74ed8a2@gmail.com>
Date:   Thu, 24 Jan 2019 21:00:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <04286c55-b995-3c5b-dc03-9f3c46d6376b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/19 6:06 PM, Frank Rowand wrote:
> On 1/24/19 5:20 PM, Florian Fainelli wrote:
>>
>>
>> On 1/24/19 3:45 PM, Frank Rowand wrote:
>>> On 1/24/19 12:08 PM, Florian Fainelli wrote:
>>>> Since c32569e358ad ("regulator: Use of_node_name_eq for node name
>>>> comparisons") Vivien reported the mc13892-regulator complaining about
>>>> not being able to find regulators.
>>>>
>>>> This is because prior to that commit we used of_node_cmp() to compare
>>>> the regulator array passed from mc13892_regulators down to
>>>> mc13xxx_parse_regulators_dt() and they are all defined in uppercase
>>>> letters by the MC13892_*_DEFINE* macros, whereas they are defined as
>>>> lowercase in the DTS.
>>>>
>>>> Fix this by use strncasecmp() since that makes sure the comparison is
>>>> case insensitive like what of_node_cmp() did.
>>>>
>>>> Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
>>>> Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>>  drivers/of/base.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>>> index 5226e898476e..ff47c86277cb 100644
>>>> --- a/drivers/of/base.c
>>>> +++ b/drivers/of/base.c
>>>> @@ -66,7 +66,8 @@ bool of_node_name_eq(const struct device_node *np, const char *name)
>>>>  	node_name = kbasename(np->full_name);
>>>>  	len = strchrnul(node_name, '@') - node_name;
>>>>  
>>>> -	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
>>>> +	return (strlen(name) == len) &&
>>>> +		(strncasecmp(node_name, name, len) == 0);
>>>>  }
>>>>  EXPORT_SYMBOL(of_node_name_eq);
>>>>  
>>>>
>>>
>>> Node names are case sensitive.  Please fix mc13xxx_parse_regulators_dt() to
>>> properly handle case instead of changing of_node_name_eq().
>>
>> Fair enough, should we issue a warning if np->full_name contains upper
>> case while name does not (and vice versa) to help troubleshoot cases
>> like the one we found with Vivien?
> 
> It seems like a lot of work to detect that specific case.  If anything,
> maybe just add some text to the existing "Unknown regulator: ..." warning
> in mc13xxx_parse_regulators_dt() to mention that case matters.

I was not thinking about something very clever, just issue a warning
like this, completely untested and likely flawed:

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5226e898476e..2505286c875b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -58,6 +58,7 @@ DEFINE_RAW_SPINLOCK(devtree_lock);
 bool of_node_name_eq(const struct device_node *np, const char *name)
 {
        const char *node_name;
+       int ret1, ret2;
        size_t len;

        if (!np)
@@ -66,7 +67,12 @@ bool of_node_name_eq(const struct device_node *np,
const char *name)
        node_name = kbasename(np->full_name);
        len = strchrnul(node_name, '@') - node_name;

-       return (strlen(name) == len) && (strncmp(node_name, name, len)
== 0);
+       ret1 = strncmp(node_name, name, len);
+       ret2 = strncasecmp(node_name, len);
+
+       WARN(ret1 ^ ret2, "Comparing case sensitive names!");
+
+       return (strlen(name) == len && (strncmp(node_name, name, len) == 0);
 }
 EXPORT_SYMBOL(of_node_name_eq);


My concern is that we have identified one place here where the
conversion to of_node_name_eq() broke that particular driver in fact,
all other regulator drivers but qcom-rpmh-regulator.c that use
of_node_name_eq() are broken after that change, but presumably this is
not the only place in the kernel where things could break, so having a
warning could potentially help (also adding the backtrace which is neat).

What should the fix look like though? Add an of_node_casename_eq() and
use it, revert Rob's commit that changes these regulators to use
of_node_name_eq()?

I don't know the regulator framework enough to know whether forcibly
making the names lowercase is not breaking sysfs/debugfs...
-- 
Florian
