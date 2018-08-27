Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DA0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A504208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3Qyet3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A504208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeH0X3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:29:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0X3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6LLZmHLoAmvhmr0ueZ4FUWXI0qyfgysPe+6v4hXaZFM=; b=Z3Qyet3GISoXG/AvrcPYNr5cPa
        nKoziJha+sBsPd9avdtUTPbj/pghia2mNewuiprT/qbuad5hu/7WdMI8WxhzzyMmTCaCqUoswITCV
        Hpim/zyjIs4g/BAz8vsTRSEdPBgIaeQGzpj1YDGO1piGzPyP3QRufyeAj8x1vOWx/IRvagH27b/ge
        zPwr9Non8auf49k8/ubpS3XU5Ylr1wyck86A54VWzbu3pNnp0Rg7PxreXPXr502AkAv2TYqT/+Okt
        d0okhWfPqQN8/7eufRFiKLgoCWdL3DZKG+TwSDL/uMGvg1rNgy91J0E3ka7U44M6XwmJLETkwraFj
        53JIy8xA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuNNg-0003t9-5r; Mon, 27 Aug 2018 19:40:58 +0000
Subject: Re: [PATCH v13 13/13] x86/sgx: Driver documentation
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-14-jarkko.sakkinen@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <291cfdc4-ec45-128c-d101-606dbe89e88b@infradead.org>
Date:   Mon, 27 Aug 2018 12:40:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827185507.17087-14-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 11:53 AM, Jarkko Sakkinen wrote:
> Documentation of the features of the Software Guard eXtensions used
> by the Linux kernel and basic design choices for the core and driver
> and functionality.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Hi,

Comments inline...

> ---
>  Documentation/index.rst         |   1 +
>  Documentation/x86/intel_sgx.rst | 185 ++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+)
>  create mode 100644 Documentation/x86/intel_sgx.rst
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 5db7e87c7cb1..1cdc139adb40 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -104,6 +104,7 @@ implementation.
>     :maxdepth: 2
>  
>     sh/index
> +   x86/index
>  
>  Filesystem Documentation
>  ------------------------
> diff --git a/Documentation/x86/intel_sgx.rst b/Documentation/x86/intel_sgx.rst
> new file mode 100644
> index 000000000000..f6b7979c41f2
> --- /dev/null
> +++ b/Documentation/x86/intel_sgx.rst
> @@ -0,0 +1,185 @@
> +===================
> +Intel(R) SGX driver
> +===================
> +
> +Introduction
> +============
> +
> +Intel(R) SGX is a set of CPU instructions that can be used by applications to
> +set aside private regions of code and data. The code outside the enclave is

   set aside private regions of code and data (which are called enclaves). The ...

> +disallowed to access the memory inside the enclave by the CPU access control.
> +In a way you can think that SGX provides inverted sandbox. It protects the

                                   provides an inverted sandbox.

> +application from a malicious host.
> +
> +You can tell if your CPU supports SGX by looking into ``/proc/cpuinfo``:
> +
> +	``cat /proc/cpuinfo  | grep sgx``

or	``grep sgx /proc/cpuinfo``
?

> +
> +Overview of SGX
> +===============
> +
> +SGX has a set of data structures to maintain information about the enclaves and
> +their security properties. BIOS reserves a fixed size region of physical memory
> +for these structures by setting Processor Reserved Memory Range Registers
> +(PRMRR).
> +
> +This memory range is protected from outside access by the CPU and all the data
> +coming in and out of the CPU package is encrypted by a key that is generated for
> +each boot cycle.
> +
> +Enclaves execute in ring-3 in a special enclave submode using pages from the
> +reserved memory range. A fixed logical address range for the enclave is reserved
> +by ENCLS(ECREATE), a leaf instruction used to create enclaves. It is referred in

                                                                  It is referred to in

> +the documentation commonly as the ELRANGE.
> +
> +Every memory access to the ELRANGE is asserted by the CPU. If the CPU is not
> +executing in the enclave mode inside the enclave, #GP is raised. On the other
> +hand enclave code can make memory accesses both inside and outside of the
> +ELRANGE.
> +
> +Enclave can only execute code inside the ELRANGE. Instructions that may cause

   An enclave can
or
   Enclaves can

> +VMEXIT, IO instructions and instructions that require a privilege change are
> +prohibited inside the enclave. Interrupts and exceptions always cause enclave

                                                                   cause the enclave

> +to exit and jump to an address outside the enclave given when the enclave is
> +entered by using the leaf instruction ENCLS(EENTER).
> +
> +Data types
> +----------
> +
> +The protected memory range contains the following data:
> +
> +* **Enclave Page Cache (EPC):** protected pages
> +* **Enclave Page Cache Map (EPCM):** a database that describes the state of the
> +  pages and link them to an enclave.
> +
> +EPC has a number of different types of pages:
> +
> +* **SGX Enclave Control Structure (SECS)**: describes the global
> +  properties of an enclave.
> +* **Regular (REG):** code and data pages in the ELRANGE.
> +* **Thread Control Structure (TCS):** pages that define entry points inside an
> +  enclave. The enclave can only be entered through these entry points and each
> +  can host a single hardware thread at a time.
> +* **Version Array (VA)**: 64-bit version numbers for pages that have been
> +  swapped outside the enclave. Each page contains 512 version numbers.
> +
> +Launch control
> +--------------
> +
> +To launch an enclave, two structures must be provided for ENCLS(EINIT):
> +
> +1. **SIGSTRUCT:** signed measurement of the enclave binary.

what does "signed measurement" mean?

