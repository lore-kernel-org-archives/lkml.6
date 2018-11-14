Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B253C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1669F21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1669F21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeKNMcO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:32:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:52335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbeKNMcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:32:13 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LcShi-1ffDBw3L5q-00jtQW; Wed, 14
 Nov 2018 03:31:03 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: kmemleak: Early log buffer exceeded (525980) during boot
From:   Qian Cai <cai@gmx.us>
In-Reply-To: <trinity-cbe4d3e0-f780-48ea-af28-ed2813eafaf6-1541871732167@msvc-mesg-gmx021>
Date:   Tue, 13 Nov 2018 21:31:00 -0500
Cc:     linux kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DD82AD13-EFD2-4C22-8348-8023E0BDD960@gmx.us>
References: <1541712198.12945.12.camel@gmx.us>
 <D7C9EA14-C812-406F-9570-CFF36F4C3983@gmx.us>
 <20181110165938.lbt6dfamk2ljafcv@localhost>
 <trinity-cbe4d3e0-f780-48ea-af28-ed2813eafaf6-1541871732167@msvc-mesg-gmx021>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:XwpWRuzoYd0GTvGDk3mU9AlObzbF03nf7LpKjGqn9DxgDPUfe8g
 VnpSajqK+TR6xbmQOrm7RfzP6DwFA30aKxWH95Oq6qDoN8PVNxckeykqdUbE8tU5kKMRr5o
 +b9j5fvgiSxhoTK0xyr3ZAysw+n8xHa0gst2wwd1VAHLd9AeP7J+f5tj3B/jZ68mKsYr97k
 ZR992IgiI/gG/jBbEQEoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yzNktzv9lew=:qzDjdQzxC4yXZCQaciWug+
 Enva5Skonq51qiEppJpMCSINzHaydZALKKMLKO2hepIuhEXmuoDA1LoHR98MWL2wUunp6UZVV
 IQYdQbqePj5nm8xWyCM5gTdaFmQz1crwMtkKdmqkYWR+ZXH52gFEsImDq7lB+863TCSr5bGUX
 OI0ZfoVmETN+UW1boJyOAHMtqiXqZy29KhCqaXaK1eixNVYFDpQcRZuUk5MRt1quwFGet4sJh
 WVYGxdJdv6vZbzyHjdCKUe3VCDXnwhwdbBt4q+rH9IihPQ4gMOhis3J3Mc9GUDjp4o3U7PNNV
 X+L0TnHDLkhzRBP3Ipeq4kpOAuesUJ7bvBOJ581D1c9FPCTOq7SpnxiFG4JgdOdRH89xLqqN0
 ABW/o2Iib6cmjK7ckYbcO7PwSZ9kSyQws2cMEfKUmKwBb9GqveMFo5VLuHZ5Btfi0Ciqisxty
 xVF5soF+DvY+mp4WQ65y0Ml9MK5ENwOksHNR4Shpw8Ab6szVDbkzNz3xOQV7K1fjqEqSDKZc3
 2RFsQhCPB5RVJHqXUrqWpxwM2jeU+aP5UNbIaMhrcRNwJjOUV6dEedZNtekdE3ylu6cvSLB2r
 QOgioI2vW2RTOpVtxem/RRK0ptcbzp81TVaHwgphbI8B0kp5jYRr64Mo7qVIk0haNZ3Rp9RRW
 w0vl4h5WOrPvS1hYRqADP1m40nBF7ugsrmbcvtW9bp3DA9i9DFbUSuzDV8X2JIjCbZr0iSr6z
 PZgJmDRy/AF8bFyfX5DvssbusrQOEWO0Ns5i44NMunXHRlOWFi7ys4aVIvMnD9+fpvv/RO7Y2
 eZX61Ade6HeCffUFpGQ47xX9rEmBHVPy/9zgqrrTg0Fu9GnC/FeMfth2ZfjVURw0gYwk5oj0k
 IQbpvWYYBXfCsphx468Jopd5bguIlZ2OahdYfXll7LyxgVdPCVwmWaUJ7ByDIL+O8GQmUKtw7
 jAtCPbb1/mq7v035jUV5MeaSqUlyjVkUy+fjmrcv4o6n1W8JxfSe+MFobsjeDxB2TZJK8JYNJ
 Qg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 10, 2018, at 12:42 PM, Qian Cai <cai@gmx.us> wrote:
