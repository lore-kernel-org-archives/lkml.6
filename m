Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3445306-1517483314-2-8894574023887429910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517483310; b=Oi3N82XakrU49p6heiRw5KsUHkLL9A58vCkQltJg94q/RYx
    mrqxOxIWCmJrWL5vy+bp2bcMTqWltdBqh4Kv+ALz636IyJVp0BG6f+Z/U4ar78f1
    VN2pRThy73/G+7NaRom3dBVMz/Oduzof1/AnmrEUUnZ0MmirRqYyQj88qDCDwDRV
    Lph768iP/XQmO147sCqXX9b0awxDtXRcbc5sWhmcHWpr8maLpSi3jcuGhyKDxVVU
    X7ACgsQ6pokGZOjDYbUNWEX2dt1pW792up03GBze0MI+iw6NG49UjUHqCxKh2/DU
    DEpvxCY2CazDNmJkEe8ysHbabgZT3PAEUdhOr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517483310; bh=l
    kWlilQgmREXL0/SeFHdZoWG1u2SDph18Lvgldv0gqA=; b=uFm8lOB/mMycWp4i3
    wUDFyUor6grEAflPYUnmFiC6/iUjniyrefDdbabCFvwqNu/+5a1tBAU84Gg8z3Uv
    uEmFvmKZZTKfh/fW27uWyaYlzhQDJRuVipDYqUlOz/8gyHBwTyJwCq41dtj6gQ8l
    5FqUWrMUtIyKjcjcpDW2K6KBA81sqshMzKXyUmlH+1yaEmegf1+VhRpAIYohSrEc
    tooUvcya/+rx+6REQkoCqL48M9w/OuETopeC1S6K/eVrBWe4G2eC/30gQkAhiGm6
    5cW1Ouwshyx8hr8Ue5JNfIetMCTO6bJgvGLr/VRtK6kZ2IRdXD5ER6sS3BCYIuaL
    L/X5g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 1 Feb 2018 12:08:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT PULL] Staging/IIO update for 4.16-rc1
Message-ID: <20180201110805.GA28965@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/ tags/st=
aging-4.16-rc1

for you to fetch changes up to 3384e01179eff2b2fe91ba7bcad98ee2be5f87f7:

  staging: rtlwifi: remove redundant initialization of 'cfg_cmd' (2018-01-2=
6 15:08:43 +0100)

----------------------------------------------------------------
Staging/IIO patches for 4.16-rc1

Here is the big Staging and IIO driver patches for 4.16-rc1.

There is the normal amount of new IIO drivers added, like all releases.

The networking IPX and the ncpfs filesystem are moved into the staging
tree, as they are on their way out of the kernel due to lack of use
anymore.

The visorbus subsystem finall has started moving out of the staging tree
to the "real" part of the kernel, and the most and fsl-mc codebases are
almost ready to move out, that will probably happen for 4.17-rc1 if all
goes well.

Other than that, there is a bunch of license header cleanups in the
tree, along with the normal amount of coding style churn that we all
know and love for this codebase.  I also got frustrated at the
Meltdown/Spectre mess and took it out on the dgnc tty driver, deleting
huge chunks of it that were never even being used.

Full details of everything is in the shortlog.

All of these patches have been in linux-next for a while with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abdul Rauf (1):
      staging: rtl8192u: ieee80211: ieee80211_rx.c fix checkpatch space pro=
hibited before that '++'

Aishwarya Pant (1):
      staging: iio: trigger: blackfin timer: replace device_attr with devic=
e_attr_rw

Ajay Singh (22):
      staging: wilc1000: removed typedef from enum BSSTYPE_T
      staging: wilc1000: remove unnecessary typedef enum G_OPERATING_MODE_T
      staging: wilc1000: removed enums typedef for BEACON_IE & TX_RATE_T
      staging: wilc1000: removed enum typedef CHIP_PS_STATE_T
      staging: wilc1000: removed enum typedef BUS_ACQUIRE_T
      staging: wilc1000: removed enum typedef BUS_RELEASE_T
      staging: wilc1000: rename elements of wilc_priv struct to avoid using=
 camelCase
      staging: wilc1000: rename wilc_wfi_p2pListenParams struct and its mem=
ber variable
      staging: wilc1000: rename au8Sta_AssociatedBss element sta_info struc=
ture
      staging: wilc1000: remove unused element in wilc_wfi_p2p_listen_param=
s struct
      staging: wilc1000: rename s32Error variable to avoid camelCase notati=
on
      staging: wilc1000: rename CfgConnectResult() and its local variable n=
ames
      staging: wilc1000: rename camelCase used in functions start with WILC=
_WFI_Cfg
      staging: wilc1000: rename pstrWFIDrv to wfi_drv to avoid camelCase na=
ming
      staging: wilc1000: rename NullBssid to null_bssid to avoid camelCase =
variable name
      staging: wilc1000: rename variables using camelCase in add_key()
      staging: wilc1000: rename strStaParams variable to avoid camelCase
      staging: wilc1000: rename pstrCfgParamVal varaible in set_wiphy_param=
s()
      staging: wilc1000: rename strStatistics & tenuAuth_type to avoid came=
lCase
      staging: wilc1000: remove unnecessary use of parentheses
      staging: wilc1000: removed unnecessary defined enums typedef
      staging: wilc1000: fix alignments to match open parenthesis

Akash Kumar (1):
      Staging: rtl8192u: Fix no spaces around '+'

Alexander Kapshuk (1):
      vboxvideo: Fix incorrect type in assignment sparse warning

Aliaksei Karaliou (5):
      drivers: lustre: osc: check result of register_shrinker()
      drivers: lustre: ptlrpc: check result of register_shrinker()
      drivers: lustre: ldlm: check result of register_shrinker()
      drivers: lustre: obdclass: check result of register_shrinker()
      drivers: lustre: obdclass: simplify unregister_shrinker() usage

Andreas Klinger (2):
      iio: hx711: add triggered buffer support
      iio: hx711: fix bug in reset functionality

Andrew F. Davis (1):
      iio: dac: mcp4725: Remove unneeded conversions to bool

Andrey Shvetsov (2):
      staging: most: update driver usage file
      staging: most: core: fix list traversing

Andrii (1):
      staging: lustre: Fix sparse, using plain integer as NULL pointer in l=
ov_object_fiemap()

Andy Pusch (1):
      Staging: wlan-ng: hfa384x_usb: fixed two line limit coding style issu=
es

Andy Shevchenko (3):
      iio: proximity: sx9500: Add another ACPI ID
      iio: magnetometer: ak8975: Add another ACPI ID
      iio: imu: inv_mpu6050: Remove duplicate NULL check

Arnd Bergmann (6):
      staging: rtlwifi: rtlwifi: use ktime_get_real_seconds() for suspend t=
ime
      staging: bcm2835-camera use ktime_t for timestamps
      staging: imx: use ktime_t for timestamps
      iio: common: ssp_sensors: use ktime_get_real_ns() timestamps
      staging: ccree: mark debug_regs[] as static
      staging: lustre: lnet: avoid uninitialized return value

Arvind Yadav (4):
      staging: lustre: ldlm: Remove a attribute group from a kobject
      staging: lustre: obdclass: Remove a attribute group from a kobject
      staging: ccree: Remove a attribute group from a kobject
      iio: trigger: Fix platform_get_irq's error checking

Ashish Kalra (3):
      staging: android: Fix checkpatch.pl error
      staging: android: add identifiers to function parameters
      staging: dgnc: add identifiers to function parameters

Bartosz Golaszewski (1):
      iio: dummy_evgen: modify the return value check for irq_sim_init()

Benjamin Gaignard (2):
      staging: ion: reorder include
      iio: stm32: Adopt SPDX identifier

Bharat Bhushan (1):
      staging: fsl-mc: use 32bits to support 64K size mc-portals

Bogdan Purcareata (3):
      staging: fsl-mc: Cleanup dprc and dpmcp header files
      staging: fsl-mc: Consolidate bus core header files
      staging: fsl-mc: Add SPDX license identifiers

Christian Gromm (51):
      staging: most: move core files
      staging: most: cdev: rename module
      staging: most: i2c: rename module
      staging: most: dim2: rename module
      staging: most: net: rename module
      staging: most: sound: rename module
      staging: most: usb: rename module
      staging: most: video: rename module
      staging: most: remove proprietary kobjects
      staging: most: core: remove function get_channel_by_iface
      staging: most: core: add a match function for the bus
      staging: most: core: encapsulate code in function
      staging: most: core: rename structure
      staging: most: core: rename struct most_c_aim_obj to pipe
      staging: most: core: rename struct memeber
      staging: most: core: rename members aim* of struct most_channel
      staging: most: core: use structure to pack driver specific data
      staging: most: core: track aim modules with linked list
      staging: most: core: fix sysfs attribute management
      staging: most: core: remove struct device
      staging: most: core: rename function
      staging: most: core: replace struct most_inst_obj
      staging: most: core: put channel name in struct most_channel
      staging: most: core: remove context pointer
      staging: most: usb: remove pointer initialization
      staging: most: rename struct most_aim
      staging: most: rename functions to register a driver with most_core
      staging: most: core: rename mod_list
      staging: most: core: rename aim variables
      staging: most: core: rename function link_channel_to_aim
      staging: most: net: remove aim designators
      staging: most: sound: remove aim designator
      staging: most: video: remove aim designators
      staging: most: cdev: rename struct aim_channel
      staging: most: cdev: rename variable aim_devno
      staging: most: cdev: rename class instance aim_class
      staging: most: cdev: rename variable cdev_aim
      staging: most: fix comment sections
      staging: most: core: denote modules as components
      staging: most: core: fix formatting
      staging: most: usb: clear functional stall on OUT endpoint
      staging: most: core: fix data type
      staging: most: core: check value returned by match function
      staging: most: cdev: replace function prefix
      staging: most: cdev: bundle module variables in structure
      staging: most: core: remove class generation
      staging: most: add ABI documentation
      staging: most: usb: fix show/store function names
      staging: most: fix Makefile
      staging: most: remove legacy folders
      staging: most: make DEVICE_ATTR structures static

Christopher D=EDaz Riveros (1):
      staging: rtl8723bs: hal_com_phycfg: Remove unneeded semicolons

Colin Ian King (18):
      staging: ccree: fix incorrect indentation of break statement
      staging: rtlwifi: remove redundant assignments to ul_enc_algo
      staging: comedi: usbdux: remove redundant initialization of val
      staging: rtl8712: remove redundant zero assignment to val32
      staging: rtl8822be: fix missing null check on dev_alloc_skb return
      iio: accel: st_accel: remove redundant pointer pdata
      staging: most: core: make functions print_links and most_match static
      iio: light: make a couple of config structures static
      ncpfs: remove redundant cast of struct ncp_inode_info
      staging: ccree: fix memory leaks in cc_ivgen_init
      staging: fsl-mc: make function its_fsl_mc_msi_init static
      staging: rtl8712: remove redundant initialization to 'rfPath'
      staging: rtl8192e: remove two redundant assignments
      staging: rtl8192u: remove redundant initialization of 'timeout'
      staging: comedi: dt2811: remove redundant initialization of 'ns'
      staging: rtl8188eu: remove redundant initialization of 'pwrcfgcmd'
      staging: rtl8723bs: remove a couple of redundant initializations
      staging: rtlwifi: remove redundant initialization of 'cfg_cmd'

Corentin Labbe (2):
      staging: fbtft: remove unused FB_TFT_SSD1325 kconfig
      staging: rtlwifi: remove unused RTLHALMAC_ST and RTLPHYDM_ST

Dan Carpenter (4):
      staging: ccree: cleanup a small white space issue
      staging: ccree: don't break lines unnecessarily
      staging: lustre: libcfs: Prevent harmless read underflow
      staging: rts5208: Fix "seg_no" calculation in reset_ms_card()

Daniel Vetter (1):
      staging/sm750fb: Add "port to atomic kms" to TODO

David Kershner (5):
      staging: unisys: fix dependencies with UNISYSSPAR Kconfig flag
      staging: unisys: remove !UML flag
      staging: unisys: combine visorchannel.h and visorbus.h
      staging: unisys: move dependencies from UNISYSSPAR to VISORBUS
      drivers: visorbus: move driver out of staging

Derek Robson (1):
      Staging: pi433 - fix ccheckpatch issue, updated include line.

Dmitry Eremin (1):
      staging: lustre: separate a connection destroy from free struct kib_c=
onn

Eugen Hristev (3):
      dt-bindings: iio: at91-sama5d2_adc: add optional dma property
      iio: adc: at91-sama5d2_adc: add support for DMA
      iio: adc: at91-sama5d2_adc: ack DRDY irq in direct mode

Eujon Sellers (1):
      staging: comedi: reformat lines to 80 chars or less

Fabian Huegel (7):
      staging: lustre: Enclose complex macros in do-while loops
      staging: lustre: Remove DECLARE_LU_VARS macro
      staging: lustre: Add identifier names to function declarations
      staging: lustre: Fix overlong lines
      staging: lustre: Align backslashes in multi-line macros
      staging: lustre: Fix comment style
      staging: lustre: Align struct member identifiers

Fabrice Gasnier (4):
      dt-bindings: iio: adc: stm32: add support for diff channels
      iio: adc: stm32: remove const channel names definition
      iio: adc: stm32: add support for differential channels
      iio: adc: stm32: fix scan of multiple channels with DMA

Gabriel L. Somlo (1):
      staging: typec: fix endianness mismatch identified by sparse

Genki Sky (3):
      staging: vc04_services: Join multiline dereferences
      staging: vc04_services: Unsplit user-visible strings
      staging: vc04_services: Use __func__

George Edward Bulmer (2):
      staging: iio: light: Add breaks to lengthy lines
      staging: most: convert macro to static function

