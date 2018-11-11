Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9868AC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C21E20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C21E20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeKLGdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:33:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49268 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbeKLFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:01 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0000l4-Jf; Sun, 11 Nov 2018 19:58:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001M3-D6; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date:   Sun, 11 Nov 2018 19:49:04 +0000
Message-ID: <lsq.1541965744.387173642@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 000/366] 3.16.61-rc1 review
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.61 release.
There are 366 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Nov 16 18:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

kt.liao@emc.com.tw (1):
      Input: elantech - fix V4 report decoding for module with middle key
         [e0ae2519ca004a628fa55aeef969c37edce522d3]

Aaron Ma (1):
      Input: elantech - enable middle button of touchpads on ThinkPad P52
         [24bb555e6e46d96e2a954aa0295029a81cc9bbaa]

Al Viro (6):
      fix __legitimize_mnt()/mntput() race
         [119e1ef80ecfe0d1deb6378d4ab41f5b71519de1]
      fix mntput/mntput race
         [9ea0a46ca2c318fcc449c1e6b62a7230a17888f1]
      make sure that __dentry_kill() always invalidates d_seq, unhashed or not
         [4c0d7cd5c8416b1ef41534d19163cb07ffaa03ab]
      root dentries need RCU-delayed freeing
         [90bad5e05bcdb0308cfa3d3a60f5c0b9c8e2efb3]
      unify dentry_iput() and dentry_unlink_inode()
         [550dce01dd606c88a837138aa448ccd367fb0cbb]
      use ->d_seq to get coherency between ->d_inode and ->d_flags
         [a528aca7f359f4b0b1d72ae406097e491a5ba9ea]

Alex Estrin (1):
      IB/isert: Fix for lib/dma_debug check_sync warning
         [763b69654bfb88ea3230d015e7d755ee8339f8ee]

Alex Vesker (2):
      net/mlx5: Fix command interface race in polling mode
         [d412c31dae053bf30a1bc15582a9990df297a660]
      net/mlx5: Fix incorrect raw command length parsing
         [603b7bcff824740500ddfa001d7a7168b0b38542]

Alexander Potapenko (1):
      vt: prevent leaking uninitialized data to userspace via /dev/vcs*
         [21eff69aaaa0e766ca0ce445b477698dc6a9f55a]

Alexander Sverdlin (2):
      ASoC: cirrus: i2s: Fix LRCLK configuration
         [2d534113be9a2aa532a1ae127a57e83558aed358]
      ASoC: cirrus: i2s: Fix {TX|RX}LinCtrlData setup
         [5d302ed3cc80564fb835bed5fdba1e1250ecc9e5]

Alexey Brodkin (1):
      ARC: Fix CONFIG_SWAP
         [6e3761145a9ba3ce267c330b6bff51cf6a057b06]

Alexey Kodanev (1):
      dccp: fix undefined behavior with 'cwnd' shift in ccid2_cwnd_restart()
         [61ef4b07fcdc30535889990cf4229766502561cf]

Amir Goldstein (3):
      ext4: do not update s_last_mounted of a frozen fs
         [db6516a5e7ddb6dc72d167b920f2f272596ea22d]
      ext4: factor out helper ext4_sample_last_mounted()
         [833a950882d33a7dfc319d5e152fdf35028936eb]
      vfs: add the sb_start_intwrite_trylock() helper
         [0c8e3fe35db9b66ae0030849545030ec7c0fc45c]

Andre Przywara (1):
      arm64: add missing data types in smp_load_acquire/smp_store_release
         [878a84d5a8a18a4ab241d40cebb791d6aedf5605]

Andrea Arcangeli (1):
      ksm: add cond_resched() to the rmap_walks
         [ad12695f177c3403a64348b42718faf9727fe358]

Andrew F. Davis (1):
      rpmsg: Correct support for MODULE_DEVICE_TABLE()
         [5b7d127726de6eed4b900bc3bbb167837690818f]

Andrew Morton (1):
      arch/x86/kernel/cpu/common.c: fix unused symbol warning
         [e48510f45107613bf14060eeabd658c49a044242]

Andri Yngvason (1):
      can: dev: Consolidate and unify state change handling
         [bac78aabcfece0c493b2ad824c68fbdc20448cbc]

Andy Lutomirski (1):
      fs/proc: Stop trying to report thread stacks
         [b18cb64ead400c01bf1580eeba330ace51f8087d]

Aneesh Kumar K.V (1):
      powerpc/mm/hash: Add missing isync prior to kernel stack SLB switch
         [91d06971881f71d945910de128658038513d1b24]

Anil Gurumurthy (1):
      scsi: qla2xxx: Return error when TMF returns
         [b4146c4929ef61d5afca011474d59d0918a0cd82]

Anna-Maria Gleixner (1):
      nohz: Fix local_timer_softirq_pending()
         [80d20d35af1edd632a5e7a3b9c0ab7ceff92769e]

Anssi Hannula (6):
      can: xilinx_can: fix RX loop if RXNEMP is asserted without RXOK
         [32852c561bffd613d4ed7ec464b1e03e1b7b6c5c]
      can: xilinx_can: fix RX overflow interrupt not being enabled
         [83997997252f5d3fc7f04abc24a89600c2b504ab]
      can: xilinx_can: fix device dropping off bus on RX overrun
         [2574fe54515ed3487405de329e4e9f13d7098c10]
      can: xilinx_can: fix incorrect clear of non-processed interrupts
         [2f4f0f338cf453bfcdbcf089e177c16f35f023c8]
      can: xilinx_can: fix recovery from error states not being propagated
         [877e0b75947e2c7acf5624331bb17ceb093c98ae]
      can: xilinx_can: keep only 1-2 frames in TX FIFO to fix TX accounting
         [620050d9c2be15c47017ba95efe59e0832e99a56]

Anton Vasilyev (1):
      can: ems_usb: Fix memory leak on ems_usb_disconnect()
         [72c05f32f4a5055c9c8fe889bb6903ec959c0aad]

Arnaldo Carvalho de Melo (9):
      perf script: Use readdir() instead of deprecated readdir_r()
         [a5e8e825bd1704c488bf6a46936aaf3b9f203d6a]
      perf thread_map: Correctly size buffer used with dirent->dt_name
         [bdf23a9a190d7ecea092fd5c4aabb7d4bd0a9980]
      perf thread_map: Use readdir() instead of deprecated readdir_r()
         [3354cf71104de49326d19d2f9bdb1f66eea52ef4]
      perf tools: Move syscall number fallbacks from perf-sys.h to tools/arch/x86/include/asm/
         [cec07f53c398f22576df77052c4777dc13f14962]
      perf tools: Use readdir() instead of deprecated readdir_r()
         [bfc279f3d233150ff260e9e93012e14f86810648]
      perf top: Use __fallthrough
         [7b0214b702ad8e124e039a317beeebb3f020d125]
      perf trace: Do not process PERF_RECORD_LOST twice
         [3ed5ca2efff70e9f589087c2013789572901112d]
      perf trace: Fix up fd -> pathname resolution
         [cdcd1e6bd8a92f8353fc2f37003c6eae2d1e6903]
      tools include: Add a __fallthrough statement
         [b5bf1733d6a391c4e90ea8f8468d83023be74a2a]

Arnd Bergmann (3):
      [media] ir-core: fix gcc-7 warning on bool arithmetic
         [bd7e31bbade02bc1e92aa00d5cf2cee2da66838a]
      arm64: use linux/types.h in kvm.h
         [d19279154b3fff9adff96b54d1a77dfb8f01e3da]
      video/omap: add module license tags
         [1bde9f2cf142b726412fa5b0e3cb557ff46952b0]

Artem Savkov (1):
      tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure
         [57ea2a34adf40f3a6e88409aafcf803b8945619a]

Bart Van Assche (1):
      scsi: sr: Avoid that opening a CD-ROM hangs with runtime power management enabled
         [1214fd7b497400d200e3f4e64e2338b303a20949]

Ben Hutchings (10):
      Revert "mtd: nand: omap2: Fix subpage write"
         [not upstream; reverted change is good but has larger dependencies]
      bcmgenet: Delete unused variable
         [not upstream; fixes incorrect backport]
      fnic: Fix misleading indentation
         [86001f248e943b7b22c22b50151ffaee9447df2d]
      iio: iio-trig-periodic-rtc: Free trigger resource  correctly
         [not upstream; driver was removed]
      rtl8723be: Fix misleading indentation
         [5c99f04fec93068147a3e95b439b345f203ac5b9]
      staging: rtl8192ee: Fix misleading indentation
         [not upstream; driver was removed from staging]
      staging: vt6656: Fix misleading indentation
         [not upstream; functions have been removed]
      string: drop __must_check from strscpy()
         [08a77676f9c5fc69a681ccd2cd8140e65dcb26c7]
      x86/apic: Fix build failure with X86_IO_APIC disabled
         [not upstream; failing configuration is no longer possible]
      x86/cpufeatures: Hide AMD-specific speculation flags
         [e7c587da125291db39ddf1f49b18e5970adbac17]

Bin Liu (1):
      usb: core: handle hub C_PORT_OVER_CURRENT condition
         [249a32b7eeb3edb6897dd38f89651a62163ac4ed]

Bjorn Helgaas (1):
      PCI: shpchp: Fix AMD POGO identification
         [bed4e9cfab93a0f3d0144cb919820e6d5c40b8b1]

Bo Chen (1):
      ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()
         [a3aa60d511746bd6c0d0366d4eb90a7998bcde8b]

Boris Brezillon (1):
      m68k: Implement ndelay() as an inline function to force type checking/casting
         [d8441ba80c55aad435e4b98fe0d7ad5d21e46bf9]

