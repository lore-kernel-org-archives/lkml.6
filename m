Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E10C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6633D218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfADXny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 18:43:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:59708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfADXny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 18:43:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6477CAD6F;
        Fri,  4 Jan 2019 23:43:50 +0000 (UTC)
Subject: Re: [RFC lora-next 5/5] HACK: net: lora: sx130x: Add PicoCell gateway
 shim for cdc-acm
To:     Rob Herring <robh@kernel.org>
Cc:     linux-lpwan@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20190104112131.14451-1-afaerber@suse.de>
 <20190104112131.14451-6-afaerber@suse.de>
 <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <9d97fec5-31b0-8717-cd10-de4f36d1cf05@suse.de>
Date:   Sat, 5 Jan 2019 00:43:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+BMOvRLEbD2Eo2D=n446vSubeXV3-FbkBSHjpfL=LYsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am 04.01.19 um 18:07 schrieb Rob Herring:
> On Fri, Jan 4, 2019 at 5:21 AM Andreas Färber <afaerber@suse.de> wrote:
>>
>> Ignore our device in cdc-acm probing and add a new driver for it,
>> dispatching to cdc-acm for the actual implementation.
>>
>> WARNING: It is likely that this VID/PID is in use for unrelated devices.
>> Only the Product string hints what this really is in current v0.2.1.
>> Previous code v0.2.0 was using a Semtech VID/PID, but no card shipping
>> with such firmware is known to me.
>>
>> While this may seem unorthodox, no internals of the driver are accessed,
>> just the set of driver callbacks is duplicated as shim.
>>
>> Use this shim construct to fake DT nodes for serdev on probe.
>> For testing purposes these nodes do not have a parent yet.
>> This results in two "Error -2 creating of_node link" warnings on probe.
> 
> It looks like the DT is pretty static. Rather than creating the nodes
> at run-time, can't you create a dts file and build that into your
> module.

Heh, if that were the only issue with this patch... ;)

I had read about that possibility here [1], but it just appeared to give
me a binary blob with no handy documentation on how to parse the
__dtb_XXX_begin..__dtb_XXX_end blob afterwards for assignment to
interface->dev.of_node. Two nodes and one compatible property were
enough to get me started, so that was quickest, given lack of knowledge.

I intentionally left it static to keep error handling and cleanup
manageable for now... Otherwise I'd need to kstrdup()/kzalloc() all
properties so that I can consistently kfree() them again on release.

Note that this was just a PoC, so there are properties missing here:

At least currently Ben's patch [2] (wrongly?) relies on the optional
clock-output-names property if #clock-cells property is specified -
which I did not in this patch. (Thus it'll disable clk_out, which would
break opening the netdev if we wouldn't run into other errors first.)

Any comments on how to best deal with clk names on the driver side would
be appreciated, so that we can just leave the property away here and get
a sane default name. Otherwise we'd need to generate a unique name here.

If #clock-cells were present, the driver would also rely on obtaining a
parent clock, which may be easiest for me to fix in the driver; but
assuming we need it, we'd need a clocks property pointing to phandles.
Wouldn't phandles need to be unique globally in the kernel for lookup?
phandles from a separate .dtb fragment wouldn't seem to tick that box.

(For reference there's also a clk locking issue under discussion at [3],
as well as multiple unresolved Kbuild reports about clk_hw not being
applicable on sparc64 allyesconfigs and m68k allmodconfig that I'm
unsure how to best resolve while keeping the driver broadly usable. Not
using clk would solve above DT worries but would leave us with ugly
driver dependencies across spi and a custom sx130x_radio bus.)

Kconfig may also be a topic to consider for this USB driver - my x86_64
host for instance doesn't have CONFIG_OF, so it might work to manually
allocate such nodes, whereas using API or &of_fwnode_ops (needed?) may
be a problem - although without CONFIG_OF the serdev code probably is
unable to enumerate the nodes in the first place?

And I assume on ACPI platforms hot-pluggable USB devices shouldn't need
a user-overridden ACPI table either - have you thought about some
serdev-specific lookup as fallback when OF and ACPI come up empty?

Your drivers/tty/serdev/core.c:serdev_controller_add() has access to
ctrl->dev->parent, so it could maintain a list of callbacks that drivers
(e.g., cdc-acm) could register callbacks with and cast the device here
to usb_interface; my module here would then only need to register such a
callback against cdc-acm in its module init to allow cdc-acm to provide
it with the usb_interface, where it could then check for the iProduct to
determine whether that device should be serdev-controlled or not - say
by returning 0 to bind, negative error to ignore - and loading/creating
an internal of_node or whatever necessary. Just a rough idea for now...

Even easier, serdev_device_driver could just get an optional callback!
Then my driver in 3/5 could just determine itself which device it wants
to bind against and still use the module_serdev_device_driver() macro.
(serdev is built-in, so not as easy to tweak on random boards here...)

Any comments on serdev in 4/5? I wonder whether that was an oversight
(in which case it should get a Fixes line) or an intentional choice due
to issues? You mentioned hangup and open/close mismatches before...

Thanks,
Andreas

[1] https://elinux.org/Device_Tree_Linux#FDT_built_into_kernel_as_data
[2] https://patchwork.ozlabs.org/patch/983173/
[3]
https://lists.infradead.org/pipermail/linux-lpwan/2019-January/000069.html

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
