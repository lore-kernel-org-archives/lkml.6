Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbeEaVHD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:07:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:47168 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbeEaVHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:07:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="228946847"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 05/15] x86/vdso: Move out the CPU number store
Thread-Topic: [PATCH V2 05/15] x86/vdso: Move out the CPU number store
Thread-Index: AQHT+QkbHjx+5Tn+vk6ZsQ1Ma3ygs6RKrXYA//+mK6A=
Date: Thu, 31 May 2018 21:06:57 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66BBA475@CRSMSX101.amr.corp.intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
 <1527789525-8857-6-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXy0bFxGoUB3rfwyJaM0ab5ZPZR0ku-wnBwfx+P+MaL8A@mail.gmail.com>
In-Reply-To: <CALCETrXy0bFxGoUB3rfwyJaM0ab5ZPZR0ku-wnBwfx+P+MaL8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGQxZWM0OTctMTM0Yi00OTliLThjZjQtNDkzYzFjNWE2OTc4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJtMzhMZXVhSitETmM1MjNWUTVkQmdKTnBBckRZOXRJbnIrRUNCSW02OFJJWWFEMkpubTJxRVpISkdWSGlQVzV4In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4VL78no009903

>> +/* Bit size and mask of CPU number stored in the per CPU data */
>> +#define PERCPU_CPU_SIZE                        12
>> +#define PERCPU_CPU_MASK                        0xfff

> This name is confusing.  Maybe LSL_TSCP_CPU_MASK?

> Can you also add a helpers like:

> static inline unsigned long make_lsl_tscp(unsigned int cpu, unsigned
> int node) { ... }
> static inline unsigned int lsl_tscp_to_cpu(unsigned long x) { ... }
> static inline unsigned int lsl_tscp_to_node(unsigned long x) { ... }

> and use them everywhere?  This will make it lot easier to understand the code.

Will rename and include the helpers as suggested.

> +#ifdef CONFIG_X86_32
> +                       GDT_ENTRY_PERCPU,
> +#else /* 64 bit */
> +                       GDT_ENTRY_PER_CPU,
>  #endif

> Please just rename one of these to match the other one.

Okay, I will try.
