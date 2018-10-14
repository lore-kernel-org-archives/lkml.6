Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78097C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1179320645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1179320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeJNXrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:47:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35571 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeJNXLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:40 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cA-DR; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-00008O-24; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.755408431@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 000/366] 3.16.60-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.60 release.
There are 366 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Oct 19 17:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Aaron Ma (2):
      HID: core: Fix size as type u32
         [6de0b13cc0b4ba10e98a9263d7a83b940720b77a]
      HID: i2c-hid: fix size check and type usage
         [ac75a041048b8c1f7418e27621ca5efda8571043]

Al Viro (12):
      Don't leak MNT_INTERNAL away from internal mounts
         [16a34adb9392b2fe4195267475ab5b472e55292c]
      affs_lookup(): close a race with affs_remove_link()
         [30da870ce4a4e007c901858a96e9e394a1daa74a]
      aio: fix io_destroy(2) vs. lookup_ioctx() race
         [baf10564fbb66ea222cae66fbff11c444590ffd9]
      do d_instantiate/unlock_new_inode combinations safely
         [1e2e547a93a00ebc21582c06ca3c6cfea2a309ee]
      ext2: fix a block leak
         [5aa1437d2d9a068c0334bd7c9dafa8ec4f97f13b]
      fix io_destroy()/aio_complete() race
         [4faa99965e027cc057c5145ce45fa772caa04e8d]
      hypfs_kill_super(): deal with failed allocations
         [a24cd490739586a7d2da3549a1844e1d7c4f4fc4]
      jffs2_kill_sb(): deal with failed allocations
         [c66b23c2840446a82c389e4cb1a12eb2a71fa2e4]
      rpc_pipefs: fix double-dput()
         [4a3877c4cedd95543f8726b0a98743ed8db0c0fb]
      udf: fix the udf_iget() vs. udf_new_inode() races
         [b231509616feb911c2a7a8814d58c0014ef5b17f]
      udf: merge the pieces inserting a new non-directory object into directory
         [d2be51cb34dc501791f3b8c01a99a3f2064bd8d1]
      ufs: deal with nfsd/iget races
         [e4502c63f56aeca887ced37f24e0def1ef11cec8]

Alan Cox (1):
      tty: handle the case where we cannot restore a line discipline
         [8a8dabf2dd68caff842d38057097c23bc514ea6e]

Alan Stern (1):
      USB: Accept bulk endpoints with 1024-byte maxpacket
         [fb5ee84ea72c5f1b6cabdd1c9d6e8648995ca7c6]

Alex Smith (1):
      mmc: jz4740: Fix race condition in IRQ mask update
         [a04f0017c22453613d5f423326b190c61e3b4f98]

Alexander Gerasiov (1):
      parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
         [823f7923833c6cc2b16e601546d607dcfb368004]

Alexey Khoroshilov (2):
      vmxnet3: avoid assumption about invalid dma_pa in vmxnet3_set_mc()
         [fb5c6cfaec126d9a96b9dd471d4711bf4c737a6f]
      vmxnet3: fix checks for dma mapping errors
         [5738a09d58d5ad2871f1f9a42bf6a3aa9ece5b3c]

Amir Goldstein (1):
      fanotify: fix logic of events on child
         [54a307ba8d3cd00a3902337ffaae28f436eeb1a4]

Andrew Morton (1):
      fs/reiserfs/journal.c: add missing resierfs_warning() arg
         [9ad553abe66f8be3f4755e9fa0a6ba137ce76341]

Andrey Ignatov (1):
      ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg
         [1b97013bfb11d66f041de691de6f0fec748ce016]

Andy King (1):
      VMXNET3: Check for map error in vmxnet3_set_mc
         [4ad9a64f53c619969dede1143d56ccda1a453c39]

Aneesh Kumar K.V (1):
      powerpc/mm/hugetlb: initialize the pagetable cache correctly for hugetlb
         [6fa504835d6969144b2bd3699684dd447c789ba2]

Ard Biesheuvel (1):
      efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32' definition for mixed mode
         [0b3225ab9407f557a8e20f23f37aa7236c10a9b1]

Arnaldo Carvalho de Melo (1):
      perf top: Document --ignore-vmlinux
         [a8403912d04e2c8271653bb5b7f6294dc6d322ac]

Arnd Bergmann (1):
      media: s3c-camif: fix out-of-bounds array access
         [a398e043637a4819a0e96467bfecaabf3224dd62]

Bai Ping (1):
      thermal: imx: register irq handler later in probe
         [84866ee5818e95f6e97194656777c10ac24cb9d3]

Bart Van Assche (1):
      IB/srp: Fix srp_abort()
         [e68088e78d82920632eba112b968e49d588d02a2]

Ben Hutchings (4):
      ALSA: timer: Fix pause event notification
         [3ae180972564846e6d794e3615e1ab0a1e6c4ef9]
      drm/msm: Fix possible null dereference on failure of get_pages()
         [3976626ea3d2011f8fd3f3a47070a8b792018253]
      ppp: Fix null pointer dereference on registration failure
         [96d934c70db6e1bc135600c57da1285eaf7efb26]
      scsi: qla2xxx: Avoid double completion of abort command
         [3a9910d7b686546dcc9986e790af17e148f1c888]

Bharat Potnuri (1):
      iw_cxgb4: Atomically flush per QP HW CQEs
         [2df19e19ae90d94fd8724083f161f368a2797537]

Bin Liu (1):
      usb: musb: host: fix potential NULL pointer dereference
         [2b63f1329df2cd814c1f8353fae4853ace6521d1]

Bjorn Helgaas (1):
      drm/radeon: make MacBook Pro d3_delay quirk more generic
         [5938628c51a711ae2169d68b2e3a4f7d93d4dbea]

Bjørn Mork (1):
      qmi_wwan: do not steal interfaces from class drivers
         [5697db4a696c41601a1d15c1922150b4dbf5726c]

Brad Volkin (1):
      drm/i915: Log a message when rejecting LRM to OACONTROL
         [00caf0199f66871b0e2c28d7c2079de0ce1d646c]

Bryan O'Donoghue (1):
      rtc: snvs: Fix usage of snvs_rtc_enable
         [1485991c024603b2fb4ae77beb7a0d741128a48e]

Chao Yu (2):
      f2fs: reposition unlock_new_inode to prevent accessing invalid inode
         [b73e52824c8920a5ff754e3c8ff68466a7dd61f9]
      udf: avoid unneeded up_write when fail to add entry in ->symlink
         [85cd083b498572fb9fa575cce3ed910c8ee84294]

Charles Keepax (2):
      regmap: Correct offset handling in regmap_volatile_range
         [b8f9a03b741ddfdde4aa8b607fa7d88eb63a6338]
      regmap: Don't use format_val in regmap_bulk_read
         [9ae27a8d1f3ebff09191fb8cb1341414547293b2]

Chris Mason (1):
      Btrfs: use insert_inode_locked4 for inode creation
         [b0d5d10f41a0f1cd839408dd94427f2db3553bca]

Chris Metcalf (3):
      Make asm/word-at-a-time.h available on all architectures
         [a6e2f029ae34f41adb6ae3812c32c5d326e1abd2]
      string: provide strscpy()
         [30035e45753b708e7d47a98398500ca005e02b86]
      word-at-a-time.h: fix some Kbuild files
         [19c22f3a29fa8669c477f20a65f6c7c27108972a]

Clemens Werther (1):
      USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator
         [6555ad13a01952c16485c82a52ad1f3e07e34b3a]

Colin Ian King (5):
      KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
         [ba3696e94d9d590d9a7e55f68e81c25dba515191]
      RDMA/iwpm: fix memory leak on map_info
         [f96416cea7bce9afe619c15e87fced70f93f9098]
      media: cx25821: prevent out-of-bounds read on array card
         [67300abdbe9f1717532aaf4e037222762716d0f6]
      rtc: tx4939: avoid unintended sign extension on a 24 bit shift
         [347876ad47b9923ce26e686173bbf46581802ffa]
      staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr
         [e1a7418529e33bc4efc346324557251a16a3e79b]

Collin May (1):
      USB: serial: simple: add libtransistor console
         [fe710508b6ba9d28730f3021fed70e7043433b2e]

Cong Wang (2):
      llc: fix NULL pointer deref for SOCK_ZAPPED
         [3a04ce7130a7e5dad4e78d45d50313747f8c830f]
      llc: hold llc_sap before release_sock()
         [f7e43672683b097bb074a8fe7af9bc600a23f231]

Dan Carpenter (2):
      net: ethernet: davinci_emac: fix error handling in probe()
         [8005b09d99fac78e6f5fb9da30b5ae94840af03b]
      xen/acpi: off by one in read_acpi_id()
         [c37a3c94775855567b90f91775b9691e10bd2806]

Daniel Borkmann (1):
      bpf, x64: fix memleak when not converging after image
         [3aab8884c9eb99189a3569ac4e6b205371c9ac0b]

Danilo Krummrich (1):
      fs/proc/proc_sysctl.c: fix potential page fault while unregistering sysctl table
         [a0b0d1c345d0317efe594df268feb5ccc99f651e]

Danit Goldberg (1):
      IB/mlx5: Use unlimited rate when static rate is not supported
         [4f32ac2e452c2180cd2df581cbadac183e27ecd0]

Dave Airlie (1):
      drm: set FMODE_UNSIGNED_OFFSET for drm files
         [76ef6b28ea4f81c3d511866a9b31392caa833126]