Gilad Ben-Yossef (107):
      staging: ccree: make long func call sites readable
      staging: ccree: simplify AEAD using local var
      staging: ccree: simplify buf mgr using local vars
      staging: ccree: fold common code into function
      staging: ccree: simplify pm manager using local var
      staging: ccree: remove unneeded cast
      staging: ccree: remove compare to none zero
      staging: ccree: remove braces for single statement
      staging: ccree: remove unused cc_base parameter
      staging: ccree: fix typos
      staging: ccree: alloc by instance not type
      staging: ccree: remove unnecessary parentheses
      staging: ccree: remove MIN/MAX macros
      staging: ccree: move logical cont. to 1st line
      staging: ccree: remove unneeded empty lines
      staging: ccree: remove unneeded cast
      staging: ccree: make mem barrier per request
      staging: ccree: replace open coded loop with for
      staging: ccree: document spinlock usage
      staging: ccree: constify help string
      staging: ccree: fix code indent
      staging: ccree: Replace CONFIG_PM_RUNTIME with CONFIG_PM
      staging: ccree: replace macro with inline func
      staging: ccree: trim long lines for readability
      staging: ccree: remove dead defs and decls
      staging: ccree: refactor code with local vars
      staging: ccree: rename func for readability
      staging: ccree: rename long define for readability
      staging: ccree: remove unneeded wrapper function
      staging: ccree: remove unused field
      staging: ccree: replace msleep with a completion
      staging: ccree: use local vars for readability
      staging: ccree: drop unused macro
      staging: ccree: remove inline qualifiers
      staging: ccree: remove unproven likely/unlikely
      staging: ccree: remove more unnecessary parentheses
      staging: ccree: fix indentation of var assignment
      staging: ccree: remove braces for single statement blocks
      staging: ccree: remove interim DT docs
      staging: ccree: update TODO list
      staging: ccree: NULLify backup_info when unused
      staging: ccree: fix AEAD func naming convention
      staging: ccree: amend aead func def for readability
      staging: ccree: remove ahash wrappers
      staging: ccree: fix hash naming convention
      staging: ccree: amend hash func def for readability
      staging: ccree: func params should follow func name
      staging: ccree: shorten parameter name
      staging: ccree: fix func def and decl coding style
      staging: ccree: simplify expression with local var
      staging: ccree: fix func call param indentation
      staging: ccree: fix reg mgr naming convention
      staging: ccree: fix req mgr func def coding style
      staging: ccree: remove cipher sync blkcipher remains
      staging: ccree: fix cipher naming convention
      staging: ccree: fix cipher func def coding style
      staging: ccree: fix ivgen naming convention
      staging: ccree: fix ivgen func def coding style
      staging: ccree: drop unsupported MULTI2 mode code
      staging: ccree: remove SSI_CC_HAS_ macros
      staging: ccree: rename all SSI to CC
      staging: ccree: rename all DX to CC
      staging: ccree: rename vars/structs/enums from ssi_ to cc_
      staging: ccree: fix buf mgr naming convention
      staging: ccree: fix sram mgr naming convention
      staging: ccree: simplify freeing SRAM memory address
      staging: ccree: fix FIPS mgr naming convention
      staging: ccree: drop ifdef CONFIG_OF in code
      staging: ccree: clean up PM registration
      staging: ccree: add explicit module init/exit func
      staging: ccree: staging: ccree: replace sysfs by debugfs interface
      staging: ccree: remove CC_IRQ_DELAY dead code
      staging: ccree: remove useless debug code
      staging: ccree: turn compile time debug log to params
      staging: ccree: remove ssi_config.h
      staging: ccree: fix fips event irq handling build
      staging: ccree: update TODO
      staging: ccree: use size_t consistently
      staging: ccree: SPDXify driver
      staging: ccree: fold hash defs into queue defs
      staging: ccree: fold reg common defines into driver
      staging: ccree: remove GFP_DMA flag from mem allocs
      staging: ccree: pick alloc mem flags based on req flags
      staging: ccree: copy larval digest from RAM
      staging: ccree: tag debugfs init/exit func properly
      staging: ccree: remove unused leftover field
      staging: ccree: break send_request and fix ret val
      staging: ccree: add backlog processing
      stating: ccree: revert "staging: ccree: fix leak of import() after in=
it()"
      staging: ccree: failing the suspend is not an error
      staging: ccree: check DMA pool buf !NULL before free
      staging: ccree: handle end of sg list gracefully
      staging: ccree: use Makefile to include PM code
      staging: ccree: remove unused field
      staging: ccree: use array for double buffer
      staging: ccree: allocate hash bufs inside req ctx
      staging: ccree: do not map bufs in ahash_init
      staging: ccree: fix indentation of func params
      staging: ccree: fold common code into service func
      staging: ccree: put pointer next to var name
      stating: ccree: fix allocation of void sized buf
      staging: ccree: update TODO
      staging: ccree: use a consistent file naming convention
      staging: ccree: remove unneeded includes
      staging: ccree: add missing include
      staging: ccree: make stub function static inline
      staging: ccree: dma mask is type u64

Greg Kroah-Hartman (64):
      staging: most: add SPDX identifiers to all most driver files
      staging: most: Remove redundant license text
      staging: fsl-mc-bus: fix build warning
      staging: comedi: add SPDX identifiers to all greybus driver files
      staging: comedi: drivers: Remove redundant license text
      staging: comedi: Remove redundant license text
      staging: unisys: add SPDX identifiers to all unisys driver files
      staging: unisys: fix up some SPDX tags
      staging: unisys: Remove redundant license text
      staging: xgifb: add SPDX identifiers to the remaining holdout file
      staging: wilc1000: add SPDX identifiers to all wilc100 files
      staging: wlan-ng: add SPDX identifiers to all wlan-ng driver files
      staging: vt6656: add SPDX identifiers to all vt6656 driver files
      staging: vt6655: add SPDX identifiers to all vt6655 driver files
      staging: android: add SPDX identifiers to all android driver files
      staging: vt6656: Remove redundant license text
      staging: vt6655: Remove redundant license text
      staging: android: Remove redundant license text
      Merge tag 'iio-for-4.16a' of git://git.kernel.org/.../jic23/iio into =
staging-next
      Merge Linus's staging merge point into staging-next
      Merge 4.15-rc4 into staging-next
      Merge 4.15-rc6 into staging-next
      staging: vme: vme_user: add SPDX identifier.
      staging: vme: vme_user.c: remove redundant license text
      staging: typec: add SPDX identifier.
      staging: typec: remove redundant license text
      staging: vc04_services: bcm2835-audio: add SPDX identifiers
      staging: vc04_services: bcm2835-audio: remove redundant license text
      staging: vc04_services: bcm2835-camera: add SPDX identifiers
      staging: vc04_services: bcm2835-camera: remove redundant license text
      staging: speakup: add SPDX identifier.
      staging: speakup: remove redundant license text
      staging: nvec: add SPDX identifier.
      staging: nvec: remove redundant license text
      staging: octeon: add SPDX identifiers.
      staging: octeon: remove redundant license text
      staging: fwserial: add SPDX identifier.
      staging: fwserial: remove redundant license text
      staging: dgnc: add SPDX identifier.
      staging: dgnc: remove redundant license text
      staging: clocking-wizard: add SPDX identifier.
      staging: clocking-wizard: remove redundant license text
      staging: emxx_udc: add SPDX identifier.
      staging: emxx_udc: remove redundant license text
      staging: fbtft: add SPDX identifiers
      staging: fbtft: remove redundant license text
      staging: dgnc: delete dgnc_utils.c
      staging: dgnc: remove crazy "management" device node
      staging: dgnc: make dgnc_num_boards static
      staging: dgnc: make dgnc_poll_lock static
      staging: dgnc: remove some global variables
      staging: dgnc: make dgnc_poll_tick static
      staging: dgnc: remove duplicated tty defines
      staging: lustre: lnet: fix build warning in module.c
      staging: dgnc: remove PCI_DEVICE_NEO stuff
      staging: dgnc: delete dgnc_neo.* files
      staging: dgnc: delete dgnc_pci.h
      staging: dgnc: delete dpatype board type variable.
      staging: dgnc: delete dpastatus board type variable.
      staging: dgnc: delete is_pci_express board type variable.
      staging: dgnc: delete a bunch of PCI board variables
      staging: dgnc: delete serial_num board variable
      staging: dgnc: remove "vpd" board variable
      staging: dgnc: drop unused neo_uart_struct

Gustavo A. R. Silva (2):
      staging: speakup: selection: replace _manual_ swap with swap macro
      iio: core: Mark expected switch fall-through

Harinath Nampally (2):
      iio: accel: mma8452: Rename a struct for code readibility
      iio: accel: mma8452: Rename config structs for readability

Ioana Radulescu (15):
      staging: fsl-dpaa2/eth: Fix access to FAS field
      staging: fsl-dpaa2/eth: Don't set netdev->needed_headroom
      staging: fsl-dpaa2/eth: Add counter for skb reallocs
      staging: fsl-dpaa2/eth: Don't enable FAS on Tx
      staging: fsl-dpaa2/eth: Compute needed headroom per frame
      staging: fsl-dpaa2/eth: Make Tx buffer alignment optional
      staging: fsl-dpaa2/eth: Flow affinity for IP forwarding
      staging: fsl-dpaa2/eth: Flow affinity for non-forwarded traffic
      staging: fsl-mc/dpio: Add dpaa2_io_service_select() API
      staging: fsl-dpaa2/eth: Use affine DPIO services
      staging: fsl-mc: Remove dead code
      staging: fsl-mc: Remove unnecessary dependency
      staging: fsl-mc: Update include header
      staging: fsl-mc: README cleanup
      staging: fsl-mc: Convert documentation to rst format

Javier Martinez Canillas (1):
      iio: accel: bmc150: Add OF device ID table

Ji-Hun Kim (1):
      staging: iio: remove unnecessary parentheses

Jia-Ju Bai (3):
      rtl8188eu: Fix a possible sleep-in-atomic bug in set_tx_beacon_cmd
      staging: vt6655: Use GFP_KERNEL in kzalloc
      staging: rtl8192u: Replace mdelay with msleep in rtl8192_usb_probe

Joe Perches (1):
      MAINTAINERS: Mark some staging directories as "Obsolete"

Joel Stanley (1):
      iio: adc: aspeed: Deassert reset in probe

Joshua Abraham (2):
      staging: dgnc: Fix usleep_range is preferred over udelay
      staging: xgifb: remove macros with hidden variable

Julia Lawall (1):
      iio: common: ssp_sensors: account for const type of of_device_id.data

Kamal Heib (12):
      staging: greybus: arche-apb-ctrl.c: Fix alignment should match open p=
arenthesis
      staging: greybus: arche-platform.c: Fix alignment should match open p=
arenthesis
      Staging: ccree: Add blank line after declarations
      staging: greybus: authentication.c: Fix alignment should match open p=
arenthesis
      staging: greybus: audio_codec.c: Fix alignment should match open pare=
nthesis
      staging: greybus: audio_codec.c: Cleanup blank lines
      staging: greybus: audio_codec.c: Space required around ':'
      staging: greybus: audio_codec.c: Logical continuations should be on t=
he previous line
      staging: greybus: audio_codec.c: Prefer kernel type 'u32' over 'uint3=
2_t'
      staging: greybus: audio_codec.h: Prefer kernel type 'u32' over 'uint3=
2_t'
      staging: greybus: audio_codec.h Fix alignment should match open paren=
thesis
      staging: ccree: Fix missing blank line after declaration

Kari Argillander (1):
      staging: pi433: Fix disordered switch case

Kees Cook (1):
      staging/irda/net: Drop extraneous parentheses around test

Kenny Ballou (3):
      staging: xgifb: vb_table: fix whitespacing issues
      staging: xgifb: vb_setmode: fix long line warnings
      staging: xgifb: vb_setmode: brace style fixes

Kishore KP (2):
      staging: vc04_services: Fix platform_no_drv_owner.cocci warnings.
      staging: vc04_services: Prefer WARN_ON_ONCE instead of if condition f=
ollowed by BUG.

Laura Abbott (2):
      staging: android: ion: Add __GFP_NOWARN for system contig heap
      staging: android: ion: Switch from WARN to pr_warn

Laurentiu Tudor (10):
      staging: fsl-mc: drop unused dpcon APIs
      staging: fsl-mc/dpio: remove incomplete refcount implementation
      staging: fsl-mc/dpio: drop EXPORT_SYMBOL() for a few functions
      staging: fsl-mc/dpio: remove couple of unused functions
      staging: fsl-mc: consistently use EXPORT_SYMBOL_GPL()
      staging: fsl-mc/dpio: change to use EXPORT_SYMBOL_GPL()
      staging: fsl-mc: remove some superfluous WARN_ONs
      staging: fsl-mc: remove debug WARN_ONs doubling error checks
      staging: fsl-mc: add support for device type
      staging: fsl-mc: use device_type instead of strcmp()

Linus Walleij (2):
      iio: adc/accel: Fix up module licenses
      iio: ABI: Fix name of timestamp sysfs file

Lorenzo Bianconi (8):
      iio: light: add support for UVIS25 sensor
      dt-bindings: iio: light: add UVIS25 device bindings
      iio: humidity: hts221: move common code in hts221_core
      iio: imu: st_lsm6dsx: fix endianness in st_lsm6dsx_read_oneshot()
      iio: imu: st_lsm6dsx: introduce conf_lock mutex
      iio: imu: st_lsm6dsx: add regmap API support
      iio: imu: st_lsm6dsx: pre-allocate read buffer at bootstrap
      iio: imu: st_lsm6dsx: remove st_lsm6dsx_write_with_mask() declaration

Luca S=F6the (1):
      staging: pi433: Fixed coding style issues with braces

Luis Gerhorst (3):
      drivers/fbtft: Remove newline after else in else-if
      drivers/fbtft: Remove unnecessary braces from if/else
      staging: fbtft: Fix indentation

