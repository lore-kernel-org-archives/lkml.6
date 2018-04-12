Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeDLI5D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:57:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34312 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeDLI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:57:01 -0400
X-Google-Smtp-Source: AIpwx48CStBTNIRKNdLt/FTAyDnRM0nmLJN+gy51eU5UKuFmP7yf3Je0qYYqrAHPCxBn/LVlus65UnF9/bYDxlXSQ8E=
MIME-Version: 1.0
In-Reply-To: <AT5PR8401MB1169413938950BBB0D30A24CABBD0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1523452889-16331-1-git-send-email-jinpu.wangl@profitbricks.com> <AT5PR8401MB1169413938950BBB0D30A24CABBD0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Thu, 12 Apr 2018 10:56:39 +0200
Message-ID: <CAMGffEk5p6PVJPF3gmvr80MVGMKY56TEgOgTZUwwE_zq4NgyWw@mail.gmail.com>
Subject: Re: [PATCH] block: ratelimite pr_err on IO path
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 7:07 PM, Elliott, Robert (Persistent Memory)
<elliott@hpe.com> wrote:
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of Jack Wang
>> Sent: Wednesday, April 11, 2018 8:21 AM
>> Subject: [PATCH] block: ratelimite pr_err on IO path
>>
>> From: Jack Wang <jinpu.wang@profitbricks.com>
> ...
>> -                             pr_err("%s: ref tag error at location %llu " \
>> -                                    "(rcvd %u)\n", iter->disk_name,
>> -                                    (unsigned long long)
>> -                                    iter->seed, be32_to_cpu(pi->ref_tag));
>> +                             pr_err_ratelimited("%s: ref tag error at "
>> +                                                "location %llu (rcvd %u)\n",
>
> Per process/coding-style.rst, you should keep a string like that on
> one line even if that exceeds 80 columns:
>
>   Statements longer than 80 columns will be broken into sensible chunks, unless
>   exceeding 80 columns significantly increases readability and does not hide
>   information. ... However, never break user-visible strings such as
>   printk messages, because that breaks the ability to grep for them.
>
>
Thanks Robert, as the original code keep the 80 columns, I just
followed, I will fix it in v2.


-- 
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin
