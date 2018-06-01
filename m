Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeFAIZK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:25:10 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46447 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbeFAIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:25:04 -0400
X-Google-Smtp-Source: ADUXVKLOJ4lZA76zupw/Uk9QtcQDYioYMqi0Xxl1ucWd7kgUf3SlN2LkTnnxq1QsSjSikUc9HqeJVhKWj4plUQFiG40=
MIME-Version: 1.0
In-Reply-To: <1527807882.10176.11.camel@linux.intel.com>
References: <CAHp75VfLqvjVPwhcsK4enhsvXSLggX9_pO9AozZT56DWDrkjPg@mail.gmail.com>
 <20180525011056.25132-1-david.e.box@linux.intel.com> <CAHp75VfgAS4mDbtnVSMCJcadra=mPEsSQ5jt153r-Fks6vis7A@mail.gmail.com>
 <1527807882.10176.11.camel@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 11:25:03 +0300
Message-ID: <CAHp75Vdxz2h1N_bLQ4wxrYoo-kRAHQK=+36Db0BfK1QR4iwVPw@mail.gmail.com>
Subject: Re: [PATCH V2] platform/x86: intel_pmc_core: Add CNP SLPS0 debug registers
To: David Box <david.e.box@linux.intel.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>, kyle.d.pelton@linux.intel.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 2:04 AM, David E. Box
<david.e.box@linux.intel.com> wrote:
> On Thu, 2018-05-31 at 21:38 +0300, Andy Shevchenko wrote:
>> On Fri, May 25, 2018 at 4:10 AM, David E. Box
>> <david.e.box@linux.intel.com> wrote:

>> > +struct slps0_dbg_map {
>> > +       const struct pmc_bit_map *slps0_dbg_sts;
>> > +       int size;
>> > +};
>>
>> Didn't pay attention to this earlier. Why do we have a separate size
>> member? What does it define?
>
> It holds the size of the pmc_bit_map array, assigned as shown here:
>
> +static const struct slps0_dbg_map cnp_slps0_dbg_maps[] = {
> + {cnp_slps0_dbg0_map, ARRAY_SIZE(cnp_slps0_dbg0_map)},
> + {cnp_slps0_dbg1_map, ARRAY_SIZE(cnp_slps0_dbg1_map)},
> + {cnp_slps0_dbg2_map, ARRAY_SIZE(cnp_slps0_dbg2_map)},
> +};

I see.
Please drop this and use a terminator instead like it's done for the
rest map tables.

-- 
With Best Regards,
Andy Shevchenko
