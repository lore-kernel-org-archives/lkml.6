Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459FFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E155220857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 21:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1JbkkeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E155220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeGZWuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 18:50:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36119 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbeGZWuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 18:50:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so1923284pgv.3;
        Thu, 26 Jul 2018 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/hRtxg6fUQ0gL3QOyE0ZRNMMYRDIL7yKstkNtMoIl1k=;
        b=k1JbkkeAV2hqsnBb0S4lCYNAHxPR3ilRjLAGrOzbviUKpu2MzYGxdz3la36uhP3Mrg
         JyrMBPNvy+glBS8yWQ2r2wec92u+AqO47IUceMeKXeO8vRJg+RTrEIsFlr10yU3jCUuB
         Lg2CiokJUC99uuUVeB1cYFXHf7UHnCUMsuJgavh3KVlrduXUUud5mzUOxVShi9CZr+nR
         blTMTzBwY/+BFMQuh3nC28+Xma95uMhEXxMt01hknaE7O/NMvOW95ND66dwYes0yNwAh
         EdToBGSRiZd9wfrcAYSLtVlw5kreTYZsLcQC2fPzNuIQh97Q6DViHQzsrDawZgc0DaMp
         hdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/hRtxg6fUQ0gL3QOyE0ZRNMMYRDIL7yKstkNtMoIl1k=;
        b=QzRENd2OZfT31UVpEdYmgy/bKjtFbZyOxFLSVAP7VLD9U2U2mxlaT0WMqAEVIAR+6p
         28AxQy0/w+v975k79bww2xvjIF1EmAS20VIutl/XdL2DLnjDKVWe7njEGAMRDk/RP7R+
         E6brqq2Sf61jzgJ/nMox+P33lY5rlEoShJJu/4NQzpe5NRNJTbPdasxTVHSbtpHzgS/j
         9TmQ7JIgIzYsxKAnkfEYeEzgt8/aYBXfg9Vl6i7ondy+0o8jFKqyZswriY1hw9yRNLOO
         WHcW3VIn+fnThE3rhEFkhSsnEvRfgDgHao1yv6X18Iq3/9p52QY7WaeU4+I2pJ0xgqt/
         /l+Q==
X-Gm-Message-State: AOUpUlHgDwmUs7Mo1+JYwgG7Cd1bL8jsbTCoCqCO3mFb6MgQo0BesCrM
        T98ZoKlO9aWT/0QCvgCEiDrI1fywZreXizY7oH8=
X-Google-Smtp-Source: AAOMgpd475Dj7bEfykcy6wc1xd3qlTu0eyzHS8L7Wmu445lXyGDey9pVDIRi6QMKgv+T/XzFYynCE4FSy/IWr9DoYNk=
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr3451967pgp.65.1532640682596;
 Thu, 26 Jul 2018 14:31:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:6d90:0:0:0:0 with HTTP; Thu, 26 Jul 2018 14:31:02
 -0700 (PDT)
In-Reply-To: <CABb+yY1VxNCskPK4LJ=JnxyKPBid2SEEgRLK3M1Csbu2xMRn8g@mail.gmail.com>
References: <1515109891-17133-1-git-send-email-jliang@xilinx.com>
 <1515109891-17133-3-git-send-email-jliang@xilinx.com> <CABb+yY00n6fLiQXftj-TMhT6q=KopZMkLYr6DpYE8CvxH-gz8Q@mail.gmail.com>
 <BY1PR0201MB0885F2BCD9FE353171B54888B0110@BY1PR0201MB0885.namprd02.prod.outlook.com>
 <CABb+yY1VxNCskPK4LJ=JnxyKPBid2SEEgRLK3M1Csbu2xMRn8g@mail.gmail.com>
