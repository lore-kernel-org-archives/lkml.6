Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDhFSn7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F6AE60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeFFPRC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeFFPQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:16:59 -0400
X-Google-Smtp-Source: ADUXVKJU5VQeyIWXRJNp1+uwVVTV0Gi9aLpdgwc5RjNr6WV/4yGP8qGWYcVtIzfKDQXDAP4n4KXANvGvHRI+qIGxuiQ=
MIME-Version: 1.0
In-Reply-To: <20180606073449.GD20078@localhost.localdomain>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <3b05ca98a671a762013c312f8b70543402ee7556.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <20180531030129.GA16122@rob-hp-laptop> <20180531071717.GG13528@localhost.localdomain>
 <20180531102315.GA5150@localhost.localdomain> <CAL_Jsq+33G7zMEDOUXHQijxqqbvqykxZENLe1-52ECkXwo2o4g@mail.gmail.com>
 <20180601062540.GB5150@localhost.localdomain> <CAL_JsqJNMxR=zdwR41iLfWU=u3J_=_VkxVL+g3a12_4vvNwBtw@mail.gmail.com>
 <20180604113225.GE5150@localhost.localdomain> <CAL_JsqL3Z_o2CFeYDvb3PqgiskTSHuOVqwdUP+gFymLDTKhn2g@mail.gmail.com>
 <20180606073449.GD20078@localhost.localdomain>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Jun 2018 10:16:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKjwtq+7CSDKiaWGa011oqdsrc-XjOyfuBPOQ9UB=EtWQ@mail.gmail.com>
Message-ID: <CAL_JsqKjwtq+7CSDKiaWGa011oqdsrc-XjOyfuBPOQ9UB=EtWQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 2:34 AM, Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On Tue, Jun 05, 2018 at 10:46:14AM -0500, Rob Herring wrote:
>> On Mon, Jun 4, 2018 at 6:32 AM, Matti Vaittinen
>> <mazziesaccount@gmail.com> wrote:
>> > On Fri, Jun 01, 2018 at 12:32:16PM -0500, Rob Herring wrote:
>> >> On Fri, Jun 1, 2018 at 1:25 AM, Matti Vaittinen
>> >> <mazziesaccount@gmail.com> wrote:
>> >> > On Thu, May 31, 2018 at 09:07:24AM -0500, Rob Herring wrote:
>> >> >> On Thu, May 31, 2018 at 5:23 AM, Matti Vaittinen
>> >> >> <mazziesaccount@gmail.com> wrote:
>> >> >> > On Thu, May 31, 2018 at 10:17:17AM +0300, Matti Vaittinen wrote:
>> >> >> >> On Wed, May 30, 2018 at 10:01:29PM -0500, Rob Herring wrote:
>> >> >> >> > On Wed, May 30, 2018 at 11:42:03AM +0300, Matti Vaittinen wrote:
>> >> >> >> > > Document devicetree bindings for ROHM BD71837 PMIC MFD.
>> >> >> >> > > + - interrupts            : The interrupt line the device is connected to.
>> >> >> >> > > + - interrupt-controller  : Marks the device node as an interrupt controller.
>> >> >> >> >
>> >> >> >> > What sub blocks have interrupts?
>> >> >> >>
>> >> >> >> The PMIC can generate interrupts from events which cause it to reset.
>> >> >> >> Eg, irq from watchdog line change, power button pushes, reset request
>> >> >> >> via register interface etc. I don't know any generic handling for these
>> >> >> >> interrupts. In "normal" use-case this PMIC is powering the processor
>> >> >> >> where driver is running and I do not see reasonable handling because
>> >> >> >> power-reset is going to follow the irq.
>> >> >> >>
>> >> >> >
>> >> >> > Oh, but when reading this I understand that the interrupt-controller
>> >> >> > property should at least be optional.
>> >> >>
>> >> >> I don't think it should. The h/w either has an interrupt controller or
>> >> >> it doesn't.
>> >> >
>> >> > I hope this explains why I did this interrupt controller - please tell
>> >> > me if this is legitimate use-case and what you think of following:
>> >> >
>> >> > +Optional properties:
>> >> > + - interrupt-controller        : Marks the device node as an interrupt controller.
>> >> > +                         BD71837MWV can report different power state change
>> >> > +                         events to other devices. Different events can be seen
>> >> > +                         as separate BD71837 domain interrupts.
>> >>
>> >> To what other devices?
>> >
>> > Would it be better if I wrote "other drivers" instead? I think I've seen
>> > examples where MFD driver is just providing the interrupts for other
>> > drivers - like power-button input driver. Currently I have no such "irq
>> > consumer" drivers written. Still I would like to expose these interrupts
>> > so that they are ready for using if any platform using PMIC needs them.
>>
>> No, worse. Interrupt binding describes interrupt connections between a
>> controller and devices (which could be sub-blocks in a device), not to
>> drivers.
>
> Ok.
>
>> I'm just curious as to what sub-blocks/devices there are. You don't
>> have to have a driver (yet) to define the devices.
>
> Right. I should have done this from the start. I just thought everyone
> is busy with other things and pushing people to read data sheets might
> be considered as lazines. "Go and read from data sheet what my driver
> does, I am too lazy to try to explain what I am doing" - type of thing
> you know... But as people asked me for more information about HW:
>
> Datasheet:
> https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> (Would it be good idea to add this link to comments in MFD driver or to
> binding document(s)?)

