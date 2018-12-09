Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959DAC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEE32081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEE32081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeLIW2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:28:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34532 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbeLIVzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:10 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0002iY-Qj; Sun, 09 Dec 2018 21:55:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72X-0003C8-Ml; Sun, 09 Dec 2018 21:55:05 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date:   Sun, 09 Dec 2018 21:50:32 +0000
Message-ID: <lsq.1544392232.713909046@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 000/328] 3.16.62-rc1 review
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.62 release.
There are 328 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Dec 14 18:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Aaron Knister (1):
      IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler
         [816e846c2eb9129a3e0afa5f920c8bbc71efecaa]

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72
         [91a97507323e1ad4bfc10f4a5922e67cdaf8b3cd]

Akihiro Tsukada (1):
      media: dvb-usb-v2/gl861: ensure USB message buffers DMA'able
         [86f65c218123c4e36fd855fbbc38147ffaf29974]

Al Viro (1):
      cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)
         [169b803397499be85bdd1e3d07d6f5e3d4bd669e]

Alan Stern (6):
      USB: fix error handling in usb_driver_claim_interface()
         [bd729f9d67aa9a303d8925bb8c4f06af25f407d1]
      USB: fix the usbfs flag sanitization for control transfers
         [665c365a77fbfeabe52694aedf3446d5f2f1ce42]
      USB: handle NULL config in usb_find_alt_setting()
         [c9a4cb204e9eb7fa7dfbe3f7d3a674fa530aa193]
      USB: leave LPM alone if possible when binding/unbinding interface drivers
         [6fb650d43da3e7054984dc548eaa88765a94d49f]
      USB: net2280: Fix erroneous synchronization change
         [dec3c23c9aa1815f07d98ae0375b4cbc10971e13]
      USB: remove LPM management from usb_driver_claim_interface()
         [c183813fcee44a249339b7c46e1ad271ca1870aa]

Alexander Aring (4):
      mac802154: tx: cleanup crc calculation
         [b7eec52bcb7ab93a8cce0f718f42fa17d6d91745]
      mac802154: tx: use put_unaligned_le16 for copy crc
         [061ef8f915988839b12460c47ebfcf3700e124f0]
      net: 6lowpan: fix reserved space for single frames
         [ac74f87c789af40936a80131c4759f3e72579c3a]
      net: mac802154: tx: expand tailroom if necessary
         [f9c52831133050c6b82aa8b6831c92da2bbf2a0b]

Anand Jain (1):
      btrfs: rename total_bytes to avoid confusion
         [3c1dbdf54a31f4f049a33214c3096595988786bf]

Andi Kleen (2):
      x86/spectre: Add missing family 6 check to microcode check
         [1ab534e85c93945f7862378d8c8adcf408205b19]
      x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+
         [cc51e5428ea54f575d49cfcede1d4cb3a72b4ec4]

Andrei Otcheretianski (1):
      cfg80211: reg: Init wiphy_idx in regulatory_hint_core()
         [24f33e64fcd0d50a4b1a8e5b41bd0257aa66b0e8]

Andrey Ryabinin (1):
      fuse: Don't access pipe->buffers without pipe_lock()
         [a2477b0e67c52f4364a47c3ad70902bc2a61bd4c]

Andy Lutomirski (1):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks
         [715bd9d12f84d8f5cc8ad21d888f9bc304a8eb0b]

Anssi Hannula (1):
      net: macb: do not disable MDIO bus at open/close time
         [0da70f808029476001109b6cb076737bc04cea2e]

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE
         [4f0223bfe9c3e62d8f45a85f1ef1b18a8a263ef9]

Ashish Samant (1):
      ocfs2: fix locking for res->tracking and dlm->tracking_list
         [cbe355f57c8074bc4f452e5b6e35509044c6fa23]

Ashok Raj (1):
      x86/microcode/intel: Check microcode revision before updating sibling threads
         [c182d2b7d0ca48e0d6ff16f7d883161238c447ed]

Aurelien Aptel (1):
      smb2: fix missing files in root share directory listing
         [0595751f267994c3c7027377058e4185b3a28e75]

Bart Van Assche (4):
      IB/srpt: Support HCAs with more than two ports
         [e620ebfc228dcbef7519e3d16f43c6c6f1a1d0cb]
      scsi: core: Avoid that SCSI device removal through sysfs triggers a deadlock
         [0ee223b2e1f67cb2de9c0e3247c510d846e74d63]
      scsi: sysfs: Introduce sysfs_{un,}break_active_protection()
         [2afc9166f79b8f6da5f347f48515215ceee4ae37]
      scsi: target/iscsi: Make iscsit_ta_authentication() respect the output buffer size
         [35bea5c84fd13c643cce63f0b5cd4b148f8c901d]

Ben Hutchings (1):
      USB: yurex: Fix buffer over-read in yurex_write()
         [7e10f14ebface44a48275c8d6dc1caae3668d5a9]

Benjamin Herrenschmidt (1):
      powerpc/powernv/pci: Work around races in PCI bridge enabling
         [db2173198b9513f7add8009f225afa1f1c79bcc6]

Bhaktipriya Shridhar (1):
      bcache: Remove deprecated create_workqueue
         [81baf90af2dcc8259e99e2f236024524b55313fc]

Bin Yang (1):
      pstore: Fix incorrect persistent ram buffer mapping
         [831b624df1b420c8f9281ed1307a8db23afb72df]

Boris Ostrovsky (1):
      x86/EISA: Don't probe EISA bus for Xen PV guests
         [6a92b11169a65b3f8cc512c75a252cbd0d096ba0]

Borislav Petkov (1):
      x86/microcode/intel: Add a helper which gives the microcode revision
         [4167709bbf826512a52ebd6aafda2be104adaec9]

Catalin Marinas (1):
      cpuidle: Do not access cpuidle_devices when !CONFIG_CPU_IDLE
         [9bd616e3dbedfc103f158197c8ad93678849b1ed]

Chirantan Ekbote (1):
      9p/net: Fix zero-copy path in the 9p virtio transport
         [d28c756caee6e414d9ba367d0b92da24145af2a8]

Christian Brauner (1):
      getxattr: use correct xattr length
         [82c9a927bc5df6e06b72d206d24a9d10cced4eb5]

Christophe JAILLET (1):
      serial: pxa: Fix an error handling path in 'serial_pxa_probe()'
         [95a0e656580fab3128c7bee5f660c50784f53651]

Christophe Leroy (1):
      serial: cpm_uart: return immediately from console poll
         [be28c1e3ca29887e207f0cbcd294cefe5074bab6]

Claudio Imbrenda (1):
      s390/kvm: fix deadlock when killed by oom
         [306d6c49ac9ded11114cb53b0925da52f2c2ada1]

Colin Ian King (2):
      leds: max8997: use mode when calling max8997_led_set_mode
         [7a5de56db902ea632a0ff0c2b47481d278db645f]
      staging: rts5208: fix missing error check on call to rtsx_write_register
         [c5fae4f4fd28189b1062fb8ef7b21fec37cb8b17]

Corey Minyard (1):
      ipmi: Move BT capabilities detection to the detect call
         [c86ba91be75702c013bbf7379542920b6920e98f]

Dan Carpenter (16):
      CIFS: fix wrapping bugs in num_entries()
         [56446f218af1133c802dad8e9e116f07f381846c]
      cifs: integer overflow in in SMB2_ioctl()
         [2d204ee9d671327915260071c19350d84344e096]
      cifs: prevent integer overflow in nxt_dir_entry()
         [8ad8aa353524d89fa2e09522f3078166ff78ec42]
      drm/panel: type promotion bug in s6e8aa0_read_mtp_id()
         [cd0e0ca69109d025b1a1b6609f70682db62138b0]
      fbdev: omapfb: off by one in omapfb_register_client()
         [5ec1ec35b2979b59d0b33381e7c9aac17e159d16]
      hwmon: (nct6775) Set weight source to zero correctly
         [e3f3d7ab00cd459d0f7a839758a4542f4d4b8ac8]
      mei: bus: type promotion bug in mei_nfc_if_version()
         [b40b3e9358fbafff6a4ba0f4b9658f6617146f9c]
      net: sched: act_ipt: check for underflow in __tcf_ipt_init()
         [aeadd93f2b0a609f603ac33e574b97a9832d1b90]
      pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()
         [19da44cd33a3a6ff7c97fff0189999ff15b241e4]
      pinctrl: imx: off by one in imx_pinconf_group_dbg_show()
         [b4859f3edb47825f62d1b2efdd75fe7945996f49]
      powerpc: Fix size calculation using resource_size()
         [c42d3be0c06f0c1c416054022aa535c08a1f9b39]
      rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()
         [ae636fb1554833ee5133ca47bf4b2791b6739c52]
      scsi: aic94xx: fix an error code in aic94xx_init()
         [0756c57bce3d26da2592d834d8910b6887021701]
      uio: potential double frees if __uio_register_device() fails
         [f019f07ecf6a6b8bd6d7853bce70925d90af02d1]
      vmci: type promotion bug in qp_host_get_user_memory()
         [7fb2fd4e25fc1fb10dcb30b5519de257cfeae84c]
      x86/paravirt: Fix some warning messages
         [571d0563c8881595f4ab027aef9ed1c55e3e7b7c]

