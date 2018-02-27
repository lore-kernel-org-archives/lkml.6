Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-893183-1519716381-2-9252814383406513849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519716380; b=G7SUfYx1t4hcpq3CD+JKK+v3IMc35xBHQ7vNrixVCLS58Ou
    HskIoBEscHoutSG25wKjSQwslLQTNpHNxpHzvvk4p0JruZTttFfyPUuUez2T75hS
    rKGnwwEQ8BkuLQKGG+SLEPxianmwZxL0MXo8uoi/kcIu1MD7GDFhXr8L1g+He6td
    Xkz91GWyFkmFfYFkzOsKgL5Wgs/ci5ffoWtMJLHz2KNTLFYmc0gRI/86mL2j4xNH
    QyGTAhk95gLP2bfnfGsvuTvabLfwetAsi279nItn2rsguCWK8U3CPQLR6fFdSE++
    q23/whorBorSCecw2Mqnabl94a+UwElqdnq1P5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type:to:from:subject
    :cc:message-id:date:content-transfer-encoding:references:sender
    :list-id; s=arctest; t=1519716380; bh=UlY0PS0dh40btBaiwenR1tVzFe
    OcKohdwwXL5zmNcTA=; b=YsIVeEED5CKoyWt6pbl8OAAJ/qwjC6BM0zFvTvh24B
    GvPkRsqDFiyB+LdVlOJzAuyACGdmjVbN72b5XurZb3Z9TqQ0I3tnHpJriMTBEd5i
    N6v0rErEYej4W5hDMahuqiIP5IGD73iKRJFSQCwO8XxZq2FYXswnKOr+uVaai0jc
    TrAYPxkiyp9NWzFKEeoZ8Ia/4+shmCNzQt9PXywxVDSaSmA1YTfOG3LygIj1Tv19
    PTj9K2CxHSmowMbsBC4N1fDxU6NVCjUZ4IfgdwZlk8So3M22DLL4DxtJo7/E8mbR
    MRvF8zhpY7X0f58pAZ0pMBGNaWHfxOoIXYDClSF75pvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=J+gOT//x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=J+gOT//x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeB0H0K (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:26:10 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53297 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeB0H0G (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 02:26:06 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180227072603euoutp02d1ddc9825abdb07f658c0c8a1a0e9fae~XHfsR8UmK3223632236euoutp02p
X-AuditID: cbfec7f2-1c1ff70000011644-06-5a95080a5def
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"; format="flowed"
To: netdev@vger.kernel.org,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: inconsistent lock state with usbnet/asix usb ethernet and xhci
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>,
        Oliver Neukum <oneukum@suse.com>
Message-id: <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
Date: Tue, 27 Feb 2018 08:26:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djP87pcHFOjDJr/K1g836hvcXnXHDaL
        Gef3MVksWtbKbHFsgZhF1+OVbA5sHru/NjF6rN9ylcXj8ya5AOYoLpuU1JzMstQifbsEroz5
        J/YyF/SaV9xr+cDcwPhDv4uRk0NCwERi15tHbF2MXBxCAisYJZZe/cgC4XxmlHjzrYkFpmrr
        7JeMEIlljBIfnqxjAknwCghK/Jh8D6yIWcBK4tm/VlaIoueMEj2334MlRAQ2MEpc+RsKYrMJ
        GEp0ve1iA7GFBdwltmyaC1TDAdTsI7H4UCHETDuJM9fng5WwCKhK9JzfywxSIioQI/H6jxvE
        KnmJg1eeQ60Vl2huvQl2tITADDaJlb8uskMc7SLRuG8DM4QtLPHq+BaouIxEZ8dBJoiGfkaJ
        f/9fQjkzGCXWf2yFqrKWOHz8IivECj6JSdumg10hIcAr0dEmBFHiIXHs/2J2iLCjxKPObJCw
        kECsxORt31knMMrOQgqiWUhBNAvJD7OQ/LCAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+
        7iZGYGo4/e/4px2MXy8lHWIU4GBU4uGdITclSog1say4MvcQowQHs5II78rFk6OEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ88Zp1EUJCaQnlqRmp6YWpBbBZJk4OKUaGHdsSTr4KeHt8anTC9d9
        6T3wscoy+2rPuVOyf3dOWPL1ZOcOYS8RDqdzcbeWHY1tuPNme5jWotsdPycI5biUMy/fKv+3
        XD7qwDPrDSeb74h4H2FVbhZL7Oxw6pROm5UraeueztQxL9s7uvJI2uMe9liLdkuZlL7025EG
        2otC20Ibbbt6fny+qMRSnJFoqMVcVJwIAAISBBQJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsVy+t/xy7pcHFOjDO4eZbR4vlHf4vKuOWwW
        M87vY7JYtKyV2eLYAjGLrscr2RzYPHZ/bWL0WL/lKovH501yAcxRXDYpqTmZZalF+nYJXBnz
        T+xlLug1r7jX8oG5gfGHfhcjJ4eEgInE1tkvGbsYuTiEBJYwSvydOYMFJMErICjxY/I9MJtZ
        wEziy8vDrBBFzxkl5jw6wALiiAhsYJTYMvM+K0gVm4ChRNfbLjYQW1jAXWLLprlARRxA3T4S
        iw8VQgy1kzhzfT5YCYuAqkTP+b3MILaoQIzE1I8bWSGWyUscvPIcarG4RHPrTZYJjHyzkNw0
        C8lNs5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgqG479nPzDsZLG4MPMQpw
        MCrx8M6QmxIlxJpYVlyZe4hRgoNZSYR35eLJUUK8KYmVValF+fFFpTmpxYcYpTlYlMR5zxtU
        RgkJpCeWpGanphakFsFkmTg4pRoYja8K6bcu2bfYXVE/dsaG1I3is+3/3p4hx69SaKZUMKvS
        Zmnp1ge8Emazbq62Wpu8Z/nJ/UES3j90BJ4EKf46GbmFJeTLudgzsyVZ2p5Yns7smW/8rmXK
        wXWvy3c2tZXtU9bY5LhM/+aPI00ugp956o2itx5aeWaBe+Tl7hc/91R9vizS+i6vQImlOCPR
        UIu5qDgRAHIyJclRAgAA
