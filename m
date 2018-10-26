Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D1C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656E420856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656E420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJZQdN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:33:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36019 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeJZQdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:33:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9F1AE208DC; Fri, 26 Oct 2018 09:57:10 +0200 (CEST)
Received: from bbrezillon (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id D64FD20794;
        Fri, 26 Oct 2018 09:57:09 +0200 (CEST)
Date:   Fri, 26 Oct 2018 09:57:07 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 6/9] i3c: master: Add driver for Cadence IP
Message-ID: <20181026095707.3cd9b511@bbrezillon>
In-Reply-To: <CAK8P3a0WDRpukjDBm1rGPnZiH2FJRpquWhEknOBg=CphNOYOwg@mail.gmail.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
        <20181022133404.2061-7-boris.brezillon@bootlin.com>
        <20181024202048.7e3534f7@bbrezillon>
        <CAK8P3a2DBgfvXs-9KzoDvbQpV+VN96xb7xHG-5=NDDgnt7ViVQ@mail.gmail.com>
        <20181025180720.1790f6a1@bbrezillon>
        <CAK8P3a02ELWiMB_pe0bzbsMfdqYOG1G0bFnSHzGu3ZbQHatH2w@mail.gmail.com>
        <20181025183005.3c0fa452@bbrezillon>
        <CAK8P3a0WDRpukjDBm1rGPnZiH2FJRpquWhEknOBg=CphNOYOwg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, 26 Oct 2018 09:43:25 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thu, Oct 25, 2018 at 6:30 PM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Thu, 25 Oct 2018 18:13:51 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Oct 25, 2018 at 6:07 PM Boris Brezillon <boris.brezillon@bootlin.com> wrote:  
> > > > On Thu, 25 Oct 2018 17:30:26 +0200
> > > > Arnd Bergmann <arnd@arndb.de> wrote:  
> > > > > On 10/24/18, Boris Brezillon <boris.brezillon@bootlin.com> wrote:  
> > > > > > On Mon, 22 Oct 2018 15:34:01 +0200  
> > > > I guess I could dynamically allocate the payload, but that requires
> > > > going over all users of i3c_send_ccc_cmd() to patch them.  
> > >
> > > This reminds me that Wolfram mentioned in his ELC talk that the
> > > buffers on i3c should all be DMA capable to make life easier for
> > > i3c master drivers that want to implement DMA transfers.  
> >
> > And this is the case for all buffers passed to
> > i3c_device_do_priv_xfers() (and soon i3c_device_send_hdr_cmd()),
> > but I did not enforce that for the internal
> > i3c_master_send_ccc_cmd_locked() helper, maybe I should...
> > It was just convenient to place the object to be transmitted/received on
> > the stack.  
> 
> Ok. Is i3c_master_send_ccc_cmd_locked() what implements the public
> interfaces then, or is this something else?

i3c_master_send_ccc_cmd_locked() calls master->ops->send_ccc_cmd(), so
it's part of the master controller interface.

> 
> If you place a buffer on the stack, it is not DMA capable, but
> it is guaranteed to be at least 32-bit word aligned, and should
> not cause an exception in readsl(), unless it starts with a couple of
> (not multiple of four)  extra bytes that are not sent to the devices.
> Is that what happens here?

Here is the report I received from Vitor:

"
	Hi Boris,


	I'm trying this new patch-set version but I get some issues when use 
	readsl() function.

	Basically the system complain about memory alignment.

	As exemple when I try to read the PID from the device

	> +static int i3c_master_getpid_locked(struct i3c_master_controller *master,
	> +				    struct i3c_device_info *info)
	> +{
	> +	struct i3c_ccc_getpid getpid;  

	at this point the getpid struct it is already unaligned with

	i3c_master_getpid_locked:1129 getpid_add=0x9a249c7a

	> +	struct i3c_ccc_cmd_dest dest = {
	> +		.addr = info->dyn_addr,
	> +		.payload.len = sizeof(struct i3c_ccc_getpid),
	> +		.payload.data = &getpid,
	> +	};
	> +	struct i3c_ccc_cmd cmd = {
	> +		.rnw = true,
	> +		.id = I3C_CCC_GETPID,
	> +		.dests = &dest,
	> +		.ndests = 1,
	> +	};
	> +	int ret, i;
	> +
	> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
	> +	if (ret)
	> +		return ret;
	> +
	> +	info->pid = 0;
	> +	for (i = 0; i < sizeof(getpid.pid); i++) {
	> +		int sft = (sizeof(getpid.pid) - i - 1) * 8;
	> +
	> +		info->pid |= (u64)getpid.pid[i] << sft;
	> +	}
	> +
	> +	return 0;
	> +}
	> +  

	and them when

	static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
	                        u8 *bytes, int nbytes)
	{
	     readsl(master->regs + RX_TX_DATA_PORT, bytes, nbytes / 4);
	...
	}

	the system crash.

	Misaligned Access
	Path: (null)
	CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc1 #88
	
	[ECR   ]: 0x00230400 => Misaligned r/w from 0x9a249c7a
	[EFA   ]: 0x9a249c7a
	[BLINK ]: dw_i3c_master_irq_handler+0x200/0x2fc [dw_i3c_master]
	[ERET  ]: dw_i3c_master_irq_handler+0x224/0x2fc [dw_i3c_master]
	[STAT32]: 0x00000a4c : K DE     A1 E2
	BTA: 0x70038e44  SP: 0x8071fe58  FP: 0x00000000
	LPS: 0x8060e63e LPE: 0x8060e642 LPC: 0x00000000
	r00: 0x00000033 r01: 0x00000004 r02: 0x00000000
	r03: 0xd0002014 r04: 0x00000006 r05: 0x00000000
	r06: 0x9a249c7a r07: 0x39307260 r08: 0xe10b6900
	r09: 0x00000013 r10: 0x00000000 r11: 0x000000c9
	r12: 0x0a613763

	Do you have any idea about this?


	Best regards,

	Vitor Soares
"

> 
> > > If we have buffers here that are not aligned to cache lines
> > > (or even just 32 bit words), doesn't that also mean that the
> > > same buffers are not DMA capable either?  
> >
> > Yep, if it's not cache-line-aligned (and on the stack), it's not
> > DMA-able.  
> 
> This sounds like a more fundamental problem to solve first
> then. Obviously it is incredibly /useful/ to be able to put short
> i2c or i3c messages on the stack, but allowing that in general
> also prevents the use of DMA without bounce buffers.

Actually, we have the same problem in MTD (UBI passes vmalloced
buffers to the MTD stack), so I understand this concern very well,
and I agree that enforcing all buffers passed to the controller to
be DMA capable is the right thing to do.

I guess I just didn't think about internal APIs when I made this
modification which explains why CCC cmds were left behind.

> 
> One way to address this might be to always bounce any
> messages that are less than a cache line through a
> (pre-)kmallocated buffer, and require any longer messages
> to be cache capable. This could also solve the issue with
> readsl(), but it would be a rather confusing user interface.
> 
> Another option might be to have separate interfaces for
> "short" and "long" messages at the API level and have
> distinct rules for those: short would always be bounced
> by the i3c code, and long puts restrictions on the buffer
> location.

Hm, let's keep the API simple. I'll just mandate that all payload bufs
passed to i3c_master_send_ccc_cmd_locked() be dynamically allocated.

Thanks for your feedback.

Boris
