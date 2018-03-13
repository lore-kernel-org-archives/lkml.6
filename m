Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeCMJZZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 05:25:25 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44647 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeCMJZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 05:25:20 -0400
X-Google-Smtp-Source: AG47ELu5FXqv4o4mXrSwZipDMZ30r+1SXyA9YIkOR6+UaEAnbe/fgAKqcFKV/s34H/uW+4EV0QxxYl84jLdBcB4X6Z4=
MIME-Version: 1.0
In-Reply-To: <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
References: <20180308105358.1506-1-ming.lei@redhat.com> <1520515113.20980.31.camel@gmail.com>
 <20180308133440.GA2713@ming.t460p> <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p> <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p> <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
 <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Mar 2018 10:25:19 +0100
X-Google-Sender-Auth: DvQfiePxi_9v50-ad6plfjIvBlA
Message-ID: <CAJZ5v0hKYJY9W3Gjo-KZzmfXhT7JqBxbe=AGPSQOSd4DCThJVA@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>,
        Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 4:11 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> Hi Thomas,
>
> At 03/09/2018 11:08 PM, Thomas Gleixner wrote:
> [...]
>>
>>
>> I'm not sure if there is a clear indicator whether physcial hotplug is
>> supported or not, but the ACPI folks (x86) and architecture maintainers
>
> +cc Rafael
>
>> should be able to answer that question. I have a machine which says:
>>
>>     smpboot: Allowing 128 CPUs, 96 hotplug CPUs
>>
>> There is definitely no way to hotplug anything on that machine and sure
>> the
>
>
> AFAIK, in ACPI based dynamic reconfiguration, there is no clear
> indicator. In theory, If the ACPI tables have the hotpluggable
> CPU resources, the OS can support physical hotplug.

In order for the ACPI-based CPU hotplug (I mean physical, not just the
software offline/online we do in the kernel) to work, there have to be
objects in the ACPI namespace corresponding to all of the processors
in question.

If they are not present, there is no way to signal insertion and eject
the processors safely.
