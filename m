Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ahA7ANrVGFu4LwAAmS7hNA
	; Thu, 07 Jun 2018 06:51:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BCED5608BF; Thu,  7 Jun 2018 06:51:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6EE8A607F7;
	Thu,  7 Jun 2018 06:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EE8A607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeFGGu5 convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 02:50:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:1708 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750897AbeFGGuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 02:50:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 23:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="206029272"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2018 23:50:54 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 6 Jun 2018 23:50:54 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 6 Jun 2018 23:50:53 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.87]) with mapi id 14.03.0319.002;
 Thu, 7 Jun 2018 14:50:51 +0800
From: "Kang, Luwei" <luwei.kang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "alexander.shishkin@linux.intel.com"
        <alexander.shishkin@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
CC: "x86@kernel.org" <x86@kernel.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "bp@suse.de" <bp@suse.de>, "Liang, Kan" <kan.liang@intel.com>,
        "Janakarajan.Natarajan@amd.com" <Janakarajan.Natarajan@amd.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsd@redhat.com" <bsd@redhat.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v9 01/12] perf/x86/intel/pt: Move Intel-PT MSRs bit
 definitions to a public header
Thread-Topic: [PATCH v9 01/12] perf/x86/intel/pt: Move Intel-PT MSRs bit
 definitions to a public header
