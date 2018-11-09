Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C6EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB320825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB320825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbeKJHem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:34:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:45947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeKJHem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:34:42 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0Ln8gj-1fryoJ1FUb-00hRFw; Fri, 09
 Nov 2018 22:51:54 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: ODEBUG: Out of memory. ODEBUG disabled
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <5c3b1cf4-1d83-c0a5-4243-28fde66b5cd9@linux.alibaba.com>
Date:   Fri, 9 Nov 2018 16:51:50 -0500
Cc:     open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Zhong Jiang <zhongjiang@huawei.com>
Content-Transfer-Encoding: 7bit
Message-Id: <9762E093-FCDD-4DAA-8FCE-9D6B953B6F17@gmx.us>
References: <54B1AA39-2C58-4B0C-B8A8-9F85EBA7C963@gmx.us>
 <5c3b1cf4-1d83-c0a5-4243-28fde66b5cd9@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:4SqzdXBWIxzxUGmcadSeBzIIuT/FFvTX9ty9vKdPzYeCBn5TJhR
 veQoB2IpdSvaUdTGxY+sTfRqrxvUlW6Yf/a8YRIlmQVaME/9kWS7XBlJ79XFNjDT38U/vxw
 A6B6loa4zW3gKSYsWjAq1l/Bm8IULMQAdO3ZfcCR2lEMAbpDV1AqxrBQFT5SMSwmzHHtKwz
 dZShKPwu7olDXREi6P6tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WjM0q5enBF0=:srCsAmSGuZ7UQ2Z2ZE2nH5
 qYbYxogJXBOSZMzGC3AkzWDLbjfmixCKufPD8nABF2ezAtSud99vFKi2NN31jwYvl1JFVoBxw
 YzPmSKDwDvwv9NeCgFnpOvG4DFEHcF5cfmXKRZ8UBUQk6mS5mG881JmDycPQDkmiFT1J5lxec
 p+km2HO/oZI6spJPdqWkgJAXXaKGFYj2B3ZdXM3i6OPnwuL1RYsWaxUCZVdieUAYh0hAqhWj+
 6hbUJGwqtVNFeeyZweEenQU+31GNOldeu2VR5kG3CL9LrdDNHMgOkBCSJ4SHnweumqEIfwZ0x
 sK0pz/GRjGPh8wjLBPO8Y+48GC3WClMxTEp7CH7HoF1cF+d6vkB0RzzlkZ9sw0M6kXsAxsuX9
 seTcOOLCbU5/203fjBMNbiihD69sCtRQYnxGHF+W6mWvtpTmu3kpGec18icty0/10lCFF39YN
 0kQ0rs6rCioo1+L9YouLUaAcXuiC6rxBH8qlCMrMAsY81QrVaQl3LouM5yPMrTX3ziyQEBXpk
 clZpHawj8Ay8Kz4nbemLmqW3Rxzk6kvv9Ff/okjeOO0YrC9rWmtW+YRSq7CSKx1RGTvRGmnKD
 hbsDDoV3moRj56arQ0Txs+dQ0Bn77EZOPdPluep/drzM0cSfiYnVxpqyl7qycTLppB+3dMbvD
 HVrFkf1Czquhd1GoWC+JySYj8O8eT2c8O1o+kvUsy/XjbFvIBZMl2a1YvFk4FuHD8CHoFBiQE
 fOMFxG4Fry9YgL1gALygtFed/ht9iRZGC7ioTppem6m5mgoZL6wrZpiKdSl/sQ3uDTGByvGvc
 ZvNuWgqzixYuYxuPaC1dqTDmwG0swD9dmEzfvrewPrimbgvOw3YJU7Qo6wIXMYjbByLeiuTWU
 7gbSEB1vGH8hx1UzfTQyOVRVIV5xQtl246HTDPUt4SkRHDI/RO3XadEUokXEYs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 4:42 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
> 
> 
> 
> On 11/9/18 1:36 PM, Qian Cai wrote:
>> It is a bit annoying on this aarch64 server with 64 CPUs that is
>> booting the latest mainline (3541833fd1f2) causes object debugging
>> always running out of memory.
> 
> May you please paste the detail failure log?
I assume you mean dmesg.

Here is the dmesg for 64 CPUs,
https://paste.ubuntu.com/p/BnhvXXhn7k/
>> 
>> I have to boot the kernel with only 16 CPUs instead (nr_cpus=16)
>> to make it work. Is it expected that object debugging is not going
>> to work with large machines?
> 
> I don't think so. I'm supposed it works well with large CPU number on x86.
Here is the one with nr_cpus workaround,
https://paste.ubuntu.com/p/qMpd2CCPSV/
