Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161519AbeBPQx1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:53:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57149 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161415AbeBPQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:53:25 -0500
Subject: Re: [PATCH] i40evf: remove redundant array comparisons to 0 checks
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180215194245.28860-1-colin.king@canonical.com>
 <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <eb8a38bd-73a0-5f44-5e89-d9ded5be1800@canonical.com>
Date: Fri, 16 Feb 2018 16:53:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/18 16:51, Andy Shevchenko wrote:
> On Thu, Feb 15, 2018 at 9:42 PM, Colin King <colin.king@canonical.com> wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The checks to see if key->dst.s6_addr and key->src.s6_addr are null
>> pointers are redundant because these are constant size arrays and
>> so the checks always return true.  Fix this by removing the redundant
>> checks.
> 
>> +               for (i = 0; i < 4; i++)
> 
>> +                       filter->f.mask.tcp_spec.dst_ip[i] |=
>>                                                         cpu_to_be32(0xffffffff);
> 
> Can it be one line then?

I re-adjusted the text because checkpatch was complaining.

> 
>> +               memcpy(&filter->f.data.tcp_spec.dst_ip,
>> +                      &key->dst.s6_addr32,
> 
> Ditto.
> 
>> +                      sizeof(filter->f.data.tcp_spec.dst_ip));
>> +
>> +               for (i = 0; i < 4; i++)
> 
>> +                       filter->f.mask.tcp_spec.src_ip[i] |=
>>                                                         cpu_to_be32(0xffffffff);
> 
> Ditto.
> 
>> +               memcpy(&filter->f.data.tcp_spec.src_ip,
>> +                      &key->src.s6_addr32,
> 
> Ditto.
> 
>> +                      sizeof(filter->f.data.tcp_spec.src_ip));
> 
