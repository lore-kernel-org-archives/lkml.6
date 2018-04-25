Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524652429-2-551403411468696998
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652428; b=UopLW1XabZZTZtOFTByiuB5u/Vp0wt4g5HK4LVqGvYbTrz0U6z
    rTxe8dct07uPTMRFgC6lzkPl+3j0/9UgoQO5pmQ3zmzGXx53BEdQPh8oK2Z2VMRR
    CxY3k9lBlUp415uE8Rd+GYkoO+p0NrgWFipqfk6mgyp01KgyJQyY1zUNw1aYWXO0
    63aw6dgrLhJ7BQcZZUEa4gjdvxLvwHFyLdiK2AZw3M9XlJTdvdTfjzpdglVBTO1v
    BGSGrkvvIYewaQQMIlCVyLhlHO3RRiLvjcIOofxpu7zn2d3t8ZWMlW3LEttSxcB/
    iZfBXSTKbBd0UQdfnrvwFTcCeElW9yhImXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524652428; bh=/t8QHNcKxUAQkH4hqcS+ejq58p8X+X
    l5FbLJpg989ug=; b=c4wYL1S5p2atXiZrwM4bZHlY8kBp/rUdQExKBDf6HZ5Rs9
    mbYXZ6ZclcNe8m+aP8aWJLcxvYY3RQ20Mk5Cci2W0QwtXzoiKqDlSLNvb6PuzUS0
    yaxx6Q0/InLUi065NJ1mWgzKSmbD58Oyh8wriNhIpcvXuqIeFc46OLe+sHk0OLWh
    /sVE3Ksic8traJmHPnTx8VGWeDJ6xMQTSXb24j6cVp4R/29KaKAVjmPwEOmFwKZ7
    x61cErF3XtFH80wrzFleUYzElCMr/26eTJZNyQufDfY1WNwB8p8hPqpOl3N65iRD
    fcsWE8tKRZvPOTegAvuizsMBKQdhW0yNQTzehidg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNqjK4MdLNBraHS1ZkTPS5HaOQjfFoe5fVVBmaB7E6vikqpgSu2Ao0c5kzXaZtPNzHZwdKg9+JFGG8vo8gF8nRdMlVqnYHD84Llh1VvAxFA62eP/pMob
    cGSYSaZ8C4KmKjyUazhNzHw0X5NfTUvP/uGOHQ/woT0GWolQH7CpDfLHaWPyqVFVrgEIXzPqSNGPTcezrfWv2hiTcn1/pbDyWdXqS+RWB3TMcs4nlB09163t
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=hoiGki7t42oA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8
    a=Byx-y9mGAAAA:8 a=20KFwNOVAAAA:8 a=t9ty7G3lAAAA:8 a=pGLkceISAAAA:8
    a=8AirrxEcAAAA:8 a=omOdbC7AAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=UPvqJ9jr5LbUdpece-YA:9 a=77_4FxxcPfNtDkuL:21 a=T9_AHhr_c21Z6WhY:21
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=1qrBK16LubpBFNPVNq2M:22
    a=CsAS6f0m0zARWR-uHzm3:22 a=ST-jHhOKWsTCqRlWije3:22 a=baC4JDFNLZpnPwus_NF9:22
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeDYKdp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:33:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeDYKdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:33:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/26] 4.16.5-stable review
Date: Wed, 25 Apr 2018 12:33:09 +0200
Message-Id: <20180425103314.842517924@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.5-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.5-rc1
X-KernelTest-Deadline: 2018-04-27T10:33+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.5 release.
There are 26 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Apr 27 10:33:04 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.5-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.5-rc1

Sean Christopherson <sean.j.christopherson@intel.com>
    Revert "KVM: X86: Fix SMRAM accessing even if VM is shutdown"

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix NULL dereference while accessing XRC_TGT QPs

Jiri Olsa <jolsa@kernel.org>
    perf: Return proper values for user stack errors

Jiri Olsa <jolsa@kernel.org>
    perf: Fix sample_max_stack maximum check

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: limit allocation requests for blob rule heads

Florian Westphal <fw@strlen.de>
    netfilter: compat: reject huge allocation requests