Boris Ostrovsky (1):
      xen: Remove unnecessary BUG_ON from __unbind_from_irq()
         [eef04c7b3786ff0c9cb1019278b6c6c2ea0ad4ff]

Borislav Petkov (1):
      x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()
         [1f74c8a64798e2c488f86efc97e308b85fb7d7aa]

Cannon Matthews (1):
      mm: hugetlb: yield when prepping struct pages
         [520495fe96d74e05db585fc748351e0504d8f40d]

Changbin Du (1):
      tracing: Fix missing return symbol in function_graph output
         [1fe4293f4b8de75824935f8d8e9a99c7fc6873da]

Chanho Park (1):
      perf tools: define _DEFAULT_SOURCE for glibc_2.20
         [512fe365373b9c95a70b4b6357503ee74d27214f]

Chas Williams (1):
      net/xen-netfront: only clean up queues if present
         [9a873c71e91cabf4c10fd9bbd8358c22deaf6c9e]

Chen-Yu Tsai (1):
      Input: i8042 - add Lenovo LaVie Z to the i8042 reset list
         [384cf4285b34e08917e3e66603382f2b0c4f6e1b]

Christophe Jaillet (1):
      scsi: qlogicpti: Fix an error handling path in 'qpti_sbus_probe()'
         [51b910c3c70986a5a0a84eea11cb8e904e37ba8b]

Colin Ian King (2):
      libata: zpodd: make arrays cdb static, reduces object code size
         [795ef788145ed2fa023efdf11e8d5d7bedc21462]
      media: smiapp: fix timeout checking in smiapp_read_nvm
         [7a2148dfda8001c983f0effd9afd8a7fa58e99c4]

Cong Wang (1):
      vsock: split dwork to avoid reinitializations
         [455f05ecd2b219e9a216050796d30c830d9bc393]

Corey Minyard (1):
      ipmi:bt: Set the timeout before doing a capabilities check
         [fe50a7d0393a552e4539da2d31261a59d6415950]

Dan Carpenter (10):
      ALSA: msnd: add some missing curly braces
         [096a020a9ef5c947577d3b57199bfc9b7e686b49]
      PCI: ibmphp: Fix use-before-set in get_max_bus_speed()
         [4051f5ebb11c6ef4b0d3eac2fbbd187c070656c5]
      USB: serial: ch341: fix type promotion bug in ch341_control_in()
         [e33eab9ded328ccc14308afa51b5be7cbe78d30b]
      dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()
         [c4c2b7644cc9a41f17a8cc8904efe3f66ae4c7ed]
      drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()
         [7f073d011f93e92d4d225526b9ab6b8b0bbd6613]
      libata: zpodd: small read overflow in eject_tray()
         [18c9a99bce2a57dfd7e881658703b5d7469cc7b9]
      mfd: tps65911-comparator: Fix a build error
         [ac1886165cd1201c5793099b6fbad1876bf98dfe]
      mwifiex: pcie: tighten a check in mwifiex_pcie_process_event_ready()
         [01eca2842874b9a85b7cd1e1b0e5b34a5d53a21f]
      qlogic: check kstrtoul() for errors
         [5fc853cc01c68f84984ecc2d5fd777ecad78240f]
      xhci: xhci-mem: off by one in xhci_stream_id_to_ring()
         [313db3d6488bb03b61b99de9dbca061f1fd838e1]

Dan Williams (2):
      x86/spectre_v1: Disable compiler optimizations over array_index_mask_nospec()
         [eab6870fee877258122a042bfd99ee7908c40280]
      x86/speculation: Fix up array_index_nospec_mask() asm constraint
         [be3233fbfcb8f5acb6e3bcd0895c3ef9e100d470]

Daniel Axtens (1):
      powerpc: make feature-fixup tests fortify-safe
         [c69a48cdb301a18697bc8c9935baf4f32861cf9e]

Daniel Jordan (1):
      mm/swapfile.c: fix swap_count comment about nonexistent SWAP_HAS_CONT
         [955c97f0859abef698e77f5697f5c4008303abb9]

Dave Martin (1):
      tty: pl011: Avoid spuriously stuck-off interrupts
         [4a7e625ce50412a7711efa0f2ef0b96ce3826759]

Dave Wysochanski (1):
      NFSv4: Fix possible 1-byte stack overflow in nfs_idmap_read_and_verify_message
         [d68894800ec5712d7ddf042356f11e36f87d7f78]

David Disseldorp (1):
      scsi: target: Fix truncated PR-in ReadKeys response
         [63ce3c384db26494615e3c8972bcd419ed71f4c4]

David Howells (1):
      VFS: Impose ordering on accesses of d_inode and d_flags
         [4bf46a272647d89e780126b52eda04737defd9f4]

David Rivshin (1):
      ARM: 8764/1: kgdb: fix NUMREGBYTES so that gdb_regs[] is the correct size
         [76ed0b803a2ab793a1b27d1dfe0de7955282cd34]

David Vrabel (4):
      xen-netfront: fix locking in connect error path
         [db8c8ab61a28d7e3eb86d247b342a853263262c3]
      xen-netfront: properly destroy queues when removing device
         [ad0681185770716523c81b156c44b9804d7b8ed2]
      xen-netfront: release per-queue Tx and Rx resource when disconnecting
         [a5b5dc3ce4df4f05f4d81c7d3c56a7604b242093]
      xen-netfront: use different locks for Rx and Tx stats
         [900e183301b54f8ca17a86d9835e9569090d182a]

Davide Caratti (1):
      net/sched: act_simple: fix parsing of TCA_DEF_DATA
         [8d499533e0bc02d44283dbdab03142b599b8ba16]

Dewet Thibaut (1):
      x86/MCE: Remove min interval polling limitation
         [fbdb328c6bae0a7c78d75734a738b66b86dffc96]

Dmitry Safonov (4):
      iommu/vt-d: Ratelimit each dmar fault printing
         [6c50d79f66382d78918a768374839d6d1b606d3f]
      netlink: Do not subscribe to non-existent groups
         [7acf9d4237c46894e0fa0492dd96314a41742e84]
      netlink: Don't shift on 64 for ngroups
         [91874ecf32e41b5d86a4cb9d60e0bee50d828058]
      netlink: Don't shift with UB on nlk->ngroups
         [61f4b23769f0cc72ae62c9a81cf08f0397d40da8]

Dmitry Torokhov (1):
      Input: i8042 - add TUXEDO BU1406 (N24_25BU) to the nomux list
         [a4c2a13129f7c5bcf81704c06851601593303fd5]

Doug Berger (1):
      PM / wakeup: Only update last time for active wakeup sources
         [2ef7c01c0cdb170142058c6d8fe0697aee4e4d7d]

Doug Ledford (1):
      RDMA/ipoib: Update paths on CLIENT_REREG/SM_CHANGE events
         [fa9391dbad4b868512ed22a7e41765f881a8a935]

Douglas Anderson (1):
      dm bufio: avoid sleeping while holding the dm_bufio lock
         [9ea61cac0b1ad0c09022f39fd97e9b99a2cfc2dc]

Eric Biggers (4):
      KEYS: DNS: fix parsing multiple options
         [c604cb767049b78b3075497b80ebb8fd530ea2cc]
      ext4: correct endianness conversion in __xattr_check_inode()
         [199625098a18a5522b424dea9b122b254c022fc5]
      ext4: don't read out of bounds when checking for in-inode xattrs
         [290ab230016f187c3551d8380ea742889276d03a]
      reiserfs: fix buffer overflow with long warning messages
         [fe10e398e860955bac4d28ec031b701d358465e4]

Eric Dumazet (6):
      net/packet: refine check for priv area size
         [eb73190f4fbeedf762394e92d6a4ec9ace684c88]
      net: metrics: add proper netlink validation
         [5b5e7a0de2bbf2a1afcd9f49e940010e9fb80d53]
      netfilter: ipv6: nf_defrag: reduce struct net memory waste
         [9ce7bc036ae4cfe3393232c86e9e1fea2153c237]
      netfilter: nf_queue: augment nfqa_cfg_policy
         [ba062ebb2cd561d404e0fba8ee4b3f5ebce7cbfc]
      rtnetlink: validate attributes in do_setlink()
         [644c7eebbfd59e72982d11ec6cc7d39af12450ae]
      xfrm_user: prevent leaking 2 bytes of kernel memory
         [45c180bc29babbedd6b8c01b975780ef44d9d09c]

Eric Engestrom (1):
      perf tools: Remove duplicate const qualifier
         [3b556bced46aa6b1873da7faa18eff235e896adc]

Eric W. Biederman (1):
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
         [7de712ccc096b81d23cc0a941cd9b8cb3956605d]

Evan Green (1):
      clk: qcom: Base rcg parent rate off plan frequency
         [c7d2a0eb6c028ba064bfe92d7667977418142c7c]

Fabian Frederick (1):
      can: constify of_device_id array
         [486e957033623656298a07c39a8bf2fd81db285b]

Florian Fainelli (1):
      net: ethernet: davinci_emac: Fix printing of base address
         [5a04e8f81a4f55ce1c2b7b525744a187c99ba302]

Florian Meier (1):
      gcov: add support for gcc version >= 6
         [d02038f972538b93011d78c068f44514fbde0a8c]

Florian Westphal (2):
      atl1c: reserve min skb headroom
         [6e56830776828d8ca9897fc4429eeab47c3bb432]
      xfrm: free skb if nlsk pointer is NULL
         [86126b77dcd551ce223e7293bb55854e3df05646]

Geert Uytterhoeven (1):
      time: Make sure jiffies_to_msecs() preserves non-zero time periods
         [abcbcb80cd09cd40f2089d912764e315459b71f7]