David Henningsson (1):
      ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr
         [f853dcaae2f5bbe021161e421bd1576845bae8f6]

David Howells (1):
      afs: Fix directory permissions check
         [378831e4daec75fbba6d3612bcf3b4dd00ddbf08]

David Lechner (1):
      pinctrl: pinctrl-single: Fix pcs_request_gpio() when bits_per_mux != 0
         [45dcb54f014d3d1f5cc3919b5f0c97087d7cb3dd]

Davidlohr Bueso (5):
      Revert "ipc/shm: Fix shmat mmap nil-page protection"
         [a73ab244f0dad8fffb3291b905f73e2d3eaa7c00]
      ipc,shm: move BUG_ON check into shm_lock
         [c5c8975b2eb4eb7604e8ce4f762987f56d2a96a2]
      ipc/sem: make semctl setting sempid consistent
         [a5f4db877177d2a3d7ae62a7bac3a5a27e083d7f]
      ipc/shm: fix shmat() nil address after round-down when remapping
         [8f89c007b6dec16a1793cb88de88fcc02117bbbc]
      ipc: convert invalid scenarios to use WARN_ON
         [d0edd8528362c07216498340e928159510595e7b]

Dennis Wassenberg (1):
      Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list
         [b56af54ac78c54a519d82813836f305d7f76ef27]

Dexuan Cui (1):
      tick/broadcast: Use for_each_cpu() specially on UP kernels
         [5596fe34495cf0f645f417eb928ef224df3e3cb4]

Dmitry Safonov (1):
      tracing/uprobe: Drop isdigit() check in create_trace_uprobe
         [5ba8a4a96f6eaa6af88e24c7794f142217aa3b6f]

Dou Liyang (1):
      x86/acpi: Prevent X2APIC id 0xffffffff from being accounted
         [10daf10ab154e31237a8c07242be3063fb6a9bf4]

Eliot Blennerhassett (1):
      ALSA: asihpi: used parts of message/response are zeroed before use
         [51e6f47dd2e3463dac6f37128fd7b7cb40c500de]

Eric Biggers (5):
      KEYS: DNS: limit the length of option strings
         [9c438d7a3a52dcc2b9ed095cb87d3a5e83cf7e60]
      crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one
         [8f461b1e02ed546fbd0f11611138da67fd85a30f]
      ext4: correctly detect when an xattr value has an invalid size
         [d7614cc16146e3f0b4c33e71875c19607602aed5]
      ipc/shm: fix use-after-free of shm file via remap_file_pages()
         [3f05317d9889ab75c7190dcd39491d2a97921984]
      ppp: remove the PPPIOCDETACH ioctl
         [af8d3c7c001ae7df1ed2b2715f058113efc86187]

Eric Dumazet (21):
      crypto: af_alg - fix possible uninit-value in alg_bind()
         [a466856e0b7ab269cdf9461886d007e88ff575b0]
      dccp: fix tasklet usage
         [a8d7aa17bbc970971ccdf71988ea19230ab368b1]
      ip6_gre: better validate user provided tunnel names
         [5f42df013b8bc1b6511af7a04bf93b014884ae2a]
      ip6_tunnel: better validate user provided tunnel names
         [db7a65e3ab78e5b1c4b17c0870ebee35a4ee3257]
      ip_tunnel: better validate user provided tunnel names
         [9cb726a212a82c88c98aa9f0037fd04777cd8fe5]
      ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy
         [aa8f8778493c85fff480cdf8b349b1e1dcb5f243]
      ipv6: sit: better validate user provided tunnel names
         [b95211e066fc3494b7c115060b2297b4ba21f025]
      llc: better deal with too small mtu
         [2c5d5b13c6eb79f5677e206b8aad59b3a2097f60]
      net: af_packet: fix race in PACKET_{R|T}X_RING
         [5171b37d959641bbc619781caf62e61f7b940871]
      net: fix rtnh_ok()
         [b1993a2de12c9e75c35729e2ffbc3a92d50c0d31]
      net: fix uninit-value in __hw_addr_add_ex()
         [77d36398d99f2565c0a8d43a86fd520a82e64bb8]
      net: initialize skb->peeked when cloning
         [b13dda9f9aa7caceeee61c080c2e544d5f5d85e5]
      net_sched: fq: take care of throttled flows before reuse
         [7df40c2673a1307c3260aab6f9d4b9bf97ca8fd7]
      netlink: fix uninit-value in netlink_sendmsg
         [6091f09c2f79730d895149bcfe3d66140288cd0e]
      sctp: do not leak kernel memory to user space
         [6780db244d6b1537d139dea0ec8aad10cf9e4adb]
      soreuseport: initialise timewait reuseport field
         [3099a52918937ab86ec47038ad80d377ba16c531]
      tcp: fix TCP_REPAIR_QUEUE bound checking
         [bf2acc943a45d2b2e8a9f1a5ddff6b6e43cc69d9]
      tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
         [7212303268918b9a203aebeacfdbd83b5e87b20d]
      tcp: purge write queue in tcp_connect_init()
         [7f582b248d0a86bae5788c548d7bb5bca6f7691a]
      vti6: better validate user provided tunnel names
         [537b361fbcbcc3cd6fe2bb47069fd292b9256d16]
      xfrm6: avoid potential infinite loop in _decode_session6()
         [d9f92772e8ec388d070752ee8f187ef8fa18621f]

Eric W. Biederman (4):
      ipc/msg: Fix msgctl(..., IPC_STAT, ...) between pid namespaces
         [39a4940eaa185910bb802ca9829c12268fd2c855]
      ipc/sem: Fix semctl(..., GETPID, ...) between pid namespaces
         [51d6f2635b39709ee5e62479be23d423b760292c]
      ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
         [98f929b1bd4d0b7c7a77d0d9776d1b924db2e454]
      ipc/util: Helpers for making the sysvipc operations pid namespace aware
         [03f1fc09180b345582889a344b012d069b3a6dbe]

Eryu Guan (1):
      ext4: protect i_disksize update by i_data_sem in direct write path
         [73fdad00b208b139cf43f3163fbc0f67e4c6047c]

Fabián Inostroza (1):
      ALSA: line6: Use correct endpoint type for midi output
         [7ecb46e9ee9af18e304eb9e7d6804c59a408e846]

Federico Cuello (1):
      ALSA: usb: mixer: volume quirk for CM102-A+/102S+
         [21493316a3c4598f308d5a9fa31cc74639c4caff]

Filipe Manana (3):
      Btrfs: don't leave dangling dentry if symlink creation failed
         [d50866d00fb39fcf72307001763ee9cc92625a43]
      Btrfs: ensure tmpfile inode is always persisted with link count of 0
         [5762b5c958abbecb7fb9f4596a6476d1ce91ecf6]
      Btrfs: fix copy_items() return value when logging an inode
         [8434ec46c6e3232cebc25a910363b29f5c617820]

Florent Flament (1):
      drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log
         [280b54ade5914d3b4abe4f0ebe083ddbd4603246]

Florian Fainelli (2):
      net: bcmgenet: Fix sparse warnings in bcmgenet_put_tx_csum()
         [6f89421180f15867dc1472d9edf68f82b0ed5ee6]
      net: systemport: Fix sparse warnings in bcm_sysport_insert_tsb()
         [c0eb05585d4184596453622b5abba7d13dd20667]

Florian Westphal (1):
      netfilter: nf_tables: can't fail after linking rule into active rule list
         [569ccae68b38654f04b6842b034aa33857f605fe]

Francisco Jerez (1):
      drm/i915: Fix command parser to validate multiple register access with the same command.
         [6a65c5b9326c9dd391afb1b3df75cbedffbaccdb]

Geert Uytterhoeven (6):
      serial: arc_uart: Fix out-of-bounds access through DT alias
         [f9f5786987e81d166c60833edcb7d1836aa16944]
      serial: fsl_lpuart: Fix out-of-bounds access through DT alias
         [ffab87fdecc655cc676f8be8dd1a2c5e22bd6d47]
      serial: imx: Fix out-of-bounds access through serial port index
         [5673444821406dda5fc25e4b52aca419f8065a19]
      serial: mxs-auart: Fix out-of-bounds access through serial port index
         [dd345a31bfdec350d2593e6de5964e55c7f19c76]
      serial: pxa: Fix out-of-bounds access through serial port index
         [afc7851fab8329eddcf321c9e0a58c893f351dd6]
      serial: xuartps: Fix out-of-bounds access through DT alias
         [e7d75e18d0fc3f7193b65282b651f980c778d935]

Govindarajulu Varadarajan (1):
      enic: set DMA mask to 47 bit
         [322eaa06d55ebc1402a4a8d140945cff536638b4]

Greg Kroah-Hartman (1):
      USB: serial: visor: handle potential invalid device configuration
         [4842ed5bfcb9daf6660537d70503c18d38dbdbb8]

Guenter Roeck (4):
      hwmon: (nct6683) Enable EC access if disabled at boot
         [dbac00f0cf634120d77edee10d25e3f6899d7636]
      hwmon: (nct6775) Fix writing pwmX_mode
         [415eb2a1aaa4881cf85bd86c683356fdd8094a23]
      hwmon: (pmbus/adm1275) Accept negative page register values
         [ecb29abd4cb0670c616fb563a078f25d777ce530]
      hwmon: (pmbus/max8688) Accept negative page register values
         [a46f8cd696624ef757be0311eb28f119c36778e8]

