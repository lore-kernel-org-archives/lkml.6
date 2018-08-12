Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C53C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD8921A07
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 21:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OpiXH2sA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD8921A07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeHLXra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 19:47:30 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:55873 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeHLXr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 19:47:29 -0400
Received: by mail-it0-f54.google.com with SMTP id d10-v6so9901808itj.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=WHyn2FxoFBKe3BsRgMohLsYsxNDrVgjeEwe71Np/Wxg=;
        b=OpiXH2sAe8Fg1qqgD0zB2iEYbeBOeVXBUwqGVpjRRW3GpZBkVsDZgfNW/m+2yVeNu4
         77ucEiw+qBiLG9y1plNJfgc9ktSOjcGmSG4Es0Atcbe1V0qbfo98E6zcG0d4k6sTLsqZ
         0TVo7kFQkLWU7akV8UWDULsSGPGCbSwaFhDnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WHyn2FxoFBKe3BsRgMohLsYsxNDrVgjeEwe71Np/Wxg=;
        b=agc2wdnWy/mcqYXEDwK1eouQ7YLAl/linMudsRCVW4+L52BwUicnQEStWQgMOSLh4h
         qn1gtpS14Tz2h3Dg6ADUvK1SeGrJ4b2IygTDNAkRM2661pqeGeS5U1gWL/jA5Hc+4U5i
         WlANGfkZeE7ORUxpAuh7L68udrKYvbPzcqe6zY2evBckBcvfQOWQFRPC4ZKpm6QtXqfk
         vG70YaZdPMYUpmrzw/Au445Y1f1cBcyT0/vHSuu9QLd9xPoC/jfkGk4Pf31KxX/Sy36m
         1vu7yxDQ2tvrTiYQ+a2xfE6HMTp6L7B363IFRLstyh4kNpnmX1Lav4IbFzgMN6PYaVAg
         nZUQ==
X-Gm-Message-State: AOUpUlHiME3VqZ0RsiJShAagP0YTvGO0F4FWUY1w4uFRMXnOfgfoUFZr
        cTLDaUdjiz8sfUoNZKrGunruBM9HMo/fMAOB4g25XSgx
X-Google-Smtp-Source: AA+uWPwdYzjHcrvySZcoChTR/FTfGnaMpNN8CLxFhmKFHz8MdRm5BLzeLB5N7tZ77CwKcEU1zNIU97dPOZHagmeJa8Y=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr12764501jas.72.1534108092318;
 Sun, 12 Aug 2018 14:08:12 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Aug 2018 14:08:01 -0700
Message-ID: <CA+55aFzos7tr=OLju10Oe-z7r=eB2dSaFa7vwz2ApGO13B=z_g@mail.gmail.com>
Subject: Linux 4.18
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One week late(r) and here we are - 4.18 is out there.

It was a very calm week, and arguably I could just have released on
schedule last week, but we did have some minor updates. Mostly
networking, but some vfs race fixes (mentioned in the rc8 announment
as "pending") and a couple of driver fixes (scsi, networking, i2c).
Some other minor random things (arm crypto fix, parisc memory ordering
fix). Shortlog appended for the (few) details.

Some of these I was almost ready to just delay to until the next merge
window, but they were marked for stable anyway, so it would just have
caused more backporting. The vfs fixes are for old races that are
really hard to hit (which is obviously why they are old and weren't
noticed earlier). Some of them _have_ been seen in real life, some of
them probably need explicit help to ever trigger (ie artificial delays
just to show that "yes, this can actually happen in theory").

Anyway, with this, the merge window for 4.19 is obviously open, and
I'll start pulling tomorrow. I already have a couple of dozen pull
requests pending due to the one-week delay of 4.18, but keep them
coming.

                 Linus

---

Al Viro (5):
      root dentries need RCU-delayed freeing
      cxgb4: mk_act_open_req() buggers ->{local, peer}_ip on big-endian hosts
      fix mntput/mntput race
      fix __legitimize_mnt()/mntput() race
      make sure that __dentry_kill() always invalidates d_seq, unhashed or not

