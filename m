Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3946214-1519035235-2-7172261421520572020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035234; b=M2p5hVaLsiu62Q52UAV2JAtYyJSQgSAyj1RgYNCaW3RoRr4
    WCi9cFUARI0xALRwieetcx8eSRu56jiKo54oB/JWRqkW21nW2wsAjCO46Ykkr+Ur
    scYdx36qieA0tfxk2cZuL++At5tcXzOUapqtkmxXDQo1ig6Ysekk6KeIBV5U9lBw
    IV/UJZ1gLUE03Y17kbqTlD8bQa4ILs6LQ+5IERxK/G2t/fCvIIUTZZ+Xjpt9lnTf
    4cChwWwfU/AoxnoeZlBwbbAylDM+O9uVtuZ/IIIDFcgJYveWaH6tWVGRTJhOhHyo
    p6dJwxaFAN1mwKR0Z3UcrmFeyXaN/VhqKVPX+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519035234; bh=Ejx+iKp5DS+6sIwMPGLiU5afO/
    zyNNZ+JHXvZen654Y=; b=OHb61kTJBa5J47w5Yno0rPs0UYgOfqpC5jWboYKXfn
    FpLBWk9gqPskTc/socp7k66GPlyUREWUmkzhQnK3jhYgZ2ysr9VLx5aLJk2UwBZg
    Q2NH7gBcT389zzditehLvWBwXukhJH8m0KM8PSSuRzjzq9VvV72Tb8iOzT9J5ANc
    1sW5t1iokdpuoccwLWioy3x70rM7qoA/reLxXPRTwSwaFYV/6PlQ5UiZrVzXgIf4
    qOU8GhUj0uwWkvARppXadgXQB021OtGtKbBQndq7/+leWcn9lk1C17ECjqBGjluR
    9U+p3iEb3tfRb5sY39PtJ4YYJUQmPZQ7V/ZuxpDWALPw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBSKNw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:13:52 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:47169 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbeBSKNv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 05:13:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [4.9-stable 0/9] patches for 'randconfig' 
Date: Mon, 19 Feb 2018 11:13:19 +0100
Message-Id: <20180219101343.2922561-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:DwdGXybDsJjgbHvfjnd9YJb7LYwb01fPrPCKiBsvXp/91gyr55a
 fHFPdIsnecZ+uMPgNTmM0ICRn1nFvHhLc9quF0j++RSb4Sj4Fia34V4bqoE/Sgcn5gwBTKj
 wM3Lu9PU48aqv7Ffe1pN8uS/PoKz4ABf/UAsUMny3Z29sGsiUw3g/oZ07kRsFIHr0cnSLTW
 waHaw9sJSqw/l5sTAk3uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Tu0UQ4Er97A=:aR7H6WTaMlIiuqrzsbheMg
 G7uvy9/nsKr5IDiPux9uzGL7RXQjrUT76BDqqzZlLRywcW+PZKP8ZWC5RpplOKcxjKuJcBCRg
 d0jpuPgGwGifo+HRPI6Ddeqa6+7jW/Ur30iRwo3orLfVT+edG5JMT+ZSv5S2Yyy2+BSn/1zLE
 tOfMZPxV6zjXej1w9WTLtQYB+anXiHyc7RFNp6sx+D0l5AT/2H+tsIo2F7VyfN++u3Xzi/UT9
 LmMi0hTcdApngr8j91/eipMLm/CZl3+76TEjJ2Kee6CEhZ8YY2Lyf8vG78OjLeWJxnq2mFUvC
 xXbX7NWdRhz/SKkbX3miMSCDcYguqCYgJxqoCFeMS/Xp0oqZ2gI91cmb3hTKtvmjZPkNIfwYN
 cXy/yeu9uA/41sg5EN7c4yuiyIKAroRZyB+vbf2n54eaoVRGai4Y4nraXqIgp98a3dPykHB2G
 OGDu3Wfzl7q30XFYcOrn5hlkzEktGN7giRi/A+BXWEDdodYK6tRiH7HBXs+aPvju2266Q3H1x
 G8TS0PE2DtIXsqzaWHU4jlREiqkGnrtS0jyfThKHgcPN/0PDUZLE41AqZ7MEPi7LMhW1cRCOu
 uAm2KOKiEWUEgF6s3/KLlQ+uy+kxKfkvo7pON3BDJetVMw9KPjZ9Yp0GM18ERC/MlQbN3oi4i
 5FGH+yyPQwLjAQoZxbDCEAXIi8CcA5+zla3GxTjEoz4qzpE4Bw5qqldlU6lyxPYgq0tLy5gSR
 wxJnakQn/jPlWJt7v2EwW5wOW1jrHKQ+7UFkPg==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As discussed with Greg, I've had my randconfig builder build 4.9-stable kernels
