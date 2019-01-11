Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0432183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216096;
	bh=468WIDtLkYHO3ueagV2krwC9Q7H2+gXKRyAXaVSaM+s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mVd2jq8PnklcggJLpqXSE/q9cpz5aIHzjaJjiSP68PP0AGmUZ1co7jam4/mzx5j3z
	 IBVN+Fud6hN22oV+tFPWiWuqVHzOHVjdELrdBT+42O+1k6bzEtitu8j00h0XgV+RN/
	 DJi8e2JKXrrF5koAkdbQAyBBBCqKsw4Tou0MKYN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbfAKOOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbfAKOOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55F920874;
        Fri, 11 Jan 2019 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216092;
        bh=468WIDtLkYHO3ueagV2krwC9Q7H2+gXKRyAXaVSaM+s=;
        h=From:To:Cc:Subject:Date:From;
        b=kKxUeE+1/VBM5qEySiVyr3r09ZENsclpszLIV22kj8O/cqgR5WgKlDtww2RpskpUZ
         kAbwuDvf+5G0bSOPfyt/DRxOPcRQYVLNaX5/aALdgAAJH1aadROX/nSyddIHtX2Bb8
         mAaFATnQUl0nrfoFHYKf3Xop0mrcELU8jkHV52ZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/47] 3.18.132-stable review
Date:   Fri, 11 Jan 2019 15:07:45 +0100
Message-Id: <20190111130956.170952125@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.132-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.132-rc1
X-KernelTest-Deadline: 2019-01-13T13:10+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.132 release.
There are 47 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jan 13 13:09:31 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.132-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.132-rc1

Lubomir Rintel <lkundrak@v3.sk>
    power: supply: olpc_battery: correct the temperature units

Christian Borntraeger <borntraeger@de.ibm.com>
    genwqe: Fix size check

Yan, Zheng <zyan@redhat.com>
    ceph: don't update importing cap's mseq when handing cap export

Dominique Martinet <dominique.martinet@cea.fr>
    9p/net: put a lower bound on msize

Larry Finger <Larry.Finger@lwfinger.net>
    b43: Fix error in cordic routine

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix loop in gfs2_rbm_find

Vasily Averin <vvs@virtuozzo.com>
    dlm: memory leaks on error path in dlm_user_request()

Vasily Averin <vvs@virtuozzo.com>
    dlm: lost put_lkb on error path in receive_convert() and receive_unlock()

Vasily Averin <vvs@virtuozzo.com>
    dlm: possible memory leak on error path in create_lkb()

Vasily Averin <vvs@virtuozzo.com>
    dlm: fixed memory leaks after failed ls_remove_names allocation

Hui Peng <benquike@163.com>
    ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Avoid access before bLength check in build_audio_procunit()

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: cs46xx: Potential NULL dereference in probe

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use SVC_NET() in svcauth_gss_* functions

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: fix cache_head leak due to queued request

David Herrmann <dh.herrmann@gmail.com>
    fork: record start_time late

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix posting too many status read buffers leading to adapter shutdown

Georgy A Bystrenin <gkot@altlinux.org>
    CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock problem

Huacai Chen <chenhc@lemote.com>
    MIPS: Align kernel load address to 64KB

Huacai Chen <chenhc@lemote.com>
    MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: free bitmap_cap when updating std/timings/etc.

Macpaul Lin <macpaul.lin@mediatek.com>
    cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Theodore Ts'o <tytso@mit.edu>
    ext4: force inode writes when nfsd calls commit_metadata()

Maurizio Lombardi <mlombard@redhat.com>
    ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Pan Bian <bianpan2016@163.com>
    ext4: fix possible use after free in ext4_quota_enable

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()

Scott Chen <scott@labau.com.tw>
    USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Deepa Dinamani <deepa.kernel@gmail.com>
    sock: Make sock->sk_stamp thread-safe

Juergen Gross <jgross@suse.com>
    xen/netfront: tolerate frags with no data

Jorgen Hansen <jhansen@vmware.com>
    VSOCK: Send reset control packet when socket is partially bound

Jason Wang <jasowang@redhat.com>
    vhost: make sure used idx is seen before log in vhost_add_used_n()

Xin Long <lucien.xin@gmail.com>
    sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Willem de Bruijn <willemb@google.com>
    packet: validate address length if non-zero

