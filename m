Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E8EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9742172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9742172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390432AbeHGVLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:11:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389242AbeHGVLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:11:39 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6DD03D01;
        Tue,  7 Aug 2018 18:55:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/12] 4.4.147-stable review
Date:   Tue,  7 Aug 2018 20:52:04 +0200
Message-Id: <20180807172343.326201671@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.147-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.147-rc1
X-KernelTest-Deadline: 2018-08-09T17:23+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.147 release.
There are 12 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Aug  9 17:23:34 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.147-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.147-rc1

Shankara Pailoor <shankarapailoor@gmail.com>
    jfs: Fix inconsistency between memory allocation and ea_buf->max_size

Esben Haabendal <eha@deif.com>
    i2c: imx: Fix reinit_completion() use

Masami Hiramatsu <mhiramat@kernel.org>
    ring_buffer: tracing: Inherit the tracing setting to next ring buffer

Vitaly Kuznetsov <vkuznets@redhat.com>
    ACPI / PCI: Bail early in acpi_pci_add_bus() if there is no ACPI handle

Theodore Ts'o <tytso@mit.edu>
    ext4: fix false negatives *and* false positives in ext4_check_descriptors()

Dmitry Safonov <dima@arista.com>
    netlink: Don't shift on 64 for ngroups

Dmitry Safonov <dima@arista.com>
    netlink: Don't shift with UB on nlk->ngroups

Dmitry Safonov <dima@arista.com>
    netlink: Do not subscribe to non-existent groups

Anna-Maria Gleixner <anna-maria@linutronix.de>
    nohz: Fix local_timer_softirq_pending()

Thomas Gleixner <tglx@linutronix.de>
    genirq: Make force irq threading setup more robust

Anil Gurumurthy <anil.gurumurthy@cavium.com>
    scsi: qla2xxx: Return error when TMF returns

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix ISP recovery on unload


-------------

Diffstat:

 Makefile                        |  4 ++--
 drivers/i2c/busses/i2c-imx.c    |  3 +--
 drivers/pci/pci-acpi.c          |  2 +-
 drivers/scsi/qla2xxx/qla_init.c |  7 +++----
 drivers/scsi/qla2xxx/qla_os.c   |  5 +++--
 fs/ext4/super.c                 |  4 ++--
 fs/jfs/xattr.c                  | 10 ++++++----
 include/linux/ring_buffer.h     |  1 +
 kernel/irq/manage.c             |  9 ++++++++-
 kernel/time/tick-sched.c        |  2 +-
 kernel/trace/ring_buffer.c      | 16 ++++++++++++++++
 kernel/trace/trace.c            |  6 ++++++
 net/netlink/af_netlink.c        |  5 +++++
 13 files changed, 55 insertions(+), 19 deletions(-)


