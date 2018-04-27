Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeD0PSn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:18:43 -0400
Received: from www381.your-server.de ([78.46.137.84]:42907 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933111AbeD0PSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:18:40 -0400
Subject: Re: [PATCH v2] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
To: Moritz Fischer <moritz.fischer.private@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com
References: <20180426174000.12008-1-mdf@kernel.org>
 <20180427051115.GX6014@localhost>
 <748ffc14-de12-c11e-eb12-65c599fe5f4e@metafoo.de>
 <20180427070830.GC6014@localhost>
 <CAJYdmeO=k06MJi1L8++BC_zPqeb-BkrT=a7GOOCUE17Tk093NA@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <716956a2-a4f4-9cbd-8761-8db477f1dfc0@metafoo.de>
Date: Fri, 27 Apr 2018 17:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJYdmeO=k06MJi1L8++BC_zPqeb-BkrT=a7GOOCUE17Tk093NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/2018 05:15 PM, Moritz Fischer wrote:
> Hi Vinod,
> 
> On Fri, Apr 27, 2018 at 12:08 AM, Vinod Koul <vinod.koul@intel.com> wrote:
>> On Fri, Apr 27, 2018 at 08:53:39AM +0200, Lars-Peter Clausen wrote:
>>> On 04/27/2018 07:11 AM, Vinod Koul wrote:
>>>> On Thu, Apr 26, 2018 at 10:40:00AM -0700, Moritz Fischer wrote:
>>>>> Request IRQ with IRQF_SHARED flag. This works since the interrupt
>>>>> handler already checks if there is an actual IRQ pending and returns
>>>>> IRQ_NONE otherwise.
>>>>
>>>> hmmm what are we trying to fix here? Is your device on a shared line or not?
>>>
>>> IRQF_SHARED does not mean that the IRQ is on a shared line. It means that
>>> the driver can handle it if the IRQ is on a shared line. Since the driver
>>> can handle it setting the flag is a good idea since this enables usecases
>>> where the line is shared.
>>
>> Yes that is correct indeed, but what is the motivation for the change.
>>
>> If you never expect this to be in shared environment why to do this?
>> Sorry but "it works" is not a good enough reason for this change, to enable
>> usecases where the line is shared is a good reason :)
> 
> Remember, this is an FPGA soft core. I happen to have a design [1] where it
> is hooked up with multiple of them on one IRQ line, so to make this work,
> I need this change.

I think what Vinod is asking for is a change to the commit message saying
that "this change enables the driver to be used with devices where the
interrupt line is shared".
