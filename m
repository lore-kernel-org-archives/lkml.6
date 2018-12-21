Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2102C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80A92173C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbeLUJrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:47:31 -0500
Received: from mail.netline.ch ([148.251.143.178]:57772 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbeLUJrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:47:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 4D95C2A6056;
        Fri, 21 Dec 2018 10:47:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0dEzdcgAPg9s; Fri, 21 Dec 2018 10:47:27 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id A283C2A6055;
        Fri, 21 Dec 2018 10:47:27 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gaHOx-0001hh-CB; Fri, 21 Dec 2018 10:47:27 +0100
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     dnicoara@chromium.org,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>, kernel@collabora.com,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com>
 <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
 <CAAFQd5BczTNdwUNcx42hC=OKkgZTV9JevHetYOjfDCnEz29LpA@mail.gmail.com>
 <0a0a35bf-69e4-8dcd-46fc-7053081480d5@collabora.com>
 <CAAFQd5C15yF4TwOLu4JsFGMSzLp8isV89WOZyRfv9wCcGfFRtg@mail.gmail.com>
 <CAKMK7uG=vdaTo25b3gSaD4T2naA51VeaVL0+5YAJ9HMrBziTWQ@mail.gmail.com>
 <CADnq5_P9nsquCV95CSZC4NCr7YNJ76ZmCruJA=f1N8dLGYm=ow@mail.gmail.com>
 <CAKMK7uHu5XMQzr7ocVEcpDS9H6pQ-BHfHNE51_YK7rLkTQC_9g@mail.gmail.com>
 <CADnq5_P1smiGhYyoZQsEAJG0+jBx6f75HwEFAf2RkaoNp0HEiA@mail.gmail.com>
 <CAKMK7uGSiBv9H_xAj2fuk=XYocefQU4bFk+fPr=iWGsaPxOwhw@mail.gmail.com>
 <fb45217c-d9ad-b208-d55d-51299ead108b@daenzer.net>
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
Message-ID: <9be83a7f-aa5f-8d8f-0486-db68e12c5feb@daenzer.net>
Date:   Fri, 21 Dec 2018 10:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <fb45217c-d9ad-b208-d55d-51299ead108b@daenzer.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-20 6:16 p.m., Michel Dänzer wrote:
> On 2018-12-20 6:09 p.m., Daniel Vetter wrote:
>> On Thu, Dec 20, 2018 at 6:03 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>> On Thu, Dec 20, 2018 at 11:54 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>>>> Not sure about the gamma thing since we had opposite bugs on i915
>>>> about gamma not being vsynced and tearing terribly. Cursor is special
>>>> since it tends to be too small to notice tearing.
>>>
>>> Our cursor hw (and possibly gamma as well Nicholas?  Harry?) is double
>>> buffered, so we can update it any time for the most part and the
>>> changes won't take affect until the next vupdate period.
>>
>> Hm, I guess we could make the gamma update optionally async, and let
>> drivers deal. The issue is that the current async helper stuff won't
>> cope with gamma updates (it's aimed at plane updates only, not at crtc
>> property updates). Or we get userspace to do proper atomic updates. Or
>> we do some faking in the kernel, e.g. waiting with the gamma update
>> until the next atomic update happens. But that kinda breaks
>> ->atomic_check.
> 
> Would it be possible to merge gamma changes into a pending commit, if
> there is one, and create a new commit otherwise?
> 
> Otherwise the atomic API just moves this same problem to be solved by
> userspace.

Actually, I'm not sure this is even solvable in a Xorg driver. When it
gets called to update the gamma LUT:

1. If there's a pending atomic commit, it cannot amend that, can it?

2. It has no way of knowing when the next atomic commit would be
submitted e.g. for a page flip, so it kind of has to create its own
commit for the gamma update.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
