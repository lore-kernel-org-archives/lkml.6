Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755590AbeEAN7L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:59:11 -0400
Received: from mail.netline.ch ([148.251.143.178]:37412 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754192AbeEAN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:59:09 -0400
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag
 TTM_PAGE_FLAG_TRANSHUGE
To: Dave Airlie <airlied@gmail.com>,
        "Koenig, Christian" <christian.koenig@amd.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180426150618.13470-1-michel@daenzer.net>
 <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
 <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
 <d5f9459e-801c-e592-d06d-c9052ef3ad4d@amd.com>
 <e5256136-6da0-cc5e-9490-5a70c89dfd83@daenzer.net>
 <361a765a-f491-4450-867e-fa88857827ee@gmail.com>
 <CAPM=9tzmmT5G5a_2WCH5xpRr6rhY6sHdi-Kg5my0az_=haVZTw@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <023175f7-53a0-c85b-f4db-e7d3e3da8691@daenzer.net>
Date: Tue, 1 May 2018 15:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPM=9tzmmT5G5a_2WCH5xpRr6rhY6sHdi-Kg5my0az_=haVZTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-01 01:15 AM, Dave Airlie wrote:
>>
>>
>> Yes, I fixed the original false positive messages myself with the swiotlb
>> maintainer and I was CCed in fixing the recent fallout from Chris changes as
>> well.
> 
> So do we have a good summary of where this at now?
> 
> I'm getting reports on 4.16.4 still displaying these, what hammer do I
> need to hit things with to get 4.16.x+1 to not do this?
> 
> Is there still outstanding issues upstream.

There are, https://patchwork.freedesktop.org/patch/219765/ should
hopefully fix the last of it.


> [...] I've no idea if the swiotlb things people report are the false
> positive, or some new thing.

The issues I've seen reported with 4.16 are false positives from TTM's
perspective, which uses DMA_ATTR_NO_WARN to suppress these warnings, due
to multiple regressions introduced by commit
0176adb004065d6815a8e67946752df4cd947c5b "swiotlb: refactor
 coherent buffer allocation" in 4.16-rc1.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