Luis de Bethencourt (6):
      staging: lustre: llite: Remove else after goto
      staging: lustre: llite: Remove redundant else keyword
      staging: lustre: llite: Remove redundant else keyword
      staging: rtl8723bs: Fix trailing semicolon
      staging: rtl8723bs: Fix trailing semicolon
      staging: rtl8723bs: Fix trailing semicolon

Lukas Wunner (2):
      MAINTAINERS: Add missing IIO ABI entries
      iio: Add macro to populate struct iio_map array

Luke Ross (1):
      iio:accel:da280: Linx 820 Windows tablet has a da280 mapped via ACPI

Maciej Purski (1):
      iio: adc: ina2xx: Make calibration register value fixed

Marcelo Guzm=E1n Lamperti (1):
      staging: sm750fb: Remove multiple blank lines

Marcin Ciupak (13):
      staging: pi433: fix (NULL device *) in log message
      staging: pi433: fix naming when more than one radio is used
      staging: pi433: Fix missing 'undefined' value in enum modulation
      staging: pi433: Fix validation of rf69_get_modulation value
      staging: pi433: make local functions static
      staging: pi433: remove unused rf69_get_payload_length function
      staging: pi433: remove unused rf69_set_rssi_timeout function
      staging: pi433: remove unused rf69_set_rx_start_timeout function
      staging: pi433: remove unused rf69_set_ook_threshold_step function
      staging: pi433: remove unused rf69_set_ook_threshold_type function
      staging: pi433: remove unused rf69_set_dc_cut_off_frequency* functions
      staging: pi433: remove unused rf69_set_sync_tolerance function
      staging: pi433: remove unused rf69_reset_flag function

Marcus Wolf (2):
      staging: pi433: rf69.c: Replace macros READ_REG and WRITE_REG with sm=
arter functions
      Staging: Pi433: Bugfix for wrong argument for sizeof() in TX thread

Markus Elfring (2):
      staging: iio: ad7152: Improve unlocking of a mutex in ad7152_start_ca=
lib()
      staging: iio: ad7746: Improve unlocking of a mutex in ad7746_start_ca=
lib()

Martin Blumenstingl (2):
      iio: adc: meson-saradc: fix the clock frequency on Meson8 and Meson8b
      iio: adc: meson-saradc: program the channel muxes during initializati=
on

Martin Homuth (5):
      staging: rtl8712: style fix over 80 characters warnings
      staging: rtl8712: style fix indentation
      staging: rtl8712: style fix unneeded else
      staging: rtl8712: style fix returned error code
      staging: rtl8712: style fix multiple line dereferences

Martin Kepplinger (1):
      iio: mma8452: replace license description with SPDX specifier

Matt Fornero (1):
      iio: buffer: Expose data available

Michael Gebhard (1):
      staging: comedi: add identifiers to function parameters

Michael Panzlaff (1):
      staging: pi433: Cleanup codestyle, indent statements after case labels

Mikhail Shvetsov (3):
      staging: vchiq_arm: Remove useless comments.
      staging: vchiq_arm: Fixing code style of comments
      staging: vchiq_arm: Cleaning up codestyle warnings

Narcisa Ana Maria Vasile (1):
      iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels

Neil Singh (2):
      staging: rtl8712: Cleanup codestyle, break up long line
      staging: rtl8712: Cleanup codestyle, change spaces to tabs

NeilBrown (47):
      staging: lustre: ldlm: use list_first_entry in ldlm_lock
      staging: lustre: ldlm: use list_for_each_entry in ldlm_lock.c
      staging: lustre: simplfy lov_finish_set()
      staging: lustre: obdclass: simplify cl_lock_fini()
      staging: lustre: use list_last_entry to simplify fld_cache_shrink
      staging: lustre: ldlm: use list_for_each_entry in ldlm_extent_shift_k=
ms()
      staging: lustre: ldlm: use list_first_entry in ldlm_lockd.c
      staging: lustre: ldlm: minor list_entry improvements in ldlm_request.c
      staging: lustre: ldlm: use list_for_each_entry in ldlm_resource.c
      staging: lustre: lov: use list_for_each_entry in lov_obd.c
      staging: lustre: libcfs: simplify memory allocation.
      staging: lustre: libcfs: remove unused rounding functions.
      staging: lustre: libcfs: discard MKSTR() macro
      staging: lustre: libcfs: discard MAX_NUMERIC_VALUE
      staging: lustre: libcfs: discard KLASSERT()
      staging: lustre: libcfs: discard LASSERT_CHECKED
      staging: lustre: use strim instead of cfs_trimwhite.
      staging: lustre: disable preempt while sampling processor id.
      staging: lustre: obdclass: discard FS_NEEDS_DEV flag.
      staging: lustre: obdclass: remove pointless struct lustre_mount_data2
      staging: lustre: obdclass: remove vfsmount option from client_fill_su=
per
      staging: lustre: obd_mount: fix possible race with module unload.
      staging: lustre: libcfs: use a workqueue for rehash work.
      staging: lustre: libcfs: remove wi_data from cfs_workitem
      staging: lustre: replace cfs_rand() with prandom_u32_max()
      staging: lustre: replace cfs_srand() calls with add_device_randomness=
().
      staging: lustre: replace cfs_get_random_bytes calls with get_random_b=
yte()
      staging: lustre: libcfs: remove prng
      staging: lustre: lnet-lib: opencode some alloc/free functions.
      staging: lustre: lnet: discard CFS_ALLOC_PTR
      staging: lustre: replace simple cases of LIBCFS_ALLOC with kzalloc.
      staging: lustre: lnet: switch to cpumask_var_t
      staging: lustre: lnet: selftest: don't allocate small strings.
      staging: lustre: lnet: use kmalloc/kvmalloc in router_proc
      staging: lustre: change some LIBCFS_ALLOC calls to k?alloc(GFP_KERNEL)
      staging: lustre: Convert more LIBCFS_ALLOC allocation to direct GFP_K=
ERNEL
      staging: lustre: more LIBCFS_ALLOC conversions to GFP_KERNEL allocati=
ons.
      staging: lustre: more conversions to GFP_KERNEL allocations.
      staging: lustre: lnet-route: use kmalloc for small allocation
      staging: lustre: use kmalloc for allocating ksock_tx
      staging: lustre: cfs_percpt_alloc: use kvmalloc(GFP_KERNEL)
      staging: lustre: opencode LIBCFS_ALLOC_ATOMIC calls.
      staging: lustre: replace LIBCFS_CPT_ALLOC()
      staging: lustre: remove LIBCFS_ALLOC, LIBCFS_FREE and related macros.
      staging: lustre: lnet: convert selftest to use workqueues
      staging: lustre: libcfs: remove workitem code.
      staging: lustre: lnet/selftest: fix compile error on UP build

Nguyen Phan Quang Minh (1):
      staging: pi433: pi433_if.c remove SET_CHECKED macro

Nipun Gupta (2):
      staging: fsl-mc: Allocate IRQ's before scanning DPRC objects
      staging: fsl-mc: do not print error in case of defer probe error

Oliver Graute (3):
      staging: pi433: pi433_if.c fix codestyle on two long lines
      staging: pi433: pi433_if.c codestyle fix
      staging: pi433: pi433_write fixed the return value

Paolo Cretaro (1):
      iio: cros_ec: Remove unused variables

Peter Meerwald-Stadler (14):
      iio: light: Add driver for IDT ZOPT2201 ambient light and UVB sensor
      Documentation: iio: Fix typo
      iio: health: max30102: Fix missing newline in dev_err
      iio: health: max30102: Remove inconsistent full stop in error message
      iio: health: max30102: Fix mode config values
      iio: health: max30102: Check retval of powermode function
      iio: health: max30102: Add check for part ID
      iio: health: max30102: Introduce intensity channel macro
      iio: health: max30102: Add power enable parameter to get_temp function
      iio: health: max30102: Introduce indices for LED channels
      iio: health: max30102: Move mode setting to buffer_postenable
      iio: health: max30102: Prepare for copying varying number of measurem=
ents
      iio: health: max30102: Add MAX30105 support
      dt-bindings: iio: health: Add MAX30105 support to max30102.txt

Petr Sedlak (1):
      staging: sm750fb: fix CamelCase for dispSet var

Philippe Loctaux (1):
      Staging: vme: vme_user: fixed an alignment coding style issue

Pravin Shedge (2):
      drivers: staging: remove duplicate includes
      drivers: iio: gyro: remove duplicate includes

Randy Dunlap (1):
      staging: ipx: depends on NET

Ravi Eluri (2):
      staging: most: Avoid trailing semicolon for macros
      staging: most: Fix identifiers to function parameters

Richard Sudaryono (1):
      staging: comedi: adv_pci1760: fix typo in comments

Rodrigo Zaiden (1):
      staging: wlan-ng: Fixing coding style warning

Roman Lakeev (1):
      staging: comedi: s626.c - fix multiline dereference

Roman Storozhenko (1):
      staging: lustre: Replace 'uint32_t' with 'u32' and 'uint64_t' with 'u=
64'

SUNIL KALLUR RAMEGOWDA (1):
      Staging: ks7010: ks_wlan_net: Fixing coding style warning

Shreeya Patel (7):
      Staging: rtl8723bs: Merge assignment with return
      Staging: rtl8723bs: Replace true with x and false with !x
      Staging: rtl8723bs: Do not check for NOT NULL before kfree()
      Staging: rtlwifi: Remove unused variable and the code
      Staging: rtl8723bs: Change names to conform to the kernel code
      Staging: rtl8723bs: Remove dead code
      Staging: rtl8723bs: Use !x instead of NULL comparison

Shubham Kumaram (1):
      Staging: gs_fpgaboot: remove FSF's mailing address from io.h

Sidong Yang (2):
      staging: vc05_services: fix checkpatch.pl errors
      staging: most: replace function name to __func__

Simon Sandstr=F6m (16):
      staging: pi433: Fix indentation in rf69_enum.h
      staging: pi433: Capitalize constant definitions
      staging: pi433: Rename variable in struct pi433_rx_cfg
      staging: pi433: Rename enum optionOnOff in rf69_enum.h
      staging: pi433: Rename enum modShaping in rf69_enum.h
      staging: pi433: Split rf69_set_crc_enabled into two functions
      staging: pi433: Split rf69_set_sync_enabled into two functions
      staging: pi433: Remove enum data_mode
      staging: pi433: Combine all rf69_set_amplifier_x()
      staging: pi433: Move enum option_on_off to pi433_if.h
      staging: pi433: Remove SET_CHECKED usage from pi433_probe
      staging: pi433: Fix ISO-8859 encoded non-english comments
      staging: pi433: Add spaces around & and + operator
      staging: pi433: Remove indentation on #ifdef blocks
      staging: pi433: Remove function entry dev_dbg()
      staging: pi433: Remove unnecessary #ifdef DEBUG around dev_dbg

Sinan Kaya (1):
      staging: rts5208: remove rtsx_read_pci_cfg_byte()

Stefan Br=FCns (10):
      iio: adc: ina2xx: Shift bus voltage register to mask flag bits
      iio: adc: ina2xx: Use LSB specifier instead of divider in config
      iio: adc: ina2xx: Allow setting Shunt Voltage PGA gain and Bus Voltag=
e range
      iio: adc: ina2xx: Remove bogus cast for data argument
      iio: adc: ina2xx: Clarify size requirement for data buffer
      iio: adc: ina2xx: Remove unneeded dummy read to clear CNVR flag
      iio: adc: ina2xx: Do not udelay for several seconds
      iio: adc: ina2xx: Use a monotonic clock for delay calculation
      iio: adc: ina2xx: Align timestamp with conversion ready flag
      iio: adc: ina2xx: Actually align the loop with the conversion ready f=
lag

Stefan Tatschner (1):
      iio:pressure:bmp280: Read calibration data in probe

Stefano Manni (1):
      staging: pi433: fixed signedness of 4th argument to kfifo_from_user

Stephen Hemminger (2):
      ipx: move Novell IPX protocol support into staging
      ncpfs: move net/ncpfs to drivers/staging/ncpfs

Sumit Pundir (8):
      Staging: iio: cdc: ad7152: Prefer using BIT macro
      Staging: lustre: Fix prefer seq_puts to seq_printf
      Staging: lustre: Fix prefer kcalloc over kzalloc with multiply
      Staging: vt6656: Fix unnecessary 'out of memory' message
      Staging: greybus: camera: cleanup multiple checks for null pointers
      staging: rts5208: sd: fix misspelled constant
      staging: lustre: lnet: prefer kcalloc over kzalloc with multiply
      staging: lustre: lnet: remove null check before kfree

Talat Batheesh (1):
      staging: lustre: Fix line over 80 characters

Tara Null (1):
      staging: vchiq_arm: fix open brace placement errors

Tim Sell (1):
      staging: unisys: visorbus: address theoretical int overflows

Tobin C. Harding (3):
      iio: fix SPHINX kernel-docs build warning
      iio: add kernel-doc for field @owner
      iio: add field identifier for @use_count kernel-doc

Tomas Marek (1):
      Staging: vc04_services: fix brace coding style issues in vchiq_shim.c

Valentin Vidic (26):
      staging: pi433: add space before open parenthesis
      staging: pi433: add space after comma
      staging: pi433: add space around operators
      staging: pi433: remove space inside parenthesis
      staging: pi433: use consistent brace style
      staging: pi433: use tabs for code indent
      staging: pi433: move trailing statements to next line
      staging: pi433: remove spaces before tabs
      staging: pi433: remove return from a void function
      staging: pi433: rewrite comparison with NULL
      staging: pi433: fix spelling errors in documentation
      staging: pi433: add blank line after function
      staging: pi433: remove comparison with false
      staging: pi433: remove comparison with true
      staging: pi433: fix CamelCase for dccPercent variables
      staging: pi433: remove multiple blank lines
      staging: pi433: collapse else block after return statement
      staging: pi433: replace unsigned with unsigned int
      staging: pi433: avoid logging ENOMEM messages
      staging: pi433: replace printk calls with dev_dbg
      staging: pi433: remove unused function
      staging: pi433: fix CamelCase for fifo variables
      staging: pi433: fix CamelCase for maxMinus variables
      staging: pi433: fix CamelCase for payload identifiers
      staging: pi433: replace shifting with BIT macro
      staging: pi433: align function parameters with open parenthesis

