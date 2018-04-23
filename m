Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755401AbeDWN4u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:56:50 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:46612 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755264AbeDWN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:56:44 -0400
X-Google-Smtp-Source: AIpwx49gwdrtF4a0TXO4GjVr+TlcmvW40/him53farjeaHJleEVLgbZ4KVrb+3hVAgOZ16A1WnRE+4LRDFfiDdrNekY=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 23 Apr 2018 15:56:41 +0200
Message-ID: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
Subject: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status update
To: Matthias Kaehlcke <mka@chromium.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        JF Bastien <jfb@google.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ CC Nick ]
[ CC Arnd ]
[ CC JF ]

Hi Matthias,

I was following [1] a bit and fell over your original posting in [2].

I wrote some early documentation (wiki) and tested/booted a
clang-compiled kernel on x86-64 bare metal.
The project was called "lll-project" these days.
The followup - LLVMlinux project - seems to be somehow dead?

After reading your posting, I got really excited and had a quick look
over the Linux v4.9.y-LTS patch-stack with additional stuff:

$ git fetch https://chromium.googlesource.com/chromiumos/third_party/kernel
refs/sandbox/mka/llvm/v4.9_ext
$ git checkout -b llvm_v4.9_ext FETCH_HEAD

I like your commit subjects and messages.

Before starting to compile I have some questions, I hope you can answer them.

[ CLANG-VERSION ]

Here on Debian/testing (will get Version 10 with codename "buster")
AMD64 I have the choice of installing CLANG v4.0.1, v5.0.1 and v6.0.0.
As you point out LLVM/CLANG v5.0 or higher are a good and faster
choice than v4.0.
Using CLANG >= 5.0 makes the *CLANG* patch-series obsolete?

[ REFRESH PATCH-STACK ]

What about the *FROMGIT* and *CUSTOM* patch-series?
Are they in upstream in the meantime?
If yes, will you refresh this v4.9.y-LTS patch-stack?

[ ASM-GOTO ]

Foremore, I have seen you have a "refs/sandbox/mka/llvm/v4.14" Git branch.
Linux v4.14 is also an LTS release.
After Linux v4.9 "asm-goto" support was added which is GCC specific.
Is there a workaround to compile Linux-kernel with any CLANG version?
You happen to know the status in LLVM upstream?

[ X86-EFLAGS/IF ]

AFAICS, I remember an EFLAGS/IF problem on X86 and interrupt handling.
You happen to know if this is fixed in LLVM upstream?
Some LLVM developers were interested in fixing this.
Can you comment on this, JF (we had some email conversation in private in 2016)?

I am looking forward to hearing from you.

Best regards,
- Sedat -

References:
[1] https://marc.info/?l=linux-kernel&m=152425978517449&w=2
[2] https://marc.info/?l=linux-kernel&m=150344365613264&w=2
[3] https://bugs.llvm.org/show_bug.cgi?id=9295

References from JF:
[0] Hans' fix: http://reviews.llvm.org/D15240
[1] my original pushf/popf disable: http://reviews.llvm.org/D6629
[2] More effort, such as: http://reviews.llvm.org/D15157

P.S.: Your Linux v4.9.y-LTS patch-stack

