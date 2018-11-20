Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB5C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCE92087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjbzyxgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCE92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeKUAf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:35:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38208 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKUAf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:35:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so1733667lja.5;
        Tue, 20 Nov 2018 06:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QKmVi6oK4xHxiS0EpoYyaLTZHd88UZFwRCeilC1KCxk=;
        b=RjbzyxgTKRw1+2/x/TbCbOXRlzF7i9FlZn+Pz8A+OVnMHSAQF45VYREHNvmWxjl4Ps
         eRQcQX6PTuEbCsOP8DCOyCXQ8Co9Gx2lOYrpiAIljNXEHm+We5u0GUF41hCStNd9f5mI
         Balq034joeK5099eOJW7T3Yx15295ANPUwQtDYhZlaiw/w5zB11pq8tZYWs1gyVK1Goc
         8J5hoHR53hASVTNnQTFpzbthKA0dY5Sy5CqY1uAAoRviIOX71lVOXUKYbRXIyzAURoVT
         UAEDqWj4u8c7eyh2iaXdz61tsne8N8Cl57KbQDqr14pCNGDJQrS2g6h099pscnWxnYJs
         MYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QKmVi6oK4xHxiS0EpoYyaLTZHd88UZFwRCeilC1KCxk=;
        b=lwb2C3segmsD8kFkACJSUWwblvCmk/MGl7xaX3VA8XmTIZKCXwJoYvcRuxwKOoU2lA
         /1z8OXv5npNt4BYsh/AgXt2EHrSZKuOqv3/rUuujglOP6CBKmY37zhGzHL8wA0uonwK7
         4MKZsJk9nklv8KkStSevbESPNvXZIgsmuu/Af3gPF9hGFb93s8JynDS6zMZHW/i9mxup
         LE6ijlb1Tkurt0LZpb9Cs1PSRwCGOTU7WLezG8OcEdIijPCEJrjqkqXawCca0u+nwx8b
         ue1x+xaI6el2rgTVjNsE57lsoHviEvkw9lsjmqXhdBcrAuMOuS+axlg2DG10oX5VPlDm
         Ehog==
X-Gm-Message-State: AA+aEWYbN3CE93KTj7a1PJ3IDh1z8XBhFHl8XyKm3KDf25NtmQNeT13q
        34HUxDQN/OzrdLkNcDxloR+pw60agO1UmeF0EUBThuOK
X-Google-Smtp-Source: AFSGD/VafT0DsNTXgOg/cl+nituif+IzopenLr/9EVwq+Y7Q3bO8eQ1qSXk34psvlTtdOZ1YYxWU81X9ISzTvDjl340=
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr1468128ljj.6.1542722767576;
 Tue, 20 Nov 2018 06:06:07 -0800 (PST)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 20 Nov 2018 15:05:55 +0100
Message-ID: <CAA85sZthkwZ0yhfwXZ5dAJitqsod71O1478e44tz0NNLJVsvGg@mail.gmail.com>
Subject: pcc_cpufreq: high LA
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've had this happen a few times now, pcc_cpufreq is loaded and the
machine has a LA of 33 with kworkers consuming *all CPU*

We have had this happen before, looking at it has been pushed to the
leaky-stack^tm in my mind and...

32 cores:
processor : 31
vendor_id : GenuineIntel
cpu family : 6
model : 62
model name : Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
stepping : 4
microcode : 0x42d
cpu MHz : 2053.444
cache size : 20480 KB
----

System Information:
Manufacturer: HP
Product Name: ProLiant SL210t Gen8
---

