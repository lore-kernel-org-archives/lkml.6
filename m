Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839952-2-774282725942248780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839950; b=M7QXKoBGA6qrOeQwKxjDD2+Qx6gkKT+/STnB/2az99dv0Jn
    9HbkKL0g7IJ/3qI93xPX/gozfEGGO4GWCo8EBrtZLqIECE71Muyq45SZVv2D23i3
    ukKneO+TYIVxq71mBI/qi8ALGjQqpa4XIHwb9/jCtV28z+G9PbtbSHEL8MhXBis+
    5322kfMKRaUUql8py6wRtSru1B768gTFtWvg+qu8BYlE6pqPEhda5UNjM1bdWuak
    lpLYdyRKz3cpqKUOh8Ozv0/hLygZ+16WycgUC8DY0tcB0S5hpEnh4DxfBEdODo6u
    /y38VWOXgBHKG56GKAJUadjWDqwQSdEbxOmEpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:sender:list-id;
    s=arctest; t=1519839950; bh=sqp0HkDHX1tutcfCn0U36eKR471BjFynDat
    RTvbYxLM=; b=OgBkXhw46RvkPEyXDiUhf9gSj5xrf4xwT80Ff4cPubVeYJ9qH+U
    ZbiDbitKS78n/FXaVIyjq+MhpxfG9jF2xpxKJMTKLGRFifxLnM/8C6UXR5jvPiHv
    OQfe47Eg59GpjhvbZRiY30Q7DRW0QvRzqYJqglJwehwn50lrMqgbH3MkvqoEDfxf
    gqydIIWgKFy/z/KjZVSSK45G1vKrf+H3gjq6HVAqsXL+6hprUGUlUHmfpTlDdXSj
    jkTBwA2gf2pz8b9uoH95Ot6oriGLcx/wC6uwpbNB297tbE57KeLMW7TDGpMv90G1
    EqQp50JG9VyJUwucaDs3HCQY4EwQqXjWfaQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934301AbeB1Rpq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:45:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33077 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932428AbeB1PWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.703311959@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 000/140] 3.2.100-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.2.100 release.
There are 140 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar 02 18:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.2.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Aaron Ma (2):
      Input: elantech - add new icbody type 15
         [10d900303f1c3a821eb0bef4e7b7ece16768fba4]
      Input: trackpoint - force 3 buttons if 0 button is reported
         [f5d07b9e98022d50720e38aa936fc11c67868ece]

Alexey Kodanev (1):
      dccp: don't restart ccid2_hc_tx_rto_expire() if sk in closed state
         [dd5684ecae3bd8e44b644f50e2c12c7e57fdfef5]

Andrew Honig (1):
      KVM: x86: Add memory barrier on vmcs field lookup
         [75f139aaf896d6fdeec2e468ddfa4b2fe469bf40]

Andrzej Hajda (1):
      [media] v4l2-compat-ioctl32: fix alignment for ARM64
         [655e9780ab913a3a06d4a164d55e3b755524186d]

Anshuman Khandual (1):
      mm/mprotect: add a cond_resched() inside change_pmd_range()
         [4991c09c7c812dba13ea9be79a68b4565bb1fa4e]

Arnd Bergmann (1):
      mmc: s3mci: mark debug_regs[] as static
         [2bd7b4aacdb6efa5ccd4749c365c171b884791d2]

Bart Westgeest (1):
      staging: usbip: removed dead code from receive function
         [5a08c5267e45fe936452051a8c126e8418984eb7]

Ben Hutchings (2):
      nfsd: auth: Fix gid sorting when rootsquash enabled
         [1995266727fa8143897e89b55f5d3c79aa828420]
      of: fdt: Fix return with value in void function
         [not upstream; fixes incorrect backport]

Benjamin Poirier (2):
      e1000e: Fix e1000_check_for_copper_link_ich8lan return value.
         [4110e02eb45ea447ec6f5459c9934de0a273fb91]
      e1000e: Separate signaling for link check/link up
         [19110cfbb34d4af0cdfe14cd243f3b09dc95b013]

