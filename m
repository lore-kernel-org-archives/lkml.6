Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEA32176F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbeLUJ4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:56:03 -0500
Received: from mail.netline.ch ([148.251.143.178]:57959 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbeLUJ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:56:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 445862A6057;
        Fri, 21 Dec 2018 10:56:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MqFyEuBgndZT; Fri, 21 Dec 2018 10:55:59 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 5CA502A6055;
        Fri, 21 Dec 2018 10:55:59 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gaHXD-0001mW-3L; Fri, 21 Dec 2018 10:55:59 +0100
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
To:     "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     "dnicoara@chromium.org" <dnicoara@chromium.org>,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        Alexandros Frantzis <alexandros.frantzis@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        "kernel@collabora.com" <kernel@collabora.com>
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
 <0bbee54e-7666-3d83-c80a-8ed2b4cc737d@amd.com>
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
Message-ID: <1c36151b-741f-0c25-2607-d36738937aba@daenzer.net>
Date:   Fri, 21 Dec 2018 10:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <0bbee54e-7666-3d83-c80a-8ed2b4cc737d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-20 6:38 p.m., Kazlauskas, Nicholas wrote:
> On 12/20/18 12:09 PM, Daniel Vetter wrote:
>> On Thu, Dec 20, 2018 at 6:03 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>> On Thu, Dec 20, 2018 at 11:54 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>>>>
>>>> Not sure about the gamma thing since we had opposite bugs on i915
>>>> about gamma not being vsynced and tearing terribly. Cursor is special
>>>> since it tends to be too small to notice tearing.
>>>
>>> Our cursor hw (and possibly gamma as well Nicholas?  Harry?) is double
>>> buffered, so we can update it any time for the most part and the
>>> changes won't take affect until the next vupdate period.
> 
> I haven't really investigated too much into the gamma stuttering issue, 
> but I think it's similar to the cursor update - a high volume of atomic 
> updates that ends up skipping over a vblank or two.

FWIW, I don't think the use-cases described in
https://bugs.freedesktop.org/108917 (Night Light / RedShift) involve a
particularly high volume of gamma updates. I was able to reproduce the
stuttering with ~10 gamma changes per second, but I suspect even a
single one could cause a frame drop. I assume the issue is that gamma
updates are done as separate atomic commits, which can delay other
commits for page flips.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
