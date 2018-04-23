Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755515AbeDWQez (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755192AbeDWQev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:34:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A94217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AB8JxZqQLo/MfzcAcd/g1CSVBdAUNvlyJghRPzhXsqrGKPGcQFDzFDOsYnWGXar1zsbQsFfWcIcxTYwY4Y1gC45egi4=
MIME-Version: 1.0
In-Reply-To: <71dfbcd9-501c-631f-76a3-53d7265d9321@monstr.eu>
References: <20180328020700.17050-1-robh@kernel.org> <20180328020700.17050-3-robh@kernel.org>
 <584d5be2-6961-5f65-d0d7-bc4661aa21f0@xilinx.com> <CAL_Jsq+yEfWZkwWAWKeDuFjxaaZO0uec6eqaq7UNOF-oY30ZuQ@mail.gmail.com>
 <71dfbcd9-501c-631f-76a3-53d7265d9321@monstr.eu>
From: Rob Herring <robh@kernel.org>
Date: Mon, 23 Apr 2018 11:34:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJGvf1deWwqTxGaj5fKSL6eTvoY4gQ3Pn8x6YF6W7NMkg@mail.gmail.com>
Message-ID: <CAL_JsqJGvf1deWwqTxGaj5fKSL6eTvoY4gQ3Pn8x6YF6W7NMkg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] microblaze: remove redundant early_printk support
To: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 5:50 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 13.4.2018 16:11, Rob Herring wrote:
>> On Tue, Apr 10, 2018 at 8:44 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>>> Hi Rob,
>>>
>>> On 28.3.2018 04:06, Rob Herring wrote:
>>>> With earlycon support now enabled, the arch specific early_printk support
>>>> can be removed.
>>>
>>> earlycon is not the full replacement of early_printk support as is
>>> designed right now.
>>> Definitely current early_printk is pretty old and contains code
>>> duplication but it starts much earlier then earlycon.
>>
>> Yes, essentially it's after MMU enabling rather than before. But it is
>> still before any h/w specific setup (dependent on the DT) which is
>> where one would typically fail to boot. Generally, I've found before
>> DT unflattening to be early enough. What can go wrong at this early
>> stage? Memory is flaky or you've passed in bad memory ranges or image
>> locations. An earlier console may or may not help there and those
>> problems are easier to debug in the bootloader.
>>
>> So it is a question of what you want to maintain.
>>
>>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>>> Cc: Michal Simek <monstr@monstr.eu>
>>>> ---
>>>> v2:
>>>> - Fix booting. The setup_memory call needed to be before the
>>>>   parse_early_param call.
>>>
>>> What's the reason for calling setup_memory before parse_early_param?
>>> Is there any dependency?
>>
>> Yes, either fixmap or ioremap (in your case) has to be functional when
>> earlycon is setup which happens via parse_early_param.
>
> Ok. Let's add it and see if there is any issue. Do you have any code
> which depends on this series?

No, I don't.

Rob
