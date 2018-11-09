Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94051C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599C42080D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599C42080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeKJBJV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:09:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:39941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeKJBJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:09:21 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MhQju-1g8ZfU0gVe-00MbEx; Fri, 09
 Nov 2018 16:28:10 +0100
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <b23b62b4-9ecb-8b76-57e5-d323cc9926ce@arm.com>
Date:   Fri, 9 Nov 2018 10:28:06 -0500
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <13A11479-97FB-4EFD-A182-61DA63CB64D6@gmx.us>
References: <1541710771.12945.7.camel@gmx.us>
 <c8ff3004-33ee-19d5-8eb8-38d41f78c8ee@arm.com>
 <trinity-e1d06dde-12e1-4e2a-8871-d6c5f4af9f51-1541766480902@msvc-mesg-gmx023>
 <b23b62b4-9ecb-8b76-57e5-d323cc9926ce@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:rPJwO6RxgO0SFVphsh6B7EeAOlmTurcyYpAr0Um5NNA1UaZVAPa
 XFA0654qNUkAdZnAg90+1Pl383usjRucwfkQQD5C/Kmhoc7P7IzWH6rp8zZDYa06S4ZorDm
 OIIHLEE30l/TOT9I1DUy17Ljehh24uc4T/yooOx9ZfTpoU56MQjFQYZunEsLGWDfqVZcyVF
 8VOYpPA1+RN16UnT4Da2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eoJMFF+wqTs=:v48fVdWTZpt/huh3tkb+NT
 JjaHgmd4YTEoaqPktgKl5v5MDxsMB2O1LE15Alf87vDNCep5mhqAkHcQ4s62WuYEJ44H0KuOf
 P/8tduNbbLb9Iidp1LVAYnH75HCwX79t9KB54iFke0ecAE5ZuBJQ0wP6E0IKFzEV3fr3PDzYO
 U8J6zAYgenqpKKrPBcaUxclRic9utgjyMkBkEg5WyUsf9uGrQN6+At5jWEwt7V6Wj829/MTU9
 twB2Ntkn2GuUfTZjgEqSxv7a0HCpNp22ELvez7yaCSqjei/CYUAfi8vMZsz0fwV0dgTJXNX3i
 pb+JM/BtQjcamwc4FVXXNtNE++O3NfqxyMP7KFaQJguNw3bzRqXm7oOk6MwYYtqr0Usi5R5wC
 lO9X/l8nvsu9kLQa2tFtb96NNgpwXCQOAz93rbGHg9PtHz/gBk1VDyjSYqQq4RvkIQn9NGpbE
 2Tf3Hyw2UMs+MVj4JUniM88k254Pwy8oaCqYdCCDv8UTAG3YS+Pr72DAkiZQZtZVT23gYhEiK
 nI1y0xEHq+Ct0PrCXVHxQFd8B+5gM40Y5ZPnnHo6vznrhifD+dpy4yBcNxNl0GtacbfdN3KAb
 OVlDg5d/qzFI58/OpqjWdngULQ/ykKZ56QqJXeK8n/HNq0cfawXspPwzEwLyXWuQVX+SVxNxu
 BEOj0jsgpJemJzIB9CPQAfw1M0Djnl/jpz//1etkqZCdKPM4ii6jLkW8rELU4WA0Bf31m0Jkf
 ZsfQAzdbqGk6NftxKDDTfix04nRSwe2JuqRnhq/pflKHmhBnv+j7K2WiW6zBVPTIIQEPwLSqz
 +shZvHa7o5PsbUiuQnCFu/tiKAUeFyIQ1KqyWnunNDPJBAqDh3H96CDpTa/0TNuAnWld/mRsO
 4eJrafWXZj6y0dJkWcaWZIboHI5EHZxvKKkXz5jVlWm6z9ZfXw5RQ9InyH3gKN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 8:50 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