Thread-Index: AQHT8XiywMAZxFSpsEGuxZJAkMIGbaRUcLog
Date: Thu, 7 Jun 2018 06:50:50 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E167FE8E4B@SHSMSX101.ccr.corp.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-2-git-send-email-luwei.kang@intel.com>
In-Reply-To: <1526964735-16566-2-git-send-email-luwei.kang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGNiOTlmMWQtNmIyNS00MGMzLTg0YzktNjNkODczYzdjNTU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWWJsanpvS1RpamhYb3lWcFJwcHNEVHlIRjFjcFwvMjhcL3BcLzhENFRiUFg0SmxXNjJHSUVMbWsxaEZwNTV2bWF3MCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kang, Luwei
> Sent: Tuesday, May 22, 2018 12:52 PM
> To: kvm@vger.kernel.org
> Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org; chao.p.peng@linux.intel.com;
> thomas.lendacky@amd.com; bp@suse.de; Liang, Kan <kan.liang@intel.com>; Janakarajan.Natarajan@amd.com;
> dwmw@amazon.co.uk; linux-kernel@vger.kernel.org; alexander.shishkin@linux.intel.com; peterz@infradead.org;
> mathieu.poirier@linaro.org; kstewart@linuxfoundation.org; gregkh@linuxfoundation.org; pbonzini@redhat.com;
> rkrcmar@redhat.com; david@redhat.com; bsd@redhat.com; yu.c.zhang@linux.intel.com; joro@8bytes.org; Kang, Luwei
> <luwei.kang@intel.com>
> Subject: [PATCH v9 01/12] perf/x86/intel/pt: Move Intel-PT MSRs bit definitions to a public header
> 
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Intel Processor Trace virtualization enabling in KVM guest need to access these MSRs bit definitions, so move them to public header
> file msr-index.h.
> 
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> ---
>  arch/x86/events/intel/pt.h       | 37 -------------------------------------
>  arch/x86/include/asm/msr-index.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h index 0eb41d0..0050ca1 100644
> --- a/arch/x86/events/intel/pt.h
> +++ b/arch/x86/events/intel/pt.h
> @@ -20,43 +20,6 @@
>  #define __INTEL_PT_H__
> 
>  /*
> - * PT MSR bit definitions
> - */
> -#define RTIT_CTL_TRACEEN		BIT(0)
> -#define RTIT_CTL_CYCLEACC		BIT(1)
> -#define RTIT_CTL_OS			BIT(2)
> -#define RTIT_CTL_USR			BIT(3)
> -#define RTIT_CTL_PWR_EVT_EN		BIT(4)
> -#define RTIT_CTL_FUP_ON_PTW		BIT(5)
> -#define RTIT_CTL_CR3EN			BIT(7)
> -#define RTIT_CTL_TOPA			BIT(8)
> -#define RTIT_CTL_MTC_EN			BIT(9)
> -#define RTIT_CTL_TSC_EN			BIT(10)
> -#define RTIT_CTL_DISRETC		BIT(11)
> -#define RTIT_CTL_PTW_EN			BIT(12)
> -#define RTIT_CTL_BRANCH_EN		BIT(13)
> -#define RTIT_CTL_MTC_RANGE_OFFSET	14
> -#define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
> -#define RTIT_CTL_CYC_THRESH_OFFSET	19
> -#define RTIT_CTL_CYC_THRESH		(0x0full << RTIT_CTL_CYC_THRESH_OFFSET)
> -#define RTIT_CTL_PSB_FREQ_OFFSET	24
> -#define RTIT_CTL_PSB_FREQ      		(0x0full << RTIT_CTL_PSB_FREQ_OFFSET)
> -#define RTIT_CTL_ADDR0_OFFSET		32
> -#define RTIT_CTL_ADDR0      		(0x0full << RTIT_CTL_ADDR0_OFFSET)
> -#define RTIT_CTL_ADDR1_OFFSET		36
> -#define RTIT_CTL_ADDR1      		(0x0full << RTIT_CTL_ADDR1_OFFSET)
> -#define RTIT_CTL_ADDR2_OFFSET		40
> -#define RTIT_CTL_ADDR2      		(0x0full << RTIT_CTL_ADDR2_OFFSET)
> -#define RTIT_CTL_ADDR3_OFFSET		44
> -#define RTIT_CTL_ADDR3      		(0x0full << RTIT_CTL_ADDR3_OFFSET)
> -#define RTIT_STATUS_FILTEREN		BIT(0)
> -#define RTIT_STATUS_CONTEXTEN		BIT(1)
> -#define RTIT_STATUS_TRIGGEREN		BIT(2)
> -#define RTIT_STATUS_BUFFOVF		BIT(3)
> -#define RTIT_STATUS_ERROR		BIT(4)
> -#define RTIT_STATUS_STOPPED		BIT(5)
> -
> -/*
>   * Single-entry ToPA: when this close to region boundary, switch
>   * buffers to avoid losing data.
>   */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 53d5b1b..afe4e13 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -106,7 +106,40 @@
>  #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
> 
>  #define MSR_IA32_RTIT_CTL		0x00000570
> +#define RTIT_CTL_TRACEEN		BIT(0)
> +#define RTIT_CTL_CYCLEACC		BIT(1)
> +#define RTIT_CTL_OS			BIT(2)
> +#define RTIT_CTL_USR			BIT(3)
> +#define RTIT_CTL_PWR_EVT_EN		BIT(4)
> +#define RTIT_CTL_FUP_ON_PTW		BIT(5)
> +#define RTIT_CTL_CR3EN			BIT(7)
> +#define RTIT_CTL_TOPA			BIT(8)
> +#define RTIT_CTL_MTC_EN			BIT(9)
> +#define RTIT_CTL_TSC_EN			BIT(10)
> +#define RTIT_CTL_DISRETC		BIT(11)
> +#define RTIT_CTL_PTW_EN			BIT(12)
> +#define RTIT_CTL_BRANCH_EN		BIT(13)
> +#define RTIT_CTL_MTC_RANGE_OFFSET	14
> +#define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
> +#define RTIT_CTL_CYC_THRESH_OFFSET	19
> +#define RTIT_CTL_CYC_THRESH		(0x0full << RTIT_CTL_CYC_THRESH_OFFSET)
> +#define RTIT_CTL_PSB_FREQ_OFFSET	24
> +#define RTIT_CTL_PSB_FREQ		(0x0full << RTIT_CTL_PSB_FREQ_OFFSET)
> +#define RTIT_CTL_ADDR0_OFFSET		32
> +#define RTIT_CTL_ADDR0			(0x0full << RTIT_CTL_ADDR0_OFFSET)
> +#define RTIT_CTL_ADDR1_OFFSET		36
> +#define RTIT_CTL_ADDR1			(0x0full << RTIT_CTL_ADDR1_OFFSET)
> +#define RTIT_CTL_ADDR2_OFFSET		40
> +#define RTIT_CTL_ADDR2			(0x0full << RTIT_CTL_ADDR2_OFFSET)
> +#define RTIT_CTL_ADDR3_OFFSET		44
> +#define RTIT_CTL_ADDR3			(0x0full << RTIT_CTL_ADDR3_OFFSET)
>  #define MSR_IA32_RTIT_STATUS		0x00000571
> +#define RTIT_STATUS_FILTEREN		BIT(0)
> +#define RTIT_STATUS_CONTEXTEN		BIT(1)
> +#define RTIT_STATUS_TRIGGEREN		BIT(2)
> +#define RTIT_STATUS_BUFFOVF		BIT(3)
> +#define RTIT_STATUS_ERROR		BIT(4)
> +#define RTIT_STATUS_STOPPED		BIT(5)
>  #define MSR_IA32_RTIT_ADDR0_A		0x00000580
>  #define MSR_IA32_RTIT_ADDR0_B		0x00000581
>  #define MSR_IA32_RTIT_ADDR1_A		0x00000582

Hi,
    Patch 1~5 have some code changes in x86 native for Intel Processor Trace virtualization enabling in KVM guest.
    I have sent patch set v9 which include some minor changes from old version.
    Do you have any comments?

Thanks,
Luwei Kang