> +2. **EINITTOKEN:** a cryptographic token CMAC-signed with a AES256-key called
> +   *launch key*, which is re-generated for each boot cycle.
> +
> +The CPU holds a SHA256 hash of a 3072-bit RSA public key inside
> +IA32_SGXLEPUBKEYHASHn MSRs. Enclaves with a SIGSTRUCT that is signed with this
> +key do not require a valid EINITTOKEN and can be authorized with special
> +privileges. One of those privileges is ability to acquire the launch key with
> +ENCLS(EGETKEY).
> +
> +**IA32_FEATURE_CONTROL[17]** is used by the BIOS configure whether

                                        by the BIOS to configure whether

> +IA32_SGXLEPUBKEYHASH MSRs are read-only or read-write before locking the
> +feature control register and handing over control to the operating system.
> +
> +Enclave construction
> +--------------------
> +
> +The construction is started by filling out the SECS that contains enclave
> +address range, privileged attributes and measurement of TCS and REG pages (pages

what is this "measurement"?  how is it done?

> +that will be mapped to the address range) among the other things. This structure
> +is passed out to the ENCLS(ECREATE) together with a physical address of a page
> +in EPC that will hold the SECS.
> +
> +The pages are added with ENCLS(EADD) and measured with ENCLS(EEXTEND) i.e.
> +SHA256 hash MRENCLAVE residing in the SECS is extended with the page data.
> +
> +After all of the pages have been added, the enclave is initialized with
> +ENCLS(EINIT). ENCLS(INIT) checks that the SIGSTRUCT is signed with the contained
> +public key. If the given EINITTOKEN has the valid bit set, the CPU checks that
> +the token is valid (CMAC'd with the launch key). If the token is not valid,
> +the CPU will check whether the enclave is signed with a key matching to the
> +IA32_SGXLEPUBKEYHASHn MSRs.
> +
> +Swapping pages
> +--------------
> +
> +Enclave pages can be swapped out with ENCLS(EWB) to the unprotected memory. In
> +addition to the EPC page, ENCLS(EWB) takes in a VA page and address for PCMD
> +structure (Page Crypto MetaData) as input. The VA page will seal a version
> +number for the page. PCMD is 128 byte structure that contains tracking
> +information for the page, most importantly its MAC. With these structures the
> +enclave is sealed and rollback protected while it resides in the unprotected
> +memory.
> +
> +Before the page can be swapped out it must not have any active TLB references.
> +ENCLS(EBLOCK) instruction moves a page to the *blocked* state, which means
> +that no new TLB entries can be created to it by the hardware threads.
> +
> +After this a shootdown sequence is started with ENCLS(ETRACK), which sets an
> +increased counter value to the entering hardware threads. ENCLS(EWB) will
> +return SGX_NOT_TRACKED error while there are still threads with the earlier
> +couner value because that means that there might be hardware thread inside

   counter

> +the enclave with TLB entries to pages that are to be swapped.
> +
> +Kernel internals
> +================
> +
> +Requirements
> +------------
> +
> +Because SGX has an ever evolving and expanding feature set, it's possible for
> +a BIOS or VMM to configure a system in such a way that not all CPUs are equal,
> +e.g. where Launch Control is only enabled on a subset of CPUs.  Linux does
> +*not* support such a heterogeneous system configuration, nor does it even
> +attempt to play nice in the face of a misconfigured system.  With the exception
> +of Launch Control's hash MSRs, which can vary per CPU, Linux assumes that all
> +CPUs have a configuration that is identical to the boot CPU.
> +
> +
> +Roles and responsibilities
> +--------------------------
> +
> +SGX introduces system resources, e.g. EPC memory, that must be accessible to
> +multiple entities, e.g. the native kernel driver (to expose SGX to userspace)
> +and KVM (to expose SGX to VMs), ideally without introducing any dependencies
> +between each SGX entity.  To that end, the kernel owns and manages the shared
> +system resources, i.e. the EPC and Launch Control MSRs, and defines functions
> +that provide appropriate access to the shared resources.  SGX support for
> +user space and VMs is left to the SGX platform driver and KVM respectively.

   userspace
(as on the second line of that same paragraph)

> +
> +Launching enclaves
> +------------------
> +
> +The current kernel implementation supports only unlocked MSRs i.e.
> +FEATURE_CONTROL_SGX_LE_WR must be set. The launch is performed by setting the
> +MSRs to the hash of the public key modulus of the enclave signer, which is one
> +f the fields in the SIGSTRUCT.
> +
> +EPC management
> +--------------
> +
> +Due to the unique requirements for swapping EPC pages, and because EPC pages
> +(currently) do not have associated page structures, management of the EPC is
> +not handled by the standard Linux swapper.  SGX directly handles swapping
> +of EPC pages, including a kthread to initiate reclaim and a rudimentary LRU
> +mechanism. The consumers of EPC pages, e.g. the SGX driver, are required to
> +implement function callbacks that can be invoked by the kernel to age,
> +swap, and/or forcefully reclaim a target EPC page.  In effect, the kernel
> +controls what happens and when, while the consumers (driver, KVM, etc..) do
> +the actual work.
> +
> +SGX uapi
> +========
> +
> +.. kernel-doc:: drivers/platform/x86/intel_sgx/sgx_ioctl.c
> +   :functions: sgx_ioc_enclave_create
> +               sgx_ioc_enclave_add_page
> +               sgx_ioc_enclave_init
> +
> +.. kernel-doc:: arch/x86/include/uapi/asm/sgx.h
> +
> +References
> +==========
> +
> +* System Programming Manual: 39.1.4 Intel® SGX Launch Control Configuration
> 

HTH.
-- 
~Randy