Venkat Prashanth B U (4):
      Drivers: iio:adc: fix brace coding style issue in at91_adc.c
      Drivers:iio:adc:ti_am335x_adc remove comparison to bool
      gyro:adis16136: fix debugfs_simple_attr.cocci warnings
      imu:adis16480: fix debugfs_simple_attr.cocci warnings

Vikash Kesarwani (1):
      Staging: comedi: drivers: serial2002 fixed a blank line coding style

Wei Yongjun (1):
      staging: ccree: remove redundant dev_err call in init_cc_resources()

Xingyu Chen (2):
      iio: adc: meson-saradc: remove irrelevant clock "sana"
      dt-bindings: iio: adc: update the doc for SAR ADC

Xiongwei Song (2):
      staging: android: check for error from register_shrinker in ion_heap_=
init_shrinker
      staging: android: check the return value of register_shrinker

Zebulon McCorkle (2):
      staging: olpc_dcon: Change bitshifts to BIT macro
      staging: olpc_dcon: Line up parentheses in func calls and defs

Zhai Zhaoxuan (1):
      staging: android: ashmem: add procfs fdinfo helper

 Documentation/ABI/testing/sysfs-bus-iio            |   14 +-
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |    1 -
 .../devicetree/bindings/iio/adc/aspeed_adc.txt     |    4 +-
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |    7 +
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   24 +
 .../devicetree/bindings/iio/health/max30102.txt    |    8 +-
 .../devicetree/bindings/iio/light/uvis25.txt       |   23 +
 MAINTAINERS                                        |   19 +-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/iio/accel/bmc150-accel-i2c.c               |   12 +
 drivers/iio/accel/da280.c                          |   31 +-
 drivers/iio/accel/kxsd9-i2c.c                      |    3 +
 drivers/iio/accel/mma8452.c                        |   20 +-
 drivers/iio/accel/st_accel_core.c                  |    5 -
 drivers/iio/adc/Kconfig                            |    3 +
 drivers/iio/adc/aspeed_adc.c                       |   25 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |  456 ++++-
 drivers/iio/adc/at91_adc.c                         |    4 +-
 drivers/iio/adc/axp288_adc.c                       |   20 +-
 drivers/iio/adc/hx711.c                            |  134 +-
 drivers/iio/adc/ina2xx-adc.c                       |  317 +++-
 drivers/iio/adc/meson_saradc.c                     |   60 +-
 drivers/iio/adc/qcom-vadc-common.c                 |    4 +
 drivers/iio/adc/stm32-adc-core.c                   |   14 +-
 drivers/iio/adc/stm32-adc-core.h                   |   14 +-
 drivers/iio/adc/stm32-adc.c                        |  199 +-
 drivers/iio/adc/ti_am335x_adc.c                    |    2 +-
 drivers/iio/chemical/ccs811.c                      |   13 +-
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |    2 -
 drivers/iio/common/ssp_sensors/ssp.h               |    2 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |    2 +-
 drivers/iio/common/ssp_sensors/ssp_spi.c           |    5 +-
 drivers/iio/counter/stm32-lptimer-cnt.c            |    2 +-
 drivers/iio/dac/mcp4725.c                          |    2 +-
 drivers/iio/dac/stm32-dac-core.c                   |   14 +-
 drivers/iio/dac/stm32-dac-core.h                   |   15 +-
 drivers/iio/dac/stm32-dac.c                        |   15 +-
 drivers/iio/dummy/iio_dummy_evgen.c                |    2 +-
 drivers/iio/gyro/adis16136.c                       |   15 +-
 drivers/iio/gyro/bmg160_core.c                     |    1 -
 drivers/iio/health/max30102.c                      |  308 +++-
 drivers/iio/humidity/hts221.h                      |    3 +-
 drivers/iio/humidity/hts221_core.c                 |   18 +-
 drivers/iio/humidity/hts221_i2c.c                  |   18 +-
 drivers/iio/humidity/hts221_spi.c                  |   18 +-
 drivers/iio/imu/adis16480.c                        |   28 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c         |    3 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   39 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |  107 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  115 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |   55 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |   70 +-
 drivers/iio/industrialio-buffer.c                  |   15 +
 drivers/iio/industrialio-core.c                    |    1 +
 drivers/iio/light/Kconfig                          |   34 +
 drivers/iio/light/Makefile                         |    4 +
 drivers/iio/light/cros_ec_light_prox.c             |    2 -
 drivers/iio/light/st_uvis25.h                      |   37 +
 drivers/iio/light/st_uvis25_core.c                 |  359 ++++
 drivers/iio/light/st_uvis25_i2c.c                  |   69 +
 drivers/iio/light/st_uvis25_spi.c                  |   68 +
 drivers/iio/light/zopt2201.c                       |  568 ++++++
 drivers/iio/magnetometer/ak8975.c                  |    1 +
 drivers/iio/pressure/bmp280-core.c                 |  203 +-
 drivers/iio/proximity/sx9500.c                     |    1 +
 drivers/iio/trigger/stm32-lptimer-trigger.c        |    3 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |    2 +-
 drivers/staging/Kconfig                            |    4 +
 drivers/staging/Makefile                           |    2 +
 drivers/staging/android/ashmem.c                   |   37 +-
 drivers/staging/android/ashmem.h                   |    1 +
 drivers/staging/android/ion/ion-ioctl.c            |   16 +-
 drivers/staging/android/ion/ion.c                  |   40 +-
 drivers/staging/android/ion/ion.h                  |   16 +-
 drivers/staging/android/ion/ion_carveout_heap.c    |   11 +-
 drivers/staging/android/ion/ion_chunk_heap.c       |   11 +-
 drivers/staging/android/ion/ion_cma_heap.c         |   11 +-
 drivers/staging/android/ion/ion_heap.c             |   16 +-
 drivers/staging/android/ion/ion_page_pool.c        |   11 +-
 drivers/staging/android/ion/ion_system_heap.c      |   13 +-
 drivers/staging/android/uapi/ashmem.h              |    1 +
 drivers/staging/android/uapi/ion.h                 |   11 +-
 .../devicetree/bindings/crypto/arm-cryptocell.txt  |   27 -
 drivers/staging/ccree/Kconfig                      |    2 +
 drivers/staging/ccree/Makefile                     |    8 +-
 drivers/staging/ccree/TODO                         |   22 +-
 drivers/staging/ccree/{ssi_aead.c =3D> cc_aead.c}    | 1119 ++++++-----
 drivers/staging/ccree/{ssi_aead.h =3D> cc_aead.h}    |   56 +-
 .../ccree/{ssi_buffer_mgr.c =3D> cc_buffer_mgr.c}    | 1085 +++++------
 drivers/staging/ccree/cc_buffer_mgr.h              |   74 +
 .../staging/ccree/{ssi_cipher.c =3D> cc_cipher.c}    |  715 +++----
 drivers/staging/ccree/cc_cipher.h                  |   74 +
 drivers/staging/ccree/cc_crypto_ctx.h              |   38 +-
 drivers/staging/ccree/cc_debugfs.c                 |  101 +
 drivers/staging/ccree/cc_debugfs.h                 |   32 +
 .../staging/ccree/{ssi_driver.c =3D> cc_driver.c}    |  346 ++--
 drivers/staging/ccree/cc_driver.h                  |  194 ++
 drivers/staging/ccree/{ssi_fips.c =3D> cc_fips.c}    |   45 +-
 drivers/staging/ccree/cc_fips.h                    |   37 +
 drivers/staging/ccree/{ssi_hash.c =3D> cc_hash.c}    | 1820 ++++++++------=
