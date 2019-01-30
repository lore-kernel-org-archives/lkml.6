Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ADEC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1AA2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="PiN6Q6lJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfA3P5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:57:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfA3P5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:57:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so54422wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLa2fVLfmfhJyJea1uW61+9smEUDTGh10k2RFNIQXd8=;
        b=PiN6Q6lJRTTF35c3qI86ph8FZP2sKcznfQSIXJ3oGtS/pRqUCS8Ny9M3KFXyvJFZlu
         oiBiC5pecC63rcruEnEPZoULaRFwDtT7AOK/o2OMoCpyb1Mpk7TIS0OvB08QGYZdOgPw
         Z1VXvg7MHgCtbg7GPBxTJ4Mucc6Ep9mbr5l7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLa2fVLfmfhJyJea1uW61+9smEUDTGh10k2RFNIQXd8=;
        b=NgwhJqYKpeRUqzvNEDIymdJMIpbkx/KpSzRsiVoDA7XN0YEm6tjmBePR5M3Y/J0nJm
         yIjOUzDp9d9e3JgXm8uj2QvKoaughfvlVXR2VWAtEPghH1p9sxVZc5BYqkzb3nLGpIzP
         0AevQsqf4A3tKaOM0uOFpzximbi6Ox5FuJNCTP9zFos6cYm2y2P7dCY2lghDcpzSPRbp
         UpZmyXkagVoI9tQui+0RwHy53P3UtMtSBpFowRtft3FyGUAQY4iYMn0ty3IOAc0uCTUX
         0OuaVVp+u7sQnNz+VRPyP5x/O4SnVBzZnHaBEYaQM1rX8FALaFgo6uKeq8W1l3bvKwhi
         +GXw==
X-Gm-Message-State: AHQUAuZdNasDJ0w9iVu3RfzrQywdwArXDB4jPYngtwuy92YphzH6/53G
        7Bkypo2g4XcuBtA1oOph0Mrj2g5PTKMpQZHTstHZYQ==
X-Google-Smtp-Source: AHgI3IaVNN9KD3RuEmmk1waFVu3j6EltMCowKND/MZfNlkvxf/4W5R/KsLfcTBgVwAKKP0h2hACRR7mq8NMyZJ0Za6k=
X-Received: by 2002:a1c:44c5:: with SMTP id r188mr6518776wma.151.1548863828800;
 Wed, 30 Jan 2019 07:57:08 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi3oWnOWL8sDfjWX7YC6M5ASuhCZNz8tsCGgjvO5yJJRLg@mail.gmail.com>
 <20190129102859.GD12232@kroah.com>
In-Reply-To: <20190129102859.GD12232@kroah.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Wed, 30 Jan 2019 15:56:57 +0000
Message-ID: <CALrw=nGenx1k5dfCTLDV1a_N4pWDbBv8Wvy8huqfPSryB+atqg@mail.gmail.com>
Subject: Re: ipmi_msghandler crashes in 4.19
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're rolling out 4.19.18 across the fleet. Hopefully, we'll not see
it anymore, but if we do, we'll let you know.

Regards,
Ignat

