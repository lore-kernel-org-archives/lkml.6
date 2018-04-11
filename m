Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeDKSfX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 14:35:23 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33043 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeDKSfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 14:35:22 -0400
X-Google-Smtp-Source: AIpwx48Kyi+HSZfRR0fb3g33l2iZIjMbQh+x4cTumV58rZ40cC5if4ilCllEVr+Bk3zKQlkaExt/2w==
Subject: Re: AMD graphics performance regression in 4.15 and later
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Gabriel C <nix.or.die@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix.Kuehling@amd.com, Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
 <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
 <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com>
From: Jean-Marc Valin <jmvalin@mozilla.com>
Message-ID: <7bf2f711-bbd8-cee6-6377-0c4f22db2937@mozilla.com>
Date: Wed, 11 Apr 2018 14:35:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 05:37 AM, Christian König wrote:
>> With your patches my EPYC box is unusable with  4.15++ kernels.
>> The whole Desktop is acting weird.  This one is using
>> an Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] GPU.
>>
>> Box is  2 * EPYC 7281 with 128 GB ECC RAM
>>
>> Also a 14C Xeon box with a HD7700 is broken same way.
> 
> The hardware is irrelevant for this. We need to know what software stack
> you use on top of it.

Well, the hardware appears to be part of the issue too. I don't think
it's a coincidence that Gabriel has the problem on 2xEPYC, I have it on
2xXeon and the previous reported had it on a Core 2 Quad that internally
has two dies.

I've not yet tested your disable CONFIG_SWIOTLB fix yet -- might try it
over the weekend and report what happens.

Cheers,

	Jean-Marc
