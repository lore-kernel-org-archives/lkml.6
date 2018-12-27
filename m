Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A722EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DF9214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 11:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbeL0LzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 06:55:06 -0500
Received: from mail.netline.ch ([148.251.143.178]:38128 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbeL0LzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 06:55:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 5C4622A605E;
        Thu, 27 Dec 2018 12:55:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id C7abSc3RHOD7; Thu, 27 Dec 2018 12:55:01 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 177CF2A605D;
        Thu, 27 Dec 2018 12:55:01 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gcUFg-00086r-LE; Thu, 27 Dec 2018 12:55:00 +0100
Subject: Re: [PATCH 2/3] drm/amd: validate user pitch alignment
To:     Yu Zhao <yuzhao@google.com>
Cc:     David Zhou <David1.Zhou@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Samuel Li <Samuel.Li@amd.com>
References: <20181221031053.240161-1-yuzhao@google.com>
 <20181221031053.240161-2-yuzhao@google.com>
 <90677da7-d74d-c725-f669-88fe18789d5b@daenzer.net>
 <20181223214439.GA157289@google.com>
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
Message-ID: <3e7afc3a-cfe5-234b-8a32-00bf4746d5e7@daenzer.net>
Date:   Thu, 27 Dec 2018 12:54:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181223214439.GA157289@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-23 10:44 p.m., Yu Zhao wrote:
> On Fri, Dec 21, 2018 at 10:07:26AM +0100, Michel Dänzer wrote:
>> On 2018-12-21 4:10 a.m., Yu Zhao wrote:
>>> Userspace may request pitch alignment that is not supported by GPU.
>>> Some requests 32, but GPU ignores it and uses default 64 when cpp is
>>> 4. If GEM object is allocated based on the smaller alignment, GPU
>>> DMA will go out of bound.
>>>
>>> For GPU that does frame buffer compression, DMA writing out of bound
>>> memory will cause memory corruption.
>>>
>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>>> index e309d26170db..755daa332f8a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>>> @@ -527,6 +527,15 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
>>>  	struct drm_gem_object *obj;
>>>  	struct amdgpu_framebuffer *amdgpu_fb;
>>>  	int ret;
>>> +	struct amdgpu_device *adev = dev->dev_private;
>>> +	int cpp = drm_format_plane_cpp(mode_cmd->pixel_format, 0);
>>> +	int pitch = amdgpu_align_pitch(adev, mode_cmd->width, cpp, false);
>>
>> Also, this needs to use mode_cmd->pitches[0] instead of mode_cmd->width,
>> otherwise it'll spuriously fail for larger but well-aligned pitches.
> 
> Actually mode_cmd->pitches[0] is aligned mode_cmd->width multiplied
> by cpp. So we can't just use mode_cmd->pitches[0].

Use mode_cmd->pitches[0] / cpp then?


> And I'm not sure if the hardware works with larger alignment

It does.

> (it certainly ignores smaller alignment).

Yeah, pitch must be >= width. Maybe this patch could check that as well.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
