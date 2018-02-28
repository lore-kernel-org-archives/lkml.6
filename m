Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519833410-2-2719436272923927426
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
    t=1519833408; b=cq+gYjIc3UZlGrgzCmyjQkRoM46sG+40FBXXVmA9n484aq6
    A1oRx067pSwduJrz9jdMzmYz3/8IEpJlwofJMTGNgyqloVn48ofX1FwaxmpqyteL
    INXuX8/aCXX8YUxckFsA3VdsFPR8Eq1GI4IY/y+c+8y8yj3XlMJK847nGvTkWZ9V
    8+YuMhaBP94oyG5tDMKYvVjej4+pzRYOnp7xHPDNc/kQNz9Vp+SKMzD1Dj2WqH1R
    kzihPqT/qhjCSjUtXtgNnrtnNuzuYwLQ9NO2tcf0xpyakKw1qp2jvV+4NkbKRu0x
    iY+nrWpeVRE4FCuL5ElVXRUM5yg/tLHPpeSZLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:sender:list-id;
    s=arctest; t=1519833408; bh=Xqvpyzn+ylwdmkDsWtWXpeJTXnayJ9arP3C
    P+7bhYak=; b=gcd5bpiDJfQal0khwvrZuYTTgVPdt0nwOODPwrCRvF3ZO0onnCJ
    9NLXDbxWiyUzFowLWEaHR3dxrgF8Hi5btfq0tTicktMKG2oXEdUv5UHuoRnapbMG
    k0HieirMUvktbqme7e/CZr/GHKte7Jou9HnxtNK2cRs+DxYx+z4nuKjwPD5UGJeQ
    VZATbJaNlRvzky8LBg0SOK5U6zpIb9OBPCzcRHXu9P9RO6jBo+OGk57kntpbKJEt
    8pkp2EvWxQqL0A7fp9lNqGmg01oD9TCjUceVbo09k6QJRD8G1lOLJcj7VDyaNKTz
    fg8vnS79PRYcj9U30/YU6QUTvdGR2XCpiiA==
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
        id S932959AbeB1Pzg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:55:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34441 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932974AbeB1PxO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:53:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date: Wed, 28 Feb 2018 15:20:17 +0000
Message-ID: <lsq.1519831217.271785318@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 000/254] 3.16.55-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.16.55 release.
There are 254 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar 02 18:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Aaron Ma (2):
      Input: elantech - add new icbody type 15
         [10d900303f1c3a821eb0bef4e7b7ece16768fba4]
      Input: trackpoint - force 3 buttons if 0 button is reported
         [f5d07b9e98022d50720e38aa936fc11c67868ece]

Adam Wallis (2):
      dmaengine: dmatest: move callback wait queue to thread context
         [6f6a23a213be51728502b88741ba6a10cda2441d]
      dmaengine: dmatest: warn user when dma test times out
         [a9df21e34b422f79d9a9fa5c3eff8c2a53491be6]

Alan Stern (3):
      USB: Gadget core: fix inconsistency in the interface tousb_add_gadget_udc_release()
         [afd7fd81f22bf90474216515dbd6088f9bd70343]
      USB: UDC core: fix double-free in usb_add_gadget_udc_release
         [7ae2c3c280db183ca9ada2675c34ec2f7378abfa]
      usb: udc: core: add device_del() call to error pathway
         [c93e64e91248becd0edb8f01723dff9da890e2ab]

Alexey Kodanev (1):
      dccp: don't restart ccid2_hc_tx_rto_expire() if sk in closed state
         [dd5684ecae3bd8e44b644f50e2c12c7e57fdfef5]

Andrew Bresticker (1):
      mac80211_hwsim: fix compiler warning on MIPS
         [5d26b50813ea6206a7bbab2e645e68044f101ac5]

Andrew Honig (1):
      KVM: x86: Add memory barrier on vmcs field lookup
         [75f139aaf896d6fdeec2e468ddfa4b2fe469bf40]

Anshuman Khandual (1):
      mm/mprotect: add a cond_resched() inside change_pmd_range()
         [4991c09c7c812dba13ea9be79a68b4565bb1fa4e]

Arnd Bergmann (1):
      mmc: s3mci: mark debug_regs[] as static
         [2bd7b4aacdb6efa5ccd4749c365c171b884791d2]

Bart Van Assche (1):
      IB/srpt: Disable RDMA access by the initiator
         [bec40c26041de61162f7be9d2ce548c756ce0f65]

Ben Hutchings (3):
      ASoC: wm_adsp: Fix validation of firmware and coeff lengths
         [50dd2ea8ef67a1617e0c0658bcbec4b9fb03b936]
      nfsd: auth: Fix gid sorting when rootsquash enabled
         [1995266727fa8143897e89b55f5d3c79aa828420]
      of: fdt: Fix return with value in void function
         [not upstream; fixes incorrect backport]

Benjamin Herrenschmidt (1):
      powerpc: Don't preempt_disable() in show_cpuinfo()
         [349524bc0da698ec77f2057cf4a4948eb6349265]

Benjamin Poirier (2):
      e1000e: Fix e1000_check_for_copper_link_ich8lan return value.
         [4110e02eb45ea447ec6f5459c9934de0a273fb91]
      e1000e: Separate signaling for link check/link up
         [19110cfbb34d4af0cdfe14cd243f3b09dc95b013]

Bin Liu (1):
      usb: musb: da8xx: fix babble condition handling
         [bd3486ded7a0c313a6575343e6c2b21d14476645]

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

Christophe JAILLET (1):
      mdio-sun4i: Fix a memory leak
         [56c0290202ab94a2f2780c449395d4ae8495fab4]

Christophe Leroy (1):
      net: fs_enet: do not call phy_stop() in interrupts
         [f8b39039cbf2a15f2b8c9f081e1cbd5dee00aaf5]

Colin Ian King (2):
      usb: gadget: don't dereference g until after it has been null checked
         [b2fc059fa549fe6881d4c1f8d698b0f50bcd16ec]
      usb: host: fix incorrect updating of offset
         [1d5a31582ef046d3b233f0da1a68ae26519b2f0a]

