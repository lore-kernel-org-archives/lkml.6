Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F37CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE66F20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE66F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbeLFJyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:54:36 -0500
Received: from mail.netline.ch ([148.251.143.178]:55918 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeLFJyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:54:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 96FBB2A604C;
        Thu,  6 Dec 2018 10:54:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 230lMTFP4J4m; Thu,  6 Dec 2018 10:54:33 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id D39592A604B;
        Thu,  6 Dec 2018 10:54:32 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gUqMa-0003vB-IO; Thu, 06 Dec 2018 10:54:32 +0100
Subject: Re: [PATCH 2/2] drm/ttm: Use pr_debug for all output from
 ttm_bo_evict
To:     christian.koenig@amd.com,
        "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20181205165621.5805-1-michel@daenzer.net>
 <20181205165621.5805-2-michel@daenzer.net>
 <b0b57acb-7152-ab1a-855a-3de8c77fa425@amd.com>
 <3198051c-c09d-5bf9-e177-3a90b10b4149@daenzer.net>
 <d0990059-24bb-3f21-8b9d-85761f0be409@amd.com>
 <357b0045-d2a2-2246-b69d-19e657f6e843@amd.com>
 <50899531-c8ea-6562-f7f3-593481bcef60@gmail.com>
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
Message-ID: <f8571bb8-2a9a-e7d0-956a-f5fa39d2a14f@daenzer.net>
Date:   Thu, 6 Dec 2018 10:54:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <50899531-c8ea-6562-f7f3-593481bcef60@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-06 10:49 a.m., Christian König wrote:
> Am 06.12.18 um 10:39 schrieb Zhang, Jerry(Junwei):
>> On 12/6/18 5:33 PM, Koenig, Christian wrote:
>>> Am 06.12.18 um 10:09 schrieb Michel Dänzer:
>>>> On 2018-12-06 3:43 a.m., Zhang, Jerry(Junwei) wrote:
>>>>> On 12/6/18 12:56 AM, Michel Dänzer wrote:
>>>>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>>>>
>>>>>> All the output is related, so it should all be printed the same way.
>>>>>> Some of it was using pr_debug, but some of it appeared in dmesg by
>>>>>> default. The caller should handle failure, so there's no need to spam
>>>>>> dmesg with potentially quite a lot of output by default.
>>>>>>
>>>>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>>>>> Sounds reasonable, but personally prefer to show error when some
>>>>> vital incident happens, e.g. no memory on eviction.
>>>> The amdgpu driver still prints these in that case:
>>>>
>>>>    [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR*
>>>> amdgpu_cs_list_validate(validated) failed.
>>>>    [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Not enough memory for
>>>> command submission!
>>
>> That's from cs submit, perhaps it may come from other places by
>> ttm_bo_evict_mm().
>> Is that right? Christian.
> 
> Yeah, exactly my thinking as well. When we silence the TTM messages we
> might miss those cases.
> 
> Additional to that other drivers using TTM might not have those messages
> either.
> 
> If TTM is to noisy we should use ratelimit and/or reduce the number and
> size of the warning messages.
> 
> A simple "Warning, I ran out of memory during eviction!" should do.

Just dropping the last hunk of this patch should do then. I can do that.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