Chandan Rajendra (1):
      ext4: fix crash when a directory's i_size is too small
         [9d5afec6b8bd46d6ed821aa1579634437f58ef1f]

Christian Holl (1):
      USB: serial: cp210x: add new device ID ELV ALC 8xxx
         [d14ac576d10f865970bb1324d337e5e24d79aaf4]

Christoph Hellwig (1):
      scsi: dma-mapping: always provide dma_get_cache_alignment
         [860dd4424f344400b491b212ee4acb3a358ba9d9]

Christoph Paasch (1):
      tcp md5sig: Use skb's saddr when replying to an incoming segment
         [30791ac41927ebd3e75486f9504b6d2280463bf0]

Christophe Leroy (1):
      net: fs_enet: do not call phy_stop() in interrupts
         [f8b39039cbf2a15f2b8c9f081e1cbd5dee00aaf5]

Colin Ian King (1):
      usb: host: fix incorrect updating of offset
         [1d5a31582ef046d3b233f0da1a68ae26519b2f0a]

Cong Wang (1):
      8021q: fix a memory leak for VLAN 0 device
         [78bbb15f2239bc8e663aa20bbe1987c91a0b75f6]

Dan Williams (1):
      [SCSI] libsas: remove unused ata_task_resp fields
         [95ac7fd189b7e81a200b4d00b2bb6669b31acf3a]

Daniel Mentz (2):
      media: v4l2-compat-ioctl32.c: refactor  compat ioctl32 logic
         [a1dfb4c48cc1e64eeb7800a27c66a6f7e88d075a]
      media: v4l2-compat-ioctl32: Copy  v4l2_window->global_alpha
         [025a26fa14f8fd55d50ab284a30c016a5be953d0]

Daniel Thompson (1):
      kdb: Fix handling of kallsyms_symbol_next() return value
         [c07d35338081d107e57cf37572d8cc931a8e32e2]

David Howells (1):
      fscache: Fix the default for fscache_maybe_release_page()
         [98801506552593c9b8ac11021b0cdad12cab4f6b]

David Kozub (1):
      USB: uas and storage: Add US_FL_BROKEN_FUA for another JMicron JMS567 ID
         [62354454625741f0569c2cbe45b2d192f8fd258e]

Dennis Yang (1):
      dm thin metadata: THIN_MAX_CONCURRENT_LOCKS should be 6
         [490ae017f54e55bde382d45ea24bddfb6d1a0aaf]

Denys Vlasenko (1):
      include/stddef.h: Move offsetofend() from vfio.h to a generic kernel header
         [3876488444e71238e287459c39d7692b6f718c3e]

Diego Elio Pettenò (1):
      USB: serial: cp210x: add IDs for LifeScan OneTouch Verio IQ
         [4307413256ac1e09b8f53e8715af3df9e49beec3]

Dmitry Fleytman Dmitry Fleytman (1):
      usb: Add device quirk for Logitech HD Pro Webcam C925e
         [7f038d256c723dd390d2fca942919573995f4cfd]

Eric Biggers (3):
      af_key: fix buffer overread in parse_exthdrs()
         [4e765b4972af7b07adcb1feb16e7a525ce1f6b28]
      af_key: fix buffer overread in verify_address_len()
         [06b335cb51af018d5feeff5dd4fd53847ddb675a]
      crypto: algapi - fix NULL dereference in crypto_remove_spawns()
         [9a00674213a3f00394f4e3221b88f2d21fc05789]

Eric Dumazet (1):
      net/packet: fix a race in packet_bind() and packet_notifier()
         [15fe076edea787807a7cdc168df832544b58eba6]

Felix Fietkau (1):
      net: igmp: fix source address check for IGMPv3 reports
         [ad23b750933ea7bf962678972a286c78a8fa36aa]

Geert Uytterhoeven (1):
      m32r: fix 'fix breakage from "m32r: use generic ptrace_resume code"' fallout
         [a6b202979661eb32646048aeaad7be7b70c2cd22]

