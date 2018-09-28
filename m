Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480A2C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B9E2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B9E2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeI2ETq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:19:46 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:54243 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbeI2ETp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:19:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id AF678181D3368;
        Fri, 28 Sep 2018 21:54:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: air15_5d3ed38c9f03d
X-Filterd-Recvd-Size: 35951
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:54:00 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Jones <davej@redhat.com>
Subject: Bad MAINTAINERS pattern in section 'KEYS/KEYRINGS:'
Date:   Fri, 28 Sep 2018 14:53:59 -0700
Message-Id: <20180928215359.29678-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	8087	KEYS/KEYRINGS:
	8088	M:	David Howells <dhowells@redhat.com>
	8089	L:	keyrings@vger.kernel.org
	8090	S:	Maintained
	8091	F:	Documentation/security/keys/core.rst
	8092	F:	include/linux/key.h
	8093	F:	include/linux/key-type.h
-->	8094	F:	include/linux/keyctl.h
	8095	F:	include/uapi/linux/keyctl.h
	8096	F:	include/keys/
	8097	F:	security/keys/

Commit that introduced this:

commit 7683e9e529258d01ce99216ad3be21f59eff83ec
 Author: Linus Torvalds <torvalds@linux-foundation.org>
 Date:   Sun Jul 23 16:06:21 2017 -0700
 
     Properly alphabetize MAINTAINERS file
     
     This adds a perl script to actually parse the MAINTAINERS file, clean up
     some whitespace in it, warn about errors in it, and then properly sort
     the end result.
     
     My perl-fu is atrocious, so the script has basically been created by
     randomly putting various characters in a pile, mixing them around, and
     then looking it the end result does anything interesting when used as a
     perl script.
     
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
 
  MAINTAINERS                  | 3585 +++++++++++++++++++++---------------------
  scripts/parse-maintainers.pl |   77 +
  2 files changed, 1868 insertions(+), 1794 deletions(-)

Last commit with include/linux/keyctl.h