Geoff Levand (1):
      kexec: Fix make headers_check
         [9dc5c05f45ca8101025046cda7f8aca8835204f2]

Guillaume Nault (8):
      l2tp: clean up stale tunnel or session in pppol2tp_connect's error path
         [bda06be2158c7aa7e41b15500c4d3840369c19a6]
      l2tp: filter out non-PPP sessions in pppol2tp_tunnel_ioctl()
         [ecd012e45ab5fd76ed57546865897ce35920f56b]
      l2tp: fix missing refcount drop in pppol2tp_tunnel_ioctl()
         [f664e37dcc525768280cb94321424a09beb1c992]
      l2tp: fix pseudo-wire type for sessions created by pppol2tp_connect()
         [90904ff5f958a215cc3d26f957a46e80fa178470]
      l2tp: fix refcount leakage on PPPoL2TP sockets
         [3d609342cc04129ff7568e19316ce3d7451a27e8]
      l2tp: only accept PPP sessions in pppol2tp_connect()
         [7ac6ab1f8a38ba7f8d97f95475bb6a2575db4658]
      l2tp: prevent pppol2tp_connect() from creating kernel sockets
         [3e1bc8bf974e2d4e7beb842a4c801c2542eff3bd]
      l2tp: reject creation of non-PPP sessions on L2TPv2 tunnels
         [de9bada5d389903f4faf33980e6a95a2911c7e6d]

Gustavo A. R. Silva (2):
      HID: hiddev: fix potential Spectre v1
         [4f65245f2d178b9cba48350620d76faa4a098841]
      net: cxgb3_main: fix potential Spectre v1
         [676bcfece19f83621e905aa55b5ed2d45cc4f2d3]

Hangbin Liu (2):
      ipv6: mcast: fix unsolicited report interval after receiving querys
         [6c6da92808442908287fae8ebb0ca041a52469f4]
      multicast: do not restore deleted record source filter mode to new one
         [08d3ffcc0cfaba36f6b86fd568cc3bc773061fa6]

Hans de Goede (4):
      ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices
         [fdcb613d49321b5bf5d5a1bd0fba8e7c241dcc70]
      ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS
         [240630e61870e62e39a97225048f9945848fa5f5]
      libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
         [2cfce3a86b64b53f0a70e92a6a659c720c319b45]
      pwm: lpss: platform: Save/restore the ctrl register over a suspend/resume
         [1d375b58c12f08d8570b30b865def4734517f04f]

Herbert Xu (1):
      crypto: padlock-aes - Fix Nano workaround data corruption
         [46d8c4b28652d35dc6cfb5adf7f54e102fc04384]

Himanshu Madhani (1):
      scsi: qla2xxx: Fix setting lower transfer speed if GPSC fails
         [413c2f33489b134e3cc65d9c3ff7861e8fdfe899]

Houston Yaroschoff (1):
      usb: cdc_acm: Add quirk for Uniden UBC125 scanner
         [4a762569a2722b8a48066c7bacf0e1dc67d17fa1]

Huacai Chen (1):
      MIPS: io: Add barrier after register read in inX()
         [18f3e95b90b28318ef35910d21c39908de672331]

Huang Ying (1):
      mm: /proc/pid/pagemap: hide swap entries from unprivileged users
         [ab6ecf247a9321e3180e021a6a60164dee53ab2e]

Ingo Flaschberger (1):
      1wire: family module autoload fails because of upper/lower case mismatch.
         [065c09563c872e52813a17218c52cd642be1dca6]

Jack Morgenstein (1):
      net/mlx4_core: Save the qpn from the input modifier in RST2INIT wrapper
         [958c696f5a7274d9447a458ad7aa70719b29a50a]

Jan Kara (2):
      ext4: fix fencepost error in check for inode count overflow during resize
         [4f2f76f751433908364ccff82f437a57d0e6e9b7]
      udf: Detect incorrect directory size
         [fa65653e575fbd958bdf5fb9c4a71a324e39510d]

Jann Horn (3):
      ibmasm: don't write out of bounds in read handler
         [a0341fc1981a950c1e902ab901e98f60e0e243f3]
      netfilter: nf_log: don't hold nf_log_mutex during user access
         [ce00bf07cc95a57cd20b208e02b3c2604e532ae8]
      scsi: sg: mitigate read/write abuse
         [26b5b874aff5659a7e26e5b1997e3df2c41fa7fd]

Jason Wang (1):
      vhost_net: validate sock before trying to put its fd
         [b8f1f65882f07913157c44673af7ec0b308d03eb]

Jeff Layton (3):
      ceph: don't set req->r_locked_dir in ceph_d_revalidate
         [c3f4688a08fd86f1bf8e055724c84b7a40a09733]
      ceph: fix endianness of getattr mask in ceph_d_revalidate
         [1097680d759918ce4a8705381c0ab2ed7bd60cf1]
      nfsd: silence sparse warning about accessing credentials
         [ae4b884fc6316b3190be19448cea24b020c1cad6]

Jens Axboe (1):
      sbitmap: fix race in wait batch accounting
         [c854ab5773be1c1a0d3cef0c3a3261f2c48ab7f8]

Jeremy Cline (1):
      net: socket: fix potential spectre v1 gadget in socketcall
         [c8e8cd579bb4265651df8223730105341e61a2d1]

Jia He (1):
      mm/ksm.c: ignore STABLE_FLAG of rmap_item->address in rmap_walk_ksm()
         [1105a2fc022f3c7482e32faf516e8bc44095f778]

Jiang Biao (1):
      virtio_balloon: fix another race between migration and ballooning
         [89da619bc18d79bca5304724c11d4ba3b67ce2c6]

Jiri Olsa (2):
      perf tools: Fix python extension build for gcc 8
         [b7a313d84e853049062011d78cb04b6decd12f5c]
      perf tools: Fix snprint warnings for gcc 8
         [77f18153c080855e1c3fb520ca31a4e61530121d]

Jiri Slaby (3):
      p54: memset(0) whole array
         [6f17581788206444cbbcdbc107498f85e9765e3d]
      tty: vt, get rid of weird source code flow
         [34902b7f2754e6d890feb0cee34187f1bc75c930]
      tty: vt, remove reduntant check
         [182846a00f489849c55d113954f0c4a8a286ca39]

Joakim Tjernlund (4):
      mtd: cfi_cmdset_0002: Avoid walking all chips when unlocking.
         [f1ce87f6080b1dda7e7b1eda3da332add19d87b9]
      mtd: cfi_cmdset_0002: Fix unlocking requests crossing a chip boudary
         [0cd8116f172eed018907303dbff5c112690eeb91]
      mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()
         [f93aa8c4de307069c270b2d81741961162bead6c]
      mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips
         [5fdfc3dbad099281bf027a353d5786c09408a8e5]

Johan Hovold (7):
      USB: serial: cp210x: add CESINEL device ids
         [24160628a34af962ac99f2f58e547ac3c4cbd26f]
      USB: serial: keyspan_pda: fix modem-status error handling
         [01b3cdfca263a17554f7b249d20a247b2a751521]
      USB: serial: mos7840: fix status-register error handling
         [794744abfffef8b1f3c0c8a4896177d6d13d653d]
      backlight: as3711_bl: Fix Device Tree node leaks
         [d5318d302e7cf6583ec85a2a8bfbb3a3910ae372]
      backlight: as3711_bl: Fix Device Tree node lookup
         [4a9c8bb2aca5b5a2a15744333729745dd9903562]
      backlight: max8925_bl: Fix Device Tree node lookup
         [d1cc0ec3da23e44c23712579515494b374f111c9]
      backlight: tps65217_bl: Fix Device Tree node lookup
         [2b12dfa124dbadf391cb9a616aaa6b056823bf75]

John Syne (2):
      staging:iio:ade7854: Fix error handling on read/write
         [4297b23d927fa5265378f4a71372ecef3c33023a]
      staging:iio:ade7854: Fix the wrong number of bits to read
         [6cef2ab01636b6021044f349df466a97c408ec27]

Jon Derrick (1):
      ext4: check superblock mapped prior to committing
         [a17712c8e4be4fa5404d20e9cd3b2b21eae7bc56]

Joshua Frkuska (1):
      usb: gadget: u_audio: update hw_ptr in iso_complete after data copied
         [6b37bd78d30c890e575a1bda22978d1d2a233362]

Juergen Gross (1):
      xen/netfront: don't cache skb_shinfo()
         [d472b3a6cf63cd31cae1ed61930f07e6cd6671b5]

Julia Lawall (1):
      bnx2x: use the right constant
         [dd612f18a49b63af8b3a5f572d999bdb197385bc]

Julian Wiedmann (1):
      s390/qeth: don't clobber buffer on async TX completion
         [ce28867fd20c23cd769e78b4d619c4755bf71a1c]

Kai-Heng Feng (1):
      media: cx231xx: Add support for AverMedia DVD EZMaker 7
         [29e61d6ef061b012d320327af7dbb3990e75be45]

Kamal Heib (1):
      RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path
         [d63c46734c545ad0488761059004a65c46efdde3]

Karoly Pados (1):
      USB: serial: cp210x: add Silicon Labs IDs for Windows Update
         [2f839823382748664b643daa73f41ee0cc01ced6]

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio
         [3eb1b955cd7ed1e621ace856710006c2a8a7f231]

Kees Cook (2):
      binfmt_elf: fix calculations for bss padding
         [0036d1f7eb95bcc52977f15507f00dd07018e7e2]
      mm: refuse wrapped vm_brk requests
         [ba093a6d9397da8eafcfbaa7d95bd34255da39a0]