Yes, it would.

> Page 8 contains roughly the same picture I drew
> below. Page 69 shows the interrupt registers. And for interested ones,
> HW state transitions are described on page 24.
>
>                     +--------------------------------------------------+
>                     |                                                  |
> VSYS           +-----------------+                    +-----------+    |
>                     |            |                    |           |    |
>                     |  +-------+ |                    | BUCKS 1-4 +-------->
>                     |  |       | |                    |           |    |
> I2C IF         +------->   H   | +--------------------+  DVS      +-------->
>                     |  |   O   | |                    |  Support  |    |
> PWRON_B        +------->   S   | |                    |           +-------->
>                     |  |   T   | |                    |           |    |
> PMIC_STBY_REQ  +------->       | |                    |           +-------->
>                     |  |   I   | |                    |           |    |
> PMIC_ON_REQ    +------->   /   | |                    +-----------+    |
>                     |  |   F   | |                                     |
> WDOG_B         +------->       | |                    +-----------+    |
>                     |  |       | |                    |           +-------->
>                     |  |       | +--------------------+ BUCKS 5,8 |    |
>                     |  |       | |                    |           +-------->
>                     |  |       | |                    +-----------+    |
>                     |  |       | |                                     |
>                     |  |       | |                     +----------+    |
> IRQ_OUT        <-------+       | |                     |          |    |
>                     |  |       | +---------------------+ LDO1     +-------->
> C32K_OUT       <-------+       | |                     |          |    |
>                     |  |       | |                     +----------+    |
>                     |  |       | |                                     |
>                     |  |       | |                     +----------+    |
>                     |  |       | |                     |          |    |
>                     |  |       | +---------------------+ LDO2     +-------->
>                     |  |       | |                     |          |    |
>                     |  |       | |                     +----------+    |
>                     |  |       | |                                     |
>                     |  |       | |                     +----------+    |
>                     |  |       | |                     |          |    |
>                     |  |       | +---------------------+ LDO7     +-------->
>                     |  +-------+ |                     |          |    |
>                     |            |                     +----------+    |
>                     |            |                                     |
>                     |            | +----------+ +-------------------------->
>                     |            | |          | |                      |
>                     |            +-+ BUCK6    +-+      +----------+    |
>                     |            | |          | |      |          |    |
>                     |            | +----------+ +------> LDO5     +-------->
>                     |            |              |      |          |    |
>                     |            |              |      +----------+    |
>                     |            |              |                      |
>                     |  +-------+ |              |      +----------+    |
>                     |  |       | |              o      |          |    |
>  XIN         +---------+ 32K   | |               \-----> LDO3     +-------->
>                     |  |Crystal| +--------------o      |          |    |
>                     |  |Driver | |  +---------+        +----------+    |
>  XOUT        +---------+       | |  |         |                        |
>                     |  |       | +--+ BUCK7   +-+-------------------------->
>                     |  +-------+ |  |         | |                      |
>                     |            |  +---------+ |      +-----------+   |
>                     |            |              |      |           |   |
>                     |            |              +------>   LDO6    +------->
>                     |            |              |      |           |   |
>                     |            |              |      +-----------+   |
>                     |            |              |                      |
>                     |            |              |      +-----------+   |
>                     |            |              o      |           |   |
>                     |            |               \----->   LDO4    +------->
>                     |            +--------------o      |           |   |
>                     |                                  +-----------+   |
>                     |                                                  |
>                     +--------------------------------------------------+
>
> On the left we see input lines to PMIC. PWRON_B intended to be connected
> to power button. PMIC_STBY_REQ and PMIC_ON_REQ lines for controlling HW
> state machine PMIC has. And WDOG_B from watch dog.
>
> PMIC has control register for controlling what happens to BUCK/LDO
> outputs when input line states change. PMIC reports change in input
> lines via the IRQ_OUT line and IRQ status register.

