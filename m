Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeFDL7x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:59:53 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:65446 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752667AbeFDL7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:59:52 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40720088"
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>
CC: Song Liu <songliubraving@fb.com>, Song Liu <liu.song.a23@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>, Kernel Team <Kernel-team@fb.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <CAJwJo6aeb2q-C1R2MBnQQ8yR+7Xy4FWqSmBCE=7CkK_OHNCqSQ@mail.gmail.com>
 <alpine.DEB.2.21.1805191319190.1599@nanos.tec.linutronix.de>
 <16f47fa4-1555-cddb-3dfb-7d56fb992ea1@mellanox.com>
 <alpine.DEB.2.21.1805231049021.1598@nanos.tec.linutronix.de>
 <CAPhsuW7PPRfPYfCtBMsOYdGJCkPKsVNU0501RFKdECvadhOu3w@mail.gmail.com>
 <alpine.DEB.2.21.1805281251140.1578@nanos.tec.linutronix.de>
 <09A22A95-6BBD-48EB-A2FE-42BF6244F751@fb.com>
 <alpine.DEB.2.21.1805282206440.1584@nanos.tec.linutronix.de>
 <e4237c07-f00a-1820-d36a-7dbee4ea0297@cn.fujitsu.com>
 <alpine.DEB.2.21.1806041316020.2646@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <58b776f7-58ae-131b-47af-d85452794a0f@cn.fujitsu.com>
Date: Mon, 4 Jun 2018 19:59:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806041316020.2646@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: B80B34B41E69.A8E0B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 06/04/2018 07:17 PM, Thomas Gleixner wrote:
> On Mon, 4 Jun 2018, Dou Liyang wrote:
>> Here, why didn't we avoid this cleanup by
>>
>> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
>> index a75de0792942..0cc59646755f 100644
>> --- a/arch/x86/kernel/apic/vector.c
>> +++ b/arch/x86/kernel/apic/vector.c
>> @@ -821,6 +821,9 @@ static void free_moved_vector(struct apic_chip_data
>> *apicd)
>>           */
>>          WARN_ON_ONCE(managed);
>>
>> +       if (!vector)
>> +               return;
>> +
>>          trace_vector_free_moved(apicd->irq, cpu, vector, managed);
>>          irq_matrix_free(vector_matrix, cpu, vector, managed);
>>          per_cpu(vector_irq, cpu)[vector] = VECTOR_UNUSED;
>>
>> Is there something I didn't consider with? ;-)
> 
> Well, that just prevents the warning, but the hlist is already
> corrupted. So you'd just cure the symptom ...
> 

I see.

> I'm about to send a patch series which addresses that. Just need to finish
> writing changelogs.
> 

Thank you for telling me that.

Thanks,
	dou
