Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sbwXDQP4GltVYAAAmS7hNA
	; Fri, 08 Jun 2018 21:41:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 11B74607E4; Fri,  8 Jun 2018 21:41:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQHd+DYr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EF77D605A2;
	Fri,  8 Jun 2018 21:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF77D605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753226AbeFHVlU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:41:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40764 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbeFHVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QwBFUhEL9pv0HizaI4+xLQiAaPS94y8T1XMGffycdCg=; b=dQHd+DYrXEiuQW+Xop91X2t0w9
        sf3pSsBCU8Snm2r0e3Ov1CLEHnokpDMH2UT+dgfdv162TCre+mpiMY8eYcARLqOw1uJ+Z+bRfqc9i
        f35X58Sajb7l7V8slghpaJnz0jj7dlxDQYqw40kI+Xx7VkLCWz4tKJGJpCChbIZp5Thgo4eqffsb7
        E+mT04HbO2ZyfMv+Z45Jgz3QyMjzPCg72pn9b/Z7rjV9qjYbsjsojuhiL+eiyGGxW9m9mVf7zspjZ
        9rLyIYCkc0+3MoW22njJElP+ecfqW5k7RlvtlCLuTcPwBnfqJmYEKWShgqrXB/+1GTp2Rqrc3lyTC
        x1nwjcFg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRP8B-0000ow-8B; Fri, 08 Jun 2018 21:41:11 +0000
Subject: Re: [PATCH v11 12/13] intel_sgx: driver documentation
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-13-jarkko.sakkinen@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d88234f6-d9f9-561e-b1ab-4bfaddc3dd72@infradead.org>
Date: Fri, 8 Jun 2018 14:41:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608171216.26521-13-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> Documentation of the features of the  Software Guard eXtensions usable
> for the Linux kernel and how the driver internals uses these features.
> In addition, contains documentation for the ioctl API.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Hi,

I have a few corrections below...


> ---
>  Documentation/index.rst         |   1 +
>  Documentation/x86/intel_sgx.rst | 195 ++++++++++++++++++++++++++++++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 Documentation/x86/intel_sgx.rst
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 3b99ab931d41..b9fb92928e8c 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -100,6 +100,7 @@ implementation.
>     :maxdepth: 2
>  
>     sh/index
> +   x86/index
>  
>  Korean translations
>  -------------------
> diff --git a/Documentation/x86/intel_sgx.rst b/Documentation/x86/intel_sgx.rst
> new file mode 100644
> index 000000000000..ecbe544eb2cb
> --- /dev/null
> +++ b/Documentation/x86/intel_sgx.rst
> @@ -0,0 +1,195 @@
> +===================
> +Intel(R) SGX driver
> +===================
> +
> +Introduction
> +============
> +
> +Intel(R) SGX is a set of CPU instructions that can be used by applications to
> +set aside private regions of code and data. The code outside the enclave is
> +disallowed to access the memory inside the enclave by the CPU access control.
> +In a way you can think that SGX provides inverted sandbox. It protects the
> +application from a malicious host.
> +
> +You can tell if your CPU supports SGX by looking into ``/proc/cpuinfo``:
> +
> +	``cat /proc/cpuinfo  | grep sgx``
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
> +the documentation commonly as the ELRANGE.
> +
> +Every memory access to the ELRANGE is asserted by the CPU. If the CPU is not
> +executing in the enclave mode inside the enclave, #GP is raised. On the other
> +hand enclave code can make memory accesses both inside and outside of the
> +ELRANGE.
> +
> +Enclave can only execute code inside the ELRANGE. Instructions that may cause
> +VMEXIT, IO instructions and instructions that require a privilege change are
> +prohibited inside the enclave. Interrupts and exceptions always cause enclave
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
> +2. **EINITTOKEN:** a cryptographic token CMAC-signed with a AES256-key called
> +   *launch key*, which is re-generated for each boot cycle.
> +
> +The CPU holds a SHA256 hash of a 3072-bit RSA public key inside
> +IA32_SGXLEPUBKEYHASHn MSRs. Enclaves with a SIGSTRUCT that is signed with this
> +key do not require a valid EINITTOKEN and can be authorized with special
> +privileges. One of those privileges is ability to acquire the launch key with
> +ENCLS(EGETKEY).
> +
> +**IA32_FEATURE_CONTROL[17]** is used by to BIOS configure whether

                                        by the BIOS to configure whether