So it looks like this is just regulators with a few other signals to handle.

> So HW mapping for interrup(s) from PMIC would be:
>
> (HW) event => BD71837 domain IRQ
>
> PMIC_STBY_REQ line level change         => 0
> PMIC_ON_REQ line level change           => 1

I'm not really clear how these would have s/w handling. They look like
handshake signals for the processor to enter and exit standby/suspend.
H/w designers don't always know what to do with things and may have
just said lets have an interrupt for every input signal. I'd think you
would just want DT properties to configure what action to take (and
perhaps polarity?).

> PMIC_WDOG_B line level change           => 2

Ah, this is an input signal, not a watchdog block within the PMIC. I
think this should just be handled by the core driver. If you need to
configure what this does, then we can add a property to handle that.

> PMIC_PWRON_B line level change          => 3
> PMIC_PWRON_B line/long push detected    => 4
> PMIC_PWRON_B line/short push detected   => 5

So you need a power button driver (or maybe not even a separate
driver) for this, but I don't think that warrants a child node. I
think some PMIC drivers just generate a power key press (which just
gets punted to userspace), but some will do an actual power down. Or
maybe a combination of those based on short/long press.

I think there's already some DT properties defined to control the
behavior as well.

> SWRESET register on PMIC written        => 6

Probably this can be handled within the core driver. Seems like you'd
only use this if you have separate entities that write and read this.
If you don't know, then just ignore it for now.

>> > "The BD71837 driver only provides the infrastructure for the IRQs. The
>> > users can write his own driver to convert the IRQ into the event they
>> > wish. The IRQ can be used with the standard
>> > request_irq/enable_irq/disable_irq API inside the kernel." (I found this
>> > text from NXP forums and ruthlessly copied and modified it over here)
>>
>> That's all OS details that have nothing to do with the binding. The
>> binding describes the h/w.
>
> Right. I'll drop it.
>
>>
>> > If this is not feasible, then I will remove the irq handling from MFD
>> > (or leave code there but remove the binding information?) as I don't
>> > know what the irq handles should do in generic case.
>>
>> I don't understand what you mean by generic. An IRQ has to be wired to
>> something. The only generic IRQs are GPIOs.
>
> By generic case I mean for example when PMIC_WDOG_B line changes. In
> example use-case I have seen, this would be cutting the power from
> processor. But this is not necessarily the case. This can be configured
> from PMIC register so that action can be warm or cold reset, or no
> action. Finally, I'd rather not expect that the BUCKs are supplying
> power to processor which is controlling the PMIC. Thus I do not know how
> to do generic _handler_ for these interrupts.
>
> So from PMIC HW point of view I know that the interrupt is tied to
> PMIC_WDOG_B line change. And this can be described in binding document.
> (I tried doing this to v5 patch). Still from system/SW point of view I
> don't know what action should be taken (or by which driver) when such
> change happens. Hence I liked the idea of hiding the irq register
> details in MFD driver by declaring it as interrupt controller - and
> leaving the interrupts to be used by what ever drivers need the change
> information is system the PMIC is used.

This can still be done but doesn't have to be in DT.

