Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D3FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486472413A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486472413A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeGDKuW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:50:22 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:42934 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbeGDKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:50:20 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id CEF4041C99; Wed,  4 Jul 2018 12:50:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id C643841C98;
        Wed,  4 Jul 2018 12:50:16 +0200 (CEST)
Date:   Wed, 4 Jul 2018 12:50:16 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
X-X-Sender: nv@fox.voss.local
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
In-Reply-To: <CAHp75VeuoTM=RoUgk0qWyiRJYk2AncVhxKDvms_2Hv0yE=g8uQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807041239080.9273@fox.voss.local>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com> <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com> <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com> <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
 <8518137d-c859-657e-844f-51720f6ef8dd@arm.com> <alpine.DEB.2.20.1807041205290.8629@fox.voss.local> <CAHp75VeuoTM=RoUgk0qWyiRJYk2AncVhxKDvms_2Hv0yE=g8uQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 1:17 PM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> On Wed, 4 Jul 2018, Sudeep Holla wrote:
>>> On 04/07/18 10:32, Andy Shevchenko wrote:
>>>> On Wed, Jul 4, 2018 at 6:37 AM, Srinath Mannam
>>>> <srinath.mannam@broadcom.com> wrote:
>
>>> +1 on NACK for this and anything else that abuse PRP0001 as a short cut
>>> approach.
>> This is no abuse but exactly what PRP0001 is meant for. The basic idea of
>> PRP0001 is to reuse DT "compatible" strings in ACPI namespace, see
>> Documentation/acpi/enumeration.txt. Reusing also means getting access to the
>> of_device_id.
>
> The idea was for almost DIY and / or manufacturer to develop a
> prototype without modifying match code and faking ACPI IDs.
> That's why the target of PRP0001 is almost sensors connected to I2C and SPI.
>
> That's why I agreed on your patch to help with this. But! The proper
> solution for the devices (device manufacturer) is to allocate an ACPI
> ID and provide a corresponding table to the driver.
>
> This is my understanding of that exercise. Rafael can correct me.

This is not meant as a short cut for device manufacturers. The patch is meant to 
make PRP0001 work when access to specific driver_data is needed. I see 
nothing bad with it.

>> Allocating an ACPI id for an already existing DT driver is redundant, isn't
>> it?
>
> It is not.

The driver won't work any better with it. The driver code gets another 
table as big as of_device_id table. Can you give me a hint what the added 
value is?

Niko


