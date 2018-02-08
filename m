Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750930AbeBHGVi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 01:21:38 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53842 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHGVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 01:21:37 -0500
X-Google-Smtp-Source: AH8x2255EYFtVh5wQsTqcMWL27kve2QPMjlWJ2QpPTkiakPaD/Bqn0l23hi5GLuaB10OGwkgt8728A==
Subject: Re: [PATCH] ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE
 attribute
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org,
        Stephen Barber <smbarber@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Jaejoong Kim <climbbb.kim@gmail.com>, Julian Scheel <julian@jusst.de>,
        linux-kernel@vger.kernel.org
References: <20180129053755.20136-1-k.marinushkin@gmail.com>
 <s5hvaf95p4i.wl-tiwai@suse.de>
From: Kirill Marinushkin <k.marinushkin@gmail.com>
Message-ID: <40196230-8f73-4cca-08e5-d67bfbea2d6e@gmail.com>
Date: Thu, 8 Feb 2018 07:21:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <s5hvaf95p4i.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/18 06:45, Takashi Iwai wrote:
> On Mon, 29 Jan 2018 06:37:55 +0100,
> Kirill Marinushkin wrote:
>> The layout of the UAC2 Control request and response varies depending on
>> the request type. With the current implementation, only the Layout 2
>> Parameter Block (with the 2-byte sized RANGE attribute) is handled
>> properly. For the Control requests with the 1-byte sized RANGE attribute
>> (Bass Control, Mid Control, Tremble Control), the response is parsed
>> incorrectly.
>>
>> This commit:
>> * fixes the wLength field value in the request
>> * fixes parsing the range values from the response
>>
>> Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
>> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: Jaejoong Kim <climbbb.kim@gmail.com>
>> Cc: Bhumika Goyal <bhumirks@gmail.com>
>> Cc: Stephen Barber <smbarber@chromium.org>
>> Cc: Julian Scheel <julian@jusst.de>
>> Cc: alsa-devel@alsa-project.org
>> Cc: linux-kernel@vger.kernel.org
> Sorry for the late reply, as I've been (and still) off.
>
> Does this bug actually hit on any real devices, or is it only a
> logical error so far?  In the former case, a Cc to stable is
> mandatory.
>
> In anyway, I'll review and merge it properly once after I back to
> work.
>
>
> thanks,
>
> Takashi

Hello Takashi,

Thank you for your answer. I will wait until you are back to work, don't 
worry about the late replies.

I did not hit the issue on a real device.

During my UAC2 experiments, I reproduced this issue on the development 
board, and then tested my solution on it.
 
Best Regards,
Kirill
