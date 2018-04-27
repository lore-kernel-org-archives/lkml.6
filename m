Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488892-1524847287-2-5334442290634515427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524847286; b=H9r+FFlpUt/v0c2dnlEDUkCUdJ80oqMf7sP5XK7Fr3r5ULfgEc
    PaJ0tOCzTqvWdBDH/PlogLY0C4nzrXkcYGFmlxViI4labhgA4p3JA3bKuFVuXjs/
    RMq2IX++L29lrn83W9lANhhjx6vU3zSuTWdjmTXLT3vrBvEDe2zlScz6CeCBl9sA
    oToauVN4+WkN2jo5SoJDT7sWoNWwb7kMHNTvIZKVf0ZHhk4LuFOZcwBtPNV7+XGh
    jEwGdFTb+boywd+CNIXpv+Zqo/5qqxBQDoDtMsf3Pkro8KfX/4QbwNdD8lnfloe8
    sq0BuRDdKTGnPTfMLzKZu5e7llrK/jQqHq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1524847286; bh=vpCJ
    +rUUg6bGf0qtWUK23xfh3QIA5s16lJREQDfLZVw=; b=P0QUJU24jXzo47Q6cwLM
    MuNFuEmPnchI4qmZ8j1SzvITZMCKvB6A5aEVEvKmbnkHDuBSMp1+GppvjMZGuf1C
    vYtIwIMXrqWP9+yxmFMWYY9chO6jcD9HZTe6kH6wYarOhlgd/FGYImw6fqPxd9G5
    qBrF9npKvpjRjADc06L6RSCZkUdG2JUgH5s/h1fwYerj6VY+OxkZ/cnZOEwt8RHE
    Q8bj3dslTgFg2QkMUnuAi3Ubz5tWD3qM3ag6LuWYMKCDnvRw9vTr2YEonqnNtiA5
    yJVv7m00DNbU9q4XLlaJPTDsyL6xh9CSo880pbf6anKzpEyXA9I3Ots61O5rhVOe
    Uw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RXcbLM3w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oZdZXw8l;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RXcbLM3w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oZdZXw8l;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfISr8dUnwTNCd4nDUx4ssB0O3aKSMn0RnRcGkxKJLKb2h+3L1qcxE6NNsyfJKP0nRFKvqxHPm9KuLuNDNI+hMG74mwMA9wX3MNd72vfKhE5H4vW0KzhF
    T7Qer8IT6FGVaqMveyZU2pv3iNlJkU+leWRNcBycf1LhsG+zVpAK4cyxwlw/6SshFlTwenA8kY6ysZpNO3KgvffRA3YTzG78OXya9DZFRn5tXJjfZJpx93rn
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=XWobslsRXP8A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=PNCTgnf8Ib9h48_TjUgA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758562AbeD0QlX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 12:41:23 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37171 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757569AbeD0QlV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Apr 2018 12:41:21 -0400
X-Google-Smtp-Source: AB8JxZrR7R9Q2kc197PCojoWLjlCCVqT5iovlHNYNY59pZY8PwlPMtW8gaCzBv//UBfwCwFdpkJ9RfRxEgIsmmd/K28=
MIME-Version: 1.0
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Fri, 27 Apr 2018 11:41:20 -0500
X-Google-Sender-Auth: dq2f1VLvrafMEMo9dtd9ZNehVOY
Message-ID: <CALaQ_hq0CevQY8tUbh4D3-t_RrnmqQuHHN=MjwdsjY+e=rTvFA@mail.gmail.com>
Subject: drivers/tty/serial/samsung.c s3c24xx_uart_copy_rx_to_tty
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

No idea why, but I will say that something I've done recently was
re-enabl my ath9k_htc wireless adapter which tends to firmware-panic
quite a bit which also sometimes kills off my ppp usb adapter.
I have a script running that monitors the journalctl and restarts
hostapd everytime my ath device firmware-panics and comes back alive.
Same with netctl for my ppp.

