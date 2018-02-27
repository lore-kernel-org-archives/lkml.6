Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1753727-1519744192-2-3582787210871944132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519744191; b=JyhdX9kzohSoJxi2rurXT7U886nSS4OX4Aq2Pi7NKAKrnZj
    zOMUBXq42Tyr1oHaeeNeMCvlwFz8lBejUHjUmFyrEnI3JvYCCx87PAVQdYnzD/LP
    KMy3tsBb92Qp7D2/3Z1YWSML9ZL3FAecIY3e1Gmy5NREo3nXjU8eqjFm8b++k9Uw
    qQnWZ14U2WMcF0VTTJS88UpeE6FA0C/tVAXegZQuYALZlEqZjoBtMCcXY598wq1T
    egxWSJ5vyXNXx4r7qIli2R7Q+z0/vB+AMjagmw7T4HvkrJFHL/VDy9vUo76wgLAv
    5i2LFTMqTNjcpReo9v/moKRGi3k801PQaTHzGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519744191; bh=DF/Ya9O215ufs1UF50TN244rjt0/n2JRDyAXd2YuxcE=; b=m
    ZiVK2FTkCj2+lDwWADVw6Ybnbx3BJWzrWhTWDrvJkV6QlFpxpP1mnOaowXe4XJUy
    9gMvPHqpSRRipkb/a/XbM7bD2WHRmVW/LX+b+fvGw6zk3jWHukvpa5LrCPGzMGL4
    wEv26aHqi+wtg9ARznPNZAsSeXVIVMkQtbT6tAzI3CVKgFtLkkUHZ9q0pSqM39nt
    oELxx5kRzAVT7cYJ0w0vlX4h+qdzTY581F4ANthYUm3/GRy+Ek6Bs0deh09sm20x
    svRBjerDjYVWe67Wf3YCyF8IcjRzRKaifBXlNuehqgox/BaarTXZrRNzjPf9Q+8L
    3kRVITzrZ6hpJIHYsS6ag==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fi/K+P5K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n9g5/qtA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fi/K+P5K x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n9g5/qtA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeB0PJc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 10:09:32 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:41303 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeB0PJa (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 10:09:30 -0500
X-Google-Smtp-Source: AH8x225DyLS/Wc9JsxlwQjv7MCXimsxTnuyqkGAUxeJ2Doz5CCNEXoAVUUTOiUXHX4OcO++KPXa/pw==
Message-ID: <1519744167.7296.8.camel@gmail.com>
Subject: Re: inconsistent lock state with usbnet/asix usb ethernet and xhci
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        netdev@vger.kernel.org,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>,
        Oliver Neukum <oneukum@suse.com>
Date: Tue, 27 Feb 2018 07:09:27 -0800
In-Reply-To: <bac44c1b-d701-2f6b-5e1e-738befc25c9d@samsung.com>
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
         <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
         <1519740421.7296.6.camel@gmail.com>
         <bac44c1b-d701-2f6b-5e1e-738befc25c9d@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-27 at 15:42 +0100, Marek Szyprowski wrote:
> Hi Eric,
> 
> On 2018-02-27 15:07, Eric Dumazet wrote:
> > On Tue, 2018-02-27 at 08:26 +0100, Marek Szyprowski wrote:
> > > I've noticed that USBnet/ASIX AX88772B USB driver produces deplock kernel
> > > warning ("inconsistent lock state") on Chromebook2 Peach-PIT board. No
> > > special activity is needed to reproduce this issue, it happens almost
> > > on every boot. ASIX USB ethernet is connected to XHCI USB host controller
> > > on that board. Is it a known issue? Frankly I have no idea where to look
> > > to fix it. The same adapter connected to EHCI ports on other boards based
> > > on the same SoC works fine without any warnings.
> > > 
> > > Here are some more information from that board:
> > > # lsusb
> > > Bus 006 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > > Bus 005 Device 002: ID 0b95:772b ASIX Electronics Corp. AX88772B
> > > Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> > > Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > > Bus 001 Device 002: ID 2232:1056 Silicon Motion
> > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > 
> > > # lsusb -t
> > > /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> > > /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> > >       |__ Port 1: Dev 2, If 0, Class=Vendor Specific Class, Driver=asix, 480M
> > > /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> > > /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
> > > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=exynos-ohci/3p, 12M
> > > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=exynos-ehci/3p, 480M
> > >       |__ Port 1: Dev 2, If 0, Class=Video, Driver=, 480M
> > >       |__ Port 1: Dev 2, If 1, Class=Video, Driver=, 480M
> > > 
> > > 
> > > And the log with mentioned warning:
> > > 
> > > [   17.768040] ================================
> > > [   17.772239] WARNING: inconsistent lock state
> > > [   17.776511] 4.16.0-rc3-next-20180227-00007-g876c53a7493c #453 Not tainted
> > > [   17.783329] --------------------------------
> > > [   17.787580] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > > [   17.793607] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> > > [   17.798751]  (&syncp->seq#5){?.-.}, at: [<9b22e5f0>]
> > > asix_rx_fixup_internal+0x188/0x288
> > > [   17.806790] {IN-HARDIRQ-W} state was registered at:
> > > [   17.811677]   tx_complete+0x100/0x208
> > > [   17.815319]   __usb_hcd_giveback_urb+0x60/0xf0
> > > [   17.819770]   xhci_giveback_urb_in_irq+0xa8/0x240
> > > [   17.824469]   xhci_td_cleanup+0xf4/0x16c
> > > [   17.828367]   xhci_irq+0xe74/0x2240
> > > [   17.831827]   usb_hcd_irq+0x24/0x38
> > > [   17.835343]   __handle_irq_event_percpu+0x98/0x510
> > > [   17.840111]   handle_irq_event_percpu+0x1c/0x58
> > > [   17.844623]   handle_irq_event+0x38/0x5c
> > > [   17.848519]   handle_fasteoi_irq+0xa4/0x138
> > > [   17.852681]   generic_handle_irq+0x18/0x28
> > > [   17.856760]   __handle_domain_irq+0x6c/0xe4
> > > [   17.860941]   gic_handle_irq+0x54/0xa0
> > > [   17.864666]   __irq_svc+0x70/0xb0
> > > [   17.867964]   arch_cpu_idle+0x20/0x3c
> > > [   17.871578]   arch_cpu_idle+0x20/0x3c
> > > [   17.875190]   do_idle+0x144/0x218
> > > [   17.878468]   cpu_startup_entry+0x18/0x1c
> > > [   17.882454]   start_kernel+0x394/0x400
> > > [   17.886177] irq event stamp: 161912
> > > [   17.889616] hardirqs last  enabled at (161912): [<7bedfacf>]
> > > __netdev_alloc_skb+0xcc/0x140
> > > [   17.897893] hardirqs last disabled at (161911): [<d58261d0>]
> > > __netdev_alloc_skb+0x94/0x140
> > > [   17.904903] exynos5-hsi2c 12ca0000.i2c: tx timeout
> > > [   17.906116] softirqs last  enabled at (161904): [<387102ff>]
> > > irq_enter+0x78/0x80
> > > [   17.906123] softirqs last disabled at (161905): [<cf4c628e>]
> > > irq_exit+0x134/0x158
> > > [   17.925722].
> > > [   17.925722] other info that might help us debug this:
> > > [   17.933435]  Possible unsafe locking scenario:
> > > [   17.933435].
> > > [   17.940331]        CPU0
> > > [   17.942488]        ----
> > > [   17.944894]   lock(&syncp->seq#5);
> > > [   17.948274]   <Interrupt>
> > > [   17.950847]     lock(&syncp->seq#5);
> > > [   17.954386].
> > > [   17.954386]  *** DEADLOCK ***
> > > [   17.954386].
> > > [   17.962422] no locks held by swapper/0/0.
> > > [   17.966011].
> > > [   17.966011] stack backtrace:
> > > [   17.971333] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> > > 4.16.0-rc3-next-20180227-00007-g876c53a7493c #453
> > > [   17.980312] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> > > [   17.986380] [<c0111548>] (unwind_backtrace) from [<c010dbd8>]
> > > (show_stack+0x10/0x14)
> > > [   17.994128] [<c010dbd8>] (show_stack) from [<c09bd418>]
> > > (dump_stack+0x90/0xc8)
> > > [   18.001339] [<c09bd418>] (dump_stack) from [<c017fdf8>]
> > > (print_usage_bug+0x25c/0x2cc)
> > > [   18.009161] [<c017fdf8>] (print_usage_bug) from [<c017c14c>]
> > > (mark_lock+0x290/0x698)
> > > [   18.014952] exynos5-hsi2c 12ca0000.i2c: tx timeout
> > > [   18.016899] [<c017c14c>] (mark_lock) from [<c017c9a8>]
> > > (__lock_acquire+0x454/0x1850)
> > > [   18.029449] [<c017c9a8>] (__lock_acquire) from [<c017e6e0>]
> > > (lock_acquire+0xc8/0x2b8)
> > > [   18.037272] [<c017e6e0>] (lock_acquire) from [<c05be98c>]
> > > (usbnet_skb_return+0x7c/0x1a0)
> > > [   18.045356] [<c05be98c>] (usbnet_skb_return) from [<c05b185c>]
> > > (asix_rx_fixup_internal+0x188/0x288)
> > > [   18.054420] [<c05b185c>] (asix_rx_fixup_internal) from [<c05bfe40>]
> > > (usbnet_bh+0xf8/0x2e4)
> > > [   18.062694] [<c05bfe40>] (usbnet_bh) from [<c012d6b4>]
> > > (tasklet_action+0x8c/0x13c)
> > > [   18.070259] [<c012d6b4>] (tasklet_action) from [<c0102214>]
> > > (__do_softirq+0xd4/0x6d4)
> > > [   18.078089] [<c0102214>] (__do_softirq) from [<c012cf34>]
> > > (irq_exit+0x134/0x158)
> > > [   18.085480] [<c012cf34>] (irq_exit) from [<c018c444>]
> > > (__handle_domain_irq+0x70/0xe4)
> > > [   18.093314] [<c018c444>] (__handle_domain_irq) from [<c046400c>]
> > > (gic_handle_irq+0x54/0xa0)
> > > [   18.101670] [<c046400c>] (gic_handle_irq) from [<c01019f0>]
> > > (__irq_svc+0x70/0xb0)
> > > [   18.109163] Exception stack(0xc0f01eb8 to 0xc0f01f00)
> > > [   18.114202] 1ea0: 00000001 00000001
> > > [   18.122397] 1ec0: 00000000 c0f0ba80 eef3a540 eef3a540 ee8d2700
> > > c0f088b4 00000402 c09d23e0
> > > [   18.124980] exynos5-hsi2c 12ca0000.i2c: tx timeout
> > > [   18.130611] 1ee0: c0f0ba80 c0f01f4c 00000000 c0f01f08 c017ea54
> > > c09d92d4 20000013 ffffffff
> > > [   18.135504] cpu cpu0: _set_opp_voltage: failed to set voltage
> > > (1250000 1250000 1250000 mV): -110
> > > [   18.143690] [<c01019f0>] (__irq_svc) from [<c09d92d4>]
> > > (_raw_spin_unlock_irq+0x28/0x5c)
> > > [   18.152671] cpufreq: __target_index: Failed to change cpu frequency: -110
> > > [   18.160683] [<c09d92d4>] (_raw_spin_unlock_irq) from [<c0152684>]
> > > (finish_task_switch+0xb4/0x254)
> > > [   18.160696] [<c0152684>] (finish_task_switch) from [<c09d23e0>]
> > > (__schedule+0x290/0xb10)
> > > [   18.160704] [<c09d23e0>] (__schedule) from [<c09d3134>]
> > > (schedule_idle+0x2c/0x78)
> > > [   18.160711] [<c09d3134>] (schedule_idle) from [<c01703a0>]
> > > (cpu_startup_entry+0x18/0x1c)
> > > [   18.200726] [<c01703a0>] (cpu_startup_entry) from [<c0e00c74>]
> > > (start_kernel+0x394/0x400)
> > > 
> > > Best regards
> > 
> > Please try the attached patch, thanks.
> 
> Thanks for the patch. It fixes the deplock warning. However IMHO the same
> fix should be also applied to complete_tx function for modifying stats64
> there:
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 7f5bda0ec9e8..d9eea8cfe6cb 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1249,11 +1249,12 @@ static void tx_complete (struct urb *urb)
> 
>          if (urb->status == 0) {
>                  struct pcpu_sw_netstats *stats64 = 
> this_cpu_ptr(dev->stats64);
> +               unsigned long flags;
> 
> -               u64_stats_update_begin(&stats64->syncp);
> +               flags = u64_stats_update_begin_irqsave(&stats64->syncp);
>                  stats64->tx_packets += entry->packets;
>                  stats64->tx_bytes += entry->length;
> -               u64_stats_update_end(&stats64->syncp);
> + u64_stats_update_end_irqrestore(&stats64->syncp, flags);
>          } else {
>                  dev->net->stats.tx_errors++;
> 
> 
> I've did that and it also works fine without deplock warning.

Note that for this one, it seems we also could perform stats updates in
BH context, since skb is queued via defer_bh()

But simplicity wins I guess.

I'll send a formal patch including your change in tx_complete(),
thanks !

