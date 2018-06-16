Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2FFC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79334208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 03:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79334208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756792AbeFPDkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 23:40:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:20370 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753613AbeFPDkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 23:40:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 20:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="50331179"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2018 20:40:00 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fU24F-000Hcz-9x; Sat, 16 Jun 2018 11:39:59 +0800
Date:   Sat, 16 Jun 2018 11:39:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     kbuild-all@01.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Message-ID: <201806161143.AVrY9pr4%fengguang.wu@intel.com>
References: <20180615174731.47588-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615174731.47588-1-mka@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kvm/linux-next]
[also build test WARNING on v4.17 next-20180615]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matthias-Kaehlcke/kvm-x86-mmu-Add-cast-to-negated-bitmasks-in-update_permission_bitmask/20180616-015357
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git linux-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/seq_buf.h:71:16: sparse: expression using sizeof(void)
   include/linux/seq_buf.h:71:16: sparse: expression using sizeof(void)
   include/linux/seq_buf.h:71:16: sparse: expression using sizeof(void)
   include/linux/seq_buf.h:71:16: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:1123:21: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:1123:21: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:1769:37: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:1769:37: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:1770:35: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:1770:35: sparse: expression using sizeof(void)
   arch/x86/kvm/paging_tmpl.h:788:33: sparse: expression using sizeof(void)
   arch/x86/kvm/paging_tmpl.h:788:33: sparse: expression using sizeof(void)
   arch/x86/kvm/paging_tmpl.h:788:33: sparse: expression using sizeof(void)
   arch/x86/kvm/paging_tmpl.h:788:33: sparse: expression using sizeof(void)
   arch/x86/kvm/paging_tmpl.h:788:33: sparse: expression using sizeof(void)
   arch/x86/kvm/paging_tmpl.h:788:33: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:5168:33: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:5168:33: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:5169:31: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:5169:31: sparse: expression using sizeof(void)
   arch/x86/kvm/mmu.c:5548:24: sparse: expression using sizeof(void)
>> arch/x86/kvm/mmu.c:4280:57: sparse: cast truncates bits from constant value (ffffff33 becomes 33)
>> arch/x86/kvm/mmu.c:4282:56: sparse: cast truncates bits from constant value (ffffff0f becomes f)
>> arch/x86/kvm/mmu.c:4284:57: sparse: cast truncates bits from constant value (ffffff55 becomes 55)

vim +4280 arch/x86/kvm/mmu.c

  4247	
  4248	#define BYTE_MASK(access) \
  4249		((1 & (access) ? 2 : 0) | \
  4250		 (2 & (access) ? 4 : 0) | \
  4251		 (3 & (access) ? 8 : 0) | \
  4252		 (4 & (access) ? 16 : 0) | \
  4253		 (5 & (access) ? 32 : 0) | \
  4254		 (6 & (access) ? 64 : 0) | \
  4255		 (7 & (access) ? 128 : 0))
  4256	
  4257	
  4258	static void update_permission_bitmask(struct kvm_vcpu *vcpu,
  4259					      struct kvm_mmu *mmu, bool ept)
  4260	{
  4261		unsigned byte;
  4262	
  4263		const u8 x = BYTE_MASK(ACC_EXEC_MASK);
  4264		const u8 w = BYTE_MASK(ACC_WRITE_MASK);
  4265		const u8 u = BYTE_MASK(ACC_USER_MASK);
  4266	
  4267		bool cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
  4268		bool cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
  4269		bool cr0_wp = is_write_protection(vcpu);
  4270	
  4271		for (byte = 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
  4272			unsigned pfec = byte << 1;
  4273	
  4274			/*
  4275			 * Each "*f" variable has a 1 bit for each UWX value
  4276			 * that causes a fault with the given PFEC.
  4277			 */
  4278	
  4279			/* Faults from writes to non-writable pages */
> 4280			u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
  4281			/* Faults from user mode accesses to supervisor pages */
> 4282			u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
  4283			/* Faults from fetches of non-executable pages*/
> 4284			u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
  4285			/* Faults from kernel mode fetches of user pages */
  4286			u8 smepf = 0;
  4287			/* Faults from kernel mode accesses of user pages */
  4288			u8 smapf = 0;
  4289	
  4290			if (!ept) {
  4291				/* Faults from kernel mode accesses to user pages */
  4292				u8 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
  4293	
  4294				/* Not really needed: !nx will cause pte.nx to fault */
  4295				if (!mmu->nx)
  4296					ff = 0;
  4297	
  4298				/* Allow supervisor writes if !cr0.wp */
  4299				if (!cr0_wp)
  4300					wf = (pfec & PFERR_USER_MASK) ? wf : 0;
  4301	
  4302				/* Disallow supervisor fetches of user code if cr4.smep */
  4303				if (cr4_smep)
  4304					smepf = (pfec & PFERR_FETCH_MASK) ? kf : 0;
  4305	
  4306				/*
  4307				 * SMAP:kernel-mode data accesses from user-mode
  4308				 * mappings should fault. A fault is considered
  4309				 * as a SMAP violation if all of the following
  4310				 * conditions are ture:
  4311				 *   - X86_CR4_SMAP is set in CR4
  4312				 *   - A user page is accessed
  4313				 *   - The access is not a fetch
  4314				 *   - Page fault in kernel mode
  4315				 *   - if CPL = 3 or X86_EFLAGS_AC is clear
  4316				 *
  4317				 * Here, we cover the first three conditions.
  4318				 * The fourth is computed dynamically in permission_fault();
  4319				 * PFERR_RSVD_MASK bit will be set in PFEC if the access is
  4320				 * *not* subject to SMAP restrictions.
  4321				 */
  4322				if (cr4_smap)
  4323					smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
  4324			}
  4325	
  4326			mmu->permissions[byte] = ff | uf | wf | smepf | smapf;
  4327		}
  4328	}
  4329	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
