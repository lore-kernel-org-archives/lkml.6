Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeB1JTa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:19:30 -0500
Received: from nbd.name ([46.4.11.11]:40674 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeB1JT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:19:28 -0500
Subject: Re: [PATCH] clocksource: mips-gic-timer: fix clocksource counter
 width
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        paul.burton@imgtec.com
References: <20180221124749.39471-1-nbd@nbd.name>
 <alpine.DEB.2.21.1802280955430.1886@nanos.tec.linutronix.de>
From: Felix Fietkau <nbd@nbd.name>
Message-ID: <207b6722-a506-1e6a-c81c-a530e772dfa6@nbd.name>
Date: Wed, 28 Feb 2018 10:19:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802280955430.1886@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-28 09:56, Thomas Gleixner wrote:
> On Wed, 21 Feb 2018, Felix Fietkau wrote:
> 
>> This code needs to use ffs instead of fls on the mask to determine the
>> shift for reading the GIC_CONFIG_COUNTBITS field.
> 
> Why?
>>  	count_width = read_gic_config() & GIC_CONFIG_COUNTBITS;
>> -	count_width >>= __fls(GIC_CONFIG_COUNTBITS);
>> +	count_width >>= __ffs(GIC_CONFIG_COUNTBITS);
This code is trying to extract the GIC_CONFIG_COUNTBITS field from
read_gic_config(), so it needs to shift count_width right by the index
of the least significant bit (__ffs) instead of the most significant bit
(__fls) of the field mask.

- Felix