Keith Busch (1):
      block: Fix transfer when chunk sectors exceeds max
         [15bfd21fbc5d35834b9ea383dc458a1f0c9e3434]

Kiran Kumar Modukuri (5):
      cachefiles: Fix missing clear of the CACHEFILES_OBJECT_ACTIVE flag
         [5ce83d4bb7d8e11e8c1c687d09f4b5ae67ef3ce3]
      cachefiles: Fix refcounting bug in backing-file read monitoring
         [934140ab028713a61de8bca58c05332416d037d1]
      cachefiles: Wait rather than BUG'ing on "Unexpected object collision"
         [c2412ac45a8f8f1cd582723c1a139608694d410d]
      fscache: Allow cancelled operations to be enqueued
         [d0eb06afe712b7b103b6361f40a9a0c638524669]
      fscache: Fix reference overput in fscache_attach_object() error handling
         [f29507ce66701084c39aeb1b0ae71690cbff3554]

Konrad Rzeszutek Wilk (3):
      x86/bugs: Add AMD's SPEC_CTRL MSR usage
         [6ac2f49edb1ef5446089c7c660017732886d62d6]
      x86/bugs: Add AMD's variant of SSB_NO
         [24809860012e0130fbafe536709e08a22b3e959e]
      x86/bugs: Switch the selection of mitigation from CPU vendor to CPU features
         [108fab4b5c8f12064ef86e02cb0459992affb30f]

Konstantin Khlebnikov (1):
      pagemap: hide physical addresses from non-privileged users
         [1c90308e7a77af6742a97d1021cca923b23b7f0d]

Krzysztof Kozlowski (1):
      clk: si5351: Constify clock names and struct regmap_config
         [8234caed27f7bce141c9fb1f7e76c91a2a66d248]

Lars Persson (1):
      cifs: Fix use after free of a mid_q_entry
         [696e420bb2a6624478105651d5368d45b502b324]

Laura Abbott (2):
      staging: android: ion: Return an ERR_PTR in ion_map_kernel
         [0a2bc00341dcfcc793c0dbf4f8d43adf60458b05]
      staging: android: ion: Switch to pr_warn_once in ion_buffer_destroy
         [45ad559a29629cb1c64ee636563c69b71524f077]

Lee Jones (1):
      mfd: tps65911-comparator: Fix an off by one bug
         [1768391c3674b0c6bdc4947121f15fb0c2f47ec4]

Leon Romanovsky (4):
      RDMA/mlx4: Discard unknown SQP work requests
         [6b1ca7ece15e94251d1d0d919f813943e4a58059]
      RDMA/uverbs: Don't fail in creation of multiple flows
         [fe48aecb4df837540f13b5216f27ddb306aaf4b9]
      RDMA/uverbs: Fix slab-out-of-bounds in ib_uverbs_ex_create_flow
         [4fae7f170416f970e5655f7e945ce69286b1c4ff]
      RDMA/uverbs: Protect from attempts to create flows on unsupported QP
         [940efcc8889f0d15567eb07fc9fd69b06e366aa5]

Liang Z Li (1):
      xen-netfront: Remove the meaningless code
         [905726c1c5a3ca620ba7d73c78eddfb91de5ce28]

Linus Lüssing (2):
      batman-adv: Avoid storing non-TT-sync flags on singular entries too
         [4a519b83da16927fb98fd32b0f598e639d1f1859]
      batman-adv: Fix multicast TT issues with bogus ROAM flags
         [a44ebeff6bbd6ef50db41b4195fca87b21aefd20]

Linus Torvalds (2):
      squashfs: be more careful about metadata corruption
         [01cfb7937a9af2abb1136c7e89fbf3fd92952956]
      squashfs: more metadata hardening
         [d512584780d3e6a7cacb2f482834849453d444a1]

Lorenzo Bianconi (1):
      ipv4: remove BUG_ON() from fib_compute_spec_dst
         [9fc12023d6f51551d6ca9ed7e02ecc19d79caf17]

Lorenzo Stoakes (1):
      gcov: add support for GCC 5.1
         [3e44c471a2dab210f7e9b1e5f7d4d54d52df59eb]

Lubomir Rintel (1):
      usb: cdc_acm: Add quirk for Castles VEGA3000
         [1445cbe476fc3dd09c0b380b206526a49403c071]

Lukas Czerner (1):
      ext4: update mtime in ext4_punch_hole even if no blocks are released
         [eee597ac931305eff3d3fd1d61d6aae553bc0984]

Lyude Paul (1):
      drm/nouveau: Remove bogus crtc check in pmops_runtime_idle
         [68fe23a626b67b56c912c496ea43ed537ea9708f]

Maciej S. Szmigiero (1):
      X.509: unpack RSA signatureValue field from BIT STRING
         [b65c32ec5a942ab3ada93a048089a938918aba7f]

Mahesh Salgaonkar (1):
      powerpc/fadump: Unregister fadump on kexec down path.
         [722cde76d68e8cc4f3de42e71c82fd40dea4f7b9]

Marcelo Ricardo Leitner (1):
      sctp: fix identification of new acks for SFR-CACC
         [51446780fc33e45cb790c05a7fa2c5bf7e8bc53b]

Mark Rutland (1):
      arm64: ensure extension of smp_store_release value
         [994870bead4ab19087a79492400a5478e2906196]

Markos Chandras (2):
      MIPS: asm: compiler: Add new macros to set ISA and arch asm annotations
         [be5136988e25ae0dc8379fcb937efc63d87aba9e]
      MIPS: asmmacro: Ensure 64-bit FP registers are used with MSA
         [2bd7bc254ab1f45269db6dd7957d63b713817408]

Markus Pargmann (1):
      batman-adv: debugfs, avoid compiling for !DEBUG_FS
         [9bb218828c8f4fa6587af93e248903c96ce469d0]

Martin Kaiser (1):
      mtd: rawnand: mxc: set spare area size register explicitly
         [3f77f244d8ec28e3a0a81240ffac7d626390060c]

Martin Liska (1):
      gcov: support GCC 7.1
         [05384213436ab690c46d9dfec706b80ef8d671ab]

Masami Hiramatsu (1):
      ring_buffer: tracing: Inherit the tracing setting to next ring buffer
         [73c8d8945505acdcbae137c2e00a1232e0be709f]

Matt Turner (2):
      tools/power turbostat: Correct SNB_C1/C3_AUTO_UNDEMOTE defines
         [e0d34648b4d77ba715e13739d04e7b0692fe5eaa]
      x86: msr-index.h: Correct SNB_C1/C3_AUTO_UNDEMOTE defines
         [a00072a24a9f5b88cfc56f2dec6afe8ce3874e60]

Mauro Carvalho Chehab (5):
      [media] drxd_hard: fix bad alignments
         [cea130021448763b15f4b16af184bbab4be118fb]
      [media] drxk_hard: fix bad alignments
         [89fffac802c18caebdf4e91c0785b522c9f6399a]
      media: dvb_frontend: fix locking issues at dvb_frontend_get_event()
         [76d81243a487c09619822ef8e7201a756e58a87d]
      media: omap3isp/isp: remove an unused static var
         [3f4836beb2ebeb0211d9911d878a267d687e0e6e]
      media: v4l2-compat-ioctl32: prevent go past max size
         [ea72fbf588ac9c017224dcdaa2019ff52ca56fee]

Max Gurtovoy (1):
      IB/isert: fix T10-pi check mask setting
         [0e12af84cdd3056460f928adc164f9e87f4b303b]

Maxim Moseychuk (1):
      usb: do not reset if a low-speed or full-speed device timed out
         [6e01827ed93947895680fbdad68c072a0f4e2450]

Michael Ellerman (2):
      powerpc/lib: Fix feature fixup test of external branch
         [32810d91325ec76b8ef4df463f8a0e9baf353322]
      powerpc/lib: Fix the feature fixup tests to actually work
         [cad0e39023b43d94d5e38dfd55c103e15bdd093d]

Michael Jeanson (1):
      powerpc/e500mc: Set assembler machine type to e500mc
         [69a8405999aa1c489de4b8d349468f0c2b83f093]

Michael Karcher (1):
      net-next: ax88796: Do not free IRQ in ax_remove() (already freed in ax_close()).
         [9144c3795c2636351d553e4d0fc5297201182de2]

Michael Neuling (2):
      powerpc/ptrace: Fix enforcement of DAWR constraints
         [cd6ef7eebf171bfcba7dc2df719c2a4958775040]
      powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_DEBUGREG
         [4f7c06e26ec9cf7fe9f0c54dc90079b6a4f4b2c3]

Michael Schmitz (1):
      m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()
         [3f90f9ef2dda316d64e420d5d51ba369587ccc55]

Michal Hocko (2):
      mm, elf: handle vm_brk error
         [ecc2bc8ac03884266cf73f8a2a42b911465b2fbc]
      mm: do not bug_on on incorrect length in __mm_populate()
         [bb177a732c4369bb58a1fe1df8f552b6f0f7db5f]

Mika Westerberg (1):
      PCI: pciehp: Clear Presence Detect and Data Link Layer Status Changed on resume
         [13c65840feab8109194f9490c9870587173cb29d]

Mike Marciniszyn (1):
      IB/qib: Fix DMA api warning with debug kernel
         [0252f73334f9ef68868e4684200bea3565a4fcee]

Mike Snitzer (1):
      dm thin: handle running out of data space vs concurrent discard
         [a685557fbbc3122ed11e8ad3fa63a11ebc5de8c3]

Miklos Szeredi (2):
      fuse: atomic_o_trunc should truncate pagecache
         [df0e91d488276086bc07da2e389986cae0048c37]
      fuse: fix control dir setup and teardown
         [6becdb601bae2a043d7fb9762c4d48699528ea6e]