>> >> > + - #interrupt-cells    : The number of cells to describe an IRQ should be 1.
>> >> > +                           The first cell is the IRQ number.
>> >> > +                           masks from ../interrupt-controller/interrupts.txt.
>> >
>> > Sorry this "masks from ../interrupt-controller/interrupts.txt." was
>> > accidentally pasted here. I should have deleted it.
>> >
>> >> I'm still not clear. Generally in a PMIC, you'd define an interrupt
>> >> controller when there's a common set of registers to manage sub-block
>> >> interrupts (typical mask/unmask, ack regs) and the subblocks
>> >> themselves have control of masking/unmasking interrupts. If there's
>> >> not a need to have these 2 levels of interrupt handling, then you
>> >> don't really need to define an interrupt controller.
>> >
>> > And to clarify - the PMIC can generate irq via one irq line. This is
>> > typical ACTIVE_LOW irq with 8 bit "write 1 to clear" status register and
>> > 8 bit mask register. The role of interrupt-controller code here is just
>> > to allow these 8 irq reasons to be seen as individual BD71837 domain
>> > interrupts. I just don't have the driver(s) for handling these
>> > interrupts.
>>
>> If what I'm asking for above is still not clear, what are the 8 bits
>> defined as or what are those 8 lines connected to?
>
> I am sorry - there were only 7 bits. One bit was unused. I hope my
> explanation abowe did clarify this.
>
>> >  Or should I just
>> > somehow state that irq X in BD71837 is a "power button short push"
>> > event and power button driver should be the consumer for it?
>>
>> Yes, at least, but who is the consumer is an OS detail that is not
>> relevant to the binding. Ideally, you would describe the node with the
>> interrupts property for "irq X".
>
> I think I need to try changing my mind set. I tend to think the DT nodes
> are for drivers so that drivers can get the information they need. An as
> I don't know what kind of driver would be handling the irq, I don't know
> what kind of DT node would be good for it. Hence I would rather leave
> constructing the node who consumes the IRQ to someone who knows what
> they want to do with this IRQ information.
>
>>
>> > Rest of the interrupts are not so obvious. I have no idea how I should
>> > handle rest of the interrupts. Those are interrupts which cause the PMIC
>> > to reset and cut the powers from most of the regulators too. I can
>> > easily think setup where one processor is controlling PMIC which powers
>> > for the other processor. And getting IRQ if for example watchdog reset
>> > the other processor would probably be very usefull. But doing any
>> > 'de-facto' handler for this is hard. Only generally usefull thing would
>> > be notifying the user-space but I don't think I should invent any new
>> > kernelspace - userspace interfaces for this. I believe that when such
>> > are needed those should be implemented by ones knowing the platform.
>>
>> Don't think about the OS or driver details. Think about sub-blocks of
>> the hardware and the connections between them (like irqs) and to board
>> that need to be described in DT.
>>
>> If you can't describe that, then you just probably shouldn't have
>> sub-nodes in DT (ever).
>
> This is why I did not add any "irq consumer" nodes in example DT. But I
> believe someone can think of a board/setup where such are needed. Thus I
> liked the idea of providing the interrupt-controller.
>
>> >
>> > So please bear with me but do you mean I should
>> > a) document what conditions generate which IRQ
>> >    or
>> > b)  should I tell what kind of driver is needed for handling the IRQs
>> >    or
>> > c) should I first write code using IRQs before addinf MFD binding?
>>
>> A.
>
>
> So what do you think of this:
>
> +Optional properties:
> + - interrupt-controller        : Marks the device node as an interrupt controller.
> +                         BD71837MWV can report input line state change and SW
> +                         reset events via interrupts. Different events can be seen
> +                         as separate BD71837 domain interrupts.
> + - #interrupt-cells    : The number of cells to describe an IRQ should be 1.
> +                         The value in cell is the IRQ number.
> +                           Meaningfull numbers are:
> +                             0 => PMIC_STBY_REQ level change
> +                             1 => PMIC_ON_REQ level change
> +                             2 => WDOG_B level change
> +                             3 => Power Button level change
> +                             4 => Power Button Long Push
> +                             5 => Power Button Short Push
> +                             6 => SWRESET register is written 1
>
> Would this be getting closer to what is needed from binding document?

I don't think any of this needs to live in DT. All you really need a
separate driver (and hence irq) for is really just the power button.
You can just define the interrupts within the kernel.

Rob