----
 drivers/staging/ccree/cc_hash.h                    |  114 ++
 drivers/staging/ccree/cc_host_regs.h               |  142 ++
 drivers/staging/ccree/cc_hw_queue_defs.h           |   40 +-
 drivers/staging/ccree/{ssi_ivgen.c =3D> cc_ivgen.c}  |  139 +-
 drivers/staging/ccree/cc_ivgen.h                   |   55 +
 drivers/staging/ccree/cc_kernel_regs.h             |  167 ++
 drivers/staging/ccree/cc_lli_defs.h                |   19 +-
 drivers/staging/ccree/cc_pm.c                      |  122 ++
 drivers/staging/ccree/cc_pm.h                      |   57 +
 drivers/staging/ccree/cc_request_mgr.c             |  713 +++++++
 drivers/staging/ccree/cc_request_mgr.h             |   51 +
 .../ccree/{ssi_sram_mgr.c =3D> cc_sram_mgr.c}        |   70 +-
 drivers/staging/ccree/cc_sram_mgr.h                |   65 +
 drivers/staging/ccree/dx_crys_kernel.h             |  180 --
 drivers/staging/ccree/dx_host.h                    |  155 --
 drivers/staging/ccree/dx_reg_common.h              |   26 -
 drivers/staging/ccree/hash_defs.h                  |   36 -
 drivers/staging/ccree/ssi_buffer_mgr.h             |   91 -
 drivers/staging/ccree/ssi_cipher.h                 |   84 -
 drivers/staging/ccree/ssi_config.h                 |   36 -
 drivers/staging/ccree/ssi_driver.h                 |  206 ---
 drivers/staging/ccree/ssi_fips.h                   |   49 -
 drivers/staging/ccree/ssi_hash.h                   |  103 --
 drivers/staging/ccree/ssi_ivgen.h                  |   71 -
 drivers/staging/ccree/ssi_pm.c                     |  145 --
 drivers/staging/ccree/ssi_pm.h                     |   43 -
 drivers/staging/ccree/ssi_request_mgr.c            |  610 ------
 drivers/staging/ccree/ssi_request_mgr.h            |   60 -
 drivers/staging/ccree/ssi_sram_mgr.h               |   79 -
 drivers/staging/ccree/ssi_sysfs.c                  |  172 --
 drivers/staging/ccree/ssi_sysfs.h                  |   55 -
 .../clocking-wizard/clk-xlnx-clock-wizard.c        |   13 +-
 drivers/staging/comedi/comedi.h                    |   11 +-
 drivers/staging/comedi/comedi_buf.c                |   11 +-
 drivers/staging/comedi/comedi_compat32.c           |   11 +-
 drivers/staging/comedi/comedi_compat32.h           |   11 +-
 drivers/staging/comedi/comedi_fops.c               |   11 +-
 drivers/staging/comedi/comedi_pci.c                |   11 +-
 drivers/staging/comedi/comedi_pci.h                |   11 +-
 drivers/staging/comedi/comedi_pcmcia.c             |   11 +-
 drivers/staging/comedi/comedi_pcmcia.h             |   11 +-
 drivers/staging/comedi/comedi_usb.c                |   11 +-
 drivers/staging/comedi/comedi_usb.h                |   11 +-
 drivers/staging/comedi/comedidev.h                 |   51 +-
 drivers/staging/comedi/comedilib.h                 |   11 +-
 drivers/staging/comedi/drivers.c                   |   11 +-
 drivers/staging/comedi/drivers/8255.c              |   11 +-
 drivers/staging/comedi/drivers/8255.h              |   11 +-
 drivers/staging/comedi/drivers/8255_pci.c          |   11 +-
 drivers/staging/comedi/drivers/addi_apci_1032.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_1500.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_1516.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_1564.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_16xx.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_2032.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_2200.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_3120.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_3501.c    |   11 +-
 drivers/staging/comedi/drivers/addi_apci_3xxx.c    |   11 +-
 drivers/staging/comedi/drivers/addi_watchdog.c     |   11 +-
 drivers/staging/comedi/drivers/adl_pci6208.c       |   11 +-
 drivers/staging/comedi/drivers/adl_pci7x3x.c       |   11 +-
 drivers/staging/comedi/drivers/adl_pci8164.c       |   11 +-
 drivers/staging/comedi/drivers/adl_pci9111.c       |   11 +-
 drivers/staging/comedi/drivers/adl_pci9118.c       |    1 +
 drivers/staging/comedi/drivers/adq12b.c            |   11 +-
 drivers/staging/comedi/drivers/adv_pci1710.c       |    1 +
 drivers/staging/comedi/drivers/adv_pci1720.c       |   11 +-
 drivers/staging/comedi/drivers/adv_pci1723.c       |   11 +-
 drivers/staging/comedi/drivers/adv_pci1724.c       |   11 +-
 drivers/staging/comedi/drivers/adv_pci1760.c       |   13 +-
 drivers/staging/comedi/drivers/adv_pci_dio.c       |    1 +
 drivers/staging/comedi/drivers/aio_aio12_8.c       |   11 +-
 drivers/staging/comedi/drivers/aio_iiro_16.c       |   11 +-
 drivers/staging/comedi/drivers/amplc_dio200.c      |   11 +-
 drivers/staging/comedi/drivers/amplc_dio200.h      |   11 +-
 .../staging/comedi/drivers/amplc_dio200_common.c   |   11 +-
 drivers/staging/comedi/drivers/amplc_dio200_pci.c  |   11 +-
 drivers/staging/comedi/drivers/amplc_pc236.c       |   11 +-
 drivers/staging/comedi/drivers/amplc_pc236.h       |   11 +-
 .../staging/comedi/drivers/amplc_pc236_common.c    |   11 +-
 drivers/staging/comedi/drivers/amplc_pc263.c       |   11 +-
 drivers/staging/comedi/drivers/amplc_pci224.c      |   11 +-
 drivers/staging/comedi/drivers/amplc_pci230.c      |   11 +-
 drivers/staging/comedi/drivers/amplc_pci236.c      |   11 +-
 drivers/staging/comedi/drivers/amplc_pci263.c      |   11 +-
 drivers/staging/comedi/drivers/c6xdigio.c          |   11 +-
 drivers/staging/comedi/drivers/cb_das16_cs.c       |   11 +-
 drivers/staging/comedi/drivers/cb_pcidas.c         |   11 +-
 drivers/staging/comedi/drivers/cb_pcidas64.c       |   11 +-
 drivers/staging/comedi/drivers/cb_pcidda.c         |   11 +-
 drivers/staging/comedi/drivers/cb_pcimdas.c        |   11 +-
 drivers/staging/comedi/drivers/cb_pcimdda.c        |   11 +-
 drivers/staging/comedi/drivers/comedi_8254.c       |   11 +-
 drivers/staging/comedi/drivers/comedi_8254.h       |   11 +-
 drivers/staging/comedi/drivers/comedi_8255.c       |   11 +-
 drivers/staging/comedi/drivers/comedi_bond.c       |   11 +-
 drivers/staging/comedi/drivers/comedi_isadma.c     |   11 +-
 drivers/staging/comedi/drivers/comedi_isadma.h     |   11 +-
 drivers/staging/comedi/drivers/comedi_parport.c    |   11 +-
 drivers/staging/comedi/drivers/comedi_test.c       |   11 +-
 drivers/staging/comedi/drivers/contec_pci_dio.c    |   11 +-
 drivers/staging/comedi/drivers/dac02.c             |   11 +-
 drivers/staging/comedi/drivers/daqboard2000.c      |   11 +-
 drivers/staging/comedi/drivers/das08.c             |   11 +-
 drivers/staging/comedi/drivers/das08.h             |   11 +-
 drivers/staging/comedi/drivers/das08_cs.c          |   11 +-
 drivers/staging/comedi/drivers/das08_isa.c         |   11 +-
 drivers/staging/comedi/drivers/das08_pci.c         |   11 +-
 drivers/staging/comedi/drivers/das16.c             |   11 +-
 drivers/staging/comedi/drivers/das16m1.c           |   11 +-
 drivers/staging/comedi/drivers/das1800.c           |   11 +-
 drivers/staging/comedi/drivers/das6402.c           |   11 +-
 drivers/staging/comedi/drivers/das800.c            |   11 +-
 drivers/staging/comedi/drivers/dmm32at.c           |   11 +-
 drivers/staging/comedi/drivers/dt2801.c            |    1 +
 drivers/staging/comedi/drivers/dt2811.c            |   13 +-
 drivers/staging/comedi/drivers/dt2814.c            |   11 +-
 drivers/staging/comedi/drivers/dt2815.c            |   11 +-
 drivers/staging/comedi/drivers/dt2817.c            |   11 +-
 drivers/staging/comedi/drivers/dt282x.c            |   11 +-
 drivers/staging/comedi/drivers/dt3000.c            |   11 +-
 drivers/staging/comedi/drivers/dt9812.c            |   11 +-
 drivers/staging/comedi/drivers/dyna_pci10xx.c      |   11 +-
 drivers/staging/comedi/drivers/fl512.c             |   11 +-
 drivers/staging/comedi/drivers/gsc_hpdi.c          |   11 +-
 drivers/staging/comedi/drivers/icp_multi.c         |   11 +-
 drivers/staging/comedi/drivers/ii_pci20kc.c        |    1 +
 drivers/staging/comedi/drivers/jr3_pci.c           |   11 +-
 drivers/staging/comedi/drivers/ke_counter.c        |   11 +-
 drivers/staging/comedi/drivers/me4000.c            |   11 +-
 drivers/staging/comedi/drivers/me_daq.c            |   11 +-
 drivers/staging/comedi/drivers/mf6x4.c             |   11 +-
 drivers/staging/comedi/drivers/mite.c              |   11 +-
 drivers/staging/comedi/drivers/mite.h              |   11 +-
 drivers/staging/comedi/drivers/mpc624.c            |   11 +-
 drivers/staging/comedi/drivers/multiq3.c           |   11 +-
 drivers/staging/comedi/drivers/ni_6527.c           |   11 +-
 drivers/staging/comedi/drivers/ni_65xx.c           |   11 +-
 drivers/staging/comedi/drivers/ni_660x.c           |   11 +-
 drivers/staging/comedi/drivers/ni_670x.c           |   11 +-
 drivers/staging/comedi/drivers/ni_at_a2150.c       |   11 +-
 drivers/staging/comedi/drivers/ni_at_ao.c          |   11 +-
 drivers/staging/comedi/drivers/ni_atmio.c          |   11 +-
 drivers/staging/comedi/drivers/ni_atmio16d.c       |   11 +-
 drivers/staging/comedi/drivers/ni_daq_700.c        |   11 +-
 drivers/staging/comedi/drivers/ni_daq_dio24.c      |   11 +-
 drivers/staging/comedi/drivers/ni_labpc.c          |   11 +-
 drivers/staging/comedi/drivers/ni_labpc.h          |   11 +-
 drivers/staging/comedi/drivers/ni_labpc_common.c   |   11 +-
 drivers/staging/comedi/drivers/ni_labpc_cs.c       |   11 +-
 drivers/staging/comedi/drivers/ni_labpc_isadma.c   |   11 +-
 drivers/staging/comedi/drivers/ni_labpc_pci.c      |   11 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |   11 +-
 drivers/staging/comedi/drivers/ni_mio_cs.c         |   11 +-
 drivers/staging/comedi/drivers/ni_pcidio.c         |   11 +-
 drivers/staging/comedi/drivers/ni_pcimio.c         |   11 +-
 drivers/staging/comedi/drivers/ni_stc.h            |   11 +-
 drivers/staging/comedi/drivers/ni_tio.c            |   11 +-
 drivers/staging/comedi/drivers/ni_tio.h            |   11 +-
 drivers/staging/comedi/drivers/ni_tio_internal.h   |   11 +-
 drivers/staging/comedi/drivers/ni_tiocmd.c         |   11 +-
 drivers/staging/comedi/drivers/ni_usb6501.c        |   11 +-
 drivers/staging/comedi/drivers/pcl711.c            |   11 +-
 drivers/staging/comedi/drivers/pcl724.c            |    1 +
 drivers/staging/comedi/drivers/pcl726.c            |   11 +-
 drivers/staging/comedi/drivers/pcl730.c            |    1 +
 drivers/staging/comedi/drivers/pcl812.c            |    1 +
 drivers/staging/comedi/drivers/pcl816.c            |    1 +
 drivers/staging/comedi/drivers/pcl818.c            |    1 +
 drivers/staging/comedi/drivers/pcm3724.c           |    1 +
 drivers/staging/comedi/drivers/pcmad.c             |   11 +-
 drivers/staging/comedi/drivers/pcmda12.c           |   11 +-
 drivers/staging/comedi/drivers/pcmmio.c            |   11 +-
 drivers/staging/comedi/drivers/pcmuio.c            |   11 +-
 drivers/staging/comedi/drivers/plx9052.h           |   11 +-
 drivers/staging/comedi/drivers/plx9080.h           |    6 +-
 drivers/staging/comedi/drivers/rtd520.c            |   11 +-
 drivers/staging/comedi/drivers/rti800.c            |   11 +-
 drivers/staging/comedi/drivers/rti802.c            |   11 +-
 drivers/staging/comedi/drivers/s526.c              |   11 +-
 drivers/staging/comedi/drivers/s626.c              |   20 +-
 drivers/staging/comedi/drivers/s626.h              |   11 +-
 drivers/staging/comedi/drivers/serial2002.c        |   12 +-
 drivers/staging/comedi/drivers/ssv_dnp.c           |   11 +-
 drivers/staging/comedi/drivers/usbdux.c            |   14 +-
 drivers/staging/comedi/drivers/usbduxfast.c        |   11 +-
 drivers/staging/comedi/drivers/usbduxsigma.c       |   11 +-
 drivers/staging/comedi/drivers/vmk80xx.c           |   11 +-
 .../staging/comedi/kcomedilib/kcomedilib_main.c    |   11 +-
 drivers/staging/comedi/proc.c                      |   11 +-
 drivers/staging/comedi/range.c                     |   11 +-
 drivers/staging/dgnc/Makefile                      |    3 +-
 drivers/staging/dgnc/dgnc_cls.c                    |   38 +-
 drivers/staging/dgnc/dgnc_cls.h                    |   11 +-
 drivers/staging/dgnc/dgnc_driver.c                 |  160 +-
 drivers/staging/dgnc/dgnc_driver.h                 |   52 +-
 drivers/staging/dgnc/dgnc_mgmt.c                   |  248 ---
 drivers/staging/dgnc/dgnc_mgmt.h                   |   26 -
 drivers/staging/dgnc/dgnc_neo.c                    | 1690 -----------------
 drivers/staging/dgnc/dgnc_neo.h                    |  175 --
 drivers/staging/dgnc/dgnc_pci.h                    |   69 -
 drivers/staging/dgnc/dgnc_tty.c                    |   20 +-
 drivers/staging/dgnc/dgnc_tty.h                    |   11 +-
 drivers/staging/dgnc/dgnc_utils.c                  |   17 -
 drivers/staging/dgnc/dgnc_utils.h                  |    7 -
 drivers/staging/dgnc/digi.h                        |   88 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   10 +-
 drivers/staging/emxx_udc/emxx_udc.h                |   10 +-
 drivers/staging/fbtft/Kconfig                      |    6 -
 drivers/staging/fbtft/fb_agm1264k-fl.c             |   11 +-
 drivers/staging/fbtft/fb_bd663474.c                |   11 +-
 drivers/staging/fbtft/fb_hx8340bn.c                |   11 +-
 drivers/staging/fbtft/fb_hx8347d.c                 |   11 +-
 drivers/staging/fbtft/fb_hx8353d.c                 |   11 +-
 drivers/staging/fbtft/fb_hx8357d.c                 |   11 +-
 drivers/staging/fbtft/fb_hx8357d.h                 |    1 +
 drivers/staging/fbtft/fb_ili9163.c                 |   11 +-
 drivers/staging/fbtft/fb_ili9320.c                 |   11 +-
 drivers/staging/fbtft/fb_ili9325.c                 |   11 +-
 drivers/staging/fbtft/fb_ili9340.c                 |   11 +-
 drivers/staging/fbtft/fb_ili9341.c                 |   11 +-
 drivers/staging/fbtft/fb_ili9481.c                 |   11 +-
 drivers/staging/fbtft/fb_ili9486.c                 |   11 +-
 drivers/staging/fbtft/fb_pcd8544.c                 |   11 +-
 drivers/staging/fbtft/fb_ra8875.c                  |   11 +-
 drivers/staging/fbtft/fb_s6d02a1.c                 |   11 +-
 drivers/staging/fbtft/fb_s6d1121.c                 |   11 +-
 drivers/staging/fbtft/fb_sh1106.c                  |   11 +-
 drivers/staging/fbtft/fb_ssd1289.c                 |   11 +-
 drivers/staging/fbtft/fb_ssd1305.c                 |   11 +-
 drivers/staging/fbtft/fb_ssd1306.c                 |   11 +-
 drivers/staging/fbtft/fb_ssd1325.c                 |   11 +-
 drivers/staging/fbtft/fb_ssd1331.c                 |    1 +
 drivers/staging/fbtft/fb_ssd1351.c                 |    1 +
 drivers/staging/fbtft/fb_st7735r.c                 |   11 +-
 drivers/staging/fbtft/fb_st7789v.c                 |   11 +-
 drivers/staging/fbtft/fb_tinylcd.c                 |   11 +-
 drivers/staging/fbtft/fb_tls8204.c                 |   11 +-
 drivers/staging/fbtft/fb_uc1611.c                  |   11 +-
 drivers/staging/fbtft/fb_uc1701.c                  |   11 +-
 drivers/staging/fbtft/fb_upd161704.c               |   11 +-
 drivers/staging/fbtft/fb_watterott.c               |   11 +-
 drivers/staging/fbtft/fbtft-core.c                 |   27 +-
 drivers/staging/fbtft/fbtft.h                      |   15 +-
 drivers/staging/fbtft/fbtft_device.c               |   11 +-
 drivers/staging/fbtft/flexfb.c                     |   11 +-
 drivers/staging/fbtft/internal.h                   |   16 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |  165 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |   35 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c |    1 +
 drivers/staging/fsl-mc/Kconfig                     |    1 +
 drivers/staging/fsl-mc/Makefile                    |    1 +
 drivers/staging/fsl-mc/README.txt                  |  386 ----
 drivers/staging/fsl-mc/bus/Kconfig                 |    3 +-
 drivers/staging/fsl-mc/bus/Makefile                |    3 +-
 drivers/staging/fsl-mc/bus/dpbp-cmd.h              |   28 +-
 drivers/staging/fsl-mc/bus/dpbp.c                  |   44 +-
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             |   34 +-
 drivers/staging/fsl-mc/bus/dpcon.c                 |  115 +-
 drivers/staging/fsl-mc/bus/dpio/Makefile           |    1 +
 drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h         |   28 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c      |   27 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c     |  129 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c             |   28 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.h             |   28 +-
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c     |   27 +-
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h     |   27 +-
 drivers/staging/fsl-mc/bus/dpmcp-cmd.h             |   56 -
 drivers/staging/fsl-mc/bus/dpmcp.c                 |   63 +-
 drivers/staging/fsl-mc/bus/dpmcp.h                 |   60 -
 drivers/staging/fsl-mc/bus/dpmng-cmd.h             |   58 -
 drivers/staging/fsl-mc/bus/dprc-cmd.h              |  451 -----
 drivers/staging/fsl-mc/bus/dprc-driver.c           |   82 +-
 drivers/staging/fsl-mc/bus/dprc.c                  |  268 +--
 drivers/staging/fsl-mc/bus/dprc.h                  |  268 ---
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c      |  117 +-
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c            |  112 +-
 drivers/staging/fsl-mc/bus/fsl-mc-msi.c            |   19 +-
 drivers/staging/fsl-mc/bus/fsl-mc-private.h        |  379 +++-
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |   34 +-
 drivers/staging/fsl-mc/bus/mc-io.c                 |   62 +-
 drivers/staging/fsl-mc/bus/mc-sys.c                |   37 +-
 drivers/staging/fsl-mc/include/dpaa2-fd.h          |   27 +-
 drivers/staging/fsl-mc/include/dpaa2-global.h      |   27 +-
 drivers/staging/fsl-mc/include/dpaa2-io.h          |   33 +-
 drivers/staging/fsl-mc/include/dpbp.h              |   29 +-
 drivers/staging/fsl-mc/include/dpcon.h             |   42 +-
 drivers/staging/fsl-mc/include/mc.h                |   61 +-
 drivers/staging/fsl-mc/overview.rst                |  404 ++++
 drivers/staging/fwserial/dma_fifo.c                |   11 +-
 drivers/staging/fwserial/dma_fifo.h                |   11 +-
 drivers/staging/fwserial/fwserial.c                |   11 +-
 drivers/staging/greybus/arche-apb-ctrl.c           |   39 +-
 drivers/staging/greybus/arche-platform.c           |   21 +-
 drivers/staging/greybus/audio_codec.c              |   23 +-
 drivers/staging/greybus/audio_codec.h              |   12 +-
 drivers/staging/greybus/authentication.c           |    2 +-
 drivers/staging/greybus/camera.c                   |   16 +-
 drivers/staging/gs_fpgaboot/io.h                   |    5 -
 drivers/staging/iio/adc/ad7192.c                   |    2 +-
 drivers/staging/iio/cdc/ad7152.c                   |   25 +-
 drivers/staging/iio/cdc/ad7746.c                   |   17 +-
 drivers/staging/iio/light/tsl2x7x.c                |    9 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   19 +-
 {net =3D> drivers/staging}/ipx/Kconfig               |    1 +
 {net =3D> drivers/staging}/ipx/Makefile              |    0
 drivers/staging/ipx/TODO                           |    4 +
 {net =3D> drivers/staging}/ipx/af_ipx.c              |    0
 {net =3D> drivers/staging}/ipx/ipx_proc.c            |    0
 {net =3D> drivers/staging}/ipx/ipx_route.c           |    0
 {net =3D> drivers/staging}/ipx/pe2.c                 |    0
 {net =3D> drivers/staging}/ipx/sysctl_net_ipx.c      |    0
 drivers/staging/irda/drivers/pxaficp_ir.c          |    1 -
 drivers/staging/irda/net/irlmp.c                   |    4 +-
 drivers/staging/ks7010/ks_wlan_net.c               |    4 +-
 .../staging/lustre/include/linux/libcfs/libcfs.h   |   13 +-
 .../lustre/include/linux/libcfs/libcfs_cpu.h       |    4 +-
 .../lustre/include/linux/libcfs/libcfs_hash.h      |    6 +-
 .../lustre/include/linux/libcfs/libcfs_private.h   |  130 +-
 .../lustre/include/linux/libcfs/libcfs_string.h    |    5 +-
 .../lustre/include/linux/libcfs/libcfs_workitem.h  |  107 --
 .../lustre/include/linux/libcfs/linux/linux-cpu.h  |    4 +-
 .../staging/lustre/include/linux/lnet/lib-lnet.h   |   63 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |  160 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    |    2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |   10 +-
 .../lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c  |    4 +-
 .../staging/lustre/lnet/klnds/socklnd/socklnd.c    |   61 +-
 .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |    6 +-
 .../lustre/lnet/klnds/socklnd/socklnd_proto.c      |    8 +-
 drivers/staging/lustre/lnet/libcfs/Makefile        |    2 +-
 drivers/staging/lustre/lnet/libcfs/fail.c          |    2 +-
 drivers/staging/lustre/lnet/libcfs/hash.c          |  100 +-
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    |    6 +-
 drivers/staging/lustre/lnet/libcfs/libcfs_lock.c   |    6 +-
 drivers/staging/lustre/lnet/libcfs/libcfs_mem.c    |   24 +-
 drivers/staging/lustre/lnet/libcfs/libcfs_string.c |   32 +-
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   |  151 +-
 .../lustre/lnet/libcfs/linux/linux-module.c        |    4 +-
 drivers/staging/lustre/lnet/libcfs/module.c        |   36 +-
 drivers/staging/lustre/lnet/libcfs/prng.c          |  137 --
 drivers/staging/lustre/lnet/libcfs/tracefile.c     |    2 +-
 drivers/staging/lustre/lnet/libcfs/workitem.c      |  466 -----
 drivers/staging/lustre/lnet/lnet/api-ni.c          |   36 +-
 drivers/staging/lustre/lnet/lnet/config.c          |   53 +-
 drivers/staging/lustre/lnet/lnet/lib-eq.c          |   15 +-
 drivers/staging/lustre/lnet/lnet/lib-md.c          |    8 +-
 drivers/staging/lustre/lnet/lnet/lib-me.c          |   10 +-
 drivers/staging/lustre/lnet/lnet/lib-move.c        |   25 +-
 drivers/staging/lustre/lnet/lnet/lib-msg.c         |   20 +-
 drivers/staging/lustre/lnet/lnet/lib-ptl.c         |    8 +-
 drivers/staging/lustre/lnet/lnet/lib-socket.c      |   14 +-
 drivers/staging/lustre/lnet/lnet/net_fault.c       |   48 +-
 drivers/staging/lustre/lnet/lnet/nidstrings.c      |    8 +-
 drivers/staging/lustre/lnet/lnet/peer.c            |   10 +-
 drivers/staging/lustre/lnet/lnet/router.c          |   60 +-
 drivers/staging/lustre/lnet/lnet/router_proc.c     |   42 +-
 drivers/staging/lustre/lnet/selftest/conctl.c      |  191 +-
 drivers/staging/lustre/lnet/selftest/conrpc.c      |   10 +-
 drivers/staging/lustre/lnet/selftest/console.c     |   83 +-
 drivers/staging/lustre/lnet/selftest/framework.c   |   40 +-
 drivers/staging/lustre/lnet/selftest/module.c      |   48 +-
 drivers/staging/lustre/lnet/selftest/rpc.c         |   96 +-
 drivers/staging/lustre/lnet/selftest/selftest.h    |   46 +-
 drivers/staging/lustre/lustre/fld/fld_cache.c      |   13 +-
 .../staging/lustre/lustre/include/lustre_disk.h    |    6 +-
 drivers/staging/lustre/lustre/include/lustre_sec.h |    4 +-
 drivers/staging/lustre/lustre/include/obd_class.h  |  305 +--
 drivers/staging/lustre/lustre/ldlm/ldlm_extent.c   |    4 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_lock.c     |   18 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_lockd.c    |   14 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_pool.c     |    8 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_request.c  |   12 +-
 drivers/staging/lustre/lustre/ldlm/ldlm_resource.c |   20 +-
 drivers/staging/lustre/lustre/llite/dir.c          |    4 +-
 .../staging/lustre/lustre/llite/llite_internal.h   |    2 +-
 drivers/staging/lustre/lustre/llite/llite_lib.c    |   11 +-
 drivers/staging/lustre/lustre/llite/super25.c      |   23 +-
 drivers/staging/lustre/lustre/llite/vvp_dev.c      |    2 +-
 drivers/staging/lustre/lustre/llite/vvp_io.c       |    2 +-
 drivers/staging/lustre/lustre/lov/lov_internal.h   |   12 +-
 drivers/staging/lustre/lustre/lov/lov_obd.c        |    6 +-
 drivers/staging/lustre/lustre/lov/lov_object.c     |    2 +-
 drivers/staging/lustre/lustre/lov/lov_request.c    |   10 +-
 drivers/staging/lustre/lustre/mgc/mgc_request.c    |    4 +-
 drivers/staging/lustre/lustre/obdclass/cl_lock.c   |    9 +-
 drivers/staging/lustre/lustre/obdclass/cl_object.c |    8 +-
 drivers/staging/lustre/lustre/obdclass/cl_page.c   |    4 +-
 drivers/staging/lustre/lustre/obdclass/class_obd.c |    3 +-
 .../lustre/lustre/obdclass/linux/linux-module.c    |    3 +
 .../lustre/lustre/obdclass/lprocfs_status.c        |   21 +-
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   24 +-
 .../lustre/lustre/obdclass/lustre_handles.c        |    9 +-
 .../staging/lustre/lustre/obdclass/obd_config.c    |    2 +-
 drivers/staging/lustre/lustre/obdclass/obd_mount.c |   63 +-
 drivers/staging/lustre/lustre/osc/osc_internal.h   |    6 +-
 drivers/staging/lustre/lustre/osc/osc_request.c    |    4 +-
 drivers/staging/lustre/lustre/ptlrpc/client.c      |    2 +-
 drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c    |    8 +-
 drivers/staging/media/imx/imx-media-csi.c          |    8 +-
 drivers/staging/media/imx/imx-media-fim.c          |   30 +-
 drivers/staging/media/imx/imx-media.h              |    2 +-
 .../most/Documentation/ABI/sysfs-bus-most.txt      |  313 ++++
 .../staging/most/Documentation/driver_usage.txt    |  192 +-
 drivers/staging/most/Kconfig                       |   27 +-
 drivers/staging/most/Makefile                      |   19 +-
 drivers/staging/most/aim-cdev/Makefile             |    4 -
 drivers/staging/most/aim-network/Makefile          |    4 -
 drivers/staging/most/aim-sound/Makefile            |    4 -
 drivers/staging/most/aim-v4l2/Makefile             |    5 -
 drivers/staging/most/{aim-cdev =3D> cdev}/Kconfig    |    6 +-
 drivers/staging/most/cdev/Makefile                 |    4 +
 drivers/staging/most/{aim-cdev =3D> cdev}/cdev.c     |  194 +-
 drivers/staging/most/core.c                        | 1603 ++++++++++++++++
 .../staging/most/{mostcore/mostcore.h =3D> core.h}   |   77 +-
 drivers/staging/most/{hdm-dim2 =3D> dim2}/Kconfig    |    6 +-
 drivers/staging/most/dim2/Makefile                 |    4 +
 .../most/{hdm-dim2/dim2_hdm.c =3D> dim2/dim2.c}      |   45 +-
 .../most/{hdm-dim2/dim2_hdm.h =3D> dim2/dim2.h}      |   10 +-
 .../most/{hdm-dim2/dim2_errors.h =3D> dim2/errors.h} |   10 +-
 .../most/{hdm-dim2/dim2_hal.c =3D> dim2/hal.c}       |   16 +-
 .../most/{hdm-dim2/dim2_hal.h =3D> dim2/hal.h}       |   12 +-
 .../most/{hdm-dim2/dim2_reg.h =3D> dim2/reg.h}       |   10 +-
 drivers/staging/most/dim2/sysfs.c                  |   49 +
 drivers/staging/most/dim2/sysfs.h                  |   30 +
 drivers/staging/most/hdm-dim2/Makefile             |    5 -
 drivers/staging/most/hdm-dim2/dim2_sysfs.c         |  115 --
 drivers/staging/most/hdm-dim2/dim2_sysfs.h         |   36 -
 drivers/staging/most/hdm-i2c/Makefile              |    3 -
 drivers/staging/most/hdm-usb/Makefile              |    4 -
 drivers/staging/most/{hdm-i2c =3D> i2c}/Kconfig      |    6 +-
 drivers/staging/most/i2c/Makefile                  |    4 +
 .../staging/most/{hdm-i2c/hdm_i2c.c =3D> i2c/i2c.c}  |   19 +-
 drivers/staging/most/mostcore/Kconfig              |   14 -
 drivers/staging/most/mostcore/Makefile             |    3 -
 drivers/staging/most/mostcore/core.c               | 1949 ----------------=