[ UPSTREAM ]
0001-UPSTREAM-kbuild-Add-better-clang-cross-build-support.patch
0002-UPSTREAM-kbuild-clang-add-no-integrated-as-to-KBUILD.patch
0003-UPSTREAM-kbuild-Consolidate-header-generation-from-A.patch
0004-UPSTREAM-kbuild-consolidate-redundant-sed-script-ASM.patch
0005-UPSTREAM-kbuild-fix-asm-offset-generation-to-work-wi.patch
0006-UPSTREAM-kbuild-drop-Wno-unknown-warning-option-from.patch
0007-UPSTREAM-kbuild-LLVMLinux-Add-Werror-to-cc-option-to.patch
0008-UPSTREAM-kbuild-use-Oz-instead-of-Os-when-using-clan.patch
0009-UPSTREAM-kbuild-Add-support-to-generate-LLVM-assembl.patch
0010-UPSTREAM-modules-mark-__inittest-__exittest-as-__may.patch
0011-UPSTREAM-compiler-clang-suppress-warning-for-unused-.patch
0012-UPSTREAM-compiler-clang-properly-override-inline-for.patch
0013-UPSTREAM-x86-kbuild-Use-cc-option-to-enable-falign-j.patch
0014-UPSTREAM-crypto-x86-aesni-fix-token-pasting-for-clan.patch
0015-UPSTREAM-x86-mm-kaslr-Use-the-_ASM_MUL-macro-for-mul.patch
0016-UPSTREAM-kbuild-Add-__cc-option-macro.patch
0017-UPSTREAM-x86-build-Use-__cc-option-for-boot-code-com.patch
0018-UPSTREAM-x86-build-Specify-stack-alignment-for-clang.patch
0019-UPSTREAM-kbuild-clang-Disable-address-of-packed-memb.patch
0020-UPSTREAM-crypto-arm64-sha-avoid-non-standard-inline-.patch
0021-UPSTREAM-llist-clang-introduce-member_address_is_non.patch
0022-UPSTREAM-x86-boot-undef-memcpy-et-al-in-string.c.patch
0023-UPSTREAM-compiler-clang-always-inline-when-CONFIG_OP.patch
0024-UPSTREAM-efi-libstub-arm64-Use-hidden-attribute-for-.patch
0025-UPSTREAM-efi-libstub-arm64-Force-hidden-visibility-f.patch
0026-UPSTREAM-efi-libstub-arm64-Set-fpie-when-building-th.patch
0027-UPSTREAM-x86-build-Fix-stack-alignment-for-CLang.patch
0028-UPSTREAM-x86-build-Use-cc-option-to-validate-stack-a.patch
0029-UPSTREAM-x86-asm-Fix-inline-asm-call-constraints-for.patch
0030-UPSTREAM-x86-asm-Fix-inline-asm-call-constraints-for.patch
0031-UPSTREAM-Kbuild-use-fshort-wchar-globally.patch
0043-UPSTREAM-arm64-ensure-extension-of-smp_store_release.patch
0044-UPSTREAM-arm64-xchg-hazard-against-entire-exchange-v.patch
0045-UPSTREAM-arm64-uaccess-ensure-extension-of-access_ok.patch
0046-UPSTREAM-arm64-armv8_deprecated-ensure-extension-of-.patch
0047-UPSTREAM-arm64-atomic_lse-match-asm-register-sizes.patch
0048-UPSTREAM-arm64-uaccess-suppress-spurious-clang-warni.patch
0049-UPSTREAM-drm-i915-Remove-unused-BSM_MASK-causing-war.patch
0050-UPSTREAM-audit-add-tty-field-to-LOGIN-event.patch
0051-UPSTREAM-audit-move-audit_get_tty-to-reduce-scope-an.patch
0052-UPSTREAM-media-uvcvideo-Fix-a-wrong-macro.patch
0053-UPSTREAM-dmaengine-Fix-array-index-out-of-bounds-war.patch
0054-UPSTREAM-hpet-Make-cmd-parameter-of-hpet_ioctl_commo.patch
0055-UPSTREAM-ALSA-hda-ca0132-Remove-double-parentheses.patch
0056-UPSTREAM-selinux-Remove-unnecessary-check-of-array-b.patch
0057-UPSTREAM-mac80211-Fix-clang-warning-about-constant-o.patch
0058-UPSTREAM-cpumask-Add-helper-cpumask_available.patch
0059-UPSTREAM-genirq-Use-cpumask_available-for-check-of-c.patch
0060-UPSTREAM-cfg80211-Fix-array-bounds-warning-in-fragme.patch
0061-UPSTREAM-mac80211-ibss-Fix-channel-type-enum-in-ieee.patch
0062-UPSTREAM-nl80211-Fix-enum-type-of-variable-in-nl8021.patch
0063-UPSTREAM-ALSA-hda-ca0132-Limit-values-for-chip-addre.patch
0064-UPSTREAM-media-vcodec-mediatek-Remove-double-parenth.patch
0065-UPSTREAM-misc-lkdtm-Add-volatile-to-intentional-NULL.patch
0066-UPSTREAM-jiffies.h-declare-jiffies-and-jiffies_64-wi.patch
0067-UPSTREAM-fs-compat-Remove-warning-from-COMPATIBLE_IO.patch
0068-UPSTREAM-dm-ioctl-remove-double-parentheses.patch
0069-UPSTREAM-ath9k-Add-cast-to-u8-to-FREQ2FBIN-macro.patch
0070-UPSTREAM-tracing-Use-cpumask_available-to-check-if-c.patch
0071-UPSTREAM-netfilter-ctnetlink-Make-some-parameters-in.patch
0072-UPSTREAM-selinux-Remove-redundant-check-for-unknown-.patch
0076-UPSTREAM-x86-boot-Disable-the-address-of-packed-memb.patch
0077-UPSTREAM-zram-rework-copy-of-compressor-name-in-comp.patch
0078-UPSTREAM-arm64-avoid-overflow-in-VA_START-and-PAGE_O.patch
0079-UPSTREAM-bitops-avoid-integer-overflow-in-GENMASK-_U.patch
0080-UPSTREAM-btrfs-Remove-extra-parentheses-from-conditi.patch
0081-UPSTREAM-netpoll-Fix-device-name-check-in-netpoll_se.patch

[ BACKPORT ]
0032-BACKPORT-kbuild-fix-linker-feature-test-macros-when-.patch
0033-BACKPORT-kbuild-Set-KBUILD_CFLAGS-before-incl.-arch-.patch
0034-BACKPORT-crypto-arm64-aes-ce-cipher-move-assembler-c.patch
0073-BACKPORT-clocksource-Use-GENMASK_ULL-in-definition-o.patch
0074-BACKPORT-PCI-Make-PCI_ROM_ADDRESS_MASK-a-32-bit-cons.patch
0075-BACKPORT-iio-light-isl29018-Only-declare-ACPI-table-.patch
0082-BACKPORT-drm-i915-Consistently-use-enum-pipe-for-PCH.patch
0083-BACKPORT-drm-i915-Pass-enum-pipe-to-intel_set_pch_fi.patch

[ FROMGIT ]
0084-FROMGIT-x86-boot-Disable-Clang-warnings-about-GNU-ex.patch
0085-FROMGIT-sched-sysctl-Fix-attributes-of-some-extern-d.patch

[ CUSTOM ]
0035-CUSTOM-kbuild-clang-Disable-the-duplicate-decl-speci.patch
0036-CUSTOM-arm64-Disable-asm-operand-width-warning-for-c.patch

[ CLANG ]
0037-CLANG4-crypto-arm64-crc32-explictly-pass-mcpu-option.patch
0038-CLANG4-kbuild-Add-meabi-gnu-to-the-clang-parameters.patch
0039-CLANG4-arm64-prefetch-Use-__builtin_arm_prefetch-for.patch
0040-CLANG4-Disable-lkdtm-when-ftrace-is-enabled.patch
0041-CLANG4-futex-don-t-optimize-futex_detect_cmpxchg-on-.patch
0042-CLANG3-core-clang-work-around-x86-regparm-intrinsics.patch
0086-CLANG4-x86-mce-Disable-gcc-compat-warning-for-mce.c-.patch
0087-CLANG4-task_work-Disable-gcc-compat-warning-locally.patch
