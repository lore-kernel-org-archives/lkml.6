Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710E3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146B520652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146B520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeIDT1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:27:46 -0400
Received: from mail.netline.ch ([148.251.143.178]:39716 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeIDT1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:27:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id BF45E2A6049;
        Tue,  4 Sep 2018 17:02:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id UjSA1bCL47W9; Tue,  4 Sep 2018 17:02:13 +0200 (CEST)
Received: from thor (67.124.127.176.dynamic.wline.res.cust.swisscom.ch [176.127.124.67])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 3B9D82A6042;
        Tue,  4 Sep 2018 17:02:13 +0200 (CEST)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1fxCqK-0001Ab-63; Tue, 04 Sep 2018 17:02:12 +0200
Subject: Re: [PATCH 3/5] drm: fix drm_mode_addfb() on big endian machines.
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180903105756.24912-1-kraxel@redhat.com>
 <20180903105756.24912-4-kraxel@redhat.com>
 <20180903164558.GL21634@phenom.ffwll.local>
 <CAKb7Uvh-UB6pR1r-D5sX0HwWwTExVzjxcdeAKNAmRWdqh=hKGw@mail.gmail.com>
 <8e8f8cf3-c4d4-6bfd-4e53-536d4d0c79ff@daenzer.net>
 <CAKb7UvicP594ASs4QutRH4oW1XZ2gTA5Fa=w8FPQzzKaSzDQuw@mail.gmail.com>
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
Message-ID: <4262e9d1-75c9-1be3-08bd-1ef842a13f2f@daenzer.net>
Date:   Tue, 4 Sep 2018 17:02:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKb7UvicP594ASs4QutRH4oW1XZ2gTA5Fa=w8FPQzzKaSzDQuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-04 3:05 p.m., Ilia Mirkin wrote:
> On Tue, Sep 4, 2018 at 4:00 AM, Michel Dänzer <michel@daenzer.net> wrote:
>> On 2018-09-03 7:07 p.m., Ilia Mirkin wrote:
>>> On Mon, Sep 3, 2018 at 12:45 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>>> On Mon, Sep 03, 2018 at 12:57:54PM +0200, Gerd Hoffmann wrote:
>>>>> Userspace on big endian machhines typically expects the ADDFB ioctl
>>>>> returns a big endian framebuffer.  drm_mode_addfb() will call
>>>>> drm_mode_addfb2() unconditionally with little endian DRM_FORMAT_*
>>>>> values though, which is wrong.  This patch fixes that.
>>>>>
>>>>> Drivers (both kernel and xorg) have quirks in place to deal with the
>>>>> broken drm_mode_addfb() behavior.  Because of this we can't just change
>>>>> drm_mode_addfb() behavior for everybody without breaking things.  So add
>>>>> a new driver feature flag DRIVER_PREFER_HOST_BYTE_ORDER, so drivers can
>>>>> opt-in.
>>>>>
>>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>>> ---
>>>>>  include/drm/drm_drv.h             |  1 +
>>>>>  drivers/gpu/drm/drm_framebuffer.c | 11 +++++++++++
>>>>>  2 files changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
>>>>> index 46a8009784..9cf12596cd 100644
>>>>> --- a/include/drm/drm_drv.h
>>>>> +++ b/include/drm/drm_drv.h
>>>>> @@ -57,6 +57,7 @@ struct drm_printer;
>>>>>  #define DRIVER_KMS_LEGACY_CONTEXT    0x20000
>>>>>  #define DRIVER_SYNCOBJ                  0x40000
>>>>>  #define DRIVER_PREFER_XBGR_30BPP        0x80000
>>>>> +#define DRIVER_PREFER_HOST_BYTE_ORDER   0x100000
>>>>
>>>> Hm, not a huge fan of using driver_flags for random little quirks. I think
>>>> a boolean in sturct drm_mode_config would be much better. Bonus if you
>>>> also move the 30bpp hack over to that. Something like
>>>> mode_config.quirk_addfb_host_byte_order and
>>>> mode_config.quirk_addfb_prefer_xbgr_30bpp or whatever. That has the upside
>>>> of giving us a really nice place to put a huge comment about what this is
>>>> supposed to do.
>>>>
>>>> I think otherwise this looks overall rather reasonable. I think the only
>>>> other driver that ever cared about big endian was radeon/amdgpu. Would be
>>>> good to get at least an ack from amd folks, or a "meh, stopped caring".
>>>
>>> and nouveau.
>>>
>>> I do believe that ADDFB should be made to always prefer host byte
>>> order -- this is how all of the existing implementations work in
>>> practice. However e.g. nouveau wants DRM_FORMAT_XRGB8888. But it still
>>> treats it as host byte order. This will become more important in a
>>> world where ADDFB2 is more common.
>>>
>>> So, I think that this change should be applied, drivers (I suspect
>>> just nouveau and radeon) fixed up to consume the "new" formats, [...]
>>
>> As explained before, that would break radeon userspace on big endian hosts.
> 
> We last discussed this about a year ago, so I hope you'll forgive my
> lapse in memory...
> 
> There's userspace that uses ADDFB2 with DRM_FORMAT_XRGB8888 but
> expects it to be host-endian?

ADDFB, not ADDFB2. The latter probably didn't even exist yet when this
was made to work. :)


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