The only warning I can see, which seems unrelated is:
[6928231.623398] WARNING: CPU: 11 PID: 0 at kernel/irq/matrix.c:371
irq_matrix_free+0x35/0xe0
[6928231.623402] Modules linked in: 8021q garp mrp ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4
nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack nf_nat
nf_conntrack dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio
libcrc32c loop bonding sb_edac x86_pkg_temp_thermal intel_powerclamp
coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel pcbc aesni_intel crypto_simd cryptd glue_helper
intel_cstate intel_rapl_perf iTCO_wdt iTCO_vendor_support joydev
input_leds acpi_power_meter pcspkr hpilo sg ipmi_si ipmi_devintf
ipmi_msghandler hpwdt ioatdma lpc_ich shpchp pcc_cpufreq mfd_core
ip_tables ext4 mbcache jbd2 raid1 sd_mod crc32c_intel serio_raw
drm_kms_helper ahci syscopyarea sysfillrect libahci sysimgblt
fb_sys_fops ttm libata drm igb
[6928231.623490]  i2c_algo_bit ixgbe mdio ptp pps_core dca dm_mirror
dm_region_hash dm_log dm_mod
[6928231.623507] CPU: 11 PID: 0 Comm: swapper/11 Not tainted
4.17.0-1.el7.elrepo.x86_64 #1
[6928231.623509] Hardware name: HP ProLiant SL210t Gen8/, BIOS P83 05/21/2018
[6928231.623514] RIP: 0010:irq_matrix_free+0x35/0xe0
[6928231.623516] RSP: 0018:ffff88203f4c3f58 EFLAGS: 00010002
[6928231.623519] RAX: 0000000000026d00 RBX: ffff880ffaf64340 RCX:
0000000000000000
[6928231.623521] RDX: 000000000000000b RSI: 000000000000000b RDI:
ffff880fff038800
[6928231.623523] RBP: ffff88203f4c3f80 R08: 0000000000000101 R09:
0000000000000000
[6928231.623525] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff88203f4c0000
[6928231.623527] R13: 0000000000000000 R14: 000000000000000b R15:
ffff880fff038800
[6928231.623530] FS:  0000000000000000(0000) GS:ffff88203f4c0000(0000)
knlGS:0000000000000000
[6928231.623532] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[6928231.623534] CR2: 00007fc429b73d20 CR3: 000000000220a006 CR4:
00000000001606e0
[6928231.623537] Call Trace:
[6928231.623541]  <IRQ>
[6928231.623554]  free_moved_vector+0x58/0x110
[6928231.623563]  smp_irq_move_cleanup_interrupt+0xa2/0xc1
[6928231.623572]  irq_move_cleanup_interrupt+0xc/0x20
[6928231.623574]  </IRQ>
[6928231.623582] RIP: 0010:cpuidle_enter_state+0xdd/0x270
[6928231.623583] RSP: 0018:ffffc9000631fe48 EFLAGS: 00000246 ORIG_RAX:
ffffffffffffffdf
[6928231.623586] RAX: ffff88203f4e2c00 RBX: ffffe8ffff6da700 RCX:
000000000000001f
[6928231.623588] RDX: 0000000000000000 RSI: fff0a6fbff885c1c RDI:
0000000000000000
[6928231.623590] RBP: ffffc9000631fe80 R08: 0000000000002036 R09:
00000000000043d0
[6928231.623592] R10: 000000000000133e R11: 0000000000000018 R12:
0000000000000004
[6928231.623594] R13: 000000000000000b R14: ffffffff82364b60 R15:
00189d309ada9b44
[6928231.623599]  ? cpuidle_enter_state+0xcc/0x270
[6928231.623603]  cpuidle_enter+0x17/0x20
[6928231.623611]  call_cpuidle+0x23/0x40
[6928231.623614]  do_idle+0x1d2/0x270
[6928231.623619]  cpu_startup_entry+0x73/0x80
[6928231.623624]  start_secondary+0x1ae/0x200
[6928231.623632]  secondary_startup_64+0xa5/0xb0
[6928231.623634] Code: 57 49 89 ff 41 56 41 89 f6 41 55 41 89 d5 89 f2
41 54 4c 8b 24 d5 60 c7 12 82 53 48 8b 47 28 44 39 6f 04 77 06 44 3b
6f 08 72 0d <0f> 0b 5b 41 5c 41 5d 41 5e 41 5f 5d c3 49 01 c4 44 89 e8
f0 49
[6928231.623693] ---[ end trace 6436d0c28a5009d4 ]---
