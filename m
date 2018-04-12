Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeDLBrd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 21:47:33 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:36485 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLBrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 21:47:32 -0400
X-Google-Smtp-Source: AIpwx48Nk9wXw4o3yuRyEpGSFj7j9BxbJhMg0EP1xwPFnzqg8VrSXGj+j0h7s9CaFLfoWqkPNb6U3+9frRHG6kF1PsE=
MIME-Version: 1.0
In-Reply-To: <CAEJqkgj7uCoaScKwjPVBvWuC+=5OfAuQaO3PfM5J=qbA0v4_EQ@mail.gmail.com>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com> <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com> <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com> <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com> <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com> <7bf2f711-bbd8-cee6-6377-0c4f22db2937@mozilla.com>
 <CAEJqkgj7uCoaScKwjPVBvWuC+=5OfAuQaO3PfM5J=qbA0v4_EQ@mail.gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Thu, 12 Apr 2018 03:47:00 +0200
Message-ID: <CAEJqkgiHNcpsO=az2NQbMqTmYLqgZjCxP96yPC=qgGoxWfrW5g@mail.gmail.com>
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Jean-Marc Valin <jmvalin@mozilla.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3C1lcmH012331

2018-04-12 0:20 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
> 2018-04-11 20:35 GMT+02:00 Jean-Marc Valin <jmvalin@mozilla.com>:
>> On 04/11/2018 05:37 AM, Christian König wrote:
>>>> With your patches my EPYC box is unusable with  4.15++ kernels.
>>>> The whole Desktop is acting weird.  This one is using
>>>> an Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] GPU.
>>>>
>>>> Box is  2 * EPYC 7281 with 128 GB ECC RAM
>>>>
>>>> Also a 14C Xeon box with a HD7700 is broken same way.
>>>
>>> The hardware is irrelevant for this. We need to know what software stack
>>> you use on top of it.
>>
>> Well, the hardware appears to be part of the issue too. I don't think
>> it's a coincidence that Gabriel has the problem on 2xEPYC, I have it on
>> 2xXeon and the previous reported had it on a Core 2 Quad that internally
>> has two dies.
>>
>> I've not yet tested your disable CONFIG_SWIOTLB fix yet -- might try it
>> over the weekend and report what happens.
>>
>
> To get that right .. is only a matter of disabling SWIOTLB *code*
> while CONFIG_SWIOTLB is still set ?

Ok I tested that on 4.16.1 and yes it does work. However I didn't like the
#if 0 method and so compile an kernel twice just to compare an test.

I created an small patch and added swiotlb option for amdgpu and radeon
so I can boot and compare / test with and without SWIOTLB code.

( not meant for upstream )

http://ftp.frugalware.org/pub/other/people/crazy/0001-Make-it-possible-to-disable-SWIOTLB-code-on-admgpu-a.patch

With SWIOTLB code off all works fine , while hell breaks when turning on.

Maybe similar options should be added upstream until code is more
stable in 4.17/4.18

Regards