Guillaume Nault (12):
      l2tp: check sockaddr length in pppol2tp_connect()
         [eb1c28c05894a4b1f6b56c5bf072205e64cfa280]
      l2tp: fix race in duplicate tunnel detection
         [f6cd651b056ffd3b4e8496afd44d4ed44bf69136]
      l2tp: fix races in tunnel creation
         [6b9f34239b00e6956a267abed2bc559ede556ad6]
      l2tp: fix {pppol2tp, l2tp_dfs}_seq_stop() in case of seq_file overflow
         [5411b6187adf62909e3b998ac782e722904c7487]
      l2tp: hold reference on tunnels in netlink dumps
         [5846c131c39b6d0add36ec19dc8650700690f930]
      l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file
         [f726214d9b23e5fce8c11937577a289a3202498f]
      l2tp: hold reference on tunnels printed in pppol2tp proc file
         [0e0c3fee3a59a387aeecc4fca6f3a2e9615a5443]
      ppp: fix device unregistration upon netns deletion
         [8cb775bc0a34dc596837e7da03fd22c747be618b]
      ppp: fix lockdep splat in ppp_dev_uninit()
         [58a89ecaca53736aa465170530acea4f8be34ab4]
      ppp: fix race in ppp device destruction
         [6151b8b37b119e8e3a8401b080d532520c95faf4]
      ppp: unlock all_ppp_mutex before registering device
         [0171c41835591e9aa2e384b703ef9a6ae367c610]
      pppoe: check sockaddr length in pppoe_connect()
         [a49e2f5d5fb141884452ddb428f551b123d436b5]

Gustavo A. R. Silva (3):
      atm: zatm: Fix potential Spectre v1
         [2be147f7459db5bbf292e0a6f135037b55e20b39]
      kernel/sys.c: fix potential Spectre v1 issue
         [23d6aef74da86a33fa6bb75f79565e0a16ee97c2]
      net: atm: Fix potential Spectre v1
         [acf784bd0ce257fe43da7ca266f7a10b837479d2]

Hans de Goede (1):
      libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
         [184add2ca23ce5edcac0ab9c3b9be13f91e7b567]

Heinrich Schuchardt (1):
      usb: musb: gadget: misplaced out of bounds check
         [af6f8529098aeb0e56a68671b450cf74e7a64fcd]

Helge Deller (2):
      parisc: Fix HPMC handler by increasing size to multiple of 16 bytes
         [d5654e156bc4d68a87bbaa6d7e020baceddf6e68]
      parisc: Fix out of array access in match_pci_device()
         [615b2665fd20c327b631ff1e79426775de748094]

Hendrik Brueckner (1):
      s390/cpum_sf: ensure sample frequency of perf event attributes is non-zero
         [4bbaf2584b86b0772413edeac22ff448f36351b1]

Herbert Xu (1):
      crypto: ahash - Fix early termination in hash walk
         [900a081f6912a8985dc15380ec912752cb66025a]

Himanshu.Madhani@Cavium.Com (1):
      scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS
         [1514839b366417934e2f1328edb50ed1e8a719f5]

Hpreg@Vmware.Com (1):
      vmxnet3: set the DMA mask before the first DMA map operation
         [61aeecea40afb2b89933e27cd4adb10fc2e75cfd]

Huacai Chen (1):
      zboot: fix stack protector in compressed boot phase
         [7bbaf27d9c83037b6e60a818e57bdbedf6bc15be]

Ian Kent (1):
      autofs: mount point create should honour passed in mode
         [1e6306652ba18723015d1b4967fe9de55f042499]

Igor Pylypiv (1):
      watchdog: f71808e_wdt: Fix WD_EN register read
         [977f6f68331f94bb72ad84ee96b7b87ce737d89d]

Ilya Dryomov (1):
      libceph: validate con->state at the top of try_write()
         [9c55ad1c214d9f8c4594ac2c3fa392c1c32431a7]

Ivan Khoronzhuk (1):
      net: ethernet: ti: cpdma: correct error handling for chan create
         [8a83c5d7969b8433584e3cf658a8d76c4dc37f4d]

Jack Morgenstein (1):
      net/mlx4: Fix irq-unsafe spinlock usage
         [d546b67cda015fb92bfee93d5dc0ceadb91deaee]

Jaegeuk Kim (2):
      f2fs: call f2fs_unlock_op after error was handled
         [44c16156512f33c81e382a1e1df9524e26a7026a]
      f2fs: go out for insert_inode_locked failure
         [a21c20f0c812925085204fced932ac95f2a76bf0]

James Kelly (1):
      ASoC: ssm2602: Replace reg_default_raw with reg_default
         [a01df75ce737951ad13a08d101306e88c3f57cb2]

Jan Kara (3):
      bdi: Fix oops in wb_workfn()
         [b8b784958eccbf8f51ebeee65282ca3fd59ea391]
      ufs: Fix possible deadlock when looking up directories
         [514d748f69c97a51a2645eb198ac5c6218f22ff9]
      ufs: Fix warning from unlock_new_inode()
         [12ecbb4b1d765a5076920999298d9625439dbe58]

Jann Horn (1):
      tcp: don't read out-of-bounds opsize
         [7e5a206ab686f098367b61aca989f5cdfa8114a3]

Jason Andryuk (1):
      HID: i2c-hid: Fix "incomplete report" noise
         [ef6eaf27274c0351f7059163918f3795da13199c]

Jeff Moyer (1):
      block_invalidatepage(): only release page if the full page was invalidated
         [3172485f4f8032649c144e4aafa550e1e6179332]

Jens Remus (1):
      scsi: zfcp: fix infinite iteration on ERP ready list
         [fa89adba1941e4f3b213399b81732a5c12fd9131]

Jerome Brunet (1):
      clk: fix mux clock documentation
         [fe3f338f0cb2ed4d4f06da054c21ae2f8a36ef2d]

Jimmy Assarsson (1):
      can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()
         [6ee00865ffe4e8c8ba4a68d26db53c7ec09bbb89]

Jiri Olsa (1):
      perf record: Put new line after target override warning
         [c3dec27b7f70a9ad5f777d943d51ecdfcd9824d0]

Joakim Tjernlund (3):
      mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
         [6510bbc88e3258631831ade49033537081950605]
      mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
         [46a16a2283f9e678a4e26829175e0c37a5191860]
      mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.
         [7b70eb14392a7cf505f9b358d06c33b5af73d1e7]

Joe Jin (1):
      xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent
         [4855c92dbb7b3b85c23e88ab7ca04f99b9677b41]

Joerg Roedel (1):
      x86/mm: Prevent kernel Oops in PTDUMP code with HIGHPTE=y
         [d6ef1f194b7569af8b8397876dc9ab07649d63cb]

Johan Hovold (2):
      USB: serial: cp210x: add ELDAT Easywave RX09 id
         [1f1e82f74c0947e40144688c9e36abe4b3999f49]
      rfkill: gpio: fix memory leak in probe error path
         [4bf01ca21e2e0e4561d1a03c48c3d740418702db]

Jonathan Neuschäfer (1):
      net: core: dst: Add kernel-doc for 'net' parameter
         [8eb1a8590f5ca114fabf16ebb26a4bce0255ace9]

Julian Anastasov (3):
      ipv4: fix fnhe usage by non-cached routes
         [94720e3aee6884d8c8beb678001629da60ec6366]
      ipvs: fix buffer overflow with sync daemon and service
         [52f96757905bbf0edef47f3ee6c7c784e7f8ff8a]
      ipvs: fix stats update from local clients
         [d5e032fc5697b6c0d6b4958bcacb981a08f8174e]

Julian Wiedmann (5):
      s390/qdio: don't merge ERROR output buffers
         [0cf1e05157b9e5530dcc3ca9fec9bf617fc93375]
      s390/qdio: don't release memory in qdio_setup_irq()
         [2e68adcd2fb21b7188ba449f0fab3bee2910e500]
      s390/qdio: don't retry EQBS after CCQ 96
         [dae55b6fef58530c13df074bcc182c096609339e]
      s390/qdio: fix access to uninitialized qdio_q fields
         [e521813468f786271a87e78e8644243bead48fad]
      s390/qeth: handle failure on workqueue creation
         [a936b1ef37ce1e996533878f4b23944f9444dcdf]

Kai-Heng Feng (2):
      sky2: Increase D3 delay to sky2 stops working after suspend
         [afb133637071be6deeb8b3d0e55593ffbf63c527]
      xhci: Fix USB ports for Dell Inspiron 5775
         [621faf4f6a181b6e012c1d1865213f36f4159b7f]

Kamil Lulko (1):
      usb: core: Add quirk for HP v222w 16GB Mini
         [3180dabe08e3653bf0a838553905d88f3773f29c]

Kenny Yu (1):
      uprobe: Find last occurrence of ':' when parsing uprobe PATH:OFFSET
         [6496bb72bf20c1c7e4d6be44dfa663163e709116]

Kirill A. Shutemov (1):
      ipc/shm: handle removed segments gracefully in shm_mmap()
         [1ac0b6dec656f3f78d1c3dd216fad84cb4d0a01e]

Krzysztof Mazur (1):
      um: Use POSIX ucontext_t instead of struct ucontext
         [4d1a535b8ec5e74b42dfd9dc809142653b2597f6]

