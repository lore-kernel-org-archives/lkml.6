Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325329-2-15610435988185104529
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325328; b=npkISClwB8UDKAewrvZv1zqgg8AhZGHq9j4ytn6HYjFUBk2
    2sbhPvucyXHZt3gtI3202kgNrlNdoA1MXe1UxxObl96PpszfjGfeZcaCW/TLBksq
    NhphuYmOE5dHRo2LdyLsiclxJFtqf7TpI9eMZt7c4xp+L4z6dCX9nbuJndcpYuEt
    vSDYKz4ZlXnVmVXHNu6ZMyAy6ui+MOBEFxjPHX+2+fzzx9TuLFr7TiolNdqmJpxo
    KuzaeedF/KmAp7mdIeQH6zJLnyy49JiqECwP9j9rsDQRwe8L7JLp7t0WBHFNjdYS
    JiHAnFYkZaABQtJnxTMygohevSrRNAAZkmahTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:sender:list-id;
    s=arctest; t=1518325328; bh=k3am4Wz+cVaNfbI8jybVKDIMYLv2YKInoVw
    taMOIE5U=; b=ETM7iR7+2X0vtw+OLIcmcu9SMlT/qZuQCdCmY4lfkeLmDUginx9
    gB2jJa7GFPBm2mCbBu3PUYTcnyYJzRfe1seWfQnO+EXzBFOD0eJgsyXPOGhmz2je
    1QZsCsuRHOo178TT5HBdRteAaqBF95ztVzX5YOmh4ap/XSCoxPYrzNhXT/fVx0VF
    30hxQwSvBC09a2ij+mLQ22SDaWX4U7LMN9HW6RbJ3ehL2ghQAwkNfnYMcrnKrhpi
    MnzuThw2yskCgUfqgSG/bcZGIDxx7dT8joB4y3Sentmar9BGamhQlmxs+8eKzeqk
    3ukCUU8TlE/ExmymSsnxH3FbDZUoPP6ymDA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbeBKFBL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:01:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41648 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752465AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date: Sun, 11 Feb 2018 04:31:09 +0000
Message-ID: <lsq.1518323469.348919605@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 000/136] 3.16.54-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.16.54 release.
There are 136 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Feb 13 12:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Alan Stern (1):
      USB: usbfs: compute urb->actual_length for isochronous
         [2ef47001b3ee3ded579b7532ebdcf8680e4d8c54]

Alex Chen (1):
      ocfs2: should wait dio before inode lock in ocfs2_setattr()
         [28f5a8a7c033cbf3e32277f4cc9c6afd74f05300]

Alexander Popov (1):
      usbip: fix NULL pointer dereference on errors
         [8c7003a3b4b4afd3734cdcc39217ef22d78a4a16]

Alexander Potapenko (1):
      sctp: fully initialize the IPv6 address in sctp_v6_to_addr()
         [15339e441ec46fbc3bf3486bb1ae4845b0f1bb8d]

Alexander Steffen (1):
      tpm-dev-common: Reject too short writes
         [ee70bc1e7b63ac8023c9ff9475d8741e397316e7]

Alexandre Belloni (1):
      rtc: set the alarm to the next expiring timer
         [74717b28cb32e1ad3c1042cafd76b264c8c0f68d]

Andreas Rohner (1):
      nilfs2: fix race condition that causes file system corruption
         [31ccb1f7ba3cfe29631587d451cf5bb8ab593550]

Andrew F. Davis (1):
      ASoC: cs42l56: Fix reset GPIO name in example DT binding
         [8adc430603d67e76a0f8491df21654f691acda62]

Andrey Konovalov (1):
      p54: don't unregister leds when they are not initialized
         [fc09785de0a364427a5df63d703bae9a306ed116]

Andy Lutomirski (4):
      x86, vdso, pvclock: Simplify and speed up the vdso pvclock reader
         [6b078f5de7fc0851af4102493c7b5bb07e49c4cb]
      x86, vdso: Move the vvar area before the vdso text
         [e6577a7ce99a506b587bcd1d2cd803cb45119557]
      x86/vdso: Get pvclock data from the vvar VMA instead of the fixmap
         [dac16fba6fc590fa7239676b35ed75dae4c4cd2b]
      x86/vdso: Remove pvclock fixmap machinery
         [cc1e24fdb064d3126a494716f22ad4fc39306742]