Cong Wang (1):
      8021q: fix a memory leak for VLAN 0 device
         [78bbb15f2239bc8e663aa20bbe1987c91a0b75f6]

Daniel Mentz (2):
      media: v4l2-compat-ioctl32.c: refactor  compat ioctl32 logic
         [a1dfb4c48cc1e64eeb7800a27c66a6f7e88d075a]
      media: v4l2-compat-ioctl32: Copy  v4l2_window->global_alpha
         [025a26fa14f8fd55d50ab284a30c016a5be953d0]

Daniel Thompson (2):
      kdb: Fix handling of kallsyms_symbol_next() return value
         [c07d35338081d107e57cf37572d8cc931a8e32e2]
      usb: xhci: Add XHCI_TRUST_TX_LENGTH for Renesas uPD720201
         [da99706689481717998d1d48edd389f339eea979]

Daniele Palmas (1):
      USB: serial: option: add support for Telit ME910 PID 0x1101
         [08933099e6404f588f81c2050bfec7313e06eeaf]

Dave Martin (2):
      arm64: fpsimd: Prevent registers leaking from dead tasks
         [071b6d4a5d343046f253a5a8835d477d93992002]
      mips/ptrace: Preserve previous registers for short regset write
         [d614fd58a2834cfe4efa472c33c8f3ce2338b09b]

David Howells (1):
      fscache: Fix the default for fscache_maybe_release_page()
         [98801506552593c9b8ac11021b0cdad12cab4f6b]

David Kozub (1):
      USB: uas and storage: Add US_FL_BROKEN_FUA for another JMicron JMS567 ID
         [62354454625741f0569c2cbe45b2d192f8fd258e]

David Woodhouse (1):
      x86/alternatives: Add missing '\n' at end of ALTERNATIVE inline asm
         [b9e705ef7cfaf22db0daab91ad3cd33b0fa32eb9]

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

Dominik Brodowski (1):
      nl80211: take RCU read lock when calling ieee80211_bss_get_ie()
         [7a94b8c2eee7083ddccd0515830f8c81a8e44b1a]

Erez Shitrit (1):
      IB/ipoib: Fix race condition in neigh creation
         [16ba3defb8bd01a9464ba4820a487f5b196b455b]

Eric Biggers (8):
      509: fix printing uninitialized stack memory when OID is empty
         [8dfd2f22d3bf3ab7714f7495ad5d897b8845e8c1]
      ASN.1: check for error from ASN1_OP_END__ACT actions
         [81a7be2cd69b412ab6aeacfe5ebf1bb6e5bce955]
      ASN.1: fix out-of-bounds read when parsing indefinite length item
         [e0058f3a874ebb48b25be7ff79bc3b4e59929f90]
      X.509: fix buffer overflow detection in sprint_oid()
         [47e0a208fb9d91e3f3c86309e752b13a36470ae8]
      X.509: reject invalid BIT STRING for subjectPublicKey
         [0f30cbea005bd3077bd98cd29277d7fc2699c1da]
      af_key: fix buffer overread in parse_exthdrs()
         [4e765b4972af7b07adcb1feb16e7a525ce1f6b28]
      af_key: fix buffer overread in verify_address_len()
         [06b335cb51af018d5feeff5dd4fd53847ddb675a]
      crypto: algapi - fix NULL dereference in crypto_remove_spawns()
         [9a00674213a3f00394f4e3221b88f2d21fc05789]

Eric Dumazet (1):
      net/packet: fix a race in packet_bind() and packet_notifier()
         [15fe076edea787807a7cdc168df832544b58eba6]

Eryu Guan (1):
      ext4: fix fdatasync(2) after fallocate(2) operation
         [c894aa97577e47d3066b27b32499ecf899bfa8b0]

Eugenia Emantayev (1):
      net/mlx5: Fix misspelling in the error message and comment
         [777ec2b2a3f2760505db395de1a9fa4115d74548]

Felix Fietkau (1):
      net: igmp: fix source address check for IGMPv3 reports
         [ad23b750933ea7bf962678972a286c78a8fa36aa]

Florian Fainelli (1):
      net: phy: Add phy_interface_is_rgmii helper
         [e463d88c36d42211aa72ed76d32fb8bf37820ef1]

Greg Kroah-Hartman (2):
      ACPI: sbshc: remove raw pointer from printk() message
         [43cdd1b716b26f6af16da4e145b6578f98798bf6]
      efi: Move some sysfs files to be read-only by root
         [af97a77bc01ce49a466f9d4c0125479e2e2230b6]

Guennadi Liakhovetski (1):
      [media] V4L2: fix VIDIOC_CREATE_BUFS 32-bit compatibility mode data copy-back
         [6ed9b28504326f8cf542e6b68245b2f7ce009216]

Guillaume Nault (1):
      pppoe: take ->needed_headroom of lower device into account on xmit
         [02612bb05e51df8489db5e94d0cf8d1c81f87b0c]

H. Nikolaus Schaller (1):
      Input: twl6040-vibra - fix DT node memory management
         [c52c545ead97fcc2f4f8ea38f1ae3c23211e09a8]

Hans Verkuil (13):
      [media] v4l2-compat-ioctl32: fix sparse warnings
         [8ae632b11775254c5e555ee8c42b7d19baeb1473]
      adv7604: use correct drive strength defines
         [not upstream; fixes incorrect backport]
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
      media: v4l2-compat-ioctl32.c: move  'helper' functions to __get/put_v4l2_format32
         [486c521510c44a04cd756a9267e7d1e271c8a4ba]
      media: v4l2-ioctl.c: don't copy back the  result for -ENOTTY
         [181a4a2d5a0a7b43cab08a70710d727e7764ccdd]

Hans de Goede (1):
      uas: Always apply US_FL_NO_ATA_1X quirk to Seagate devices
         [7fee72d5e8f1e7b8d8212e28291b1a0243ecf2f1]

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

Hui Wang (1):
      ALSA: hda - Add MIC_NO_PRESENCE fixup for 2 HP machines
         [322f74ede933b3e2cb78768b6a6fdbfbf478a0c1]