Gleb Natapov (2):
      KVM: VMX: do not try to reexecute failed instruction while emulating invalid guest state
         [991eebf9f8e523e7ff1e4d31ac80641582b2e57a]
      KVM: apic: fix LDR calculation in x2apic mode
         [7f46ddbd487e0d0528d89534fdfb31d885977804]

Greg Kroah-Hartman (1):
      ACPI: sbshc: remove raw pointer from printk() message
         [43cdd1b716b26f6af16da4e145b6578f98798bf6]

Guennadi Liakhovetski (1):
      [media] V4L2: fix VIDIOC_CREATE_BUFS 32-bit compatibility mode data copy-back
         [6ed9b28504326f8cf542e6b68245b2f7ce009216]

Guillaume Nault (1):
      pppoe: take ->needed_headroom of lower device into account on xmit
         [02612bb05e51df8489db5e94d0cf8d1c81f87b0c]

Hans Verkuil (12):
      [media] v4l2-compat-ioctl32: fix sparse warnings
         [8ae632b11775254c5e555ee8c42b7d19baeb1473]
      media: v4l2-compat-ioctl32.c: add capabilities field to, v4l2_input32
         [037e0865c2ecbaa4558feba239ece08d7e457ec0]
      media: v4l2-compat-ioctl32.c: add missing  VIDIOC_PREPARE_BUF
         [3ee6d040719ae09110e5cdf24d5386abe5d1b776]
      media: v4l2-compat-ioctl32.c: avoid  sizeof(type)
         [333b1e9f96ce05f7498b581509bb30cde03018bf]
      media: v4l2-compat-ioctl32.c: copy  m.userptr in put_v4l2_plane32
         [8ed5a59dcb47a6f76034ee760b36e089f3e82529]
      media: v4l2-compat-ioctl32.c: copy clip  list in put_v4l2_window32
         [a751be5b142ef6bcbbb96d9899516f4d9c8d0ef4]
      media: v4l2-compat-ioctl32.c: don't copy  back the result for certain errors
         [d83a8243aaefe62ace433e4384a4f077bed86acb]
      media: v4l2-compat-ioctl32.c: drop pr_info  for unknown buffer type
         [169f24ca68bf0f247d111aef07af00dd3a02ae88]
      media: v4l2-compat-ioctl32.c: fix  ctrl_is_pointer
         [b8c601e8af2d08f733d74defa8465303391bb930]
      media: v4l2-compat-ioctl32.c: fix the  indentation
         [b7b957d429f601d6d1942122b339474f31191d75]
      media: v4l2-compat-ioctl32.c: move 'helper'  functions to __get/put_v4l2_format32
         [486c521510c44a04cd756a9267e7d1e271c8a4ba]
      media: v4l2-ioctl.c: don't copy back the  result for -ENOTTY
         [181a4a2d5a0a7b43cab08a70710d727e7764ccdd]

Heiko Carstens (1):
      s390: always save and restore all registers on context switch
         [fbbd7f1a51965b50dd12924841da0d478f3da71b]

Heiner Kallweit (1):
      eeprom: at24: check at24_read/write arguments
         [d9bcd462daf34aebb8de9ad7f76de0198bb5a0f0]

Helge Deller (1):
      parisc: Hide Diva-built-in serial aux and graphics card
         [bcf3f1752a622f1372d3252d0fea8855d89812e7]

Herbert Xu (5):
      ipv4: Avoid reading user iov twice after raw_probe_proto_opt
         [c008ba5bdc9fa830e1a349b20b0be5a137bdef7a]
      ipv4: Use standard iovec primitive in raw_probe_proto_opt
         [32b5913a931fd753faf3d4e1124b2bc2edb364da]
      xfrm: Reinject transport-mode packets through tasklet
         [acf568ee859f098279eadf551612f103afdacb4e]
      xfrm: Return error on unknown encap_type in init_state
         [bcfd09f7837f5240c30fd2f52ee7293516641faa]
      xfrm: Use __skb_queue_tail in xfrm_trans_queue
         [d16b46e4fd8bc6063624605f25b8c0835bb1fbe3]