X-CMS-MailID: 20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd
X-RootMTR: 20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi

I've noticed that USBnet/ASIX AX88772B USB driver produces deplock kernel
warning ("inconsistent lock state") on Chromebook2 Peach-PIT board. No
special activity is needed to reproduce this issue, it happens almost
on every boot. ASIX USB ethernet is connected to XHCI USB host controller
on that board. Is it a known issue? Frankly I have no idea where to look
to fix it. The same adapter connected to EHCI ports on other boards based
on the same SoC works fine without any warnings.

Here are some more information from that board:
# lsusb
Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 005 Device 002: ID 0b95:772b ASIX Electronics Corp. AX88772B
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 002: ID 2232:1056 Silicon Motion
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

# lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
     |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=asix, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
     |__ Port 1: Dev 2, If 0, Class=Video, Driver=, 480M
     |__ Port 1: Dev 2, If 1, Class=Video, Driver=, 480M


And the log with mentioned warning:

[   17.768040] ================================
[   17.772239] WARNING: inconsistent lock state
[   17.776511] 4.16.0-rc3-next-20180227-00007-g876c53a7493c #453 Not tainted
[   17.783329] --------------------------------
[   17.787580] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[   17.793607] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
[   17.798751]  (&syncp->seq#5){?.-.}, at: [<9b22e5f0>] 
asix_rx_fixup_internal+0x188/0x288
[   17.806790] {IN-HARDIRQ-W} state was registered at:
[   17.811677]   tx_complete+0x100/0x208
[   17.815319]   __usb_hcd_giveback_urb+0x60/0xf0
[   17.819770]   xhci_giveback_urb_in_irq+0xa8/0x240
[   17.824469]   xhci_td_cleanup+0xf4/0x16c
[   17.828367]   xhci_irq+0xe74/0x2240
[   17.831827]   usb_hcd_irq+0x24/0x38
[   17.835343]   __handle_irq_event_percpu+0x98/0x510
[   17.840111]   handle_irq_event_percpu+0x1c/0x58
[   17.844623]   handle_irq_event+0x38/0x5c
[   17.848519]   handle_fasteoi_irq+0xa4/0x138
[   17.852681]   generic_handle_irq+0x18/0x28
[   17.856760]   __handle_domain_irq+0x6c/0xe4
[   17.860941]   gic_handle_irq+0x54/0xa0
[   17.864666]   __irq_svc+0x70/0xb0
[   17.867964]   arch_cpu_idle+0x20/0x3c
[   17.871578]   arch_cpu_idle+0x20/0x3c
[   17.875190]   do_idle+0x144/0x218
[   17.878468]   cpu_startup_entry+0x18/0x1c
[   17.882454]   start_kernel+0x394/0x400
[   17.886177] irq event stamp: 161912
[   17.889616] hardirqs last  enabled at (161912): [<7bedfacf>] 
__netdev_alloc_skb+0xcc/0x140
[   17.897893] hardirqs last disabled at (161911): [<d58261d0>] 
__netdev_alloc_skb+0x94/0x140
[   17.904903] exynos5-hsi2c 12ca0000.i2c: tx timeout
[   17.906116] softirqs last  enabled at (161904): [<387102ff>] 
irq_enter+0x78/0x80
[   17.906123] softirqs last disabled at (161905): [<cf4c628e>] 
irq_exit+0x134/0x158
[   17.925722].
[   17.925722] other info that might help us debug this:
[   17.933435]  Possible unsafe locking scenario:
[   17.933435].
[   17.940331]        CPU0
[   17.942488]        ----
[   17.944894]   lock(&syncp->seq#5);
[   17.948274]   <Interrupt>
[   17.950847]     lock(&syncp->seq#5);
[   17.954386].
[   17.954386]  *** DEADLOCK ***
[   17.954386].
[   17.962422] no locks held by swapper/0/0.
[   17.966011].
[   17.966011] stack backtrace:
[   17.971333] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
4.16.0-rc3-next-20180227-00007-g876c53a7493c #453
[   17.980312] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   17.986380] [<c0111548>] (unwind_backtrace) from [<c010dbd8>] 
(show_stack+0x10/0x14)
[   17.994128] [<c010dbd8>] (show_stack) from [<c09bd418>] 
(dump_stack+0x90/0xc8)
[   18.001339] [<c09bd418>] (dump_stack) from [<c017fdf8>] 
(print_usage_bug+0x25c/0x2cc)
[   18.009161] [<c017fdf8>] (print_usage_bug) from [<c017c14c>] 
(mark_lock+0x290/0x698)
[   18.014952] exynos5-hsi2c 12ca0000.i2c: tx timeout
[   18.016899] [<c017c14c>] (mark_lock) from [<c017c9a8>] 
(__lock_acquire+0x454/0x1850)
[   18.029449] [<c017c9a8>] (__lock_acquire) from [<c017e6e0>] 
(lock_acquire+0xc8/0x2b8)
[   18.037272] [<c017e6e0>] (lock_acquire) from [<c05be98c>] 
(usbnet_skb_return+0x7c/0x1a0)
[   18.045356] [<c05be98c>] (usbnet_skb_return) from [<c05b185c>] 
(asix_rx_fixup_internal+0x188/0x288)
[   18.054420] [<c05b185c>] (asix_rx_fixup_internal) from [<c05bfe40>] 
(usbnet_bh+0xf8/0x2e4)
[   18.062694] [<c05bfe40>] (usbnet_bh) from [<c012d6b4>] 
(tasklet_action+0x8c/0x13c)
[   18.070259] [<c012d6b4>] (tasklet_action) from [<c0102214>] 
(__do_softirq+0xd4/0x6d4)
[   18.078089] [<c0102214>] (__do_softirq) from [<c012cf34>] 
(irq_exit+0x134/0x158)
[   18.085480] [<c012cf34>] (irq_exit) from [<c018c444>] 
(__handle_domain_irq+0x70/0xe4)
[   18.093314] [<c018c444>] (__handle_domain_irq) from [<c046400c>] 
(gic_handle_irq+0x54/0xa0)
[   18.101670] [<c046400c>] (gic_handle_irq) from [<c01019f0>] 
(__irq_svc+0x70/0xb0)
[   18.109163] Exception stack(0xc0f01eb8 to 0xc0f01f00)
[   18.114202] 1ea0: 00000001 00000001
[   18.122397] 1ec0: 00000000 c0f0ba80 eef3a540 eef3a540 ee8d2700 
c0f088b4 00000402 c09d23e0
[   18.124980] exynos5-hsi2c 12ca0000.i2c: tx timeout
[   18.130611] 1ee0: c0f0ba80 c0f01f4c 00000000 c0f01f08 c017ea54 
c09d92d4 20000013 ffffffff
[   18.135504] cpu cpu0: _set_opp_voltage: failed to set voltage 
(1250000 1250000 1250000 mV): -110
[   18.143690] [<c01019f0>] (__irq_svc) from [<c09d92d4>] 
(_raw_spin_unlock_irq+0x28/0x5c)
[   18.152671] cpufreq: __target_index: Failed to change cpu frequency: -110
[   18.160683] [<c09d92d4>] (_raw_spin_unlock_irq) from [<c0152684>] 
(finish_task_switch+0xb4/0x254)
[   18.160696] [<c0152684>] (finish_task_switch) from [<c09d23e0>] 
(__schedule+0x290/0xb10)
[   18.160704] [<c09d23e0>] (__schedule) from [<c09d3134>] 
(schedule_idle+0x2c/0x78)
[   18.160711] [<c09d3134>] (schedule_idle) from [<c01703a0>] 
(cpu_startup_entry+0x18/0x1c)
[   18.200726] [<c01703a0>] (cpu_startup_entry) from [<c0e00c74>] 
(start_kernel+0x394/0x400)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