Daniel Black (1):
      mm: madvise(MADV_DODUMP): allow hugetlbfs pages
         [d41aa5252394c065d1f04d1ceea885b70d00c9c6]

Daniel Borkmann (2):
      bpf, net: add skb_mac_header_len helper
         [0daf4349406074fc03e4889ba5e97e6fb5311bab]
      crypto: memzero_explicit - make sure to clear out sensitive data
         [7185ad2672a7d50bc384de0e38d90b75d99f3d82]

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume
         [083874549fdfefa629dfa752785e20427dde1511]

Daniel Mack (2):
      libertas: call into generic suspend code before turning off power
         [4f666675cdff0b986195413215eb062b7da6586f]
      libertas: fix suspend and resume for SDIO connected cards
         [7444a8092906ed44c09459780c56ba57043e39b1]

Darrick J. Wong (1):
      xfs: don't fail when converting shortform attr to long form during ATTR_REPLACE
         [7b38460dc8e4eafba06c78f8e37099d3b34d473c]

Dave Chinner (1):
      percpu_counter: batch size aware __percpu_counter_compare()
         [80188b0d77d7426b494af739ac129e0e684acb84]

Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace
         [d26c25a9d19b5976b319af528886f89cf455692d]

David Ahern (1):
      net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs
         [4ba4c566ba8448a05e6257e0b98a21f1a0d55315]

Denis Drozdov (1):
      IB/IPoIB: Set ah valid flag in multicast send flow
         [75da96067ade4e7854379ec2f7834f3497652b1a]

Dexuan Cui (1):
      Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()
         [41e270f6898e7502be9fd6920ee0a108ca259d36]

Douglas Anderson (1):
      pinctrl: msm: Fix msm_config_group_get() to be compliant
         [05e0c828955c1cab58dd71a04539442e5375d917]

Emil Lundmark (1):
      drm: udl: Destroy framebuffer only if it was initialized
         [fcb74da1eb8edd3a4ef9b9724f88ed709d684227]

Eric Biggers (5):
      KEYS: encrypted: fix buffer overread in valid_master_desc()
         [794b4bc292f5d31739d89c0202c54e7dc9bc3add]
      crypto: ablkcipher - fix crash flushing dcache in error path
         [318abdfbe708aaaa652c79fb500e9bd60521f9dc]
      crypto: blkcipher - fix crash flushing dcache in error path
         [0868def3e4100591e7a1fdbf3eed1439cc8f7ca3]
      crypto: vmac - require a block cipher with 128-bit block size
         [73bf20ef3df262026c3470241ae4ac8196943ffa]
      crypto: vmac - separate tfm and request context
         [bb29648102335586e9a66289a1d98a0cb392b6e5]

Eric Dumazet (3):
      ipv6: fix possible use-after-free in ip6_xmit()
         [bbd6528d28c1b8e80832b3b018ec402b6f5c3215]
      net: make skb_partial_csum_set() more robust against overflows
         [52b5d6f5dcf0e5201392f7d417148ccb537dbf6f]
      rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096
         [0e1d6eca5113858ed2caea61a5adc03c595f6096]

Eric W. Biederman (1):
      ipv6: Compute net once in raw6_send_hdrinc
         [adb28c9d3371c845c7a28bfd4fb163aca0d0dc37]

Ethan Lien (1):
      btrfs: use correct compare function of dirty_metadata_bytes
         [d814a49198eafa6163698bdd93961302f3a877a4]

Eugeniy Paltsev (1):
      drm: fb-helper: Reject all pixel format changing requests
         [db05c481977599236f12a85e55de9f5ab37b0a2c]

Evgenii Lepikhin (1):
      ISCSI: fix minor memory leak
         [a928d28d4487402e6bd18bea1b8cc2b2ec6e6d8f]

Felipe Balbi (1):
      usb: gadget: udc: net2280: do not rely on 'driver' argument
         [bfd0ed576dbf9cc71af7dbe42841fc9246524961]

Felix Fietkau (1):
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys
         [211710ca74adf790b46ab3867fcce8047b573cd1]

Filippo Sironi (1):
      x86/microcode: Update the new microcode revision unconditionally
         [8da38ebaad23fe1b0c4a205438676f6356607cfc]

Florian Fainelli (6):
      asix: Check for supported Wake-on-LAN modes
         [c4ce446e33d7a0e978256ac6fea4c80e59d9de5f]
      ax88179_178a: Check for supported Wake-on-LAN modes
         [5ba6b4aa9a410c5e2c6417df52b5e2118ea9b467]
      r8152: Check for supported Wake-on-LAN Modes
         [f2750df1548bd8a2b060eb609fc43ca82811af4c]
      smsc75xx: Check for Wake-on-LAN modes
         [9c734b2769a73eea2e9e9767c0e0bf839ff23679]
      smsc95xx: Check for Wake-on-LAN modes
         [c530c471ba37bdd9fe1c7185b01455c00ae606fb]
      sr9800: Check for supported Wake-on-LAN modes
         [c5cb93e994ffb43b7b3b1ff10b9f928f54574a36]

Florian Schmaus (1):
      bcache: do not assign in if condition in bcache_init()
         [16c1fdf4cfd6c0091e59b93ec2cb7e99973f8244]

Florian Westphal (1):
      netfilter: nf_tables: fix register ordering
         [d209df3e7f7002d9099fdb0f6df0f972b4386a63]

Geert Uytterhoeven (5):
      spi: rspi: Fix interrupted DMA transfers
         [8dbbaa47b96f6ea5f09f922b4effff3c505cd8cf]
      spi: rspi: Fix invalid SPI use during system suspend
         [c1ca59c22c56930b377a665fdd1b43351887830b]
      spi: rspi: Fix leaking of unused DMA descriptors
         [3819bc8752367eae0d72fa1c473dc88ea45631a7]
      spi: rspi: Handle dmaengine_prep_slave_sg() failures gracefully
         [85912a88c1ebcad04a5cfec971771195ce8d6691]
      spi: sh-msiof: Add more register documentation
         [2e2b36872d7b45b1f88a590283b14c67931b777f]

Greg Edwards (2):
      block: move bio_integrity_{intervals,bytes} into blkdev.h
         [359f642700f2ff05d9c94cd9216c97af7b8e9553]
      scsi: virtio_scsi: fix pi_bytes{out,in} on 4 KiB block size devices
         [cdcdcaae8450a975e7d07e1bfec21f9b8c016d0c]

Greg Hackmann (1):
      arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
         [5ad356eabc47d26a92140a0c4b20eba471c10de3]

Guenter Roeck (3):
      hwmon: (nct6775) Fix access to fan pulse registers
         [c793279c77035053e67937f5743c6ebfc303e7c5]
      mfd: sm501: Set coherent_dma_mask when creating subdevices
         [2f606da78230f09cf1a71fde6ee91d0c710fa2b2]
      of: unittest: Disable interrupt node tests for old world MAC systems
         [8894891446c9380709451b99ab45c5c53adfd2fc]

Guillaume Nault (1):
      pppoe: fix reception of frames with no mac header
         [8540827ebac6b654ab2f69c8fbce9e4fbd6304a0]

Guoju Fang (1):
      bcache: add separate workqueue for journal_write to avoid deadlock
         [0f843e65d9eef4936929bb036c5f771fb261eea4]