Håkon Bugge (1):
      rds: Fix NULL pointer dereference in __rds_rdma_map
         [f3069c6d33f6ae63a1668737bc78aaaa51bff7ca]

Icenowy Zheng (1):
      uas: ignore UAS for Norelsys NS1068(X) chips
         [928afc85270753657b5543e052cc270c279a3fe9]

Iyappan Subramanian (1):
      phy: Add helper function to check phy interface mode
         [32d0f7830d9be5b1652a718e050d808b4908155f]

Jaejoong Kim (2):
      ALSA: usb-audio: Add check return value for usb_string()
         [89b89d121ffcf8d9546633b98ded9d18b8f75891]
      ALSA: usb-audio: Fix out-of-bound error
         [251552a2b0d454badc8f486e6d79100970c744b0]

James Hogan (3):
      MIPS: CPS: Fix r1 .set mt assembler warning
         [17278a91e04f858155d54bee5528ba4fbcec6f87]
      MIPS: Clear [MSA]FPE CSR.Cause after notify_die()
         [64bedffe496820dbb6b53302d80dd0f04db33d8e]
      MIPS: lose_fpu(): Disable FPU when MSA enabled
         [acaf6a97d623af123314c2f8ce4cf7254f6b2fc1]

Jan Engelhardt (1):
      crypto: n2 - cure use after free
         [203f45003a3d03eea8fa28d74cfc74c354416fdb]

Jann Horn (1):
      netfilter: xt_bpf: add overflow checks
         [6ab405114b0b229151ef06f4e31c7834dd09d0c0]

Jeff Mahoney (1):
      btrfs: fix missing error return in btrfs_drop_snapshot
         [e19182c0fff451e3744c1107d98f072e7ca377a0]

Jens Axboe (1):
      blktrace: fix trace mutex deadlock
         [2967acbb257a6a9bf912f4778b727e00972eac9b]

Jeremy Compostella (1):
      i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA
         [89c6efa61f5709327ecfa24bff18e57a4e80c7fa]

Jerome Brunet (1):
      net: stmmac: enable EEE in MII, GMII or RGMII only
         [879626e3a52630316d817cbda7cec9a5446d1d82]

Jia Zhang (2):
      x86/microcode/intel: Extend BDW late-loading further with LLC size check
         [7e702d17ed138cf4ae7c00e8c00681ed464587c7]
      x86/microcode/intel: Extend BDW late-loading with a revision check
         [b94b7373317164402ff7728d10f7023127a02b60]

Jimmy Assarsson (3):
      can: kvaser_usb: Fix comparison bug in kvaser_usb_read_bulk_callback()
         [e84f44eb5523401faeb9cc1c97895b68e3cfb78d]
      can: kvaser_usb: free buf in error paths
         [435019b48033138581a6171093b181fc6b4d3d30]
      can: kvaser_usb: ratelimit errors if incomplete messages are received
         [8bd13bd522ff7dfa0eb371921aeb417155f7a3be]

Jing Xia (1):
      tracing: Fix crash when it fails to alloc ring buffer
         [24f2aaf952ee0b59f31c3a18b8b36c9e3d3c2cf5]

Joe Perches (1):
      stddef.h: move offsetofend inside #ifndef/#endif guard, neaten
         [8c7fbe5795a016259445a61e072eb0118aaf6a61]

Joe Thornber (1):
      dm btree: fix serious bug in btree_split_beneath()
         [bc68d0a43560e950850fc69b58f0f8254b28f6d6]

Johan Hovold (6):
      ASoC: twl4030: fix child-node lookup
         [15f8c5f2415bfac73f33a14bcd83422bcbfb5298]
      Input: 88pm860x-ts - fix child-node lookup
         [906bf7daa0618d0ef39f4872ca42218c29a3631f]
      Input: twl4030-vibra - fix sibling-node lookup
         [5b189201993ab03001a398de731045bfea90c689]
      Input: twl6040-vibra - fix child-node lookup
         [dcaf12a8b0bbdbfcfa2be8dff2c4948d9844b4ad]
      mfd: twl4030-audio: Fix sibling-node lookup
         [0a423772de2f3d7b00899987884f62f63ae00dcb]
      mfd: twl6040: Fix child-node lookup
         [85e9b13cbb130a3209f21bd7933933399c389ffe]

Johannes Berg (4):
      cfg80211: check dev_set_name() return value
         [59b179b48ce2a6076448a44531242ac2b3f6cef2]
      cfg80211: fix station info handling bugs
         [5762d7d3eda25c03cc2d9d45227be3f5ab6bec9e]
      mac80211_hwsim: validate number of different channels
         [51a1aaa631c90223888d8beac4d649dc11d2ca55]
      nl80211: fix nl80211_send_iface() error paths
         [4564b187c16327045d87596e8980c65ba7b84c50]

Johannes Thumshirn (1):
      dm mpath: simplify failure path of dm_multipath_init()
         [ff658e9c1aae9a84dd06d46f847dc0cd2bf0dd11]

Jon Hunter (1):
      mfd: cros ec: spi: Don't send first message too soon
         [15d8374874ded0bec37ef27f8301a6d54032c0e5]

Josef Bacik (1):
      btrfs: clear space cache inode generation always
         [8e138e0d92c6c9d3d481674fb14e3439b495be37]

Juan Zea (1):
      usbip: fix usbip bind writing random string after command in match_busid
         [544c4605acc5ae4afe7dd5914147947db182f2fb]

Kai-Heng Feng (1):
      usb: quirks: Add no-lpm quirk for KY-688 USB 3.1 Type-C Hub
         [e43a12f1793ae1fe006e26fe9327a8840a92233c]

Kevin Cernekee (1):
      net: igmp: Use correct source address on IGMPv3 reports
         [a46182b00290839fa3fa159d54fd3237bd8669f0]

Kristina Martsenko (1):
      arm64: KVM: fix VTTBR_BADDR_MASK BUG_ON off-by-one
         [26aa7b3b1c0fb3f1a6176a0c1847204ef4355693]

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