> On 09/11/18 12:28, Qian Cai wrote:
>> 
>> On 11/9/18 at 7:08 AM, Marc Zyngier wrote:
>> 
>>> [+Ard]
>>> 
>>> On 08/11/18 20:59, Qian Cai wrote:
>>>> Just booting up the latest git master (b00d209) on an aarch64 server and saw
>>>> this. Not sure about the third warning (at kernel/cpu.c:315
>>>> lockdep_assert_cpus_held+0x50/0x60) relates to irqchip or not, but appended it
>>>> to here anyway just in case.
>>>> 
>>>> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696
>>>> its_init+0x588/0xb54
>>> 
>>> It looks like EFI cannot manage to reserve the memory for your GIC
>>> redistributors. Pretty annoying. At the same time, you have reported
>>> other issues with the EFI reservation mechanism, such as:
>>> 
>>> https://lore.kernel.org/patchwork/patch/1008413/
>>> 
>>> for which you have given a "Tested-by:". Is that related?
>> No, I don’t think so. Those warnings are still there even after applied the patch above.
> 
> Do you also have this series[1] applied? I'd otherwise need your
> configuration to try and reproduce it, as I can't manage to trigger it
> on my own setup.
> 
> Thanks,
> 
> 	M.
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg685751.html
After applied the above series on the top of the mainline (b00d209), the only
warning exist is,

[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/cpu.c:315
lockdep_assert_cpus_held+0x50/0x60
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T 4.20.0-rc1+ #9
[    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    0.000000] pc : lockdep_assert_cpus_held+0x50/0x60
[    0.000000] lr : lockdep_assert_cpus_held+0x4c/0x60
[    0.000000] sp : ffff200009c97b10
[    0.000000] x29: ffff200009c97b10 x28: ffff200009e39000 
[    0.000000] x27: ffff200009cd1000 x26: ffff200009cd2000 
[    0.000000] x25: ffff200009125000 x24: ffff200009cc9868 
[    0.000000] x23: ffff200009c7c040 x22: 0000000000001000 
[    0.000000] x21: 0000000000000012 x20: ffff200009cc9000 
[    0.000000] x19: ffff200009cd5000 x18: 000000000000003f 
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 
[    0.000000] x15: 0000000000000007 x14: ffff200009461cd4 
[    0.000000] x13: ffff2000094695ac x12: ffff2000095149a4 
[    0.000000] x11: ffff2000094e4478 x10: ffff2000094e0a50 
[    0.000000] x9 : ffff200009516aa8 x8 : ffff0ffbffcc4004 
[    0.000000] x7 : 1fffeffbffcc4003 x6 : ffff0ffbffcc4003 
[    0.000000] x5 : ffff7fdffe62001b x4 : ffff0ffbffcc4004 
[    0.000000] x3 : ffff0ffbffcc4004 x2 : dfff200000000000 
[    0.000000] x1 : 0000000000000000 x0 : 0000000000000000 
[    0.000000] Call trace:
[    0.000000]  lockdep_assert_cpus_held+0x50/0x60
[    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
[    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
[    0.000000]  arch_timer_acpi_init+0x274/0x6ac
[    0.000000]  acpi_table_parse+0x1ac/0x218
[    0.000000]  __acpi_probe_device_table+0x164/0x1ec
[    0.000000]  timer_probe+0x1bc/0x254
[    0.000000]  time_init+0x44/0x98
[    0.000000]  start_kernel+0x4ec/0x7d4
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0): [<0000000000000000>]           (null)
[    0.000000] hardirqs last disabled at (0): [<0000000000000000>]           (null)
[    0.000000] softirqs last  enabled at (0): [<0000000000000000>]           (null)
[    0.000000] softirqs last disabled at (0): [<0000000000000000>]           (null)
[    0.000000] ---[ end trace 1dc5085680256ac1 ]—

Here is the kernel config used,
https://c.gmx.com/@642631272677512867/tqD5eulbQAC-1h-fkVe1Iw