Gustavo A. R. Silva (9):
      ASoC: wm8994: Fix missing break in switch
         [ad0eaee6195db1db1749dd46b9e6f4466793d178]
      ASoC: wm8994: Mark expected switch fall-through
         [2cea1542859bc812f1ec51ea71c06e927e5b922e]
      IB/ucm: Fix Spectre v1 vulnerability
         [0295e39595e1146522f2722715dba7f7fba42217]
      RDMA/ucma: Fix Spectre v1 vulnerability
         [a3671a4f973ee9d9621d60166cc3b037c397d604]
      hwmon: (nct6775) Fix potential Spectre v1
         [d49dbfade96d5b0863ca8a90122a805edd5ef50a]
      misc: hmc6352: fix potential Spectre v1
         [de916736aaaadddbd6061472969f667b14204aa9]
      ptp: fix Spectre v1 vulnerability
         [efa61c8cf2950ab5c0e66cff3cabe2a2b24e81ba]
      tty: vt_ioctl: fix potential Spectre v1
         [e97267cb4d1ee01ca0929638ec0fcbb0904f903d]
      usb: gadget: storage: Fix Spectre v1 vulnerability
         [9ae24af3669111d418242caec8dd4ebd9ba26860]

H. Nikolaus Schaller (2):
      power: generic-adc-battery: check for duplicate properties copied from iio channels
         [a427503edaaed9b75ed9746a654cece7e93e60a8]
      power: generic-adc-battery: fix out-of-bounds write when copying channel properties
         [932d47448c3caa0fa99e84d7f5bc302aa286efd8]

Haishuang Yan (1):
      vxlan: fix a potential issue when create a new vxlan fdb entry.
         [17b463654f41f0aa334efd5a6efeab8a6e9496f7]

Han Xu (1):
      mtd: fsl-quadspi: fix macro collision problems with READ/WRITE
         [04850c4d8613127a9b488321c0ad83bff7519311]

Hangbin Liu (2):
      igmp: fix incorrect unsolicit report count after link down and up
         [ff06525fcb8ae3c302ac1319bf6c07c026dea964]
      igmp: fix incorrect unsolicit report count when join group
         [4fb7253e4f9a8f06a986a3b317e2f79d9b43d552]

Hari Bathini (1):
      powerpc/fadump: handle crash memory ranges array index overflow
         [1bd6a1c4b80a28d975287630644e6b47d0f977a5]

Heiner Kallweit (1):
      r8169: fix NAPI handling under high load
         [6b839b6cf9eada30b086effb51e5d6076bafc761]

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register
         [31a5fae4c5a009898da6d177901d5328051641ff]

Huacai Chen (1):
      MIPS: Change definition of cpu_relax() for Loongson-3
         [a30718868915fbb991a9ae9e45594b059f28e9ae]

Ido Schimmel (1):
      team: Forbid enslaving team device to itself
         [471b83bd8bbe4e89743683ef8ecb78f7029d8288]

Imre Deak (1):
      drm/i915/bdw: Increase IPS disable timeout to 100ms
         [acb3ef0ee40ea657280a4a11d9f60eb2937c0dca]

Jani Nikula (1):
      drm/i915: set DP Main Stream Attribute for color range on DDI platforms
         [dc5977da99ea28094b8fa4e9bacbd29bedc41de5]

Jann Horn (6):
      RDMA/ucma: check fd type in ucma_migrate_id()
         [0d23ba6034b9cf48b8918404367506da3e4b3ee5]
      mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly
         [58bc4c34d249bf1bc50730a9a209139347cfacfe]
      mtdchar: fix overflows in adjustment of `count`
         [6c6bc9ea84d0008024606bf5ba10519e20d851bf]
      proc: restrict kernel stack dumps to root
         [f8a00cef17206ecd1b30d3d9f99e10d9fa707aa7]
      reiserfs: fix broken xattr handling (heap corruption, bad retval)
         [a13f085d111e90469faf2d9965eb39b11c114d7e]
      x86/process: Don't mix user/kernel regs in 64bit __show_regs()
         [9fe6299dde587788f245e9f7a5a1b296fad4e8c7]

Javier Martinez Canillas (1):
      media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data
         [2ec7debd44b49927a6e2861521994cc075a389ed]

Jean Delvare (1):
      ACPI / bus: Only call dmi_check_system() on X86
         [5d128fbd8b20f8a48cb13c3eced789d1f9573ecd]

Jens Axboe (2):
      bcache: don't embed 'return' statements in closure macros
         [77b5a08427e87514c33730afc18cd02c9475e2c3]
      nbd: don't allow invalid blocksize settings
         [bc811f05d77f47059c197a98b6ad242eb03999cb]

Jeremy Cline (2):
      ext4: fix spectre gadget in ext4_mb_regular_allocator()
         [1a5d5e5d51e75a5bca67dadbcea8c841934b7b85]
      fs/quota: Fix spectre gadget in do_quotactl
         [7b6924d94a60c6b8c1279ca003e8744e6cd9e8b1]

Jia-Ju Bai (2):
      usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_frame()
         [6d4f268fa132742fe96dad22307c68d237356d88]
      usb: misc: uss720: Fix two sleep-in-atomic-context bugs
         [bc8acc214d3f1cafebcbcd101a695bbac716595d]

Jiangyiwen (1):
      9p/virtio: fix off-by-one error in sg list bounds check
         [23cba9cbde0bba05d772b335fe5f66aa82b9ad19]

Jiri Olsa (2):
      perf/core: Protect PMU device removal with a 'pmu_bus_running' check, to fix CONFIG_DEBUG_TEST_DRIVER_REMOVE=y kernel panic
         [0933840acf7b65d6d30a5b6089d882afea57aca3]
      perf/ring_buffer: Prevent concurent ring buffer access
         [cd6fb677ce7e460c25bdd66f689734102ec7d642]

Joel Fernandes (1):
      mm: shmem.c: Correctly annotate new inodes for lockdep
         [b45d71fb89ab8adfe727b9d0ee188ed58582a647]

Johan Hovold (8):
      EDAC, i7core: Fix memleaks and use-after-free on probe and remove
         [6c974d4dfafe5e9ee754f2a6fba0eb1864f1649e]
      EDAC: Fix memleak in module init error path
         [4708aa85d50cc6e962dfa8acf5ad4e0d290a21db]
      USB: serial: io_ti: fix array underflow in completion handler
         [691a03cfe8ca483f9c48153b869d354e4ae3abef]
      USB: serial: kobil_sct: fix modem-status error handling
         [a420b5d939ee58f1d950f0ea782834056520aeaa]
      USB: serial: simple: add Motorola Tetra MTP6550 id
         [f5fad711c06e652f90f581fc7c2caee327c33d31]
      USB: serial: ti_usb_3410_5052: fix array underflow in completion handler
         [5dfdd24eb3d39d815bc952ae98128e967c9bba49]
      tty: fix termios input-speed encoding
         [fada18c48d774b9e837928ecdce6a5d5fdd11ee7]
      tty: fix termios input-speed encoding when using BOTHER
         [1cee38f0363a88db374e50b232ca17b9a4c12fa0]

John Johansen (1):
      apparmor: remove no-op permission check in policy_unpack
         [c037bd615885f1d9d3bdb48531bace79fae1505d]

John Ogness (1):
      USB: serial: sierra: fix potential deadlock at close
         [e60870012e5a35b1506d7b376fddfb30e9da0b27]

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset
         [6e1811900b6fe6f2b4665dba6bd6ed32c6b98575]

Josef Bacik (1):
      Btrfs: fix btrfs_write_inode vs delayed iput deadlock
         [3c4276936f6fbe52884b4ea4e6cc120b890a0f9f]

Julian Wiedmann (1):
      s390/qdio: reset old sbal_state flags
         [64e03ff72623b8c2ea89ca3cb660094e019ed4ae]

Junxiao Bi (1):
      ocfs2: fix ocfs2 read block panic
         [234b69e3e089d850a98e7b3145bd00e9b52b1111]

K. Y. Srinivasan (1):
      Tools: hv: Fix a bug in the key delete code
         [86503bd35dec0ce363e9fdbf5299927422ed3899]

Kees Cook (1):
      pstore/ram: Fix failure-path memory leak in ramoops_init
         [bac6f6cda206ad7cbe0c73c35e494377ce9c4749]

Kirill Tkhai (1):
      fuse: Add missed unlock_page() to fuse_readpages_fill()
         [109728ccc5933151c68d1106e4065478a487a323]

Ladislav Michl (2):
      video: udlfb: Fix unaligned access
         [115e77597efcc94cb1f6cbb7df5cf7ce8feb8632]
      video: udlfb: Remove noisy warnings
         [de4b74bda8e87a4ed45ebc2c26cc3e2eaae38429]

