Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeC0VQx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:16:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:34366 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeC0VQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:16:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,368,1517904000";
   d="scan'208";a="211819629"
Date: Wed, 28 Mar 2018 05:15:58 +0800
From: kbuild test robot <lkp@intel.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v2 2/2] KVM: X86: Add Force Emulation Prefix for "emulate
 the next instruction"
Message-ID: <201803280558.NGUoaoTS%fengguang.wu@intel.com>
References: <1522141616-9825-3-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522141616-9825-3-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wanpeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvm/linux-next]
[also build test WARNING on next-20180327]
[cannot apply to v4.16-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wanpeng-Li/KVM-X86-Add-Force-Emulation-Prefix-for-emulate-the-next-instruction/20180328-025804
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/kvm/x86.c:149:20: sparse: symbol 'force_emulation_prefix' was not declared. Should it be static?
   arch/x86/kvm/x86.c:2196:38: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const [noderef] <asn:1>*<noident> @@    got d const [noderef] <asn:1>*<noident> @@
   arch/x86/kvm/x86.c:2196:38:    expected void const [noderef] <asn:1>*<noident>
   arch/x86/kvm/x86.c:2196:38:    got unsigned char [usertype] *
   arch/x86/kvm/x86.c:7911:5: sparse: symbol 'kvm_valid_sregs' was not declared. Should it be static?
   arch/x86/kvm/x86.c:8786:16: sparse: incompatible types in comparison expression (different address spaces)
   arch/x86/include/asm/paravirt.h:783:9: sparse: context imbalance in 'vcpu_enter_guest' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