Kyle Roeschley (1):
      USB: serial: cp210x: add ID for NI USB serial console
         [1e23aace21515a8f7615a1de016c0ea8d4e0cc6e]

Lance Richardson (1):
      net: support compat 64-bit time in {s,g}etsockopt
         [988bf7243e03ef69238381594e0334a79cef74a6]

Leon Romanovsky (1):
      RDMA/mlx5: Protect from shift operand overflow
         [002bf2282b2d7318e444dca9ffcb994afc5d5f15]

Leonard Crestez (1):
      crypto: arm,arm64 - Fix random regeneration of S_shipped
         [6aaf49b495b446ff6eec0ac983f781ca0dc56a73]

Li RongQing (1):
      x86/apic: Fix signedness bug in APIC ID validity checks
         [a774635db5c430cbf21fa5d2f2df3d23aaa8e782]

Linus Lüssing (1):
      batman-adv: Fix TT sync flags for intermediate TT responses
         [7072337e52b3e9d5460500d8dc9cbc1ba2db084c]

Linus Torvalds (3):
      give up on gcc ilog2() constant optimizations
         [474c90156c8dcc2fa815e6716cc9394d7930cb9c]
      mmap: introduce sane default mmap limits
         [be83bbf806822b1b89e0a0f23cd87cddc409e429]
      mmap: relax file size limit for regular files
         [423913ad4ae5b3e8fb8983f70969fb522261ba26]

Liu Bo (3):
      Btrfs: bail out on error during replay_dir_deletes
         [b98def7ca6e152ee55e36863dddf6f41f12d1dc6]
      Btrfs: fix NULL pointer dereference in log_dir_items
         [80c0b4210a963e31529e15bf90519708ec947596]
      Btrfs: fix unexpected cow in run_delalloc_nocow
         [5811375325420052fcadd944792a416a43072b7f]

Long Li (1):
      cifs: Allocate validate negotiation request through kmalloc
         [2796d303e3c5ec213c578ed3a66872205c126eb8]

Maciej W. Rozycki (3):
      MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs
         [9a3a92ccfe3620743d4ae57c987dc8e9c5f88996]
      MIPS: ptrace: Expose FIR register through FP regset
         [71e909c0cdad28a1df1fa14442929e68615dee45]
      MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
         [c7e814628df65f424fe197dde73bfc67e4a244d7]

Mahesh Rajashekhara (1):
      scsi: sd: Defer spinning up drive while SANITIZE is in progress
         [505aa4b6a8834a2300971c5220c380c3271ebde3]

Major Hayden (1):
      USB: serial: ftdi_sio: add RT Systems VX-8 cable
         [9608e5c0f079390473b484ef92334dfd3431bb89]

Marc Dionne (1):
      afs: Ignore AFS_ACE_READ and AFS_ACE_WRITE for directories
         [fd2498211a551fd42b2d6b9050d649d43536e75c]

Marc Zyngier (1):
      KVM: arm/arm64: Close VMID generation race
         [f0cf47d939d0b4b4f660c5aaa4276fa3488f3391]

Marek Lindner (1):
      batman-adv: prevent TT request storms by not sending inconsistent TT TLVLs
         [16116dac23396e73c01eeee97b102e4833a4b205]

Mark Brown (1):
      regmap: Support bulk reads for devices without raw formatting
         [d5b98eb12420ce856caaf57dc5256eedc56a3747]

Markus Elfring (2):
      tracing: Deletion of an unnecessary check before iput()
         [16a8ef2751801346f1f76a18685b2beb63cd170f]
      video/fbdev/stifb: Return -ENOMEM after a failed kzalloc() in stifb_init_fb()
         [f9815f945aff2204b8afbbb9d2182024eb44a194]

Martin K. Petersen (1):
      scsi: mptsas: Disable WRITE SAME
         [94e5395d2403c8bc2504a7cbe4c4caaacb7b8b84]

Martin Kelly (2):
      iio:buffer: make length types match kfifo types
         [c043ec1ca5baae63726aae32abbe003192bc6eec]
      iio:kfifo_buf: check for uint overflow
         [3d13de4b027d5f6276c0f9d3a264f518747d83f2]

Masami Hiramatsu (3):
      ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
         [eb0146daefdde65665b7f076fbff7b49dade95b9]
      ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions
         [0d73c3f8e7f6ee2aab1bb350f60c180f5ae21a2c]
      tracing/uprobe_event: Fix strncpy corner case
         [50268a3d266ecfdd6c5873d62b2758d9732fc598]

Mathieu Desnoyers (1):
      tracepoint: Do not warn on ENOMEM
         [d66a270be3310d7aa132fec0cea77d3d32a0ff75]

Matt Redfearn (4):
      MIPS: memset.S: EVA & fault support for small_memset
         [8a8158c85e1e774a44fbe81106fa41138580dfd1]
      MIPS: memset.S: Fix clobber of v1 in last_fixup
         [c96eebf07692e53bf4dd5987510d8b550e793598]
      MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
         [daf70d89f80c6e1772233da9e020114b1254e7e0]
      MIPS: uaccess: Add micromips clobbers to bzero invocation
         [b3d7e55c3f886493235bfee08e1e5a4a27cbcce8]

Matthew Auld (1):
      drm/i915/userptr: reject zero user_size
         [c11c7bfd213495784b22ef82a69b6489f8d0092f]

Matthew Wilcox (1):
      mm/filemap.c: fix NULL pointer in page_cache_tree_insert()
         [abc1be13fd113ddef5e2d807a466286b864caed3]

Mauro Carvalho Chehab (1):
      media: v4l2-compat-ioctl32: don't oops on overlay
         [85ea29f19eab56ec16ec6b92bc67305998706afa]

Michael Ellerman (1):
      powerpc/lib: Fix off-by-one in alternate feature patching
         [b8858581febb050688e276b956796bc4a78299ed]

Michael Neuling (3):
      powerpc/64s: Clear PCR on boot
         [faf37c44a105f3608115785f17cbbf3500f8bc71]
      powerpc/eeh: Fix enabling bridge MMIO windows
         [13a83eac373c49c0a081cbcd137e79210fe78acd]
      powerpc/eeh: Fix race with driver un/bind
         [f0295e047fcf52ccb42561fb7de6942f5201b676]

Michael S. Tsirkin (6):
      virtio: add ability to iterate over vqs
         [24a7e4d20783c0514850f24a5c41ede46ab058f0]
      virtio_console: don't tie bufs to a vq
         [2855b33514d290c51d52d94e25d3ef942cd4d578]
      virtio_console: drop custom control queue cleanup
         [61a8950c5c5708cf2068b29ffde94e454e528208]
      virtio_console: free buffers after reset
         [a7a69ec0d8e4a58be7db88d33cbfa2912807bb2b]
      virtio_console: move removal code
         [aa44ec867030a72e8aa127977e37dec551d8df19]
      virtio_console: reset on out of memory
         [5c60300d68da32ca77f7f978039dc72bfc78b06b]

Michal Srb (1):
      drm/i915/cmdparser: Do not check past the cmd length.
         [3aec7f871c65eb5f76b4125fda432593c834a6f2]

Mika Westerberg (2):
      ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
         [13d3047c81505cc0fb9bdae7810676e70523c8bf]
      ahci: Add PCI ID for Cannon Lake PCH-LP AHCI
         [4544e403eb25552aed7f0ee181a7a506b8800403]

Mike Frysinger (1):
      vt: change SGR 21 to follow the standards
         [65d9982d7e523a1a8e7c9af012da0d166f72fc56]

Mike Galbraith (1):
      sched/autogroup: Fix 64-bit kernel nice level adjustment
         [83929cce95251cc77e5659bf493bd424ae0e7a67]

Mike Kravetz (1):
      hugetlbfs: fix bug in pgoff overflow checking
         [5df63c2a149ae65a9ec239e7c2af44efa6f79beb]

Mikhail Lappo (1):
      thermal: imx: Fix race condition in imx_thermal_probe()
         [cf1ba1d73a33944d8c1a75370a35434bf146b8a7]

Moshe Shemesh (1):
      net/mlx4_en: Verify coalescing parameters are in range
         [6ad4e91c6d796b38a7f0e724db1de28eeb122bad]

Nicholas Piggin (5):
      powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently
         [0bfdf598900fd62869659f360d3387ed80eb71cf]
      powerpc/powernv: Fix NVRAM sleep in invalid context when crashing
         [c1d2a31397ec51f0370f6bd17b19b39152c263cb]
      powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops
         [3b8070335f751aac9f1526ae2e012e6f5b8b0f21]
      powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
         [741de617661794246f84a21a02fc5e327bffc9ad]
      powerpc/powernv: define a standard delay for OPAL_BUSY type retry loops
         [34dd25de9fe3f60bfdb31b473bf04b28262d0896]

Nico Sneck (1):
      drm/radeon: add PX quirk for Asus K73TK
         [b1550359d1eb392ee54f7cf47cffcfe0a602f6a7]

Nicolas Dichtel (1):
      ip_tunnel: restore binding to ifaces with a large mtu
         [82612de1c98e610d194e34178bde3cca7dedce41]

Nicolas Ferre (1):
      ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
         [e8fd0adf105e132fd84545997bbef3d5edc2c9c1]

Nicolin Chen (1):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio
         [c656941df9bc80f7ec65b92ca73c42f8b0b62628]

