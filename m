Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B65C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBE52087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcDjyPuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBE52087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeIJWIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:08:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42398 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:08:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so10019979plq.9;
        Mon, 10 Sep 2018 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpiXGPhFepwUIXaL9NlaQ1hCx3xDrFv4GP95+nUw8ts=;
        b=NcDjyPuE/MGsF7MQb3B18TK8hZ1HtyQJrqYCGjdiKgDUMQoIyZwIbLS8mkvlP8mHoJ
         7dETJHIfjq0KL6po8ZzX6cvTFOMcfArtFJu1CwAQAB1J1bKq6a1gEtqUl4oqeKVQmVKb
         LT7LU6FbfF6oRBdWaQVSMDZSYIwh/YlvqWDD/czUhnwtTLIQUpbyCZULQL7dh0tD0RWA
         bUUXjblQhfIeRcSnAIv+kH43V7E3TGuQtPB6WAylagcBduSTVoTecJ5MWgBMIwi4RsKv
         iEJb1X6b68z7Rs4tWYZ7Dour0ww1SEopqufp/vkDumJQjFDtDphtAHsXTsrLRIoGujQY
         AIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpiXGPhFepwUIXaL9NlaQ1hCx3xDrFv4GP95+nUw8ts=;
        b=nAoXqW8rrHzaZ2hJ6hHLbwNsI8C9MKOSa7//5wvy5kCL/Nq9IMuyJiHJL97nU3rqgJ
         j8eb6MqZBj6h9y0sMJg9xQNCj3rn+gXmhtSHG7OsyQd1xIUMkd382OgxYbhWAYnloR9U
         K3Q7WHAo9khN422KUHyWuuxF+DM7PuamkzU/HQxI9szQSJp4lShAvLQMg2KUNLOwnYUe
         2LF4lhEv0LWgx+pw8BExWPfqYXrOCJIC3LKo0+wVZMDLfcoc64UL8INIBR9F/MWyzU48
         p3+fb9dyYJbVD4LIztu1mOkQaaD9tLRDGcNZ48sibr71TUJogSSk4Hx10/87LvOwKLiz
         1sVw==
X-Gm-Message-State: APzg51AkCF3I/xP/hewVbZ5trxGeP4Tfa+eLRN4wt1hpQmB2dLyeCwOA
        BzHJ4b6Kb2sf3VTJJ8kWkTbyq0vznjDyqimLAr0=
X-Google-Smtp-Source: ANB0VdZT0DCfe8Jr2oDg1cdC2NZpwsOSgpBvHU0rOgZwi89LeDnbuKnaEtLRNOkRQl3vkwd7mMEmD4WkPXEPthQGaBc=
X-Received: by 2002:a17:902:6f16:: with SMTP id w22-v6mr23248590plk.127.1536599624699;
 Mon, 10 Sep 2018 10:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <1515109891-17133-1-git-send-email-jliang@xilinx.com>
 <1515109891-17133-3-git-send-email-jliang@xilinx.com> <CABb+yY00n6fLiQXftj-TMhT6q=KopZMkLYr6DpYE8CvxH-gz8Q@mail.gmail.com>
 <BY1PR0201MB0885F2BCD9FE353171B54888B0110@BY1PR0201MB0885.namprd02.prod.outlook.com>
 <CABb+yY1VxNCskPK4LJ=JnxyKPBid2SEEgRLK3M1Csbu2xMRn8g@mail.gmail.com> <CAA07jV-K5x0TFvVDE4SyFqCztJsjiMbns=h=dQ4_EPRa+p7jfg@mail.gmail.com>
