Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1378925-1527560467-2-4682927571519056846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527560466; b=LQ413nd5UxTlFumCaKyV/dsT+ljebfROnzGyEl9++/NMPAB90s
    FzfviXsBABUINacP98IpGL2xYjl2ipt1HLpMb2nYeB1kh2AW/C7TCLTUySMRDDD9
    OP932d744I+wo+7u3GPXhzzyXYqcsPytZAAxdtx0dKTfdMewNd2RjS7Gr/R4BLpx
    wk92mdx/H0tkRrwmVfoSSuSSxJMbP4wXQG6uGIoiU+JJsf7JtP69J1QUKqViWh+o
    fRmVDSLQmlpqtDrbJNqJqlEEmgv1dEVic9c1pC5PyhZWXwOsJjcWjQ85IhDWVcUT
    3O/vMFoO5yHscMcN8P2/rWrLW5yl3//GN0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527560466; bh=
    Fpl07SEPbOFTYHUbgKUkRu2qSE/T50iGffMUgnjbDTs=; b=Y5KlC/fFJNce4aVT
    GHdAwweSycR0Ud9pOQ3XuA1vn7lPt7aLk1uIPSwmkjUCQTRdH1KOwMcmlR23DRiA
    Y+9XNSQirk+u/XhYWJEhm2gfgjPC//ib5RZOWIhihZABYx+v8T1jzxMdzTZ9a7pC
    d8F2uFhCgPwPN66gLhYLCz3J7BiJSnonXxrUMZlsp1e6xdvkt2qzd11C6MjMN25B
    DHpTSU74PwCes04D7twB8tq5Cyu5zGcDPp1astLCu84izahsP7o5IPyLvoPICj+O
    W2PLrX5BO6MO+2viuAhJPuoN2FdoVkm4K6Ka7PgSUHi0Y2Lwpr5NVu/+u2vuD8tD
    +Um0uw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMJ1I9UXLeeoFed647zKCSMc2VMcyElvZAM98H7AvHbTK4D5G1sX73m099OGIrEys2B+rdyHNAtA/Q/SD/rtoQs3JXUfDsKS2s6ZfBk24n2vE+vy9VPv
    MErMHLTVkAOweKDSm81Pgirb0XBhdFP4w9M+ihGOKtK+fsr7pywGqSblvunJqlrZ9EQhoJ1V6+KpyEvfi4J5II82xxoR8g/SeE54JkzCAy95bdGKpFYeB+AY
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8
    a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8 a=CxaZg77CAAAA:8 a=pGLkceISAAAA:8
    a=vQjrHL2NPSDogq3NUb0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=HxQw6O0h_v37Y3_G5fB_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756042AbeE2CVE (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 22:21:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:58221 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753829AbeE2CVA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 28 May 2018 22:21:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,454,1520924400";
   d="scan'208";a="232484736"
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH V5 1/3] x86/efi: Make efi_delete_dummy_variable() use set_variable_nonblocking() instead of set_variable()
Date: Mon, 28 May 2018 19:21:02 -0700
Message-Id: <1527560464-19466-2-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527560464-19466-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1527560464-19466-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Presently, efi_delete_dummy_variable() uses set_variable() which might
block and hence kernel prints stack trace with a warning "bad:
scheduling from the idle thread!". So, make efi_delete_dummy_variable()
use set_variable_nonblocking(), which, as the name suggests doesn't
block.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Naresh Bhat <naresh.bhat@linaro.org>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 arch/x86/platform/efi/quirks.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 36c1f8b9f7e0..6af39dc40325 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -105,12 +105,11 @@ early_param("efi_no_storage_paranoia", setup_storage_paranoia);
 */
 void efi_delete_dummy_variable(void)
 {
-	efi.set_variable((efi_char16_t *)efi_dummy_name,
-			 &EFI_DUMMY_GUID,
-			 EFI_VARIABLE_NON_VOLATILE |
-			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
-			 EFI_VARIABLE_RUNTIME_ACCESS,
-			 0, NULL);
+	efi.set_variable_nonblocking((efi_char16_t *)efi_dummy_name,
+				     &EFI_DUMMY_GUID,
+				     EFI_VARIABLE_NON_VOLATILE |
+				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
 }
 
 /*
-- 
2.7.4