The first time I've noticed this particular issue was yesterday when
my ssh session became sluggish and I was eventually forced to pull
power from my odroid. I only have 4 cores enabled, otherwise the usb
issues increase.
I cobbled together a setup with my ATX power supply providing power to
everything (including usb devices and hubs).
*****
Apr 27 10:27:39 computername kernel: [<c041fc38>]
(s3c64xx_serial_handle_irq) from [<c016da24>]
(__handle_irq_event_percpu+0x50/0x11c)
Apr 27 10:28:42 computername systemd-journald[22668]: Missed 5173
kernel messages
Apr 27 10:28:42 computername kernel: CPU: 0 PID: 99 Comm: mmcqd/1
Tainted: G      D W       4.14.0-dirty #6
Apr 27 10:28:42 computername kernel: Hardware name: SAMSUNG EXYNOS
(Flattened Device Tree)
Apr 27 10:28:42 computername kernel: [<c010f428>] (unwind_backtrace)
from [<c010ba74>] (show_stack+0x10/0x14)
Apr 27 10:28:42 computername kernel: [<c010ba74>] (show_stack) from
[<c0731e9c>] (dump_stack+0x88/0x9c)
Apr 27 10:28:42 computername kernel: [<c0731e9c>] (dump_stack) from
[<c011cab8>] (__warn+0xe8/0x100)
Apr 27 10:28:42 computername kernel: [<c011cab8>] (__warn) from
[<c011cbc8>] (warn_slowpath_null+0x20/0x28)
Apr 27 10:28:42 computername kernel: [<c011cbc8>] (warn_slowpath_null)
from [<c041f814>] (s3c24xx_uart_copy_rx_to_tty+0xa0/0xd4)
Apr 27 10:28:42 computername kernel: [<c041f814>]
(s3c24xx_uart_copy_rx_to_tty) from [<c041fb84>]
(s3c24xx_serial_rx_chars+0x14c/0x1b8)
Apr 27 10:28:42 computername kernel: [<c041fb84>]
(s3c24xx_serial_rx_chars) from [<c041fc38>]
(s3c64xx_serial_handle_irq+0x48/0x60)
Apr 27 10:28:42 computername kernel: [<c041fc38>]
(s3c64xx_serial_handle_irq) from [<c016da24>]
(__handle_irq_event_percpu+0x50/0x11c)
Apr 27 10:28:42 computername kernel: [<c016da24>]
(__handle_irq_event_percpu) from [<c016db1c>]
(handle_irq_event_percpu+0x2c/0x7c)
Apr 27 10:28:42 computername kernel: [<c016db1c>]
(handle_irq_event_percpu) from [<c016dba4>]
(handle_irq_event+0x38/0x5c)
Apr 27 10:28:42 computername kernel: [<c016dba4>] (handle_irq_event)
from [<c0171448>] (handle_fasteoi_irq+0xa4/0x158)
Apr 27 10:28:42 computername kernel: [<c0171448>] (handle_fasteoi_irq)
from [<c016cda0>] (generic_handle_irq+0x24/0x34)
Apr 27 10:28:42 computername kernel: [<c016cda0>] (generic_handle_irq)
from [<c016d2b8>] (__handle_domain_irq+0x5c/0xb4)
Apr 27 10:28:42 computername kernel: [<c016d2b8>]
(__handle_domain_irq) from [<c01014d8>] (gic_handle_irq+0x3c/0x78)
Apr 27 10:28:42 computername kernel: [<c01014d8>] (gic_handle_irq)
from [<c010c78c>] (__irq_svc+0x6c/0x90)
Apr 27 10:28:42 computername kernel: Exception stack(0xede8baf8 to 0xede8bb40)
Apr 27 10:28:42 computername kernel: bae0:
                          ede8bcf4 ede98c80