Anna Schumaker (1):
      NFS: Avoid RCU usage in tracepoints
         [3944369db701f075092357b511fd9f5755771585]

Arnd Bergmann (4):
      Input: adxl34x - do not treat FIFO_MODE() as boolean
         [1dbc080c9ef6bcfba652ef0d6ae919b8c7c85a1d]
      drm: gma500: fix logic error
         [67a3b63a54cbe18944191f43d644686731cf30c7]
      elf_fdpic: fix unused variable warning
         [11e3e8d6d9274bf630859b4c47bc4e4d76f289db]
      isofs: fix timestamps beyond 2027
         [34be4dbf87fc3e474a842305394534216d428f5d]

Bart Van Assche (3):
      IB/srp: Avoid that a cable pull can trigger a kernel crash
         [8a0d18c62121d3c554a83eb96e2752861d84d937]
      IB/srpt: Do not accept invalid initiator port names
         [c70ca38960399a63d5c048b7b700612ea321d17e]
      target/iscsi: Fix iSCSI task reassignment handling
         [59b6986dbfcdab96a971f9663221849de79a7556]

Ben Hutchings (1):
      usbip: tools: Install all headers needed for libusbip development
         [c15562c0dcb2c7f26e891923b784cf1926b8c833]

Ben Seri (1):
      Bluetooth: Prevent stack info leak from the EFS element.
         [06e7e776ca4d36547e503279aeff996cbb292c16]

Bernhard Rosenkraenzer (1):
      USB: Add delay-init quirk for Corsair K70 LUX keyboards
         [a0fea6027f19c62727315aba1a7fae75a9caa842]

Boshi Wang (1):
      ima: fix hash algorithm initialization
         [ebe7c0a7be92bbd34c6ff5b55810546a0ee05bee]

Brent Taylor (1):
      mtd: nand: Fix writing mtdoops to nand flash.
         [30863e38ebeb500a31cecee8096fb5002677dd9b]

Brian King (6):
      i40e: Use smp_rmb rather than read_barrier_depends
         [52c6912fde0133981ee50ba08808f257829c4c93]
      i40evf: Use smp_rmb rather than read_barrier_depends
         [f72271e2a0ae4277d53c4053f5eed8bb346ba38a]
      igb: Use smp_rmb rather than read_barrier_depends
         [c4cb99185b4cc96c0a1c70104dc21ae14d7e7f28]
      igbvf: Use smp_rmb rather than read_barrier_depends
         [1e1f9ca546556e508d021545861f6b5fc75a95fe]
      ixgbe: Fix skb list corruption on Power systems
         [0a9a17e3bb4564caf4bfe2a6783ae1287667d188]
      ixgbevf: Use smp_rmb rather than read_barrier_depends
         [ae0c585d93dfaf923d2c7eb44b2c3ab92854ea9b]

Christian König (1):
      drm/ttm: once more fix ttm_buffer_object_transfer
         [4d98e5ee6084f6d7bc578c5d5f86de7156aaa4cb]

Chuck Lever (1):
      nfs: Fix ugly referral attributes
         [c05cefcc72416a37eba5a2b35f0704ed758a9145]

Colin Ian King (3):
      btrfs: avoid null pointer dereference on fs_info when calling btrfs_crit
         [3993b112dac968612b0b213ed59cb30f50b0015b]
      rtc: interface: ignore expired timers when enqueuing new timers
         [2b2f5ff00f63847d95adad6289bd8b05f5983dd5]
      staging: rtl8188eu: avoid a null dereference on pmlmepriv
         [123c0aab0050cd0e07ce18e453389fbbb0a5a425]