Liran Alon (3):
      KVM: x86: Don't re-execute instruction when not passing CR2 value
         [9b8ae63798cb97e785a667ff27e43fa6220cb734]
      KVM: x86: Exit to user-mode on #UD intercept when emulator requires
         [61cb57c9ed631c95b54f8e9090c89d18b3695b3c]
      KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure
         [1f4dcb3b213235e642088709a1c54964d23365e9]

Lixin Wang (1):
      i2c: core: decrease reference count of device node in i2c_unregister_device
         [e0638fa400eaccf9fa8060f67140264c4e276552]

Maciej S. Szmigiero (2):
      ASoC: fsl_ssi: AC'97 ops need regmap, clock and cleaning up on failure
         [695b78b548d8a26288f041e907ff17758df9e1d5]
      ASoC: fsl_ssi: add AC'97 ops setting check and cleanup
         [04143d614f3af84a3f39e79a24a7ca740bd39efd]

Maciej W. Rozycki (13):
      MIPS: Always clear FCSR cause bits after emulation
         [443c44032a54f9acf027a8e688380fddc809bc19]
      MIPS: Disallow outsized PTRACE_SETREGSET NT_PRFPREG regset accesses
         [c8c5a3a24d395b14447a9a89d61586a913840a3b]
      MIPS: Factor out NT_PRFPREG regset access helpers
         [a03fe72572c12e98f4173f8a535f32468e48b6ec]
      MIPS: Fix FCSR Cause bit handling for correct SIGFPE issue
         [5a1aca4469fdccd5b74ba0b4e490173b2b447895]
      MIPS: Fix a preemption issue with thread's FPU defaults
         [03dce595270f22d59a6f37e9170287c1afd94bc2]
      MIPS: Fix an FCSR access API regression with NT_PRFPREG and MSA
         [be07a6a1188372b6d19a3307ec33211fc9c9439d]
      MIPS: Guard against any partial write attempt with PTRACE_SETREGSET
         [dc24d0edf33c3e15099688b6bbdf7bdc24bf6e91]
      MIPS: Respect the FCSR exception mask for `si_code'
         [ed2d72c1eb3643b7c109bdf387563d9b9a30c279]
      MIPS: Respect the ISA level in FCSR handling
         [9b26616c8d9dae53fbac7f7cb2c6dd1308102976]
      MIPS: Set `si_code' for SIGFPE signals sent from emulation too
         [304acb717e5b67cf56f05bc5b21123758e1f7ea0]
      MIPS: math-emu: Define IEEE 754-2008 feature control bits
         [f1f3b7ebac08161761c352fd070cfa07b7b94c54]
      MIPS: ptrace: Fix FP context restoration FCSR regression
         [4249548454f7ba4581aeee26bd83f42b48a14d15]
      MIPS: ptrace: Prevent writes to read-only FCSR bits
         [abf378be49f38c4d3e23581d3df3fa9f1b1b11d2]

Marc Kleine-Budde (2):
      can: af_can: can_rcv(): replace WARN_ONCE by pr_warn_once
         [8cb68751c115d176ec851ca56ecfbb411568c9e8]
      can: af_can: canfd_rcv(): replace WARN_ONCE by pr_warn_once
         [d4689846881d160a4d12a514e991a740bcb5d65a]

Marc Zyngier (3):
      KVM: arm/arm64: Fix HYP unmapping going off limits
         [7839c672e58bf62da8f2f0197fefb442c02ba1dd]
      arm64: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls
         [acfb3b883f6d6a4b5d27ad7fdded11f6a09ae6dd]
      arm: KVM: Fix VTTBR_BADDR_MASK BUG_ON off-by-one
         [5553b142be11e794ebc0805950b2e8313f93d718]

Marek Belisko (1):
      Input: twl4030-vibra - fix ERROR: Bad of_node_put() warning
         [e661d0a04462dd98667f8947141bd8defab5b34a]

Martin Kelly (4):
      can: ems_usb: cancel urb on -EPIPE and -EPROTO
         [bd352e1adfe0d02d3ea7c8e3fb19183dc317e679]
      can: esd_usb2: cancel urb on -EPIPE and -EPROTO
         [7a31ced3de06e9878e4f9c3abe8f87d9344d8144]
      can: kvaser_usb: cancel urb on -EPIPE and -EPROTO
         [6aa8d5945502baf4687d80de59b7ac865e9e666b]
      can: usb_8dev: cancel urb on -EPIPE and -EPROTO
         [12147edc434c9e4c7c2f5fee2e5519b2e5ac34ce]

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

Mike Looijmans (1):
      usb: hub: Cycle HUB power when initialization fails
         [973593a960ddac0f14f0d8877d2d0abe0afda795]

Ming Lei (1):
      blk-mq: fix race between timeout and freeing request
         [0048b4837affd153897ed1222283492070027aa9]

Mohamed Ghannam (1):
      net: ipv4: fix for a race condition in raw_sendmsg
         [8f659a03a0ba9289b9aeb9b4470e6fb263d6f483]

Monty_pavel@Sina.Com (1):
      dm: fix various targets to dm_register_target after module __init resources created
         [7e6358d244e4706fe612a77b9c36519a33600ac0]

Moshe Shemesh (2):
      net/mlx5: Cleanup IRQs in case of unload failure
         [d6b2785cd55ee72e9608762650b3ef299f801b1b]
      net/mlx5: Stay in polling mode when command EQ destroy fails
         [a2fba188fd5eadd6061bef4f2f2577a43231ebf3]

Nicolai Stange (1):
      net: ipv4: emulate READ_ONCE() on ->hdrincl bit-field in raw_sendmsg()
         [20b50d79974ea3192e8c3ab7faf4e536e5f14d8f]

Nikolay Aleksandrov (1):
      net: bridge: fix early call to br_stp_change_bridge_id and plug newlink leaks
         [84aeb437ab98a2bce3d4b2111c79723aedfceb33]

Nikolay Borisov (1):
      btrfs: Fix possible off-by-one in btrfs_search_path_in_tree
         [c8bcbfbd239ed60a6562964b58034ac8a25f4c31]