commit 607ca46e97a1b6594b29647d98a32d545c24bdff
Author: David Howells <dhowells@redhat.com>
Date:   Sat Oct 13 10:46:48 2012 +0100

    UAPI: (Scripted) Disintegrate include/linux
    
    Signed-off-by: David Howells <dhowells@redhat.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>
    Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>
    Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Acked-by: Dave Jones <davej@redhat.com>

 include/linux/Kbuild                          |  379 -----
 include/linux/a.out.h                         |  196 +--
 include/linux/acct.h                          |  108 +-
 include/linux/adb.h                           |   39 +-
 include/linux/adfs_fs.h                       |   42 +-
 include/linux/agpgart.h                       |   86 +-
 include/linux/apm_bios.h                      |  125 +-
 include/linux/atalk.h                         |   43 +-
 include/linux/atm.h                           |  238 +--
 include/linux/atm_tcp.h                       |   54 +-
 include/linux/atmdev.h                        |  213 +--
 include/linux/audit.h                         |  381 +----
 include/linux/auto_fs.h                       |   68 +-
 include/linux/auxvec.h                        |   33 +-
 include/linux/binfmts.h                       |   19 +-
 include/linux/blktrace_api.h                  |  142 +-
 include/linux/bsg.h                           |   63 +-
 include/linux/capability.h                    |  346 +----
 include/linux/cciss_ioctl.h                   |   86 +-
 include/linux/cdrom.h                         |  902 +----------
 include/linux/cm4000_cs.h                     |   60 +-
 include/linux/cn_proc.h                       |  103 +-
 include/linux/coda.h                          |  680 +--------
 include/linux/coda_psdev.h                    |   26 +-
 include/linux/connector.h                     |   56 +-
 include/linux/cramfs_fs.h                     |   86 +-
 include/linux/cuda.h                          |   25 +-
 include/linux/cyclades.h                      |  426 +-----
 include/linux/dccp.h                          |  236 +--
 include/linux/dlm.h                           |   62 +-
 include/linux/dlm_plock.h                     |   37 +-
 include/linux/edd.h                           |  158 +-
 include/linux/elf.h                           |  414 +----
 include/linux/elfcore.h                       |  102 +-
 include/linux/errno.h                         |    5 +-
 include/linux/errqueue.h                      |   25 +-
 include/linux/ethtool.h                       | 1076 +------------
 include/linux/eventpoll.h                     |   53 +-
 include/linux/falloc.h                        |    7 +-
 include/linux/fanotify.h                      |  114 +-
 include/linux/fb.h                            |  403 +----
 include/linux/fcntl.h                         |   50 +-
 include/linux/fd.h                            |  380 +----
 include/linux/filter.h                        |  133 +-
 include/linux/flat.h                          |   50 +-
 include/linux/fs.h                            |  333 +----
 include/linux/fsl_hypervisor.h                |  180 +--
 include/linux/futex.h                         |  150 +-
 include/linux/gameport.h                      |   26 +-
 include/linux/genetlink.h                     |   82 +-
 include/linux/hdlc.h                          |   13 +-
 include/linux/hdlcdrv.h                       |  104 +-
 include/linux/hid.h                           |   46 +-
 include/linux/hiddev.h                        |  190 +--
 include/linux/hidraw.h                        |   40 +-
 include/linux/hpet.h                          |   23 +-
 include/linux/i2c-dev.h                       |   49 +-
 include/linux/i2c.h                           |  125 +-
 include/linux/icmp.h                          |   80 +-
 include/linux/icmpv6.h                        |  165 +-
 include/linux/if_arp.h                        |  136 +-
 include/linux/if_bridge.h                     |   89 +-
 include/linux/if_eql.h                        |   36 +-
 include/linux/if_ether.h                      |  115 +-
 include/linux/if_fddi.h                       |   80 +-
 include/linux/if_frad.h                       |   98 +-
 include/linux/if_link.h                       |  427 +-----
 include/linux/if_ltalk.h                      |    7 +-
 include/linux/if_phonet.h                     |    7 +-
 include/linux/if_pppol2tp.h                   |   89 +-
 include/linux/if_pppox.h                      |  143 +-
 include/linux/if_team.h                       |   97 +-
 include/linux/if_tun.h                        |   78 +-
 include/linux/if_tunnel.h                     |   94 +-
 include/linux/if_vlan.h                       |   51 +-
 include/linux/igmp.h                          |  113 +-
 include/linux/in.h                            |  235 +--
 include/linux/in6.h                           |  258 +---
 include/linux/inet_diag.h                     |  134 +-
 include/linux/inotify.h                       |   69 +-
 include/linux/input.h                         | 1151 +-------------
 include/linux/ip.h                            |  119 +-
 include/linux/ipc.h                           |   80 +-
 include/linux/ipmi.h                          |  422 +-----
 include/linux/ipv6.h                          |  166 +-
 include/linux/ipv6_route.h                    |   45 +-
 include/linux/irqnr.h                         |    8 +-
 include/linux/isdn.h                          |  130 +-
 include/linux/isdn_divertif.h                 |   18 +-
 include/linux/isdn_ppp.h                      |   55 +-
 include/linux/isdnif.h                        |   43 +-
 include/linux/joystick.h                      |  114 +-
 include/linux/kd.h                            |  181 +--
 include/linux/kdev_t.h                        |   14 +-
 include/linux/kernel-page-flags.h             |   34 +-
 include/linux/kernel.h                        |   12 +-
 include/linux/kernelcapi.h                    |   38 +-
 include/linux/kexec.h                         |   52 +-
 include/linux/keyboard.h                      |  441 +-----
 include/linux/kvm_para.h                      |   26 +-
 include/linux/l2tp.h                          |  172 +--
 include/linux/llc.h                           |   74 +-
 include/linux/loop.h                          |   91 +-
 include/linux/lp.h                            |   97 +-
 include/linux/mdio.h                          |  287 +---
 include/linux/mempolicy.h                     |   63 +-
 include/linux/mii.h                           |  154 +-
 include/linux/mman.h                          |   12 +-
 include/linux/mroute.h                        |  146 +-
 include/linux/mroute6.h                       |  138 +-
 include/linux/msdos_fs.h                      |  165 +-
 include/linux/msg.h                           |   74 +-
 include/linux/n_r3964.h                       |   56 +-
 include/linux/nbd.h                           |   63 +-
 include/linux/net.h                           |   39 +-
 include/linux/netdevice.h                     |   32 +-
 include/linux/netfilter.h                     |   72 +-
 include/linux/netfilter_bridge.h              |   27 +-
 include/linux/netfilter_ipv4.h                |   80 +-
 include/linux/netfilter_ipv6.h                |   75 +-
 include/linux/netlink.h                       |  152 +-
 include/linux/nfs.h                           |  124 +-
 include/linux/nfs3.h                          |   92 +-
 include/linux/nfs4.h                          |  166 +-
 include/linux/nfs_fs.h                        |   54 +-
 include/linux/nfs_idmap.h                     |   28 +-
 include/linux/nfsacl.h                        |   23 +-
 include/linux/nubus.h                         |  234 +--
 include/linux/nvram.h                         |   14 +-
 include/linux/omapfb.h                        |  198 +--
 include/linux/oom.h                           |   10 +-
 include/linux/parport.h                       |   89 +-
 include/linux/patchkey.h                      |   24 +-
 include/linux/pci.h                           |   25 +-
 include/linux/perf_event.h                    |  600 +-------
 include/linux/personality.h                   |   71 +-
 include/linux/phonet.h                        |  162 +-
 include/linux/pktcdvd.h                       |   99 +-
 include/linux/pmu.h                           |  130 +-
 include/linux/poll.h                          |    6 +-
 include/linux/ppp-comp.h                      |   86 +-
 include/linux/ppp_defs.h                      |  141 +-
 include/linux/ptrace.h                        |   88 +-
 include/linux/quota.h                         |  139 +-
 include/linux/random.h                        |   43 +-
 include/linux/reboot.h                        |   38 +-
 include/linux/resource.h                      |   78 +-
 include/linux/rfkill.h                        |   92 +-
 include/linux/rtc.h                           |   96 +-
 include/linux/rtnetlink.h                     |  611 +-------
 include/linux/scc.h                           |  169 +--
 include/linux/sched.h                         |   44 +-
 include/linux/screen_info.h                   |   72 +-
 include/linux/sdla.h                          |   93 +-
 include/linux/seccomp.h                       |   45 +-
 include/linux/securebits.h                    |   51 +-
 include/linux/sem.h                           |   79 +-
 include/linux/serial.h                        |  119 +-
 include/linux/serial_core.h                   |  199 +--
 include/linux/serio.h                         |   76 +-
 include/linux/shm.h                           |   81 +-
 include/linux/signal.h                        |    7 +-
 include/linux/signalfd.h                      |   44 +-
 include/linux/sock_diag.h                     |   24 +-
 include/linux/socket.h                        |   20 +-
 include/linux/sonet.h                         |   58 +-
 include/linux/sonypi.h                        |  110 +-
 include/linux/sound.h                         |   29 +-
 include/linux/soundcard.h                     | 1261 +---------------
 include/linux/stat.h                          |   46 +-
 include/linux/stddef.h                        |    5 +-
 include/linux/string.h                        |    7 +-
 include/linux/swab.h                          |  280 +---
 include/linux/synclink.h                      |  288 +---
 include/linux/sysctl.h                        |  911 +----------
 include/linux/tcp.h                           |  208 +--
 include/linux/time.h                          |   72 +-
 include/linux/timex.h                         |  113 +-
 include/linux/toshiba.h                       |   17 +-
 include/linux/tty.h                           |   37 +-
 include/linux/types.h                         |   50 +-
 include/linux/udp.h                           |   22 +-
 include/linux/uinput.h                        |  109 +-
 include/linux/uio.h                           |   24 +-
 include/linux/usbdevice_fs.h                  |  151 +-
 include/linux/utsname.h                       |   33 +-
 include/linux/uuid.h                          |   37 +-
 include/linux/vfio.h                          |  357 +----
 include/linux/videodev2.h                     | 1940 +-----------------------
 include/linux/virtio_config.h                 |   53 +-
 include/linux/virtio_console.h                |   45 +-
 include/linux/virtio_ring.h                   |  163 +-
 include/linux/vt.h                            |   88 +-
 include/linux/wait.h                          |   20 +-
 include/linux/wanrouter.h                     |  405 +----
 include/linux/watchdog.h                      |   49 +-
 include/linux/wireless.h                      | 1120 +-------------
 include/linux/xattr.h                         |   54 +-
 include/uapi/linux/Kbuild                     |  393 +++++
 include/uapi/linux/a.out.h                    |  274 ++++
 include/uapi/linux/acct.h                     |  122 ++
 include/uapi/linux/adb.h                      |   44 +
 include/uapi/linux/adfs_fs.h                  |   44 +
 include/{ => uapi}/linux/affs_hardblocks.h    |    0
 include/uapi/linux/agpgart.h                  |  113 ++
 include/{ => uapi}/linux/aio_abi.h            |    0
 include/uapi/linux/apm_bios.h                 |  135 ++
 include/{ => uapi}/linux/arcfb.h              |    0
 include/uapi/linux/atalk.h                    |   44 +
 include/uapi/linux/atm.h                      |  241 +++
 include/{ => uapi}/linux/atm_eni.h            |    0
 include/{ => uapi}/linux/atm_he.h             |    0
 include/{ => uapi}/linux/atm_idt77105.h       |    0
 include/{ => uapi}/linux/atm_nicstar.h        |    0
 include/uapi/linux/atm_tcp.h                  |   61 +
 include/{ => uapi}/linux/atm_zatm.h           |    0
 include/{ => uapi}/linux/atmapi.h             |    0
 include/{ => uapi}/linux/atmarp.h             |    0
 include/{ => uapi}/linux/atmbr2684.h          |    0
 include/{ => uapi}/linux/atmclip.h            |    0
 include/uapi/linux/atmdev.h                   |  215 +++
 include/{ => uapi}/linux/atmioc.h             |    0
 include/{ => uapi}/linux/atmlec.h             |    0
 include/{ => uapi}/linux/atmmpc.h             |    0
 include/{ => uapi}/linux/atmppp.h             |    0
 include/{ => uapi}/linux/atmsap.h             |    0
 include/{ => uapi}/linux/atmsvc.h             |    0
 include/uapi/linux/audit.h                    |  404 +++++
 include/uapi/linux/auto_fs.h                  |   83 +
 include/{ => uapi}/linux/auto_fs4.h           |    0
 include/uapi/linux/auxvec.h                   |   35 +
 include/{ => uapi}/linux/ax25.h               |    0
 include/{ => uapi}/linux/b1lli.h              |    0
 include/{ => uapi}/linux/baycom.h             |    0
 include/{ => uapi}/linux/bfs_fs.h             |    0
 include/uapi/linux/binfmts.h                  |   20 +
 include/{ => uapi}/linux/blkpg.h              |    0
 include/uapi/linux/blktrace_api.h             |  142 ++
 include/{ => uapi}/linux/bpqether.h           |    0
 include/uapi/linux/bsg.h                      |   65 +
 include/{ => uapi}/linux/can.h                |    0
 include/uapi/linux/capability.h               |  358 +++++
 include/{ => uapi}/linux/capi.h               |    0
 include/{ => uapi}/linux/cciss_defs.h         |    0
 include/uapi/linux/cciss_ioctl.h              |   88 ++
 include/uapi/linux/cdrom.h                    |  912 +++++++++++
 include/{ => uapi}/linux/cgroupstats.h        |    0
 include/{ => uapi}/linux/chio.h               |    0
 include/uapi/linux/cm4000_cs.h                |   62 +
 include/uapi/linux/cn_proc.h                  |  121 ++
 include/uapi/linux/coda.h                     |  741 +++++++++
 include/uapi/linux/coda_psdev.h               |   27 +
 include/{ => uapi}/linux/coff.h               |    0
 include/uapi/linux/connector.h                |   77 +
 include/{ => uapi}/linux/const.h              |    0
 include/uapi/linux/cramfs_fs.h                |   88 ++
 include/uapi/linux/cuda.h                     |   33 +
 include/uapi/linux/cyclades.h                 |  493 ++++++
 include/{ => uapi}/linux/cycx_cfm.h           |    0
 include/{ => uapi}/linux/dcbnl.h              |    0
 include/uapi/linux/dccp.h                     |  237 +++
 include/uapi/linux/dlm.h                      |   75 +
 include/{ => uapi}/linux/dlm_device.h         |    0
 include/{ => uapi}/linux/dlm_netlink.h        |    0
 include/uapi/linux/dlm_plock.h                |   45 +
 include/{ => uapi}/linux/dlmconstants.h       |    0
 include/{ => uapi}/linux/dm-ioctl.h           |    0
 include/{ => uapi}/linux/dm-log-userspace.h   |    0
 include/{ => uapi}/linux/dn.h                 |    0
 include/{ => uapi}/linux/dqblk_xfs.h          |    0
 include/uapi/linux/edd.h                      |  191 +++
 include/{ => uapi}/linux/efs_fs_sb.h          |    0
 include/{ => uapi}/linux/elf-em.h             |    0
 include/{ => uapi}/linux/elf-fdpic.h          |    2 +-
 include/uapi/linux/elf.h                      |  414 +++++
 include/uapi/linux/elfcore.h                  |  100 ++
 include/uapi/linux/errno.h                    |    1 +
 include/uapi/linux/errqueue.h                 |   26 +
 include/uapi/linux/ethtool.h                  | 1085 ++++++++++++++
 include/uapi/linux/eventpoll.h                |   66 +
 include/{ => uapi}/linux/fadvise.h            |    0
 include/uapi/linux/falloc.h                   |    9 +
 include/uapi/linux/fanotify.h                 |  116 ++
 include/uapi/linux/fb.h                       |  402 +++++
 include/uapi/linux/fcntl.h                    |   52 +
 include/uapi/linux/fd.h                       |  382 +++++
 include/{ => uapi}/linux/fdreg.h              |    0
 include/{ => uapi}/linux/fib_rules.h          |    0
 include/{ => uapi}/linux/fiemap.h             |    0
 include/uapi/linux/filter.h                   |  135 ++
 include/{ => uapi}/linux/firewire-cdev.h      |    0
 include/{ => uapi}/linux/firewire-constants.h |    0
 include/uapi/linux/flat.h                     |   58 +
 include/uapi/linux/fs.h                       |  334 +++++
 include/uapi/linux/fsl_hypervisor.h           |  220 +++
 include/{ => uapi}/linux/fuse.h               |    0
 include/uapi/linux/futex.h                    |  152 ++
 include/uapi/linux/gameport.h                 |   28 +
 include/{ => uapi}/linux/gen_stats.h          |    0
 include/uapi/linux/genetlink.h                |   84 ++
 include/{ => uapi}/linux/gfs2_ondisk.h        |    0
 include/{ => uapi}/linux/gigaset_dev.h        |    0
 include/uapi/linux/hdlc.h                     |   23 +
 include/uapi/linux/hdlcdrv.h                  |  110 ++
 include/{ => uapi}/linux/hdreg.h              |    0
 include/uapi/linux/hid.h                      |   66 +
 include/uapi/linux/hiddev.h                   |  212 +++
 include/uapi/linux/hidraw.h                   |   50 +
 include/uapi/linux/hpet.h                     |   25 +
 include/{ => uapi}/linux/hysdn_if.h           |    0
 include/uapi/linux/i2c-dev.h                  |   72 +
 include/uapi/linux/i2c.h                      |  151 ++
 include/{ => uapi}/linux/i2o-dev.h            |    0
 include/{ => uapi}/linux/i8k.h                |    0
 include/uapi/linux/icmp.h                     |   97 ++
 include/uapi/linux/icmpv6.h                   |  164 ++
 include/{ => uapi}/linux/if.h                 |    0
 include/{ => uapi}/linux/if_addr.h            |    0
 include/{ => uapi}/linux/if_addrlabel.h       |    0
 include/{ => uapi}/linux/if_alg.h             |    0
 include/{ => uapi}/linux/if_arcnet.h          |    0
 include/uapi/linux/if_arp.h                   |  159 ++
 include/{ => uapi}/linux/if_bonding.h         |    0
 include/uapi/linux/if_bridge.h                |  101 ++
 include/{ => uapi}/linux/if_cablemodem.h      |    0
 include/uapi/linux/if_eql.h                   |   54 +
 include/uapi/linux/if_ether.h                 |  135 ++
 include/{ => uapi}/linux/if_fc.h              |    0
 include/uapi/linux/if_fddi.h                  |  104 ++
 include/uapi/linux/if_frad.h                  |  122 ++
 include/{ => uapi}/linux/if_hippi.h           |    0
 include/{ => uapi}/linux/if_infiniband.h      |    0
 include/uapi/linux/if_link.h                  |  429 ++++++
 include/uapi/linux/if_ltalk.h                 |    9 +
 include/{ => uapi}/linux/if_packet.h          |    0
 include/uapi/linux/if_phonet.h                |   16 +
 include/{ => uapi}/linux/if_plip.h            |    0
 include/{ => uapi}/linux/if_ppp.h             |    0
 include/uapi/linux/if_pppol2tp.h              |  104 ++
 include/uapi/linux/if_pppox.h                 |  156 ++
 include/{ => uapi}/linux/if_slip.h            |    0
 include/uapi/linux/if_team.h                  |  107 ++
 include/uapi/linux/if_tun.h                   |   94 ++
 include/uapi/linux/if_tunnel.h                |   96 ++
 include/uapi/linux/if_vlan.h                  |   63 +
 include/{ => uapi}/linux/if_x25.h             |    0
 include/uapi/linux/igmp.h                     |  128 ++
 include/uapi/linux/in.h                       |  253 ++++
 include/uapi/linux/in6.h                      |  279 ++++
 include/{ => uapi}/linux/in_route.h           |    0
 include/uapi/linux/inet_diag.h                |  136 ++
 include/uapi/linux/inotify.h                  |   74 +
 include/uapi/linux/input.h                    | 1153 ++++++++++++++
 include/{ => uapi}/linux/ioctl.h              |    0
 include/uapi/linux/ip.h                       |  136 ++
 include/{ => uapi}/linux/ip6_tunnel.h         |    0
 include/{ => uapi}/linux/ip_vs.h              |    0
 include/uapi/linux/ipc.h                      |   81 +
 include/uapi/linux/ipmi.h                     |  456 ++++++
 include/{ => uapi}/linux/ipmi_msgdefs.h       |    0
 include/{ => uapi}/linux/ipsec.h              |    0
 include/uapi/linux/ipv6.h                     |  164 ++
 include/uapi/linux/ipv6_route.h               |   58 +
 include/{ => uapi}/linux/ipx.h                |    0
 include/{ => uapi}/linux/irda.h               |    0
 include/uapi/linux/irqnr.h                    |    0
 include/uapi/linux/isdn.h                     |  143 ++
 include/uapi/linux/isdn_divertif.h            |   30 +
 include/uapi/linux/isdn_ppp.h                 |   67 +
 include/uapi/linux/isdnif.h                   |   56 +
 include/{ => uapi}/linux/iso_fs.h             |    0
 include/{ => uapi}/linux/ivtv.h               |    0
 include/{ => uapi}/linux/ivtvfb.h             |    0
 include/{ => uapi}/linux/ixjuser.h            |    0
 include/{ => uapi}/linux/jffs2.h              |    0
 include/uapi/linux/joystick.h                 |  136 ++
 include/uapi/linux/kd.h                       |  183 +++
 include/uapi/linux/kdev_t.h                   |   13 +
 include/uapi/linux/kernel-page-flags.h        |   36 +
 include/uapi/linux/kernel.h                   |   13 +
 include/uapi/linux/kernelcapi.h               |   47 +
 include/uapi/linux/kexec.h                    |   54 +
 include/uapi/linux/keyboard.h                 |  443 ++++++
 include/{ => uapi}/linux/keyctl.h             |    0
 include/{ => uapi}/linux/kvm.h                |    0
 include/uapi/linux/kvm_para.h                 |   28 +
 include/uapi/linux/l2tp.h                     |  180 +++
 include/{ => uapi}/linux/limits.h             |    0
 include/uapi/linux/llc.h                      |   84 ++
 include/uapi/linux/loop.h                     |   94 ++
 include/uapi/linux/lp.h                       |  100 ++
 include/{ => uapi}/linux/magic.h              |    0
 include/{ => uapi}/linux/major.h              |    0
 include/{ => uapi}/linux/map_to_7segment.h    |    0
 include/{ => uapi}/linux/matroxfb.h           |    0
 include/uapi/linux/mdio.h                     |  297 ++++
 include/{ => uapi}/linux/media.h              |    0
 include/{ => uapi}/linux/mei.h                |    0
 include/uapi/linux/mempolicy.h                |   64 +
 include/{ => uapi}/linux/meye.h               |    0
 include/uapi/linux/mii.h                      |  161 ++
 include/{ => uapi}/linux/minix_fs.h           |    0
 include/uapi/linux/mman.h                     |   13 +
 include/{ => uapi}/linux/mmtimer.h            |    0
 include/{ => uapi}/linux/mqueue.h             |    0
 include/uapi/linux/mroute.h                   |  143 ++
 include/uapi/linux/mroute6.h                  |  137 ++
 include/uapi/linux/msdos_fs.h                 |  167 +++
 include/uapi/linux/msg.h                      |   75 +
 include/{ => uapi}/linux/mtio.h               |    0
 include/uapi/linux/n_r3964.h                  |   98 ++
 include/uapi/linux/nbd.h                      |   77 +
 include/{ => uapi}/linux/ncp.h                |    0
 include/{ => uapi}/linux/ncp_fs.h             |    0
 include/{ => uapi}/linux/ncp_mount.h          |    0
 include/{ => uapi}/linux/ncp_no.h             |    0
 include/{ => uapi}/linux/neighbour.h          |    0
 include/uapi/linux/net.h                      |   57 +
 include/{ => uapi}/linux/net_dropmon.h        |    0
 include/{ => uapi}/linux/net_tstamp.h         |    0
 include/uapi/linux/netdevice.h                |   53 +
 include/uapi/linux/netfilter.h                |   72 +
 include/{ => uapi}/linux/netfilter_arp.h      |    0
 include/uapi/linux/netfilter_bridge.h         |   27 +
 include/{ => uapi}/linux/netfilter_decnet.h   |    0
 include/uapi/linux/netfilter_ipv4.h           |   81 +
 include/uapi/linux/netfilter_ipv6.h           |   79 +
 include/uapi/linux/netlink.h                  |  153 ++
 include/{ => uapi}/linux/netrom.h             |    0
 include/{ => uapi}/linux/nfc.h                |    0
 include/uapi/linux/nfs.h                      |  131 ++
 include/{ => uapi}/linux/nfs2.h               |    0
 include/uapi/linux/nfs3.h                     |   97 ++
 include/uapi/linux/nfs4.h                     |  178 +++
 include/{ => uapi}/linux/nfs4_mount.h         |    0
 include/uapi/linux/nfs_fs.h                   |   61 +
 include/uapi/linux/nfs_idmap.h                |   65 +
 include/{ => uapi}/linux/nfs_mount.h          |    0
 include/uapi/linux/nfsacl.h                   |   29 +
 include/{ => uapi}/linux/nl80211.h            |    0
 include/uapi/linux/nubus.h                    |  244 +++
 include/uapi/linux/nvram.h                    |   16 +
 include/{ => uapi}/linux/omap3isp.h           |    0
 include/uapi/linux/omapfb.h                   |  222 +++
 include/uapi/linux/oom.h                      |   11 +
 include/{ => uapi}/linux/packet_diag.h        |    0
 include/{ => uapi}/linux/param.h              |    0
 include/uapi/linux/parport.h                  |   95 ++
 include/uapi/linux/patchkey.h                 |   37 +
 include/uapi/linux/pci.h                      |   41 +
 include/{ => uapi}/linux/pci_regs.h           |    0
 include/uapi/linux/perf_event.h               |  615 ++++++++
 include/uapi/linux/personality.h              |   69 +
 include/{ => uapi}/linux/pfkeyv2.h            |    0
 include/{ => uapi}/linux/pg.h                 |    0
 include/{ => uapi}/linux/phantom.h            |    0
 include/uapi/linux/phonet.h                   |  185 +++
 include/{ => uapi}/linux/pkt_cls.h            |    0
 include/{ => uapi}/linux/pkt_sched.h          |    0
 include/uapi/linux/pktcdvd.h                  |  111 ++
 include/uapi/linux/pmu.h                      |  139 ++
 include/uapi/linux/poll.h                     |    1 +
 include/{ => uapi}/linux/posix_types.h        |    0
 include/{ => uapi}/linux/ppdev.h              |    0
 include/uapi/linux/ppp-comp.h                 |   93 ++
 include/{ => uapi}/linux/ppp-ioctl.h          |    0
 include/uapi/linux/ppp_defs.h                 |  150 ++
 include/{ => uapi}/linux/pps.h                |    0
 include/{ => uapi}/linux/prctl.h              |    0
 include/{ => uapi}/linux/ptp_clock.h          |    0
 include/uapi/linux/ptrace.h                   |   81 +
 include/{ => uapi}/linux/qnx4_fs.h            |    0
 include/{ => uapi}/linux/qnxtypes.h           |    0
 include/uapi/linux/quota.h                    |  171 +++
 include/{ => uapi}/linux/radeonfb.h           |    0
 include/uapi/linux/random.h                   |   50 +
 include/{ => uapi}/linux/raw.h                |    0
 include/{ => uapi}/linux/rds.h                |    0
 include/uapi/linux/reboot.h                   |   39 +
 include/{ => uapi}/linux/reiserfs_fs.h        |    0
 include/{ => uapi}/linux/reiserfs_xattr.h     |    0
 include/uapi/linux/resource.h                 |   80 +
 include/uapi/linux/rfkill.h                   |  107 ++
 include/{ => uapi}/linux/romfs_fs.h           |    0
 include/{ => uapi}/linux/rose.h               |    0
 include/{ => uapi}/linux/route.h              |    0
 include/uapi/linux/rtc.h                      |  107 ++
 include/uapi/linux/rtnetlink.h                |  612 ++++++++
 include/uapi/linux/scc.h                      |  172 +++
 include/uapi/linux/sched.h                    |   46 +
 include/uapi/linux/screen_info.h              |   74 +
 include/uapi/linux/sdla.h                     |  116 ++
 include/uapi/linux/seccomp.h                  |   47 +
 include/uapi/linux/securebits.h               |   51 +
 include/{ => uapi}/linux/selinux_netlink.h    |    0
 include/uapi/linux/sem.h                      |   80 +
 include/uapi/linux/serial.h                   |  126 ++
 include/uapi/linux/serial_core.h              |  219 +++
 include/{ => uapi}/linux/serial_reg.h         |    0
 include/uapi/linux/serio.h                    |   80 +
 include/uapi/linux/shm.h                      |   79 +
 include/uapi/linux/signal.h                   |    8 +
 include/uapi/linux/signalfd.h                 |   52 +
 include/{ => uapi}/linux/snmp.h               |    0
 include/uapi/linux/sock_diag.h                |   26 +
 include/uapi/linux/socket.h                   |   21 +
 include/{ => uapi}/linux/sockios.h            |    0
 include/{ => uapi}/linux/som.h                |    0
 include/uapi/linux/sonet.h                    |   60 +
 include/uapi/linux/sonypi.h                   |  146 ++
 include/uapi/linux/sound.h                    |   31 +
 include/uapi/linux/soundcard.h                | 1282 ++++++++++++++++
 include/uapi/linux/stat.h                     |   45 +
 include/uapi/linux/stddef.h                   |    1 +
 include/uapi/linux/string.h                   |    9 +
 include/{ => uapi}/linux/suspend_ioctls.h     |    0
 include/uapi/linux/swab.h                     |  282 ++++
 include/uapi/linux/synclink.h                 |  300 ++++
 include/uapi/linux/sysctl.h                   |  932 ++++++++++++
 include/{ => uapi}/linux/sysinfo.h            |    0
 include/{ => uapi}/linux/taskstats.h          |    0
 include/uapi/linux/tcp.h                      |  225 +++
 include/{ => uapi}/linux/tcp_metrics.h        |    0
 include/{ => uapi}/linux/telephony.h          |    0
 include/{ => uapi}/linux/termios.h            |    0
 include/uapi/linux/time.h                     |   71 +
 include/{ => uapi}/linux/times.h              |    0
 include/uapi/linux/timex.h                    |  166 ++
 include/{ => uapi}/linux/tiocl.h              |    0
 include/{ => uapi}/linux/tipc.h               |    0
 include/{ => uapi}/linux/tipc_config.h        |    0
 include/uapi/linux/toshiba.h                  |   37 +
 include/uapi/linux/tty.h                      |   38 +
 include/{ => uapi}/linux/tty_flags.h          |    0
 include/uapi/linux/types.h                    |   56 +
 include/{ => uapi}/linux/udf_fs_i.h           |    0
 include/uapi/linux/udp.h                      |   39 +
 include/{ => uapi}/linux/uhid.h               |    0
 include/uapi/linux/uinput.h                   |  137 ++
 include/uapi/linux/uio.h                      |   30 +
 include/{ => uapi}/linux/ultrasound.h         |    0
 include/{ => uapi}/linux/un.h                 |    0
 include/{ => uapi}/linux/unistd.h             |    0
 include/{ => uapi}/linux/unix_diag.h          |    0
 include/uapi/linux/usbdevice_fs.h             |  180 +++
 include/{ => uapi}/linux/utime.h              |    0
 include/uapi/linux/utsname.h                  |   34 +
 include/uapi/linux/uuid.h                     |   58 +
 include/{ => uapi}/linux/uvcvideo.h           |    0
 include/{ => uapi}/linux/v4l2-common.h        |    0
 include/{ => uapi}/linux/v4l2-controls.h      |    0
 include/{ => uapi}/linux/v4l2-dv-timings.h    |    0
 include/{ => uapi}/linux/v4l2-mediabus.h      |    0
 include/{ => uapi}/linux/v4l2-subdev.h        |    0
 include/{ => uapi}/linux/veth.h               |    0
 include/uapi/linux/vfio.h                     |  368 +++++
 include/{ => uapi}/linux/vhost.h              |    0
 include/uapi/linux/videodev2.h                | 1998 +++++++++++++++++++++++++
 include/{ => uapi}/linux/virtio_9p.h          |    0
 include/{ => uapi}/linux/virtio_balloon.h     |    0
 include/{ => uapi}/linux/virtio_blk.h         |    0
 include/uapi/linux/virtio_config.h            |   54 +
 include/uapi/linux/virtio_console.h           |   74 +
 include/{ => uapi}/linux/virtio_ids.h         |    0
 include/{ => uapi}/linux/virtio_net.h         |    0
 include/{ => uapi}/linux/virtio_pci.h         |    0
 include/uapi/linux/virtio_ring.h              |  163 ++
 include/{ => uapi}/linux/virtio_rng.h         |    0
 include/uapi/linux/vt.h                       |   90 ++
 include/uapi/linux/wait.h                     |   21 +
 include/uapi/linux/wanrouter.h                |  452 ++++++
 include/uapi/linux/watchdog.h                 |   57 +
 include/{ => uapi}/linux/wimax.h              |    0
 include/uapi/linux/wireless.h                 | 1128 ++++++++++++++
 include/{ => uapi}/linux/x25.h                |    0
 include/uapi/linux/xattr.h                    |   64 +
 include/{ => uapi}/linux/xfrm.h               |    0
 tools/vm/page-types.c                         |    2 +-
 578 files changed, 32659 insertions(+), 30108 deletions(-)