On Tue, Jan 29, 2019 at 10:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 15, 2019 at 10:36:42AM -0800, Ivan Babrou wrote:
> > Hey,
> >
> > We've upgraded some machines from 4.14 to 4.19 and started seeing rare
> > crashes like these:
> >
> > [75855.909507] BUG: unable to handle kernel NULL pointer dereference
> > at 0000000000000d00
> > [75855.925667] PGD 0 P4D 0
> > [75855.936359] Oops: 0000 [#1] SMP PTI
> > [75855.947951] CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G           O
> >      4.19.13-cloudflare-2019.1.4 #2019.1.4
> > [75855.966028] Hardware name: Quanta Cloud Technology Inc. QuantaPlex
> > T42S-2U(LBG-4) -/T42S-2U MB (Lewisburg-4), BIOS 3A11.Q10 06/29/2018
> > [75855.994246] RIP: 0010:__srcu_read_unlock+0xe/0x20
> > [75856.006851] Code: 01 48 63 c8 65 48 ff 04 ca f0 83 44 24 fc 00 c3
> > 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 83 44 24 fc 00
> > 48 63 f6 <48> 8b 87 e8 0c 00 00 65 48 ff 44 f0 10 c3 0f 1f 40 00 0f 1f
> > 44 00
> > [75856.041551] RSP: 0018:ffffba00cc66fd48 EFLAGS: 00010286
> > [75856.054564] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [75856.069449] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000018
> > [75856.084168] RBP: ffffa28276abb200 R08: ffffa29119772540 R09: 0000000000000000
> > [75856.098756] R10: 00000000000c1425 R11: ffffa29120a201c8 R12: ffffa29118d57e08
> > [75856.113422] R13: dead000000000200 R14: dead000000000100 R15: ffffa27dcbafa400
> > [75856.127798] FS:  0000000000000000(0000) GS:ffffa29120a00000(0000)
> > knlGS:0000000000000000
> > [75856.138973] perf: interrupt took too long (7735 > 7677), lowering
> > kernel.perf_event_max_sample_rate to 25000
> > [75856.143083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [75856.172956] CR2: 0000000000000d00 CR3: 000000187ca0a005 CR4: 00000000007606f0
> > [75856.187116] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [75856.201312] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [75856.215274] PKRU: 55555554
> > [75856.224621] Call Trace:
> > [75856.230942] perf: interrupt took too long (9748 > 9668), lowering
> > kernel.perf_event_max_sample_rate to 20000
> > [75856.233560]  deliver_response+0x88/0xd0 [ipmi_msghandler]
> > [75856.261744]  deliver_local_response+0xe/0x30 [ipmi_msghandler]
> > [75856.273937]  handle_one_recv_msg+0x164/0xbf0 [ipmi_msghandler]
> > [75856.285962]  ? __switch_to_asm+0x34/0x70
> > [75856.295957]  ? __switch_to_asm+0x40/0x70
> > [75856.306011]  ? __switch_to_asm+0x34/0x70
> > [75856.315872]  ? __switch_to_asm+0x40/0x70
> > [75856.325562]  ? __switch_to_asm+0x34/0x70
> > [75856.325565]  ? __switch_to_asm+0x40/0x70
> > [75856.325567]  ? __switch_to_asm+0x34/0x70
> > [75856.325569]  ? __switch_to_asm+0x40/0x70
> > [75856.325578]  handle_new_recv_msgs+0x16d/0x1e0 [ipmi_msghandler]
> > [75856.325583]  ? __switch_to_asm+0x34/0x70
> > [75856.381815]  tasklet_action_common.isra.21+0x4e/0xf0
> > [75856.381823]  __do_softirq+0xd8/0x2d2
> > [75856.399498]  ? sort_range+0x20/0x20
> > [75856.399506]  run_ksoftirqd+0x1a/0x20
> > [75856.415184]  smpboot_thread_fn+0xc5/0x160
> > [75856.415190]  kthread+0x113/0x130
> > [75856.430502]  ? kthread_create_worker_on_cpu+0x70/0x70
> > [75856.430512]  ret_from_fork+0x35/0x40
> > [75856.446793] Modules linked in: xt_connlimit nf_conncount xt_bpf
> > xt_hashlimit cls_flow cls_u32 sch_htb sch_fq md_mod dm_crypt
> > algif_skcipher af_alg dm_mod dax ip6table_nat nf_nat_ipv6
> > ip6table_mangle ip6table_security ip6table_raw ip6table_filter
> > ip6_tables xt_nat iptable_nat nf_nat_ipv4 nf_nat xt_TPROXY
> > nf_tproxy_ipv6 nf_tproxy_ipv4 xt_connmark iptable_mangle xt_owner
> > xt_CT xt_socket nf_socket_ipv4 nf_socket_ipv6 iptable_raw
> > nfnetlink_log xt_NFLOG xt_tcpudp xt_comment xt_conntrack nf_conntrack
> > nf_defrag_ipv6 nf_defrag_ipv4 xt_mark xt_multiport xt_set
> > iptable_filter bpfilter ip_set_hash_netport ip_set_hash_net
> > ip_set_hash_ip ip_set nfnetlink 8021q garp mrp stp llc skx_edac
> > x86_pkg_temp_thermal kvm_intel kvm irqbypass crc32_pclmul crc32c_intel
> > ipmi_ssif pcbc aesni_intel aes_x86_64 crypto_simd sfc(O)
> > [75856.446862]  cryptd glue_helper mdio ipmi_si xhci_pci i40e tpm_crb
> > ioatdma ipmi_devintf xhci_hcd dca ipmi_msghandler tpm_tis tpm_tis_core
> > tpm efivarfs ip_tables x_tables
> > [75856.569103] CR2: 0000000000000d00
> > [75856.569124] ---[ end trace 604e13a0789ee766 ]---
> >
> > [117620.868720] general protection fault: 0000 [#1] SMP PTI
> > [117620.911871] CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G
> > O      4.19.0-cloudflare-2018.10.3 #1
> > [117620.937885] Hardware name: Quanta Computer Inc QuantaPlex
> > T41S-2U/S2S-MB, BIOS S2S_3B10.03 06/21/2018
> > [117620.963750] RIP: 0010:__srcu_read_unlock+0xe/0x20
> > [117620.984950] Code: 01 48 63 c8 65 48 ff 04 ca f0 83 44 24 fc 00 c3
> > 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f0 83 44 24 fc 00
> > 48 63 f6 <48> 8b 87 e8 0c 00 00 65 48 ff 44 f0 10 c3 0f 1f 40
> >  00 0f 1f 44 00
> > [117621.020240] perf: interrupt took too long (10250 > 10230),
> > lowering kernel.perf_event_max_sample_rate to 19000
> > [117621.036578] RSP: 0018:ffff89007f603e38 EFLAGS: 00010286
> > [117621.073528] perf: interrupt took too long (12979 > 12812),
> > lowering kernel.perf_event_max_sample_rate to 15000
> > [117621.084232] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > 0000000000000000
> > [117621.133897] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
> > 403a080083ad0878
> > [117621.156877] RBP: ffff890d90a78e00 R08: 0000000000000002 R09:
> > 0000000000020900
> > [117621.179507] R10: 0000eb0270fbf3f0 R11: ffff89007f603ca4 R12:
> > ffff89107b411e08
> > [117621.179509] R13: dead000000000200 R14: dead000000000100 R15:
> > ffff890a9b3e6800
> > [117621.179511] FS:  0000000000000000(0000) GS:ffff89007f600000(0000)
> > knlGS:0000000000000000
> > [117621.179513] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [117621.179514] CR2: 00007f193f3095e0 CR3: 0000001f79e0a001 CR4:
> > 00000000003606f0
> > [117621.179526] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [117621.179527] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [117621.179529] Call Trace:
> > [117621.179532]  <IRQ>
> > [117621.179552]  deliver_response+0x88/0xd0 [ipmi_msghandler]
> > [117621.179557]  deliver_local_response+0xe/0x30 [ipmi_msghandler]
> > [117621.179561]  handle_one_recv_msg+0x164/0xbf0 [ipmi_msghandler]
> > [117621.179568]  ? try_to_wake_up+0x54/0x470
> > [117621.179575]  ? ipmi_si_platform_shutdown+0x20/0x20 [ipmi_si]
> > [117621.236448] perf: interrupt took too long (16285 > 16223),
> > lowering kernel.perf_event_max_sample_rate to 12000
> > [117621.247534]  ? kcs_event+0x17d/0x730 [ipmi_si]
> > [117621.426069] perf: interrupt took too long (20619 > 20356),
> > lowering kernel.perf_event_max_sample_rate to 9000
> > [117621.437773]  handle_new_recv_msgs+0x16d/0x1e0 [ipmi_msghandler]
> > [117621.535276]  tasklet_action_common.isra.21+0x4e/0xf0
> > [117621.535284]  __do_softirq+0xd8/0x2d2
> > [117621.567383]  irq_exit+0xb4/0xc0
> > [117621.567387]  smp_apic_timer_interrupt+0x74/0x140
> > [117621.567390]  apic_timer_interrupt+0xf/0x20
> > [117621.567392]  </IRQ>
> > [117621.567397] RIP: 0010:finish_task_switch+0x78/0x260
> > [117621.567399] Code: 65 48 8b 1c 25 00 4d 01 00 0f 1f 44 00 00 0f 1f
> > 44 00 00 41 c7 46 38 00 00 00 00 41 c6 04 24 00 fb 65 48 8b 04 25 00
> > 4d 01 00 <0f> 1f 44 00 00 4d 85 ed 74 1a 41 8b 85 80 03 00 00
>
> This should all be fixed in the latest 4.19.y release, right?
>
> thanks,
>
> greg k-h