> 
> 
> On 11/10/18 at 11:59 AM, Catalin Marinas wrote:
> 
>> On Sat, Nov 10, 2018 at 10:08:10AM -0500, Qian Cai wrote:
>>> On Nov 8, 2018, at 4:23 PM, Qian Cai <cai@gmx.us> wrote:
>>>> The maximum value for DEBUG_KMEMLEAK_EARLY_LOG_SIZE is only 40000, so it
>>>> disables kmemleak every time on this aarch64 server running the latest mainline
>>>> (b00d209).
>>>> 
>>>> # echo scan > /sys/kernel/debug/kmemleak 
>>>> -bash: echo: write error: Device or resource busy
>>>> 
>>>> Any idea on how to enable kmemleak there?
>>> 
>>> I have managed to hard-code DEBUG_KMEMLEAK_EARLY_LOG_SIZE to 600000,
>> 
>> That's quite a high number, I wouldn't have thought it is needed.
>> Basically the early log buffer is only used until the slub allocator
>> gets initialised and kmemleak_init() is called from start_kernel(). I
>> don't know what allocates that much memory so early.
>> 
>> What else is in your .config?
> https://c.gmx.com/@642631272677512867/tqD5eulbQAC-1h-fkVe1Iw
> 
> Does the dmesg helps? 
> https://paste.ubuntu.com/p/BnhvXXhn7k/
>> 
>>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>>> index 877de4fa0720..c10119102c10 100644
>>> --- a/mm/kmemleak.c
>>> +++ b/mm/kmemleak.c
>>> @@ -280,7 +280,7 @@ struct early_log {
>>> 
>>> /* early logging buffer and current position */
>>> static struct early_log
>>> -       early_log[CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE] __initdata;
>>> +       early_log[600000] __initdata;
>> 
>> You don't need to patch the kernel, the config variable is there to be
>> changed.
> Right, but the maximum is only 40000 in kconfig, so anything bigger than that will be rejected.

I got soft lockups all over the place by compiling kernel on another aarch64 server with 256-CPU
with DEBUG_KMEMLEAK_EARLY_LOG_SIZE=200000

[  802.897516] watchdog: BUG: soft lockup - CPU#151 stuck for 22s! [kworker/151:1:1410]
[  802.905311] Modules linked in: vfat fat ghash_ce i2c_smbus sha2_ce sha256_arm64 sha1_ce sg ipmi_ssif ipmi_devintf ipmi_msghandler sch_fq_codel xfs libcrc32c sr_mod cdrom ast mlx5_core i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm uas usb_storage mlxfw devlink i2c_xlp9xx gpio_xlp dm_mirror dm_region_hash dm_log dm_mod
[  802.936640] irq event stamp: 2717000
[  802.940277] hardirqs last  enabled at (2716999): [<ffff200008fabd48>] _raw_write_unlock_irqrestore+0x80/0x88
[  802.950166] hardirqs last disabled at (2717000): [<ffff2000080839b4>] el1_irq+0x74/0x140
[  802.958405] softirqs last  enabled at (84510): [<ffff200008082210>] __do_softirq+0x7c8/0x9c8
[  802.966914] softirqs last disabled at (84433): [<ffff20000812dbe4>] irq_exit+0x25c/0x2f0
[  802.975035] CPU: 151 PID: 1410 Comm: kworker/151:1 Kdump: loaded Tainted: G        W    L    4.20.0-rc2+ #4
[  802.984800] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.0.6 07/10/2018
[  802.994692] Workqueue: events free_obj_work
[  802.998918] pstate: 20400009 (nzCv daif +PAN -UAO)
[  803.003755] pc : _raw_write_unlock_irqrestore+0x84/0x88
[  803.009008] lr : _raw_write_unlock_irqrestore+0x80/0x88
[  803.014251] sp : ffff8095884a6760
[  803.017582] x29: ffff8095884a6760 x28: 0000000000000000 
[  803.022916] x27: 0000000000000000 x26: ffff20000c318d80 
[  803.028246] x25: ffff809254772738 x24: ffff20000dbf3be0 
[  803.033581] x23: ffff80925477dc28 x22: dfff200000000000 
[  803.038942] x21: ffff20000851ea9c x20: ffff20000c318d80 
[  803.044352] x19: 0000000000000000 x18: 0000000000000000 
[  803.049700] x17: 0000000000000000 x16: 0000000000000000 
[  803.055064] x15: 0000000000000000 x14: 0000000000000000 
[  803.060408] x13: 0000000000000000 x12: 000000000000005c 
[  803.065733] x11: 00000000f2f2f2f2 x10: dfff200000000000 
[  803.071061] x9 : ffff20000c139848 x8 : ffff8095cd9247d8 
[  803.076389] x7 : 0000000041b58ab3 x6 : dfff200000000000 
[  803.081723] x5 : ffff20000954e8b8 x4 : dfff200000000000 
[  803.087064] x3 : 0000000000000001 x2 : 0000000000000007 
[  803.092409] x1 : 086e7d9f6bfbf800 x0 : 0000000000000000 
[  803.097752] Call trace:
[  803.100249]  _raw_write_unlock_irqrestore+0x84/0x88
[  803.105170]  create_object+0x4dc/0x600
[  803.108957]  kmemleak_alloc+0xc8/0xd8
[  803.112646]  kmem_cache_alloc+0x3b0/0x3f8
[  803.116679]  __debug_object_init+0x8cc/0x918
[  803.120978]  debug_object_activate+0x218/0x370
[  803.125439]  __call_rcu+0xdc/0xad0
[  803.128856]  call_rcu+0x30/0x40
[  803.132019]  put_object+0x50/0x68
[  803.135348]  __delete_object+0xfc/0x140
[  803.139200]  delete_object_full+0x2c/0x38
[  803.143235]  kmemleak_free+0xa4/0xb0
[  803.146825]  kmem_cache_free+0x2e4/0x3a8
[  803.150762]  free_obj_work+0x300/0x468
[  803.154529]  process_one_work+0x60c/0xd90
[  803.158575]  worker_thread+0x13c/0xa70
[  803.162365]  kthread+0x1c4/0x1d0
[  803.165618]  ret_from_fork+0x10/0x1c
