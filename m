Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC594C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BD121104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BD121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeK3FeC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:34:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:21410 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbeK3FeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:34:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 10:27:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="290995738"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2018 10:27:44 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 29 Nov 2018 10:27:44 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.106]) with mapi id 14.03.0415.000;
 Thu, 29 Nov 2018 10:27:44 -0800
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "YiFei Zhu" <zhuyifei1999@gmail.com>
Subject: RE: [GIT PULL 00/11] EFI updates
Thread-Topic: [GIT PULL 00/11] EFI updates
Thread-Index: AQHUiAbHOvhS3sTUD06cGnW0DdiISqVnEMMA
Date:   Thu, 29 Nov 2018 18:27:43 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485F14B8@ORSMSX114.amr.corp.intel.com>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGMxOGQ0ZDUtOTgxMy00ZmEzLTgxNjktOTZiYjcxZTkxN2Y3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQlRsa2tJNUpzMUFlaUF4UlV2bWpwK3hoZ29rTEJTNzg1c3RKRTJlc0JLOE85R0ZVVEZmVDZIaEJoVlZyWWlWbiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

While building from next branch of efi tree, I noticed the below warning. Could you please check the same on your side?

  CC      lib/list_debug.o
drivers/firmware/efi/efi.c: In function 'efi_mem_reserve_persistent':
drivers/firmware/efi/efi.c:1000:6: warning: unused variable 'rsvsize' [-Wunused-variable]
  int rsvsize = EFI_MEMRESERVE_SIZE(1);
      ^~~~~~~
  CC      lib/bitrev.o
  CC      net/core/sock_reuseport.o

> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> Sent: Thursday, November 29, 2018 9:12 AM
> To: linux-efi@vger.kernel.org; Ingo Molnar <mingo@kernel.org>; Thomas
> Gleixner <tglx@linutronix.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>; linux-kernel@vger.kernel.org;
> Andy Lutomirski <luto@kernel.org>; Arend van Spriel
> <arend.vanspriel@broadcom.com>; Bhupesh Sharma <bhsharma@redhat.com>;
> Borislav Petkov <bp@alien8.de>; Hansen, Dave <dave.hansen@intel.com>; Eric
> Snowberg <eric.snowberg@oracle.com>; Hans de Goede
> <hdegoede@redhat.com>; Joe Perches <joe@perches.com>; Jon Hunter
> <jonathanh@nvidia.com>; Julien Thierry <julien.thierry@arm.com>; Marc
> Zyngier <marc.zyngier@arm.com>; Nathan Chancellor
> <natechancellor@gmail.com>; Peter Zijlstra <peterz@infradead.org>; Prakhya,
> Sai Praneeth <sai.praneeth.prakhya@intel.com>; Sedat Dilek
> <sedat.dilek@gmail.com>; YiFei Zhu <zhuyifei1999@gmail.com>
> Subject: [GIT PULL 00/11] EFI updates
> 
> The following changes since commit
> 976b489120cdab2b1b3a41ffa14661db43d58190:
> 
>   efi: Prevent GICv3 WARN() by mapping the memreserve table before first use
> (2018-11-27 13:50:20 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> 
> for you to fetch changes up to 1d29afdbf7ae878a23627ebee81efcd213f11749:
> 
>   efi/x86: earlyprintk - Fix infinite loop on some screen widths (2018-11-28
> 17:58:42 +0100)
>

Regards,
Sai
