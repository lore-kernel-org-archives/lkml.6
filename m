Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3243972-1519400612-2-7307752555729342750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519400612; b=BgwPyxKUsAmdR4+DZIrcVqepmXJN8BMMJM9oD+g/P234sj8
    aontX/rqRTdFDLXBzxFyks3P0Qryr8euwDm9t1Mm2gPxbFV+13+8No3FKmUbtdQ+
    NhuHNRmddJwSzopckLaRrXe9zlKwofNTfaZCrYuNxY62g0EY48w/TeZg0w6+PEAh
    PbRBDViL052pV+gwL6hEd5LwpfGgFgAFKUPH8WZ/w1qG7XGBhLrl0SGRZBI3PKfD
    yQa+X02P7/KhO4AmF2QLds1pu9WXWEMMRYiDHjKdcQkuYwDZiX7YCH2nKfcyic1H
    VCU8I5iBDOUQCcRxXaLsieAwxU6KGq52MPUGIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519400612; bh=RAsU/i08kCE5NYE4vUu8NDPtLA
    n/IVUruV0dSbvLwyQ=; b=lRx0vCJ3YmsvdMzZB2koorpGCwTiZxiaFlIP2BzgGK
    9t9zW8a2XUrvCkp7EARo061J7TELcXa+UA6qxmrc7TUwfjMQjgZOLyOL04XAOUdb
    djvI3ZvYGOsF8mKufIeIVByDUAkCur5V02jAsl/KfmFMQjV2tiGqKinkgMZArFp9
    9lWQx9c4u0B02bR7qJYwGV2mf/yu7/bJt5VQeYC1zIZ0adqqrUNLuc3MgBKqG6/Z
    Bbw2Up4LT9tCE5CDrTQ6Ef1DVqSNL5Ld8QUZQhvJNb4rDXxWWxLZyjFR5cqR8Sr/
    VkQSHR1ykY5oNH5LyhOS6JnlZwnZ8fUldYOFAEf04kqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeBWPnb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 10:43:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeBWPna (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 10:43:30 -0500
Date: Fri, 23 Feb 2018 16:42:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [4.9-stable 0/9] patches for 'randconfig'
Message-ID: <20180223154244.GA9812@kroah.com>
References: <20180219101343.2922561-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219101343.2922561-1-arnd@arndb.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 11:13:19AM +0100, Arnd Bergmann wrote:
> As discussed with Greg, I've had my randconfig builder build 4.9-stable kernels
> over the weekend, here is what it found missing. There are 45 patches that can
> be backported cleanly from mainline, plus another 9 that are either not part of
> mainline because the problem no longer exists there (e.g. file was removed), or
> the backport required context changes.
> 
> Most of these should also apply to 4.4, but I have not tried that yet.
> 
>        Arnd
> 
> ac29fc66855b drm/i915: fix intel_backlight_device_register declaration
> 23f919d4ad0e shmem: avoid maybe-uninitialized warning
> aa01338c0184 clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER
> fbdf0e28d061 vmxnet3: prevent building with 64K pages
> 11d8b05855f3 perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
> 42db500a551f PCI: vmd: Fix suspend handlers defined-but-not-used warning
> fbc2a294f29e gpio: intel-mid: Fix build warning when !CONFIG_PM
> b4aca383f9af platform/x86: intel_mid_thermal: Fix suspend handlers unused warning
> c8bd2ac3b4c6 usb: musb: fix compilation warning on unused function
> de5bbdd01cf9 PCI: Change pci_host_common_probe() visibility
> c0bfc549e962 perf: xgene: Include module.h
> 484c7bbf2649 video: fbdev: via: remove possibly unused variables
> 067fdeb2f391 dmaengine: zx: fix build warning
> f46e7cd36b5f scsi: advansys: fix build warning for PCI=n
> d4b2ac63b0ea x86/ras/inject: Make it depend on X86_LOCAL_APIC=y
> b115bebc07f2 gpio: xgene: mark PM functions as __maybe_unused
> f13d52cb3fad arm64: define BUG() instruction without CONFIG_BUG
> 75e2f0a6b161 x86/fpu/math-emu: Fix possible uninitialized variable use
> e572d0887137 tools build: Add tools tree support for 'make -s'
> d460131dd505 x86/build: Silence the build with "make -s"
> 68fd77cf8a4b thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
> c2ce3f5d89d5 x86: add MULTIUSER dependency for KVM
> d689c64d189e x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG
> 3ba5b5ea7dc3 x86/vm86: Fix unused variable warning if THP is disabled
> 44a5b977128c scsi: advansys: fix uninitialized data access
> 2e449048a25e arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set
> 46a049dae771 ALSA: hda/ca0132 - fix possible NULL pointer use
> ab4949640d66 reiserfs: avoid a -Wmaybe-uninitialized warning
> 7fc1503c906f cw1200: fix bogus maybe-uninitialized warning
> 3cd18d198173 security/keys: BIG_KEY requires CONFIG_CRYPTO
> 7e1751001818 drm: exynos: mark pm functions as __maybe_unused
> 9e343e87d2c4 mtd: cfi: convert inline functions to macros
> 3cd890dbe2a4 media: dvb-frontends: fix i2c access helpers for KASAN
> d4c2269b3d5d rbd: silence bogus -Wmaybe-uninitialized warning
> b74c0a9969f2 drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized
> ea4348c8462a Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning
> 16c3ada89cff media: r820t: fix r820t_write_reg for KASAN
> e42eef4ba388 KVM: add X86_LOCAL_APIC dependency
> f1f5929cd971 shmem: fix compilation warnings on unused functions
> 3538aa6ecfb2 [media] tc358743: fix register i2c_rd/wr functions
> fa6317eedd63 [media] go7007: add MEDIA_CAMERA_SUPPORT dependency
> 190b23b4eb99 [media] em28xx: only use mt9v011 if camera support is enabled
> 27430d19a916 [media] tw5864: use dev_warn instead of WARN to shut up warning
> 27d807180ae0 ISDN: eicon: reduce stack size of sig_ind function
> dbed87a9d3a8 clk: meson: gxbb: fix build error without RESET_CONTROLLER

All of those patches are now queued up, along with the 9 you attached
"by hand" here.  Many thanks for them.

greg k-h