Nikolay Borisov (3):
      btrfs: Fix possible softlock on single core machines
         [1e1c50a929bc9e49bc3f9935b92450d9e69f8158]
      btrfs: Handle error from btrfs_uuid_tree_rem call in _btrfs_ioctl_set_received_subvol
         [d87ff75863e92a500538ab53318c5740f196631e]
      btrfs: Refactor transaction handling in received subvolume ioctl
         [efd38150af45375b46576d0110a323d7fab7e142]

Ondrej Zary (2):
      Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad
         [04bb1719c4de94700056241d4c0fe3c1413f5aff]
      drm/i915: Disable LVDS on Radiant P845
         [7f7105f99b75aca4f8c2a748ed6b82c7f8be3293]

Paolo Abeni (2):
      netfilter: ebtables: handle string from userspace with care
         [94c752f99954797da583a84c4907ff19e92550a4]
      team: avoid adding twice the same option to the event list
         [4fb0534fb7bbc2346ba7d3a072b538007f4135a5]

Paul Parsons (1):
      drm/radeon: Fix PCIe lane width calculation
         [85e290d92b4b794d0c758c53007eb4248d385386]

Peng Hao (1):
      kvm: x86: fix a compile warning
         [3140c156e919b0f5fad5c5f6cf7876c39d1d4f06]

Peter Rosin (3):
      i2c: pmcmsp: fix error return from master_xfer
         [12d9bbc5a7f347eaa65ff2a9d34995cadc05eb1b]
      i2c: pmcmsp: return message count on master_xfer success
         [de9a8634f1cb4560a35696d472cc7f1383d9b866]
      i2c: viperboard: return message count on master_xfer success
         [35cd67a0caf767aba472452865dcb4471fcce2b1]

Peter Zijlstra (5):
      clocksource: Initialize cs->wd_list
         [5b9e886a4af97574ca3ce1147f35545da0e7afc7]
      perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*
         [ef9ee4ad38445a30909c48998624861716f2a994]
      perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()
         [46b1b577229a091b137831becaa0fae8690ee15a]
      sched/autogroup: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]
         [354d7793070611b4df5a79fbb0f12752d0ed0cc5]
      sched/core: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]
         [7281c8dec8a87685cb54d503d8cceef5a0fc2fdd]

Piaojun (1):
      ocfs2/dlm: wait for dlm recovery done when migrating all lock resources
         [60c7ec9ee4a3410c2cb08850102d363c7e207f48]

Prakash Kamliya (1):
      drm/msm: fix leak in failed get_pages
         [62e3a3e342af3c313ab38603811ecdb1fcc79edb]

Qu Wenruo (1):
      btrfs: tests/qgroup: Fix wrong tree backref level
         [3c0efdf03b2d127f0e40e30db4e7aa0429b1b79a]

Raju Rangoju (1):
      RDMA/cxgb4: release hw resources on device removal
         [26bff1bd74a4f7417509a83295614e9dab995b2a]

Rasmus Villemoes (1):
      drivers: tty: Merge alloc_tty_struct and initialize_tty_struct
         [2c964a2f4191f2229566895f1a0e85f8339f5dd1]

Ravi Chandra Sadineni (1):
      USB: Increment wakeup count on remote wakeup.
         [83a62c51ba7b3c0bf45150c4eac7aefc6c785e94]

Richard Weinberger (2):
      ubi: Reject MLC NAND
         [b5094b7f135be34630e3ea8a98fa215715d0f29d]
      ubifs: Check ubifs_wbuf_sync() return code
         [aac17948a7ce01fb60b9ee6cf902967a47b3ce26]

Robbie Ko (1):
      Btrfs: send, fix invalid access to commit roots due to concurrent snapshotting
         [6f2f0b394b54e2b159ef969a0b5274e9bbf82ff2]

Rodrigo Rivas Costa (1):
      HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device
         [a955358d54695e4ad9f7d6489a7ac4d69a8fc711]

Roland Dreier (3):
      RDMA/ucma: Allow resolving address w/o specifying source address
         [09abfe7b5b2f442a85f4c4d59ecf582ad76088d7]
      RDMA/ucma: Don't allow setting RDMA_OPTION_IB_PATH without an RDMA device
         [8435168d50e66fa5eae01852769d20a36f9e5e83]
      RDMA/ucma: Introduce safer rdma_addr_size() variants
         [84652aefb347297aa08e91e283adf7b18f77c2d5]

Romain Izard (1):
      ubi: Fix error for write access
         [78a8dfbabbece22bee58ac4cb26cab10e7a19c5d]

Ronnie Sahlberg (1):
      cifs: fix memory leak in SMB2_open()
         [b7a73c84eb96dabd6bb8e9d7c56f796d83efee8e]

Russell King (1):
      ARM: keystone: fix platform_domain_notifier array overrun
         [9954b80b8c0e8abc98e17bba0fccd9876211ceaa]

SZ Lin (1):
      NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
         [9306b38e42cb266f98bff6f6f4c1c652aa79ba45]

Sachin Grover (1):
      selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
         [efe3de79e0b52ca281ef6691480c8c68c82a4657]

Sean Young (1):
      media: rc: oops in ir_timer_keyup after device unplug
         [8d4068810d9926250dd2435719a080b889eb44c3]

Sebastian Ott (1):
      s390/cio: update chpid descriptor after resource accessibility event
         [af2e460ade0b0180d0f3812ca4f4f59cc9597f3e]

Sekhar Nori (1):
      ARM: davinci: board-dm646x-evm: set VPIF capture card name
         [bb7298a7e87cf3430eb62be8746e5d7a07ca9d7c]

Sergei Shtylyov (1):
      drm: rcar-du: lvds: Fix LVDS startup on R-Car Gen2
         [8525d04ba8a6a9ecfa4bd619c988ca873a5fc2a4]

Shamir Rabinovitch (1):
      RDMA/ucma: ucma_context reference leak in error path
         [ef95a90ae6f4f21990e1f7ced6719784a409e811]

Shuah Khan (2):
      usbip: vhci_hcd: Fix usb device and sockfd leaks
         [9020a7efe537856eb3e826ebebdf38a5d07a7857]
      usbip: vhci_hcd: check rhport before using in vhci_hub_control()
         [5b22f676118ff25049382041da0db8012e57c9e8]

Song Liu (1):
      tracing: Fix bad use of igrab in trace_uprobe.c
         [0c92c7a3c5d416f47b32c5f20a611dfeca5d5f2e]

Stefan Brüns (1):
      drm/i915: Try EDID bitbanging on HDMI after failed read
         [cfb926e148e99acc02351d72e8b85e32b5f786ef]

Stefan Haberland (1):
      s390/dasd: fix IO error for newly defined devices
         [5d27a2bf6e14f5c7d1033ad1e993fcd0eba43e83]

Steve French (2):
      cifs: do not allow creating sockets except with SMB1 posix exensions
         [1d0cffa674cfa7d185a302c8c6850fc50b893bed]
      smb3: directory sync should not return an error
         [6e70c267e68d77679534dcf4aaf84e66f2cf1425]

Steven Rostedt (3):
      tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flush_tlb{_all}
         [45dd9b0666a162f8e4be76096716670cf1741f0e]
      tracing: Fix crash when freeing instances with event triggers
         [86b389ff22bd6ad8fd3cb98e41cd271886c6d023]
      tracing: Fix regex_match_front() to not over compare the test string
         [dc432c3d7f9bceb3de6f5b44fb9c657c9810ed6d]

Sudhir Sreedharan (1):
      rtl8187: Fix NULL pointer dereference in priv->conf_mutex
         [7972326a26b5bf8dc2adac575c4e03ee7e9d193a]

Sudip Mukherjee (1):
      libata: blacklist Micron 500IT SSD with MU01 firmware
         [136d769e0b3475d71350aa3648a116a6ee7a8f6c]

Sven Eckelmann (1):
      batman-adv: Avoid race in TT TVLV allocator helper
         [8ba0f9bd3bdea1058c2b2676bec7905724418e40]

Takashi Iwai (21):
      ALSA: aloop: Add missing cable lock to ctl API callbacks
         [76b3421b39bd610546931fc923edcf90c18fa395]
      ALSA: asihpi: Hardening for potential Spectre v1
         [f9d94b57e30fd1575b4935045b32d738668aa74b]
      ALSA: control: Hardening for potential Spectre v1
         [088e861edffb84879cf0c0d1b02eda078c3a0ffe]
      ALSA: hda: Hardening for potential Spectre v1
         [69fa6f19b95597618ab30438a27b67ad93daa7c7]
      ALSA: hdspm: Hardening for potential Spectre v1
         [10513142a7114d251670361ad40cba2c61403406]
      ALSA: opl3: Hardening for potential Spectre v1
         [7f054a5bee0987f1e2d4e59daea462421c76f2cb]
      ALSA: pcm: Avoid potential races between OSS ioctls and read/write
         [02a5d6925cd34c3b774bdb8eefb057c40a30e870]
      ALSA: pcm: Check PCM state at xfern compat ioctl
         [f13876e2c33a657a71bcbb10f767c0951b165020]
      ALSA: pcm: Fix UAF at PCM release via PCM timer access
         [a820ccbe21e8ce8e86c39cd1d3bc8c7d1cbb949b]
      ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation
         [e15dc99dbb9cf99f6432e8e3c0b3a8f7a3403a86]
      ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
         [f6d297df4dd47ef949540e4a201230d0c5308325]
      ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
         [40cab6e88cb0b6c56d3f30b7491a20e803f948f6]
      ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation
         [c64ed5dd9feba193c76eb460b451225ac2a0d87b]
      ALSA: rawmidi: Fix missing input substream checks in compat ioctls
         [8a56ef4f3ffba9ebf4967b61ef600b0a7ba10f11]
      ALSA: rme9652: Hardening for potential Spectre v1
         [f526afcd8f71945c23ce581d7864ace93de8a4f7]
      ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
         [8f22e52528cc372b218b5f100457469615c733ce]
      ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
         [f5e94b4c6ebdabe0f602d796e0430180927521a0]
      ALSA: seq: oss: Hardening for potential Spectre v1
         [8d218dd8116695ecda7164f97631c069938aa22e]
      ALSA: timer: Call notifier in the same spinlock
         [f65e0d299807d8a11812845c972493c3f9a18e10]
      ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
         [1d8d6428d1da642ddd75b0be2d1bb1123ff8e017]
      resource: fix integer overflow at reallocation
         [60bb83b81169820c691fbfa33a6a4aef32aa4b0b]

