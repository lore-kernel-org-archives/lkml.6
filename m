Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 59B82C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA95208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2eB4Rc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA95208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935939AbeFMPAk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935734AbeFMPAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:00:38 -0400
Received: from mail-it0-f43.google.com (mail-it0-f43.google.com [209.85.214.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35294208AF;
        Wed, 13 Jun 2018 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528902038;
        bh=Ar9qFdvZ18Y7P9v6lgRMmV2DaywiLhTiyRmVQuMCazA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=q2eB4Rc14sdqTGg2lkr3Y7tFtCMjA6OhP9phPwT//mLHfddwYLCkdPQpMYRtvda3E
         gyDQTVB8hyPdtoj7Q7Tdk5F+OvWXy2jnzDcGqXJPAOj4Wk9SRFUFmhi3vpoGQjuNBs
         7roXJC2ge3CAp28T7H1lWokJkR2SEMXwzl7dPa9I=
Received: by mail-it0-f43.google.com with SMTP id p185-v6so4276300itp.4;
        Wed, 13 Jun 2018 08:00:38 -0700 (PDT)
X-Gm-Message-State: APt69E20Pee9/RP3jXty1/X2sLwYTBeOvddCSHL3QLxrrbusUGkORo1p
        TTYJz7zmx+V/p1PwByu+FplYoNBOLlqFCcm/ew==
X-Google-Smtp-Source: ADUXVKLdllfERofpdelI4P35eSJUBsRo6teb+BxUZJwDXWc9cF1bEFGtG9jw5WHEkj+3efnoEAGjBLpvDcxgcShnqYs=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr4728554itc.19.1528902037645;
 Wed, 13 Jun 2018 08:00:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 08:00:17
 -0700 (PDT)
In-Reply-To: <f5e71bac1bc23f96b7dae64bbdad8e2154c339aa.camel@kernel.crashing.org>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
 <CAL_Jsq+dHVN+Y7xczf_Oxcn=BiJ6N9WzovRbSujgLLTYHMEh0g@mail.gmail.com> <f5e71bac1bc23f96b7dae64bbdad8e2154c339aa.camel@kernel.crashing.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Jun 2018 09:00:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJtL0HMPxv5vMv2+LOyvyVtYusu3Ja-NikCy2RQSo7f0Q@mail.gmail.com>
Message-ID: <CAL_JsqJtL0HMPxv5vMv2+LOyvyVtYusu3Ja-NikCy2RQSo7f0Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:53 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2018-06-12 at 11:42 -0600, Rob Herring wrote:
>> On Mon, Jun 11, 2018 at 6:01 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > There are still quite a few cases where a device might want to get to a
>> > different node of the device-tree, obtain the resources and map them.
>> >
>> > Drivers doing that currently open code the whole thing, which is error
>> > proe.
>> >
>> > We have of_iomap() and of_io_request_and_map() but they both have shortcomings,
>> > such as not returning the size of the resource found (which can be necessary)
>> > and not being "managed".
>> >
>> > This adds a devm_of_iomap() that provides all of these and should probably
>> > replace uses of the above in most drivers.
>> >
>> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > ---
>> >
>> > I'm cooking a driver that uses this, if there's no objection I'd like
>> > to carry it in my pull request for that driver (it can also exist in
>> > the DT tree of course). Just let me know.
>>
>> We generally only use of_iomap when there is no struct device for any
>> new driver. Why can't you use devm_ioremap_resource? Is this a
>> non-platform bus device?
>
> This is just a wrapper on devm_ioremap_resource :-) Basically it's a
> "fixed" version of of_iomap, that has the devm* management and will
> mark the resource busy.
>
> My thinking was to then replace most of_iomap users with this.
>
> As for the specific case of the driver I'm cooking, it's a case where
> the SoC contains a little coprocessor (a ColdFire even !) alongside the

Wow. Must be the 1 licensee.

> main ARM core. I have a driver that offloads the bitbanging of some
> GPIOs to it (to implement the FSI bus). I use devm_of_iomap() to map
> the registers of the interrupt controller of the coprocessor, it's not
> really part of the interrupt tree, it doesn't distribute interrupts to
> the ARM or to Linux, it's just a device-node pointed to by a handle.

Accessing another processor's interrupt controller. What could go
wrong with that.

I guess this is fine. There's another problem though. This doesn't
work on Sparc because address.c is not built. I'd suggest moving to
of/device.c or a new file.


> BTW. Another thing that I find a bit annoying is "allocated" reserved-
> memory, there's no API to get to it other than via the DMA APIs or a
> CMA, which is overkill in a few circumstances (such as the one here
> where I just want to dedicate a bit of memory to the coprocessor).
> Right now I'm using a fixed reservation (with a reg property) and go to
> it "manually" but that somewhat sucks.

But that's not really a DT problem. It's a kernel problem if you can't
reserve a contiguous range of unmapped pages. But why not just get
coherent allocation and ignore that it is mapped. That seems better to
me than working around it in DT.

Rob