Apr 27 10:28:42 computername kernel: bb00: 00000000 00000002 a00c0113
eddfec00 ede8bce0 00000000 ee20f904 ede8bd58
Apr 27 10:28:42 computername kernel: bb20: 00000100 c0c02080 c0801550
ede8bb48 c074c7dc c074c7e0 600c0113 ffffffff
Apr 27 10:28:42 computername kernel: [<c010c78c>] (__irq_svc) from
[<c074c7e0>] (_raw_spin_unlock_irqrestore+0x10/0x14)
Apr 27 10:28:42 computername kernel: [<c074c7e0>]
(_raw_spin_unlock_irqrestore) from [<c05aecb0>]
(dw_mci_request_end+0xa8/0xdc)
Apr 27 10:28:42 computername kernel: [<c05aecb0>] (dw_mci_request_end)
from [<c05af000>] (dw_mci_tasklet_func+0x31c/0x3dc)
Apr 27 10:28:42 computername kernel: [<c05af000>]
(dw_mci_tasklet_func) from [<c0121808>] (tasklet_action+0x7c/0x118)
Apr 27 10:28:42 computername kernel: [<c0121808>] (tasklet_action)
from [<c01015f8>] (__do_softirq+0xe0/0x248)
Apr 27 10:28:42 computername kernel: [<c01015f8>] (__do_softirq) from
[<c0121bf8>] (irq_exit+0xd8/0x140)
Apr 27 10:28:42 computername kernel: [<c0121bf8>] (irq_exit) from
[<c016d2bc>] (__handle_domain_irq+0x60/0xb4)
Apr 27 10:28:42 computername kernel: [<c016d2bc>]
(__handle_domain_irq) from [<c01014d8>] (gic_handle_irq+0x3c/0x78)
Apr 27 10:28:42 computername kernel: [<c01014d8>] (gic_handle_irq)
from [<c010c78c>] (__irq_svc+0x6c/0x90)
Apr 27 10:28:42 computername kernel: Exception stack(0xede8bc28 to 0xede8bc70)
Apr 27 10:28:42 computername kernel: bc20:                   ede8bcf4
ede98c80 00000000 00000001 7fffffff ede8bcf4
Apr 27 10:28:42 computername kernel: bc40: ede8a000 00000002 00000000
c0c05448 00000000 ede8bcf0 00000100 ede8bc78
Apr 27 10:28:42 computername kernel: bc60: c074c7ec c074c7f0 600c0013 ffffffff
Apr 27 10:28:42 computername kernel: [<c010c78c>] (__irq_svc) from
[<c074c7f0>] (_raw_spin_unlock_irq+0xc/0x10)
Apr 27 10:28:42 computername kernel: [<c074c7f0>]
(_raw_spin_unlock_irq) from [<c0748324>] (wait_for_common+0xa0/0x168)
Apr 27 10:28:42 computername kernel: [<c0748324>] (wait_for_common)
from [<c05921b0>] (mmc_wait_for_req_done+0x8c/0x110)
Apr 27 10:28:42 computername kernel: [<c05921b0>]
(mmc_wait_for_req_done) from [<c0592e34>] (mmc_wait_for_cmd+0x68/0x9c)
Apr 27 10:28:42 computername kernel: [<c0592e34>] (mmc_wait_for_cmd)
from [<c0598de4>] (__mmc_send_status+0x68/0x98)
Apr 27 10:28:42 computername kernel: [<c0598de4>] (__mmc_send_status)
from [<c05a0fac>] (card_busy_detect+0x64/0x150)
Apr 27 10:28:42 computername kernel: [<c05a0fac>] (card_busy_detect)
from [<c05a2378>] (mmc_blk_err_check+0x180/0x5bc)
Apr 27 10:28:42 computername kernel: [<c05a2378>] (mmc_blk_err_check)
from [<c05929d4>] (mmc_start_areq+0xb0/0x3bc)
Apr 27 10:28:42 computername kernel: [<c05929d4>] (mmc_start_areq)
from [<c05a35f4>] (mmc_blk_issue_rw_rq+0xb8/0x39c)
Apr 27 10:28:42 computername kernel: [<c05a35f4>]
(mmc_blk_issue_rw_rq) from [<c05a3ec0>] (mmc_blk_issue_rq+0x1a4/0x844)
Apr 27 10:28:42 computername kernel: [<c05a3ec0>] (mmc_blk_issue_rq)
from [<c05a4624>] (mmc_queue_thread+0xc4/0x164)
Apr 27 10:28:42 computername kernel: [<c05a4624>] (mmc_queue_thread)
from [<c0139b18>] (kthread+0x14c/0x154)
Apr 27 10:28:42 computername kernel: [<c0139b18>] (kthread) from
[<c0107e50>] (ret_from_fork+0x14/0x24)
Apr 27 10:28:42 computername kernel: ---[ end trace 2f940e396221e98e ]---
Apr 27 10:28:42 computername kernel: samsung-uart 12c20000.serial:
RxData copy to tty layer failed
Apr 27 10:28:42 computername kernel: ------------[ cut here ]------------
Apr 27 10:28:42 computername kernel: WARNING: CPU: 0 PID: 21972 at
drivers/tty/serial/samsung.c:381 s3c24xx_uart_copy_rx_to_tty+0xa0/0xd4
Apr 27 10:28:42 computername kernel: Modules linked in: tun cmac ccm
md5 ppp_deflate ppp_async arc4 ppp_generic slhc ath9k_htc ath9k_common
ath9k_hw ath mac80211 cfg80211 option usb_wwan rfkill hid_logitech_dj
usbserial bridge stp llc nf_log_ipv6 ip6table_filter ip6t_MASQUERADE
n>
Apr 27 10:28:42 computername kernel:  dvb_core videobuf2_v4l2 videodev
videobuf2_core nfsd auth_rpcgss oid_registry nfs_acl lockd grace
sunrpc crypto_user ip_tables x_tables
Apr 27 10:28:42 computername kernel: CPU: 0 PID: 21972 Comm:
kworker/0:1 Tainted: G      D W       4.14.0-dirty #6
Apr 27 10:28:42 computername kernel: Hardware name: SAMSUNG EXYNOS
(Flattened Device Tree)
Apr 27 10:28:42 computername kernel: Workqueue: events dbs_work_handler
Apr 27 10:28:42 computername kernel: [<c010f428>] (unwind_backtrace)
from [<c010ba74>] (show_stack+0x10/0x14)
Apr 27 10:28:42 computername kernel: [<c010ba74>] (show_stack) from
[<c0731e9c>] (dump_stack+0x88/0x9c)
Apr 27 10:28:42 computername kernel: [<c0731e9c>] (dump_stack) from
[<c011cab8>] (__warn+0xe8/0x100)
Apr 27 10:28:42 computername kernel: [<c011cab8>] (__warn) from
[<c011cbc8>] (warn_slowpath_null+0x20/0x28)
Apr 27 10:28:42 computername kernel: [<c011cbc8>] (warn_slowpath_null)
from [<c041f814>] (s3c24xx_uart_copy_rx_to_tty+0xa0/0xd4)
Apr 27 10:28:42 computername kernel: [<c041f814>]
(s3c24xx_uart_copy_rx_to_tty) from [<c041fb84>]
(s3c24xx_serial_rx_chars+0x14c/0x1b8)
Apr 27 10:28:42 computername kernel: [<c041fb84>]
(s3c24xx_serial_rx_chars) from [<c041fc38>]
(s3c64xx_serial_handle_irq+0x48/0x60)
Apr 27 10:28:42 computername kernel: [<c041fc38>]
(s3c64xx_serial_handle_irq) from [<c016da24>]
(__handle_irq_event_percpu+0x50/0x11c)
Apr 27 10:28:42 computername kernel: [<c016da24>]
(__handle_irq_event_percpu) from [<c016db1c>]
(handle_irq_event_percpu+0x2c/0x7c)
Apr 27 10:28:42 computername kernel: [<c016db1c>]
(handle_irq_event_percpu) from [<c016dba4>]
(handle_irq_event+0x38/0x5c)
Apr 27 10:28:42 computername kernel: [<c016dba4>] (handle_irq_event)
from [<c0171448>] (handle_fasteoi_irq+0xa4/0x158)
Apr 27 10:28:42 computername kernel: [<c0171448>] (handle_fasteoi_irq)
from [<c016cda0>] (generic_handle_irq+0x24/0x34)
Apr 27 10:28:42 computername kernel: [<c016cda0>] (generic_handle_irq)
from [<c016d2b8>] (__handle_domain_irq+0x5c/0xb4)
Apr 27 10:28:42 computername kernel: [<c016d2b8>]
(__handle_domain_irq) from [<c01014d8>] (gic_handle_irq+0x3c/0x78)
Apr 27 10:28:42 computername kernel: [<c01014d8>] (gic_handle_irq)
from [<c010c78c>] (__irq_svc+0x6c/0x90)
Apr 27 10:28:42 computername kernel: Exception stack(0xdd101db0 to 0xdd101df8)
Apr 27 10:28:42 computername kernel: 1da0:
        d35fdb77 00000000 c0c055d4 f080e000
