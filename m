Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9017FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBF02171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfABAot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:44:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:49646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbfABAos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:44:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88F5CAD08;
        Wed,  2 Jan 2019 00:44:43 +0000 (UTC)
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio to
 register as a clk provider
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
To:     Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Cc:     Ben Whitten <ben.whitten@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        starnight@g.ncu.edu.tw, "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
 <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
 <20181231175034.GI1846@sirena.org.uk>
 <ae7dd20c-777e-e043-127c-819fa0ae4792@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <1904336c-3349-b22b-18ac-e82e4afebc51@suse.de>
Date:   Wed, 2 Jan 2019 01:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <ae7dd20c-777e-e043-127c-819fa0ae4792@suse.de>
Content-Type: multipart/mixed;
 boundary="------------417627AF9FF0D73EA7FBFE3C"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------417627AF9FF0D73EA7FBFE3C
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

Am 31.12.18 um 23:56 schrieb Andreas Färber:
> Am 31.12.18 um 18:50 schrieb Mark Brown:
>> On Sun, Dec 30, 2018 at 11:55:46AM +0100, Andreas Färber wrote:
>>> Given that observed symptoms were CPU stalls, workqueue hangs and RCU
>>> problems, requiring a power-cycle to recover, I wonder whether we are
>>> running into some atomic/locking issue with clk_enable()? Is it valid at
>>> all to use SPI/regmap for clk_enable()? If it is, is there a known issue
>>> specific to spi-sun6i (A64) in 4.20.0?
>>> I already tried setting .disable_locking = true in both regmap_configs.
>>> Any suggestions how to further debug?
>>
>> You can't use SPI for clk_enable(), clk_enable() needs to be doable in
>> atomic context since we need to wait for the bus operations to complete
>> (you can start SPI transfers in atomic context but you still need to
>> wait for them to complete).  Any clocks that are only accessible via a
>> slow bus like I2C or SPI need to do the enable/disable in the
>> prepare/unprepare operations which aren't done in atomic context.
>>
>> regmap can be used in atomic contexts, though you need to configure it
>> to use spinlocks instead of mutexes and ensure that no register cache
>> allocations happen during I/O (eg, by providing defaults for all
>> registers or by not using a cache).
> 
> We have .cache_type = REGCACHE_NONE on both bus and spi regmap_configs.
> 
> I moved the regmap_field_write() from .enable to .prepare and set
> .fast_io = true on both regmap_configs to force using spinlocks, but
> same hang as in .enable before...
> 
> And same if I set .disable_locking = true on both.
> 
> Given that it works with one SPI driver and not with the other,
> independent of the locking options applied, I assume my symptoms are not
> a regmap-layer issue.
> 
> Is it allowed during a .prepare operation to call the mentioned
> clk_get_rate(), which ends up calling clk_prepare_lock()?
> 
> According to my debug output in spi-sun6i.c our hanging
> regmap_field_write() ends up calling sun6i_transfer_one() three times,
> the first two look okay, but the third one doesn't make it past the
> clk_get_rate() [...].

SysRq still works in that state! Attached is SysRq-w output.
(still with .disable_locking = true in both regmap_configs)

In the very bottom you see the "ip" task, at wait_for_completion() from
__spi_sync().
I trigger this issue with `ip link set lora2 up`, so that looks okay.

Then there's a "spi1" task at clk_prepare_lock()' mutex_lock() coming
from spi_pump_messages().
The reason for that will be that clk_prepare_lock()'s mutex_trylock()
failed (because we're holding the prepare_lock from clk_prepare_enable()
in the "ip" task) and that the prepare_owner == current check fails for
this separate task_struct, too.

So, the third invocation of sun6i_transfer_one() calling clk_get_rate()
hangs at the prepare_lock instead of reference-counting, because it runs
from a separate kthread, unlike the two previous calls?

Besides, there's also an mmc_rescan workqueue task at clk_prepare_lock()
coming from sunxi_mmc_enable() due to pm_generic_runtime_resume().
My rootfs is on microSD card.