Coly Li (2):
      bcache: check ca->alloc_thread initialized before wake up it
         [91af8300d9c1d7c6b6a2fd754109e08d4798b8d8]
      bcache: only permit to recovery read error when cache device is clean
         [d59b23795933678c9638fd20c942d2b4f3cd6185]

Corey Minyard (1):
      ipmi: fix unsigned long underflow
         [392a17b10ec4320d3c0e96e2a23ebaad1123b989]

Dan Carpenter (2):
      eCryptfs: use after free in ecryptfs_release_messaging()
         [db86be3a12d0b6e5c5b51c2ab2a48f06329cb590]
      scsi: bfa: integer overflow in debugfs
         [3e351275655d3c84dc28abf170def9786db5176d]

Dongho Sim (1):
      f2fs: remove redundant lines in allocate_data_block
         [33be828ada7274ebcade2001f16e5b4e33a4636e]

Doug Berger (1):
      net: bcmgenet: enable loopback during UniMAC sw_reset
         [28c2d1a7a0bfdf3617800d2beae1c67983c03d15]

Douglas Fischer (1):
      USB: serial: qcserial: add pid/vid for Sierra Wireless EM7355 fw update
         [771394a54148f18926ca86414e51c69eda27d0cd]

Eric Biggers (1):
      dm bufio: fix integer overflow when limiting maximum cache size
         [74d4108d9e681dbbe4a2940ed8fdff1f6868184c]

Eric Dumazet (1):
      netfilter: xt_TCPMSS: add more sanity tests on tcph->doff
         [2638fd0f92d4397884fd991d8f4925cb3f081901]

Eric W. Biederman (1):
      net/sctp: Always set scope_id in sctp_inet6_skb_msgname
         [7c8a61d9ee1df0fb4747879fa67a99614eb62fec]

Gabriele Paoloni (1):
      PCI/AER: Report non-fatal errors only to the affected endpoint
         [86acc790717fb60fb51ea3095084e331d8711c74]

Guenter Roeck (1):
      kaiser: Set _PAGE_NX only if supported
         [61e9b3671007a5da8127955a1a3bda7e0d5f42e8]

Guillaume Nault (5):
      l2tp: don't register sessions in l2tp_session_create()
         [3953ae7b218df4d1e544b98a393666f9ae58a78c]
      l2tp: ensure sessions are freed after their PPPOL2TP socket
         [cdd10c9627496ad25c87ce6394e29752253c69d3]
      l2tp: initialise PPP sessions before registering them
         [f98be6c6359e7e4a61aaefb9964c1db31cb9ec0c]
      l2tp: initialise l2tp_eth sessions before registering them
         [ee28de6bbd78c2e18111a0aef43ea746f28d2073]
      l2tp: protect sock pointer of struct pppol2tp_session with RCU
         [ee40fb2e1eb5bc0ddd3f2f83c6e39a454ef5a741]

Heiko Carstens (2):
      s390/runtime instrumention: fix possible memory corruption
         [d6e646ad7cfa7034d280459b2b2546288f247144]
      s390: fix transactional execution control register handling
         [a1c5befc1c24eb9c1ee83f711e0f21ee79cbb556]

Hou Tao (1):
      dm: fix race between dm_get_from_kobject() and __dm_destroy()
         [b9a41d21dceadf8104812626ef85dc56ee8a60ed]

Ingo Molnar (1):
      x86/platform/uv: Include clocksource.h for clocksource_touch_watchdog()
         [d51953b0873358d13b189996e6976dfa12a9b59d]

Jaegeuk Kim (1):
      f2fs: expose some sectors to user in inline data or dentry case
         [5b4267d195dd887c4412e34b5a7365baa741b679]

James Morse (2):
      ACPI / APEI: Remove ghes_ioremap_area
         [520e18a5080d2c444a03280d99c8a35cb667d321]
      ACPI / APEI: Replace ioremap_page_range() with fixmap
         [4f89fa286f6729312e227e7c2d764e8e7b9d340e]

Jan Harkes (1):
      coda: fix 'kernel memory exposure attempt' in fsync
         [d337b66a4c52c7b04eec661d86c2ef6e168965a2]