Mikulas Patocka (3):
      branch-check: fix long->int truncation when profiling branches
         [2026d35741f2c3ece73c11eb7e4a15d7c2df9ebe]
      dm bufio: drop the lock when doing GFP_NOIO allocation
         [41c73a49df31151f4ff868f28fe4f129f113fa2c]
      drm/udl: fix display corruption of the last line
         [99ec9e77511dea55d81729fc80b6c63a61bfa8e0]

Ming_qian (1):
      media: uvcvideo: Support realtek's UVC 1.5 device
         [f620d1d7afc7db57ab59f35000752840c91f67e7]

Nathan Chancellor (1):
      kconfig: Avoid format overflow warning from GCC 8.1
         [2ae89c7a82ea9d81a19b4fc2df23bef4b112f24e]

Nathan Sullivan (1):
      leds: do not overflow sysfs buffer in led_trigger_show
         [3b9b95363c45365d606ad4bbba16acca75fdf6d3]

NeilBrown (1):
      w1: support auto-load of w1_bq27000 module.
         [4b7e4f8289c1ca60accb6c1baf31984f69bc2771]

Nicholas Mc Guire (2):
      can: mpc5xxx_can: check of_iomap return before use
         [b5c1a23b17e563b656cc9bb76ce5323b997d90e8]
      drm: re-enable error handling
         [d530b5f1ca0bb66958a2b714bebe40a1248b9c15]

Nico Sneck (1):
      usb: quirks: add delay quirks for Corsair Strafe
         [bba57eddadda936c94b5dccf73787cb9e159d0a5]

OGAWA Hirofumi (1):
      fat: fix memory allocation failure handling of match_strdup()
         [35033ab988c396ad7bce3b6d24060c16a9066db8]

Olli Salonen (1):
      USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick
         [367b160fe4717c14a2a978b6f9ffb75a7762d3ed]

Omar Sandoval (3):
      Btrfs: don't BUG_ON() in btrfs_truncate_inode_items()
         [0552210997badb6a60740a26ff9d976a416510f0]
      Btrfs: don't return ino to ino cache if inode item removal fails
         [c08db7d8d295a4f3a10faaca376de011afff7950]
      Btrfs: reserve space for O_TMPFILE orphan item deletion
         [399b0bbf5f680797d3599fa14f16706ffc470145]

Oscar Salvador (1):
      fs, elf: make sure to page align bss in load_elf_library
         [24962af7e1041b7e50c1bc71d8d10dc678c556b5]

Paul Bolle (1):
      eeepc-laptop: simplify parse_arg()
         [95369a73a957ad221f1d6b8f11a63a376f38c544]

Paul Burton (1):
      MIPS: Fix off-by-one in pci_resource_to_user()
         [38c0a74fe06da3be133cae3fb7bde6a9438e698b]

Paulo Alcantara (1):
      cifs: Fix infinite loop when using hard mount option
         [7ffbe65578b44fafdef577a360eb0583929f7c6e]

Paweł Chmiel (2):
      pinctrl: samsung: Correct EINTG banks order
         [5cf9a338db94cfd570aa2607bef1b30996f188e3]
      regulator: max8998: Fix platform data retrieval.
         [c1472737914fe5246a672fef6e85c9455de8473f]

Prabhakar Lad (1):
      media: platform: davinci: drop VPFE_CMD_S_CCDC_RAW_PARAMS
         [d75cf0144f150272be806b69b4e62553ba07ea1b]

Pranay Kr. Srivastava (1):
      ext4: Fix WARN_ON_ONCE in ext4_commit_super()
         [4743f83990614af6adb09ea7aa3c37b78c4031ab]

Quinn Tran (1):
      scsi: qla2xxx: Fix ISP recovery on unload
         [b08abbd9f5996309f021684f9ca74da30dcca36a]

Rasmus Villemoes (1):
      net/wireless/brcm80211/brcmfmac: Make return type and name reflect actual semantics
         [e843bb199ba58ce5d1364d4c82fcf6975f08eec2]

Ronnie Sahlberg (1):
      cifs: store the leaseKey in the fid on SMB2_open
         [96164ab2d880c9539989bea68d4790f6fd619b1f]

Ross Lagerwall (4):
      xen-netfront: Fix mismatched rtnl_unlock
         [cb257783c2927b73614b20f915a91ff78aa6f3e8]
      xen-netfront: Fix race between device setup and open
         [f599c64fdf7d9c108e8717fb04bc41c680120da4]
      xen-netfront: Improve error handling during initialization
         [e2e004acc7cbe3c531e752a270a74e95cde3ea48]
      xen-netfront: Update features after registering netdev
         [45c8184c1bed1ca8a7f02918552063a00b909bf5]

Sabrina Dubroca (1):
      ip6mr: only set ip6mr_table from setsockopt when ip6mr_new_table succeeds
         [848235edb5c93ed086700584c8ff64f6d7fc778d]

Sakari Ailus (1):
      media: v4l: event: Prevent freeing event subscriptions while accessed
         [ad608fbcf166fec809e402d548761768f602702c]

Scott Mayhew (1):
      nfsd: restrict rd_maxcount to svc_max_payload in nfsd_encode_readdir
         [9c2ece6ef67e9d376f32823086169b489c422ed0]

Sean Young (1):
      media: rc: mce_kbd decoder: fix stuck keys
         [63039c29f7a4ce8a8bd165173840543c0098d7b0]

Sergey Senozhatsky (1):
      tools/lib/subcmd/pager.c: do not alias select() params
         [ad343a98e74e85aa91d844310e797f96fee6983b]

Shuah Khan (1):
      usbip: stub_rx: fix static checker warning on unnecessary checks
         [10c90120930628e8b959bf58d4a0aaef3ae5d945]

Siarhei Liakh (1):
      x86: Call fixup_exception() before notify_die() in math_error()
         [3ae6295ccb7cf6d344908209701badbbbb503e40]

Silvio Cesare (1):
      UBIFS: Fix potential integer overflow in allocation
         [353748a359f1821ee934afc579cf04572406b420]

Simon Wunderlich (1):
      batman-adv: unify flags access style in tt global add
         [ad7e2c466d8b0a7056cd248e1df6bb7296e014f7]

Snild Dolkow (1):
      kthread, tracing: Don't expose half-written comm when creating kthreads
         [3e536e222f2930534c252c1cc7ae799c725c5ff9]

Song Liu (1):
      perf/core: Fix group scheduling with mixed hw and sw events
         [a1150c202207cc8501bebc45b63c264f91959260]

Srinivas Kandagatla (2):
      ASoC: dapm: delete dapm_kcontrol_data paths list before freeing it
         [ff2faf1289c1f81b5b26b9451dd1c2006aac8db8]
      of: platform: stop accessing invalid dev in of_platform_device_destroy
         [522811e944ed9b36806faa019faec10f9d259cca]

Stefan Agner (1):
      mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states
         [92748beac07c471d995fbec642b63572dc01b3dc]

Stefan M Schaeckeler (1):
      of: unittest: for strings, account for trailing \\0 in property length field
         [3b9cf7905fe3ab35ab437b5072c883e609d3498d]

Stefan Potyra (1):
      w1: mxc_w1: Enable clock before calling clk_get_rate() on it
         [955bc61328dc0a297fb3baccd84e9d3aee501ed8]

Stefano Brivio (2):
      cifs: Fix stack out-of-bounds in smb{2,3}_create_lease_buf()
         [729c0c9dd55204f0c9a823ac8a7bfa83d36c7e78]
      skbuff: Unconditionally copy pfmemalloc in __skb_clone()
         [e78bfb0751d4e312699106ba7efbed2bab1a53ca]

Steffen Maier (7):
      scsi: zfcp: fix misleading REC trigger trace where erp_action setup failed
         [512857a795cbbda5980efa4cdb3c0b6602330408]
      scsi: zfcp: fix missing REC trigger trace for all objects in ERP_FAILED
         [8c3d20aada70042a39c6a6625be037c1472ca610]
      scsi: zfcp: fix missing REC trigger trace on enqueue without ERP thread
         [6a76550841d412330bd86aed3238d1888ba70f0e]
      scsi: zfcp: fix missing REC trigger trace on terminate_rport_io early return
         [96d9270499471545048ed8a6d7f425a49762283d]
      scsi: zfcp: fix missing REC trigger trace on terminate_rport_io for ERP_FAILED
         [d70aab55924b44f213fec2b900b095430b33eec6]
      scsi: zfcp: fix missing SCSI trace for result of eh_host_reset_handler
         [df30781699f53e4fd4c494c6f7dd16e3d5c21d30]
      scsi: zfcp: fix missing SCSI trace for retry of abort / scsi_eh TMF
         [81979ae63e872ef650a7197f6ce6590059d37172]

Steven Rostedt (3):
      tracing: Fix double free of event_trigger_data
         [1863c387259b629e4ebfb255495f67cd06aa229b]
      tracing: Fix possible double free in event_enable_trigger_func()
         [15cc78644d0075e76d59476a4467e7143860f660]
      tracing: Quiet gcc warning about maybe unused link variable
         [2519c1bbe38d7acacc9aacba303ca6f97482ed53]

Sven Eckelmann (3):
      batman-adv: Fix debugfs path for renamed hardif
         [36dc621ceca1be3ec885aeade5fdafbbcc452a6d]
      batman-adv: Fix debugfs path for renamed softif
         [6da7be7d24b2921f8215473ba7552796dff05fe1]
      cfg80211: initialize sinfo in cfg80211_get_station
         [3c12d0486856b9eb89c2a9ac336713cba90813e3]

