Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeEUJ1U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:27:20 -0400
Received: from foss.arm.com ([217.140.101.70]:45532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbeEUJ1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:27:18 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <Will.Deacon@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>, vkilari@codeaurora.org,
        Al Stone <ahs3@redhat.com>, Dietmar.Eggemann@arm.com,
        Morten.Rasmussen@arm.com, Palmer Dabbelt <palmer@sifive.com>,
        Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
        austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
        jhugo@codeaurora.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v9 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-3-jeremy.linton@arm.com>
 <78b08b68-ff57-8dd8-6eb1-00548f275eac@arm.com>
 <CAHp75VciOAMX1HWifZ+K9GiVicZRFrwHaGteJFVe1uFrh+qu0w@mail.gmail.com>
 <a64ed431-0f60-2711-4138-eeefc7ba2d8b@arm.com>
 <20180517154701.GA20281@e107155-lin>
 <CAHp75VfEYcPdECmDDOd8CLBBXGpcwSUGQRr0x8VTb1-7j51_0Q@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <7c9a4921-d4da-f1db-85ed-7d7f917be30c@arm.com>
Date: Mon, 21 May 2018 10:27:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfEYcPdECmDDOd8CLBBXGpcwSUGQRr0x8VTb1-7j51_0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/18 22:50, Andy Shevchenko wrote:
> On Thu, May 17, 2018 at 6:47 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> Is below patch does what you were looking for ?
> 
> Somewhat.
> See below for some minors.
> 

Thanks

>> of_property_read_u64 searches for a property in a device node and read
>> a 64-bit value from it. Instead of using of_get_property to get the
>> property and then read 64-bit value using of_read_number, we can make
>> use of of_property_read_u64.
> 
> Suggested-by?
>

Yes indeed, added it locally after I sent out this patch. Will send out
a proper patch soon.

>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> 
>> -       cache_size = of_get_property(np, propname, NULL);
>> -       if (cache_size)
>> -               this_leaf->size = of_read_number(cache_size, 1);
>> +       if (!of_property_read_u64(np, propname, &cache_size))
>> +               this_leaf->size = cache_size;
> 
> I suppose it's something like this
> 
> ret = of_property_...(..., &this_leaf->VAR);
> if (ret)
>  warning / set default / etc

OK, I do prefer this but once I was told not to use structure elements
directly like that, but should be harmless in this particular case, will
do so.

-- 
Regards,
Sudeep
