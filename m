Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932122AbeCMR2m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:28:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:18364 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeCMR2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:28:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,465,1515484800";
   d="scan'208";a="210954291"
Subject: Re: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Kroening, Gary" <gary.kroening@hpe.com>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
 <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com>
 <CAHp75VdYG+i+m12yotuUa2JwW4ndMMXTV0ZSs_qOS5EAw7=M4w@mail.gmail.com>
 <CAHp75Vex+m-HqVD-H=B7zh=TFWR2Jbw2zSUwhApeY7xBb8pcvg@mail.gmail.com>
 <23d70b0d-ec19-32c8-e636-4cc36f1eec47@linux.intel.com>
 <CAHp75VebU5NYXRDpG4pzYrKDmNLE6prGbecacq3gCyDQBJd=cA@mail.gmail.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c3e09140-8a5b-0fdd-82cc-03700be3b5a0@linux.intel.com>
Date: Tue, 13 Mar 2018 13:28:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VebU5NYXRDpG4pzYrKDmNLE6prGbecacq3gCyDQBJd=cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/2018 1:22 PM, Andy Shevchenko wrote:
> On Tue, Mar 13, 2018 at 7:15 PM, Liang, Kan <kan.liang@linux.intel.com> wrote:
>> On 3/13/2018 12:00 PM, Andy Shevchenko wrote:
>>> On Tue, Mar 13, 2018 at 5:58 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Tue, Mar 13, 2018 at 3:42 AM, Liang, Kan <kan.liang@linux.intel.com>
>>>> wrote:
> 
>>>>> +#define SKX_CAPID6             0x9c
> 
>>>>> +       pci_read_config_dword(dev, SKX_CAPID6, &val);
> 
>>> Moreover, this is too non-flexible. Can't you find a capability based
>>> on CAP ID  + offset?
>>>
>>
>> It looks it doesn't use capability.
> 
> See below. It would be sad if it's true. (Will need comment in that case)
> 
>> 16:1e.3 System peripheral: Intel Corporation Sky Lake-E PCU Registers (rev
>> 04)
>> 00: 86 80 83 20 00 00 00 00 04 00 80 08 00 00 80 00
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Can you instead provide
> % lspci -nk -vvv -xx -s 16:1e.3
> ?

$ lspci -nk -vvv -xx -s 16:1e.3
16:1e.3 0880: 8086:2083 (rev 04)
         Subsystem: 8086:0000
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
00: 86 80 83 20 00 00 00 00 04 00 80 08 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
