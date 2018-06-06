Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3SaTulC"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C855606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeFFMJC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:09:02 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39736 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbeFFMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:09:00 -0400
X-Google-Smtp-Source: ADUXVKI60JuKC/gyJVLgrHI9OUYgwXu/hoNEBToRFJNRPlFimEOPamXLdq7SmPY4xMmX97hBREVRvlV+ZlJ4s5BZDfY=
MIME-Version: 1.0
In-Reply-To: <52eceaff-987d-4c1d-a2cb-73b28e48c01c@amd.com>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com> <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com> <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com> <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com> <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <CAEJqkgjfhmjwYo74xivsfgvoPQUFh2dFeXFwtEKoN+DXG1riMg@mail.gmail.com>
 <CAEJqkgiVdeBf9konX4OJi59dYp4y_b+J02ns=yf-D6tjtZ7P1g@mail.gmail.com> <52eceaff-987d-4c1d-a2cb-73b28e48c01c@amd.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 6 Jun 2018 14:08:28 +0200
Message-ID: <CAEJqkgiBZ6G+tXWULYoGKqq3BsgvH7TrqkFbhtRL4JnGM+dLuA@mail.gmail.com>
Subject: Re: AMD graphics performance regression in 4.15 and later
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

2018-06-06 13:33 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.com>:
> Am 06.06.2018 um 13:28 schrieb Gabriel C:
>>
>> 2018-04-11 7:02 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>>
>>>> 2018-04-11 6:00 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>> 2018-04-09 11:42 GMT+02:00 Christian K=C3=B6nig
>>>> <ckoenig.leichtzumerken@gmail.com>:
>>>>>
>>>>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>>
>>> ...
>>>>
>>>> I can help testing code for 4.17/++ if you wish but that is *different=
*
>>>> storry.
>>>>
>>> Quick tested an 4.16.0-11490-gb284d4d5a678 , amdgpu and radeon driver
>>> are broken now in this one.
>>>
>>> radeon tells:
>>>
>>> ...
>>>
>>> [    6.337838] [drm] PCIE GART of 2048M enabled (table at
>>> 0x00000000001D6000).
>>> [    6.338210] radeon 0000:21:00.0: (-12) create WB bo failed
>>> [    6.338214] radeon 0000:21:00.0: disabling GPU acceleration
>>>
>>> ...
>>>
>> I have the same Issue now on final 4.17.
>
>
> Actually Michel came up with a fix for the performance regression which i=
s
> now backported to older kernels as well.
>
> So the original issue of this mail thread should be fixed by now.

Ok , will test as soon I get the GPU to work :))

>
>> Also I played with BIOS options also which does not fix anything but
>> changes the error message.
>>
>> IOMMU && SR-IOV disabled the error changes to this :
>>
>> [    7.092044] [drm:r600_ring_test [radeon]] *ERROR* radeon: ring 0
>> test failed (scratch(0x850C)=3D0xCAFEDEAD)
>> [    7.092059] radeon 0000:21:00.0: disabling GPU acceleration
>>
>>
>> While I could workaround SWIOTLB bugs in 4.15 and 4.16 , 4.17 seems to
>> kill the GPU with no way
>> for me to make it work ( at least I could not find any workaround by now=
 )
>
>
> That actually sounds like something completely different. Can you provide=
 a
> full dmesg of radeon and/or amdgpu?

Sure here from boot with IOMMU/SR-IOV ON/OFF in BIOS :

http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-=
off.txt
http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-sr-iov-=
on.txt

Also nothing else changed in that setup just testing kernel 4.17.

I can force the GPU to use amdgpu if you wish and post dmesg's too.
Just let me know