I did not find any *regmap_init_spi() based example in drivers/clk/, and
all other "spi" mentions in drivers/clk/ appeared to be clock names.
The closest was devm_regmap_init_i2c() based clk-cdce706.c, which uses
the prepare/unprepare ops, as suggested by Mark, and does
regmap_update_bits() from there.

A quick grep in drivers/i2c/ does not find any mention of "kthread", so
probably that's the breaking difference?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)

--------------417627AF9FF0D73EA7FBFE3C
Content-Type: text/plain; charset=UTF-8;
 name="pinie-sysrq-w.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pinie-sysrq-w.txt"

[39292.911444] sysrq: SysRq : Show Blocked State
[39292.915819]   task                        PC stack   pid father
[39292.921784] kworker/0:2     D    0   170      2 0x00000028
[39292.927282] Workqueue: ipv6_addrconf addrconf_verify_work
[39292.932676] Call trace:
[39292.935127]  __switch_to+0x9c/0xd8
[39292.938530]  __schedule+0x2a0/0x888
[39292.942016]  schedule+0x30/0x88
[39292.945157]  schedule_preempt_disabled+0x14/0x20
[39292.949770]  __mutex_lock.isra.1+0x2c0/0x4b8
[39292.954036]  __mutex_lock_slowpath+0x24/0x30
[39292.958302]  mutex_lock+0x48/0x50
[39292.961615]  rtnl_lock+0x1c/0x28
[39292.964841]  addrconf_verify_work+0x14/0x28
[39292.969022]  process_one_work+0x1f4/0x428
[39292.973028]  worker_thread+0x44/0x4a8
[39292.976686]  kthread+0x130/0x138
[39292.979912]  ret_from_fork+0x10/0x18
[39292.983518] btrfs-transacti D    0   383      2 0x00000028
[39292.988998] Call trace:
[39292.991444]  __switch_to+0x9c/0xd8
[39292.994845]  __schedule+0x2a0/0x888
[39292.998330]  schedule+0x30/0x88
[39293.001472]  io_schedule+0x20/0x40
[39293.004874]  wbt_wait+0x1bc/0x2f8
[39293.008188]  rq_qos_throttle+0x4c/0x68
[39293.011936]  blk_mq_make_request+0xc4/0x4f0
[39293.016118]  generic_make_request+0xf4/0x308
[39293.020384]  submit_bio+0x40/0x198
[39293.023977]  btrfs_map_bio+0x370/0x3f8 [btrfs]
[39293.028550]  btrfs_submit_bio_hook+0xa4/0x1c0 [btrfs]
[39293.033727]  submit_one_bio+0x78/0xb8 [btrfs]
[39293.038211]  flush_write_bio.isra.12+0x2c/0x48 [btrfs]
[39293.043477]  extent_writepages+0x60/0x70 [btrfs]
[39293.048217]  btrfs_writepages+0x28/0x38 [btrfs]
[39293.052747]  do_writepages+0x3c/0xe0
[39293.056323]  __filemap_fdatawrite_range+0xc0/0x118
[39293.061109]  filemap_fdatawrite_range+0x38/0x48
[39293.065764]  btrfs_fdatawrite_range+0x34/0x78 [btrfs]
[39293.070942]  __btrfs_write_out_cache+0x400/0x450 [btrfs]
[39293.076382]  btrfs_write_out_cache+0xc0/0x160 [btrfs]
[39293.081551]  btrfs_start_dirty_block_groups+0x2dc/0x4d0 [btrfs]
[39293.087591]  btrfs_commit_transaction+0x554/0x940 [btrfs]
[39293.093111]  transaction_kthread+0x18c/0x1a8 [btrfs]
[39293.098072]  kthread+0x130/0x138
[39293.101298]  ret_from_fork+0x10/0x18
[39293.104877] systemd-journal D    0   448      1 0x00000801
[39293.110358] Call trace:
[39293.112803]  __switch_to+0x9c/0xd8
[39293.116204]  __schedule+0x2a0/0x888
[39293.119690]  schedule+0x30/0x88
[39293.122830]  io_schedule+0x20/0x40
[39293.126230]  wait_on_page_bit+0x134/0x240
[39293.130366]  btrfs_page_mkwrite+0x1e0/0x450 [btrfs]
[39293.135240]  do_page_mkwrite+0x40/0xb0
[39293.138985]  do_wp_page+0x3d0/0x578
[39293.142471]  __handle_mm_fault+0x484/0x528
[39293.146563]  handle_mm_fault+0x10c/0x1e8
[39293.150484]  do_page_fault+0x174/0x480
[39293.154229]  do_mem_abort+0x50/0xa8
[39293.157713]  el0_da+0x20/0x24
[39293.160676] journal-offline D    0 23928      1 0x00000801
[39293.166156] Call trace:
[39293.168601]  __switch_to+0x9c/0xd8
[39293.172002]  __schedule+0x2a0/0x888
[39293.175487]  schedule+0x30/0x88
[39293.178626]  io_schedule+0x20/0x40
[39293.182025]  wbt_wait+0x1bc/0x2f8
[39293.185338]  rq_qos_throttle+0x4c/0x68
[39293.189085]  blk_mq_make_request+0xc4/0x4f0
[39293.193266]  generic_make_request+0xf4/0x308
[39293.197533]  submit_bio+0x40/0x198
[39293.201064]  btrfs_map_bio+0x370/0x3f8 [btrfs]
[39293.205632]  btrfs_submit_bio_hook+0xa4/0x1c0 [btrfs]
[39293.210808]  submit_one_bio+0x78/0xb8 [btrfs]
[39293.215292]  submit_extent_page+0xcc/0x218 [btrfs]
[39293.220209]  __extent_writepage_io+0x230/0x3e8 [btrfs]
[39293.225472]  __extent_writepage+0x114/0x2e0 [btrfs]
[39293.230476]  extent_write_cache_pages+0xec/0x328 [btrfs]
[39293.235912]  extent_writepages+0x54/0x70 [btrfs]
[39293.240651]  btrfs_writepages+0x28/0x38 [btrfs]
[39293.245179]  do_writepages+0x3c/0xe0
[39293.248751]  __filemap_fdatawrite_range+0xc0/0x118
[39293.253538]  filemap_fdatawrite_range+0x38/0x48
[39293.258194]  btrfs_fdatawrite_range+0x34/0x78 [btrfs]
[39293.263368]  start_ordered_ops+0x4c/0x80 [btrfs]
[39293.268110]  btrfs_sync_file+0x88/0x3e0 [btrfs]
[39293.272640]  vfs_fsync_range+0x4c/0x88
[39293.276385]  do_fsync+0x48/0x88
[39293.279525]  __arm64_sys_fsync+0x24/0x38
[39293.283446]  el0_svc_common+0x98/0x100
[39293.287192]  el0_svc_handler+0x38/0x78
[39293.290936]  el0_svc+0x8/0xc
[39293.293829] wickedd         D    0   713      1 0x00000000
[39293.299309] Call trace:
[39293.301755]  __switch_to+0x9c/0xd8
[39293.305155]  __schedule+0x2a0/0x888
[39293.308641]  schedule+0x30/0x88
[39293.311781]  schedule_preempt_disabled+0x14/0x20
[39293.316394]  __mutex_lock.isra.1+0x2c0/0x4b8
[39293.320661]  __mutex_lock_slowpath+0x24/0x30
[39293.324927]  mutex_lock+0x48/0x50
[39293.328243]  __netlink_dump_start+0x7c/0x1d8
[39293.332511]  rtnetlink_rcv_msg+0x280/0x2c0
[39293.336604]  netlink_rcv_skb+0x60/0x120
[39293.340437]  rtnetlink_rcv+0x28/0x38
[39293.344010]  netlink_unicast+0x1a8/0x280
[39293.347928]  netlink_sendmsg+0x188/0x338
[39293.351848]  sock_sendmsg+0x4c/0x68
[39293.355333]  ___sys_sendmsg+0x26c/0x2a0
[39293.359165]  __sys_sendmsg+0x64/0xa0
[39293.362736]  __arm64_sys_sendmsg+0x2c/0x38
[39293.366829]  el0_svc_common+0x98/0x100
[39293.370575]  el0_svc_handler+0x38/0x78
[39293.374320]  el0_svc+0x8/0xc
[39293.377201] ntpd            D    0  1354      1 0x00000001
[39293.382681] Call trace:
[39293.385126]  __switch_to+0x9c/0xd8
[39293.388526]  __schedule+0x2a0/0x888
[39293.392012]  schedule+0x30/0x88
[39293.395151]  schedule_preempt_disabled+0x14/0x20
[39293.399764]  __mutex_lock.isra.1+0x2c0/0x4b8
[39293.404029]  __mutex_lock_slowpath+0x24/0x30
[39293.408296]  mutex_lock+0x48/0x50
[39293.411610]  __netlink_dump_start+0x7c/0x1d8
[39293.415876]  rtnetlink_rcv_msg+0x280/0x2c0
[39293.419969]  netlink_rcv_skb+0x60/0x120
[39293.423801]  rtnetlink_rcv+0x28/0x38
[39293.427374]  netlink_unicast+0x1a8/0x280
[39293.431294]  netlink_sendmsg+0x188/0x338
[39293.435211]  sock_sendmsg+0x4c/0x68
[39293.438694]  __sys_sendto+0xe8/0x150
[39293.442266]  __arm64_sys_sendto+0x30/0x40
[39293.446272]  el0_svc_common+0x98/0x100
[39293.450018]  el0_svc_handler+0x38/0x78
[39293.453762]  el0_svc+0x8/0xc
[39293.456670] kworker/2:1     D    0 23762      2 0x00000028
[39293.462197] Workqueue: events_freezable mmc_rescan [mmc_core]
[39293.467936] Call trace:
[39293.470381]  __switch_to+0x9c/0xd8
[39293.473781]  __schedule+0x2a0/0x888
[39293.477267]  schedule+0x30/0x88
[39293.480406]  schedule_preempt_disabled+0x14/0x20
[39293.485019]  __mutex_lock.isra.1+0x2c0/0x4b8
[39293.489285]  __mutex_lock_slowpath+0x24/0x30
[39293.493551]  mutex_lock+0x48/0x50
[39293.496865]  clk_prepare_lock+0x48/0xa0
[39293.500699]  clk_prepare+0x24/0x58
[39293.504105]  sunxi_mmc_enable+0x40/0x220 [sunxi_mmc]
[39293.509067]  sunxi_mmc_runtime_resume+0x2c/0x70 [sunxi_mmc]
[39293.514637]  pm_generic_runtime_resume+0x3c/0x58
[39293.519251]  __rpm_callback+0x118/0x208
[39293.523082]  rpm_callback+0x70/0x98
[39293.526567]  rpm_resume+0x65c/0x840
[39293.530052]  __pm_runtime_resume+0x68/0xc8
[39293.534182]  __mmc_claim_host+0x200/0x260 [mmc_core]
[39293.539178]  mmc_get_card+0x38/0x48 [mmc_core]
[39293.543656]  mmc_sd_detect+0x24/0x90 [mmc_core]
[39293.548219]  mmc_rescan+0x3d0/0x540 [mmc_core]
[39293.552659]  process_one_work+0x1f4/0x428
[39293.556665]  worker_thread+0x44/0x4a8
[39293.560323]  kthread+0x130/0x138
[39293.563549]  ret_from_fork+0x10/0x18
[39293.567122] kworker/u8:5    D    0 23778      2 0x00000028
[39293.572608] Workqueue: writeback wb_workfn (flush-btrfs-1)
[39293.578087] Call trace:
[39293.580533]  __switch_to+0x9c/0xd8
[39293.583933]  __schedule+0x2a0/0x888
[39293.587419]  schedule+0x30/0x88
[39293.590557]  io_schedule+0x20/0x40
[39293.593956]  wbt_wait+0x1bc/0x2f8
[39293.597269]  rq_qos_throttle+0x4c/0x68
[39293.601016]  blk_mq_make_request+0xc4/0x4f0
[39293.605196]  generic_make_request+0xf4/0x308
[39293.609461]  submit_bio+0x40/0x198
[39293.612995]  btrfs_map_bio+0x370/0x3f8 [btrfs]
[39293.617563]  btrfs_submit_bio_hook+0xa4/0x1c0 [btrfs]
[39293.622743]  submit_one_bio+0x78/0xb8 [btrfs]
[39293.627227]  submit_extent_page+0xcc/0x218 [btrfs]
[39293.632142]  __extent_writepage_io+0x230/0x3e8 [btrfs]
[39293.637405]  __extent_writepage+0x114/0x2e0 [btrfs]
[39293.642411]  extent_write_cache_pages+0xec/0x328 [btrfs]
[39293.647849]  extent_writepages+0x54/0x70 [btrfs]
[39293.652590]  btrfs_writepages+0x28/0x38 [btrfs]
[39293.657118]  do_writepages+0x3c/0xe0
[39293.660691]  __writeback_single_inode+0x48/0x438
[39293.665304]  writeback_sb_inodes+0x1c8/0x478
[39293.669570]  __writeback_inodes_wb+0x78/0xc8
[39293.673835]  wb_writeback+0x264/0x388
[39293.677494]  wb_workfn+0x304/0x4a8
[39293.680893]  process_one_work+0x1f4/0x428
[39293.684898]  worker_thread+0x44/0x4a8
[39293.688555]  kthread+0x130/0x138
[39293.691781]  ret_from_fork+0x10/0x18
[39293.695354] spi1            D    0 23857      2 0x00000028
[39293.700834] Call trace:
[39293.703280]  __switch_to+0x9c/0xd8
[39293.706680]  __schedule+0x2a0/0x888
[39293.710165]  schedule+0x30/0x88
[39293.713305]  schedule_preempt_disabled+0x14/0x20
[39293.717918]  __mutex_lock.isra.1+0x2c0/0x4b8
[39293.722183]  __mutex_lock_slowpath+0x24/0x30
[39293.726450]  mutex_lock+0x48/0x50
[39293.729763]  clk_prepare_lock+0x48/0xa0
[39293.733597]  clk_core_get_rate+0x1c/0x78
[39293.737515]  clk_get_rate+0x28/0x38
[39293.741006]  sun6i_spi_transfer_one+0x150/0x4a0 [spi_sun6i]
[39293.746575]  spi_transfer_one_message+0x150/0x648
[39293.751274]  __spi_pump_messages+0x424/0x6f0
[39293.755541]  spi_pump_messages+0x24/0x30
[39293.759460]  kthread_worker_fn+0xf0/0x1f8
[39293.763465]  kthread+0x130/0x138
[39293.766691]  ret_from_fork+0x10/0x18
[39293.770266] kworker/u8:8    D    0 23923      2 0x00000028
[39293.775882] Workqueue: btrfs-submit btrfs_submit_helper [btrfs]
[39293.781793] Call trace:
[39293.784240]  __switch_to+0x9c/0xd8
[39293.787640]  __schedule+0x2a0/0x888
[39293.791126]  schedule+0x30/0x88
[39293.794301]  __mmc_claim_host+0xa8/0x260 [mmc_core]
[39293.799210]  mmc_get_card+0x38/0x48 [mmc_core]
[39293.803658]  mmc_mq_queue_rq+0x220/0x308 [mmc_block]
[39293.808619]  __blk_mq_try_issue_directly+0x120/0x190
[39293.813580]  blk_mq_request_issue_directly+0x94/0xc0
[39293.818539]  blk_mq_try_issue_list_directly+0x40/0x98
[39293.823585]  blk_mq_sched_insert_requests+0x98/0xc0
[39293.828458]  blk_mq_flush_plug_list+0x184/0x298
[39293.832984]  blk_flush_plug_list+0xd8/0x250
[39293.837164]  blk_finish_plug+0x3c/0x4c
[39293.841042]  run_scheduled_bios+0x2e4/0x408 [btrfs]
[39293.846045]  pending_bios_fn+0x20/0x30 [btrfs]
[39293.850615]  normal_work_helper+0x200/0x470 [btrfs]
[39293.855619]  btrfs_submit_helper+0x20/0x30 [btrfs]
[39293.860406]  process_one_work+0x1f4/0x428
[39293.864411]  worker_thread+0x44/0x4a8
[39293.868068]  kthread+0x130/0x138
[39293.871294]  ret_from_fork+0x10/0x18
[39293.874866] ip              D    0 23925  23924 0x00000000
[39293.880346] Call trace:
[39293.882792]  __switch_to+0x9c/0xd8
[39293.886193]  __schedule+0x2a0/0x888
[39293.889679]  schedule+0x30/0x88
[39293.892817]  schedule_timeout+0x2c4/0x408
[39293.896823]  wait_for_common+0xdc/0x1a8
[39293.900656]  wait_for_completion+0x28/0x38
[39293.904750]  __spi_sync+0x148/0x388
[39293.908235]  spi_sync+0x34/0x58
[39293.911375]  regmap_spi_write+0x84/0x98
[39293.915210]  _regmap_raw_write_impl+0x794/0x8d8
[39293.919737]  _regmap_bus_raw_write+0x70/0x90
[39293.924003]  _regmap_write+0x70/0x128
[39293.927662]  regmap_write+0x50/0x78
[39293.931155]  sx130x_radio_read+0x94/0x270 [lora_sx130x]
[39293.936375]  _regmap_raw_read+0xd0/0x248
[39293.940295]  _regmap_bus_read+0x50/0x88
[39293.944127]  _regmap_read+0x6c/0x170
[39293.947700]  _regmap_update_bits+0xa4/0xf0
[39293.951793]  regmap_update_bits_base+0x68/0x98
[39293.956233]  regmap_field_update_bits_base+0x5c/0x70
[39293.961195]  sx125x_clkout_prepare+0x44/0x50 [lora_sx125x]
[39293.966674]  clk_core_prepare+0x64/0x1d8
[39293.970593]  clk_prepare+0x2c/0x58
[39293.973995]  sx130x_loradev_open+0x58/0x738 [lora_sx130x]
[39293.979388]  __dev_open+0xd8/0x178
[39293.982788]  __dev_change_flags+0x134/0x198
[39293.986968]  dev_change_flags+0x34/0x70
[39293.990800]  do_setlink+0x2a8/0xbb8
[39293.994287]  rtnl_newlink+0x408/0x768
[39293.997945]  rtnetlink_rcv_msg+0x20c/0x2c0
[39294.002038]  netlink_rcv_skb+0x60/0x120
[39294.005870]  rtnetlink_rcv+0x28/0x38
[39294.009443]  netlink_unicast+0x1a8/0x280
[39294.013363]  netlink_sendmsg+0x188/0x338
[39294.017281]  sock_sendmsg+0x4c/0x68
[39294.020766]  ___sys_sendmsg+0x26c/0x2a0
[39294.024598]  __sys_sendmsg+0x64/0xa0
[39294.028170]  __arm64_sys_sendmsg+0x2c/0x38
[39294.032263]  el0_svc_common+0x98/0x100
[39294.036009]  el0_svc_handler+0x38/0x78
[39294.039753]  el0_svc+0x8/0xc


--------------417627AF9FF0D73EA7FBFE3C--