Jani Nikula (1):
      drm/i915/bios: parse DDI ports also for CHV for HDMI DDC pin and DP AUX channel
         [348e4058ebf53904e817eec7a1b25327143c2ed2]

Jason Gunthorpe (1):
      sctp: Fixup v4mapped behaviour to comply with Sock API
         [299ee123e19889d511092347f5fc14db0f10e3a6]

Jens Axboe (1):
      blktrace: fix unlocked access to init/start-stop/teardown
         [1f2cac107c591c24b60b115d6050adc213d10fc0]

Joerg Roedel (1):
      iommu/vt-d: Don't register bus-notifier under dmar_global_lock
         [ec154bf56b276a0bb36079a5d22a267b5f417801]

Johan Hovold (5):
      NFC: fix device-allocation error return
         [c45e3e4c5b134b081e8af362109905427967eb19]
      USB: serial: garmin_gps: fix I/O after failed probe and remove
         [19a565d9af6e0d828bd0d521d3bafd5017f4ce52]
      USB: serial: garmin_gps: fix memory leak on probe errors
         [74d471b598444b7f2d964930f7234779c80960a0]
      USB: serial: metro-usb: stop I/O after failed open
         [2339536d229df25c71c0900fc619289229bfecf6]
      clk: ti: dra7-atl-clock: fix child-node lookups
         [33ec6dbc5a02677509d97fe36cd2105753f0f0ea]

Johannes Berg (1):
      nl80211: don't expose wdev->ssid for most interfaces
         [44905265bc155e0237c76c25bf5ddf740d85a8f2]

John David Anglin (1):
      parisc: Fix validity check of pointer size argument in new CAS implementation
         [05f016d2ca7a4fab99d5d5472168506ddf95e74f]

John Johansen (1):
      apparmor: ensure that undecidable profile attachments fail
         [844b8292b6311ecd30ae63db1471edb26e01d895]

Joshua Watt (1):
      NFS: Fix typo in nomigration mount option
         [f02fee227e5f21981152850744a6084ff3fa94ee]

Juerg Haefliger (1):
      Revert "x86: kvmclock: Disable use from  vDSO if KPTI is enabled"
         [not upstream; reverts 3.16-specific change]

Ladi Prosek (1):
      KVM: nVMX: set IDTR and GDTR limits when loading L1 host state
         [21f2d551183847bc7fbe8d866151d00cdad18752]

Ladislav Michl (1):
      video: udlfb: Fix read EDID timeout
         [c98769475575c8a585f5b3952f4b5f90266f699b]

Lepton Wu (1):
      kaiser: Set _PAGE_NX only if supported
         [not upstream; specific to KAISER backport]

Maciej W. Rozycki (1):
      MIPS: Fix an n32 core file generation regset support regression
         [547da673173de51f73887377eb275304775064ad]

Majd Dibbiny (1):
      IB/mlx5: Assign send CQ and recv CQ of UMR QP
         [31fde034a8bd964a5c7c1a5663fc87a913158db2]

Manasi Navare (1):
      drm/i915/edp: Get the Panel Power Off timestamp after panel is off
         [cbacf02e7796fea02e5c6e46c90ed7cbe9e6f2c0]

Mark Bloch (1):
      IB/mlx4: Increase maximal message size under UD QP
         [5f22a1d87c5315a98981ecf93cd8de226cffe6ca]

Mark Rutland (1):
      arm64: vdso: fix clock_getres for 4GiB-aligned res
         [c80ed088a519da53f27b798a69748eaabc66aadf]

Markus Elfring (2):
      media: omap_vout: Fix a possible null pointer dereference in omap_vout_open()
         [bfba2b3e21b9426c0f9aca00f3cad8631b2da170]
      platform/x86: sony-laptop: Fix error handling in sony_nc_setup_rfkill()
         [f6c8a317ab208aee223776327c06f23342492d54]

Masami Hiramatsu (1):
      x86/decoder: Add new TEST instruction pattern
         [12a78d43de767eaf8fb272facb7a7b6f2dc6a9df]

