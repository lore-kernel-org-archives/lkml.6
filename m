Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D155EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9AF2172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHtxEVNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9AF2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeI1NKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:10:07 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45032 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1NKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:10:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so3607931pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9g+g1TTkFJ501vu8iUe7iyD2346NTVtXcmvSUYaRHn8=;
        b=ZHtxEVNI9mNadph1q12xMVmteLff84W3rwrrk3l8qbC33B7425jgqQXTUSP5R1PyhT
         vUuxBa+HmF6mwRwGjoDP0xGREdAALIlqVFWtXjAr9qj6i85+DDfBr1DRrBovF5GBXtzV
         HQ63OpRt7u14nuLBn/+OeCrCdo7mhCOGD5Czs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9g+g1TTkFJ501vu8iUe7iyD2346NTVtXcmvSUYaRHn8=;
        b=lqRh+AvMiwNV/3cCRp7gcK9NY1Z8CYtUaqGpc16W4N5uygGkjr96e/Qri+GtVCR/g4
         I5B92dAiYjU4pTNt7KT4TMtX95UlexyUE+i2klLnOk5WKEbbu/M8lwqKTPVDLTfvRmXj
         FsbKJkoKQ7CeTgo+SIcqWjL574T/T9qXqgI9TtAfUbJzz/NniTXGTIcf6Vni1mdNyegv
         oLLy+gfUC+J8TRfqiwK/ZB+YbumxidSzGd2CopX66W+Cid03IHvk6IwqSkvzYeY3roYd
         VSLhoqke0XBAWk9dhEssu1qtw4382HgUIAK3cbFfomNU5gpdM1s0nyd+JSO59ljbK8QH
         vyqA==
X-Gm-Message-State: ABuFfoi/D3TQqDEcFMEnl+C+qAlNlH6JUZl1Gh58ZVzeMn3kkD/+gs1P
        N8it4QzvJCMSpYtKK3JA/yO7mA==
X-Google-Smtp-Source: ACcGV62B7jRSjWali2RVt2dMt7ZdhtxOK6DoBanSd7FO6dXpQTSM6wxPl2B7fdow2WccXKmeQCwi3A==
X-Received: by 2002:a62:9683:: with SMTP id s3-v6mr15157254pfk.191.1538117272150;
        Thu, 27 Sep 2018 23:47:52 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id g21-v6sm8057605pfe.41.2018.09.27.23.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 23:47:50 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v15 00/16] arm64: kexec: add kexec_file_load() support
Date:   Fri, 28 Sep 2018 15:48:25 +0900
Message-Id: <20180928064841.14117-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fifteenth round of implementing kexec_file_load() support
on arm64.[1] (See "Changes" below)
Most of the code is based on kexec-tools.

# Since v15, we need a few prerequisite patches; See "Changes."
#  You will find them in [1], too.


This patch series enables us to
  * load the kernel by specifying its file descriptor, instead of user-
    filled buffer, at kexec_file_load() system call, and
  * optionally verify its signature at load time for trusted boot.
Kernel virtual address randomization is also supported since v9.

Contrary to kexec_load() system call, as we discussed a long time ago,
users may not be allowed to provide a device tree to the 2nd kernel
explicitly, hence enforcing a dt blob of the first kernel to be re-used
internally.

To use kexec_file_load() system call, instead of kexec_load(), at kexec
command, '-s' option must be specified. See [2] for a necessary patch for
kexec-tools.

To analyze a generated crash dump file, use the latest master branch of
crash utility[3]. I always try to submit patches to fix any inconsistencies
introduced in the latest kernel.

Regarding a kernel image verification, a signature must be presented
along with the binary itself. A signature is basically a hash value
calculated against the whole binary data and encrypted by a key which
will be authenticated by one of the system's trusted certificates.
Any attempt to read and load a to-be-kexec-ed kernel image through
a system call will be checked and blocked if the binary's hash value
doesn't match its associated signature.

There are two methods available now:
1. implementing arch-specific verification hook of kexec_file_load()
2. utilizing IMA(Integrity Measurement Architecture)[4] appraisal framework

Before my v7, I believed that my patch only supports (1) but am now
confident that (2) comes free if IMA is enabled and properly configured.


(1) Arch-specific verification hook
If CONFIG_KEXEC_VERIFY_SIG is enabled, kexec_file_load() invokes an arch-
defined (and hence file-format-specific) hook function to check for the
validity of kernel binary.

