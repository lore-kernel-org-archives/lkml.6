Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeEAW0H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:26:07 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42353 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeEAW0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:26:06 -0400
X-Google-Smtp-Source: AB8JxZqigOX3a9p9j+pUfqj9ooEL2gK8l2Ib655BaK2/9joUHk+rReCfmbYZV/ZZaFqmqgHp38CBWA==
Subject: Re: [PATCH] proc/kcore: Don't bounds check against address 0
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Anderson <anderson@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <andi@firstfloor.org>
References: <1039518799.26129578.1525185916272.JavaMail.zimbra@redhat.com>
 <20180501201143.15121-1-labbott@redhat.com>
 <20180501144604.1cf872e7938bffc01a26349f@linux-foundation.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <4db64722-47b5-767c-4090-bdd9c1522e96@redhat.com>
Date: Tue, 1 May 2018 15:26:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501144604.1cf872e7938bffc01a26349f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 02:46 PM, Andrew Morton wrote:
> On Tue,  1 May 2018 13:11:43 -0700 Laura Abbott <labbott@redhat.com> wrote:
> 
>> The existing kcore code checks for bad addresses against
>> __va(0) with the assumption that this is the lowest address
>> on the system. This may not hold true on some systems (e.g.
>> arm64) and produce overflows and crashes. Switch to using
>> other functions to validate the address range.
>>
>> Tested-by: Dave Anderson <anderson@redhat.com>
>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>> ---
>> I took your previous comments as a tested by, please let me know if that
>> was wrong. This should probably just go through -mm. I don't think this
>> is necessary for stable but I can request it later if necessary.
> 
> I'm surprised.  "overflows and crashes" sounds rather serious??
> 

It's currently only seen on arm64 and it's not clear if anyone
wants to use that particular combination on a stable release.
I think a better phrase is "this is not urgent for stable".

Thanks,
Laura
