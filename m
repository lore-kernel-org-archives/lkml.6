Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeEHHEW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:04:22 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:41641 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754272AbeEHHEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:04:20 -0400
X-Google-Smtp-Source: AB8JxZqXjn2FPRlnEeMxbjkHkG7J8WIyMg3mCbAnYxD80Ox0x9mj+hLsIf76e++j5v+osqMc+GB94g==
Subject: Re: [PATCH] xen: xenbus: Fix a possible data race in xs_request_enter
To: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com,
        simon@invisiblethingslab.com, joao.m.martins@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180508033429.12749-1-baijiaju1990@gmail.com>
 <ea5634a2-b0e2-0fac-e5ec-cef1083958fe@suse.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <770bc26b-3819-2235-132f-55b0319955dd@gmail.com>
Date: Tue, 8 May 2018 15:04:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ea5634a2-b0e2-0fac-e5ec-cef1083958fe@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/8 15:02, Juergen Gross wrote:
> On 08/05/18 05:34, Jia-Ju Bai wrote:
>> The read operation to "req->type" is protected by
>> the lock on line 128, but the write operation to
>> this data on line 118 is not protected by the lock.
>> Thus, there may exist a data race for "req->type".
>>
>> To fix this data race, the write operation to "req->type"
>> should be also protected by the lock.
> No, xs_request_enter() is never called for a request already visible to
> another thread or processor. So no race exists.

Okay, thanks for your reply.


Best wishes,
Jia-Ju Bai