In-Reply-To: <CAA07jV-K5x0TFvVDE4SyFqCztJsjiMbns=h=dQ4_EPRa+p7jfg@mail.gmail.com>
From:   Wendy Liang <sunnyliangjy@gmail.com>
Date:   Mon, 10 Sep 2018 10:13:33 -0700
Message-ID: <CAA07jV_RmL+DfMbWW93Xa8ZjS2g50vY93zcwqO2=Y9GZJgab1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Wendy Liang <jliang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 2:31 PM Wendy Liang <sunnyliangjy@gmail.com> wrote:
>
> On Tue, Jan 9, 2018 at 8:42 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > On Wed, Jan 10, 2018 at 6:52 AM, Jiaying Liang <jliang@xilinx.com> wrote:
> >>> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
> >
> >>> > +
> >>> > +Controller Device Node:
> >>> > +===========================
> >>> > +Required properties:
> >>> > +--------------------
> >>> > +- compatible:          Shall be: "xlnx,zynqmp-ipi-mailbox"
> >>> > +- reg:                 IPI buffers address ranges
> >>> > +- reg-names:           Names of the reg resources. It should have:
> >>> > +                       * local_request_region
> >>> > +                         - IPI request msg buffer written by local and read
> >>> > +                           by remote
> >>> > +                       * local_response_region
> >>> > +                         - IPI response msg buffer written by local and read
> >>> > +                           by remote
> >>> > +                       * remote_request_region
> >>> > +                         - IPI request msg buffer written by remote and read
> >>> > +                           by local
> >>> > +                       * remote_response_region
> >>> > +                         - IPI response msg buffer written by remote and read
> >>> > +                           by local
> >>> >
> >>> shmem is option and external to the controller. It should be passed via
> >>> client's binding.
> >>> Please have a look at Sudeep's proposed patch
> >>> https://www.spinics.net/lists/arm-kernel/msg626120.html
> >> [Wendy] thanks for the link, but those 'buffers" are registers in the hardware
> >> but not memory.
> >>
> > No, that is for memory, not registers.
> > Please have a more careful look at the patch.
>
> Sorry for very late response.
>
> Those are not the normal memory but device memories,
> they are 32bytes fixed request buffers and response buffers per
> channel. They come
> from the IPI hardware block.
>
> The mailbox framework API "mbox_send_message()" allows users to send message
> to the mailbox. in this case, just not clear on why we cannot have the
> buffer in the
> controller? These memories are not for sharing data, but just for
> short notification
> messages.
>
> >
> >>>
> >>> > +- #mbox-cells:         Shall be 1. It contains:
> >>> > +                       * tx(0) or rx(1) channel
> >>> > +- xlnx,ipi-ids:                Xilinx IPI agent IDs of the two peers of the
> >>> > +                       Xilinx IPI communication channel.
> >>> > +- interrupt-parent:    Phandle for the interrupt controller
> >>> > +- interrupts:          Interrupt information corresponding to the
> >>> > +                       interrupt-names property.
> >>> > +
> >>> > +Optional properties:
> >>> > +--------------------
> >>> > +- method:              The method of accessing the IPI agent registers.
> >>> > +                       Permitted values are: "smc" and "hvc". Default is
> >>> > +                       "smc".
> >>> > +
> >>> Andre almost implemented the generic driver. Can you please have a look at
> >>> https://www.spinics.net/lists/arm-kernel/msg595416.html
> >>> and see if you can just finish it off?
> >> [Wendy] This mailbox controller is about to use Xilinx IPI hardware as mailbox.
> >>
> > I couldn't find anything specific to Xilinx h/w
> > zynqmp_ipi_fw_call() is same as arm_smc_send_data() in Andre's driver
> > (though it needs to pass on [R2,R7] as I suggested in reply to him).
> >
> >> We use it to send notification/short request to firmware (usually running on
> >> another core on SoC),
> >>
> > So does Andre's driver. Which is precise and generic, so I much prefer that.
> >
> >> and also to receive notification/short request from firmware.
> >> Interrupt is used in the receiving direction. It looks different to the usage of
> >> mailbox driver from the link.
> >>
> > Yes, there is some difference. But nothing related to your h/w.
> > Andre's driver assume synchronous transmits where the response is
> > filled in the regs upon return.
> > What kind of calls do you make to your remote firmware? I would expect
> > them to be 'fast'.
>
> The reason to have this mailbox driver is because, we have an hardware block
> for IPI, this hardware block has registers and buffers and we want to
> to use Linux
> kernel mailbox framework APIs such as mbox_send_message() and rx_callback in
> client drivers to send notification or short request to other
> processors and receive
> response and request.
>
> The reason to use SMC calls to access the registers is because we have the case
> that both the ATF and Linux kernel drive will need to access the same registers.
>
> I have looked at the arm_smc patch, it looks like it is for
> synchronous request, and only
> allow 32bit message. In our case, we need to:
> * besides synchronous request, we also need to handle asynchronous request.
>   The driver will monitor the interrupt to see if there is a message
> from the other core.
>    If yes, it will notify the client from rx_callback.
> * put 32bytes short message to the mailbox.
>
> Thanks,
> Wendy
Hi Jassi,

Ping.
I posted some questions on another email to the ARM SMC mailbox
driver. But no response yet.
There are some issues with the latest ARM SMC mailbox driver I have seen so far.

* The message length is very limited. In our case, in order to send or
receive message from our mailbox hardware,
  we will need to extend the message length, in our case it is 32bytes.
  Here is what I am thinking about:
     * Opt 1: pass pointer from kernel to ATF to allow ATF to
read/write to the pointer.
     * Opt 2: define ARM-SMC message as
        struct arm_smc_msg {
                u32 len;
                void *msg;
                void *resp;
         };
         When sends to the message, use multiple SMC calls to copy the
message content to the SMCC parameters.
         Also use multiple SMC calls to get the response from SMCC parameters.
     * Opt3: even if our driver is using SMCC to send and receive
messages, but those SMCC calls will be specific to our hardware.
Instead of using a generic ARM-SMC mailbox driver, we have our vendor
specific mailbox driver in Linux kernel.

How do you think about the above options?

Thanks,
Wendy
>
> >
> >> Is there a plan to extend the ARM SMC mailbox driver
> >> to both trigger firmware actions and receive request from firmware?
> >>
> > Sure if we have a genuine requirement we can support RX path as well.
> >
> > Thanks.