Huacai Chen (2):
      scsi: libsas: align sata_device's rps_resp on a cacheline
         [c2e8fbf908afd81ad502b567a6639598f92c9b9d]
      scsi: use dma_get_cache_alignment() as minimum DMA alignment
         [90addc6b3c9cda0146fbd62a08e234c2b224a80c]

Håkon Bugge (1):
      rds: Fix NULL pointer dereference in __rds_rdma_map
         [f3069c6d33f6ae63a1668737bc78aaaa51bff7ca]

Jaejoong Kim (2):
      ALSA: usb-audio: Add check return value for usb_string()
         [89b89d121ffcf8d9546633b98ded9d18b8f75891]
      ALSA: usb-audio: Fix out-of-bound error
         [251552a2b0d454badc8f486e6d79100970c744b0]

Jan Engelhardt (1):
      crypto: n2 - cure use after free
         [203f45003a3d03eea8fa28d74cfc74c354416fdb]

Jeremy Compostella (1):
      i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA
         [89c6efa61f5709327ecfa24bff18e57a4e80c7fa]

Joe Thornber (2):
      dm btree: fix serious bug in btree_split_beneath()
         [bc68d0a43560e950850fc69b58f0f8254b28f6d6]
      dm thin metadata: introduce THIN_MAX_CONCURRENT_LOCKS
         [8c971178a788c70e8d6db5c3a813de1a1f54e5b7]

Johannes Berg (2):
      cfg80211: check dev_set_name() return value
         [59b179b48ce2a6076448a44531242ac2b3f6cef2]
      cfg80211: fix station info handling bugs
         [5762d7d3eda25c03cc2d9d45227be3f5ab6bec9e]

Johannes Thumshirn (1):
      dm mpath: simplify failure path of dm_multipath_init()
         [ff658e9c1aae9a84dd06d46f847dc0cd2bf0dd11]

Josef Bacik (1):
      btrfs: clear space cache inode generation always
         [8e138e0d92c6c9d3d481674fb14e3439b495be37]

Juan Zea (1):
      usbip: fix usbip bind writing random string after command in match_busid
         [544c4605acc5ae4afe7dd5914147947db182f2fb]

Kevin Cernekee (1):
      net: igmp: Use correct source address on IGMPv3 reports
         [a46182b00290839fa3fa159d54fd3237bd8669f0]

Lan Tianyu (1):
      KVM/x86: Check input paging mode when cs.l is set
         [f29810335965ac1f7bcb501ee2af5f039f792416]

Laurent Caumont (1):
      media: dvb: i2c transfers over usb cannot be done from stack
         [6d33377f2abbf9f0e561b116dd468d1c3ff36a6a]

Li Jinyue (1):
      futex: Prevent overflow by strengthen input validation
         [fbe0e839d1e22d88810f3ee3e2f1479be4c0aa4a]

Linus Torvalds (2):
      kbuild: add '-fno-stack-check' to kernel build options
         [3ce120b16cc548472f80cf8644f90eda958cf1b6]
      n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD)
         [966031f340185eddd05affcf72b740549f056348]

Liran Alon (1):
      KVM: x86: Don't re-execute instruction when not passing CR2 value
         [9b8ae63798cb97e785a667ff27e43fa6220cb734]

Marc Kleine-Budde (1):
      can: af_can: can_rcv(): replace WARN_ONCE by pr_warn_once
         [8cb68751c115d176ec851ca56ecfbb411568c9e8]

Martin Kelly (2):
      can: ems_usb: cancel urb on -EPIPE and -EPROTO
         [bd352e1adfe0d02d3ea7c8e3fb19183dc317e679]
      can: esd_usb2: cancel urb on -EPIPE and -EPROTO
         [7a31ced3de06e9878e4f9c3abe8f87d9344d8144]

Masakazu Mokuno (1):
      USB: core: Add type-specific length check of BOS descriptors
         [81cf4a45360f70528f1f64ba018d61cb5767249a]

