Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeCNR2N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:28:13 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40450 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbeCNR2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:28:12 -0400
X-Google-Smtp-Source: AG47ELt759+bIx6kOqkBuPog+cSvS4+U/UcDxP11itF2sdVL6QAyGgWCa+Wb2anK9eGBR+9dlp9aHw==
Date: Wed, 14 Mar 2018 10:28:10 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Mar 2018 10:28:06 PDT (-0700)
Subject: Re: [PATCH v3 3/5] arm: Convert to GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <alpine.DEB.2.21.1803141806580.2481@nanos.tec.linutronix.de>
CC: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@sifive.com>
To: tglx@linutronix.de
Message-ID: <mhng-154bcacc-ddfa-4875-b5c5-e3efc72f3e42@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018 10:07:35 PDT (-0700), tglx@linutronix.de wrote:
> On Wed, 7 Mar 2018, Palmer Dabbelt wrote:
>
>> This converts the ARM port to use the recently added
>> GENERIC_IRQ_MULTI_HANDLER, which is essentially just a copy of ARM's
>> existhing MULTI_IRQ_HANDLER.  The only changes are:
>>
>> * handle_arch_irq is now defined in a generic C file instead of an
>>   arm-specific assembly file.
>> * handle_arch_irq is not marked as __ro_after_init.
>
> Why? What prevents the generic implementation from doing so?

Sorry, I guess that should have said "handle_arch_irq was not marked as
__ro_after_init".  The patch set has __ro_after_init for the generic
implementation, which was not the case for the arm version.
