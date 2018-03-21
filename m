Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCURis (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:38:48 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33118 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeCURir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:38:47 -0400
X-Google-Smtp-Source: AG47ELvjib/o+A4zEOylEckEdVZU9u5bmqWBAQgs/diWqDZm0X83BfmVJNVG6oyyYfgqJs6Xk4s8OQ==
Subject: Re: Why two irq chips for MSI
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <81eb7191-1c5c-ad27-2714-9563e4ef7c68@gmail.com>
 <adf13928-d1da-e8af-5b32-efc199ac6ba9@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
From: valmiki <valmikibow@gmail.com>
Message-ID: <a0cd800b-f20f-64f3-c3b3-7f0c193c2b16@gmail.com>
Date: Wed, 21 Mar 2018 23:08:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <adf13928-d1da-e8af-5b32-efc199ac6ba9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 21/03/18 17:12, valmiki wrote:
>> Hi,
>>
>> In most of the RP drivers, why two irq chips are being used for MSI ?
>>
>> One at irq_domain_set_info (which uses irq_compose_msi_msg and
>> irq_set_affinity methods) and another being registered with struct
>> msi_domain_info (which uses irq_mask/irq_unmask methods).
>>
>> When will each chip be used w.r.t to virq ?
>
> A simple way to think of it is that you have two pieces of HW involved:
> an end-point that generates an interrupt, and a controller that receives it.
>
> Transpose this to the kernel view of things: one chip implements the PCI
> MSI, with the PCI semantics attached to it (how to program the
> payload/doorbell into the end-point, for example). The other implements
> the MSI controller part of it, talking to the HW that deals with the
> interrupt.
>
> Does it makes sense? Admittedly, this is not always that simple, but
> that the general approach.
>
Thanks Marc. Yes got a good picture now.
So the one which implements PCI semantics has irq_set_affinity, which is 
being invoked at request_irq. Why most of the drivers have this as dummy 
with return 0 ?
Does setting affinity to MSI needs any support from GIC?
Setting affinity can be achieved only with hardware support ?

Valmiki

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
