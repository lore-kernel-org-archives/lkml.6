Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933206AbeCGKWa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:22:30 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58851 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbeCGKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:22:28 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180307102225euoutp024c31c3bdad47d710fad046cebc0ffa31~ZnD_KHk9O0452204522euoutp02y
X-AuditID: cbfec7f2-1c1ff70000011644-5b-5a9fbd60a836
Subject: Re: [PATCH] crypto: hash.h: Prevent use of req->digest in ahash
 update
To: Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-id: <6fbd6e11-8c5c-4935-6f9e-0cea8f5dd178@partner.samsung.com>
Date: Wed, 07 Mar 2018 11:22:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <0d5cfbd5-8675-290b-f840-d9121872f8da@amd.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOd2EvfOjDGbtkbHYOGM9q8Wc8y0s
        Ft2vZCzu3/vJZHF51xw2iyNT9rE6sHm0XvrL5rFl5U0mj20HVD36tqxi9Pi8SS6ANYrLJiU1
        J7MstUjfLoEr49mPTYwF0yQqjv3pYmtg/CTUxcjJISFgIjFx0lSWLkYuDiGBFYwSfQu/MUM4
        nxklNr1tZ4Sp+nztLStEYhmjxOK+LWwQzjNGiSWn17GAVAkLBEo8eLgZzBYRCJP49mkuI0gR
        s8BCRokf/efZQRJsAuYSj7afYQKxeQXcJLpO/GYDsVkEVCXunb4O1iwqECGxcOpTRogaQYkf
        k+8BxTk4OAWsJVZNjAQJMwtoSrz4MokFwhaXaG69CWXLS2xe8xbsBQmBI2wSH45PZYZ4wUVi
        x5ZP7BC2sMSr41ugbBmJzo6DTBB2ucSmLWvZIZobGCXWvG+C+t9a4vDxi6wQG/gkJm2bzgxy
        kIQAr0RHGzQgPSQO3wIFEUjYUeJbpx8kgE4zSrRf/M00gVFuFpJ3ZiH5YRaSH2Yh+WEBI8sq
        RvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2MwFRy+t/xTzsYv15KOsQowMGoxMMbsXdelBBr
        YllxZe4hRgkOZiUR3skl86OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YW
        pBbBZJk4OKUaGB111P0/XG+Vs47x0o+Kl/Y6XP08duasFMXjfa9OnlumY83aIbwvWX0ey5f1
        H4oeXmSLs9Rhu/f9R9fnTmHGQ/y9jy9qlKbsrs948bJ2yu6ffKlSywuY+pdInayUbui3/XRp
        5cIbXeEcPu6uH79uy55WkGy0/3/DMS2DXQvdIi/PfyzdG9R6RImlOCPRUIu5qDgRAAyimmUh
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsVy+t/xq7rxe+dHGWw6amixccZ6Vos551tY
        LLpfyVjcv/eTyeLyrjlsFkem7GN1YPNovfSXzWPLyptMHtsOqHr0bVnF6PF5k1wAaxSXTUpq
        TmZZapG+XQJXxrMfmxgLpklUHPvTxdbA+Emoi5GTQ0LAROLztbesXYxcHEICSxglet8cYARJ
        CAk8Y5S49FwBxBYW8JdY/P8KK4gtIhAm8XD1Q3aQBmaBhYwSkxYfg+o+C+QsuMUGUsUmYC7x
        aPsZJhCbV8BNouvEb7A4i4CqxL3T11lAbFGBCInOlfNZIGoEJX5Mvgdkc3BwClhLrJoYCWIy
        C6hLTJmSC1LBLCAu0dx6kwXClpfYvOYt8wRGgVlImmchdMxC0jELSccCRpZVjCKppcW56bnF
        hnrFibnFpXnpesn5uZsYgaG+7djPzTsYL20MPsQowMGoxMO7Yf+8KCHWxLLiytxDjBIczEoi
        vJNL5kcJ8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYJzq
        aHnMZJtqXnngpdpZbqvLW+r+BOyb0uSi4M0bcyPpiNa9Y0JWscqnF+2/vG3z34g3XHXPpGJY
        C97/kn2tGrjtuXyY2VSXqS0v5608nPz7Q5JY2Y2ayA9fY3M2LCz0L1t4Or9G/mL9z4ySeQLT
        pBd0Fx0zkdWyW9qutFVqvfKjFSvmtF07+leJpTgj0VCLuag4EQDWOvYIcQIAAA==
