Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbeDKO13 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:27:29 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:45125 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeDKO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:27:27 -0400
X-Google-Smtp-Source: AIpwx49eHoUni5YWxml23hW6YSqOziW54kjLysmGrTxM/WKiS6NBE+dZ2kYxpupAiE3K59/j5UYAMy7xYScpdLAsjDo=
MIME-Version: 1.0
In-Reply-To: <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com> <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com> <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com> <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com> <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 11 Apr 2018 16:26:54 +0200
Message-ID: <CAEJqkgje5Q=FLXLr_nR0gUwPpEuzx=Ln1nucJQRDXWW_0Byg=w@mail.gmail.com>
Subject: Re: AMD graphics performance regression in 4.15 and later
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>, Dave Airlie <airlied@linux.ie>,
        alexander.deucher@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3BESPE1024318

2018-04-11 11:37 GMT+02:00 Christian König <christian.koenig@amd.com>:
> Am 11.04.2018 um 06:00 schrieb Gabriel C:
>>
>> 2018-04-09 11:42 GMT+02:00 Christian König
>> <ckoenig.leichtzumerken@gmail.com>:
>>>
>>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>>>
>>>> Hi Christian,
>>>>
>>>> Thanks for the info. FYI, I've also opened a Firefox bug for that at:
>>>> https://bugzilla.mozilla.org/show_bug.cgi?id=1448778
>>>> Feel free to comment since you have a better understanding of what's
>>>> going on.
>>>>
>>>> One last question: right now I'm running 4.15.0 with the "offending"
>>>> patch reverted. Is that safe to run or are there possible bad
>>>> interactions with other changes.
>>>
>>>
>>> That should work without problems.
>>>
>>> But I just had another idea as well, if you want you could still test the
>>> new code path which will be using in 4.17.
>>>
>> While Firefox may do some strange things is not about only Firefox.
>>
>> With your patches my EPYC box is unusable with  4.15++ kernels.
>> The whole Desktop is acting weird.  This one is using
>> an Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] GPU.
>>
>> Box is  2 * EPYC 7281 with 128 GB ECC RAM
>>
>> Also a 14C Xeon box with a HD7700 is broken same way.
>
>
> The hardware is irrelevant for this. We need to know what software stack you
> use on top of it.
>
> E.g. desktop environment/Mesa and DDX version etc...

Plasma 5.12.4 compiled wth frameworks 5.44.0 , Qt5 5.10.1
mesa 18.0.0 and mesa 17.3.7 on the other box
Xorg is 1.19.6
xf86-video-amdgpu and xf86-video-ati both 18.0.1

>
>>
>> Everything breaks in X .. scrolling , moving windows , flickering etc.
>>
>>
>> reverting f4c809914a7c3e4a59cf543da6c2a15d0f75ee38 and
>> 648bc3574716400acc06f99915815f80d9563783
>> from an 4.15 kernel makes things work again.
>>
>>
>>> Backporting all the detection logic is to invasive, but you could just go
>>> into drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c and forcefull use the other
>>> code path.
>>>
>>> Just look out for "#ifdef CONFIG_SWIOTLB" checks and disable those.
>>>
>> Well you really can't be serious about these suggestions ? Are you ?
>>
>> Telling peoples to #if 0 random code is not a solution.
>
>
> That is for testing and not a permanent solution.
>
>> You broke existsing working userland with your patches and at least
>> please fix that for 4.16.
>>
>> I can help testing code for 4.17/++ if you wish but that is *different*
>> storry.
>
>
> Please test Alex's amd-staging-drm-next branch from
> git://people.freedesktop.org/~agd5f/linux.

I'm on it just the connection to freedesktop.org is slow as hell.
Will take a while to get that branch with 62KiB/s :)

Regards
