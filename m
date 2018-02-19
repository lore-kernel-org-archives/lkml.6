Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeBSRm1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:42:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeBSRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:42:26 -0500
Subject: Re: linux acpi (thunderbolt? bug)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuriy Vostrikov <delamonpansie@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <CABbc0=RMYWGN0L=z_Y=FuZJUDzD5NVa2XBTVnmpZxX5tnk3-5g@mail.gmail.com>
 <alpine.DEB.2.21.1802141306360.1292@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802150948530.1673@nanos.tec.linutronix.de>
 <CABbc0=QZY8d_Kyd5hX5X99S60ANrncPSk785FpZTAJS+C9_tDQ@mail.gmail.com>
 <alpine.DEB.2.21.1802181901520.1549@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802191549270.1853@nanos.tec.linutronix.de>
 <bfee0c69-ce31-f699-7e9b-7c28fc640596@infradead.org>
 <alpine.DEB.2.21.1802191823570.1853@nanos.tec.linutronix.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <01a8cd3c-4f03-d6d4-23c1-afea1c5099e3@infradead.org>
Date: Mon, 19 Feb 2018 09:42:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802191823570.1853@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/18 09:26, Thomas Gleixner wrote:
> On Mon, 19 Feb 2018, Randy Dunlap wrote:
> 
>> On 02/19/18 06:51, Thomas Gleixner wrote:
>>>  	} else {
>>> +		/*
>>> +		 * Offline case: The current vector needs to be released in
>>> +		 * the matrix allocator.
>>> +		 */
>>> +		if (apicd->vector &&
>>
>> Drop the "apicd->vector &&" ? (redundant)
> 
> No. The else path is entered when
> 
>     apicd->vector == 0
> 
> or
> 
>     apicd->cpu is offline
> 
> So we need to check here for vector != 0 as otherwise we'd free vector 0
> which is invalid. I'll add a comment explaining the mess.
> 
>>> +		    apicd->vector != MANAGED_IRQ_SHUTDOWN_VECTOR) {
>>> +			irq_matrix_free(vector_matrix, apicd->cpu,
>>> +					apicd->vector, managed);
>>> +		}
>>>  		apicd->prev_vector = 0;
>>>  	}

I see. Thanks.

-- 
~Randy