Mathias Nyman (2):
      xhci: Don't add a virt_dev to the devs array before it's fully allocated
         [5d9b70f7d52eb14bb37861c663bae44de9521c35]
      xhci: Don't show incorrect WARN message about events for empty rings
         [e4ec40ec4b260efcca15089de4285a0a3411259b]

Matt Wilson (1):
      serial: 8250_pci: Add Amazon PCI serial device ID
         [3bfd1300abfe3adb18e84a89d97a0e82a22124bb]

Max Schulze (1):
      USB: serial: ftdi_sio: add id for Airbus DS P8GR
         [c6a36ad383559a60a249aa6016cebf3cb8b6c485]

Mohamed Ghannam (1):
      net: ipv4: fix for a race condition in raw_sendmsg
         [8f659a03a0ba9289b9aeb9b4470e6fb263d6f483]

Monty_pavel@Sina.Com (1):
      dm: fix various targets to dm_register_target after module __init resources created
         [7e6358d244e4706fe612a77b9c36519a33600ac0]

Nicolai Stange (1):
      net: ipv4: emulate READ_ONCE() on ->hdrincl bit-field in raw_sendmsg()
         [20b50d79974ea3192e8c3ab7faf4e536e5f14d8f]

Nikolay Aleksandrov (1):
      net: bridge: fix early call to br_stp_change_bridge_id and plug newlink leaks
         [84aeb437ab98a2bce3d4b2111c79723aedfceb33]

Nikolay Borisov (1):
      btrfs: Fix possible off-by-one in btrfs_search_path_in_tree
         [c8bcbfbd239ed60a6562964b58034ac8a25f4c31]

Nogah Frankel (1):
      net_sched: red: Avoid illegal values
         [8afa10cbe281b10371fee5a87ab266e48d71a7f9]

Oliver Neukum (2):
      USB: usbfs: Filter flags passed in from user space
         [446f666da9f019ce2ffd03800995487e79a91462]
      usb: add RESET_RESUME for ELSA MicroLink 56K
         [b9096d9f15c142574ebebe8fbb137012bb9d99c2]

Oliver Stäbler (1):
      can: ti_hecc: Fix napi poll return value for repoll
         [f6c23b174c3c96616514827407769cbcfc8005cf]

Oscar Campos (1):
      Input: trackpoint - assume 3 buttons when buttons detection fails
         [293b915fd9bebf33cdc906516fb28d54649a25ac]

Pete Zaitcev (1):
      USB: fix usbmon BUG trigger
         [46eb14a6e1585d99c1b9f58d0e7389082a5f466b]

Rafael J. Wysocki (1):
      PCI / PM: Force devices to D0 in pci_pm_thaw_noirq()
         [5839ee7389e893a31e4e3c9cf17b50d14103c902]

Robb Glasser (1):
      ALSA: pcm: prevent UAF in snd_pcm_info
         [362bca57f5d78220f8b5907b875961af9436e229]

Robert Lippert (1):
      hwmon: (pmbus) Use 64bit math for DIRECT format values
         [bd467e4eababe4c04272c1e646f066db02734c79]

Robin Murphy (1):
      iommu/vt-d: Fix scatterlist offset handling
         [29a90b70893817e2f2bb3cea40a29f5308e21b21]

SZ Lin (1):
      USB: serial: option: adding support for YUGA CLM920-NC5
         [3920bb713038810f25770e7545b79f204685c8f2]

Sebastian Sjoholm (1):
      USB: serial: option: add Quectel BG96 id
         [c654b21ede93845863597de9ad774fd30db5f2ab]

Sergei Shtylyov (2):
      SolutionEngine771x: add Ether TSU resource
         [f9a531d6731d74f1e24298d9641c2dc1fef2631b]
      SolutionEngine771x: fix Ether platform data
         [195e2addbce09e5afbc766efc1e6567c9ce840d3]

Shuah Khan (4):
      usbip: prevent leaking socket pointer address in messages
         [90120d15f4c397272aaf41077960a157fc4212bf]
      usbip: remove kernel addresses from usb device and urb debug msgs
         [e1346fd87c71a1f61de1fe476ec8df1425ac931c]
      usbip: stub: stop printing kernel pointer addresses in messages
         [248a22044366f588d46754c54dfe29ffe4f8b4df]
      usbip: vhci: stop printing kernel pointer addresses in messages
         [8272d099d05f7ab2776cf56a2ab9f9443be18907]

