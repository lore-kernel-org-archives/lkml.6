Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D672080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D672080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390676AbeKVKYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:24:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:53911 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390659AbeKVKYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:24:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 15:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,262,1539673200"; 
   d="scan'208";a="91169516"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.144]) ([10.54.74.144])
  by orsmga007.jf.intel.com with ESMTP; 21 Nov 2018 15:48:13 -0800
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>
References: <20181121201430.559770965@linutronix.de>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [patch 00/24] x86/speculation: Remedy the STIBP/IBPB overhead
Message-ID: <47a9c3da-de77-071a-c5fb-237f07c6892f@linux.intel.com>
Date:   Wed, 21 Nov 2018 15:48:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20181121201430.559770965@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2018 12:14 PM, Thomas Gleixner wrote:
> This is based on Tim Chen's V5 patch series. The following changes have
> been made:
> 
...
> 
> TODO: Write documentation
> 

Andi took a crack at the document.  I made some 
modifications on top.  It can be used as a
starting point for the final document.

Thanks.

Tim

---

From bc69984e744192fa0e0b4850ecc4b25ec667b3a8 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Wed, 21 Nov 2018 15:36:19 -0800
Subject: [PATCH] x86/speculation: Add document to describe Spectre and its
 mitigations

From: Andi Kleen <ak@linux.intel.com>

There are no document in admin guides describing
Spectre v1 and v2 side channels and their mitigations
in Linux.

Create a document to describe Spectre and the mitigation
methods used in the kernel.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/spectre.rst | 401 ++++++++++++++++++++++++++++++++++
 1 file changed, 401 insertions(+)
 create mode 100644 Documentation/admin-guide/spectre.rst

