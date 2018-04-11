Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbeDKEBU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:01:20 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:40625 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeDKEBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:01:19 -0400
X-Google-Smtp-Source: AIpwx48FoRem6gUX2smiTqXo9FaCVAxWfwAYe1KTV9T7QYx2CfJm+csIuVTj7XBSycOrarP+TlX5xzPOjUo73d6zyPw=
MIME-Version: 1.0
In-Reply-To: <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com> <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com> <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com> <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 11 Apr 2018 06:00:47 +0200
Message-ID: <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
Subject: Re: AMD graphics performance regression in 4.15 and later
To: christian.koenig@amd.com
Cc: Jean-Marc Valin <jmvalin@mozilla.com>, Dave Airlie <airlied@linux.ie>,
        alexander.deucher@amd.com, Felix.Kuehling@amd.com,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3B41QAE026464

2018-04-09 11:42 GMT+02:00 Christian König <ckoenig.leichtzumerken@gmail.com>:
> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>
>> Hi Christian,
>>
>> Thanks for the info. FYI, I've also opened a Firefox bug for that at:
>> https://bugzilla.mozilla.org/show_bug.cgi?id=1448778
>> Feel free to comment since you have a better understanding of what's
>> going on.
>>
>> One last question: right now I'm running 4.15.0 with the "offending"
>> patch reverted. Is that safe to run or are there possible bad
>> interactions with other changes.
>
>
> That should work without problems.
>
> But I just had another idea as well, if you want you could still test the
> new code path which will be using in 4.17.
>

While Firefox may do some strange things is not about only Firefox.

With your patches my EPYC box is unusable with  4.15++ kernels.
The whole Desktop is acting weird.  This one is using
an Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] GPU.

Box is  2 * EPYC 7281 with 128 GB ECC RAM

Also a 14C Xeon box with a HD7700 is broken same way.

Everything breaks in X .. scrolling , moving windows , flickering etc.


reverting f4c809914a7c3e4a59cf543da6c2a15d0f75ee38 and
648bc3574716400acc06f99915815f80d9563783
from an 4.15 kernel makes things work again.


> Backporting all the detection logic is to invasive, but you could just go
> into drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c and forcefull use the other
> code path.
>
> Just look out for "#ifdef CONFIG_SWIOTLB" checks and disable those.
>

Well you really can't be serious about these suggestions ? Are you ?

Telling peoples to #if 0 random code is not a solution.

You broke existsing working userland with your patches and at least
please fix that for 4.16.

I can help testing code for 4.17/++ if you wish but that is *different* storry.

Regards,

Gabriel C