Willem de Bruijn <willemb@google.com>
    packet: validate address length

Cong Wang <xiyou.wangcong@gmail.com>
    netrom: fix locking in nr_find_socket()

Eric Dumazet <edumazet@google.com>
    isdn: fix kernel-infoleak in capi_unlocked_ioctl

Cong Wang <xiyou.wangcong@gmail.com>
    ipv6: explicitly initialize udp6_addr in udp_sock_create6()

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Cong Wang <xiyou.wangcong@gmail.com>
    ax25: fix a use-after-free in ax25_fillin_cb()

Colin Ian King <colin.king@canonical.com>
    x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels

Christophe Leroy <christophe.leroy@c-s.fr>
    gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Russell King <rmk+kernel@armlinux.org.uk>
    mmc: omap_hsmmc: fix DMA API warning

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Reset HPI enabled state during re-init and in case of errors

Tore Anderson <tore@fud.no>
    USB: serial: option: add HP lt4132

Hui Peng <benquike@gmail.com>
    USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |  7 ++-
 arch/mips/include/asm/pgtable-64.h                 |  5 ++
 arch/x86/include/asm/kvm_host.h                    |  2 +-
 arch/x86/kernel/cpu/mtrr/if.c                      |  2 +
 drivers/gpio/gpio-max7301.c                        | 12 +---
 drivers/hv/vmbus_drv.c                             | 20 +++++++
 drivers/isdn/capi/kcapi.c                          |  4 +-
 drivers/media/platform/vivid/vivid-vid-cap.c       |  2 +
 drivers/misc/genwqe/card_utils.c                   |  2 +-
 drivers/mmc/core/mmc.c                             |  4 +-
 drivers/mmc/host/omap_hsmmc.c                      | 12 +++-
 drivers/net/ethernet/ibm/ibmveth.c                 |  6 +-
 drivers/net/usb/hso.c                              | 18 +++++-
 drivers/net/wireless/b43/phy_common.c              |  2 +-
 drivers/net/xen-netfront.c                         |  2 +-
 drivers/power/olpc_battery.c                       |  4 +-
 drivers/s390/scsi/zfcp_aux.c                       |  6 +-
 drivers/usb/class/cdc-acm.c                        | 10 ++++
 drivers/usb/class/cdc-acm.h                        |  1 +
 drivers/usb/host/r8a66597-hcd.c                    |  5 +-
 drivers/usb/serial/option.c                        |  7 ++-
 drivers/usb/serial/pl2303.c                        |  5 ++
 drivers/usb/serial/pl2303.h                        |  5 ++
 drivers/vhost/vhost.c                              |  2 +
 fs/ceph/caps.c                                     |  1 -
 fs/cifs/smb2maperror.c                             |  4 +-
 fs/dlm/lock.c                                      | 17 +++---
 fs/dlm/lockspace.c                                 |  2 +-
 fs/ext4/inline.c                                   |  5 +-
 fs/ext4/super.c                                    | 13 ++++-
 fs/gfs2/rgrp.c                                     |  2 +-
 include/net/sock.h                                 | 36 +++++++++++-
 include/trace/events/ext4.h                        | 20 +++++++
 kernel/fork.c                                      | 13 ++++-
 net/9p/client.c                                    | 21 +++++++
 net/ax25/af_ax25.c                                 | 11 +++-
 net/ax25/ax25_dev.c                                |  2 +
 net/compat.c                                       | 15 +++--
 net/core/sock.c                                    |  3 +
 net/ipv6/ip6_udp_tunnel.c                          |  3 +-
 net/netrom/af_netrom.c                             | 15 +++--
 net/packet/af_packet.c                             |  8 ++-
 net/sctp/ipv6.c                                    |  1 +
 net/sunrpc/auth_gss/svcauth_gss.c                  |  8 +--
 net/sunrpc/cache.c                                 |  9 ++-
 net/sunrpc/svcsock.c                               |  2 +-
 net/vmw_vsock/vmci_transport.c                     | 67 ++++++++++++++++------
 sound/pci/cs46xx/dsp_spos.c                        |  3 +
 sound/usb/mixer.c                                  | 10 +++-
 sound/usb/quirks-table.h                           |  3 +
 51 files changed, 352 insertions(+), 91 deletions(-)