----
 drivers/staging/most/{aim-network =3D> net}/Kconfig  |    6 +-
 drivers/staging/most/net/Makefile                  |    4 +
 .../most/{aim-network/networking.c =3D> net/net.c}   |   71 +-
 drivers/staging/most/{aim-sound =3D> sound}/Kconfig  |    6 +-
 drivers/staging/most/sound/Makefile                |    4 +
 drivers/staging/most/{aim-sound =3D> sound}/sound.c  |   33 +-
 drivers/staging/most/{hdm-usb =3D> usb}/Kconfig      |    7 +-
 drivers/staging/most/usb/Makefile                  |    4 +
 .../staging/most/{hdm-usb/hdm_usb.c =3D> usb/usb.c}  |  276 +--
 drivers/staging/most/{aim-v4l2 =3D> video}/Kconfig   |    6 +-
 drivers/staging/most/video/Makefile                |    4 +
 drivers/staging/most/{aim-v4l2 =3D> video}/video.c   |  167 +-
 {fs =3D> drivers/staging}/ncpfs/Kconfig              |    0
 {fs =3D> drivers/staging}/ncpfs/Makefile             |    0
 drivers/staging/ncpfs/TODO                         |    4 +
 {fs =3D> drivers/staging}/ncpfs/dir.c                |    0
 {fs =3D> drivers/staging}/ncpfs/file.c               |    0
 {fs =3D> drivers/staging}/ncpfs/getopt.c             |    0
 {fs =3D> drivers/staging}/ncpfs/getopt.h             |    0
 {fs =3D> drivers/staging}/ncpfs/inode.c              |    3 +-
 {fs =3D> drivers/staging}/ncpfs/ioctl.c              |    0
 {fs =3D> drivers/staging}/ncpfs/mmap.c               |    0
 {fs =3D> drivers/staging}/ncpfs/ncp_fs.h             |    0
 {fs =3D> drivers/staging}/ncpfs/ncp_fs_i.h           |    0
 {fs =3D> drivers/staging}/ncpfs/ncp_fs_sb.h          |    0
 {fs =3D> drivers/staging}/ncpfs/ncplib_kernel.c      |    0
 {fs =3D> drivers/staging}/ncpfs/ncplib_kernel.h      |    0
 {fs =3D> drivers/staging}/ncpfs/ncpsign_kernel.c     |    0
 {fs =3D> drivers/staging}/ncpfs/ncpsign_kernel.h     |    0
 {fs =3D> drivers/staging}/ncpfs/sock.c               |    0
 {fs =3D> drivers/staging}/ncpfs/symlink.c            |    0
 drivers/staging/nvec/nvec-keytable.h               |   14 +-
 drivers/staging/nvec/nvec.c                        |    6 +-
 drivers/staging/nvec/nvec.h                        |    6 +-
 drivers/staging/nvec/nvec_kbd.c                    |    6 +-
 drivers/staging/nvec/nvec_paz00.c                  |    6 +-
 drivers/staging/nvec/nvec_power.c                  |    6 +-
 drivers/staging/nvec/nvec_ps2.c                    |    6 +-
 drivers/staging/octeon/Makefile                    |    4 +-
 drivers/staging/octeon/ethernet-defines.h          |    5 +-
 drivers/staging/octeon/ethernet-mdio.c             |    5 +-
 drivers/staging/octeon/ethernet-mdio.h             |    5 +-
 drivers/staging/octeon/ethernet-mem.c              |    5 +-
 drivers/staging/octeon/ethernet-mem.h              |    5 +-
 drivers/staging/octeon/ethernet-rgmii.c            |    5 +-
 drivers/staging/octeon/ethernet-rx.c               |    5 +-
 drivers/staging/octeon/ethernet-rx.h               |    5 +-
 drivers/staging/octeon/ethernet-sgmii.c            |    5 +-
 drivers/staging/octeon/ethernet-spi.c              |    5 +-
 drivers/staging/octeon/ethernet-tx.c               |    5 +-
 drivers/staging/octeon/ethernet-tx.h               |    5 +-
 drivers/staging/octeon/ethernet-util.h             |    5 +-
 drivers/staging/octeon/ethernet.c                  |    5 +-
 drivers/staging/octeon/octeon-ethernet.h           |    5 +-
 drivers/staging/olpc_dcon/olpc_dcon.c              |   30 +-
 drivers/staging/olpc_dcon/olpc_dcon.h              |   30 +-
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c         |    2 +-
 .../Documentation/devicetree/pi433-overlay.dts     |   32 +-
 drivers/staging/pi433/Documentation/pi433.txt      |   18 +-
 drivers/staging/pi433/pi433_if.c                   |  607 +++---
 drivers/staging/pi433/pi433_if.h                   |   38 +-
 drivers/staging/pi433/rf69.c                       |  905 ++++-----
 drivers/staging/pi433/rf69.h                       |   37 +-
 drivers/staging/pi433/rf69_enum.h                  |  298 ++-
 drivers/staging/pi433/rf69_registers.h             |   48 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |    4 +-
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c          |    2 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |    1 -
 drivers/staging/rtl8192e/rtllib_softmac.c          |    2 +-
 drivers/staging/rtl8192u/ieee80211/dot11d.c        |    2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |   12 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |    2 +-
 drivers/staging/rtl8192u/r8192U_core.c             |    2 +-
 drivers/staging/rtl8712/hal_init.c                 |    1 -
 drivers/staging/rtl8712/ieee80211.c                |    6 +-
 drivers/staging/rtl8712/os_intfs.c                 |    5 +-
 drivers/staging/rtl8712/rtl8712_cmd.c              |   18 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |   55 +-
 drivers/staging/rtl8712/rtl8712_xmit.c             |    3 +-
 drivers/staging/rtl8712/rtl871x_cmd.c              |   36 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c      |  106 +-
 drivers/staging/rtl8712/rtl871x_ioctl_set.c        |   72 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |    9 +-
 drivers/staging/rtl8712/rtl871x_mlme.h             |    3 +-
 drivers/staging/rtl8712/rtl871x_mp.c               |    2 +-
 drivers/staging/rtl8712/rtl871x_security.c         |   44 +-
 drivers/staging/rtl8712/usb_ops_linux.c            |    2 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |    4 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |    2 +-
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c       |    2 +-
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c     |   16 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |    2 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |  768 ++++----
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c     |    4 +-
 drivers/staging/rtlwifi/Kconfig                    |   10 -
 drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c   |   20 +-
 drivers/staging/rtlwifi/cam.c                      |    4 +-
 drivers/staging/rtlwifi/core.c                     |   10 +-
 drivers/staging/rtlwifi/rtl8822be/fw.c             |    2 +
 drivers/staging/rtlwifi/wifi.h                     |    2 +-
 drivers/staging/rts5208/ms.c                       |    3 +-
 drivers/staging/rts5208/rtsx.c                     |   17 -
 drivers/staging/rts5208/rtsx.h                     |    2 -
 drivers/staging/rts5208/sd.h                       |    2 +-
 drivers/staging/sm750fb/TODO                       |    4 +-
 drivers/staging/sm750fb/ddk750_sii164.c            |    8 -
 drivers/staging/sm750fb/ddk750_sii164.h            |    2 -
 drivers/staging/sm750fb/sm750_hw.c                 |   14 +-
 drivers/staging/speakup/buffers.c                  |    1 +
 drivers/staging/speakup/fakekey.c                  |   11 +-
 drivers/staging/speakup/keyhelp.c                  |   11 +-
 drivers/staging/speakup/kobjects.c                 |    1 +
 drivers/staging/speakup/main.c                     |   11 +-
 drivers/staging/speakup/selection.c                |    9 +-
 drivers/staging/speakup/serialio.c                 |    1 +
 drivers/staging/speakup/speakup_acntpc.c           |   10 +-
 drivers/staging/speakup/speakup_acntsa.c           |   11 +-
 drivers/staging/speakup/speakup_apollo.c           |   11 +-
 drivers/staging/speakup/speakup_audptr.c           |   11 +-
 drivers/staging/speakup/speakup_bns.c              |   11 +-
 drivers/staging/speakup/speakup_decext.c           |   11 +-
 drivers/staging/speakup/speakup_decpc.c            |   11 +-
 drivers/staging/speakup/speakup_dectlk.c           |   11 +-
 drivers/staging/speakup/speakup_dtlk.c             |   11 +-
 drivers/staging/speakup/speakup_dummy.c            |   11 +-
 drivers/staging/speakup/speakup_keypc.c            |   11 +-
 drivers/staging/speakup/speakup_ltlk.c             |   11 +-
 drivers/staging/speakup/speakup_soft.c             |   12 +-
 drivers/staging/speakup/speakup_spkout.c           |   11 +-
 drivers/staging/speakup/speakup_txprt.c            |   11 +-
 drivers/staging/speakup/spk_priv.h                 |   11 +-
 drivers/staging/speakup/spk_priv_keyinfo.h         |   11 +-
 drivers/staging/speakup/spk_ttyio.c                |    1 +
 drivers/staging/speakup/synth.c                    |    1 +
 drivers/staging/speakup/thread.c                   |    1 +
 drivers/staging/speakup/varhandlers.c              |    1 +
 drivers/staging/typec/tcpci.c                      |   28 +-
 drivers/staging/typec/tcpci.h                      |   11 +-
 drivers/staging/unisys/Kconfig                     |    4 -
 drivers/staging/unisys/Makefile                    |    1 -
 drivers/staging/unisys/include/iochannel.h         |   15 +-
 drivers/staging/unisys/include/visorchannel.h      |  189 --
 drivers/staging/unisys/visorhba/visorhba_main.c    |   14 +-
 .../staging/unisys/visorinput/ultrainputreport.h   |   11 +-
 drivers/staging/unisys/visorinput/visorinput.c     |   13 +-
 drivers/staging/unisys/visornic/visornic_main.c    |   13 +-
 drivers/staging/vboxvideo/vbox_fb.c                |    2 +-
 drivers/staging/vboxvideo/vbox_main.c              |    2 +-
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c      |   15 +-
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |   15 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |   15 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |   16 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |   15 +-
 .../bcm2835-audio/vc_vchi_audioserv_defs.h         |   15 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   61 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.h  |    7 +-
 .../vc04_services/bcm2835-camera/controls.c        |    5 +-
 .../vc04_services/bcm2835-camera/mmal-common.h     |    5 +-
 .../vc04_services/bcm2835-camera/mmal-encodings.h  |    5 +-
 .../vc04_services/bcm2835-camera/mmal-msg-common.h |    5 +-
 .../vc04_services/bcm2835-camera/mmal-msg-format.h |    5 +-
 .../vc04_services/bcm2835-camera/mmal-msg-port.h   |    5 +-
 .../vc04_services/bcm2835-camera/mmal-msg.h        |    5 +-
 .../vc04_services/bcm2835-camera/mmal-parameters.h |    5 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.c      |   12 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.h      |    5 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |    6 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   12 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |    9 +-
 .../interface/vchiq_arm/vchiq_kern_lib.c           |   50 +-
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c |    3 +-
 drivers/staging/vme/devices/vme_user.c             |   18 +-
 drivers/staging/vt6655/baseband.c                  |   11 +-
 drivers/staging/vt6655/baseband.h                  |   11 +-
 drivers/staging/vt6655/card.c                      |   11 +-
 drivers/staging/vt6655/card.h                      |   11 +-
 drivers/staging/vt6655/channel.c                   |   11 +-
 drivers/staging/vt6655/channel.h                   |   12 +-
 drivers/staging/vt6655/desc.h                      |   11 +-
 drivers/staging/vt6655/device.h                    |   11 +-
 drivers/staging/vt6655/device_cfg.h                |   11 +-
 drivers/staging/vt6655/device_main.c               |   19 +-
 drivers/staging/vt6655/dpc.c                       |   11 +-
 drivers/staging/vt6655/dpc.h                       |   11 +-
 drivers/staging/vt6655/key.c                       |   11 +-
 drivers/staging/vt6655/key.h                       |   11 +-
 drivers/staging/vt6655/mac.c                       |   11 +-
 drivers/staging/vt6655/mac.h                       |   11 +-
 drivers/staging/vt6655/power.c                     |   11 +-
 drivers/staging/vt6655/power.h                     |   11 +-
 drivers/staging/vt6655/rf.c                        |   11 +-
 drivers/staging/vt6655/rf.h                        |   11 +-
 drivers/staging/vt6655/rxtx.c                      |   11 +-
 drivers/staging/vt6655/rxtx.h                      |   11 +-
 drivers/staging/vt6655/srom.c                      |   11 +-
 drivers/staging/vt6655/srom.h                      |   11 +-
 drivers/staging/vt6655/tmacro.h                    |   11 +-
 drivers/staging/vt6655/upc.h                       |   11 +-
 drivers/staging/vt6656/baseband.c                  |   12 +-
 drivers/staging/vt6656/baseband.h                  |   12 +-
 drivers/staging/vt6656/card.c                      |   12 +-
 drivers/staging/vt6656/card.h                      |   12 +-
 drivers/staging/vt6656/channel.c                   |   12 +-
 drivers/staging/vt6656/channel.h                   |   12 +-
 drivers/staging/vt6656/desc.h                      |   12 +-
 drivers/staging/vt6656/device.h                    |   12 +-
 drivers/staging/vt6656/dpc.c                       |   12 +-
 drivers/staging/vt6656/dpc.h                       |   12 +-
 drivers/staging/vt6656/firmware.c                  |   12 +-
 drivers/staging/vt6656/firmware.h                  |   12 +-
 drivers/staging/vt6656/int.c                       |   12 +-
 drivers/staging/vt6656/int.h                       |   12 +-
 drivers/staging/vt6656/key.c                       |   12 +-
 drivers/staging/vt6656/key.h                       |   12 +-
 drivers/staging/vt6656/mac.c                       |   12 +-
 drivers/staging/vt6656/mac.h                       |   12 +-
 drivers/staging/vt6656/main_usb.c                  |   17 +-
 drivers/staging/vt6656/power.c                     |   12 +-
 drivers/staging/vt6656/power.h                     |   12 +-
 drivers/staging/vt6656/rf.c                        |   12 +-
 drivers/staging/vt6656/rf.h                        |   12 +-
 drivers/staging/vt6656/rxtx.c                      |   12 +-
 drivers/staging/vt6656/rxtx.h                      |   12 +-
 drivers/staging/vt6656/usbpipe.c                   |   12 +-
 drivers/staging/vt6656/usbpipe.h                   |   12 +-
 drivers/staging/vt6656/wcmd.c                      |   12 +-
 drivers/staging/vt6656/wcmd.h                      |   12 +-
 drivers/staging/wilc1000/coreconfigurator.c        |    2 +-
 drivers/staging/wilc1000/host_interface.c          |   40 +-
 drivers/staging/wilc1000/linux_wlan.c              |   11 +-
 drivers/staging/wilc1000/wilc_debugfs.c            |    1 +
 drivers/staging/wilc1000/wilc_sdio.c               |    5 +-
 drivers/staging/wilc1000/wilc_spi.c                |   21 +-
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c  |  566 +++---
 drivers/staging/wilc1000/wilc_wfi_netdevice.h      |   29 +-
 drivers/staging/wilc1000/wilc_wlan.c               |    9 +-
 drivers/staging/wilc1000/wilc_wlan_cfg.c           |    6 +-
 drivers/staging/wilc1000/wilc_wlan_if.h            |  100 +-
 drivers/staging/wlan-ng/hfa384x.h                  |    1 +
 drivers/staging/wlan-ng/hfa384x_usb.c              |    7 +-
 drivers/staging/wlan-ng/p80211conv.c               |    1 +
 drivers/staging/wlan-ng/p80211conv.h               |    1 +
 drivers/staging/wlan-ng/p80211hdr.h                |    1 +
 drivers/staging/wlan-ng/p80211ioctl.h              |    1 +
 drivers/staging/wlan-ng/p80211metadef.h            |    1 +
 drivers/staging/wlan-ng/p80211metastruct.h         |    1 +
 drivers/staging/wlan-ng/p80211mgmt.h               |    1 +
 drivers/staging/wlan-ng/p80211msg.h                |    1 +
 drivers/staging/wlan-ng/p80211netdev.c             |    4 +-
 drivers/staging/wlan-ng/p80211netdev.h             |    1 +
 drivers/staging/wlan-ng/p80211req.c                |    1 +
 drivers/staging/wlan-ng/p80211req.h                |    1 +
 drivers/staging/wlan-ng/p80211types.h              |    1 +
 drivers/staging/wlan-ng/p80211wep.c                |    1 +
 drivers/staging/wlan-ng/prism2fw.c                 |    1 +
 drivers/staging/wlan-ng/prism2mgmt.c               |    1 +
 drivers/staging/wlan-ng/prism2mgmt.h               |    1 +
 drivers/staging/wlan-ng/prism2mib.c                |    1 +
 drivers/staging/wlan-ng/prism2sta.c                |    1 +
 drivers/staging/xgifb/XGI_main.h                   |   13 -
 drivers/staging/xgifb/XGI_main_26.c                |  224 +--
 drivers/staging/xgifb/vb_setmode.c                 |   81 +-
 drivers/staging/xgifb/vb_table.h                   |    4 +-
 drivers/{staging/unisys =3D> }/visorbus/Kconfig      |    2 +-
 drivers/{staging/unisys =3D> }/visorbus/Makefile     |    2 -
 .../unisys =3D> }/visorbus/controlvmchannel.h        |   14 +-
 .../{staging/unisys =3D> }/visorbus/vbuschannel.h    |   13 +-
 .../{staging/unisys =3D> }/visorbus/visorbus_main.c  |   13 +-
 .../unisys =3D> }/visorbus/visorbus_private.h        |   13 +-
 .../{staging/unisys =3D> }/visorbus/visorchannel.c   |   13 +-
 .../{staging/unisys =3D> }/visorbus/visorchipset.c   |   20 +-
 fs/Kconfig                                         |    1 -
 fs/Makefile                                        |    1 -
 include/linux/iio/iio.h                            |    4 +-
 include/linux/iio/machine.h                        |    7 +
 include/linux/iio/trigger.h                        |    3 +-
 .../unisys/include =3D> include/linux}/visorbus.h    |  178 +-
 kernel/workqueue.c                                 |    1 +
 net/Kconfig                                        |    1 -
 net/Makefile                                       |    1 -
 819 files changed, 14848 insertions(+), 22474 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/uvis25.txt
 create mode 100644 drivers/iio/light/st_uvis25.h
 create mode 100644 drivers/iio/light/st_uvis25_core.c
 create mode 100644 drivers/iio/light/st_uvis25_i2c.c
 create mode 100644 drivers/iio/light/st_uvis25_spi.c
 create mode 100644 drivers/iio/light/zopt2201.c
 delete mode 100644 drivers/staging/ccree/Documentation/devicetree/bindings=
