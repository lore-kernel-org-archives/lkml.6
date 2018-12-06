Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3BC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D3420850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D3420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeLFJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:23:27 -0500
Received: from mail.netline.ch ([148.251.143.178]:55401 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:23:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id BFB372A604C;
        Thu,  6 Dec 2018 10:23:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id F3B5h78J3AzK; Thu,  6 Dec 2018 10:23:19 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 538792A604B;
        Thu,  6 Dec 2018 10:23:19 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gUpsN-0003es-2A; Thu, 06 Dec 2018 10:23:19 +0100
Subject: Re: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is
 disabled
To:     Joe Perches <joe@perches.com>,
        "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181205165621.5805-1-michel@daenzer.net>
 <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
 <1586a49594d30b4bf4d88eba0d258e21efd26da2.camel@perches.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <276fbf7f-d33f-83a5-cb88-bd4051dc03ba@daenzer.net>
Date:   Thu, 6 Dec 2018 10:23:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1586a49594d30b4bf4d88eba0d258e21efd26da2.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-06 3:51 a.m., Joe Perches wrote:
> On Thu, 2018-12-06 at 10:40 +0800, Zhang, Jerry(Junwei) wrote:
>> On 12/6/18 12:56 AM, Michel Dänzer wrote:
>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>
>>> The following cases are possible for pr_debug():
>>>
>>> 1. CONFIG_DYNAMIC_DEBUG disabled
>>>     a) DEBUG not defined: pr_debug() translates to no_printk(...), i.e.
>>>        it never generates any output.
>>>     b) DEBUG defined: pr_debug() translates to printk(KERN_DEBUG ...),
>>>        i.e. it generates output which doesn't appear in dmesg by default,
>>>        can be enabled dynamically.
>>>
>>> 2. CONFIG_DYNAMIC_DEBUG enabled: pr_debug() translates to
>>>     dynamic_pr_debug()
>>>     a) DEBUG not defined: dynamic_pr_debug() generates no output by
>>>        default, can be enabled dynamically.
>>>     b) DEBUG defined: dynamic_pr_debug() generates output by default,
>>>        can be disabled dynamically.
>>>
>>> The intention for drm_debug_printer() is to generate output which
>>> doesn't appear in dmesg by default, but can be enabled dynamically, i.e.
>>> cases 1b) and 2a). However, defining DEBUG unconditionally gave us 2b)
>>> instead of 2a) with CONFIG_DYNAMIC_DEBUG enabled.
>>>
>>> Fixes: 79a5ad2fdb3c ("drm: Enable pr_debug() for drm_printer")
> 
> I very much doubt this is a fix.
> 
> Did you read the commit log for this commit?
> 
> It says "make sure it will always produce output"

I thought the commit log covered this, suggestions for improvement welcome.

Chris' change addressed case 1a), but also took us from 2a) to 2b). But
we want 2a).

I suspect Chris missed that pr_debug()'s output is visible by default if
CONFIG_DYNAMIC_DEBUG and DEBUG are both defined.


> And why didn't you cc Chris Wilson, the author of that patch?

I used the get_maintainer.pl script. Thanks for adding Chris.


P.S. FYI, your e-mail had a very aggressive tone to me, not sure what for.


>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>> Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/drm_print.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
>>> index 0e7fc3e7dfb4..ee56e4a1b343 100644
>>> --- a/drivers/gpu/drm/drm_print.c
>>> +++ b/drivers/gpu/drm/drm_print.c
>>> @@ -23,11 +23,13 @@
>>>    * Rob Clark <robdclark@gmail.com>
>>>    */
>>>   
>>> -#define DEBUG /* for pr_debug() */
>>> -
>>>   #include <stdarg.h>
>>>   #include <linux/seq_file.h>
>>>   #include <drm/drmP.h>
>>> +
>>> +#ifndef CONFIG_DYNAMIC_DEBUG
>>> +#define DEBUG /* for pr_debug() */
>>> +#endif
>>>   #include <drm/drm_print.h>
>>>   
>>>   void __drm_puts_coredump(struct drm_printer *p, const char *str)
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