diff --git a/Documentation/admin-guide/spectre.rst b/Documentation/admin-guide/spectre.rst
new file mode 100644
index 0000000..67db151
--- /dev/null
+++ b/Documentation/admin-guide/spectre.rst
@@ -0,0 +1,401 @@
+Spectre side channels
+=====================
+
+Spectre is a class of side channel attacks against modern CPUs that
+use branch prediction and speculative execution, which allows to read malicious
+local software to read memory it does not have access to. It does not
+modify any memory.
+
+This document covers Spectre variant 1 and 2.
+
+Affected processors
+-------------------
+
+The vulnerability affects a wide range of modern high performance processors, since
+most modern high speed processors use branch prediction and speculative execution.
+
+The following CPUs are vulnerable:
+
+    - Intel Core, Atom, Pentium, Xeon CPUs
+    - AMD CPUs like Phenom, EPYC, Zen.
+    - IBM processors like POWER and zSeries
+    - Higher end ARM processors
+    - Apple CPUs
+    - Higher end MIPS CPUs
+    - Likely most other high performance CPUs. Contact your CPU vendor for details.
+
+This document documents the mitigations on Intel CPUs.
+      
+Related CVEs
+------------
+
+The following CVE entries describe Spectre variants:
+
+   =============   =======================  ==========
+   CVE-2017-5753   Bounds check bypass      Spectre-V1   
+   CVE-2017-5715   Branch target injection  Spectre-V2
+      
+Problem
+-------
+
+CPUs have shared caches, such as buffers for branch prediction,
+which are later used to guide speculative execution. These
+buffers are not flushed over context switches. Malicious local
+software might influence these buffers and trigger specific
+speculative execution in the kernel or different user processes.
+This speculative execution can then be used to read data in memory
+and cause a side effect in a data cache. The side effect can then
+later be measured by the malicious software, after it gets
+executed again, and used to determine the memory values read
+speculatively.
+
+Spectre attacks allow tricking other software to disclose
+values in their memory.
+
+For Spectre variant 1 the attacker passes an parameter to a
+victim. The victim boundary checks the parameter and rejects illegal
+values. However due to speculation over branch prediction the code
+path for correct values might be speculatively executed, then
+reference memory controlled by the input parameter and leave
+measurable side effects in the caches.  The attacker could then
+measure these side effects after it gains control again and determine
+the leaked value.
+
+There are some extensions of Spectre variant 1 attacks for reading
+data over the network, see [2]. However the attacks are very
+difficult, low bandwidth and fragile and considered low risk.
+
+For Spectre variant 2 the attacker poisons the indirect branch
+predictors of the CPU. Then control is passed to the victim, which
+executes indirect branches. Due to the poisoned branch predictor data
+the CPU can speculatively execute arbitrary code in the victim's
+address space, such as a code sequence ("disclosure gadget") that
+reads arbitrary data on some input parameter and causes a measurable
+cache side effect based on the value. The attacker can then measure
+this side effect after gaining control again and determine the value.
+
+For fully usable gadgets there needs to be an input parameter
+so that the memory read can be controlled. It might be possible
+to do attacks without input parameter, however in this case the attacker
+has little control over what memory can be read and the risk
+of actual secret disclosure is low.
+
+Attack scenarios
+----------------
+
+1. Local User process attacking kernel
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The kernel can read all memory. An malicious user program can trigger
+an kernel entry. For variant 1 it would need to pass a parameter, so
+only system calls (but not interrupts or exceptions) are vulnerable.
+
+For variant 2 the attacker needs to poison the CPU branch buffers
+first, and then enter the kernel and trick it into jumping to a disclosure
+gadget through an indirect branch. If it wants to control the address that
+the gadget can read it would also need to pass a parameter to the gadget,
+either through a register or through a known address in memory. Finally
+it needs to gain execution again to measure the side effect.
+
+Requirements: malicious local process passing parameters to kernel with
+kernel or other process on same machine having secrets.
+
+2. User process attacking another user process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In this scenario an malicious user process wants to attack another
+user process through a context switch.
+
+For variant 1 this generally requires passing some parameter between
+the processes, which needs a data passing relationship, such a remote
+procedure calls (RPC).
+
+For variant 2 the poisoning can happen through a context switch, or
+on CPUs with simultaneous multi-threading (SMT) potentially on the
+thread sibling executing in parallel on the same core.  In any case to
+control the memory read by the disclosure gadget also requires a data
+passing relationship to the victim process, otherwise while it may
+observe values through side effects, it won't know which memory
+addresses they relate to.
+
+Requirements: malicious local process attacking
+containing secrets running on same core.
+
+3. User sandbox attacking runtime in process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A process, such as a web browser, might be running interpreted or JITed
+untrusted code, such as java script code downloaded from a website.
+It uses restrictions in the JIT code generator and checks in a run time
+to prevent the untrusted code from attacking the hosting process.
+
+The untrusted code might either use variant 1 or 2 to trick
+a disclosure gadget in the run time to read memory inside the process.
+
+Requirements: sandbox in process running untrusted code 
+with runtime in same process containing secrets.
+
+4. Kernel sandbox attacking kernel
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The kernel has support for eBPF to execute JITed untrusted byte code inside
+the kernel. eBPF is used for manipulating and examining network
+packets, examining system call parameters for sand boxes and other uses.
+
+A malicious local process could upload and trigger an malicious
+eBPF script to the kernel, with the script attacking the kernel
+using variant 1 or 2 and reading memory.
+
+Requirements: Malicious local process, EBPF enabled for
+unprivileged users, attacking kernel with secrets on the same
+machine.
+
+5. Virtualization guest attacking host
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+An untrusted guest might attack the host through a hyper call
+or other virtualization exit.
+
+Requirements: untrusted guest attacking host with secrets
+on local machine.
+
+For variant 1 VM exits use appropiate mitigations
+("bounds clipping") to prevent speculation leaking data
+in kernel code. For variant 2 the kernel flushes the branch buffer.
+
+6. Virtualization guest attacking other guest
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+An untrusted guest attacking another guest containing
+secrets. Mitigations are similar to the case above.
+
+Runtime vulnerability information
+---------------------------------
+
+The kernel reports the vulnerability and mitigation status in
+/sys/devices/system/cpu/vulnerabilities/
+
+The summary can be displayed with
+grep . /sys/devices/system/cpu/vulnerabilities/*
+
+The spectre_v1 file describes the always enabled variant 1
+mitigation.
+
+The spectre_v2 the kernel mitigation status is reported,
+which includes if the kernel has been compiled with a retpoline
+aware compiler, if the CPU has hardware mitigation, and if has
+microcode support for additional process specific mitigations.
+
+Full mitigations might require an microcode update from the CPU
+vendor. When the necessary microcode is not available the kernel
+will report vulnerability.
+
+Kernel mitigation
+-----------------
+
+The kernel has default on mitigations for Variant 1 and Variant 2
+against attacks from user programs or guests. For variant 1 it
+annotates vulnerable kernel code (as determined by the sparse code
+scanning tool and code audits) to use "bounds clipping" to avoid any
+usable disclosure gadgets.
+
+For variant 2 the kernel employs "retpoline" with compiler help to
+secure the indirect branches inside the kernel, when CONFIG_RETPOLINE
+is enabled and the compiler supports retpoline. On Intel Skylake systems
+the mitigation covers most, but not all, cases, see [1] for more details.
+
+On CPUs with hardware mitigations for variant 2 retpoline is automatically
+disabled at runtime. 
+
+Using kernel address space randomization (CONFIG_RANDOMIZE_SLAB=y
+and CONFIG_SLAB_FREELIST_RANDOM=y in the kernel configuration)
+makes attacks on the kernel generally more difficult.
+
+Host mitigation
+---------------
+
+The Linux kernel uses retpoline to eliminate attacks on indirect
+branches. It also flushes the Return Branch Stack on every VM exit to
+prevent guests from attacking the host kernel when retpoline is
+enabled.
+
+Variant 1 attacks are mitigated unconditionally.
+
+The kernel also allows guests to use any microcode based mitigations
+they chose to use (such as IBRS, IBPB or STIBP), assuming the
+host has an updated microcode and reports IBPB in
+/sys/devices/system/cpu/vulnerabilities/spectre_v2.
+
+Mitigation control at kernel build time
+---------------------------------------
+
+When the CONFIG_RETPOLINE option is enabled the kernel uses special
+code sequences to avoid attacks on indirect branches through
+Variant 2 attacks.
+
+The compiler also needs to support retpoline and support the
+-mindirect-branch=thunk-extern -mindirect-branch-register options
+for gcc, or -mretpoline-external-thunk option for clang.
+When the compiler doesn't support these options the
+
+Variant 1 mitigations and other side channel related user APIs are
+enabled unconditionally.
+
+Hardware mitigation
+-------------------
+
+Some CPUs have hardware mitigations for Spectre variant 2.  The 4.19
+kernel has support for detecting this capability and automatically
+disable any unnecessary workarounds at runtime.
+
+User mitigation
+---------------
+
+For variant 1 user programs can use LFENCE or bounds clipping. For more
+details see [3].
+
+For variant 2 user programs can be compiled with retpoline.
+
+User programs should use address space randomization
+(/proc/sys/kernel/randomize_va_space = 1) to make any attacks
+more difficult.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+
+Spectre v2 mitigations can be disabled and force enabled at the kernel
+command line.
+
+	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
+			(indirect branch prediction) vulnerability. System may
+			allow data leaks with this option, which is equivalent
+			to spectre_v2=off.
+
+	spectre_v2=	[X86] Control mitigation of Spectre variant 2
+			(indirect branch speculation) vulnerability.
+
+			on   - unconditionally enable
+			off  - unconditionally disable
+			auto - kernel detects whether your CPU model is
+			       vulnerable
+
+			Selecting 'on' will, and 'auto' may, choose a
+			mitigation method at run time according to the
+			CPU, the available microcode, the setting of the
+			CONFIG_RETPOLINE configuration option, and the
+			compiler with which the kernel was built.
+
+			Specific mitigations can also be selected manually:
+
+			retpoline	  - replace indirect branches
+			retpoline,generic - google's original retpoline
+			retpoline,amd     - AMD-specific minimal thunk
+
+			Not specifying this option is equivalent to
+			spectre_v2=auto.			
+
+For user space mitigation: 
+
+	spectre_v2_app2app=
+			[X86] Control mitigation of Spectre variant 2
+		        application to application (indirect branch speculation)
+			vulnerability.
+
+			on      - Unconditionally enable mitigations. Is enforced
+				  by spectre_v2=on
+			off     - Unconditionally disable mitigations. Is enforced
+				  by spectre_v2=off
+			auto    - Kernel selects the mitigation depending on
+				  the available CPU features and vulnerability.
+			prctl   - Indirect branch speculation is enabled, but
+				  mitigation can be enabled via prctl per thread.
+				  The mitigation control state is inherited on fork.
+			seccomp - Same as "prctl" above, but all seccomp threads
+				  will enable the mitigation unless they explicitly
+				  opt out.
+
+			Default mitigation:
+			If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
+
+			Not specifying this option is equivalent to
+			spectre_v2_app2app=auto.
+
+In general the kernel by default selects reasonable mitigations for
+the current CPU. To disable Spectre v2 mitigations boot with
+spectre_v2=off. Spectre v1 mitigations cannot be disabled.
+
+APIs for mitigation control per process
+---------------------------------------
+
+Under the "prctl" option for spectre_v2_app2app, issuing
+prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIR_BRANCH, PR_SPEC_DISABLE,
+0, 0) on a process restricts indirect branch speculation on a process.
+
+Processes containing secrets, such as cryptographic keys, can invoke this
+prctl for extra protection against Spectre v2. 
+
+Before running untrusted processes, this prctl should be issued to prevent
+such processes from launching Spectre v2 attacks.
+
+The kernel automatically flushes the branch buffers when context switching
+in or out of the process, which prevents any branch buffer poisoning
+from the sandboxed code. IBPB will be issued on context switching into
+and out of such processes to clear branch target buffers.  This protects the
+process from any external influence on its indirect branch predictions or
+influencing others on the same thread.
+
+On systems with Simultaneous Multi Threading (SMT)
+it may be possible for a process to affect the indirect branches on a
+process running on a thread sibling on the same core.
+
+Using prctl to restrict indirect branch speculation prevents
+either untrusted code in the current process affect anything else,
+or code running in SMT affect the current process.  This is
+done using STIBP.
+
+This should be only deployed as needed, as it has performance
+impact on both the current process, and any process running
+on the thread sibling.
+
+Under the "seccomp" option, the processes running with SECCOMP
+will be restrained similarly. 
+
+References
+----------
+
+Intel white papers and documents on Spectre:
+
+https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/Intel-Analysis-of-Speculative-Execution-Side-Channels.pdf
+
+[1]
+https://software.intel.com/security-software-guidance/api-app/sites/default/files/Retpoline-A-Branch-Target-Injection-Mitigation.pdf
+
+https://www.intel.com/content/www/us/en/architecture-and-technology/facts-about-side-channel-analysis-and-intel-products.html
+
+[3] https://software.intel.com/security-software-guidance/
+
+AMD white papers:
+
+https://developer.amd.com/wp-content/resources/90343-B_SoftwareTechniquesforManagingSpeculation_WP_7-18Update_FNL.pdf
+
+https://www.amd.com/en/corporate/security-updates
+
+ARM white papers:
+
+https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/download-the-whitepaper
+
+https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability/latest-updates/cache-speculation-issues-update
+
+MIPS:
+
+https://www.mips.com/blog/mips-response-on-speculative-execution-and-side-channel-vulnerabilities/
+
+Academic papers:
+
+https://spectreattack.com/spectre.pdf [original spectre paper]
+
+https://arxiv.org/abs/1807.07940 [Spectre RSB, a variant of Spectre v2]
+
+[2] https://arxiv.org/abs/1807.10535 [NetSpectre]
+
+https://arxiv.org/abs/1811.05441 [generalization of Spectre]
-- 
1.8.3.1