/crypto/arm-cryptocell.txt
 rename drivers/staging/ccree/{ssi_aead.c =3D> cc_aead.c} (70%)
 rename drivers/staging/ccree/{ssi_aead.h =3D> cc_aead.h} (64%)
 rename drivers/staging/ccree/{ssi_buffer_mgr.c =3D> cc_buffer_mgr.c} (56%)
 create mode 100644 drivers/staging/ccree/cc_buffer_mgr.h
 rename drivers/staging/ccree/{ssi_cipher.c =3D> cc_cipher.c} (58%)
 create mode 100644 drivers/staging/ccree/cc_cipher.h
 create mode 100644 drivers/staging/ccree/cc_debugfs.c
 create mode 100644 drivers/staging/ccree/cc_debugfs.h
 rename drivers/staging/ccree/{ssi_driver.c =3D> cc_driver.c} (52%)
 create mode 100644 drivers/staging/ccree/cc_driver.h
 rename drivers/staging/ccree/{ssi_fips.c =3D> cc_fips.c} (60%)
 create mode 100644 drivers/staging/ccree/cc_fips.h
 rename drivers/staging/ccree/{ssi_hash.c =3D> cc_hash.c} (52%)
 create mode 100644 drivers/staging/ccree/cc_hash.h
 create mode 100644 drivers/staging/ccree/cc_host_regs.h
 rename drivers/staging/ccree/{ssi_ivgen.c =3D> cc_ivgen.c} (62%)
 create mode 100644 drivers/staging/ccree/cc_ivgen.h
 create mode 100644 drivers/staging/ccree/cc_kernel_regs.h
 create mode 100644 drivers/staging/ccree/cc_pm.c
 create mode 100644 drivers/staging/ccree/cc_pm.h
 create mode 100644 drivers/staging/ccree/cc_request_mgr.c
 create mode 100644 drivers/staging/ccree/cc_request_mgr.h
 rename drivers/staging/ccree/{ssi_sram_mgr.c =3D> cc_sram_mgr.c} (50%)
 create mode 100644 drivers/staging/ccree/cc_sram_mgr.h
 delete mode 100644 drivers/staging/ccree/dx_crys_kernel.h
 delete mode 100644 drivers/staging/ccree/dx_host.h
 delete mode 100644 drivers/staging/ccree/dx_reg_common.h
 delete mode 100644 drivers/staging/ccree/hash_defs.h
 delete mode 100644 drivers/staging/ccree/ssi_buffer_mgr.h
 delete mode 100644 drivers/staging/ccree/ssi_cipher.h
 delete mode 100644 drivers/staging/ccree/ssi_config.h
 delete mode 100644 drivers/staging/ccree/ssi_driver.h
 delete mode 100644 drivers/staging/ccree/ssi_fips.h
 delete mode 100644 drivers/staging/ccree/ssi_hash.h
 delete mode 100644 drivers/staging/ccree/ssi_ivgen.h
 delete mode 100644 drivers/staging/ccree/ssi_pm.c
 delete mode 100644 drivers/staging/ccree/ssi_pm.h
 delete mode 100644 drivers/staging/ccree/ssi_request_mgr.c
 delete mode 100644 drivers/staging/ccree/ssi_request_mgr.h
 delete mode 100644 drivers/staging/ccree/ssi_sram_mgr.h
 delete mode 100644 drivers/staging/ccree/ssi_sysfs.c
 delete mode 100644 drivers/staging/ccree/ssi_sysfs.h
 delete mode 100644 drivers/staging/dgnc/dgnc_mgmt.c
 delete mode 100644 drivers/staging/dgnc/dgnc_mgmt.h
 delete mode 100644 drivers/staging/dgnc/dgnc_neo.c
 delete mode 100644 drivers/staging/dgnc/dgnc_neo.h
 delete mode 100644 drivers/staging/dgnc/dgnc_pci.h
 delete mode 100644 drivers/staging/dgnc/dgnc_utils.c
 delete mode 100644 drivers/staging/dgnc/dgnc_utils.h
 delete mode 100644 drivers/staging/fsl-mc/README.txt
 delete mode 100644 drivers/staging/fsl-mc/bus/dpmcp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpmcp.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpmng-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dprc-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dprc.h
 create mode 100644 drivers/staging/fsl-mc/overview.rst
 rename {net =3D> drivers/staging}/ipx/Kconfig (99%)
 rename {net =3D> drivers/staging}/ipx/Makefile (100%)
 create mode 100644 drivers/staging/ipx/TODO
 rename {net =3D> drivers/staging}/ipx/af_ipx.c (100%)
 rename {net =3D> drivers/staging}/ipx/ipx_proc.c (100%)
 rename {net =3D> drivers/staging}/ipx/ipx_route.c (100%)
 rename {net =3D> drivers/staging}/ipx/pe2.c (100%)
 rename {net =3D> drivers/staging}/ipx/sysctl_net_ipx.c (100%)
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/libcfs_work=
item.h
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/prng.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/workitem.c
 create mode 100644 drivers/staging/most/Documentation/ABI/sysfs-bus-most.t=
