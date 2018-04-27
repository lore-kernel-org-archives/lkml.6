Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933750AbeD0PPh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:15:37 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:42805 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933223AbeD0PPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:15:33 -0400
X-Google-Smtp-Source: AB8JxZqy79WX/YIayGvG2SA/O641PWz3VHSb3rI/6DH42SEiJhbcpnPAZ//aegF8QUv8tq90jXIKpCY+no9WEt7iiv0=
MIME-Version: 1.0
In-Reply-To: <20180427070830.GC6014@localhost>
References: <20180426174000.12008-1-mdf@kernel.org> <20180427051115.GX6014@localhost>
 <748ffc14-de12-c11e-eb12-65c599fe5f4e@metafoo.de> <20180427070830.GC6014@localhost>
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Date: Fri, 27 Apr 2018 08:15:32 -0700
Message-ID: <CAJYdmeO=k06MJi1L8++BC_zPqeb-BkrT=a7GOOCUE17Tk093NA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
To: Vinod Koul <vinod.koul@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Fri, Apr 27, 2018 at 12:08 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, Apr 27, 2018 at 08:53:39AM +0200, Lars-Peter Clausen wrote:
>> On 04/27/2018 07:11 AM, Vinod Koul wrote:
>> > On Thu, Apr 26, 2018 at 10:40:00AM -0700, Moritz Fischer wrote:
>> >> Request IRQ with IRQF_SHARED flag. This works since the interrupt
>> >> handler already checks if there is an actual IRQ pending and returns
>> >> IRQ_NONE otherwise.
>> >
>> > hmmm what are we trying to fix here? Is your device on a shared line or not?
>>
>> IRQF_SHARED does not mean that the IRQ is on a shared line. It means that
>> the driver can handle it if the IRQ is on a shared line. Since the driver
>> can handle it setting the flag is a good idea since this enables usecases
>> where the line is shared.
>
> Yes that is correct indeed, but what is the motivation for the change.
>
> If you never expect this to be in shared environment why to do this?
> Sorry but "it works" is not a good enough reason for this change, to enable
> usecases where the line is shared is a good reason :)

Remember, this is an FPGA soft core. I happen to have a design [1] where it
is hooked up with multiple of them on one IRQ line, so to make this work,
I need this change.

Thanks,

Moritz

[1] https://www.ettus.com/product/details/USRP-N310