Mauro Carvalho Chehab (1):
      [media] cx231xx: Fix the max number of interfaces
         [139d28826b8e2bc7a9232fde0d2f14812914f501]

Michał Mirosław (1):
      clk: tegra: Fix cclk_lp divisor register
         [54eff2264d3e9fd7e3987de1d7eba1d3581c631e]

Mike Snitzer (1):
      dm: discard support requires all targets in a table support discards
         [8a74d29d541cd86569139c6f3f44b2d210458071]

Mohamed Ghannam (2):
      RDS: Heap OOB write in rds_message_alloc_sgs()
         [c095508770aebf1b9218e77026e48345d719b17c]
      RDS: null pointer dereference in rds_atomic_free_op
         [7d11f77f84b27cef452cee332f4e469503084737]

Nadav Amit (2):
      KVM: vmx: Inject #GP on invalid PAT CR
         [4566654bb9be9e8864df417bb72ceee5136b6a6a]
      staging: lustre: ptlrpc: kfree used instead of kvfree
         [c3eec59659cf25916647d2178c541302bb4822ad]

Nathan Lynch (1):
      arm64: vdso: minor ABI fix for clock_getres
         [e1b6b6ce55a0a25c8aa8af019095253b2133a41a]

NeilBrown (2):
      autofs: don't fail mount for transient error
         [ecc0c469f27765ed1e2b967be0aa17cee1a60b76]
      autofs: fix careless error in recent commit
         [302ec300ef8a545a7fc7f667e5fd743b091c2eeb]

Nicholas Bellinger (3):
      iscsi-target: Fix non-immediate TMR reference leak
         [3fc9fb13a4b2576aeab86c62fd64eb29ab68659c]
      iscsi-target: Make TASK_REASSIGN use proper se_cmd->cmd_kref
         [ae072726f6109bb1c94841d6fb3a82dde298ea85]
      target: Avoid early CMD_T_PRE_EXECUTE failures during ABORT_TASK
         [1c21a48055a67ceb693e9c2587824a8de60a217c]

Paolo Bonzini (2):
      KVM: SVM: obey guest PAT
         [15038e14724799b8c205beb5f20f9e54896013c3]
      x86: pvclock: Really remove the sched notifier for cross-cpu migrations
         [73459e2a1ada09a68c02cc5b73f3116fc8194b3d]

Peter Ujfalusi (1):
      clk: ti: dra7-atl-clock: Fix of_node reference counting
         [660e1551939931657808d47838a3f443c0e83fd0]

Peter Zijlstra (1):
      lib/int_sqrt: optimize small argument
         [3f3295709edea6268ff1609855f498035286af73]

Philip Derrin (1):
      ARM: 8721/1: mm: dump: check hardware RO bit for LPAE
         [3b0c0c922ff4be275a8beb87ce5657d16f355b54]

Radu Alexe (1):
      crypto: caam - fix incorrect define
         [cc2f8ab5334a736fa0e775cfccf06c1e268667f0]

Roger Quadros (1):
      mtd: nand: omap2: Fix subpage write
         [739c64414f01748a36e7d82c8e0611dea94412bd]

Roman Kapl (1):
      drm/radeon: fix atombios on big endian
         [4f626a4ac8f57ddabf06d03870adab91e463217f]

Sean Young (1):
      media: rc: check for integer overflow
         [3e45067f94bbd61dec0619b1c32744eb0de480c8]

Shriya (1):
      powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo
         [cd77b5ce208c153260ed7882d8910f2395bfaabd]

Shuah Khan (4):
      usbip: fix stub_rx: get_pipe() to validate endpoint number
         [635f545a7e8be7596b9b2b6a43cab6bbd5a88e43]
      usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input
         [c6688ef9f29762e65bce325ef4acd6c675806366]
      usbip: fix stub_send_ret_submit() vulnerability to null transfer_buffer
         [be6123df1ea8f01ee2f896a16c2b7be3e4557a5a]
      usbip: prevent vhci_hcd driver from leaking a socket pointer address
         [2f2d0088eb93db5c649d2a5e34a3800a8a935fc5]

