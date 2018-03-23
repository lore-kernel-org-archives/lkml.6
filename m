Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeCWVbC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:31:02 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:33143 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeCWVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:31:00 -0400
X-Google-Smtp-Source: AG47ELv3T4aDvzdumhzauXw7eOYWQ0tFtHez1d5fkzKMX9HcWiXl1kgDe37cOs8jP/CmOaPGA7MILw==
Subject: Re: [PATCH v2 1/2] x86, msr: add rdmsr_safe_on_cpu_resched() and use
 it in msr_read()
To: Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Cc: x86 <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Hugh Dickins <hughd@google.com>, Borislav Petkov <bp@alien8.de>
References: <20180319152503.123372-1-edumazet@google.com>
 <alpine.DEB.2.21.1803232221550.1481@nanos.tec.linutronix.de>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f4e89d95-1cd8-a9c9-cc93-77c35d82e76b@gmail.com>
Date: Fri, 23 Mar 2018 14:30:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803232221550.1481@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/23/2018 02:27 PM, Thomas Gleixner wrote:
>
> Looking at all call sites. None of them is performance critical and all of
> them are in preemptible context.
> 
> So we simply can switch the rdmsr_safe_on_cpu() implementation over to wait
> mode completely.

SGTM, thanks for looking, I will send a v3 then.

> 
>> +/* Note: This version spins in smp_call_function_single().
>> + * Consider using rdmsr_safe_on_cpu_resched() variant instead.
> 
> Bah. This is not networking code. x86 uses sensible comment style :)

Right ;)
