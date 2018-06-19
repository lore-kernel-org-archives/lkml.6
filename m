Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C55C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F2820883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F2820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757330AbeFSNbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:31:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:40604 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbeFSNbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:31:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 06:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="48237339"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2018 06:31:28 -0700
Date:   Tue, 19 Jun 2018 16:31:26 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 12/13] intel_sgx: driver documentation
Message-ID: <20180619133126.GH5609@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-13-jarkko.sakkinen@linux.intel.com>
 <d88234f6-d9f9-561e-b1ab-4bfaddc3dd72@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d88234f6-d9f9-561e-b1ab-4bfaddc3dd72@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:41:07PM -0700, Randy Dunlap wrote:
> On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > Documentation of the features of the  Software Guard eXtensions usable
> > for the Linux kernel and how the driver internals uses these features.
> > In addition, contains documentation for the ioctl API.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Hi,
> 
> I have a few corrections below...
> 
> 
> > ---
> >  Documentation/index.rst         |   1 +
> >  Documentation/x86/intel_sgx.rst | 195 ++++++++++++++++++++++++++++++++
> >  2 files changed, 196 insertions(+)
> >  create mode 100644 Documentation/x86/intel_sgx.rst
> > 
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index 3b99ab931d41..b9fb92928e8c 100644
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> > @@ -100,6 +100,7 @@ implementation.
> >     :maxdepth: 2
> >  
> >     sh/index
> > +   x86/index
> >  
> >  Korean translations
> >  -------------------
> > diff --git a/Documentation/x86/intel_sgx.rst b/Documentation/x86/intel_sgx.rst
> > new file mode 100644
> > index 000000000000..ecbe544eb2cb
> > --- /dev/null
> > +++ b/Documentation/x86/intel_sgx.rst
> > @@ -0,0 +1,195 @@
> > +===================
> > +Intel(R) SGX driver
> > +===================
> > +
> > +Introduction
> > +============
> > +
> > +Intel(R) SGX is a set of CPU instructions that can be used by applications to
> > +set aside private regions of code and data. The code outside the enclave is
> > +disallowed to access the memory inside the enclave by the CPU access control.
> > +In a way you can think that SGX provides inverted sandbox. It protects the
> > +application from a malicious host.
> > +
> > +You can tell if your CPU supports SGX by looking into ``/proc/cpuinfo``:
> > +
> > +	``cat /proc/cpuinfo  | grep sgx``
> > +
> > +Overview of SGX
> > +===============
> > +
> > +SGX has a set of data structures to maintain information about the enclaves and
> > +their security properties. BIOS reserves a fixed size region of physical memory
> > +for these structures by setting Processor Reserved Memory Range Registers
> > +(PRMRR).
> > +
> > +This memory range is protected from outside access by the CPU and all the data
> > +coming in and out of the CPU package is encrypted by a key that is generated for
> > +each boot cycle.
> > +
> > +Enclaves execute in ring-3 in a special enclave submode using pages from the
> > +reserved memory range. A fixed logical address range for the enclave is reserved
> > +by ENCLS(ECREATE), a leaf instruction used to create enclaves. It is referred in
> > +the documentation commonly as the ELRANGE.
> > +
> > +Every memory access to the ELRANGE is asserted by the CPU. If the CPU is not
> > +executing in the enclave mode inside the enclave, #GP is raised. On the other
> > +hand enclave code can make memory accesses both inside and outside of the
> > +ELRANGE.
> > +
> > +Enclave can only execute code inside the ELRANGE. Instructions that may cause
> > +VMEXIT, IO instructions and instructions that require a privilege change are
> > +prohibited inside the enclave. Interrupts and exceptions always cause enclave
> > +to exit and jump to an address outside the enclave given when the enclave is
> > +entered by using the leaf instruction ENCLS(EENTER).
> > +
> > +Data types
> > +----------
> > +
> > +The protected memory range contains the following data:
> > +
> > +* **Enclave Page Cache (EPC):** protected pages
> > +* **Enclave Page Cache Map (EPCM):** a database that describes the state of the
> > +  pages and link them to an enclave.
> > +
> > +EPC has a number of different types of pages:
> > +
> > +* **SGX Enclave Control Structure (SECS)**: describes the global
> > +  properties of an enclave.
> > +* **Regular (REG):** code and data pages in the ELRANGE.
> > +* **Thread Control Structure (TCS):** pages that define entry points inside an
> > +  enclave. The enclave can only be entered through these entry points and each
> > +  can host a single hardware thread at a time.
> > +* **Version Array (VA)**: 64-bit version numbers for pages that have been
> > +  swapped outside the enclave. Each page contains 512 version numbers.
> > +
> > +Launch control
> > +--------------
> > +
> > +To launch an enclave, two structures must be provided for ENCLS(EINIT):
> > +
> > +1. **SIGSTRUCT:** signed measurement of the enclave binary.
> > +2. **EINITTOKEN:** a cryptographic token CMAC-signed with a AES256-key called
> > +   *launch key*, which is re-generated for each boot cycle.
> > +
> > +The CPU holds a SHA256 hash of a 3072-bit RSA public key inside
> > +IA32_SGXLEPUBKEYHASHn MSRs. Enclaves with a SIGSTRUCT that is signed with this
> > +key do not require a valid EINITTOKEN and can be authorized with special
> > +privileges. One of those privileges is ability to acquire the launch key with
> > +ENCLS(EGETKEY).
> > +
> > +**IA32_FEATURE_CONTROL[17]** is used by to BIOS configure whether
> 
>                                         by the BIOS to configure whether
> 
> > +IA32_SGXLEPUBKEYHASH MSRs are read-only or read-write before locking the
> > +feature control register and handing over control to the operating system.
> > +
> > +Enclave construction
> > +--------------------
> > +
> > +The construction is started by filling out the SECS that contains enclave
> > +address range, privileged attributes and measurement of TCS and REG pages (pages
> > +that will be mapped to the address range) among the other things. This structure
> > +is passed out to the ENCLS(ECREATE) together with a physical address of a page
> > +in EPC that will hold the SECS.
> > +
> > +Then pages are added with ENCLS(EADD) and measured with ENCLS(EEXTEND).  Finally
> 
> "measured"?  what does that mean?
> 
> > +enclave is initialized with ENCLS(EINIT). ENCLS(INIT) checks that the SIGSTRUCT
> > +is signed with the contained public key and that the supplied EINITTOKEN is
> > +valid (CMAC'd with the launch key). If these hold, the enclave is successfully
> > +initialized.
> > +
> > +Swapping pages
> > +--------------
> > +
> > +Enclave pages can be swapped out with ENCLS(EWB) to the unprotected memory. In
> > +addition to the EPC page, ENCLS(EWB) takes in a VA page and address for PCMD
> > +structure (Page Crypto MetaData) as input. The VA page will seal a version
> > +number for the page. PCMD is 128 byte structure that contains tracking
> > +information for the page, most importantly its MAC. With these structures the
> > +enclave is sealed and rollback protected while it resides in the unprotected
> > +memory.
> > +
> > +Before the page can be swapped out it must not have any active TLB references.
> > +By using ENCLS(EBLOCK) instructions no new TLB entries can be created to it.
> > +After this the a counter called *epoch* associated hardware threads inside the
> 
> huh?
> 
> > +enclave is increased with ENCLS(ETRACK). After all the threads from the previous
> > +epoch have exited the page can be safely swapped out.
> > +
> > +An enclave memory access to a swapped out pages will cause #PF. #PF handler can
> > +fault the page back by using ENCLS(ELDU).
> > +
> > +Kernel internals
> > +================
> > +
> > +Requirements
> > +------------
> > +
> > +Because SGX has an ever evolving and expanding feature set, it's possible for
> > +a BIOS or VMM to configure a system in such a way that not all cpus are equal,
> 
>                                                                   CPUs
> 
> > +e.g. where Launch Control is only enabled on a subset of cpus.  Linux does
> 
>                                                             CPUs.
> 
> > +*not* support such a heterogenous system configuration, nor does it even
> 
>                         heterogeneous
> 
> > +attempt to play nice in the face of a misconfigured system.  With the exception
> > +of Launch Control's hash MSRs, which can vary per cpu, Linux assumes that all
> 
>                                                      CPU,
> 
> > +cpus have a configuration that is identical to the boot cpu.
> 
>    CPUs                                                    CPU.
> 
> > +
> > +
> > +Roles and responsibilities
> > +--------------------------
> > +
> > +SGX introduces system resources, e.g. EPC memory, that must be accessible to
> > +multiple entities, e.g. the native kernel driver (to expose SGX to userspace)
> > +and KVM (to expose SGX to VMs), ideally without introducing any dependencies
> > +between each SGX entity.  To that end, the kernel owns and manages the shared
> > +system resources, i.e. the EPC and Launch Control MSRs, and defines functions
> > +that provide appropriate access to the shared resources.  SGX support for
> > +userpace and VMs is left to the SGX platform driver and KVM respectively.
> 
>    userspace
> 
> > +
> > +Launching enclaves
> > +------------------
> > +
> > +For privileged enclaves the launch is performed simply by submitting the
> > +SIGSTRUCT for that enclave to ENCLS(EINIT). For unprivileged enclaves the
> > +driver hosts a process in ring-3 that hosts a launch enclave signed with a key
> > +supplied for kbuild.
> > +
> > +The current implementation of the launch enclave generates a token for any
> > +enclave. In the future it could be potentially extended to have ways to
> > +configure policy what can be lauched.
> 
>                                 launched.
> 
> > +
> > +The driver will fail to initialize if it cannot start its own launch enclave.
> > +A user space application can submit a SIGSTRUCT instance through the ioctl API.
> > +The kernel will take care of the rest.
> > +
> > +This design assures that the Linux kernel has always full control, which
> > +enclaves get to launch and which do not, even if the public key MSRs are
> > +read-only. Having launch intrinsics inside the kernel also enables easy
> > +development of enclaves without necessarily needing any heavy weight SDK.
> > +Having a low-barrier to implement enclaves could make sense for example for
> 
>             low barrier
> 
> > +system daemons where amount of dependecies ought to be minimized.
> 
>                                   dependencies
> 
> > +
> > +EPC management
> > +--------------
> > +
> > +Due to the unique requirements for swapping EPC pages, and because EPC pages
> > +(currently) do not have associated page structures, management of the EPC is
> > +not handled by the standard Linux swapper.  SGX directly handles swapping
> > +of EPC pages, including a kthread to initiate reclaim and a rudimentary LRU
> > +mechanism.  Consumsers of EPC pages, e.g. the SGX driver, are required to
> 
>                Consumers
> 
> > +implement function callbacks that can be invoked by the kernel to age,
> > +swap, and/or forcefully reclaim a target EPC page.  In effect, the kernel
> > +controls what happens and when, while the consumers (driver, KVM, etc..) do
> > +the actual work.
> > +
> > +SGX uapi
> > +========
> > +
> > +.. kernel-doc:: drivers/platform/x86/intel_sgx/sgx_ioctl.c
> > +   :functions: sgx_ioc_enclave_create
> > +               sgx_ioc_enclave_add_page
> > +               sgx_ioc_enclave_init
> > +
> > +.. kernel-doc:: arch/x86/include/uapi/asm/sgx.h
> > +
> > +References
> > +==========
> > +
> > +* System Programming Manual: 39.1.4 Intel® SGX Launch Control Configuration
> > 
> 
> 
> -- 
> ~Randy

Thank you, I'll refine the parts that you pointed out for the next
version.

/Jarkko