Steve Wise (1):
      iw_cxgb4: Only validate the MSN for successful completions
         [f55688c45442bc863f40ad678c638785b26cdce6]

Steven Rostedt (1):
      ring-buffer: Mask out the info bits when returning buffer page length
         [45d8b80c2ac5d21cd1e2954431fb676bc2b1e099]

Sven Eckelmann (1):
      batman-adv: Fix lock for ogm cnt access in batadv_iv_ogm_calc_tq
         [5ba7dcfe77037b67016263ea597a8b431692ecab]

Takashi Iwai (13):
      ACPI: APEI / ERST: Fix missing error handling in erst_reader()
         [bb82e0b4a7e96494f0c1004ce50cec3d7b5fb3d1]
      ALSA: aloop: Fix inconsistent format due to incomplete rule
         [b088b53e20c7d09b5ab84c5688e609f478e5c417]
      ALSA: aloop: Fix racy hw constraints adjustment
         [898dfe4687f460ba337a01c11549f87269a13fa2]
      ALSA: aloop: Release cable upon open error path
         [9685347aa0a5c2869058ca6ab79fd8e93084a67f]
      ALSA: pcm: Abort properly at pending signal in OSS read/write loops
         [29159a4ed7044c52e3e2cf1a9fb55cec4745c60b]
      ALSA: pcm: Add missing error checks in OSS emulation plugin builder
         [6708913750344a900f2e73bfe4a4d6dbbce4fe8d]
      ALSA: pcm: Allow aborting mutex lock at OSS read/write loops
         [900498a34a3ac9c611e9b425094c8106bdd7dc1c]
      ALSA: pcm: Remove incorrect snd_BUG_ON() usages
         [fe08f34d066f4404934a509b6806db1a4f700c86]
      ALSA: pcm: Remove yet superfluous WARN_ON()
         [23b19b7b50fe1867da8d431eea9cd3e4b6328c2c]
      ALSA: rawmidi: Avoid racy info ioctl via ctl device
         [c1cfd9025cc394fd137a01159d74335c5ac978ce]
      ALSA: seq: Fix regression by incorrect ioctl_mutex usages
         [not upstream; fixes incorrect backport]
      ALSA: seq: Remove spurious WARN_ON() at timer check
         [43a3542870328601be02fcc9d27b09db467336ef]
      ALSA: usb-audio: Fix the missing ctl name suffix at parsing SU
         [5a15f289ee87eaf33f13f08a4909ec99d837ec5f]

Thiago Rafael Becker (1):
      kernel: make groups_sort calling a responsibility group_info allocators
         [bdcf0a423ea1c40bbb40e7ee483b50fc8aa3d758]

Thomas Gleixner (3):
      hrtimer: Reset hrtimer cpu base proper on CPU hotplug
         [d5421ea43d30701e03cadc56a38854c36a8b4433]
      posix-timer: Properly check sigevent->sigev_notify
         [cef31d9af908243421258f1df35a4a644604efbe]
      x86/mce: Make machine check speculation protected
         [6f41c34d69eb005e7848716bbcafc979b35037d5]

Tianyu Lan (1):
      KVM/x86: Fix wrong macro references of X86_CR0_PG_BIT and X86_CR4_PAE_BIT in kvm_valid_sregs()
         [37b95951c58fdf08dc10afa9d02066ed9f176fb5]

Tiffany Lin (1):
      [media] media: v4l2-compat-ioctl32: fix missing reserved field copy in put_v4l2_create32
         [baf43c6eace43868e490f18560287fa3481b2159]

Wanpeng Li (1):
      KVM: X86: Fix load RFLAGS w/o the fixed bit
         [d73235d17ba63b53dc0e1051dbc10a1f1be91b71]