Tadeusz Struk (1):
      tpm: fix race condition in tpm_common_write()
         [3ab2011ea368ec3433ad49e1b9e1c7b70d2e65df]

Takashi Iwai (5):
      ALSA: core: Assure control device to be registered at last
         [dc82e52492f684dcd5ed9e4773e72dbf2203d75e]
      ALSA: hda/conexant - Add fixup for HP Z2 G4 workstation
         [f16041df4c360eccacfe90f96673b37829e4c959]
      ALSA: hda/realtek - Add a quirk for FSC ESPRIMO U9210
         [275ec0cb946cb75ac8977f662e608fce92f8b8a8]
      ALSA: timer: Fix UBSAN warning at SNDRV_TIMER_IOCTL_NEXT_DEVICE ioctl
         [b41f794f284966fd6ec634111e3b40d241389f96]
      xen-netfront: Use static attribute groups for sysfs entries
         [27b917e54bed7156c2b0249969ace34a5f585626]

Takashi Sakamoto (1):
      ALSA: hda/ca0132: fix build failure when a local macro is defined
         [8e142e9e628975b0dddd05cf1b095331dff6e2de]

Tetsuo Handa (4):
      driver core: Don't ignore class_dir_create_and_add() failure.
         [84d0c27d6233a9ba0578b20f5a09701eb66cee42]
      fuse: don't keep dead fuse_conn at fuse_fill_super().
         [543b8f8662fe6d21f19958b666ab0051af9db21a]
      n_tty: Access echo_* variables carefully.
         [ebec3f8f5271139df618ebdf8427e24ba102ba94]
      n_tty: Fix stall at n_tty_receive_char_special().
         [3d63b7e4ae0dc5e02d28ddd2fa1f945defc68d81]

Thadeu Lima de Souza Cascardo (1):
      fs/binfmt_misc.c: do not allow offset overflow
         [5cc41e099504b77014358b58567c5ea6293dd220]

Theodore Ts'o (7):
      ext4: add more mount time checks of the superblock
         [bfe0a5f47ada40d7984de67e59a7d3390b9b9ecc]
      ext4: bubble errors from ext4_find_inline_data_nolock() up to ext4_iget()
         [eb9b5f01c33adebc31cbc236c02695f605b0e417]
      ext4: check for allocation block validity with block group locked
         [8d5a803c6a6ce4ec258e31f76059ea5153ba46ef]
      ext4: check if in-inode xattr is corrupted in ext4_expand_extra_isize_ea()
         [9e92f48c34eb2b9af9d12f892e2fe1fce5e8ce35]
      ext4: fix inline data updates with checksums enabled
         [362eca70b53389bddf3143fe20f53dcce2cfdf61]
      ext4: include the illegal physical block in the bad map ext4_error msg
         [bdbd6ce01a70f02e9373a584d0ae9538dcf0a121]
      random: mix rdrand with entropy sent in from userspace
         [81e69df38e2911b642ec121dec319fad2a4782f3]

Thomas Richter (2):
      perf: fix invalid bit in diagnostic entry
         [3c0a83b14ea71fef5ccc93a3bd2de5f892be3194]
      s390/cpum_sf: Add data entry sizes to sampling trailer entry
         [77715b7ddb446bd39a06f3376e85f4bb95b29bb8]

Tobias Jordan (1):
      spi: pxa2xx: check clk_prepare_enable() return value
         [62bbc864d1946c715063bd481bff3641fd1324e2]

Tokunori Ikegami (5):
      MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum
         [2a027b47dba6b77ab8c8e47b589ae9bbc5ac6175]
      mtd: cfi_cmdset_0002: Change definition naming to retry write operation
         [85a82e28b023de9b259a86824afbd6ba07bd6475]
      mtd: cfi_cmdset_0002: Change erase functions to check chip good only
         [79ca484b613041ca223f74b34608bb6f5221724b]
      mtd: cfi_cmdset_0002: Change erase functions to retry for error
         [45f75b8a919a4255f52df454f1ffdee0e42443b2]
      mtd: cfi_cmdset_0002: Change write buffer to check correct value
         [dfeae1073583dc35c33b32150e18b7048bbb37e6]

Tom Lendacky (1):
      x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR
         [612bc3b3d4be749f73a513a17d9b3ee1330d3487]

Tomasz Kramkowski (2):
      HID: clamp input to logical range if no null state
         [c3883fe06488a483658ba5d849b70e49bee15e7c]
      HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter
         [9547837bdccb4af127528b36a73377150658b4ac]

Tommi Rantala (1):
      xfrm: fix missing dst_release() after policy blocking lbcast and multicast
         [8cc88773855f988d6a3bbf102bbd9dd9c828eb81]

Tushar Behera (1):
      usb: misc: usb3503: Update error code in print message
         [ec5734c41bee2ee7c938a8f34853d31cada7e67a]

Ulrik De Bie (1):
      Input: elantech - report the middle button of the touchpad
         [f386474e12a560e005ec7899e78f51f6bdc3cf41]

Valtteri Heikkilä (1):
      HID: reject input outside logical range only if null state is set
         [3f3752705dbd50b66b66ad7b4d54fe33d2f746ed]

Ville Syrjälä (1):
      x86/apm: Don't access __preempt_count with zeroed fs
         [6f6060a5c9cc76fdbc22748264e6aa3779ec2427]

Vineet Gupta (1):
      ARC: mm: allow mprotect to make stack mappings executable
         [93312b6da4df31e4102ce5420e6217135a16c7ea]

Vitaly Kuznetsov (1):
      xen-netfront: avoid crashing on resume after a failure in talk_to_netback()
         [d86b5672b1adb98b4cdd6fbf0224bbfb03db6e2e]

Vladimir Zapolskiy (1):
      sh_eth: fix invalid context bug while changing link options by ethtool
         [5cb3f52a11e18628fc4bee76dd14b1f0b76349de]

Vlastimil Babka (1):
      mm, page_alloc: do not break __GFP_THISNODE by zonelist reset
         [7810e6781e0fcbca78b91cf65053f895bf59e85f]

Wanpeng Li (1):
      KVM: x86: fix escape of guest dr6 to the host
         [efdab992813fb2ed825745625b83c05032e9cda2]

Willem de Bruijn (1):
      packet: refine ring v3 block size test to hold one frame
         [4576cd469d980317c4edd9173f8b694aa71ea3a3]

Xunlei Pang (1):
      sched/fair: Fix bandwidth timer clock drift condition
         [512ac999d2755d2b7109e996a76b6fb8b888631d]

Yoshihiro Shimoda (2):
      usb: gadget: function: printer: avoid spinlock recursion
         [9ada8c582088d32bd5c071c17213bc6edf37443a]
      usb: gadget: function: printer: avoid wrong list handling in printer_write()
         [4a014a7339f441b0851ce012f469c0fadac61c81]

YueHaibing (1):
      net: caif: Add a missing rcu_read_unlock() in caif_flow_cb
         [64119e05f7b31e83e2555f6782e6cdc8f81c63f4]

Yuiko Oshino (1):
      smsc75xx: Add workaround for gigabit link up hardware errata.
         [d461e3da905332189aad546b2ad9adbe6071c7cc]

Zheng Yan (2):
      ceph: fix llistxattr on symlink
         [0abb43dcacb52145aa265f82c914375d59dfe2da]
      ceph: use lookup request to revalidate dentry
         [200fd27c8fa2ba8bb4529033967b69a7cbfa2c2e]

