Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3957578-1519034664-2-14368155781244648107
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519034663; b=rjlv34JDeKiHHi1SSPmfQFiVyq/cZgnD9H4xHesq22nOAG7
    8TpBXURMPcnII6KuNmgsQZdWJ3QCWM/YN4GbplhZn4ProY3+f9Va0e+62hAmezFa
    F2tvHCZa1b7PnTpclnRM5ITsf0vQSEnkUzz61GpobJl4EQ66GxwzH7OO+JHlhgcV
    lcBcbRnXD2AnHLrSq5tNF51Jak04Y19ofMuL+i9niDsKIcKyvfgk0TPaxWJiUu2T
    zS5Q8+1kr4GmNrbgvVWZKO9ZVFJIqD3jhFfhXIa06xxIZsPAUacUaI7gBppFCnMI
    7KOsnaHOvV7fjNnMpk9/PUlM62kpxoWGlmVmPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519034663; bh=AQyU896U02jlneCEs8VponKsrv7wvG8X8F9VR9
    UXh60=; b=EDs9UteZzGeyElfkcoOg5O4yOwyRaMoEI70aByvyLLLom8SlamJ+3b
    9GVt610O16he2TzxSa7mYXEBQi5dCEtMvrp4UBoVPbpP72Wd4tIsGr0C6IJ9sOtl
    /39+L7D2ZLzRqkM6++w1UlXX8Fcq774lFZ8tC3+ULHvYn558okCbgoOwjer4TzT6
    PKYi+l9/WPpJGhZzF9JQYbQX5BPLMxTFV3NfnbA3A5q/NuimKhU7ILqGucC+IDd4
    pZ3XUiS1gxAgOartbp87r8bvUYrLq30QETSgaZilfVsYUp8PnanoyIguQ4phHPF1
    xrALfadYN3rnbL5Co/VI5pNPdsLeLrrw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VDFz75YS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EsofbI2H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VDFz75YS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EsofbI2H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeBSKEW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:04:22 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35535 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeBSKEU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 05:04:20 -0500
X-Google-Smtp-Source: AH8x226fKASWAkuQRU0aMJUdQbGs8YSt/qc9+z2ahIL6foVxMthC1DfhRs8rI8Su97VfJnRSEiXKVy7Uhh37i4kqEMw=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0YwGfO=XTcNzA2pbxjUTc=AsC8geX7Lbqwmq==jeRhmg@mail.gmail.com>
References: <20171206141627.688219-1-arnd@arndb.de> <CAK8P3a0ZN2ALu1tj9sm8-Lt9SsRgpbQtz91zR4MhY-Np7TQNyg@mail.gmail.com>
 <af5124d4-b2cc-7d3c-5b8e-f7381859efd6@linux.intel.com> <CAK8P3a3pyM2FwHcAvFQckvbfqt7WvgRYSWE97pwLAtdvd77ToQ@mail.gmail.com>
 <20180215054357.GC7377@kroah.com> <CAK8P3a0hTbb+zRPH6nXVEdxP7zJyu5mYcjLqnWd4AfG_=Yrm-w@mail.gmail.com>
 <20180215164343.GA6230@kroah.com> <CAK8P3a0YwGfO=XTcNzA2pbxjUTc=AsC8geX7Lbqwmq==jeRhmg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Feb 2018 11:04:18 +0100
X-Google-Sender-Auth: OFa8PxduMEPSqMwOIpSO0i6W0Do
Message-ID: <CAK8P3a2ZZMHQ0B=w=qy-rcG21ShZ6ycvcP4M4ZPNwN2EadQA3Q@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/kaiser: avoid 32-bit/PAE build warning
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 10:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Feb 15, 2018 at 5:43 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Thu, Feb 15, 2018 at 04:37:10PM +0100, Arnd Bergmann wrote:
>>> In order to test this, I backported some 35 other (mostly trivial) patches later
>>> kernels, and now I have a 4.9.80 based tree that produces a clean randconfig
>>> build every time on arm64 and x86_64. If you want, I'll send you the list
>>> of the required backports as well. From what I can tell, they are all
>>> harmless (unused functions, missing Kconfig dependencies etc), but
>>> being able to do randconfig builds reliable gives us an additional tool for
>>> regression testing the stable kernels.
>>
>> Sure, I'll be glad to take those.
>
> Here are the ones that I think should apply cleanly
>
> ac29fc66855b drm/i915: fix intel_backlight_device_register declaration
> 23f919d4ad0e shmem: avoid maybe-uninitialized warning
> aa01338c0184 clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER
> fbdf0e28d061 vmxnet3: prevent building with 64K pages
> 11d8b05855f3 perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
> 42db500a551f PCI: vmd: Fix suspend handlers defined-but-not-used warning
> fbc2a294f29e gpio: intel-mid: Fix build warning when !CONFIG_PM
> b4aca383f9af platform/x86: intel_mid_thermal: Fix suspend handlers
> unused warning
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
> 2e449048a25e arm64: Kconfig: select COMPAT_BINFMT_ELF only when
> BINFMT_ELF is set
> 46a049dae771 ALSA: hda/ca0132 - fix possible NULL pointer use
> ab4949640d66 reiserfs: avoid a -Wmaybe-uninitialized warning

and some more:

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

There are a few more that that don't apply cleanly or that I had to
write from scratch,
I'll follow up with a patch series to stable@v.k.o.

      Arnd
