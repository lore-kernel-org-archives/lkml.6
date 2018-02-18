Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeBRTAm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 14:00:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54197 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBRTAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 14:00:40 -0500
Subject: Re: [PATCH] i40evf: remove redundant array comparisons to 0 checks
To: Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180215194245.28860-1-colin.king@canonical.com>
 <CAHp75Vcxt0kkzRaF1Zzkt4hVqcPt0VG61yTLgB7HvG1xwhPUbg@mail.gmail.com>
 <eb8a38bd-73a0-5f44-5e89-d9ded5be1800@canonical.com>
 <CAHp75VcsV4NfR3OiAjjYAowcHmK+rXOsrPN2aHnxBp5hqg+C+g@mail.gmail.com>
 <1518971510.1894.2.camel@perches.com>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <28e69707-9f10-451b-9218-8246238a9958@canonical.com>
Date: Sun, 18 Feb 2018 19:00:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518971510.1894.2.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/18 16:31, Joe Perches wrote:
> On Sun, 2018-02-18 at 16:58 +0200, Andy Shevchenko wrote:
>> On Fri, Feb 16, 2018 at 6:53 PM, Colin Ian King
>> <colin.king@canonical.com> wrote:
>>> On 16/02/18 16:51, Andy Shevchenko wrote:
>>>> On Thu, Feb 15, 2018 at 9:42 PM, Colin King <colin.king@canonical.com> wrote:
>>>>> +                       filter->f.mask.tcp_spec.dst_ip[i] |=
>>>>>                                                         cpu_to_be32(0xffffffff);
>>>>
>>>> Can it be one line then?
>>>
>>> I re-adjusted the text because checkpatch was complaining.
>>>>
>>>>> +                       filter->f.mask.tcp_spec.src_ip[i] |=
>>>>>                                                         cpu_to_be32(0xffffffff);
>>
>> For the rest OK, but for the above two how much over 80 it went if
>> would be one line?
>> If it 2-3 characters, consider to make it one line. It would increase
>> readability.
> 
> Another possibility would be to use temporaries for
> 	filter->f.mask.tcp_spec
> and
> 	filter->f.data.tcp_spec
> as both are used ~10 times in the function

That's a good idea. I'll fix this up tomorrow when I get back to work
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
