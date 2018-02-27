Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeB0HWl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:22:41 -0500
Received: from thoth.sbs.de ([192.35.17.2]:50714 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752372AbeB0HWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:22:38 -0500
Subject: Re: [PATCH 2/6] pci: Scan all functions when probing while running
 over Jailhouse
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Benedikt Spranger <b.spranger@linutronix.de>
References: <cover.1516601570.git.jan.kiszka@siemens.com>
 <66bfcfc6dc1832baa3fbd8e4879764d36aa9c1e7.1516601570.git.jan.kiszka@siemens.com>
 <CAHp75VcssoPE8ZCiHOt8-BKcponpr3xpzn42KZGx=Y+nMmZjYw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <17710852-a221-c707-0438-44031666028e@siemens.com>
Date: Tue, 27 Feb 2018 08:22:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAHp75VcssoPE8ZCiHOt8-BKcponpr3xpzn42KZGx=Y+nMmZjYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-23 14:23, Andy Shevchenko wrote:
> On Mon, Jan 22, 2018 at 8:12 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>>  #include <linux/export.h>
>>  #include <linux/pci.h>
>>  #include <asm/pci_x86.h>
>> +#include <asm/jailhouse_para.h>
> 
> Keep it in order?
> 

Done.

> 
>>  #include <linux/acpi.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/hypervisor.h>
> 
> Ditto.
> 

Despite the context suggesting it, this file has no ordering.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
