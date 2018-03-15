Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeCONrI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:47:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35998 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752438AbeCONrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:47:05 -0400
X-Google-Smtp-Source: AG47ELtTnoBo8ZLZcoVtsUNKMT/4z9NyfTjCd8Fg8p3BhQZc8AAY+/u2dEPKF6yWor5yKDUx/JXe5A==
Subject: Re: [PATCH v1 2/3] drm/tegra: plane: Correct legacy blending
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
 <00cf4565238be471c90e5823e53e0ed504869bfe.1521075485.git.digetx@gmail.com>
 <20180315102905.GB15393@ulmo>
 <16e06ec0-af24-e2c1-b400-2ff1acae931c@gmail.com>
Message-ID: <5bb313f0-8d90-3cd6-5680-bb695d9b7e2a@gmail.com>
Date: Thu, 15 Mar 2018 16:47:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <16e06ec0-af24-e2c1-b400-2ff1acae931c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2018 15:42, Dmitry Osipenko wrote:
> On 15.03.2018 13:29, Thierry Reding wrote:
>> On Thu, Mar 15, 2018 at 04:00:24AM +0300, Dmitry Osipenko wrote:
>>> Keep old 'dependent' state of unaffected planes, this way new state takes
>>> into account current state of unaffected planes.
>>>
>>> Fixes: ebae8d07435a ("drm/tegra: dc: Implement legacy blending")
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/gpu/drm/tegra/plane.c | 15 ++++++---------
>>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
>>> index fc37dcf8c458..3c0cb6a04c66 100644
>>> --- a/drivers/gpu/drm/tegra/plane.c
>>> +++ b/drivers/gpu/drm/tegra/plane.c
>>> @@ -287,13 +287,11 @@ unsigned int tegra_plane_format_adjust(unsigned int opaque)
>>>  	return opaque;
>>>  }
>>>  
>>> -unsigned int tegra_plane_get_overlap_index(struct tegra_plane *plane,
>>> -					   struct tegra_plane *other)
>>> +static unsigned int tegra_plane_get_overlap_index(struct tegra_plane *plane,
>>> +						  struct tegra_plane *other)
>>
>> I'd prefer this to be a separate patch to keep the diff down to make
>> this easier to apply to v4.16. I can do that when I apply, no need to
>> resend.
> 
> Okay. But now I'm thinking that it's probably not really worth to backport this
> patch at all because it doesn't fix blending entirely, but only makes it good
> enough to show cursor plane properly. I'll send V2.

Ah, didn't notice that I don't have to re-send. I've spotted other problem in
the patch, so will just send V2 ;)