Apr 27 10:28:42 computername kernel: 1dc0: c0c85640 036b7fbe 2e241000
00000002 c0c055d4 0000005f fd5c0698 00003172
Apr 27 10:28:42 computername kernel: 1de0: 00000002 dd101e00 c0182644
c05b4e5c 600c0013 ffffffff
Apr 27 10:28:42 computername kernel: [<c010c78c>] (__irq_svc) from
[<c05b4e5c>] (exynos4_frc_read+0x14/0x18)
Apr 27 10:28:42 computername kernel: [<c05b4e5c>] (exynos4_frc_read)
from [<c0182644>] (ktime_get+0x44/0xdc)
Apr 27 10:28:42 computername kernel: [<c0182644>] (ktime_get) from
[<c0190c60>] (get_cpu_idle_time_us+0x48/0x140)
Apr 27 10:28:42 computername kernel: [<c0190c60>]
(get_cpu_idle_time_us) from [<c058a9c4>]
(get_cpu_idle_time+0x48/0x18c)
Apr 27 10:28:42 computername kernel: [<c058a9c4>] (get_cpu_idle_time)
from [<c058e28c>] (dbs_update+0xa8/0x25c)
Apr 27 10:28:42 computername kernel: [<c058e28c>] (dbs_update) from
[<c058da80>] (od_dbs_update+0x48/0x160)
Apr 27 10:28:42 computername kernel: [<c058da80>] (od_dbs_update) from
[<c058e0f4>] (dbs_work_handler+0x2c/0x54)
Apr 27 10:28:42 computername kernel: [<c058e0f4>] (dbs_work_handler)
from [<c0133e6c>] (process_one_work+0x1d8/0x404)
Apr 27 10:28:42 computername kernel: [<c0133e6c>] (process_one_work)
from [<c0134c18>] (worker_thread+0x50/0x598)
Apr 27 10:28:42 computername kernel: [<c0134c18>] (worker_thread) from
[<c0139b18>] (kthread+0x14c/0x154)
Apr 27 10:28:42 computername kernel: [<c0139b18>] (kthread) from
[<c0107e50>] (ret_from_fork+0x14/0x24)
Apr 27 10:28:42 computername kernel: ---[ end trace 2f940e396221e98f ]---
*****
