Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C149C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F9120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F9120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLFQOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:14:14 -0500
Received: from mail.netline.ch ([148.251.143.178]:34320 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeLFQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:14:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 4D3AA2A604C;
        Thu,  6 Dec 2018 17:14:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id y_p9IVZEyrvC; Thu,  6 Dec 2018 17:14:05 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 74A0A2A604B;
        Thu,  6 Dec 2018 17:14:05 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gUwHs-0007Hh-Ux; Thu, 06 Dec 2018 17:14:04 +0100
Subject: Re: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is
 disabled
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        Huang Rui <ray.huang@amd.com>, Joe Perches <joe@perches.com>,
        Sean Paul <sean@poorly.run>,
        Christian Koenig <christian.koenig@amd.com>
References: <20181205165621.5805-1-michel@daenzer.net>
 <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
 <1586a49594d30b4bf4d88eba0d258e21efd26da2.camel@perches.com>
 <276fbf7f-d33f-83a5-cb88-bd4051dc03ba@daenzer.net>
 <e7859ce4b8417b094604d9ab4740d338730e38bf.camel@perches.com>
 <d2a1f009-b2c7-240d-7e1c-e48a08d8ac7d@daenzer.net>
 <61385d4cb6c9d990427349849d0af28faa3b67af.camel@perches.com>
 <747d6c1b-8c0a-8168-bd1e-e969839ff5be@daenzer.net>
 <20181206161011.hkjjzdtfzd2hthos@holly.lan>
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
Message-ID: <7fb7dbd9-96ff-03c7-cbab-3c5af9c00d4e@daenzer.net>
Date:   Thu, 6 Dec 2018 17:14:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181206161011.hkjjzdtfzd2hthos@holly.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-06 5:10 p.m., Daniel Thompson wrote:
> On Thu, Dec 06, 2018 at 03:41:16PM +0100, Michel Dänzer wrote:
>> On 2018-12-06 1:23 p.m., Joe Perches wrote:
>>> On Thu, 2018-12-06 at 12:52 +0100, Michel Dänzer wrote:
>>>> In contrast to the 2b case, the pr_debug output isn't visible by default
>>>> with 1b, so the latter doesn't fit "always produce output" either.
>>>
>>> I think you are mistaken here.
>>
>> Still puzzled as to what you're hoping to achieve with that kind of
>> language. None of the confusion about this patch has been on my part. :)
>>
>>
>>> Adding #define DEBUG as Chris did enables pr_debug output
>>> and is your 1b.
>>>
>>> Perhaps your default console logging level is set to a
>>> non-default value.
>>
>> I have CONFIG_DYNAMIC_DEBUG enabled in my kernels. The problem addressed
>> by this patch is that messages from drm_debug_printer are visible by
>> default (case 2b), whereas they shouldn't be (case 2a, like 1b).
> 
> When enabled (either dynamically or statically) pr_debug() will emit
> output at KERN_DEBUG level regardless of whether CONFIG_DYNAMIC_DEBUG
> is defined or not.
> 
> Thus unless you change additional settings (either dynamically or
> statically) then debug messages should not be shown on the console
> because the default settings filter KERN_DEBUG messages. However they
> are available via dmesg and system loggers (syslogd, journal, etc).
> 
> The patch proposed will change the behaviour of the debug messages
> w.r.t. system loggers based on whether the user has enabled
> CONFIG_DYNAMIC_DEBUG or not, violating the principle of least surprise.

Ah, that makes sense now, thanks.

I'm withdrawing this patch.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
