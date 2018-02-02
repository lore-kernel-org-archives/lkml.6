Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeBBUEG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:04:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:39854 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbeBBUD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:03:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="14933785"
Date: Sat, 3 Feb 2018 04:03:02 +0800
From: kbuild test robot <lkp@intel.com>
To: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Cc: kbuild-all@01.org, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
        Len Brown <len.brown@intel.com>, Kyle Huey <me@kylehuey.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Borislav Petkov <bp@suse.de>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kan Liang <Kan.liang@intel.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [RFC PATCH] x86/kvm: perf_ext_supported() can be static
Message-ID: <20180202200302.GA27752@cairo>
References: <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f481ade083edd15c0f5850babaeef378ab06ffce.1517333237.git.Janakarajan.Natarajan@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 60e6688e74ee ("x86/kvm: Expose AMD Core Perf Extension flag to guests")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 cpuid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0c991c6a..5cfd3c2 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -55,7 +55,7 @@ bool kvm_mpx_supported(void)
 }
 EXPORT_SYMBOL_GPL(kvm_mpx_supported);
 
-bool perf_ext_supported(void)
+static bool perf_ext_supported(void)
 {
 	return boot_cpu_has(X86_FEATURE_PERFCTR_CORE);
 }
