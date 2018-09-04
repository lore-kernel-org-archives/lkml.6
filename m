Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E1C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F6820658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F6820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeIECwV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:52:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:42652 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIECwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:52:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 15:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="80889970"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2018 15:25:09 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 15:25:11 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.139]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 15:25:11 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V3 2/5] efi: Introduce __efi_init attribute
Thread-Topic: [PATCH V3 2/5] efi: Introduce __efi_init attribute
Thread-Index: AQHURJygUP1gh8tApk2emZPW/4FVg6TgsWJg
Date:   Tue, 4 Sep 2018 22:25:11 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485B981D@ORSMSX114.amr.corp.intel.com>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536099149-12564-3-git-send-email-sai.praneeth.prakhya@intel.com>
In-Reply-To: <1536099149-12564-3-git-send-email-sai.praneeth.prakhya@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjFkODI1MDYtMTk2Ni00OGJhLWE1NTAtNzVmNDZjODZiY2RlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9iYnBvQ0dPdktJWEh5NGRNQ1I1MWlYNGcyV0VPc2FkZmViaUp3MDB1SDFRekEybFwvVjZMMVg5QngySE9zN1RVIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris and Ard,

> Buggy firmware could illegally access some efi regions even after the kernel has
> assumed control of the platform. When
> "CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS" is enabled, the efi page fault
> handler will detect and recover from these illegal accesses.
> efi_md_typeattr_format() and memory_type_name are used by the efi page
> fault handler to print information about memory descriptor that was illegally
> accessed. As the page fault handler is present during/after kernel boot it doesn't
> have an __init attribute, but
> efi_md_typeattr_format() has it and thus during kernel build, "WARNING:
> modpost: Found * section mismatch(es)" build warning is observed. To fix it,
> remove __init attribute for efi_md_typeattr_format().
> 
> In order to not keep efi_md_typeattr_format() and memory_type_name
> needlessly when "CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS" is not selected,
> add a new __efi_init attribute whose value changes based on whether the config
> option is selected or not.

In previous versions (i.e. up to V2), where we handled EFI_BOOT_SERVICES_<CODE/DATA> 
regions differently, it made sense to have a separate attribute like __efi_init because many 
function definitions were modified. From V3, do you think it's still OK to have __efi_init or 
should I just remove __init attribute (and not have __efi_init) for efi_md_typeattr_format() 
and memory_type_name because we are just modifying two.

Regards,
Sai