Nogah Frankel (2):
      net_sched: red: Avoid devision by zero
         [5c472203421ab4f928aa1ae9e1dbcfdd80324148]
      net_sched: red: Avoid illegal values
         [8afa10cbe281b10371fee5a87ab266e48d71a7f9]

Oleg Nesterov (1):
      kernel/acct.c: fix the acct->needcheck check in check_free_space()
         [4d9570158b6260f449e317a5f9ed030c2504a615]

Oliver Neukum (2):
      USB: usbfs: Filter flags passed in from user space
         [446f666da9f019ce2ffd03800995487e79a91462]
      usb: add RESET_RESUME for ELSA MicroLink 56K
         [b9096d9f15c142574ebebe8fbb137012bb9d99c2]

Oliver Stäbler (1):
      can: ti_hecc: Fix napi poll return value for repoll
         [f6c23b174c3c96616514827407769cbcfc8005cf]

Omar Sandoval (1):
      Btrfs: disable FUA if mounted with nobarrier
         [1b9e619c5bc8235cfba3dc4ced2fb0e3554a05d4]

Oscar Campos (1):
      Input: trackpoint - assume 3 buttons when buttons detection fails
         [293b915fd9bebf33cdc906516fb28d54649a25ac]

Paul Burton (2):
      MIPS: clear MSACSR cause bits when handling MSA FP exception
         [091be550a70a086c3b4420c6155e733dc410f190]
      MIPS: prevent FP context set via ptrace being discarded
         [ac9ad83bc318635ed7496e9dff30beaa522eaec7]

Paul Meyer (1):
      hv: kvp: Avoid reading past allocated blocks from KVP file
         [297d6b6e56c2977fc504c61bbeeaa21296923f89]

Pete Zaitcev (1):
      USB: fix usbmon BUG trigger
         [46eb14a6e1585d99c1b9f58d0e7389082a5f466b]

Petri Gynther (1):
      net: bcmgenet: fix bcmgenet_open()
         [fac25940c5e0d6f31d56bb2a704fadad6d5e382a]

Rafael J. Wysocki (2):
      PCI / PM: Force devices to D0 in pci_pm_thaw_noirq()
         [5839ee7389e893a31e4e3c9cf17b50d14103c902]
      x86/PCI: Make broadcom_postcore_init() check acpi_disabled
         [ddec3bdee05b06f1dda20ded003c3e10e4184cab]

Ralf Baechle (1):
      MIPS: MSA: bugfix - disable MSA correctly for new threads/processes.
         [9cc719ab3f4f639d629ac8ff09e9b998bc006f68]

Ravi Bangoria (1):
      powerpc/perf: Dereference BHRB entries safely
         [f41d84dddc66b164ac16acf3f584c276146f1c48]

Ricardo Ribalda (1):
      vb2: V4L2_BUF_FLAG_DONE is set after DQBUF
         [3171cc2b4eb9831ab4df1d80d0410a945b8bc84e]

Richard Fitzgerald (1):
      ASoC: wm_adsp: Don't overrun firmware file buffer when reading region data
         [1cab2a84f470e15ecc8e5143bfe9398c6e888032]

Robb Glasser (1):
      ALSA: pcm: prevent UAF in snd_pcm_info
         [362bca57f5d78220f8b5907b875961af9436e229]

Robert Lippert (1):
      hwmon: (pmbus) Use 64bit math for DIRECT format values
         [bd467e4eababe4c04272c1e646f066db02734c79]

Robin Murphy (1):
      iommu/vt-d: Fix scatterlist offset handling
         [29a90b70893817e2f2bb3cea40a29f5308e21b21]

Rui Hua (1):
      bcache: recover data from backing when data is clean
         [e393aa2446150536929140739f09c6ecbcbea7f0]

SZ Lin (1):
      USB: serial: option: adding support for YUGA CLM920-NC5
         [3920bb713038810f25770e7545b79f204685c8f2]

Sebastian Sjoholm (1):
      USB: serial: option: add Quectel BG96 id
         [c654b21ede93845863597de9ad774fd30db5f2ab]

Sergei Shtylyov (5):
      SolutionEngine771x: add Ether TSU resource
         [f9a531d6731d74f1e24298d9641c2dc1fef2631b]
      SolutionEngine771x: fix Ether platform data
         [195e2addbce09e5afbc766efc1e6567c9ce840d3]
      sh_eth: fix SH7757 GEther initialization
         [5133550296d43236439494aa955bfb765a89f615]
      sh_eth: fix TSU resource handling
         [dfe8266b8dd10e12a731c985b725fcf7f0e537f0]
      sh_eth: fix TXALCR1 offsets
         [50f3d740d376f664f6accc7e86c9afd8f1c7e1e4]

Shuah Khan (4):
      usbip: prevent leaking socket pointer address in messages
         [90120d15f4c397272aaf41077960a157fc4212bf]
      usbip: remove kernel addresses from usb device and urb debug msgs
         [e1346fd87c71a1f61de1fe476ec8df1425ac931c]
      usbip: stub: stop printing kernel pointer addresses in messages
         [248a22044366f588d46754c54dfe29ffe4f8b4df]
      usbip: vhci: stop printing kernel pointer addresses in messages
         [8272d099d05f7ab2776cf56a2ab9f9443be18907]

Stefan Agner (1):
      usb: misc: usb3503: make sure reset is low for at least 100us
         [b8626f1dc29d3eee444bfaa92146ec7b291ef41c]

Steve Wise (1):
      iw_cxgb4: Only validate the MSN for successful completions
         [f55688c45442bc863f40ad678c638785b26cdce6]

Steven Rostedt (2):
      ring-buffer: Mask out the info bits when returning buffer page length
         [45d8b80c2ac5d21cd1e2954431fb676bc2b1e099]
      tracing: Fix possible double free on failure of allocating trace buffer
         [4397f04575c44e1440ec2e49b6302785c95fd2f8]

Sven Eckelmann (1):
      batman-adv: Fix lock for ogm cnt access in batadv_iv_ogm_calc_tq
         [5ba7dcfe77037b67016263ea597a8b431692ecab]