Alexey Kodanev (1):
      dccp: fix undefined behavior with 'cwnd' shift in ccid2_cwnd_restart()

Andrew Lunn (1):
      dsa: slave: eee: Allow ports to use phylink

Andrey Ryabinin (1):
      lib/ubsan: remove null-pointer checks

Ard Biesheuvel (1):
      crypto: arm64 - revert NEON yield for fast AEAD implementations

Bart Van Assche (2):
      scsi: qedi: Fix a potential buffer overflow
      scsi: sr: Avoid that opening a CD-ROM hangs with runtime power
management enabled

Benjamin Tissoires (1):
      gpiolib-acpi: make sure we trigger edge events at least once on boot

Colin Ian King (1):
      net: thunderx: check for failed allocation lmac->dmacs

Cong Wang (3):
      ipv6: fix double refcount of fib6_metrics
      vsock: split dwork to avoid reinitializations
      llc: use refcount_inc_not_zero() for llc_sap_find()

Daniel Borkmann (3):
      bpf, sockmap: fix bpf_tcp_sendmsg sock error handling
      bpf, sockmap: fix leak in bpf_tcp_sendmsg wait for mem path
      bpf, sockmap: fix cork timeout for select due to epipe

David Howells (1):
      rxrpc: Fix the keepalive generator [ver #2]

Dmitry Bogdanov (1):
      net: aquantia: Fix IFF_ALLMULTI flag functionality

George Cherian (1):
      i2c: xlp9xx: Fix case where SSIF read transaction completes early

Helge Deller (1):
      parisc: Enable CONFIG_MLONGCALLS by default

Huy Nguyen (1):
      net/mlx5e: Cleanup of dcbnl related fields

Ivan Khoronzhuk (2):
      net: ethernet: ti: cpsw: clear all entries when delete vid
      net: ethernet: ti: cpsw: fix runtime_pm while add/kill vlan

Jason Wang (1):
      vhost: reset metadata cache when initializing new IOTLB

Jesper Dangaard Brouer (3):
      xdp: fix bug in cpumap teardown code path
      samples/bpf: xdp_redirect_cpu adjustment to reproduce teardown race easier
      xdp: fix bug in devmap teardown code path

Jim Gill (1):
      scsi: vmw_pvscsi: Return DID_RESET for status SAM_STAT_COMMAND_TERMINATED

Johannes Thumshirn (3):
      scsi: fcoe: fix use-after-free in fcoe_ctlr_els_send
      scsi: fcoe: drop frames in ELS LOGO error path
      scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO

John David Anglin (1):
      parisc: Define mb() and add memory barriers to assembler unlock sequences

Juergen Gross (1):
      xen/netfront: don't cache skb_shinfo()

Kieran Bingham (1):
      MAINTAINERS: GDB: update e-mail address

Linus Torvalds (2):
      init: rename and re-order boot_cpu_state_init()
      Linux 4.18

Martin KaFai Lau (1):
      bpf: btf: Change tools/lib/bpf/btf to LGPL

Minchan Kim (1):
      zram: remove BD_CAP_SYNCHRONOUS_IO with writeback feature

Ondrej Mosnacek (1):
      crypto: x86/aegis,morus - Fix and simplify CPUID checks

Or Gerlitz (1):
      net/mlx5e: Properly check if hairpin is possible between two functions

Quinn Tran (1):
      scsi: qla2xxx: Fix memory leak for allocating abort IOCB

Sreekanth Reddy (1):
      scsi: mpt3sas: Swap I/O memory read value back to cpu endianness

Ursula Braun (3):
      net/smc: no shutdown in state SMC_LISTEN
      net/smc: allow sysctl rmem and wmem defaults for servers
      net/smc: move sock lock in smc_ioctl()

Willem de Bruijn (1):
      packet: refine ring v3 block size test to hold one frame

Xin Long (1):
      ip6_tunnel: use the right value for ipv4 min mtu check in ip6_tnl_xmit

Ying Xue (1):
      tipc: fix an interrupt unsafe locking scenario

jie@chenjie6@huwei.com (1):
      mm/memory.c: check return value of ioremap_prot