Stanislaw Gruszka (1):
      rt2x00usb: mark device removed when get ENOENT usb error
         [bfa62a52cad93686bb8d8171ea5288813248a7c6]

Takashi Iwai (6):
      ALSA: seq: Make ioctls race-free
         [b3defb791b26ea0683a93a4f49c77ec45ec96f10]
      ALSA: timer: Remove kernel warning at compat ioctl error paths
         [3d4e8303f2c747c8540a0a0126d0151514f6468b]
      ALSA: usb-audio: Add sanity checks in v2 clock parsers
         [0a62d6c966956d77397c32836a5bbfe3af786fc1]
      ALSA: usb-audio: Add sanity checks to FE parser
         [d937cd6790a2bef2d07b500487646bd794c039bb]
      ALSA: usb-audio: Fix potential out-of-bound access at parsing SU
         [f658f17b5e0e339935dca23e77e0f3cad591926b]
      ALSA: usb-audio: Fix potential zero-division at parsing FU
         [8428a8ebde2db1e988e41a58497a28beb7ce1705]

Theodore Ts'o (1):
      ext4: fix interaction between i_size, fallocate, and delalloc after a crash
         [51e3ae81ec58e95f10a98ef3dd6d7bce5d8e35a2]

Tuomas Tynkkynen (2):
      fs/9p: Compare qid.path in v9fs_test_inode
         [8ee031631546cf2f7859cc69593bd60bbdd70b46]
      net/9p: Switch to wait_event_killable()
         [9523feac272ccad2ad8186ba4fcc89103754de52]

Tyrel Datwyler (1):
      powerpc/pseries/vio: Dispose of virq mapping on vdevice unregister
         [b8f89fea599d91e674497aad572613eb63181f31]

Vasily Gorbik (1):
      s390/disassembler: increase show_code buffer size
         [b192571d1ae375e0bbe0aa3ccfa1a3c3704454b9]

Vijendar Mukunda (1):
      ALSA: hda: Add Raven PCI ID
         [9ceace3c9c18c67676e75141032a65a8e01f9a7a]

Viktor Slavkovic (1):
      staging: android: ashmem: fix a race condition in ASHMEM_SET_SIZE ioctl
         [443064cb0b1fb4569fe0a71209da7625129fb760]

Ville Syrjälä (1):
      drm/i915: Read timings from the correct transcoder in intel_crtc_mode_get()
         [e30a154b5262b967b133b06ac40777e651045898]

Waiman Long (1):
      blktrace: Fix potential deadlock between delete & sysfs ops
         [5acb3cc2c2e9d3020a4fee43763c6463767f1572]

William A. Kennington III (1):
      powerpc/opal: Fix EBUSY bug in acquiring tokens
         [71e24d7731a2903b1ae2bba2b2971c654d9c2aa6]

Xin Long (2):
      route: also update fnhe_genid when updating a route cache
         [cebe84c6190d741045a322f5343f717139993c08]
      route: update fnhe_expires for redirect when the fnhe exists
         [e39d5246111399dbc6e11cd39fd8580191b86c47]

Yunlong Song (1):
      Revert "f2fs: handle dirty segments inside refresh_sit_entry"
         [65f1b80b33378501ea552ef085e9c31739af356c]