xt
 delete mode 100644 drivers/staging/most/aim-cdev/Makefile
 delete mode 100644 drivers/staging/most/aim-network/Makefile
 delete mode 100644 drivers/staging/most/aim-sound/Makefile
 delete mode 100644 drivers/staging/most/aim-v4l2/Makefile
 rename drivers/staging/most/{aim-cdev =3D> cdev}/Kconfig (70%)
 create mode 100644 drivers/staging/most/cdev/Makefile
 rename drivers/staging/most/{aim-cdev =3D> cdev}/cdev.c (68%)
 create mode 100644 drivers/staging/most/core.c
 rename drivers/staging/most/{mostcore/mostcore.h =3D> core.h} (84%)
 rename drivers/staging/most/{hdm-dim2 =3D> dim2}/Kconfig (83%)
 create mode 100644 drivers/staging/most/dim2/Makefile
 rename drivers/staging/most/{hdm-dim2/dim2_hdm.c =3D> dim2/dim2.c} (96%)
 rename drivers/staging/most/{hdm-dim2/dim2_hdm.h =3D> dim2/dim2.h} (54%)
 rename drivers/staging/most/{hdm-dim2/dim2_errors.h =3D> dim2/errors.h} (7=
3%)
 rename drivers/staging/most/{hdm-dim2/dim2_hal.c =3D> dim2/hal.c} (98%)
 rename drivers/staging/most/{hdm-dim2/dim2_hal.h =3D> dim2/hal.h} (88%)
 rename drivers/staging/most/{hdm-dim2/dim2_reg.h =3D> dim2/reg.h} (89%)
 create mode 100644 drivers/staging/most/dim2/sysfs.c
 create mode 100644 drivers/staging/most/dim2/sysfs.h
 delete mode 100644 drivers/staging/most/hdm-dim2/Makefile
 delete mode 100644 drivers/staging/most/hdm-dim2/dim2_sysfs.c
 delete mode 100644 drivers/staging/most/hdm-dim2/dim2_sysfs.h
 delete mode 100644 drivers/staging/most/hdm-i2c/Makefile
 delete mode 100644 drivers/staging/most/hdm-usb/Makefile
 rename drivers/staging/most/{hdm-i2c =3D> i2c}/Kconfig (72%)
 create mode 100644 drivers/staging/most/i2c/Makefile
 rename drivers/staging/most/{hdm-i2c/hdm_i2c.c =3D> i2c/i2c.c} (95%)
 delete mode 100644 drivers/staging/most/mostcore/Kconfig
 delete mode 100644 drivers/staging/most/mostcore/Makefile
 delete mode 100644 drivers/staging/most/mostcore/core.c
 rename drivers/staging/most/{aim-network =3D> net}/Kconfig (69%)
 create mode 100644 drivers/staging/most/net/Makefile
 rename drivers/staging/most/{aim-network/networking.c =3D> net/net.c} (87%)
 rename drivers/staging/most/{aim-sound =3D> sound}/Kconfig (72%)
 create mode 100644 drivers/staging/most/sound/Makefile
 rename drivers/staging/most/{aim-sound =3D> sound}/sound.c (95%)
 rename drivers/staging/most/{hdm-usb =3D> usb}/Kconfig (77%)
 create mode 100644 drivers/staging/most/usb/Makefile
 rename drivers/staging/most/{hdm-usb/hdm_usb.c =3D> usb/usb.c} (85%)
 rename drivers/staging/most/{aim-v4l2 =3D> video}/Kconfig (71%)
 create mode 100644 drivers/staging/most/video/Makefile
 rename drivers/staging/most/{aim-v4l2 =3D> video}/video.c (74%)
 rename {fs =3D> drivers/staging}/ncpfs/Kconfig (100%)
 rename {fs =3D> drivers/staging}/ncpfs/Makefile (100%)
 create mode 100644 drivers/staging/ncpfs/TODO
 rename {fs =3D> drivers/staging}/ncpfs/dir.c (100%)
 rename {fs =3D> drivers/staging}/ncpfs/file.c (100%)
 rename {fs =3D> drivers/staging}/ncpfs/getopt.c (100%)
 rename {fs =3D> drivers/staging}/ncpfs/getopt.h (100%)
 rename {fs =3D> drivers/staging}/ncpfs/inode.c (99%)
 rename {fs =3D> drivers/staging}/ncpfs/ioctl.c (100%)
 rename {fs =3D> drivers/staging}/ncpfs/mmap.c (100%)
 rename {fs =3D> drivers/staging}/ncpfs/ncp_fs.h (100%)
 rename {fs =3D> drivers/staging}/ncpfs/ncp_fs_i.h (100%)
 rename {fs =3D> drivers/staging}/ncpfs/ncp_fs_sb.h (100%)
 rename {fs =3D> drivers/staging}/ncpfs/ncplib_kernel.c (100%)
 rename {fs =3D> drivers/staging}/ncpfs/ncplib_kernel.h (100%)
 rename {fs =3D> drivers/staging}/ncpfs/ncpsign_kernel.c (100%)
 rename {fs =3D> drivers/staging}/ncpfs/ncpsign_kernel.h (100%)
 rename {fs =3D> drivers/staging}/ncpfs/sock.c (100%)
 rename {fs =3D> drivers/staging}/ncpfs/symlink.c (100%)
 delete mode 100644 drivers/staging/unisys/include/visorchannel.h
 rename drivers/{staging/unisys =3D> }/visorbus/Kconfig (94%)
 rename drivers/{staging/unisys =3D> }/visorbus/Makefile (81%)
 rename drivers/{staging/unisys =3D> }/visorbus/controlvmchannel.h (97%)
 rename drivers/{staging/unisys =3D> }/visorbus/vbuschannel.h (85%)
 rename drivers/{staging/unisys =3D> }/visorbus/visorbus_main.c (98%)
 rename drivers/{staging/unisys =3D> }/visorbus/visorbus_private.h (78%)
 rename drivers/{staging/unisys =3D> }/visorbus/visorchannel.c (95%)
 rename drivers/{staging/unisys =3D> }/visorbus/visorchipset.c (98%)
 rename {drivers/staging/unisys/include =3D> include/linux}/visorbus.h (52%)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