Tarick Bedeir (1):
      net/mlx4_core: Fix error handling in mlx4_init_port_info.
         [57f6f99fdad9984801cde05c1db68fe39b474a10]

Tejun Heo (1):
      libata: Blacklist some Sandisk SSDs for NCQ
         [322579dcc865b94b47345ad1b6002ad167f85405]

Tetsuo Handa (4):
      tty: Avoid possible error pointer dereference at tty_ldisc_restore().
         [598c2d41ff44889dd8eced4f117403e472158d85]
      tty: Don't call panic() at tty_ldisc_init()
         [903f9db10f18f735e62ba447147b6c434b6af003]
      tty: Use __GFP_NOFAIL for tty_ldisc_get()
         [bcdd0ca8cb8730573afebcaae4138f8f4c8eaa20]
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure
         [a466ef76b815b86748d9870ef2a430af7b39c710]

Theodore Ts'o (6):
      ext4: add bounds checking to ext4_xattr_find_entry()
         [9496005d6ca4cf8f5ee8f828165a8956872dc59d]
      ext4: add extra checks to ext4_xattr_block_get()
         [54dd0e0a1b255f115f8647fc6fb93273251b01b9]
      ext4: don't update checksum of new initialized bitmaps
         [044e6e3d74a3d7103a0c8a9305dfd94d64000660]
      ext4: force revalidation of directory pointer after seekdir(2)
         [e40ff213898502d299351cc2fe1e350cd186f0d3]
      ext4: set h_journal if there is a failure starting a reserved handle
         [b2569260d55228b617bd82aba6d0db2faeeb4116]
      jbd2: if the journal is aborted then don't allow update of the log tail
         [85e0c4e89c1b864e763c4e3bb15d0b6d501ad5d9]

Thinh Nguyen (1):
      usb: dwc3: pci: Properly cleanup resource
         [cabdf83dadfb3d83eec31e0f0638a92dbd716435]

Tony Lindgren (1):
      net: davinci_emac: Fix runtime pm calls for davinci_emac
         [b5133e7a988b2cf8e1cd2b23231f36aff35ceffc]

Toshiaki Makita (1):
      vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi
         [7ce2367254e84753bceb07327aaf5c953cfce117]

Uwe Kleine-König (1):
      serial: altera: ensure port->regshift is honored consistently
         [0e254963b6ba4d63ac911e79537fea38dd03dc50]

Vasily Gorbik (1):
      s390/ipl: ensure loadparm valid flag is set
         [15deb080a6087b73089139569558965750e69d67]

Vasyl Vavrychuk (1):
      USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster
         [470b5d6f0cf4674be2d1ec94e54283a1770b6a1a]

Wei Huang (1):
      KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed
         [c4d2188206bafa177ea58e9a25b952baa0bf7712]

Wenwen Wang (1):
      ALSA: control: fix a redundant-copy issue
         [3f12888dfae2a48741c4caa9214885b3aaf350f9]

Willem de Bruijn (2):
      net: test tailroom before appending to linear skb
         [113f99c3358564a0647d444c2ae34e8b1abfd5b9]
      packet: fix bitfield update race
         [a6361f0ca4b25460f2cdf3235ebe8115f622901e]

Wolfgang Bumiller (1):
      net: fix deadlock while clearing neighbor proxy table
         [53b76cdf7e8fecec1d09e38aad2f8579882591a8]

Xiaoming Gao (1):
      x86/tsc: Prevent 32bit truncation in calc_hpet_ref()
         [d3878e164dcd3925a237a20e879432400e369172]

Xin Long (5):
      bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave
         [ddea788c63094f7c483783265563dd5b50052e28]
      sctp: do not check port in sctp_inet6_cmp_addr
         [1071ec9d453a38023579714b64a951a2fb982071]
      sctp: fix the issue that the cookie-ack with auth can't get processed
         [ce402f044e4e432c296f90eaabb8dbe8f3624391]
      sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
         [d625329b06e46bd20baf9ee40847d11982569204]
      team: fix netconsole setup over team
         [9cf2f437ca5b39828984064fad213e68fc17ef11]

Yazen Ghannam (1):
      x86/smpboot: Don't use mwait_play_dead() on AMD systems
         [da6fa7ef67f07108a1b0cb9fd9e7fcaabd39c051]

Yishai Hadas (1):
      RDMA/mlx5: Don't assume that medium blueFlame register exists
         [18b0362e87dfa09e355093b897b9db854e360d28]

Zheng Yan (1):
      ceph: always update atime/mtime/ctime for new inode
         [ffdeec7aa41aa61ca4ee68fddf4669df9ce661d1]

Zhengjun Xing (1):
      USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw
         [64627388b50158fd24d6ad88132525b95a5ef573]