From:   Wendy Liang <sunnyliangjy@gmail.com>
Date:   Thu, 26 Jul 2018 14:31:02 -0700
Message-ID: <CAA07jV-K5x0TFvVDE4SyFqCztJsjiMbns=h=dQ4_EPRa+p7jfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: mailbox: Add Xilinx IPI Mailbox
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jiaying Liang <jliang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 9, 2018 at 8:42 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Wed, Jan 10, 2018 at 6:52 AM, Jiaying Liang <jliang@xilinx.com> wrote:
>>> From: Jassi Brar [mailto:jassisinghbrar@gmail.com]
>
>>> > +
>>> > +Controller Device Node:
>>> > +===========================
>>> > +Required properties:
>>> > +--------------------
>>> > +- compatible:          Shall be: "xlnx,zynqmp-ipi-mailbox"
>>> > +- reg:                 IPI buffers address ranges
>>> > +- reg-names:           Names of the reg resources. It should have:
>>> > +                       * local_request_region
>>> > +                         - IPI request msg buffer written by local and read
>>> > +                           by remote
>>> > +                       * local_response_region
>>> > +                         - IPI response msg buffer written by local and read
>>> > +                           by remote
>>> > +                       * remote_request_region
>>> > +                         - IPI request msg buffer written by remote and read
>>> > +                           by local
>>> > +                       * remote_response_region
>>> > +                         - IPI response msg buffer written by remote and read
>>> > +                           by local
>>> >
>>> shmem is option and external to the controller. It should be passed via
>>> client's binding.
>>> Please have a look at Sudeep's proposed patch
>>> https://www.spinics.net/lists/arm-kernel/msg626120.html
>> [Wendy] thanks for the link, but those 'buffers" are registers in the hardware
>> but not memory.
>>
> No, that is for memory, not registers.
> Please have a more careful look at the patch.

Sorry for very late response.

Those are not the normal memory but device memories,
they are 32bytes fixed request buffers and response buffers per
channel. They come
from the IPI hardware block.

The mailbox framework API "mbox_send_message()" allows users to send message
to the mailbox. in this case, just not clear on why we cannot have the
buffer in the
controller? These memories are not for sharing data, but just for
short notification
messages.

>
>>>
>>> > +- #mbox-cells:         Shall be 1. It contains:
>>> > +                       * tx(0) or rx(1) channel
>>> > +- xlnx,ipi-ids:                Xilinx IPI agent IDs of the two peers of the
>>> > +                       Xilinx IPI communication channel.
>>> > +- interrupt-parent:    Phandle for the interrupt controller
>>> > +- interrupts:          Interrupt information corresponding to the
>>> > +                       interrupt-names property.
>>> > +
>>> > +Optional properties:
>>> > +--------------------
>>> > +- method:              The method of accessing the IPI agent registers.
>>> > +                       Permitted values are: "smc" and "hvc". Default is
>>> > +                       "smc".
>>> > +
>>> Andre almost implemented the generic driver. Can you please have a look at
>>> https://www.spinics.net/lists/arm-kernel/msg595416.html
>>> and see if you can just finish it off?
>> [Wendy] This mailbox controller is about to use Xilinx IPI hardware as mailbox.
>>
> I couldn't find anything specific to Xilinx h/w
> zynqmp_ipi_fw_call() is same as arm_smc_send_data() in Andre's driver
> (though it needs to pass on [R2,R7] as I suggested in reply to him).
>
>> We use it to send notification/short request to firmware (usually running on
>> another core on SoC),
>>
> So does Andre's driver. Which is precise and generic, so I much prefer that.
>
>> and also to receive notification/short request from firmware.
>> Interrupt is used in the receiving direction. It looks different to the usage of
>> mailbox driver from the link.
>>
> Yes, there is some difference. But nothing related to your h/w.
> Andre's driver assume synchronous transmits where the response is
> filled in the regs upon return.
> What kind of calls do you make to your remote firmware? I would expect
> them to be 'fast'.

The reason to have this mailbox driver is because, we have an hardware block
for IPI, this hardware block has registers and buffers and we want to
to use Linux
kernel mailbox framework APIs such as mbox_send_message() and rx_callback in
client drivers to send notification or short request to other
processors and receive
response and request.

The reason to use SMC calls to access the registers is because we have the case
that both the ATF and Linux kernel drive will need to access the same registers.

I have looked at the arm_smc patch, it looks like it is for
synchronous request, and only
allow 32bit message. In our case, we need to:
* besides synchronous request, we also need to handle asynchronous request.
  The driver will monitor the interrupt to see if there is a message
from the other core.
   If yes, it will notify the client from rx_callback.
* put 32bytes short message to the mailbox.

Thanks,
Wendy

>
>> Is there a plan to extend the ARM SMC mailbox driver
>> to both trigger firmware actions and receive request from firmware?
>>
> Sure if we have a genuine requirement we can support RX path as well.
>
> Thanks.
