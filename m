Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeEUMeS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:34:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44695 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeEUMeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:34:13 -0400
X-Google-Smtp-Source: AB8JxZpXbvujm9Mw+wBMW9ouCELdIXxGn1EF5NNQhJ2rixnTserAGT15BEMHVbyjji1aoMxe+5HmT1YbVszFe2Cn6uA=
MIME-Version: 1.0
In-Reply-To: <20180521105511.6ztjk5conf7lfaiz@lakrids.cambridge.arm.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
 <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com> <20180426105938.y6unpt36lisb7kbr@lakrids.cambridge.arm.com>
 <CAKTKpr7Q7T9ZCTBi=LQR=XaAoihbBA3OKCO7yFobzNmR8EfyjQ@mail.gmail.com> <20180521105511.6ztjk5conf7lfaiz@lakrids.cambridge.arm.com>
From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Date: Mon, 21 May 2018 18:04:12 +0530
Message-ID: <CAKTKpr7fhR1aRenZBFUAzinjpD9DJ0NoNptCpkXAGx_J7DmMfA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, May 21, 2018 at 4:25 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Sat, May 05, 2018 at 12:16:13AM +0530, Ganapatrao Kulkarni wrote:
>> On Thu, Apr 26, 2018 at 4:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Wed, Apr 25, 2018 at 02:30:47PM +0530, Ganapatrao Kulkarni wrote:
>
>> >> + *
>> >> + *  L3 Tile and DMC channel selection is through SMC call
>> >> + *  SMC call arguments,
>> >> + *   x0 = THUNDERX2_SMC_CALL_ID      (Vendor SMC call Id)
>> >> + *   x1 = THUNDERX2_SMC_SET_CHANNEL  (Id to set DMC/L3C channel)
>> >> + *   x2 = Node id
>> >
>> > How do we map Linux node IDs to the firmware's view of node IDs?
>> >
>> > I don't believe the two are necessarily the same -- Linux's node IDs are
>> > a Linux-specific construct.
>>
>> both are same, it is numa node id from ACPI/firmware.
>
> I am very wary about assuming that the Linux nid will always be the same
> as the ACPI node id.
>
> For that to *potentially* be true, this driver should depend on
> CONFIG_NUMA, NUMA must not be disabled on the command line, etc, or the
> node id will always be NUMA_NO_NODE.

ok, i can check the node id which we get from ACPI helpers in probe.
if it is NUMA_NO_NODE, I will init first socket uncore only and nid
param to fw is always zero?

>
> I would be *much* happier if we had an explicit mapping somewhere to the
> ID the FW expects.
>
>> > It would be much nicer if we could pass something based on the MPIDR,
>> > which is a known HW construct, or if this implicitly affected the
>> > current node.
>>
>> IMO,  node id is sufficient.
>
> I agree that *a* node ID is sufficient, I just don't think that we're
> guaranteed to have the specific node ID the FW wants.

for thunderx2 which is 2 socket only platform, pxm and nid should be
same(either 0 or 1)
however, i can send PXM id(node_to_pxm) to firmware to make it more sane.

>
>> > It would be vastly more sane for this to not be muxed at all. :/
>>
>> i am helpless due to crappy hw design!
>
> I'm certainly not blaming you for this! :)
>
> I hope the HW designers don't make the same mistake in future, though...
>
> Thanks,
> Mark.

thanks
Ganapat