Lars-Peter Clausen (2):
      iio: ad9523: Fix displayed phase
         [5a4e33c1c53ae7d4425f7d94e60e4458a37b349e]
      iio: ad9523: Fix return value for ad952x_store()
         [9a5094ca29ea9b1da301b31fd377c0c0c4c23034]

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads
         [d80771c08363ad7fbf0f56f5301e7ca65065c582]

Li Dongyang (1):
      ext4: don't mark mmp buffer head dirty
         [fe18d649891d813964d3aaeebad873f281627fbc]

Liang Chen (1):
      bcache: explicitly destroy mutex while exiting
         [330a4db89d39a6b43f36da16824eaa7a7509d34d]

Linus Torvalds (2):
      Make file credentials available to the seqfile interfaces
         [34dbbcdbf63360661ff7bda6c5f52f99ac515f92]
      mremap: properly flush TLB before releasing the page
         [eb66ae030829605d61fbef1909ce310e29f78821]

Lior David (1):
      wil6210: missing length check in wmi_set_ie
         [b5a8ffcae4103a9d823ea3aa3a761f65779fbe2a]

Lukas Wunner (3):
      PCI: hotplug: Don't leak pci_slot on registration failure
         [4ce6435820d1f1cc2c2788e232735eb244bcc8a3]
      PCI: pciehp: Fix unprotected list iteration in IRQ handler
         [1204e35bedf4e5015cda559ed8c84789a6dae24e]
      PCI: pciehp: Fix use-after-free on unplug
         [281e878eab191cce4259abbbf1a0322e3adae02c]

Lyude Paul (1):
      drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in connector_detect()
         [6833fb1ec120bf078e1a527c573a09d4de286224]