On x86, a signature is embedded into a PE file (Microsoft's format) header
of binary. Since arm64's "Image" can also be seen as a PE file as far as
CONFIG_EFI is enabled, we adopt this format for kernel signing.  

As in the case of UEFI applications, we can create a signed kernel image:
    $ sbsign --key ${KEY} --cert ${CERT} Image

You may want to use certs/signing_key.pem, which is intended to be used
for module signing (CONFIG_MODULE_SIG), as ${KEY} and ${CERT} for test
purpose.


(2) IMA appraisal-based
IMA was first introduced in linux in order to meet TCG (Trusted Computing
Group) requirement that all the sensitive files be *measured* before
reading/executing them to detect any untrusted changes/modification.
Then appraisal feature, which allows us to ensure the integrity of
files and even prevent them from reading/executing, was added later.

Meanwhile, kexec_file_load() has been merged since v3.17 and evolved to
enable IMA-appraisal type verification by the commit b804defe4297 ("kexec:
replace call to copy_file_from_fd() with kernel version").

In this scheme, a signature will be stored in a extended file attribute,
"security.ima" while a decryption key is hold in a dedicated keyring,
".ima" or "_ima".  All the necessary process of verification is confined
in a secure API, kernel_read_file_from_fd(), called by kexec_file_load().

    Please note that powerpc is one of the two architectures now
    supporting KEXEC_FILE, and that it wishes to extend IMA,
    where a signature may be appended to "vmlinux" file[5], like module
    signing, instead of using an extended file attribute.

While IMA meant to be used with TPM (Trusted Platform Module) on secure
platform, IMA is still usable without TPM. Here is an example procedure
about how we can give it a try to run the feature using a self-signed
root ca for demo/test purposes:

 1) Generate needed keys and certificates, following "Generate trusted
    keys" section in README of ima-evm-utils[6].

 2) Build the kernel with the following kernel configurations, specifying
    "ima-local-ca.pem" for CONFIG_SYSTEM_TRUSTED_KEYS:
	CONFIG_EXT4_FS_SECURITY
	CONFIG_INTEGRITY_SIGNATURE
	CONFIG_INTEGRITY_ASYMMETRIC_KEYS
	CONFIG_INTEGRITY_TRUSTED_KEYRING
	CONFIG_IMA
	CONFIG_IMA_WRITE_POLICY
	CONFIG_IMA_READ_POLICY
	CONFIG_IMA_APPRAISE
	CONFIG_IMA_APPRAISE_BOOTPARAM
	CONFIG_SYSTEM_TRUSTED_KEYS
    Please note that CONFIG_KEXEC_VERIFY_SIG is not, actually should
    not be, enabled.

 3) Sign(label) a kernel image binary to be kexec-ed on target filesystem:
    $ evmctl ima_sign --key /path/to/private_key.pem /your/Image

 4) Add a command line parameter and boot the kernel:
    ima_appraise=enforce

 On live system,
 5) Set a security policy:
    $ mount -t securityfs none /sys/kernel/security
    $ echo "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig" \
      > /sys/kernel/security/ima/policy

 6) Add a key for ima:
    $ keyctl padd asymmetric my_ima_key %:.ima < /path/to/x509_ima.der
    (or evmctl import /path/to/x509_ima.der <ima_keyring_id>)

 7) Then try kexec as normal.


Concerns(or future works):
* Support for physical address randomization
* Signature verification of big endian kernel with CONFIG_KEXEC_VERIFY_SIG
  While big-endian kernel can support kernel signing, I'm not sure that
  Image can be recognized as in PE format because x86 standard only
  defines little-endian-based format.
* Support for vminux loading

  [1] http://git.linaro.org/people/takahiro.akashi/linux-aarch64.git
	branch:arm64/kexec_file
  [2] http://git.linaro.org/people/takahiro.akashi/kexec-tools.git
	branch:arm64/kexec_file
  [3] http://github.com/crash-utility/crash.git
  [4] https://sourceforge.net/p/linux-ima/wiki/Home/
  [5] http://lkml.iu.edu//hypermail/linux/kernel/1707.0/03669.html
  [6] https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/


Changes in v15 (Sep 28, 2018)
* rework fdt helper functions, utilizing new fdt_address_cells() and
  fdt_size_cells() from libfdt after Frank's comment
  This change requires the following patches to be applied as well:
  [7] http://lkml.iu.edu//hypermail/linux/kernel/1809.1/04800.html
  [8] https://www.spinics.net/lists/devicetree/msg250653.html

