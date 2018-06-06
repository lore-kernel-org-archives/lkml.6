Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN4H/fMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6CB860764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeFFLom (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:44:42 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:46489 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeFFLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:44:40 -0400
X-Google-Smtp-Source: ADUXVKJNpPbClEOBOBLZCds6LqxHhW25B/N6PlW7HdcwXS1c683Qdw7Fw+wtHrb97fUu5ltG/Bs1Ola0ND3AFT0eRB4=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806061133450.1579@nanos.tec.linutronix.de>
References: <CAFgQCTudugoNc26P22V+G_awzj2srKHhWBJubFoa7-K=cDtQyw@mail.gmail.com>
 <alpine.DEB.2.21.1806061114290.1584@nanos.tec.linutronix.de>
 <CAFgQCTsqbv2nwAwcvv6hW9mbaWRE251jroMSLM5891VYsr=bMw@mail.gmail.com> <alpine.DEB.2.21.1806061133450.1579@nanos.tec.linutronix.de>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 6 Jun 2018 19:44:38 +0800
Message-ID: <CAFgQCTv-Bou-XSfzDhH0tVefiL8Dk2Uv4jcLvGeupQ2Tu6o+MQ@mail.gmail.com>
Subject: Re: question about the limited interrupt vector resource on a single cpu
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 5:34 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 6 Jun 2018, Pingfan Liu wrote:
>
>> On Wed, Jun 6, 2018 at 5:15 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Wed, 6 Jun 2018, Pingfan Liu wrote:
>> >
>> >> For x86, there is around 200 vectors left for external device on a
>> >> single logic cpu.
>> >>
>> >> Is there any case that we exhaust them in real world, and is it worth to fix?
>> >
>> > Exhaustion is unlikely, but how would you fix it? The vector space per CPU
>> > is limited by hardware not software.
>> >
>> Playing some trick on iommu, we can use it to identify the irq requester.
>
> But what's the point? If you have more than 200 device interrupts on a
> single CPU, then you surely have other problems than that.
>
> What kind of problem are you trying to solve?
>
In kdump case,  normally we set nr_cpus=1 by default, and in some huge
system, it can exhaust vector space.
By this is easily to resolve by inc nr_cpus. Hence I post this
question to see whether there are other requirements to resolve such
case

Thanks,
Pingfan