Maciej W. Rozycki (3):
      MIPS: Correct the 64-bit DSP accumulator register size
         [f5958b4cf4fc38ed4583ab83fb7c4cd1ab05f47b]
      MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup' regression
         [148b9aba99e0bbadf361747d21456e1589015f74]
      binfmt_elf: Respect error return from `regset->active'
         [2f819db565e82e5f73cd42b39925098986693378]

Mahesh Salgaonkar (2):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.
         [74e96bf44f430cf7a01de19ba6cf49b361cdfd6e]
      powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.
         [cd813e1cd7122f2c261dce5b54d1e0c97f80e1a5]

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock
         [7001cab1dabc0b72b2b672ef58a90ab64f5e2343]

Mario Limonciello (1):
      platform/x86: alienware-wmi: Correct a memory leak
         [ff0e9f26288d2daee4950f42b37a3d3d30d36ec1]

Martin Kaiser (1):
      mtd: rawnand: mxc: remove __init qualifier from mxcnd_probe_dt
         [24f0ae995deb728076e3ea93fea1949a9775debf]

Masami Hiramatsu (1):
      kprobes: Make list and blacklist root user read only
         [f2a3ab36077222437b4826fc76111caa14562b7c]

Mathias Nyman (3):
      usb: Avoid use-after-free by flushing endpoints early in usb_set_interface()
         [f9a5b4f58b280c1d26255376713c132f93837621]
      usb: Don't die twice if PCI xhci host is not responding in resume
         [f3dc41c5d22b2ca14a0802a65d8cdc33a3882d4e]
      xhci: Add missing CAS workaround for Intel Sunrise Point xHCI
         [ffe84e01bb1b38c7eb9c6b6da127a6c136d251df]

Mathieu OTHACEHE (1):
      USB: serial: ti_usb_3410_5052: use functions rather than macros
         [d8d841e8332779fae2b18420d39ef407ea3729da]

Matthias Brugger (1):
      tty: fix typo in comment of tty_termios_encode_baud_rate
         [a1d51aa2214cea3f91611893610a2f769cada0e7]

Mauricio Faria de Oliveira (2):
      partitions/aix: append null character to print data from disk
         [d43fdae7bac2def8c4314b5a49822cb7f08a45f1]
      partitions/aix: fix usage of uninitialized lv_info and lvname structures
         [14cb2c8a6c5dae57ee3e2da10fa3db2b9087e39e]

Mauro Carvalho Chehab (1):
      media: rtl28xxu: be sure that it won't go past the array size
         [845b978a871bff3707eee611b32e4be0b9a94dd2]

Max Filippov (2):
      xtensa: increase ranges in ___invalidate_{i,d}cache_all
         [fec3259c9f747c039f90e99570540114c8d81a14]
      xtensa: limit offsets in __loop_cache_{all,page}
         [be75de25251f7cf3e399ca1f584716a95510d24a]

Maxence Duprès (1):
      USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB controller
         [9b83a1c301ad6d24988a128c69b42cbaaf537d82]

Mian Yousaf Kaukab (1):
      usb: gadget: net2280: fix pullup handling
         [11bece5e063ca567e631c6ea3b1611c10dbc3282]

Michael Bringmann (1):
      powerpc/pseries: Fix unitialized timer reset on migration
         [8604895a34d92f5e186ceb931b0d1b384030ea3d]

Michael Büsch (2):
      b43/leds: Ensure NUL-termination of LED name string
         [2aa650d1950fce94f696ebd7db30b8830c2c946f]
      b43legacy/leds: Ensure NUL-termination of LED name string
         [4d77a89e3924b12f4a5628b21237e57ab4703866]

Mika Båtsman (1):
      media: gl861: fix probe of dvb_usb_gl861
         [48db0089bff6f9154f6bd98ce7a6ae3786fa8ebe]

Mike Christie (1):
      iscsi target: fix session creation failure handling
         [26abc916a898d34c5ad159315a2f683def3c5555]

Mike Snitzer (1):
      dm cache metadata: save in-core policy_hint_size to on-disk superblock
         [fd2fa95416188a767a63979296fa3e169a9ef5ec]

Miklos Szeredi (3):
      fuse: Fix oops at process_init_reply()
         [e8f3bd773d22f488724dffb886a1618da85c2966]
      fuse: don't wake up reserved req in fuse_conn_kill()
         [0c4dd4ba1426c599072511dcf95a15ee5e12725b]
      fuse: flush requests on umount
         [580640ba5d331eb5631a5de46941c98f5ed90886]

Mikulas Patocka (13):
      dm: disable CRYPTO_TFM_REQ_MAY_SLEEP to fix a GFP_KERNEL recursion deadlock
         [432061b3da64e488be3403124a72a9250bbe96d4]
      fb: fix lost console when the user unplugs a USB adapter
         [8c5b044299951acd91e830a688dd920477ea1eda]
      mach64: detect the dot clock divider correctly on sparc
         [76ebebd2464c5c8a4453c98b6dbf9c95a599e810]
      udl-kms: change down_interruptible to down
         [8456b99c16d193c4c3b7df305cf431e027f0189c]
      udl-kms: fix crash due to uninitialized memory
         [09a00abe3a9941c2715ca83eb88172cd2f54d8fd]
      udl-kms: handle allocation failure
         [542bb9788a1f485eb1a2229178f665d8ea166156]
      udlfb: don't switch if we are switching to the same videomode
         [564f1807379298dfdb12ed0d5b25fcb89c238527]
      udlfb: fix display corruption of the last line
         [4e705e17ce3409a1f492cfd5dadcf6a4f6075842]
      udlfb: fix semaphore value leak
         [9d0aa601e4cd9c0892f90d36e8488d79b72f4073]
      udlfb: handle allocation failure
         [080fb5240bdcabed7387b814139c3ea172d59fc5]
      udlfb: make a local copy of fb_ops
         [2c29cfc3eaf11779176bf41475cfca49bccba11c]
      udlfb: set line_length in dlfb_ops_set_par
         [0ac319b7af1bb24a33365d0ec82a2f56a59b2a78]
      udlfb: set optimal write delay
         [bb24153a3f13dd0dbc1f8055ad97fe346d598f66]

Nadav Amit (1):
      x86/mm: Use WRITE_ONCE() when setting PTEs
         [9bc4f28af75a91aea0ae383f50b0a430c4509303]

Nicholas Mc Guire (3):
      ALSA: snd-aoa: add of_node_put() in error path
         [222bce5eb88d1af656419db04bcd84b2419fb900]
      ARM: hisi: handle of_iomap and fix missing of_node_put
         [d396cb185c0337aae5664b250cdd9a73f6eb1503]
      cifs: check kmalloc before use
         [126c97f4d0d1b5b956e8b0740c81a2b2a2ae548c]

Nicholas Piggin (1):
      mm: move tlb_table_flush to tlb_flush_mmu_free
         [db7ddef301128dad394f1c0f77027f86ee9a4edb]

Oliver Neukum (3):
      USB: usbdevfs: restore warning for nonsensical flags
         [81e0403b26d94360abd1f6a57311337973bc82cd]
      USB: usbdevfs: sanitize flags more
         [7a68d9fb851012829c29e770621905529bd9490b]
      usb: uas: add support for more quirk flags
         [42d1c6d4a06a77b3ab206a919b9050c3080f3a71]

Olle Liljenzin (1):
      platform/x86: ideapad-laptop: Add Y520-15IKBN to no_hw_rfkill
         [5d9f40b56630a8702b5f7a61a770f9b73aa07464]

Ondrej Mosnáček (1):
      audit: Fix extended comparison of GID/EGID
         [af85d1772e31fed34165a1b3decef340cf4080c0]

Paolo Abeni (2):
      ip6_tunnel: be careful when accessing the inner header
         [76c0ddd8c3a683f6e2c6e60e11dc1a1558caf4bc]
      ip_tunnel: be careful when accessing the inner header
         [ccfec9e5cb2d48df5a955b7bf47f7782157d3bc2]

Parav Pandit (1):
      RDMA/cma: Protect cma dev list with lock
         [954a8e3aea87e896e320cf648c1a5bbe47de443e]

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function
         [46dec40fb741f00f1864580130779aeeaf24fb3d]

Pavel Tikhomirov (1):
      mm: cleancache: fix corruption on missed inode invalidation
         [6ff38bd40230af35e446239396e5fc8ebd6a5248]

Peter Zijlstra (3):
      mm/tlb: Remove tlb_remove_table() non-concurrent condition
         [a6f572084fbee8b30f91465f4a085d7a90901c57]
      perf/core: Fix perf_pmu_unregister() locking
         [a9f9772114c8b07ae75bcb3654bd017461248095]
      x86/percpu: Fix this_cpu_read()
         [b59167ac7bafd804c91e49ad53c6d33a7394d4c8]

Piaojun (1):
      fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr failed
         [3111784bee81591ea2815011688d28b65df03627]

Prarit Bhargava (1):
      x86/microcode: Make sure boot_cpu_data.microcode is up-to-date
         [370a132bb2227ff76278f98370e0e701d86ff752]

Punit Agrawal (2):
      KVM: arm/arm64: Skip updating PMD entry if no change
         [86658b819cd0a9aa584cd84453ed268a6f013770]
      KVM: arm/arm64: Skip updating PTE entry if no change
         [976d34e2dab10ece5ea8fe7090b7692913f89084]

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors
         [69e445ab8b66a9f30519842ef18be555d3ee9b51]

Rian Hunter (1):
      x86/process: Re-export start_thread()
         [dc76803e57cc86589c4efcb5362918f9b0c0436f]

Richard Weinberger (4):
      ubifs: Check data node size before truncate
         [95a22d2084d72ea067d8323cc85677dba5d97cae]
      ubifs: Check for name being NULL while mounting
         [37f31b6ca4311b94d985fb398a72e5399ad57925]
      ubifs: Fix memory leak in lprobs self-check
         [eef19816ada3abd56d9f20c88794cc2fea83ebb2]
      ubifs: Fix synced_i_size calculation for xattr inodes
         [59965593205fa4044850d35ee3557cf0b7edcd14]

Roopa Prabhu (2):
      vxlan: add new fdb alloc and create helpers
         [25e20e730d56471cffa25419bf2a66078bd55330]
      vxlan: fix default fdb entry netlink notify ordering during netdev create
         [0241b836732f5f43c3f0fd9e9073c1fb24ea6757]

Sabrina Dubroca (2):
      ipv6: fix cleanup ordering for pingv6 registration
         [a03dc36bdca6b614651fedfcd8559cf914d2d21d]
      net: ipv4: update fnhe_pmtu when first hop's MTU changes
         [af7d6cce53694a88d6a1bb60c9a239a6a5144459]

Sagi Grimberg (1):
      iscsi-target: nullify session in failed login sequence
         [a0b3b9b2409b409c677f7eb1e0485b816a5848f7]

Sebastian Ott (1):
      s390/pci: fix out of bounds access during irq setup
         [866f3576a72b2233a76dffb80290f8086dc49e17]

Shahed Shaikh (1):
      qlcnic: fix Tx descriptor corruption on 82xx devices
         [c333fa0c4f220f8f7ea5acd6b0ebf3bf13fd684d]

Shenghui Wang (1):
      dm cache: destroy migration_cache if cache target registration failed
         [c7cd55504a5b0fc826a2cd9540845979d24ae542]

Shuah Khan (1):
      usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()
         [81f7567c51ad97668d1c3a48e8ecc482e64d4161]

Shubhrajyoti Datta (1):
      i2c: xiic: Make the start and the byte count write atomic
         [ae7304c3ea28a3ba47a7a8312c76c654ef24967e]

Simon Vincent (1):
      ieee802154: 6lowpan: ensure header compression does not corrupt ipv6 header
         [f19f4f9525cf32f97341fac20ce66392e86a1b67]

Steffen Klassert (1):
      xfrm: Validate address prefix lengths in the xfrm selector.
         [07bf7908950a8b14e81aa1807e3c667eab39287a]

Steve French (4):
      SMB3: Backup intent flag missing for directory opens with backupuid mounts
         [5e19697b56a64004e2d0ff1bb952ea05493c088f]
      cifs: add missing debug entries for kconfig options
         [950132afd59385caf6e2b84e5235d069fa10681d]
      smb3: check for and properly advertise directory lease support
         [f801568332321e2b1e7a8bd26c3e4913a312a2ec]
      smb3: fill in statfs fsid and correct namelen
         [21ba3845b59c733a79ed4fe1c4f3732e7ece9df7]

Steve Wise (3):
      RDMA/cxgb4: Only call CQ completion handler if it is armed
         [678ea9b5baab6800692b249bdba77c3c07261d61]
      iw_cxgb4: atomically flush the qp
         [bc52e9ca74b9a395897bb640c6671b2cbf716032]
      iw_cxgb4: only allow 1 flush on user qps
         [308aa2b8f7b7db3332a7d41099fd37851fb793b2]

Steven Rostedt (3):
      tracing/blktrace: Fix to allow setting same value
         [757d9140072054528b13bbe291583d9823cde195]
      tracing: Do not call start/stop() functions when tracing_on does not change
         [f143641bfef9a4a60c57af30de26c63057e7e695]
      uprobes: Use synchronize_rcu() not synchronize_sched()
         [016f8ffc48cb01d1e7701649c728c5d2e737d295]

Sven Eckelmann (8):
      ath10k: prevent active scans on potential unusable channels
         [3f259111583801013cb605bb4414aa529adccf1c]
      batman-adv: Place kref_get for softif_vlan near use
         [df28ca6bb3282a4c8dc5b65f60b0136fc190ee52]
      batman-adv: Prevent duplicated gateway_node entry
         [dff9bc42ab0b2d38c5e90ddd79b238fed5b4c7ad]
      batman-adv: Prevent duplicated global TT entry
         [e7136e48ffdfb9f37b0820f619380485eb407361]
      batman-adv: Prevent duplicated nc_node entry
         [fa122fec8640eb7186ce5a41b83a4c1744ceef8f]
      batman-adv: Prevent duplicated softif_vlan entry
         [94cb82f594ed86be303398d6dfc7640a6f1d45d4]
      batman-adv: Prevent duplicated tvlv handler
         [ae3cdc97dc10c7a3b31f297dab429bfb774c9ccb]
      batman-adv: Use kref_get for batadv_nc_get_nc_node
         [0de32ceee156787429035c974316f4e5098cf722]

Sylwester Nawrocki (1):
      media: exynos4-is: Prevent NULL pointer dereference in __isp_video_try_fmt()
         [7c1b9a5aeed91bef98988ac0fcf38c8c1f4f9a3a]

Taehee Yoo (1):
      netfilter: nft_set: fix allocation size overflow in privsize callback.
         [4ef360dd6a65f6ef337645e1b65e744034754b19]

Takashi Iwai (9):
      ALSA: cs5535audio: Fix invalid endian conversion
         [69756930f2de0457d51db7d505a1e4f40e9fd116]
      ALSA: memalloc: Don't exceed over the requested size
         [dfef01e150824b0e6da750cacda8958188d29aea]
      ALSA: seq: Fix poll() error return
         [a49a71f6e25da2acc637fcd31e73debd96ca18f8]
      ALSA: virmidi: Fix too long output trigger loop
         [50e9ffb1996a5d11ff5040a266585bad4ceeca0a]
      ALSA: vx222: Fix invalid endian conversions
         [fff71a4c050ba46e305d910c837b99ba1728135e]
      ALSA: vx: Fix possible transfer overflow
         [874e1f6fad9a5184b67f4cee37c1335cd2cc5677]
      ALSA: vxpocket: Fix invalid endian conversions
         [3acd3e3bab95ec3622ff98da313290ee823a0f68]
      EDAC: i7core: Return proper error codes for kzalloc() errors
         [e97d7e38162dc305b4734a316ca758a2bbd1fa6e]
      platform/x86: ideapad-laptop: Apply no_hw_rfkill to Y20-15IKBM, too
         [58e73aa177850babb947555257fd4f79e5275cf1]

Takashi Sakamoto (1):
      ALSA: bebob: use address returned by kmalloc() instead of kernel stack for streaming DMA mapping
         [493626f2d87a74e6dbea1686499ed6e7e600484e]

Thadeu Lima de Souza Cascardo (1):
      xfrm6: call kfree_skb when skb is toobig
         [215ab0f021c9fea3c18b75e7d522400ee6a49990]

Theodore Ts'o (6):
      ext4: avoid divide by zero fault when deleting corrupted inline directories
         [4d982e25d0bdc83d8c64e66fdeca0b89240b3b85]
      ext4: check for NUL characters in extended attribute's name
         [7d95178c77014dbd8dce36ee40bbbc5e6c121ff5]
      ext4: check to make sure the rename(2)'s destination is not freed
         [b50282f3241acee880514212d88b6049fb5039c8]
      ext4: fix online resize's handling of a too-small final block group
         [f0a459dec5495a3580f8d784555e6f8f3bf7f263]
      ext4: fix online resizing for bigalloc file systems with a 1k block size
         [5f8c10936fab2b69a487400f2872902e597dd320]
      ext4: prevent online resize with backup superblock
         [011fa99404bea3f5d897c4983f6bd51170e3b18f]

Thomas Gleixner (3):
      alarmtimer: Prevent overflow for relative nanosleep
         [5f936e19cc0ef97dbe3a56e9498922ad5ba1edef]
      posix-timers: Sanitize overrun handling
         [78c9c4dfbf8c04883941445a195276bb4bb92c76]
      x86/boot: Move EISA setup to a separate file
         [f7eaf6e00fd581043bb540dfe865f1d81769b189]

Thomas Petazzoni (2):
      ARM: 8799/1: mm: fix pci_ioremap_io() offset check
         [3a58ac65e2d7969bcdf1b6acb70fa4d12a88e53e]
      PCI: mvebu: Fix I/O space end address calculation
         [dfd0309fd7b30a5baffaf47b2fccb88b46d64d69]

Thomas Werschlein (1):
      cifs: connect to servername instead of IP for IPC$ share
         [395a2076b4064f97d3fce03af15210ff2a7bb7f9]

Tim Anderson (1):
      USB: Add quirk to support DJI CineSSD
         [f45681f9becaa65111ed0a691ccf080a0cd5feb8]

Tomas Bortoli (3):
      9p: fix multiple NULL-pointer-dereferences
         [10aa14527f458e9867cf3d2cc6b8cb0f6704448b]
      net/9p/client.c: version pointer uninitialized
         [7913690dcc5e18e235769fd87c34143072f5dbea]
      net/9p/trans_fd.c: fix race-condition by flushing workqueue before the kfree()
         [430ac66eb4c5b5c4eb846b78ebf65747510b30f1]

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak
         [1bafcbf59fed92af58955024452f45430d3898c5]

Tycho Andersen (1):
      uart: fix race between uart_put_char() and uart_shutdown()
         [a5ba1d95e46ecaea638ddd7cd144107c783acb5d]

Vaibhav Nagarnaik (1):
      ring-buffer: Allow for rescheduling when removing pages
         [83f365554e47997ec68dc4eca3f5dce525cd15c3]

Varka Bhadram (1):
      mac802154: common tx error path
         [f55889128a776b51581394b20abd0b470304cf95]

Vignesh R (2):
      pwm: tiehrpwm: Don't use emulation mode bits to control PWM output
         [aa49d628f6e016bcec8c6f8e704b9b18ee697329]
      pwm: tiehrpwm: Fix disabling of output of PWMs
         [38dabd91ff0bde33352ca3cc65ef515599b77a05]

Vineet Gupta (1):
      ARC: clone syscall to setp r25 as thread pointer
         [c58a584f05e35d1d4342923cd7aac07d9c3d3d16]

Vitaly Kuznetsov (2):
      tools: hv: fcopy: set 'error' in case an unknown operation was requested
         [c2d68afba86d1ff01e7300c68bc16a9234dcd8e9]
      xen-netfront: fix queue name setting
         [2d408c0d4574b01b9ed45e02516888bf925e11a9]

Wei Wang (2):
      ipv6: take rcu lock in rawv6_send_hdrinc()
         [a688caa34beb2fd2a92f1b6d33e40cde433ba160]
      l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache
         [6d37fa49da1e8db8fb1995be22ac837ca41ac8a8]

Willy Tarreau (1):
      ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_IOCTL_INFO
         [49434c6c575d2008c0abbc93e615019f39e01252]

Yelena Krivosheev (1):
      net: mvneta: fix mtu change on port without link
         [8466baf788ec3e18836bd9c91ba0b1a07af25878]

Young_X (1):
      cdrom: fix improper type cast, which can leat to information leak.
         [e4f3aa2e1e67bb48dfbaaf1cad59013d5a5bc276]

Yu Zhao (1):
      regulator: fix crash caused by null driver data
         [fb6de923ca3358a91525552b4907d4cb38730bdd]

YueHaibing (2):
      pinctrl: berlin: fix 'pctrl->functions' allocation in berlin_pinctrl_build_state
         [b5031b7db77dc47f474f0efc2b2552c32b7bb59d]
      xfrm: fix 'passing zero to ERR_PTR()' warning
         [934ffce1343f22ed5e2d0bd6da4440f4848074de]

 Makefile                                           |   4 +-
 arch/arc/kernel/process.c                          |  20 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   1 +
 arch/arm/kvm/mmu.c                                 |  42 ++-
 arch/arm/mach-hisi/hotplug.c                       |  19 +-
 arch/arm/mm/ioremap.c                              |   2 +-
 arch/arm64/kvm/guest.c                             |  45 +++
 arch/arm64/mm/init.c                               |   6 +-
 arch/mips/include/asm/processor.h                  |  15 +-
 arch/mips/kernel/ptrace.c                          |   2 +-
 arch/mips/kernel/ptrace32.c                        |   2 +-
 arch/mips/lib/memset.S                             |   4 +-
 arch/powerpc/include/asm/fadump.h                  |   3 -
 arch/powerpc/kernel/fadump.c                       |  92 ++++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |   2 +-
 arch/powerpc/mm/numa.c                             |   4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  37 ++
 arch/powerpc/platforms/pseries/ras.c               |   4 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |   2 +-
 arch/s390/include/asm/qdio.h                       |   1 -
 arch/s390/mm/fault.c                               |   2 +
 arch/s390/pci/pci.c                                |   2 +
 arch/x86/include/asm/kdebug.h                      |  12 +-
 arch/x86/include/asm/microcode_intel.h             |  15 +
 arch/x86/include/asm/percpu.h                      |   8 +-
 arch/x86/include/asm/pgtable_64.h                  |  16 +-
 arch/x86/include/asm/processor.h                   |   4 +-
 arch/x86/kernel/Makefile                           |   1 +
 arch/x86/kernel/cpu/bugs.c                         |  46 ++-
 arch/x86/kernel/cpu/common.c                       |   1 +
 arch/x86/kernel/cpu/intel.c                        |  14 +-
 arch/x86/kernel/cpu/microcode/amd.c                |  22 +-
 arch/x86/kernel/cpu/microcode/intel.c              |  31 +-
 arch/x86/kernel/cpu/microcode/intel_early.c        |  33 +-
 arch/x86/kernel/dumpstack_32.c                     |   2 +-
 arch/x86/kernel/dumpstack_64.c                     |   2 +-
 arch/x86/kernel/paravirt.c                         |   4 +-
 arch/x86/kernel/process_32.c                       |   4 +-
 arch/x86/kernel/process_64.c                       |  11 +-
 arch/x86/kernel/traps.c                            |  13 -
 arch/x86/mm/kmemcheck/error.c                      |   2 +-
 arch/x86/mm/pgtable.c                              |   6 +-
 arch/x86/vdso/vclock_gettime.c                     |  18 +-
 arch/xtensa/include/asm/cacheasm.h                 |  69 ++--
 block/bio-integrity.c                              |  26 --
 block/partitions/aix.c                             |  13 +-
 crypto/ablkcipher.c                                |  57 ++-
 crypto/blkcipher.c                                 |  54 ++-
 crypto/cts.c                                       |   3 +-
 crypto/sha1_generic.c                              |   2 +-
 crypto/sha256_generic.c                            |   5 +-
 crypto/sha512_generic.c                            |   2 +-
 crypto/tgr192.c                                    |   4 +-
 crypto/vmac.c                                      | 412 +++++++++------------
 crypto/wp512.c                                     |   8 +-
 drivers/acpi/bus.c                                 |  13 +-
 drivers/base/power/main.c                          |   5 +-
 drivers/block/nbd.c                                |   3 +
 drivers/cdrom/cdrom.c                              |   2 +-
 drivers/char/ipmi/ipmi_bt_sm.c                     |  92 ++---
 drivers/crypto/mxs-dcp.c                           |  53 +--
 drivers/edac/edac_mc_sysfs.c                       |   6 +-
 drivers/edac/i7core_edac.c                         |  24 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  91 ++---
 drivers/gpu/drm/i915/i915_reg.h                    |   1 +
 drivers/gpu/drm/i915/intel_ddi.c                   |   4 +
 drivers/gpu/drm/i915/intel_display.c               |   8 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  20 +-
 drivers/gpu/drm/panel/panel-s6e8aa0.c              |   2 +-
 drivers/gpu/drm/udl/udl_fb.c                       |  10 +-
 drivers/gpu/drm/udl/udl_main.c                     |  35 +-
 drivers/hv/connection.c                            |   8 +-
 drivers/hwmon/nct6775.c                            |  28 +-
 drivers/i2c/busses/i2c-xiic.c                      |   4 +
 drivers/iio/frequency/ad9523.c                     |   4 +-
 drivers/infiniband/core/cma.c                      |  12 +-
 drivers/infiniband/core/ucm.c                      |   3 +
 drivers/infiniband/core/ucma.c                     |   9 +
 drivers/infiniband/hw/cxgb4/ev.c                   |   1 +
 drivers/infiniband/hw/cxgb4/qp.c                   |  62 +++-
 drivers/infiniband/hw/cxgb4/t4.h                   |  11 +
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   2 +
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |   1 +
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   6 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |   4 +-
 drivers/input/mouse/elantech.c                     |   2 +
 drivers/leds/leds-max8997.c                        |   2 +-
 drivers/md/bcache/bcache.h                         |   1 +
 drivers/md/bcache/closure.h                        |   3 -
 drivers/md/bcache/io.c                             |   1 +
 drivers/md/bcache/journal.c                        |   8 +-
 drivers/md/bcache/request.c                        |  14 +-
 drivers/md/bcache/super.c                          |  29 +-
 drivers/md/dm-cache-metadata.c                     |   3 +-
 drivers/md/dm-cache-target.c                       |   5 +-
 drivers/md/dm-crypt.c                              |   8 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c |  11 +-
 drivers/media/platform/omap3isp/isp.c              |   2 +-
 drivers/media/usb/dvb-usb-v2/gl861.c               |  17 +-
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |   2 +-
 drivers/mfd/sm501.c                                |   1 +
 drivers/misc/hmc6352.c                             |   2 +
 drivers/misc/mei/nfc.c                             |   2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |   4 +-
 drivers/mtd/mtdchar.c                              |  10 +-
 drivers/mtd/nand/mxc_nand.c                        |   4 +-
 drivers/mtd/spi-nor/fsl-quadspi.c                  |  20 +-
 drivers/net/ethernet/cadence/macb.c                |  10 +-
 drivers/net/ethernet/marvell/mvneta.c              |   1 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |   8 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  12 +-
 drivers/net/ethernet/realtek/r8169.c               |   8 +-
 drivers/net/ppp/pppoe.c                            |   3 +
 drivers/net/team/team.c                            |   5 +
 drivers/net/usb/asix_common.c                      |   3 +
 drivers/net/usb/ax88179_178a.c                     |   3 +
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/usb/smsc75xx.c                         |   3 +
 drivers/net/usb/smsc95xx.c                         |   3 +
 drivers/net/usb/sr9800.c                           |   3 +
 drivers/net/vxlan.c                                | 103 ++++--
 drivers/net/wireless/ath/ath10k/mac.c              |   7 +
 drivers/net/wireless/ath/wil6210/wmi.c             |   7 +-
 drivers/net/wireless/b43/leds.c                    |   2 +-
 drivers/net/wireless/b43legacy/leds.c              |   2 +-
 drivers/net/wireless/libertas/dev.h                |   1 +
 drivers/net/wireless/libertas/if_sdio.c            |  34 +-
 drivers/net/wireless/rndis_wlan.c                  |   2 +
 drivers/net/xen-netfront.c                         |   2 +-
 drivers/of/selftest.c                              |  28 +-
 drivers/pci/host/pci-mvebu.c                       |   2 +-
 drivers/pci/hotplug/pci_hotplug_core.c             |   9 +
 drivers/pci/hotplug/pciehp.h                       |   1 +
 drivers/pci/hotplug/pciehp_core.c                  |   5 +
 drivers/pci/hotplug/pciehp_hpc.c                   |  18 +-
 drivers/pci/pci.c                                  |  27 +-
 drivers/pinctrl/berlin/berlin.c                    |  13 +-
 drivers/pinctrl/pinctrl-imx.c                      |   2 +-
 drivers/pinctrl/pinctrl-imx1-core.c                |   2 +-
 drivers/pinctrl/pinctrl-msm.c                      |  10 +-
 drivers/platform/x86/alienware-wmi.c               |   1 +
 drivers/platform/x86/ideapad-laptop.c              |   7 +
 drivers/power/generic-adc-battery.c                |  25 +-
 drivers/ptp/ptp_chardev.c                          |   4 +
 drivers/pwm/pwm-tiehrpwm.c                         |  13 +-
 drivers/regulator/core.c                           |   3 +-
 drivers/s390/cio/qdio_main.c                       |   5 +-
 drivers/scsi/aic94xx/aic94xx_init.c                |   4 +-
 drivers/scsi/scsi_sysfs.c                          |  20 +-
 drivers/scsi/virtio_scsi.c                         |   6 +-
 drivers/spi/spi-rspi.c                             | 140 +++++--
 drivers/spi/spi-sh-msiof.c                         |  57 ++-
 drivers/spi/spi-tegra20-slink.c                    |  31 +-
 drivers/staging/rts5208/sd.c                       |   2 +-
 drivers/staging/usbip/vhci_hcd.c                   |  43 ++-
 drivers/target/iscsi/iscsi_target_login.c          |  35 +-
 drivers/target/iscsi/iscsi_target_tpg.c            |   3 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  10 +-
 drivers/tty/serial/pxa.c                           |   3 +-
 drivers/tty/serial/serial_core.c                   |  17 +-
 drivers/tty/tty_ioctl.c                            |  15 +-
 drivers/tty/vt/vt_ioctl.c                          |   4 +
 drivers/uio/uio.c                                  |   3 +-
 drivers/usb/core/devio.c                           |  24 +-
 drivers/usb/core/driver.c                          |  50 +--
 drivers/usb/core/hcd-pci.c                         |   2 -
 drivers/usb/core/message.c                         |  11 +
 drivers/usb/core/quirks.c                          |   7 +
 drivers/usb/core/usb.c                             |   2 +
 drivers/usb/gadget/f_mass_storage.c                |   3 +
 drivers/usb/gadget/net2280.c                       |  36 +-
 drivers/usb/host/u132-hcd.c                        |   2 +-
 drivers/usb/host/xhci-pci.c                        |   2 +
 drivers/usb/misc/uss720.c                          |   4 +-
 drivers/usb/misc/yurex.c                           |   5 +-
 drivers/usb/serial/io_ti.h                         |   2 +-
 drivers/usb/serial/kobil_sct.c                     |  12 +-
 drivers/usb/serial/sierra.c                        |   4 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |  13 +-
 drivers/usb/serial/ti_usb_3410_5052.h              |   2 -
 drivers/usb/serial/usb-serial-simple.c             |   3 +-
 drivers/usb/storage/scsiglue.c                     |   9 +
 drivers/usb/storage/uas.c                          |  20 +
 drivers/usb/storage/unusual_devs.h                 |   7 +
 drivers/video/fbdev/aty/atyfb.h                    |   3 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   7 +-
 drivers/video/fbdev/aty/mach64_ct.c                |  10 +-
 drivers/video/fbdev/core/fbmem.c                   |  38 +-
 drivers/video/fbdev/omap/omapfb_main.c             |   2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |   5 +-
 drivers/video/fbdev/udlfb.c                        | 140 ++++---
 fs/9p/xattr.c                                      |   6 +-
 fs/binfmt_elf.c                                    |   2 +-
 fs/btrfs/disk-io.c                                 |  10 +-
 fs/btrfs/inode.c                                   |  25 --
 fs/btrfs/super.c                                   |   1 -
 fs/btrfs/volumes.c                                 |  10 +-
 fs/cachefiles/namei.c                              |   2 +-
 fs/cifs/cifs_debug.c                               |  30 +-
 fs/cifs/cifsfs.c                                   |  20 +-
 fs/cifs/connect.c                                  |   9 +-
 fs/cifs/inode.c                                    |   2 +
 fs/cifs/readdir.c                                  |  11 +-
 fs/cifs/sess.c                                     |   6 +
 fs/cifs/smb2ops.c                                  |  23 +-
 fs/cifs/smb2pdu.c                                  |  40 +-
 fs/cifs/smb2pdu.h                                  |  11 +
 fs/ext4/dir.c                                      |  20 +-
 fs/ext4/inline.c                                   |   4 +-
 fs/ext4/mballoc.c                                  |   4 +-
 fs/ext4/mmp.c                                      |   1 -
 fs/ext4/namei.c                                    |   6 +
 fs/ext4/resize.c                                   |  45 ++-
 fs/ext4/xattr.c                                    |   2 +
 fs/fuse/cuse.c                                     |   2 +-
 fs/fuse/dev.c                                      |   7 +-
 fs/fuse/file.c                                     |   1 +
 fs/fuse/fuse_i.h                                   |   2 -
 fs/fuse/inode.c                                    |  37 +-
 fs/ocfs2/buffer_head_io.c                          |   1 +
 fs/ocfs2/dlm/dlmmaster.c                           |   4 +-
 fs/proc/base.c                                     |  14 +
 fs/pstore/ram.c                                    |  29 +-
 fs/pstore/ram_core.c                               |  17 +-
 fs/quota/quota.c                                   |   5 +-
 fs/reiserfs/xattr.c                                |   6 +-
 fs/seq_file.c                                      |   7 +-
 fs/sysfs/file.c                                    |  44 +++
 fs/ubifs/journal.c                                 |  16 +-
 fs/ubifs/lprops.c                                  |   8 +-
 fs/ubifs/super.c                                   |   3 +
 fs/xattr.c                                         |   2 +-
 fs/xfs/xfs_attr.c                                  |   9 +-
 include/crypto/vmac.h                              |  63 ----
 include/linux/blkdev.h                             |  38 ++
 include/linux/cpuidle.h                            |   3 +
 include/linux/netdevice.h                          |   7 +
 include/linux/percpu_counter.h                     |  13 +-
 include/linux/posix-timers.h                       |   4 +-
 include/linux/seq_file.h                           |  13 +-
 include/linux/skbuff.h                             |   5 +
 include/linux/sysfs.h                              |  14 +
 include/linux/usb.h                                |   2 +-
 include/net/ip_fib.h                               |   1 +
 include/net/netfilter/nf_tables.h                  |   4 +-
 include/video/udlfb.h                              |   5 +-
 kernel/auditsc.c                                   |   8 +-
 kernel/events/core.c                               |  15 +-
 kernel/kprobes.c                                   |   4 +-
 kernel/posix-cpu-timers.c                          |   2 +-
 kernel/posix-timers.c                              |  31 +-
 kernel/sched/idle.c                                |   2 +-
 kernel/time/alarmtimer.c                           |   3 +-
 kernel/trace/blktrace.c                            |   4 +
 kernel/trace/ring_buffer.c                         |   2 +
 kernel/trace/trace.c                               |   4 +-
 kernel/trace/trace_uprobe.c                        |   2 +-
 lib/percpu_counter.c                               |   6 +-
 mm/huge_memory.c                                   |   6 +-
 mm/madvise.c                                       |   2 +-
 mm/memory.c                                        |  15 +-
 mm/mremap.c                                        |  21 +-
 mm/shmem.c                                         |   2 +
 mm/truncate.c                                      |   8 +-
 mm/vmstat.c                                        |   3 +
 net/9p/client.c                                    |   2 +-
 net/9p/trans_fd.c                                  |   7 +-
 net/9p/trans_rdma.c                                |   3 +
 net/9p/trans_virtio.c                              |  13 +-
 net/batman-adv/gateway_client.c                    |  11 +-
 net/batman-adv/main.c                              |   8 +-
 net/batman-adv/network-coding.c                    |  34 +-
 net/batman-adv/soft-interface.c                    |  27 +-
 net/batman-adv/translation-table.c                 |   6 +-
 net/core/dev.c                                     |  28 +-
 net/core/rtnetlink.c                               |   6 +
 net/core/skbuff.c                                  |  12 +-
 net/ieee802154/6lowpan_rtnl.c                      | 140 +++++--
 net/ipv4/fib_frontend.c                            |   4 +
 net/ipv4/fib_semantics.c                           |  50 +++
 net/ipv4/igmp.c                                    |   8 +-
 net/ipv4/ip_tunnel.c                               |   9 +
 net/ipv6/addrconf.c                                |   6 +-
 net/ipv6/af_inet6.c                                |   4 +-
 net/ipv6/ip6_output.c                              |   3 +-
 net/ipv6/ip6_tunnel.c                              |  13 +-
 net/ipv6/raw.c                                     |  34 +-
 net/ipv6/xfrm6_output.c                            |   2 +
 net/l2tp/l2tp_core.c                               |   2 +-
 net/mac80211/cfg.c                                 |   2 +-
 net/mac802154/tx.c                                 |  35 +-
 net/netfilter/nf_tables_api.c                      |  10 +-
 net/netfilter/nft_hash.c                           |   2 +-
 net/netfilter/nft_rbtree.c                         |   2 +-
 net/sched/act_ipt.c                                |   2 +-
 net/wireless/nl80211.c                             |   1 +
 net/wireless/reg.c                                 |   1 +
 net/xfrm/xfrm_policy.c                             |   5 +-
 net/xfrm/xfrm_user.c                               |  12 +
 security/apparmor/policy_unpack.c                  |  32 --
 security/keys/encrypted-keys/encrypted.c           |  31 +-
 sound/aoa/core/gpio-feature.c                      |   4 +-
 sound/core/memalloc.c                              |   8 +-
 sound/core/seq/oss/seq_oss.c                       |   2 +-
 sound/core/seq/seq_clientmgr.c                     |   2 +-
 sound/core/seq/seq_virmidi.c                       |  10 +
 sound/drivers/vx/vx_pcm.c                          |   6 +-
 sound/firewire/bebob/bebob_maudio.c                |  24 +-
 sound/pci/cs5535audio/cs5535audio.h                |   6 +-
 sound/pci/cs5535audio/cs5535audio_pcm.c            |   4 +-
 sound/pci/emu10k1/emufx.c                          |   2 +-
 sound/pci/vx222/vx222_ops.c                        |  20 +-
 sound/pcmcia/vx/vxp_ops.c                          |  22 +-
 sound/soc/codecs/wm8994.c                          |   1 +
 tools/hv/hv_fcopy_daemon.c                         |   1 +
 tools/hv/hv_kvp_daemon.c                           |   2 +-
 319 files changed, 2983 insertions(+), 1647 deletions(-)

-- 
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                       - Robert Coveyou