X-CMS-MailID: 20180307102223eucas1p19ea3b588b4788085ac7c0f164b916e3b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180306114512eucas1p286d36bafa1bc719d7e7ccbaa9f549fc1
X-RootMTR: 20180306114512eucas1p286d36bafa1bc719d7e7ccbaa9f549fc1
References: <CGME20180306114512eucas1p286d36bafa1bc719d7e7ccbaa9f549fc1@eucas1p2.samsung.com>
        <c29d442e-22b6-9013-05a4-32c8eb04b692@partner.samsung.com>
        <0d5cfbd5-8675-290b-f840-d9121872f8da@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.2018 19:04, Tom Lendacky wrote:
> On 3/6/2018 5:45 AM, Kamil Konieczny wrote:
>> Prevent improper use of req->digest field in ahash update, init, export and
> 
> Shouldn't that be req->result (here and below)?

Yes, it should, I will send version 2 soon,
thank you.

Best regards,
Kamil Konieczny

>> import functions in drivers code. A driver should use ahash request context
>> if it needs to save internal state.
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>>  include/crypto/hash.h | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
>> index 2d1849dffb80..e97c2e662d6a 100644
>> --- a/include/crypto/hash.h
>> +++ b/include/crypto/hash.h
>> @@ -74,7 +74,8 @@ struct ahash_request {
>>   * @init: **[mandatory]** Initialize the transformation context. Intended only to initialize the
>>   *	  state of the HASH transformation at the beginning. This shall fill in
>>   *	  the internal structures used during the entire duration of the whole
>> - *	  transformation. No data processing happens at this point.
>> + *	  transformation. No data processing happens at this point. Driver code
>> + *	  implementation must not use req->digest.
>>   * @update: **[mandatory]** Push a chunk of data into the driver for transformation. This
>>   *	   function actually pushes blocks of data from upper layers into the
>>   *	   driver, which then passes those to the hardware as seen fit. This
>> @@ -83,7 +84,8 @@ struct ahash_request {
>>   *	   transformation. This function shall not modify the transformation
>>   *	   context, as this function may be called in parallel with the same
>>   *	   transformation object. Data processing can happen synchronously
>> - *	   [SHASH] or asynchronously [AHASH] at this point.
>> + *	   [SHASH] or asynchronously [AHASH] at this point. Driver must not use
>> + *	   req->digest.
>>   * @final: **[mandatory]** Retrieve result from the driver. This function finalizes the
>>   *	   transformation and retrieves the resulting hash from the driver and
>>   *	   pushes it back to upper layers. No data processing happens at this
>> @@ -120,11 +122,12 @@ struct ahash_request {
>>   *	    you want to save partial result of the transformation after
>>   *	    processing certain amount of data and reload this partial result
>>   *	    multiple times later on for multiple re-use. No data processing
>> - *	    happens at this point.
>> + *	    happens at this point. Driver must not use req->digest.
>>   * @import: Import partial state of the transformation. This function loads the
>>   *	    entire state of the ongoing transformation from a provided block of
>>   *	    data so the transformation can continue from this point onward. No
>> - *	    data processing happens at this point.
>> + *	    data processing happens at this point. Driver must not use
>> + *	    req->digest.
>>   * @halg: see struct hash_alg_common
>>   */
>>  struct ahash_alg {
>>
> 
> 
> 