over the weekend, here is what it found missing. There are 45 patches that can
be backported cleanly from mainline, plus another 9 that are either not part of
mainline because the problem no longer exists there (e.g. file was removed), or
the backport required context changes.

Most of these should also apply to 4.4, but I have not tried that yet.

       Arnd

ac29fc66855b drm/i915: fix intel_backlight_device_register declaration
23f919d4ad0e shmem: avoid maybe-uninitialized warning
aa01338c0184 clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER
fbdf0e28d061 vmxnet3: prevent building with 64K pages
11d8b05855f3 perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
42db500a551f PCI: vmd: Fix suspend handlers defined-but-not-used warning
fbc2a294f29e gpio: intel-mid: Fix build warning when !CONFIG_PM
b4aca383f9af platform/x86: intel_mid_thermal: Fix suspend handlers unused warning
c8bd2ac3b4c6 usb: musb: fix compilation warning on unused function
de5bbdd01cf9 PCI: Change pci_host_common_probe() visibility
c0bfc549e962 perf: xgene: Include module.h
484c7bbf2649 video: fbdev: via: remove possibly unused variables
067fdeb2f391 dmaengine: zx: fix build warning
f46e7cd36b5f scsi: advansys: fix build warning for PCI=n
d4b2ac63b0ea x86/ras/inject: Make it depend on X86_LOCAL_APIC=y
b115bebc07f2 gpio: xgene: mark PM functions as __maybe_unused
f13d52cb3fad arm64: define BUG() instruction without CONFIG_BUG
75e2f0a6b161 x86/fpu/math-emu: Fix possible uninitialized variable use
e572d0887137 tools build: Add tools tree support for 'make -s'
d460131dd505 x86/build: Silence the build with "make -s"
68fd77cf8a4b thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
c2ce3f5d89d5 x86: add MULTIUSER dependency for KVM
d689c64d189e x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG
3ba5b5ea7dc3 x86/vm86: Fix unused variable warning if THP is disabled
44a5b977128c scsi: advansys: fix uninitialized data access
2e449048a25e arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set
46a049dae771 ALSA: hda/ca0132 - fix possible NULL pointer use
ab4949640d66 reiserfs: avoid a -Wmaybe-uninitialized warning
7fc1503c906f cw1200: fix bogus maybe-uninitialized warning
3cd18d198173 security/keys: BIG_KEY requires CONFIG_CRYPTO
7e1751001818 drm: exynos: mark pm functions as __maybe_unused
9e343e87d2c4 mtd: cfi: convert inline functions to macros
3cd890dbe2a4 media: dvb-frontends: fix i2c access helpers for KASAN
d4c2269b3d5d rbd: silence bogus -Wmaybe-uninitialized warning
b74c0a9969f2 drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized
ea4348c8462a Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning
16c3ada89cff media: r820t: fix r820t_write_reg for KASAN
e42eef4ba388 KVM: add X86_LOCAL_APIC dependency
f1f5929cd971 shmem: fix compilation warnings on unused functions
3538aa6ecfb2 [media] tc358743: fix register i2c_rd/wr functions
fa6317eedd63 [media] go7007: add MEDIA_CAMERA_SUPPORT dependency
190b23b4eb99 [media] em28xx: only use mt9v011 if camera support is enabled
27430d19a916 [media] tw5864: use dev_warn instead of WARN to shut up warning
27d807180ae0 ISDN: eicon: reduce stack size of sig_ind function
dbed87a9d3a8 clk: meson: gxbb: fix build error without RESET_CONTROLLER

Arnd Bergmann (8):
  kasan: rework Kconfig settings
  drm/i915: hide unused intel_panel_set_backlight function
  arm64: sunxi: always enable reset controller
  binfmt_elf: compat: avoid unused function warning
  spi: bcm-qspi: shut up warning about cfi header inclusion
  idle: i7300: add PCI dependency
  arm64: fix warning about swapper_pg_dir overflow
  usb: phy: msm add regulator dependency

Borislav Petkov (1):
  x86/microcode/AMD: Change load_microcode_amd()'s param to bool to fix
    preemptibility bug

 arch/arm64/Kconfig.platforms         |  2 +
 arch/arm64/mm/mmu.c                  |  2 +-
 arch/x86/include/asm/microcode_amd.h |  1 -
 arch/x86/kernel/cpu/microcode/amd.c  | 17 ++++---
 drivers/gpu/drm/i915/intel_panel.c   | 86 ++++++++++++++++++------------------
 drivers/idle/Kconfig                 |  1 +
 drivers/spi/Kconfig                  |  1 +
 drivers/usb/phy/Kconfig              |  1 +
 fs/compat_binfmt_elf.c               |  2 +
 lib/Kconfig.debug                    |  1 -
 10 files changed, 62 insertions(+), 52 deletions(-)

-- 
2.9.0
