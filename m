Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeCMRWs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:22:48 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:38833 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbeCMRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:22:45 -0400
X-Google-Smtp-Source: AG47ELuV9gDI+uiqTbwmzTdktLWccp1tFzQaKwGmBV6I3rJZiArQ7+iahZo3QCfRH6NjZifBsNUwXCEahWcQuoNEREc=
MIME-Version: 1.0
In-Reply-To: <23d70b0d-ec19-32c8-e636-4cc36f1eec47@linux.intel.com>
References: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
 <9efcdfa1-9da3-f4de-749f-0950d20a5758@linux.intel.com> <CAHp75VdYG+i+m12yotuUa2JwW4ndMMXTV0ZSs_qOS5EAw7=M4w@mail.gmail.com>
 <CAHp75Vex+m-HqVD-H=B7zh=TFWR2Jbw2zSUwhApeY7xBb8pcvg@mail.gmail.com> <23d70b0d-ec19-32c8-e636-4cc36f1eec47@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 19:22:44 +0200
Message-ID: <CAHp75VebU5NYXRDpG4pzYrKDmNLE6prGbecacq3gCyDQBJd=cA@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
To: "Liang, Kan" <kan.liang@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 7:15 PM, Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 3/13/2018 12:00 PM, Andy Shevchenko wrote:
>> On Tue, Mar 13, 2018 at 5:58 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Tue, Mar 13, 2018 at 3:42 AM, Liang, Kan <kan.liang@linux.intel.com>
>>> wrote:

>>>> +#define SKX_CAPID6             0x9c

>>>> +       pci_read_config_dword(dev, SKX_CAPID6, &val);

>> Moreover, this is too non-flexible. Can't you find a capability based
>> on CAP ID  + offset?
>>
>
> It looks it doesn't use capability.

See below. It would be sad if it's true. (Will need comment in that case)

> 16:1e.3 System peripheral: Intel Corporation Sky Lake-E PCU Registers (rev
> 04)
> 00: 86 80 83 20 00 00 00 00 04 00 80 08 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Can you instead provide
% lspci -nk -vvv -xx -s 16:1e.3
?

-- 
With Best Regards,
Andy Shevchenko
