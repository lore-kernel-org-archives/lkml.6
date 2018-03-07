Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754669AbeCGR1C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:27:02 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38272 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754248AbeCGR1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:27:00 -0500
X-Google-Smtp-Source: AG47ELvwtrzn/SKlq8FpQ5RUGevXq5sUJzE/9obWW0aXUTBtP2xHil6c+RtTUoj7FgKWYYsanBRYiQ==
Subject: Re: [PATCH 6/7] lkdtm: crash on overwriting protected pmalloc var
To: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
        willy@infradead.org, keescook@chromium.org, mhocko@kernel.org
Cc: labbott@redhat.com, linux-security-module@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-7-igor.stoppa@huawei.com>
 <1723ee8d-c89e-0704-c2c3-254eda39dc8b@gmail.com>
 <6378e63e-174f-642e-d319-1d121b74d3d7@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <2664691b-4d48-1701-8dae-774ec7733f61@gmail.com>
Date: Wed, 7 Mar 2018 09:26:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6378e63e-174f-642e-d319-1d121b74d3d7@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/18 5:18 AM, Igor Stoppa wrote:
>
> On 06/03/18 19:20, J Freyensee wrote:
>
>> On 2/28/18 12:06 PM, Igor Stoppa wrote:
> [...]
>
>>>    void __init lkdtm_perms_init(void);
>>>    void lkdtm_WRITE_RO(void);
>>>    void lkdtm_WRITE_RO_AFTER_INIT(void);
>>> +void lkdtm_WRITE_RO_PMALLOC(void);
>> Does this need some sort of #ifdef too?
> Not strictly. It's just a function declaration.
> As long as it is not used, the linker will not complain.
> The #ifdef placed around the use and definition is sufficient, from a
> correctness perspective.
>
> But it's a different question if there is any standard in linux about
> hiding also the declaration.


I'd prefer hiding it if it's contents are being ifdef'ed out, but I 
really think it's more of a maintainer preference question.


>
> I am not very fond of #ifdefs, so when I can I try to avoid them.
>
>