> +IA32_SGXLEPUBKEYHASH MSRs are read-only or read-write before locking the
> +feature control register and handing over control to the operating system.
> +
> +Enclave construction
> +--------------------
> +
> +The construction is started by filling out the SECS that contains enclave
> +address range, privileged attributes and measurement of TCS and REG pages (pages
> +that will be mapped to the address range) among the other things. This structure
> +is passed out to the ENCLS(ECREATE) together with a physical address of a page
> +in EPC that will hold the SECS.
> +
> +Then pages are added with ENCLS(EADD) and measured with ENCLS(EEXTEND).  Finally

"measured"?  what does that mean?

> +enclave is initialized with ENCLS(EINIT). ENCLS(INIT) checks that the SIGSTRUCT
> +is signed with the contained public key and that the supplied EINITTOKEN is
> +valid (CMAC'd with the launch key). If these hold, the enclave is successfully
> +initialized.
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
> +By using ENCLS(EBLOCK) instructions no new TLB entries can be created to it.
> +After this the a counter called *epoch* associated hardware threads inside the

huh?

> +enclave is increased with ENCLS(ETRACK). After all the threads from the previous
> +epoch have exited the page can be safely swapped out.
> +
> +An enclave memory access to a swapped out pages will cause #PF. #PF handler can
> +fault the page back by using ENCLS(ELDU).
> +
> +Kernel internals
> +================
> +
> +Requirements
> +------------
> +
> +Because SGX has an ever evolving and expanding feature set, it's possible for
> +a BIOS or VMM to configure a system in such a way that not all cpus are equal,

                                                                  CPUs

> +e.g. where Launch Control is only enabled on a subset of cpus.  Linux does

                                                            CPUs.

> +*not* support such a heterogenous system configuration, nor does it even

                        heterogeneous

> +attempt to play nice in the face of a misconfigured system.  With the exception
> +of Launch Control's hash MSRs, which can vary per cpu, Linux assumes that all

                                                     CPU,

> +cpus have a configuration that is identical to the boot cpu.

   CPUs                                                    CPU.

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
> +userpace and VMs is left to the SGX platform driver and KVM respectively.

   userspace

> +
> +Launching enclaves
> +------------------
> +
> +For privileged enclaves the launch is performed simply by submitting the
> +SIGSTRUCT for that enclave to ENCLS(EINIT). For unprivileged enclaves the
> +driver hosts a process in ring-3 that hosts a launch enclave signed with a key
> +supplied for kbuild.
> +
> +The current implementation of the launch enclave generates a token for any
> +enclave. In the future it could be potentially extended to have ways to
> +configure policy what can be lauched.

                                launched.

> +
> +The driver will fail to initialize if it cannot start its own launch enclave.
> +A user space application can submit a SIGSTRUCT instance through the ioctl API.
> +The kernel will take care of the rest.
> +
> +This design assures that the Linux kernel has always full control, which
> +enclaves get to launch and which do not, even if the public key MSRs are
> +read-only. Having launch intrinsics inside the kernel also enables easy
> +development of enclaves without necessarily needing any heavy weight SDK.
> +Having a low-barrier to implement enclaves could make sense for example for

            low barrier

> +system daemons where amount of dependecies ought to be minimized.

                                  dependencies

> +
> +EPC management
> +--------------
> +
> +Due to the unique requirements for swapping EPC pages, and because EPC pages
> +(currently) do not have associated page structures, management of the EPC is
> +not handled by the standard Linux swapper.  SGX directly handles swapping
> +of EPC pages, including a kthread to initiate reclaim and a rudimentary LRU
> +mechanism.  Consumsers of EPC pages, e.g. the SGX driver, are required to

               Consumers

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


-- 
~Randy