Takashi Iwai (15):
      ACPI: APEI / ERST: Fix missing error handling in erst_reader()
         [bb82e0b4a7e96494f0c1004ce50cec3d7b5fb3d1]
      ALSA: aloop: Fix inconsistent format due to incomplete rule
         [b088b53e20c7d09b5ab84c5688e609f478e5c417]
      ALSA: aloop: Fix racy hw constraints adjustment
         [898dfe4687f460ba337a01c11549f87269a13fa2]
      ALSA: aloop: Release cable upon open error path
         [9685347aa0a5c2869058ca6ab79fd8e93084a67f]
      ALSA: hda - Apply the existing quirk to iMac 14,1
         [031f335cda879450095873003abb03ae8ed3b74a]
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
      lib/oid_registry.c: X.509: fix the buffer overflow in the utility function for OID string
         [afdb05e9d61905220f09268535235288e6ba3a16]

Tetsuo Handa (1):
      quota: Check for register_shrinker() failure.
         [88bc0ede8d35edc969350852894dc864a2dc1859]

Thiago Rafael Becker (1):
      kernel: make groups_sort calling a responsibility group_info allocators
         [bdcf0a423ea1c40bbb40e7ee483b50fc8aa3d758]

Thomas Gleixner (4):
      hrtimer: Reset hrtimer cpu base proper on CPU hotplug
         [d5421ea43d30701e03cadc56a38854c36a8b4433]
      nohz: Prevent a timer interrupt storm in tick_nohz_stop_sched_tick()
         [5d62c183f9e9df1deeea0906d099a94e8a43047a]
      posix-timer: Properly check sigevent->sigev_notify
         [cef31d9af908243421258f1df35a4a644604efbe]
      x86/mce: Make machine check speculation protected
         [6f41c34d69eb005e7848716bbcafc979b35037d5]

Thomas Petazzoni (1):
      ARM: dts: kirkwood: fix pin-muxing of MPP7 on OpenBlocks A7
         [56aeb07c914a616ab84357d34f8414a69b140cdf]

Tianyu Lan (1):
      KVM/x86: Fix wrong macro references of X86_CR0_PG_BIT and X86_CR4_PAE_BIT in kvm_valid_sregs()
         [37b95951c58fdf08dc10afa9d02066ed9f176fb5]

Tiffany Lin (1):
      [media] media: v4l2-compat-ioctl32: fix missing reserved field copy in put_v4l2_create32
         [baf43c6eace43868e490f18560287fa3481b2159]

Tobias Jordan (2):
      dmaengine: jz4740: disable/unprepare clk if probe fails
         [eb9436966fdc84cebdf222952a99898ab46d9bb0]
      net: mvmdio: disable/unprepare clocks in EPROBE_DEFER case
         [589bf32f09852041fbd3b7ce1a9e703f95c230ba]

Tonghao Zhang (1):
      sctp: Replace use of sockets_allocated with specified macro.
         [8cb38a602478e9f806571f6920b0a3298aabf042]

Ville Syrjälä (2):
      drm/i915: Don't try indexed reads to alternate slave addresses
         [c4deb62d7821672265b87952bcd1c808f3bf3e8f]
      drm/i915: Prevent zero length "index" write
         [bb9e0d4bca50f429152e74a459160b41f3d60fb2]

Wanpeng Li (1):
      KVM: X86: Fix load RFLAGS w/o the fixed bit
         [d73235d17ba63b53dc0e1051dbc10a1f1be91b71]

Weiping Zhang (1):
      virtio: release virtio index when fail to device_register
         [e60ea67bb60459b95a50a156296041a13e0e380e]

William Breathitt Gray (1):
      isa: Prevent NULL dereference in isa_bus driver callbacks
         [5a244727f428a06634f22bb890e78024ab0c89f3]

Wolfgang Grandegger (1):
      can: gs_usb: fix return value of the "set_bittiming" callback
         [d5b42e6607661b198d8b26a0c30969605b1bf5c7]

Xin Long (4):
      sctp: do not allow the v4 socket to bind a v4mapped v6 address
         [c5006b8aa74599ce19104b31d322d2ea9ff887cc]
      sctp: force the params with right types for sctp csum apis
         [af2697a0273f7665429c47d71ab26f2412af924e]
      sctp: return error if the asoc has been peeled off in sctp_wait_for_sndbuf
         [a0ff660058b88d12625a783ce9e5c1371c87951f]
      sctp: use the right sk after waking up from wait_buf sleep
         [cea0cc80a6777beb6eb643d4ad53690e1ad1d4ff]

Yelena Krivosheev (1):
      net: mvneta: clear interface link status on port disable
         [4423c18e466afdfb02a36ee8b9f901d144b3c607]

Yu Chen (1):
      usb: xhci: fix panic in xhci_free_virt_devices_depth_first
         [80e457699a8dbdd70f2d26911e46f538645c55fc]