William Breathitt Gray (1):
      isa: Prevent NULL dereference in isa_bus driver callbacks
         [5a244727f428a06634f22bb890e78024ab0c89f3]

Xin Long (3):
      sctp: do not allow the v4 socket to bind a v4mapped v6 address
         [c5006b8aa74599ce19104b31d322d2ea9ff887cc]
      sctp: return error if the asoc has been peeled off in sctp_wait_for_sndbuf
         [a0ff660058b88d12625a783ce9e5c1371c87951f]
      sctp: use the right sk after waking up from wait_buf sleep
         [cea0cc80a6777beb6eb643d4ad53690e1ad1d4ff]

Zhao Qiang (1):
      net: phy: marvell: Limit 88m1101 autoneg errata to 88E1145 as well.
         [c505873eaece2b4aefd07d339dc7e1400e0235ac]

 Makefile                                           |   7 +-
 arch/m32r/kernel/ptrace.c                          |   7 +-
 arch/s390/include/asm/system.h                     |  18 +-
 arch/s390/kernel/compat_linux.c                    |   1 +
 arch/sh/boards/mach-se/770x/setup.c                |  24 +-
 arch/sh/include/mach-se/mach/se.h                  |   1 +
 arch/x86/include/asm/kvm_host.h                    |   4 +-
 arch/x86/include/asm/traps.h                       |   1 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |   5 +
 arch/x86/kernel/entry_64.S                         |   2 +-
 arch/x86/kvm/lapic.c                               |   2 +-
 arch/x86/kvm/vmx.c                                 |  12 +-
 arch/x86/kvm/x86.c                                 |  38 +-
 crypto/algapi.c                                    |  12 +
 drivers/acpi/apei/erst.c                           |   2 +-
 drivers/acpi/sbshc.c                               |   4 +-
 drivers/base/isa.c                                 |  10 +-
 drivers/crypto/n2_core.c                           |   3 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  21 +-
 drivers/i2c/i2c-core.c                             |  13 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   6 +-
 drivers/input/mouse/elantech.c                     |   2 +-
 drivers/input/mouse/trackpoint.c                   |   7 +-
 drivers/iommu/intel-iommu.c                        |   8 +-
 drivers/md/dm-mpath.c                              |  34 +-
 drivers/md/dm-snap.c                               |  48 +-
 drivers/md/dm-thin-metadata.c                      |  18 +-
 drivers/md/persistent-data/dm-btree.c              |  19 +-
 drivers/media/dvb/dvb-usb/dibusb-common.c          |  16 +-
 drivers/media/video/Makefile                       |   7 +-
 drivers/media/video/v4l2-compat-ioctl32.c          | 973 +++++++++++++--------
 drivers/media/video/v4l2-ioctl.c                   |   6 +-
 drivers/misc/eeprom/at24.c                         |   6 +
 drivers/mmc/host/s3cmci.c                          |   6 +-
 drivers/net/can/ti_hecc.c                          |   3 +
 drivers/net/can/usb/ems_usb.c                      |   2 +
 drivers/net/can/usb/esd_usb2.c                     |   2 +
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |  16 +-
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |   1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  10 +-
 drivers/net/ethernet/intel/e1000e/lib.c            |  11 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   2 +-
 drivers/net/phy/marvell.c                          |   2 +-
 drivers/net/ppp/pppoe.c                            |  11 +-
 drivers/of/fdt.c                                   |   2 +-
 drivers/parisc/lba_pci.c                           |  33 +
 drivers/pci/pci-driver.c                           |   7 +-
 drivers/scsi/libsas/sas_ata.c                      |   4 -
 drivers/scsi/scsi_lib.c                            |  10 +-
 drivers/staging/usbip/stub_dev.c                   |   3 +-
 drivers/staging/usbip/stub_main.c                  |   5 +-
 drivers/staging/usbip/stub_rx.c                    |   9 +-
 drivers/staging/usbip/stub_tx.c                    |   4 +-
 drivers/staging/usbip/usbip_common.c               |  85 +-
 drivers/staging/usbip/usbip_common.h               |   3 +-
 drivers/staging/usbip/userspace/src/utils.c        |   9 +-
 drivers/staging/usbip/vhci_hcd.c                   |  12 +-
 drivers/staging/usbip/vhci_rx.c                    |  26 +-
 drivers/staging/usbip/vhci_tx.c                    |   3 +-
 drivers/tty/n_tty.c                                |   4 +-
 drivers/tty/serial/8250_pci.c                      |   3 +
 drivers/usb/core/config.c                          |  16 +-
 drivers/usb/core/devio.c                           |  14 +-
 drivers/usb/core/quirks.c                          |   6 +-
 drivers/usb/host/ehci-dbg.c                        |   2 +-
 drivers/usb/host/xhci-mem.c                        |  17 +-
 drivers/usb/host/xhci-ring.c                       |  12 +-
 drivers/usb/mon/mon_bin.c                          |   8 +-
 drivers/usb/serial/cp210x.c                        |   2 +
 drivers/usb/serial/ftdi_sio.c                      |   1 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |  12 +
 drivers/usb/storage/unusual_devs.h                 |   7 +
 fs/btrfs/extent-tree.c                             |  14 +-
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/ext4/namei.c                                    |   4 +
 fs/nfsd/auth.c                                     |   3 +
 include/asm-generic/dma-mapping-broken.h           |   3 -
 include/linux/cred.h                               |   1 +
 include/linux/dma-mapping.h                        |   2 -
 include/linux/fscache.h                            |   2 +-
 include/linux/stddef.h                             |  10 +
 include/linux/usb/ch9.h                            |   2 +
 include/net/red.h                                  |  11 +
 include/net/xfrm.h                                 |   1 +
 include/scsi/libsas.h                              |   9 +-
 kernel/debug/kdb/kdb_io.c                          |   2 +-
 kernel/futex.c                                     |   3 +
 kernel/groups.c                                    |   5 +-
 kernel/hrtimer.c                                   |   2 +
 kernel/posix-timers.c                              |  37 +-
 kernel/trace/ring_buffer.c                         |   6 +-
 kernel/uid16.c                                     |   1 +
 mm/mprotect.c                                      |   6 +-
 net/8021q/vlan.c                                   |   6 +-
 net/batman-adv/bat_iv_ogm.c                        |   4 +-
 net/bridge/br_netlink.c                            |   7 +-
 net/can/af_can.c                                   |  12 +-
 net/dccp/ccids/ccid2.c                             |   3 +
 net/ipv4/esp4.c                                    |   1 +
 net/ipv4/igmp.c                                    |  20 +-
 net/ipv4/raw.c                                     | 119 ++-
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv4/xfrm4_input.c                             |  11 +-
 net/ipv6/esp6.c                                    |   3 +-
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/ipv6/xfrm6_input.c                             |   9 +-
 net/key/af_key.c                                   |   8 +
 net/packet/af_packet.c                             |   5 +
 net/rds/rdma.c                                     |   2 +-
 net/sched/sch_choke.c                              |   3 +
 net/sched/sch_gred.c                               |   3 +
 net/sched/sch_red.c                                |   2 +
 net/sctp/socket.c                                  |  27 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |   1 +
 net/sunrpc/svcauth_unix.c                          |   2 +
 net/wireless/core.c                                |   7 +-
 net/wireless/wext-compat.c                         |   3 +-
 net/xfrm/xfrm_input.c                              |  56 ++
 sound/core/oss/pcm_oss.c                           |  41 +-
 sound/core/oss/pcm_plugin.c                        |  14 +-
 sound/core/pcm.c                                   |   2 +
 sound/core/pcm_lib.c                               |   5 +-
 sound/core/rawmidi.c                               |  15 +-
 sound/core/seq/seq_clientmgr.c                     |  15 +-
 sound/core/seq/seq_timer.c                         |   2 +-
 sound/drivers/aloop.c                              |  98 ++-
 sound/usb/mixer.c                                  |  27 +-
 128 files changed, 1509 insertions(+), 882 deletions(-)

-- 
Ben Hutchings
If the facts do not conform to your theory, they must be disposed of.