Florian Westphal <fw@strlen.de>
    netfilter: compat: prepare xt_compat_init_offsets to return errors

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: add counters allocation wrapper

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: cap allocations at 512 mbyte

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm,vmscan: Allow preallocating memory for register_shrinker().

Thomas Gleixner <tglx@linutronix.de>
    alarmtimer: Init nanosleep alarm timer on stack

Imre Deak <imre.deak@intel.com>
    drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state

Xidong Wang <wangxidong_97@163.com>
    drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value

Gaurav K Singh <gaurav.k.singh@intel.com>
    drm/i915/audio: Fix audio detection issue on GLK

Jani Nikula <jani.nikula@intel.com>
    drm/i915/bios: filter out invalid DDC pins from VBT child devices

Tina Zhang <tina.zhang@intel.com>
    drm/i915/gvt: Add drm_format_mod update

Gerd Hoffmann <kraxel@redhat.com>
    drm/i915/gvt: throw error on unhandled vfio ioctls

Daniel J Blueman <daniel@quora.org>
    drm/vc4: Fix memory leak during BO teardown

Xiaoming Gao <gxm.linux.kernel@gmail.com>
    x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Laura Abbott <labbott@redhat.com>
    posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated

Anson Huang <Anson.Huang@nxp.com>
    clocksource/imx-tpm: Correct -ETIME return condition check

Dou Liyang <douly.fnst@cn.fujitsu.com>
    x86/acpi: Prevent X2APIC id 0xffffffff from being accounted

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix race condition between delayed refs and blockgroup removal

David Sterba <dsterba@suse.com>
    btrfs: fix unaligned access in readdir

Steve French <smfrench@gmail.com>
    cifs: do not allow creating sockets except with SMB1 posix exensions

Long Li <longli@microsoft.com>
    cifs: smbd: Check for iov length on sending the last iov


-------------

Diffstat:

 Makefile                                   |  4 +--
 arch/x86/kernel/acpi/boot.c                |  4 +++
 arch/x86/kernel/tsc.c                      |  2 +-
 arch/x86/kvm/mmu.c                         |  2 +-
 drivers/clocksource/timer-imx-tpm.c        |  2 +-
 drivers/gpu/drm/drm_dp_dual_mode_helper.c  | 39 +++++++++++++++++++----
 drivers/gpu/drm/i915/gvt/dmabuf.c          |  1 +
 drivers/gpu/drm/i915/gvt/kvmgt.c           |  2 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |  2 +-
 drivers/gpu/drm/i915/intel_audio.c         |  2 +-
 drivers/gpu/drm/i915/intel_bios.c          | 13 +++++---
 drivers/gpu/drm/vc4/vc4_bo.c               |  2 ++
 drivers/gpu/drm/vc4/vc4_validate_shaders.c |  1 +
 drivers/infiniband/hw/mlx5/qp.c            |  3 +-
 fs/btrfs/delayed-ref.c                     | 19 ++++++++---
 fs/btrfs/delayed-ref.h                     |  1 +
 fs/btrfs/extent-tree.c                     | 16 +++++++---
 fs/btrfs/inode.c                           | 20 +++++++-----
 fs/cifs/dir.c                              |  9 +++---
 fs/cifs/smbdirect.c                        |  2 ++
 fs/super.c                                 |  9 +++---
 include/linux/netfilter/x_tables.h         |  3 +-
 include/linux/shrinker.h                   |  7 ++--
 kernel/events/callchain.c                  | 21 ++++++------
 kernel/events/core.c                       |  4 +--
 kernel/time/alarmtimer.c                   | 34 +++++++++++++++-----
 kernel/time/posix-cpu-timers.c             |  4 ++-
 mm/vmscan.c                                | 21 +++++++++++-
 net/bridge/netfilter/ebtables.c            | 10 ++++--
 net/ipv4/netfilter/arp_tables.c            | 12 ++++---
 net/ipv4/netfilter/ip_tables.c             | 10 ++++--
 net/ipv6/netfilter/ip6_tables.c            | 12 ++++---
 net/netfilter/x_tables.c                   | 51 ++++++++++++++++++++++++------
 33 files changed, 250 insertions(+), 94 deletions(-)