Changes in v14 (Sep 7, 2018)
* rebased to v4.19-rc
* define default KEXEC_BUF_MEM_UNKNOWN which indicates that,
  if kexec_buf.mem does match it, kexec_locate_mem_hole() should allocate
  free memory for arch

Changes in v13 (July 31, 2018)
* rebased to arm64/for-next/core
* system call number changed to 294
  (kexec-tools must be updated as well.)
* rename arch_kexec_walk_mem() to kexec_walk_resources()
* define string macros for dtb properties' names in setup_dtb()
* use MEMBLOCK_NONE rather than 0 at for_each_mem_range[_reverse]()
* rename dtb_buf to dtb in struct kexec_arch at right place
* provide "kaslr-seed" only if random number generator is available

Changes in v12 (July 24, 2018)
 (mostly addressing James' comments)
* unify all the variants of arch_kexec_walk_mem(), including s390's, into
  common code, leaving arch_kexec_walk_mem() static (i.e. no longer
  replaceable)
* always initialize kbuf.mem to zero to align with a change above
* set kbuf.buf_min/buf_max consistently between kexec and kdump
* try to consistently use "unsigned long" for physical (kexec-time)
  address, and "void *" for virtual (runtime) address in
  load_other_segments() with a couple of variables renamed for readability
* fix a 'sparse' warning against arch_kimage_file_post_load_cleanup()
* fix a calculation of string length of "ARM64_MAGIC"
* set kernel image alignment to MIN_KIMG_ALIGN rather than SZ_2M
* set elf header alignment to SZ_64K rather than SZ_4K


Changes in v11 (July 11, 2018)
* split v10's patch#3, a refactoring stuff, into two parts, "just move"
  and modify
* remove selecting BUILD_BIN2C from KEXEC_FILE config
* modify setup_dtb()
   * to correct a return value on failure of fdt_xyz() call,
   * to always remove existing bootargs and initrd-start/end properties,
     if any, when copying current system's dtb into new dtb
   * to use fdt_setprop_string() for bootargs (I'm now sure that
     kimage->cmdline_buf is a null-terminated string.)
* revise a warning comment in case of KEXEC_VERIFY_SIG but
  !(EFI && SIGNED_PE_FILE_VERIFICATION)

Changes in v10 (June 23, 2018)
* rebased to v4.18-rc
* change syscall number of kexec_file_load from 292 to 293
* factor out memblock-based arch_kexec_walk_mem() from powerpc and
  merge it into generic one
* move generic fdt helper functions from arm64 dir to drivers/of
  (dt_root_[addr|size]_cells are no longer __initdata.)
* modify fill_property() to use 'while' loop
* modify fdt_setprop_reg() to allocate a buffer on stack
* modify setup_dtb() to use fdt_setprop_u64()
* pass kernel_load_addr/size directly as arguments, instead of via
  kimage_arch.kern_segment, at load_other_segments()
* refuse loading an image which cannot be supported in image loader,
  adding cpu-feature(MMFR0) helper functions
* modify prepare_elf_headers() to use kmalloc() instead of vmalloc()
* always pass arch.dtb_mem as the fourth argument to cpu_soft_restart()
  in machine_kexec() while dtb_mem will be zero in kexec case

Changes in v9 (April 25, 2018)
* rebased to v4.17-rc
* remove preparatory patches on generic/x86/ppc code
  They have now been merged in v4.17-rc1.
* allocate memory based on memblock list instead of system resources
  This will prevent reserved regions, particularly UEFI/ACPI data,
  from being corrupted.
* correct dt property names, linux,initrd-*, in newly-created dtb
  "linux," was missing.
* remove alignment requirement for initrd loading
* add kaslr (kernel virtual address randomization) support
* misc code clean-up
* revise commit messages

Changes in v8 (Feb 22, 2018)
* introduce ARCH_HAS_KEXEC_PURGATORY so that arm64 will be able to skip
  purgatory
* remove "ifdef CONFIG_X86_64" stuffs from a re-factored function,
  prepare_elf64_headers(), making its interface more generic
  (The original patch was split into two for easier reviews.)
* modify cpu_soft_restart() so as to let the 2nd kernel jump into its entry
  code directly without requiring purgatory in case of kexec_file_load
* remove CONFIG_KEXEC_FILE_IMAGE_FMT and introduce
  CONFIG_KEXEC_IMAGE_VERIFY_SIG, much similar to x86 but quite redundant
  for now.
* In addition, update/modify dependencies of KEXEC_IMAGE_VERIFY_SIG

Changes in v7 (Dec 4, 2017)
* rebased to v4.15-rc2
* re-organize the patch set to separate KEXEC_FILE_VERIFY_SIG-related
  code from the others
* revamp factored-out code in kernel/kexec_file.c due to the changes
  in original x86 code
* redefine walk_sys_ram_res_rev() prototype due to change of callback
  type in the counterpart, walk_sys_ram_res()
* make KEXEC_FILE_IMAGE_FMT default on if KEXEC_FILE selected

Changes in v6 (Oct 24, 2017)
* fix a for-loop bug in _kexec_kernel_image_probe() per Julien

Changes in v5 (Oct 10, 2017)
* fix kbuild errors around patch #3
per Julien's comments,
* fix a bug in walk_system_ram_res_rev() with some cleanup
* modify fdt_setprop_range() to use vmalloc()
* modify fill_property() to use memset()

Changes in v4 (Oct 2, 2017)
* reinstate x86's arch_kexec_kernel_image_load()
* rename weak arch_kexec_kernel_xxx() to _kexec_kernel_xxx() for
  better re-use
* constify kexec_file_loaders[]

Changes in v3 (Sep 15, 2017)
* fix kbuild test error
* factor out arch_kexec_kernel_*() & arch_kimage_file_post_load_cleanup()
* remove CONFIG_CRASH_CORE guard from kexec_file.c
* add vmapped kernel region to vmcore for gdb backtracing
  (see prepare_elf64_headers())
* merge asm/kexec_file.h into asm/kexec.h
* and some cleanups

Changes in v2 (Sep 8, 2017)
* move core-header-related functions from crash_core.c to kexec_file.c
* drop hash-check code from purgatory
* modify purgatory asm to remove arch_kexec_apply_relocations_add()
* drop older kernel support
* drop vmlinux support (at least, for this series)


Patch #1 to #10 are essential part for KEXEC_FILE support
(additionally allowing for IMA-based verification):
  Patch #1 to #6 are all preparatory patches on generic side.
  Patch #7 to #11 are to enable kexec_file_load on arm64.

Patch #12 to #13 are for KEXEC_VERIFY_SIG (arch-specific verification)
support

AKASHI Takahiro (16):
  asm-generic: add kexec_file_load system call to unistd.h
  kexec_file: make kexec_image_post_load_cleanup_default() global
  s390, kexec_file: drop arch_kexec_mem_walk()
  powerpc, kexec_file: factor out memblock-based arch_kexec_walk_mem()
  kexec_file: kexec_walk_memblock() only walks a dedicated region at
    kdump
  of/fdt: add helper functions for handling properties
  arm64: add image head flag definitions
  arm64: cpufeature: add MMFR0 helper functions
  arm64: enable KEXEC_FILE config
  arm64: kexec_file: load initrd and device-tree
  arm64: kexec_file: allow for loading Image-format kernel
  arm64: kexec_file: add crash dump support
  arm64: kexec_file: invoke the kernel without purgatory
  include: pe.h: remove message[] from mz header definition
  arm64: kexec_file: add kernel signature verification support
  arm64: kexec_file: add kaslr support

 arch/arm64/Kconfig                          |  33 ++
 arch/arm64/include/asm/boot.h               |  15 +
 arch/arm64/include/asm/cpufeature.h         |  48 +++
 arch/arm64/include/asm/kexec.h              |  49 +++
 arch/arm64/kernel/Makefile                  |   3 +-
 arch/arm64/kernel/cpu-reset.S               |   8 +-
 arch/arm64/kernel/head.S                    |   2 +-
 arch/arm64/kernel/kexec_image.c             | 123 +++++++
 arch/arm64/kernel/machine_kexec.c           |  12 +-
 arch/arm64/kernel/machine_kexec_file.c      | 353 ++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S         |   3 +-
 arch/powerpc/kernel/machine_kexec_file_64.c |  54 ---
 arch/s390/kernel/machine_kexec_file.c       |  10 -
 drivers/of/fdt.c                            |  56 ++++
 include/linux/kexec.h                       |  11 +-
 include/linux/of_fdt.h                      |   4 +
 include/linux/pe.h                          |   2 +-
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/kexec_file.c                         |  69 +++-
 19 files changed, 778 insertions(+), 81 deletions(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c

-- 
2.19.0

