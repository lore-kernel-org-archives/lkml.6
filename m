Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 06F58C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A407B208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A407B208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935445AbeFMU1q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:27:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:16490 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754498AbeFMU1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:27:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2018 13:27:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,220,1526367600"; 
   d="scan'208";a="63857502"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2018 13:27:44 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 13 Jun 2018 13:27:42 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.248]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.118]) with mapi id 14.03.0319.002;
 Wed, 13 Jun 2018 13:27:42 -0700
From:   "Warden, Brett T" <brett.t.warden@intel.com>
To:     Jessica Yu <jeyu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] module: Implement sig_unenforce parameter
Thread-Topic: [PATCH v2] module: Implement sig_unenforce parameter
Thread-Index: AQHUAxiaJEKlFUsiK06Ydv9YILZJOqReoMfw
Date:   Wed, 13 Jun 2018 20:27:42 +0000
Message-ID: <7404D3279C2A5140B77235CB241B2D99C03CFB36@ORSMSX115.amr.corp.intel.com>
References: <201806062114.40uzFbuB%fengguang.wu@intel.com>
 <20180606194414.14500-1-brett.t.warden@intel.com>
 <20180613131520.uwtwi67meobos3ws@linux-5o07>
In-Reply-To: <20180613131520.uwtwi67meobos3ws@linux-5o07>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDI0YmNlMmUtZWMyNy00NTJhLWFhOTUtMzE2MmM4ZDgwNWU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZk1xbTU5T1p4UzdcLytuRElNVzZnYmtzOUo2eDN4RjRFcWRnOUV4MkM4NEZKdU9Ia2o2NURkaDBYR3RVOFFNdGsifQ==
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jessica Yu [mailto:jeyu@kernel.org]
> Sent: Wednesday, June 13, 2018 6:15 AM
> To: Warden, Brett T <brett.t.warden@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] module: Implement sig_unenforce parameter
> 
> +++ Brett T. Warden [06/06/18 12:44 -0700]:
> >When CONFIG_MODULE_SIG_FORCE is enabled, also provide a boot-time-only
> >parameter, module.sig_unenforce, to disable signature enforcement. This
> >allows distributions to ship with signature verification enforcement
> >enabled by default, but for users to elect to disable it without
> >recompiling, to support building and loading out-of-tree modules.
> >
> >Signed-off-by: Brett T. Warden <brett.t.warden@intel.com>
> >---
> >
> >Added CONFIG_X86 guards around use of boot_params since this structure
> >is arch-specific.
> >
> > .../admin-guide/kernel-parameters.txt         |  4 +++
> > kernel/module.c                               | 31 +++++++++++++++++--
> > 2 files changed, 33 insertions(+), 2 deletions(-)
> >
> >diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> >index 1beb30d8d7fc..87909e021558 100644
> >--- a/Documentation/admin-guide/kernel-parameters.txt
> >+++ b/Documentation/admin-guide/kernel-parameters.txt
> >@@ -2380,6 +2380,10 @@
> > 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
> > 			is always true, so this option does nothing.
> >
> >+	module.sig_unenforce
> >+			[KNL] This parameter allows modules without signatures
> >+			to be loaded, overriding CONFIG_MODULE_SIG_FORCE.
> >+
> > 	module_blacklist=  [KNL] Do not load a comma-separated list of
> > 			modules.  Useful for debugging problem modules.
> >
> >diff --git a/kernel/module.c b/kernel/module.c
> >index c9bea7f2b43e..27f23d85e1ba 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -64,6 +64,7 @@
> > #include <linux/bsearch.h>
> > #include <linux/dynamic_debug.h>
> > #include <linux/audit.h>
> >+#include <linux/efi.h>
> > #include <uapi/linux/module.h>
> > #include "module-internal.h"
> >
> >@@ -274,9 +275,13 @@ static void module_assert_mutex_or_preempt(void)
> > }
> >
> > static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> >-#ifndef CONFIG_MODULE_SIG_FORCE
> >+#ifdef CONFIG_MODULE_SIG_FORCE
> >+/* Allow disabling module signature requirement by adding boot param */
> >+static bool sig_unenforce;
> >+module_param(sig_unenforce, bool_enable_only, 0444);
> >+#else /* !CONFIG_MODULE_SIG_FORCE */
> > module_param(sig_enforce, bool_enable_only, 0644);
> >-#endif /* !CONFIG_MODULE_SIG_FORCE */
> >+#endif /* CONFIG_MODULE_SIG_FORCE */
> >
> > /*
> >  * Export sig_enforce kernel cmdline parameter to allow other subsystems
> rely
> >@@ -415,6 +420,10 @@ extern const s32 __start___kcrctab_unused[];
> > extern const s32 __start___kcrctab_unused_gpl[];
> > #endif
> >
> >+#ifdef CONFIG_X86
> >+extern struct boot_params boot_params;
> >+#endif
> >+
> > #ifndef CONFIG_MODVERSIONS
> > #define symversion(base, idx) NULL
> > #else
> >@@ -4243,6 +4252,24 @@ static const struct file_operations
> proc_modules_operations = {
> > static int __init proc_modules_init(void)
> > {
> > 	proc_create("modules", 0, NULL, &proc_modules_operations);
> >+
> >+#ifdef CONFIG_MODULE_SIG_FORCE
> >+#ifdef CONFIG_X86
> >+	switch (boot_params.secure_boot) {
> >+	case efi_secureboot_mode_unset:
> >+	case efi_secureboot_mode_unknown:
> >+	case efi_secureboot_mode_disabled:
> >+		/*
> >+		 * sig_unenforce is only applied if SecureBoot is not
> >+		 * enabled.
> >+		 */
> >+		sig_enforce = !sig_unenforce;
> >+	}
> >+#else
> >+	sig_enforce = !sig_unenforce;
> >+#endif
> >+#endif
> 
> I don't want to rope in Secure Boot specifics and arch-specific code
> (other than what's in arch/) into the module loader. I also don't want
> to change the current semantics of CONFIG_MODULE_SIG_FORCE, for any
> existing users who just want to set a build-time policy and already
> assume that unsigned modules can't be loaded, period. Lastly, having
> both sig_enforce and sig_unenforce parameters is really confusing.
> Might as well just make it one parameter - sig_enforce - and make that
> toggleable under a certain configuration.
> 
> It sounds like you want to ship with signature enforcement enabled by
> default, but stil want to make this toggleable for users. So maybe
> something in between CONFIG_MODULE_SIG and CONFIG_MODULE_SIG_FORCE.
> Half baked suggestion: Would a new config option that enforces module
> signatures by default but makes sig_enforce toggleable for users suit
> your use case? This would be less strict than CONFIG_MODULE_SIG_FORCE.
> 
> Thanks,
> 
> Jessica

What if I make a sub-option (default n) of CONFIG_MODULE_SIG_FORCE that
would allow toggling sig_enforce (eliminating sig_unenforce)?
CONFIG_MODULE_SIG_FORCE_ALLOW_OVERRIDE?



Our internal security review produced the requirement to check for
SecureBoot before disabling sig_enforce. I'll have to do some research
to figure out a cleaner way to accomplish that without X86 code in
module.c.


Thanks for the feedback,

-- Brett