Zhou Chengming (1):
      kprobes, x86/alternatives: Use text_mutex to protect smp_alt_modules
         [e846d13958066828a9483d862cc8370a72fadbb6]

 .../devicetree/bindings/sound/cs42l56.txt          |   2 +-
 Makefile                                           |   4 +-
 arch/arm/mm/dump.c                                 |   4 +-
 arch/arm64/kernel/vdso/gettimeofday.S              |   3 +-
 arch/mips/kernel/ptrace.c                          |  17 ++
 arch/parisc/kernel/syscall.S                       |   6 +-
 arch/powerpc/kernel/vio.c                          |   2 +
 arch/powerpc/platforms/powernv/opal-async.c        |   6 +-
 arch/powerpc/platforms/powernv/setup.c             |   2 +-
 arch/s390/include/asm/switch_to.h                  |   2 +-
 arch/s390/kernel/dis.c                             |   4 +-
 arch/s390/kernel/early.c                           |   4 +-
 arch/s390/kernel/process.c                         |   1 +
 arch/s390/kernel/runtime_instr.c                   |   4 +-
 arch/x86/include/asm/fixmap.h                      |  11 +-
 arch/x86/include/asm/pvclock.h                     |  15 +-
 arch/x86/include/asm/vdso.h                        |  19 +-
 arch/x86/kernel/alternative.c                      |  26 +-
 arch/x86/kernel/kvmclock.c                         |  16 +-
 arch/x86/kernel/pvclock.c                          |  68 -----
 arch/x86/kvm/svm.c                                 |   7 +
 arch/x86/kvm/vmx.c                                 |   4 +
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/kvm/x86.h                                 |   2 +
 arch/x86/lib/x86-opcode-map.txt                    |   2 +-
 arch/x86/mm/kaiser.c                               |   7 +-
 arch/x86/platform/uv/uv_nmi.c                      |   1 +
 arch/x86/vdso/vclock_gettime.c                     | 103 ++++---
 arch/x86/vdso/vdso-layout.lds.S                    |  45 ++-
 arch/x86/vdso/vdso2c.c                             |  15 +-
 arch/x86/vdso/vdso2c.h                             |  25 +-
 arch/x86/vdso/vma.c                                |  34 ++-
 block/blk-core.c                                   |   3 +
 drivers/acpi/apei/ghes.c                           |  85 +-----
 drivers/char/ipmi/ipmi_msghandler.c                |  10 +-
 drivers/char/tpm/tpm-dev.c                         |   6 +
 drivers/clk/tegra/clk-tegra30.c                    |   2 +-
 drivers/clk/ti/clk-dra7-atl.c                      |   3 +-
 drivers/crypto/caam/desc.h                         |   2 +-
 drivers/gpu/drm/gma500/mdfld_intel_display.c       |   2 +-
 drivers/gpu/drm/i915/intel_bios.c                  |   2 +-
 drivers/gpu/drm/i915/intel_display.c               |  14 +-
 drivers/gpu/drm/i915/intel_dp.c                    |   2 +-
 drivers/gpu/drm/radeon/atombios_dp.c               |  38 ++-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   1 +
 drivers/infiniband/hw/mlx4/qp.c                    |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +
 drivers/infiniband/ulp/srp/ib_srp.c                |  23 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   9 +-
 drivers/input/misc/adxl34x.c                       |   2 +-
 drivers/iommu/dmar.c                               |   7 +-
 drivers/iommu/intel-iommu.c                        |  10 +
 drivers/md/bcache/alloc.c                          |   3 +-
 drivers/md/bcache/request.c                        |  10 +-
 drivers/md/dm-bufio.c                              |  15 +-
 drivers/md/dm-table.c                              |  32 +-
 drivers/md/dm.c                                    |  12 +-
 drivers/media/platform/omap/omap_vout.c            |   3 +-
 drivers/media/rc/ir-lirc-codec.c                   |   9 +-
 drivers/media/usb/cx231xx/cx231xx-cards.c          |   3 +-
 drivers/mtd/nand/nand_base.c                       |   9 +-
 drivers/mtd/nand/omap2.c                           | 340 ++++++++++++++-------
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  56 +---
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   2 +-
 drivers/net/wireless/p54/main.c                    |   7 +-
 drivers/net/wireless/rt2x00/rt2x00usb.c            |   6 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |   9 +-
 drivers/platform/x86/sony-laptop.c                 |  14 +-
 drivers/rtc/interface.c                            |  16 +-
 drivers/scsi/bfa/bfad_debugfs.c                    |   5 +-
 drivers/staging/android/ashmem.c                   |   2 +
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |   2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |   3 +-
 drivers/staging/usbip/stub.h                       |   1 -
 drivers/staging/usbip/stub_dev.c                   |   4 +-
 drivers/staging/usbip/stub_rx.c                    |  66 ++--
 drivers/staging/usbip/stub_tx.c                    |  13 +-
 drivers/staging/usbip/usbip_common.h               |   1 +
 drivers/staging/usbip/userspace/Makefile.am        |   3 +-
 .../staging/usbip/userspace/libsrc/vhci_driver.c   |   8 +-
 drivers/staging/usbip/vhci_sysfs.c                 |  20 +-
 drivers/target/iscsi/iscsi_target.c                |  49 ++-
 drivers/target/target_core_tmr.c                   |  10 +
 drivers/target/target_core_transport.c             |   2 +
 drivers/usb/core/devio.c                           |  14 +
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/serial/garmin_gps.c                    |  22 +-
 drivers/usb/serial/metro-usb.c                     |  11 +-
 drivers/usb/serial/qcserial.c                      |   1 +
 drivers/video/fbdev/udlfb.c                        |  10 +-
 fs/9p/vfs_inode.c                                  |   3 +
 fs/9p/vfs_inode_dotl.c                             |   3 +
 fs/autofs4/waitq.c                                 |  16 +-
 fs/binfmt_elf_fdpic.c                              |   2 +
 fs/btrfs/super.c                                   |   4 +-
 fs/coda/upcall.c                                   |   3 +-
 fs/ecryptfs/messaging.c                            |   7 +-
 fs/ext4/extents.c                                  |   6 +-
 fs/f2fs/file.c                                     |   5 +
 fs/f2fs/segment.c                                  |  20 +-
 fs/isofs/isofs.h                                   |   2 +-
 fs/isofs/rock.h                                    |   2 +-
 fs/isofs/util.c                                    |   2 +-
 fs/nfs/nfs4proc.c                                  |  18 +-
 fs/nfs/nfs4trace.h                                 |   8 +-
 fs/nfs/super.c                                     |   2 +-
 fs/nilfs2/segment.c                                |   6 +-
 fs/ocfs2/file.c                                    |   9 +-
 include/linux/blkdev.h                             |   1 +
 include/linux/dmar.h                               |   1 +
 include/linux/sched.h                              |   8 -
 include/net/sctp/sctp.h                            |   2 +
 include/net/sctp/structs.h                         |   8 +-
 include/target/target_core_base.h                  |   2 +
 kernel/extable.c                                   |   2 +
 kernel/sched/core.c                                |  15 -
 kernel/trace/blktrace.c                            |  76 ++++-
 lib/int_sqrt.c                                     |   3 +
 net/9p/client.c                                    |   3 +-
 net/9p/trans_virtio.c                              |  13 +-
 net/bluetooth/l2cap_core.c                         |  20 +-
 net/ipv4/route.c                                   |  14 +-
 net/l2tp/l2tp_core.c                               |  21 +-
 net/l2tp/l2tp_core.h                               |   3 +
 net/l2tp/l2tp_eth.c                                | 101 ++++--
 net/l2tp/l2tp_ppp.c                                | 236 ++++++++------
 net/netfilter/xt_TCPMSS.c                          |   6 +-
 net/nfc/core.c                                     |   2 +-
 net/rds/rdma.c                                     |   4 +
 net/sctp/ipv6.c                                    | 160 +++++-----
 net/sctp/protocol.c                                |  12 +-
 net/sctp/socket.c                                  |  33 +-
 net/sctp/transport.c                               |   4 +-
 net/sctp/ulpevent.c                                |   2 +-
 net/wireless/nl80211.c                             |  26 +-
 security/apparmor/domain.c                         |  53 +++-
 security/integrity/ima/ima_main.c                  |   4 +
 sound/core/seq/seq_clientmgr.c                     |  10 +-
 sound/core/seq/seq_clientmgr.h                     |   1 +
 sound/core/timer_compat.c                          |  12 +-
 sound/pci/hda/hda_intel.c                          |   3 +
 sound/usb/clock.c                                  |   9 +-
 sound/usb/mixer.c                                  |  19 +-
 149 files changed, 1480 insertions(+), 1026 deletions(-)

-- 
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.
