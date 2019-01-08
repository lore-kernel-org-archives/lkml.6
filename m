Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501002087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nq5Ewb0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfAHEtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:49:35 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45242 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHEtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:49:35 -0500
Received: by mail-yb1-f193.google.com with SMTP id q2so1078911ybd.12;
        Mon, 07 Jan 2019 20:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oFSWDE7ylA7tHsFZ+Uhyyuy8BZ86kWvQtuER6gDsHAM=;
        b=Nq5Ewb0G7B/wpzAeVAOQHDAr3MBqAgx+bnVdlV2+iGHij9H8HZkMDXNnHBdnsyDSWZ
         FUq94AF//AEZZ8l9mcggu4ZWenx86rPvOadPNlkv75C/wMw/ipkKkY6whYb1xfOQgeUg
         j1K5ToAxM3gsgX77/b0oWH7rdXFNWYnKW6NjnKLU7qxtpNO2IlWJM6IPcOgK7IQ6uDjG
         DGBoPvdKzC6KOWUZluMnJh7PeaXvBjvkZqpBLgOpihYeEfpv0MIV8CY07XOYpUDrhzf9
         BxCUSS4KhW+uIzpPycGDf02WOdqtp+5FJZS5ifbLYP3YaZ3n11zWXRNsR0b1uF0Yd/n5
         lDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oFSWDE7ylA7tHsFZ+Uhyyuy8BZ86kWvQtuER6gDsHAM=;
        b=EDO0UXTa8nNpKn//sj5gr3glOEPkvBDeAHi8wL3SMZ2xHwDZbALga5cSoCm0euOAJW
         SAQkfECW1ZcYD94hbcXFCnAE756DWv5VcWxExBTn8c6gMHmoDnTFGGhcjZ1cxw2oSIVa
         zZDmAodEL+zSjGAhz6WLfzheQ2ce1SjoCCWSYVdNUy0+5RJ9wZmOveS2Jrjng9dAEWcV
         DPraYY6CzcYWy5Sk2IG9DD4UAa02nzxg+qTJ5WZ/2485PF7Wti7TZ2rHuQ8/OlOO1dH4
         K0V5R3rqgyAbL/Lcpi5PVf/C9SCN/yaQtBzkyIsOsOkTZN1NIQCm37k0DH85Ft3g4YGQ
         i4HA==
X-Gm-Message-State: AJcUukclBwRABYHMBD38pM/WIGNP2yMGcSwgrK8EjMsHAT9dQUHdKJGS
        hCoisfFws6Sb8SSp/WmMjYw=
X-Google-Smtp-Source: ALg8bN4ouxCMKcODXGkbWP3hIxvMWyx0NqW6urgLUi9W3UN/u/8SgTl+7h6UrFwqyvvcaGozO7CTTQ==
X-Received: by 2002:a25:84c7:: with SMTP id x7mr211298ybm.378.1546922974393;
        Mon, 07 Jan 2019 20:49:34 -0800 (PST)
Received: from [192.168.1.138] (cpe-24-160-118-96.tampabay.res.rr.com. [24.160.118.96])
        by smtp.gmail.com with ESMTPSA id j134sm31936261ywb.91.2019.01.07.20.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 20:49:33 -0800 (PST)
Subject: Re: Consistent capitalization of "device tree"?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org
References: <20190107183711.GA5671@amd>
 <91bc4723-8e3a-4ed6-5104-36a614d6a6d2@gmail.com> <20190107192458.GG933@amd>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <64534368-1ee5-3a6b-18a6-d1d527aa4bdd@gmail.com>
Date:   Mon, 7 Jan 2019 20:49:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107192458.GG933@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 11:24 AM, Pavel Machek wrote:
> On Mon 2019-01-07 11:06:27, Frank Rowand wrote:
>>
>> + Frank
>>
>> On 1/7/19 10:37 AM, Pavel Machek wrote:
>>> Is it "Device Tree" or "device tree"?
>>>     
>>>  pavel@duo:/data/l/k/Documentation$ grep -r "Device Tree"  | wc -l
>>>  235
>>>  pavel@duo:/data/l/k/Documentation$ grep -r "device tree"  | wc -l
>>>  595
>>>     
>>> I guess it would be nice to make it consistent. I guess "device tree"
>>> is preffered?
>>>
>>> Should we do something like this?
>>> 								Pavel
>>>
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>>     
>>> diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
>>> index 725fb8d..cc5f507 100644
>>> --- a/Documentation/devicetree/overlay-notes.txt
>>> +++ b/Documentation/devicetree/overlay-notes.txt
>>> @@ -8,7 +8,7 @@ companion document to Documentation/devicetree/dynamic-resolution-notes.txt[1]
>>>  How overlays work
>>>  -----------------
>>>  
>>> -A Device Tree's overlay purpose is to modify the kernel's live tree, and
>>> +A device tree's overlay purpose is to modify the kernel's live tree, and
>>>  have the modification affecting the state of the kernel in a way that
>>>  is reflecting the changes.
>>>  Since the kernel mainly deals with devices, any new device node that result
>>>
>>
>> Not a strong opinion, but I would prefer a third option of devicetree.  That
>> makes it much easier to search for.
> 
> That one is much less popular at the moment -- according to my
> searches... so it would be a bigger change.
> 
> (Which I'll gladly support if I won't have to do the work... as long
> as it is consistent. But I believe that "device tree" is most common
> here, makes sense, and is easiest change, so...)
> 
> 								Pavel

After finding the rest of the thread, and thinking further, I don't think
the easiest change is the correct change.  Ease of search is much more
than just grep of the kernel source, it is also web search engines.  I
think that the extra effort of "devicetree" is worth while in the long
run.  But I don't see a need to do an immediate global change - it can
happen either slowly over time or quickly as people choose to submit
patches.

-Frank

