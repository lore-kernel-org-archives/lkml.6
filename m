Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeA3KC3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:02:29 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.206]:46161 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751496AbeA3KCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:02:23 -0500
Date: Tue, 30 Jan 2018 04:02:22 -0600
Message-ID: <20180130040222.Horde.f-T_LoXaosAs8kCmN9RdOXK@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/edid: use false for boolean value
References: <20180123164607.GA25071@embeddedgus>
 <20180130094353.GH25930@phenom.ffwll.local>
In-Reply-To: <20180130094353.GH25930@phenom.ffwll.local>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 108.167.133.22
X-Source-L: Yes
X-Exim-ID: 1egSkA-001Z61-Kw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:14402
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Quoting Daniel Vetter <daniel@ffwll.ch>:

> On Tue, Jan 23, 2018 at 10:46:07AM -0600, Gustavo A. R. Silva wrote:
>> Assign true or false to boolean variables instead of an integer value.
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Thanks for your patch.
>
>> ---
>>  drivers/gpu/drm/drm_edid.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index ddd5379..45a80d7 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -2767,7 +2767,7 @@ do_detailed_mode(struct detailed_timing  
>> *timing, void *c)
>>
>>  		drm_mode_probed_add(closure->connector, newmode);
>>  		closure->modes++;
>> -		closure->preferred = 0;
>> +		closure->preferred = false;
>
> There's also
>
> 		.preferred = 1,
>
> in add_detailed_modes. Please fix that one up too for consistency, then
> I'll merge your patch.
>

Sure. I'll send a new patch shortly.

I also need to update the Coccinelle script to catch those cases.

Thanks for the feedback.
--
Gustavo