Łukasz Stelmach (1):
      ARM: 8753/1: decompressor: add a missing parameter to the addruart macro
         [e07e3c33b9c0b5751ade624f44325c9bf2487ea6]

 Documentation/networking/ppp_generic.txt         |   6 -
 Makefile                                         |   4 +-
 arch/arc/include/asm/Kbuild                      |   1 +
 arch/arm/boot/compressed/head.S                  |  16 +-
 arch/arm/boot/compressed/misc.c                  |   9 +-
 arch/arm/boot/dts/at91sam9g25.dtsi               |   2 +-
 arch/arm/crypto/Makefile                         |   2 +
 arch/arm/include/asm/assembler.h                 |  10 +
 arch/arm/kernel/traps.c                          |   5 +-
 arch/arm/kvm/arm.c                               |  15 +-
 arch/arm/lib/getuser.S                           |   4 +
 arch/arm/mach-davinci/board-dm646x-evm.c         |   3 +-
 arch/arm/mach-keystone/pm_domain.c               |   1 +
 arch/avr32/include/asm/Kbuild                    |   1 +
 arch/blackfin/include/asm/Kbuild                 |   1 +
 arch/c6x/include/asm/Kbuild                      |   1 +
 arch/cris/include/asm/Kbuild                     |   1 +
 arch/frv/include/asm/Kbuild                      |   1 +
 arch/hexagon/include/asm/Kbuild                  |   1 +
 arch/ia64/include/asm/Kbuild                     |   1 +
 arch/m32r/include/asm/Kbuild                     |   1 +
 arch/metag/include/asm/Kbuild                    |   1 +
 arch/microblaze/include/asm/Kbuild               |   1 +
 arch/mips/include/asm/Kbuild                     |   1 +
 arch/mips/include/asm/uaccess.h                  |  11 +-
 arch/mips/kernel/ptrace.c                        |  24 ++-
 arch/mips/kernel/ptrace32.c                      |   6 +-
 arch/mips/kvm/kvm_mips.c                         |   2 +-
 arch/mips/lib/memset.S                           |  11 +-
 arch/mn10300/include/asm/Kbuild                  |   1 +
 arch/parisc/kernel/drivers.c                     |   4 +
 arch/parisc/kernel/hpmc.S                        |   6 +-
 arch/powerpc/include/asm/barrier.h               |   3 +-
 arch/powerpc/include/asm/opal.h                  |   3 +
 arch/powerpc/include/asm/synch.h                 |   4 -
 arch/powerpc/kernel/cpu_setup_power.S            |   4 +
 arch/powerpc/kernel/eeh_driver.c                 |  61 ++++--
 arch/powerpc/kernel/eeh_pe.c                     |   3 +-
 arch/powerpc/lib/feature-fixups.c                |   2 +-
 arch/powerpc/mm/hugetlbpage.c                    |  17 +-
 arch/powerpc/platforms/powernv/opal-nvram.c      |  21 +-
 arch/s390/hypfs/inode.c                          |   2 +-
 arch/s390/include/asm/Kbuild                     |   1 +
 arch/s390/kernel/ipl.c                           |   1 +
 arch/s390/kernel/perf_cpum_sf.c                  |   4 +
 arch/score/include/asm/Kbuild                    |   1 +
 arch/tile/include/asm/Kbuild                     |   1 +
 arch/um/include/asm/Kbuild                       |   1 +
 arch/um/os-Linux/signal.c                        |   2 +-
 arch/unicore32/include/asm/Kbuild                |   1 +
 arch/x86/boot/compressed/eboot.c                 |   6 +-
 arch/x86/crypto/cast5_avx_glue.c                 |   3 +-
 arch/x86/include/asm/apic.h                      |   4 +-
 arch/x86/include/asm/x2apic.h                    |   2 +-
 arch/x86/kernel/acpi/boot.c                      |  18 +-
 arch/x86/kernel/apic/apic_numachip.c             |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c               |   2 +-
 arch/x86/kernel/cpu/perf_event.c                 |   8 +-
 arch/x86/kernel/machine_kexec_32.c               |   6 +-
 arch/x86/kernel/machine_kexec_64.c               |   4 +-
 arch/x86/kernel/smpboot.c                        |   2 +
 arch/x86/kernel/tsc.c                            |   2 +-
 arch/x86/kvm/x86.c                               |   7 +-
 arch/x86/mm/dump_pagetables.c                    |  10 +-
 arch/x86/net/bpf_jit_comp.c                      |   3 +-
 arch/x86/um/stub_segv.c                          |   2 +-
 arch/x86/xen/mmu.c                               |   6 +-
 arch/xtensa/include/asm/Kbuild                   |   1 +
 crypto/af_alg.c                                  |   8 +-
 crypto/ahash.c                                   |   7 +-
 drivers/ata/ahci.c                               |   1 +
 drivers/ata/libata-core.c                        |   8 +
 drivers/atm/zatm.c                               |   3 +
 drivers/base/regmap/regmap.c                     |  22 +-
 drivers/char/virtio_console.c                    | 157 +++++++-------
 drivers/gpu/drm/drm_fops.c                       |   1 +
 drivers/gpu/drm/i915/i915_cmd_parser.c           |  80 ++++---
 drivers/gpu/drm/i915/i915_drv.h                  |   5 +
 drivers/gpu/drm/i915/i915_gem_userptr.c          |   3 +
 drivers/gpu/drm/i915/intel_hdmi.c                |  14 +-
 drivers/gpu/drm/i915/intel_lvds.c                |  11 +-
 drivers/gpu/drm/msm/msm_gem.c                    |  30 ++-
 drivers/gpu/drm/radeon/radeon_device.c           |  15 +-
 drivers/gpu/drm/radeon/si_dpm.c                  |   4 +-
 drivers/gpu/drm/rcar-du/rcar_du_lvdsenc.c        |  10 +-
 drivers/hid/hid-core.c                           |  12 +-
 drivers/hid/hidraw.c                             |   5 +
 drivers/hid/i2c-hid/i2c-hid.c                    |  13 +-
 drivers/hwmon/nct6683.c                          |   4 +-
 drivers/hwmon/nct6775.c                          |  10 +-
 drivers/hwmon/pmbus/adm1275.c                    |   4 +-
 drivers/hwmon/pmbus/max8688.c                    |   2 +-
 drivers/i2c/busses/i2c-pmcmsp.c                  |   4 +-
 drivers/i2c/busses/i2c-viperboard.c              |   2 +-
 drivers/iio/kfifo_buf.c                          |  11 +-
 drivers/infiniband/core/addr.c                   |  16 ++
 drivers/infiniband/core/iwpm_util.c              |   5 +-
 drivers/infiniband/core/ucma.c                   |  43 ++--
 drivers/infiniband/hw/cxgb4/cq.c                 |  11 +-
 drivers/infiniband/hw/cxgb4/device.c             |   8 +
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h           |   6 +-
 drivers/infiniband/hw/cxgb4/qp.c                 |   4 +-
 drivers/infiniband/hw/cxgb4/resource.c           |  26 ++-
 drivers/infiniband/hw/mlx5/qp.c                  |  39 ++--
 drivers/infiniband/ulp/srp/ib_srp.c              |   8 +-
 drivers/input/serio/i8042-x86ia64io.h            |  24 +++
 drivers/media/pci/cx25821/cx25821-core.c         |   7 +-
 drivers/media/platform/s3c-camif/camif-capture.c |   7 +-
 drivers/media/rc/rc-main.c                       |   4 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c    |   4 +-
 drivers/message/fusion/mptsas.c                  |   1 +
 drivers/mmc/host/jz4740_mmc.c                    |   2 +-
 drivers/mtd/chips/cfi_cmdset_0001.c              |  33 ++-
 drivers/mtd/chips/cfi_cmdset_0002.c              |   9 +-
 drivers/mtd/ubi/block.c                          |   2 +-
 drivers/mtd/ubi/build.c                          |  11 +
 drivers/net/bonding/bond_main.c                  |   3 +-
 drivers/net/can/usb/kvaser_usb.c                 |   2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c       |  11 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c   |  11 +-
 drivers/net/ethernet/cisco/enic/enic_main.c      |   8 +-
 drivers/net/ethernet/marvell/sky2.c              |   2 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c  |  16 ++
 drivers/net/ethernet/mellanox/mlx4/main.c        |   4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h     |   7 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c          |   4 +-
 drivers/net/ethernet/ti/cpsw.c                   |  13 +-
 drivers/net/ethernet/ti/davinci_cpdma.c          |   2 +-
 drivers/net/ethernet/ti/davinci_emac.c           |  62 ++++--
 drivers/net/ppp/ppp_generic.c                    | 136 +++++++-----
 drivers/net/ppp/pppoe.c                          |   4 +
 drivers/net/team/team.c                          |  38 +++-
 drivers/net/usb/qmi_wwan.c                       |  13 ++
 drivers/net/vmxnet3/vmxnet3_drv.c                | 137 ++++++++----
 drivers/net/vmxnet3/vmxnet3_int.h                |   8 +-
 drivers/net/wireless/rtl818x/rtl8187/dev.c       |   2 +-
 drivers/parport/parport_pc.c                     |   4 +
 drivers/pci/hotplug/acpiphp_glue.c               |  23 +-
 drivers/pci/quirks.c                             |  13 ++
 drivers/pinctrl/pinctrl-single.c                 |  22 +-
 drivers/rtc/rtc-snvs.c                           |  15 +-
 drivers/rtc/rtc-tx4939.c                         |   6 +-
 drivers/s390/block/dasd_alias.c                  |  16 +-
 drivers/s390/cio/chsc.c                          |  14 +-
 drivers/s390/cio/qdio_main.c                     |  42 ++--
 drivers/s390/cio/qdio_setup.c                    |  12 +-
 drivers/s390/net/qeth_core_main.c                |   8 +-
 drivers/s390/scsi/zfcp_dbf.c                     |  23 +-
 drivers/s390/scsi/zfcp_ext.h                     |   5 +-
 drivers/s390/scsi/zfcp_scsi.c                    |  14 +-
 drivers/scsi/qla2xxx/qla_init.c                  |   3 +-
 drivers/scsi/sd.c                                |   2 +
 drivers/staging/line6/midi.c                     |   2 +-
 drivers/staging/rtl8192u/r8192U_core.c           |   2 +
 drivers/staging/usbip/usbip_common.h             |   2 +-
 drivers/staging/usbip/vhci_hcd.c                 |   8 +-
 drivers/thermal/imx_thermal.c                    |  19 +-
 drivers/tty/Makefile                             |   3 +-
 drivers/tty/n_null.c                             |  80 +++++++
 drivers/tty/pty.c                                |  19 +-
 drivers/tty/serial/altera_uart.c                 |   6 +-
 drivers/tty/serial/arc_uart.c                    |   8 +-
 drivers/tty/serial/fsl_lpuart.c                  |   4 +
 drivers/tty/serial/imx.c                         |   6 +
 drivers/tty/serial/mxs-auart.c                   |   5 +
 drivers/tty/serial/pxa.c                         |   4 +
 drivers/tty/serial/xilinx_uartps.c               |   2 +-
 drivers/tty/tty_io.c                             |  42 ++--
 drivers/tty/tty_ldisc.c                          |  68 +++---
 drivers/tty/vt/vt.c                              |   6 +-
 drivers/usb/core/config.c                        |   4 +-
 drivers/usb/core/generic.c                       |   9 +-
 drivers/usb/core/hcd.c                           |   1 +
 drivers/usb/core/hub.c                           |  10 +-
 drivers/usb/core/quirks.c                        |   3 +
 drivers/usb/dwc3/dwc3-pci.c                      |   2 +-
 drivers/usb/host/xhci-pci.c                      |   5 +-
 drivers/usb/musb/musb_gadget_ep0.c               |  14 +-
 drivers/usb/musb/musb_host.c                     |   4 +-
 drivers/usb/serial/Kconfig                       |   1 +
 drivers/usb/serial/cp210x.c                      |   2 +
 drivers/usb/serial/ftdi_sio.c                    |   5 +-
 drivers/usb/serial/ftdi_sio_ids.h                |   9 +
 drivers/usb/serial/usb-serial-simple.c           |   7 +
 drivers/usb/serial/visor.c                       |  69 +++---
 drivers/video/fbdev/stifb.c                      |   2 +-
 drivers/watchdog/f71808e_wdt.c                   |   2 +-
 drivers/xen/swiotlb-xen.c                        |   2 +-
 drivers/xen/xen-acpi-processor.c                 |   6 +-
 fs/affs/namei.c                                  |  10 +-
 fs/afs/security.c                                |  13 +-
 fs/aio.c                                         |   7 +-
 fs/autofs4/root.c                                |   2 +-
 fs/btrfs/ctree.c                                 |  16 +-
 fs/btrfs/extent-tree.c                           |   1 +
 fs/btrfs/inode.c                                 | 231 +++++++++++++-------
 fs/btrfs/ioctl.c                                 |  22 +-
 fs/btrfs/tests/qgroup-tests.c                    |   2 +-
 fs/btrfs/tree-log.c                              |  12 +-
 fs/buffer.c                                      |   2 +-
 fs/ceph/inode.c                                  |  10 +-
 fs/cifs/cifsfs.c                                 |  13 ++
 fs/cifs/dir.c                                    |   9 +-
 fs/cifs/smb2pdu.c                                |  49 +++--
 fs/dcache.c                                      |  22 ++
 fs/ecryptfs/inode.c                              |   3 +-
 fs/ext2/inode.c                                  |  10 -
 fs/ext2/namei.c                                  |   6 +-
 fs/ext3/namei.c                                  |   6 +-
 fs/ext4/balloc.c                                 |   3 +-
 fs/ext4/dir.c                                    |   8 +-
 fs/ext4/ialloc.c                                 |  43 +---
 fs/ext4/indirect.c                               |   5 +-
 fs/ext4/namei.c                                  |   6 +-
 fs/ext4/xattr.c                                  |  86 +++++---
 fs/ext4/xattr.h                                  |  11 +
 fs/f2fs/f2fs.h                                   |   1 +
 fs/f2fs/gc.c                                     |   2 +-
 fs/f2fs/inode.c                                  |  23 ++
 fs/f2fs/namei.c                                  |  52 ++---
 fs/fs-writeback.c                                |   2 +-
 fs/hugetlbfs/inode.c                             |  10 +-
 fs/jbd2/journal.c                                |   5 +-
 fs/jbd2/transaction.c                            |   1 +
 fs/jffs2/dir.c                                   |  12 +-
 fs/jffs2/super.c                                 |   2 +-
 fs/jfs/namei.c                                   |  12 +-
 fs/namespace.c                                   |   3 +-
 fs/nilfs2/namei.c                                |   6 +-
 fs/notify/fanotify/fanotify.c                    |  34 ++-
 fs/ocfs2/dlm/dlmcommon.h                         |   1 +
 fs/ocfs2/dlm/dlmdomain.c                         |  15 ++
 fs/ocfs2/dlm/dlmrecovery.c                       |  13 +-
 fs/proc/proc_sysctl.c                            |   3 +
 fs/reiserfs/journal.c                            |   2 +-
 fs/reiserfs/namei.c                              |  12 +-
 fs/ubifs/super.c                                 |  14 +-
 fs/udf/ialloc.c                                  |   7 +-
 fs/udf/namei.c                                   | 106 ++++-----
 fs/ufs/ialloc.c                                  |   6 +-
 fs/ufs/namei.c                                   |  14 +-
 include/asm-generic/word-at-a-time.h             |  80 ++++++-
 include/linux/clk-provider.h                     |   3 +-
 include/linux/dcache.h                           |   1 +
 include/linux/efi.h                              |   8 +-
 include/linux/hid.h                              |   4 +-
 include/linux/iio/buffer.h                       |   6 +-
 include/linux/log2.h                             |  13 +-
 include/linux/msg.h                              |   4 +-
 include/linux/mtd/flashchip.h                    |   1 +
 include/linux/shm.h                              |   4 +-
 include/linux/string.h                           |   3 +
 include/linux/tty.h                              |   6 +-
 include/linux/virtio.h                           |   3 +
 include/net/dst.h                                |   1 +
 include/net/inet_timewait_sock.h                 |   1 +
 include/net/nexthop.h                            |   2 +-
 include/rdma/ib_addr.h                           |   2 +
 include/sound/control.h                          |   7 +-
 include/sound/pcm_oss.h                          |   1 +
 include/trace/events/xen.h                       |  16 --
 include/uapi/linux/ppp-ioctl.h                   |   2 +-
 include/uapi/linux/tty.h                         |   1 +
 ipc/msg.c                                        |  19 +-
 ipc/msgutil.c                                    |   2 +-
 ipc/sem.c                                        |  38 ++--
 ipc/shm.c                                        | 116 +++++++---
 ipc/util.c                                       |   9 +
 ipc/util.h                                       |  11 +
 kernel/resource.c                                |   3 +-
 kernel/sched/auto_group.c                        |   9 +-
 kernel/sched/core.c                              |   3 +
 kernel/sys.c                                     |   4 +
 kernel/time/clocksource.c                        |   2 +
 kernel/time/tick-broadcast.c                     |   8 +
 kernel/trace/trace_events_filter.c               |   3 +
 kernel/trace/trace_events_trigger.c              |   5 +-
 kernel/trace/trace_uprobe.c                      |  32 ++-
 kernel/tracepoint.c                              |   4 +-
 lib/string.c                                     |  88 ++++++++
 mm/filemap.c                                     |   7 +-
 mm/mmap.c                                        |  32 +++
 net/atm/lec.c                                    |   9 +-
 net/batman-adv/translation-table.c               |  93 ++++++--
 net/bridge/netfilter/ebtables.c                  |   3 +-
 net/ceph/messenger.c                             |   7 +
 net/compat.c                                     |   6 +-
 net/core/dev.c                                   |   3 +-
 net/core/dev_addr_lists.c                        |   4 +-
 net/core/neighbour.c                             |  30 ++-
 net/core/skbuff.c                                |   1 +
 net/dccp/ccids/ccid2.c                           |  14 +-
 net/dccp/timer.c                                 |   2 +-
 net/dns_resolver/dns_key.c                       |  14 +-
 net/ipv4/inet_timewait_sock.c                    |   1 +
 net/ipv4/ip_output.c                             |   3 +-
 net/ipv4/ip_tunnel.c                             |  17 +-
 net/ipv4/ping.c                                  |   7 +-
 net/ipv4/route.c                                 | 118 +++++-----
 net/ipv4/tcp.c                                   |   8 +-
 net/ipv4/tcp_input.c                             |   7 +-
 net/ipv4/tcp_output.c                            |   7 +-
 net/ipv4/udp.c                                   |   7 +-
 net/ipv6/ip6_gre.c                               |   8 +-
 net/ipv6/ip6_output.c                            |   3 +-
 net/ipv6/ip6_tunnel.c                            |   8 +-
 net/ipv6/ip6_vti.c                               |   7 +-
 net/ipv6/route.c                                 |   2 +
 net/ipv6/sit.c                                   |   8 +-
 net/ipv6/xfrm6_policy.c                          |   2 +-
 net/l2tp/l2tp_core.c                             | 260 ++++++++++-------------
 net/l2tp/l2tp_core.h                             |   7 +-
 net/l2tp/l2tp_debugfs.c                          |  18 +-
 net/l2tp/l2tp_netlink.c                          |  28 ++-
 net/l2tp/l2tp_ppp.c                              |  43 +++-
 net/llc/af_llc.c                                 |  17 +-
 net/netfilter/ipvs/ip_vs_core.c                  |   8 +
 net/netfilter/ipvs/ip_vs_ctl.c                   |  15 +-
 net/netfilter/ipvs/ip_vs_sync.c                  |  10 +-
 net/netfilter/nf_tables_api.c                    |  59 ++---
 net/netlink/af_netlink.c                         |   2 +
 net/packet/af_packet.c                           |  86 +++++---
 net/packet/internal.h                            |  10 +-
 net/rfkill/rfkill-gpio.c                         |   7 +-
 net/sched/sch_fq.c                               |  37 ++--
 net/sctp/inqueue.c                               |   2 +-
 net/sctp/ipv6.c                                  |  65 +++---
 net/sunrpc/rpc_pipe.c                            |   1 +
 security/selinux/ss/services.c                   |   2 +-
 sound/core/control_compat.c                      |   3 +-
 sound/core/oss/pcm_oss.c                         | 186 ++++++++++++----
 sound/core/pcm.c                                 |   8 +-
 sound/core/pcm_compat.c                          |   2 +
 sound/core/pcm_native.c                          |   1 +
 sound/core/rawmidi_compat.c                      |  18 +-
 sound/core/seq/oss/seq_oss_event.c               |  15 +-
 sound/core/seq/oss/seq_oss_midi.c                |   2 +
 sound/core/seq/oss/seq_oss_synth.c               |  85 ++++----
 sound/core/seq/oss/seq_oss_synth.h               |   3 +-
 sound/core/seq/seq_virmidi.c                     |   4 +-
 sound/core/timer.c                               | 222 +++++++++----------
 sound/drivers/aloop.c                            |  17 +-
 sound/drivers/opl3/opl3_synth.c                  |   7 +-
 sound/pci/asihpi/hpimsginit.c                    |  39 ++--
 sound/pci/asihpi/hpioctl.c                       |   4 +-
 sound/pci/hda/hda_hwdep.c                        |  12 +-
 sound/pci/rme9652/hdspm.c                        |  24 ++-
 sound/pci/rme9652/rme9652.c                      |   6 +-
 sound/soc/codecs/ssm2602.c                       |  19 +-
 sound/soc/fsl/fsl_esai.c                         |   7 +
 sound/usb/mixer.c                                |   8 +
 sound/usb/mixer_maps.c                           |   3 +
 tools/perf/Documentation/perf-top.txt            |   3 +
 tools/perf/builtin-record.c                      |   2 +-
 354 files changed, 3603 insertions(+), 1941 deletions(-)

-- 
Ben Hutchings
I haven't lost my mind; it's backed up on tape somewhere.