Zhao Qiang (1):
      net: phy: marvell: Limit 88m1101 autoneg errata to 88E1145 as well.
         [c505873eaece2b4aefd07d339dc7e1400e0235ac]

 Makefile                                           |    7 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |   10 +-
 arch/arm/include/asm/kvm_arm.h                     |    3 +-
 arch/arm/kvm/mmu.c                                 |   10 +-
 arch/arm64/include/asm/kvm_arm.h                   |    3 +-
 arch/arm64/kernel/process.c                        |    9 +
 arch/arm64/kvm/handle_exit.c                       |    4 +-
 arch/mips/include/asm/cpu-info.h                   |    2 +
 arch/mips/include/asm/elf.h                        |    7 +
 arch/mips/include/asm/fpu.h                        |    6 +-
 arch/mips/include/asm/fpu_emulator.h               |   18 +-
 arch/mips/include/asm/kdebug.h                     |    3 +-
 arch/mips/include/asm/mipsregs.h                   |   14 +-
 arch/mips/include/asm/switch_to.h                  |   21 +-
 arch/mips/kernel/cps-vec.S                         |    2 +
 arch/mips/kernel/cpu-probe.c                       |   55 +-
 arch/mips/kernel/genex.S                           |   15 +-
 arch/mips/kernel/ptrace.c                          |  197 +++-
 arch/mips/kernel/r2300_switch.S                    |    7 +-
 arch/mips/kernel/r4k_switch.S                      |    7 +-
 arch/mips/kernel/traps.c                           |  153 ++-
 arch/mips/kernel/unaligned.c                       |    4 +-
 arch/mips/math-emu/cp1emu.c                        |    8 +-
 arch/mips/math-emu/ieee754.h                       |   12 +-
 arch/powerpc/kernel/setup-common.c                 |   11 -
 arch/powerpc/perf/core-book3s.c                    |    8 +-
 arch/s390/include/asm/switch_to.h                  |   24 +-
 arch/s390/kernel/compat_linux.c                    |    1 +
 arch/sh/boards/mach-se/770x/setup.c                |   24 +-
 arch/sh/include/mach-se/mach/se.h                  |    1 +
 arch/x86/include/asm/alternative.h                 |    4 +-
 arch/x86/include/asm/kvm_host.h                    |    3 +-
 arch/x86/include/asm/traps.h                       |    1 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |    6 +
 arch/x86/kernel/cpu/microcode/intel.c              |   29 +-
 arch/x86/kernel/entry_64.S                         |    2 +-
 arch/x86/kvm/svm.c                                 |    2 +
 arch/x86/kvm/vmx.c                                 |   16 +-
 arch/x86/kvm/x86.c                                 |   30 +-
 arch/x86/pci/broadcom_bus.c                        |    2 +-
 block/blk-flush.c                                  |    6 +
 block/blk-mq-tag.h                                 |   12 +
 block/blk-mq.c                                     |   16 +-
 crypto/algapi.c                                    |   12 +
 crypto/asymmetric_keys/x509_cert_parser.c          |    2 +
 drivers/acpi/apei/erst.c                           |    2 +-
 drivers/acpi/sbshc.c                               |    4 +-
 drivers/base/isa.c                                 |   10 +-
 drivers/crypto/n2_core.c                           |    3 +
 drivers/dma/dma-jz4740.c                           |    4 +-
 drivers/dma/dmatest.c                              |   54 +-
 drivers/firmware/efi/efi.c                         |    3 +-
 drivers/firmware/efi/runtime-map.c                 |   10 +-
 drivers/gpu/drm/i915/intel_i2c.c                   |    4 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |   21 +-
 drivers/i2c/i2c-core.c                             |   17 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |    6 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   25 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |    5 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |    3 +-
 drivers/input/misc/twl4030-vibra.c                 |    7 +-
 drivers/input/misc/twl6040-vibra.c                 |    2 +-
 drivers/input/mouse/elantech.c                     |    2 +-
 drivers/input/mouse/trackpoint.c                   |    7 +-
 drivers/input/touchscreen/88pm860x-ts.c            |   16 +-
 drivers/iommu/intel-iommu.c                        |    8 +-
 drivers/md/bcache/request.c                        |   13 +-
 drivers/md/dm-cache-target.c                       |   12 +-
 drivers/md/dm-mpath.c                              |   34 +-
 drivers/md/dm-snap.c                               |   48 +-
 drivers/md/dm-thin-metadata.c                      |    6 +-
 drivers/md/dm-thin.c                               |   22 +-
 drivers/md/persistent-data/dm-btree.c              |   19 +-
 drivers/media/i2c/adv7604.c                        |    6 +-
 drivers/media/usb/dvb-usb/dibusb-common.c          |   16 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      | 1025 ++++++++++++--------
 drivers/media/v4l2-core/v4l2-ioctl.c               |    5 +-
 drivers/media/v4l2-core/videobuf2-core.c           |    5 +
 drivers/mfd/cros_ec_spi.c                          |    4 +
 drivers/mfd/twl4030-audio.c                        |    9 +-
 drivers/mfd/twl6040.c                              |   12 +-
 drivers/misc/eeprom/at24.c                         |    6 +
 drivers/mmc/host/s3cmci.c                          |    6 +-
 drivers/net/can/ti_hecc.c                          |    3 +
 drivers/net/can/usb/ems_usb.c                      |    2 +
 drivers/net/can/usb/esd_usb2.c                     |    2 +
 drivers/net/can/usb/gs_usb.c                       |    2 +-
 drivers/net/can/usb/kvaser_usb.c                   |   13 +-
 drivers/net/can/usb/usb_8dev.c                     |    2 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    2 +-
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |   16 +-
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |    1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   11 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |   11 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    2 +-
 drivers/net/ethernet/marvell/mvmdio.c              |    3 +-
 drivers/net/ethernet/marvell/mvneta.c              |    4 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   17 +-
 drivers/net/ethernet/renesas/sh_eth.c              |   33 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    6 +
 drivers/net/phy/marvell.c                          |    2 +-
 drivers/net/phy/mdio-sun4i.c                       |    6 +-
 drivers/net/ppp/pppoe.c                            |   11 +-
 drivers/net/wireless/mac80211_hwsim.c              |   14 +-
 drivers/of/fdt.c                                   |    2 +-
 drivers/parisc/lba_pci.c                           |   33 +
 drivers/pci/pci-driver.c                           |    7 +-
 drivers/scsi/scsi_lib.c                            |   10 +-
 drivers/staging/usbip/stub_dev.c                   |    3 +-
 drivers/staging/usbip/stub_main.c                  |    5 +-
 drivers/staging/usbip/stub_rx.c                    |    7 +-
 drivers/staging/usbip/stub_tx.c                    |    4 +-
 drivers/staging/usbip/usbip_common.c               |   31 +-
 drivers/staging/usbip/userspace/src/utils.c        |    9 +-
 drivers/staging/usbip/vhci_hcd.c                   |   12 +-
 drivers/staging/usbip/vhci_rx.c                    |   23 +-
 drivers/staging/usbip/vhci_tx.c                    |    3 +-
 drivers/tty/n_tty.c                                |    4 +-
 drivers/tty/serial/8250/8250_pci.c                 |    3 +
 drivers/usb/core/config.c                          |   16 +-
 drivers/usb/core/devio.c                           |   14 +-
 drivers/usb/core/hub.c                             |    9 +
 drivers/usb/core/quirks.c                          |    9 +-
 drivers/usb/gadget/composite.c                     |    7 +-
 drivers/usb/gadget/udc-core.c                      |   32 +-
 drivers/usb/host/ehci-dbg.c                        |    2 +-
 drivers/usb/host/xhci-mem.c                        |   24 +-
 drivers/usb/host/xhci-pci.c                        |    3 +
 drivers/usb/host/xhci-ring.c                       |   12 +-
 drivers/usb/misc/usb3503.c                         |    2 +
 drivers/usb/mon/mon_bin.c                          |    8 +-
 drivers/usb/musb/da8xx.c                           |   10 +-
 drivers/usb/serial/cp210x.c                        |    2 +
 drivers/usb/serial/ftdi_sio.c                      |    1 +
 drivers/usb/serial/ftdi_sio_ids.h                  |    6 +
 drivers/usb/serial/option.c                        |   20 +
 drivers/usb/storage/uas-detect.h                   |    4 +
 drivers/usb/storage/unusual_devs.h                 |    7 +
 drivers/usb/storage/unusual_uas.h                  |   14 +
 drivers/virtio/virtio.c                            |    2 +
 fs/btrfs/disk-io.c                                 |    9 +-
 fs/btrfs/extent-tree.c                             |   15 +-
 fs/btrfs/ioctl.c                                   |    2 +-
 fs/ext4/extents.c                                  |    1 +
 fs/ext4/namei.c                                    |    4 +
 fs/nfsd/auth.c                                     |    3 +
 fs/quota/dquot.c                                   |    3 +-
 include/asm-generic/dma-mapping-broken.h           |    3 -
 include/linux/blkdev.h                             |    6 +
 include/linux/cred.h                               |    1 +
 include/linux/dma-mapping.h                        |    2 -
 include/linux/fscache.h                            |    2 +-
 include/linux/mlx5/driver.h                        |    2 +-
 include/linux/phy.h                                |   21 +
 include/linux/sh_eth.h                             |    1 -
 include/linux/stddef.h                             |   15 +-
 include/linux/sysfs.h                              |    6 +
 include/linux/vfio.h                               |   13 -
 include/net/cfg80211.h                             |    2 +
 include/net/red.h                                  |   13 +-
 include/net/sctp/checksum.h                        |   13 +-
 include/net/xfrm.h                                 |    1 +
 include/scsi/libsas.h                              |    2 +-
 include/uapi/linux/usb/ch9.h                       |    2 +
 kernel/acct.c                                      |    2 +-
 kernel/debug/kdb/kdb_io.c                          |    2 +-
 kernel/futex.c                                     |    3 +
 kernel/groups.c                                    |    5 +-
 kernel/hrtimer.c                                   |    2 +
 kernel/posix-timers.c                              |   37 +-
 kernel/time/tick-sched.c                           |   19 +-
 kernel/trace/blktrace.c                            |    4 +-
 kernel/trace/ring_buffer.c                         |    6 +-
 kernel/trace/trace.c                               |    3 +
 kernel/uid16.c                                     |    1 +
 lib/asn1_decoder.c                                 |   45 +-
 lib/oid_registry.c                                 |   16 +-
 mm/mprotect.c                                      |    6 +-
 net/8021q/vlan.c                                   |    7 +-
 net/batman-adv/bat_iv_ogm.c                        |    4 +-
 net/bridge/br_netlink.c                            |    7 +-
 net/can/af_can.c                                   |   22 +-
 net/dccp/ccids/ccid2.c                             |    3 +
 net/ipv4/esp4.c                                    |    1 +
 net/ipv4/igmp.c                                    |   20 +-
 net/ipv4/raw.c                                     |  121 ++-
 net/ipv4/tcp_ipv4.c                                |    2 +-
 net/ipv4/xfrm4_input.c                             |   11 +-
 net/ipv6/esp6.c                                    |    3 +-
 net/ipv6/tcp_ipv6.c                                |    2 +-
 net/ipv6/xfrm6_input.c                             |    9 +-
 net/key/af_key.c                                   |    8 +
 net/netfilter/xt_bpf.c                             |    6 +-
 net/packet/af_packet.c                             |    5 +
 net/rds/rdma.c                                     |    2 +-
 net/sched/sch_choke.c                              |    3 +
 net/sched/sch_gred.c                               |    3 +
 net/sched/sch_red.c                                |    2 +
 net/sched/sch_sfq.c                                |    3 +
 net/sctp/socket.c                                  |   31 +-
 net/sunrpc/auth_gss/gss_rpc_xdr.c                  |    1 +
 net/sunrpc/auth_gss/svcauth_gss.c                  |    1 +
 net/sunrpc/svcauth_unix.c                          |    2 +
 net/wireless/core.c                                |    7 +-
 net/wireless/core.h                                |    2 -
 net/wireless/nl80211.c                             |   15 +-
 net/wireless/wext-compat.c                         |    3 +-
 net/xfrm/xfrm_input.c                              |   56 ++
 sound/core/oss/pcm_oss.c                           |   41 +-
 sound/core/oss/pcm_plugin.c                        |   14 +-
 sound/core/pcm.c                                   |    2 +
 sound/core/pcm_lib.c                               |    5 +-
 sound/core/rawmidi.c                               |   15 +-
 sound/core/seq/seq_clientmgr.c                     |   15 +-
 sound/core/seq/seq_timer.c                         |    2 +-
 sound/drivers/aloop.c                              |   98 +-
 sound/pci/hda/patch_cirrus.c                       |    1 +
 sound/pci/hda/patch_conexant.c                     |   29 +
 sound/soc/codecs/twl4030.c                         |    4 +-
 sound/soc/codecs/wm_adsp.c                         |   29 +-
 sound/soc/fsl/fsl_ssi.c                            |   17 +-
 sound/usb/mixer.c                                  |   26 +-
 tools/hv/hv_kvp_daemon.c                           |   70 +-
 223 files changed, 2532 insertions(+), 1264 deletions(-)

-- 
Ben Hutchings
If the facts do not conform to your theory, they must be disposed of.