Zhong Jiang (1):
      sched/topology: Make local variables static
         [ace8031099f91480799b5929b4cccf2dcacc5136]

 Documentation/filesystems/proc.txt                 |  31 +-
 Makefile                                           |   4 +-
 arch/arc/include/asm/page.h                        |   2 +-
 arch/arc/include/asm/pgtable.h                     |   2 +-
 arch/arm/boot/dts/da850.dtsi                       |   6 +-
 arch/arm/include/asm/kgdb.h                        |   2 +-
 arch/arm64/include/asm/barrier.h                   |  20 ++
 arch/arm64/include/uapi/asm/kvm.h                  |   2 +-
 arch/m68k/include/asm/delay.h                      |  11 +-
 arch/m68k/mm/kmap.c                                |   3 +-
 arch/mips/bcm47xx/setup.c                          |   6 +
 arch/mips/include/asm/asmmacro.h                   |  11 +
 arch/mips/include/asm/compiler.h                   |   6 +
 arch/mips/include/asm/io.h                         |   2 +
 arch/mips/include/asm/mipsregs.h                   |   3 +
 arch/mips/include/asm/pci.h                        |   2 +-
 arch/powerpc/Makefile                              |   1 +
 arch/powerpc/kernel/entry_64.S                     |   1 +
 arch/powerpc/kernel/fadump.c                       |   3 +
 arch/powerpc/kernel/hw_breakpoint.c                |   4 +-
 arch/powerpc/kernel/ptrace.c                       |   1 +
 arch/powerpc/lib/feature-fixups-test.S             |   4 +-
 arch/powerpc/lib/feature-fixups.c                  | 180 +++++------
 arch/s390/include/asm/cpu_mf.h                     |   6 +-
 arch/x86/include/asm/apm.h                         |   6 -
 arch/x86/include/asm/barrier.h                     |   4 +-
 arch/x86/include/asm/cpufeature.h                  |   8 +-
 arch/x86/include/uapi/asm/msr-index.h              |   4 +-
 arch/x86/kernel/apic/apic.c                        |   3 +-
 arch/x86/kernel/apm_32.c                           |   5 +
 arch/x86/kernel/cpu/bugs.c                         |  17 +-
 arch/x86/kernel/cpu/common.c                       |  13 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |  21 +-
 arch/x86/kernel/traps.c                            |  14 +-
 arch/x86/kvm/cpuid.c                               |  10 +-
 arch/x86/kvm/cpuid.h                               |   2 +-
 arch/x86/kvm/svm.c                                 |   2 +-
 arch/x86/kvm/x86.c                                 |   6 +
 arch/xtensa/kernel/traps.c                         |   2 +-
 block/blk-mq-tag.c                                 |  42 ++-
 crypto/asymmetric_keys/x509_cert_parser.c          |   9 +
 drivers/acpi/acpi_lpss.c                           |   1 +
 drivers/ata/ahci.c                                 |  59 ++++
 drivers/ata/libata-core.c                          |   6 +-
 drivers/ata/libata-zpodd.c                         |   4 +-
 drivers/base/core.c                                |  14 +-
 drivers/base/power/wakeup.c                        |   1 -
 drivers/char/ipmi/ipmi_bt_sm.c                     |   3 +-
 drivers/char/random.c                              |  10 +-
 drivers/char/tpm/tpm-dev.c                         |  41 ++-
 drivers/clk/clk-si5351.c                           |  10 +-
 drivers/clk/qcom/clk-rcg2.c                        |   1 +
 drivers/crypto/padlock-aes.c                       |   8 +-
 drivers/dma/k3dma.c                                |   2 +-
 drivers/gpu/drm/drm_context.c                      |   2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   7 -
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   4 +-
 drivers/gpu/drm/udl/udl_fb.c                       |   5 +-
 drivers/gpu/drm/udl/udl_transfer.c                 |  11 +-
 drivers/hid/hid-ids.h                              |   3 +
 drivers/hid/hid-input.c                            |  20 +-
 drivers/hid/usbhid/hid-quirks.c                    |   1 +
 drivers/hid/usbhid/hiddev.c                        |  11 +
 drivers/infiniband/core/uverbs_cmd.c               |  27 +-
 drivers/infiniband/hw/mlx4/mad.c                   |   1 -
 drivers/infiniband/hw/mlx5/srq.c                   |  18 +-
 drivers/infiniband/hw/qib/qib.h                    |   3 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |  10 +-
 drivers/infiniband/hw/qib/qib_user_pages.c         |  20 +-
 drivers/infiniband/ulp/ipoib/ipoib.h               |   2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |  33 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  27 +-
 drivers/input/mouse/elantech.c                     |  28 +-
 drivers/input/serio/i8042-x86ia64io.h              |  14 +
 drivers/iommu/dmar.c                               |   8 +-
 drivers/leds/led-triggers.c                        |  12 +-
 drivers/md/dm-bufio.c                              |  15 +-
 drivers/md/dm-thin.c                               |  11 +-
 drivers/media/dvb-core/dvb_frontend.c              |  23 +-
 drivers/media/dvb-frontends/drxd_hard.c            |   3 +-
 drivers/media/dvb-frontends/drxk_hard.c            |   3 +-
 drivers/media/i2c/smiapp/smiapp-core.c             |  11 +-
 drivers/media/platform/davinci/ccdc_hw_device.h    |  10 -
 drivers/media/platform/davinci/dm355_ccdc.c        |  92 +-----
 drivers/media/platform/davinci/dm644x_ccdc.c       | 151 +--------
 drivers/media/platform/davinci/vpfe_capture.c      |  75 -----
 drivers/media/platform/omap3isp/isp.c              |   7 -
 drivers/media/rc/imon.c                            |   2 +-
 drivers/media/rc/ir-mce_kbd-decoder.c              |   2 +
 drivers/media/usb/cx231xx/cx231xx-cards.c          |   3 +
 drivers/media/usb/uvc/uvc_video.c                  |  24 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |   2 +-
 drivers/media/v4l2-core/v4l2-event.c               |  38 +--
 drivers/media/v4l2-core/v4l2-fh.c                  |   2 +
 drivers/mfd/tps65911-comparator.c                  |  17 +-
 drivers/misc/ibmasm/ibmasmfs.c                     |  27 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  18 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                |  51 ++--
 drivers/mtd/nand/mxc_nand.c                        |   5 +-
 drivers/mtd/nand/omap2.c                           | 340 +++++++--------------
 drivers/net/can/cc770/cc770_platform.c             |   2 +-
 drivers/net/can/dev.c                              |  78 +++++
 drivers/net/can/grcan.c                            |   2 +-
 drivers/net/can/mscan/mpc5xxx_can.c                |   7 +-
 drivers/net/can/sja1000/sja1000_platform.c         |   2 +-
 drivers/net/can/usb/ems_usb.c                      |   1 +
 drivers/net/can/xilinx_can.c                       | 323 ++++++++++++++++----
 drivers/net/ethernet/8390/ax88796.c                |   1 -
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |   1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   1 -
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |   2 +
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   8 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  |   2 +
 drivers/net/ethernet/renesas/sh_eth.c              |  47 +--
 drivers/net/ethernet/ti/davinci_emac.c             |   4 +-
 drivers/net/usb/smsc75xx.c                         |  62 ++++
 drivers/net/wireless/brcm80211/brcmfmac/p2p.c      |   2 +-
 .../net/wireless/brcm80211/brcmfmac/wl_cfg80211.c  |   7 +-
 .../net/wireless/brcm80211/brcmfmac/wl_cfg80211.h  |   2 +-
 drivers/net/wireless/mwifiex/pcie.c                |   3 +-
 drivers/net/wireless/p54/fwio.c                    |   2 +-
 drivers/net/wireless/rtlwifi/rtl8723be/hw.c        |   2 +-
 drivers/net/xen-netfront.c                         | 295 +++++++-----------
 drivers/of/platform.c                              |   4 +-
 drivers/of/selftest.c                              |   8 +-
 drivers/pci/hotplug/ibmphp_core.c                  |   2 +-
 drivers/pci/hotplug/pciehp.h                       |   2 +-
 drivers/pci/hotplug/pciehp_core.c                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c                   |  13 +-
 drivers/pci/hotplug/shpchp_ctrl.c                  |   8 +-
 drivers/pinctrl/pinctrl-exynos.c                   |   2 +-
 drivers/platform/x86/eeepc-laptop.c                |  36 +--
 drivers/pwm/pwm-lpss.c                             |  24 ++
 drivers/regulator/max8998.c                        |   3 +-
 drivers/s390/net/qeth_core.h                       |  11 +
 drivers/s390/net/qeth_core_main.c                  |  22 +-
 drivers/s390/scsi/zfcp_dbf.c                       |  39 +++
 drivers/s390/scsi/zfcp_erp.c                       | 123 ++++++--
 drivers/s390/scsi/zfcp_ext.h                       |   5 +
 drivers/s390/scsi/zfcp_scsi.c                      |  18 +-
 drivers/scsi/fnic/fnic_fcs.c                       |   3 +-
 drivers/scsi/qla2xxx/qla_init.c                    |  10 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   5 +-
 drivers/scsi/qlogicpti.c                           |   6 +-
 drivers/scsi/sg.c                                  |  42 ++-
 drivers/scsi/sr.c                                  |  33 +-
 drivers/spi/spi-pxa2xx.c                           |  18 +-
 drivers/staging/android/ion/ion.c                  |   5 +-
 drivers/staging/android/ion/ion_heap.c             |   2 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |  26 +-
 drivers/staging/iio/meter/ade7854.c                |  10 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   6 +-
 .../staging/rtl8192ee/btcoexist/halbtc8821a2ant.c  |   4 +-
 drivers/staging/rtl8192ee/rtl8192ee/hw.c           |  14 +-
 drivers/staging/usbip/stub_rx.c                    |  11 +-
 drivers/staging/vt6656/dpc.c                       |   4 +-
 drivers/staging/vt6656/main_usb.c                  |  23 +-
 drivers/target/target_core_pr.c                    |  22 +-
 drivers/tty/n_tty.c                                |  55 ++--
 drivers/tty/serial/amba-pl011.c                    |  15 +
 drivers/tty/vt/vt.c                                |  76 ++---
 drivers/usb/class/cdc-acm.c                        |   6 +
 drivers/usb/core/hub.c                             |  12 +-
 drivers/usb/core/quirks.c                          |   4 +
 drivers/usb/gadget/f_uac2.c                        |   8 +-
 drivers/usb/gadget/printer.c                       |  13 +-
 drivers/usb/host/xhci-mem.c                        |   2 +-
 drivers/usb/misc/usb3503.c                         |   3 +-
 drivers/usb/serial/ch341.c                         |   2 +-
 drivers/usb/serial/cp210x.c                        |  15 +
 drivers/usb/serial/keyspan_pda.c                   |   4 +-
 drivers/usb/serial/mos7840.c                       |   3 +
 drivers/vhost/net.c                                |   3 +-
 drivers/video/backlight/as3711_bl.c                |  45 ++-
 drivers/video/backlight/max8925_bl.c               |   4 +-
 drivers/video/backlight/tps65217_bl.c              |   4 +-
 drivers/video/fbdev/omap/lcd_ams_delta.c           |   4 +
 drivers/video/fbdev/omap/lcd_h3.c                  |   4 +
 drivers/video/fbdev/omap/lcd_htcherald.c           |   4 +
 drivers/video/fbdev/omap/lcd_inn1510.c             |   4 +
 drivers/video/fbdev/omap/lcd_inn1610.c             |   4 +
 drivers/video/fbdev/omap/lcd_osk.c                 |   4 +
 drivers/video/fbdev/omap/lcd_palmte.c              |   4 +
 drivers/video/fbdev/omap/lcd_palmtt.c              |   4 +
 drivers/video/fbdev/omap/lcd_palmz71.c             |   4 +
 drivers/virtio/virtio_balloon.c                    |   2 +
 drivers/w1/masters/mxc_w1.c                        |  20 +-
 drivers/w1/slaves/w1_bq27000.c                     |   4 +-
 drivers/w1/w1.c                                    |   2 +-
 drivers/w1/w1_family.h                             |   1 +
 drivers/xen/events/events_base.c                   |   2 -
 fs/binfmt_elf.c                                    |  46 +--
 fs/binfmt_misc.c                                   |  12 +-
 fs/btrfs/inode.c                                   |  33 +-
 fs/cachefiles/bind.c                               |   3 +-
 fs/cachefiles/namei.c                              |   3 +-
 fs/cachefiles/rdwr.c                               |  17 +-
 fs/ceph/dir.c                                      |  39 +++
 fs/ceph/inode.c                                    |   1 +
 fs/ceph/super.h                                    |   9 +
 fs/ceph/xattr.c                                    |  10 +-
 fs/cifs/cifsglob.h                                 |   5 +-
 fs/cifs/cifsproto.h                                |   1 +
 fs/cifs/cifssmb.c                                  |  10 +-
 fs/cifs/connect.c                                  |   7 +-
 fs/cifs/smb1ops.c                                  |   1 +
 fs/cifs/smb2file.c                                 |  11 +-
 fs/cifs/smb2ops.c                                  |  13 +-
 fs/cifs/smb2pdu.c                                  |  33 +-
 fs/cifs/smb2pdu.h                                  |   6 +-
 fs/cifs/smb2transport.c                            |   1 +
 fs/cifs/transport.c                                |  18 +-
 fs/dcache.c                                        |  85 +++---
 fs/ext4/balloc.c                                   |   3 +
 fs/ext4/file.c                                     |  90 +++---
 fs/ext4/ialloc.c                                   |   5 +-
 fs/ext4/inline.c                                   |  18 +-
 fs/ext4/inode.c                                    |  70 +++--
 fs/ext4/resize.c                                   |   2 +-
 fs/ext4/super.c                                    |  75 +++--
 fs/ext4/xattr.c                                    |  31 +-
 fs/fat/inode.c                                     |  20 +-
 fs/fscache/cache.c                                 |   2 +-
 fs/fscache/cookie.c                                |   7 +-
 fs/fscache/object.c                                |   1 +
 fs/fscache/operation.c                             |   6 +-
 fs/fuse/control.c                                  |  13 +-
 fs/fuse/dir.c                                      |  13 +-
 fs/fuse/inode.c                                    |   1 +
 fs/namespace.c                                     |  27 +-
 fs/nfs/idmap.c                                     |   5 +-
 fs/nfsd/auth.c                                     |   2 +-
 fs/nfsd/nfs4xdr.c                                  |   5 +-
 fs/proc/task_mmu.c                                 |  74 ++---
 fs/proc/task_nommu.c                               |  32 +-
 fs/reiserfs/prints.c                               | 141 +++++----
 fs/squashfs/block.c                                |   2 +
 fs/squashfs/cache.c                                |   3 +
 fs/squashfs/file.c                                 |   8 +-
 fs/squashfs/fragment.c                             |   4 +-
 fs/squashfs/squashfs_fs.h                          |   6 +
 fs/ubifs/journal.c                                 |   5 +-
 fs/udf/directory.c                                 |   3 +
 include/linux/blkdev.h                             |   4 +-
 include/linux/can/dev.h                            |   3 +
 include/linux/compiler.h                           |   2 +-
 include/linux/cred.h                               |   9 +
 include/linux/dcache.h                             |  17 --
 include/linux/fs.h                                 |   5 +
 include/linux/libata.h                             |   1 +
 include/linux/mfd/as3711.h                         |   4 +-
 include/linux/mm.h                                 |   3 +-
 include/linux/perf_event.h                         |   8 +
 include/linux/ring_buffer.h                        |   1 +
 include/linux/string.h                             |   2 +-
 include/media/davinci/dm644x_ccdc.h                |  12 -
 include/media/davinci/vpfe_capture.h               |  10 -
 include/media/v4l2-fh.h                            |   1 +
 include/net/af_vsock.h                             |   4 +-
 include/net/net_namespace.h                        |   1 +
 include/net/netns/ipv6.h                           |   1 -
 include/sound/core.h                               |   2 +-
 include/uapi/linux/can/error.h                     |   1 +
 include/uapi/linux/kexec.h                         |   6 -
 include/uapi/linux/vt.h                            |   1 -
 kernel/events/core.c                               |  21 +-
 kernel/gcov/base.c                                 |  12 +
 kernel/gcov/gcc_4_7.c                              |   6 +-
 kernel/kthread.c                                   |   8 +-
 kernel/power/wakelock.c                            |   1 +
 kernel/sched/core.c                                |   2 +-
 kernel/sched/fair.c                                |  14 +-
 kernel/sched/sched.h                               |   2 +
 kernel/time.c                                      |   6 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/trace/ring_buffer.c                         |  16 +
 kernel/trace/trace.c                               |   6 +
 kernel/trace/trace_events_trigger.c                |  18 +-
 kernel/trace/trace_functions_graph.c               |   7 +-
 kernel/trace/trace_kprobe.c                        |  15 +-
 mm/hugetlb.c                                       |   1 +
 mm/ksm.c                                           |  16 +-
 mm/mlock.c                                         |   2 -
 mm/mmap.c                                          |  13 +-
 mm/page_alloc.c                                    |   3 +-
 mm/rmap.c                                          |   4 +
 mm/swapfile.c                                      |   2 +-
 mm/util.c                                          |  34 +--
 net/batman-adv/Makefile                            |   2 +-
 net/batman-adv/debugfs.c                           |  48 ++-
 net/batman-adv/debugfs.h                           |  45 +++
 net/batman-adv/hard-interface.c                    |  37 ++-
 net/batman-adv/translation-table.c                 |   7 +-
 net/caif/caif_dev.c                                |   4 +-
 net/core/rtnetlink.c                               |   8 +-
 net/core/skbuff.c                                  |   1 +
 net/dccp/ccids/ccid2.c                             |   6 +-
 net/dns_resolver/dns_key.c                         |  28 +-
 net/ipv4/fib_frontend.c                            |   5 +-
 net/ipv4/fib_semantics.c                           |   2 +
 net/ipv4/igmp.c                                    |   3 +-
 net/ipv6/ip6mr.c                                   |   3 +-
 net/ipv6/mcast.c                                   |  12 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   6 +-
 net/l2tp/l2tp_netlink.c                            |   6 +
 net/l2tp/l2tp_ppp.c                                |  76 +++--
 net/netfilter/nf_log.c                             |   9 +-
 net/netfilter/nfnetlink_queue_core.c               |   3 +
 net/netlink/af_netlink.c                           |   5 +
 net/packet/af_packet.c                             |  10 +-
 net/sched/act_simple.c                             |  14 +-
 net/sctp/outqueue.c                                |  48 ++-
 net/socket.c                                       |   2 +
 net/vmw_vsock/af_vsock.c                           |  15 +-
 net/vmw_vsock/vmci_transport.c                     |   3 +-
 net/wireless/util.c                                |   2 +
 net/xfrm/xfrm_policy.c                             |   3 +
 net/xfrm/xfrm_user.c                               |  18 +-
 scripts/kconfig/confdata.c                         |   2 +-
 scripts/mod/devicetable-offsets.c                  |   3 +
 scripts/mod/file2alias.c                           |  11 +
 sound/core/device.c                                |   9 +
 sound/core/timer.c                                 |   2 +-
 sound/isa/msnd/msnd_pinnacle_mixer.c               |   3 +-
 sound/pci/hda/hda_controller.c                     |   4 +-
 sound/pci/hda/patch_ca0132.c                       |   8 +-
 sound/pci/hda/patch_conexant.c                     |   1 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/cirrus/edb93xx.c                         |   2 +-
 sound/soc/cirrus/ep93xx-i2s.c                      |  26 +-
 sound/soc/cirrus/snappercl15.c                     |   2 +-
 sound/soc/soc-dapm.c                               |   2 +
 tools/arch/x86/include/asm/unistd_32.h             |   9 +
 tools/arch/x86/include/asm/unistd_64.h             |   9 +
 tools/include/linux/compiler.h                     |   9 +
 tools/perf/Makefile.perf                           |   2 -
 tools/perf/builtin-script.c                        |  82 +++--
 tools/perf/builtin-top.c                           |   2 +-
 tools/perf/builtin-trace.c                         |   5 +-
 tools/perf/config/Makefile                         |   1 +
 tools/perf/perf-sys.h                              |  18 --
 tools/perf/tests/attr.c                            |   4 +-
 tools/perf/tests/pmu.c                             |   2 +-
 tools/perf/util/cgroup.c                           |   2 +-
 tools/perf/util/event.c                            |  12 +-
 tools/perf/util/include/asm/unistd_32.h            |   1 -
 tools/perf/util/include/asm/unistd_64.h            |   1 -
 tools/perf/util/pager.c                            |   5 +-
 tools/perf/util/parse-events.c                     |  64 ++--
 tools/perf/util/pmu.c                              |   2 +-
 tools/perf/util/setup.py                           |   1 +
 tools/perf/util/thread.c                           |   2 +-
 tools/perf/util/thread_map.c                       |  10 +-
 tools/perf/util/util.h                             |   2 +
 tools/power/x86/turbostat/turbostat.c              |   4 +-
 357 files changed, 3362 insertions(+), 2348 deletions(-)

-- 
Ben Hutchings
Reality is just a crutch for people who can't handle science fiction.

