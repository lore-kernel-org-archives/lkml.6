Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeC2IyQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:54:16 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:54348 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeC2IyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:54:15 -0400
Date: Thu, 29 Mar 2018 11:54:09 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: 4.16-rc2+git: pata_serverworks: hanging ata detection thread on
 HP DL380G3
In-Reply-To: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee>
Message-ID: <alpine.LRH.2.21.1803291153070.12825@math.ut.ee>
References: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 4.16 git bootup on HP Proliant DL380 G3 pauses for a a minute or two and 
> then continues with "blocked for more than 120 seconds" message with 
> libata detection functions in ther stack - 
> async_synchronize_cookie_domain() as the last. It seems to happen during 
> IDE CD-ROM detection (detected before but registered as sr0 after the 
> warning). After detection, the eject button on the drive did not work.
> 
> 
> pata_serverworks is the libata driver in use.

This is still the same in 4.16.0-rc7-00062-g0b412605ef5f.

> [  242.652061] INFO: task kworker/u8:4:613 blocked for more than 120 seconds.
> [  242.652230]       Not tainted 4.16.0-rc2-00374-g3664ce2d9309 #36
> [  242.654171] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  242.654386] kworker/u8:4    D    0   613      2 0x80000000
> [  242.654517] Workqueue: events_unbound async_run_entry_fn
> [  242.654637] Call Trace:
> [  242.654759]  __schedule+0x1bc/0x8d3
> [  242.654877]  ? set_next_entity+0xc1/0x39a
> [  242.654994]  schedule+0x28/0xb2
> [  242.655096]  async_synchronize_cookie_domain+0xac/0xf4
> [  242.655217]  ? __clear_rsb+0x1d/0x32
> [  242.655334]  ? wait_woken+0xb7/0xb7
> [  242.655449]  async_synchronize_cookie+0xd/0x15
> [  242.655583]  async_port_probe+0x57/0x87 [libata]
> [  242.655703]  ? __clear_rsb+0xd/0x32
> [  242.655825]  ? ata_port_probe+0x52/0x52 [libata]
> [  242.655945]  async_run_entry_fn+0x49/0x1f2
> [  242.656075]  process_one_work+0x20a/0x568
> [  242.656191]  worker_thread+0x4c/0x631
> [  242.656312]  kthread+0x140/0x1e4
> [  242.656428]  ? process_one_work+0x568/0x568
> [  242.656547]  ? kthread_create_on_node+0x23/0x23
> [  242.656667]  ret_from_fork+0x2e/0x38
> [  242.656793] INFO: task systemd-udevd:803 blocked for more than 120 seconds.
> [  242.656920]       Not tainted 4.16.0-rc2-00374-g3664ce2d9309 #36
> [  242.657039] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  242.657257] systemd-udevd   D    0   803    758 0x80000004
> [  242.657379] Call Trace:
> [  242.657495]  __schedule+0x1bc/0x8d3
> [  242.657614]  ? kfree_skbmem+0x65/0x85
> [  242.657730]  schedule+0x28/0xb2
> [  242.657846]  async_synchronize_cookie_domain+0xac/0xf4
> [  242.657968]  ? wait_woken+0xb7/0xb7
> [  242.658082]  async_synchronize_full+0x14/0x16
> [  242.658206]  do_init_module+0x10f/0x24b
> [  242.658323]  load_module+0x29c9/0x3865
> [  242.658443]  ? kernel_read+0x50/0xa7
> [  242.658558]  SyS_finit_module+0x78/0x8d
> [  242.658681]  do_fast_syscall_32+0xc7/0x323
> [  242.658800]  entry_SYSENTER_32+0x4e/0x7c
> [  242.658916] EIP: 0xb7f0cad5
> [  242.659030] EFLAGS: 00000292 CPU: 0
> [  242.659145] EAX: ffffffda EBX: 0000000d ECX: b7d03bdd EDX: 00000000
> [  242.659265] ESI: 011ba740 EDI: 011bdb50 EBP: 00000000 ESP: bfcf1bcc
> [  242.659388]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
> [  244.422337] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [  246.012767] tg3 0000:02:01.0 eth0: Link is up at 100 Mbps, full duplex
> [  246.012875] tg3 0000:02:01.0 eth0: Flow control is off for TX and off for RX
> [  246.012990] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [  316.432903] scsi 1:0:0:0: Attached scsi generic sg3 type 5
> [  316.667528] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
> [  316.667571] cdrom: Uniform CD-ROM driver Revision: 3.20
> [  316.667837] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [ 4097.814125] random: crng init done
> 
> 

-- 
Meelis Roos (mroos@linux.ee)
