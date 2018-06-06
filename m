Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht60gzYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FED7601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeFFNeW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:34:22 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38330 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeFFNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:34:20 -0400
X-Google-Smtp-Source: ADUXVKJ8IA/Uo3pldx1Ta+yozwKBUw4rysef7d6UFX/MFiJ8cNWSX+al/l176ExvtOwH63kHoIEctqdWUrnB1qtKOQo=
MIME-Version: 1.0
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 6 Jun 2018 15:33:47 +0200
Message-ID: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        michel.daenzer@amd.com, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-06 14:19 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.com>:
> Am 06.06.2018 um 14:08 schrieb Gabriel C:
>>
>> 2018-06-06 13:33 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.co=
m>:
>>>
>>> Am 06.06.2018 um 13:28 schrieb Gabriel C:
>>>>
>>>> 2018-04-11 7:02 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>>>>
>>>>>> 2018-04-11 6:00 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>>>> 2018-04-09 11:42 GMT+02:00 Christian K=C3=B6nig
>>>>>> <ckoenig.leichtzumerken@gmail.com>:
>>>>>>>
>>>>>>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>>>>
>>>>> ...
>>>>>>
>>>>>> I can help testing code for 4.17/++ if you wish but that is
>>>>>> *different*
>>>>>> storry.
>>>>>>
>>>>> Quick tested an 4.16.0-11490-gb284d4d5a678 , amdgpu and radeon driver
>>>>> are broken now in this one.
>>>>>
>>>>> radeon tells:
>>>>>
>>>>> ...
>>>>>
>>>>> [    6.337838] [drm] PCIE GART of 2048M enabled (table at
>>>>> 0x00000000001D6000).
>>>>> [    6.338210] radeon 0000:21:00.0: (-12) create WB bo failed
>>>>> [    6.338214] radeon 0000:21:00.0: disabling GPU acceleration
>>>>>
>>>>> ...
>>>>>
>>>> I have the same Issue now on final 4.17.
>>>
>>>
>>> Actually Michel came up with a fix for the performance regression which
>>> is
>>> now backported to older kernels as well.
>>>
>>> So the original issue of this mail thread should be fixed by now.
>>
>> Ok , will test as soon I get the GPU to work :))
>>
>>>> Also I played with BIOS options also which does not fix anything but
>>>> changes the error message.
>>>>
>>>> IOMMU && SR-IOV disabled the error changes to this :
>>>>
>>>> [    7.092044] [drm:r600_ring_test [radeon]] *ERROR* radeon: ring 0
>>>> test failed (scratch(0x850C)=3D0xCAFEDEAD)
>>>> [    7.092059] radeon 0000:21:00.0: disabling GPU acceleration
>>>>
>>>>
>>>> While I could workaround SWIOTLB bugs in 4.15 and 4.16 , 4.17 seems to
>>>> kill the GPU with no way
>>>> for me to make it work ( at least I could not find any workaround by n=
ow
>>>> )
>>>
>>>
>>> That actually sounds like something completely different. Can you provi=
de
>>> a
>>> full dmesg of radeon and/or amdgpu?
>>
>> Sure here from boot with IOMMU/SR-IOV ON/OFF in BIOS :
>>
>>
>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-i=
ov-off.txt
>>
>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-i=
ov-on.txt
>>
>> Also nothing else changed in that setup just testing kernel 4.17.
>
>
> That has nothing TODO with the driver nor the original bug you reported. =
The
> problem is that SME is active and that is currently not supported at all
> with a that hardware.

Ok .. so are we playing now kernel an AMD Hardware roulette on each release=
 ?

SME was like this in kernel 4.16.x here and all worked.

Also if you don't support SME at all now on that Hardware while worked befo=
re
please add proper error handling and proper dmesg messages
letting the user know.

radeon: xxxx : SME not supported on that Hardware anymore , please
disable SME...
radeon: xxxx: Update your GPU < or whatever >

How hard would be that ?

No one but developers , can guess from these error messges why his
hardware  suddenly  isn't working anymore by just updating the kernel.


>
> Try to disable SME either in the BIOS or on the kernel command line.

Yes that works but is not the point.

Really you just can't break users setups like this.
