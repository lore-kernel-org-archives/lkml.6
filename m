Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeDDEpE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:45:04 -0400
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:62784
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750770AbeDDEpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:45:02 -0400
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        Hugh Dickins <hughd@google.com>, Juergen Gross <jgross@suse.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 09/11] x86/pti: enable global pages for shared areas
Thread-Topic: [PATCH 09/11] x86/pti: enable global pages for shared areas
Thread-Index: AQHTy7IQ+1o1PSI8zEeC82uK+3UGdqPwB/uA
Date: Wed, 4 Apr 2018 04:45:00 +0000
Message-ID: <5DEE9F6E-535C-4DBF-A513-69D9FD5C0235@vmware.com>
References: <20180404010946.6186729B@viggo.jf.intel.com>
 <20180404011007.A381CC8A@viggo.jf.intel.com>
In-Reply-To: <20180404011007.A381CC8A@viggo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4580:b719:1434:a5d7:2a3c:bb2a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2718;7:Eck/3SyGujIYUSvKyDjDkhP/M+8WKmLp9C0bLsE0svD6AEdY5NaY4mGkwK+Zup+hpu8ifyNr8A1mZD1AhkMjxeSuL7cnRq/jH5S02U5uWbnlfToa0tIxoF8iUf1Joj94xqVN5jaJ8ZXedwr/1WqJEb02mQwkNmwLRZGjtrzGhJ+9adNMYdA5Oxb2J2nLGDNeg9C1+Yh2JeuRJR/VJLlwHaWi02T7IDp3oM17y74Zb+mtburuGb+a//5H17N0QAmU;20:9oVCKpJKqY4JLBPOMMTXgoc3c3OMjeep0Ue/CrysFM9z/+aM5QWAc5zhm3pUf7XvtqK7dCT+v9maWuG7yeb2KemQSrEk27pdtvaaCwP/QgNb1vomFUFM7eK146EE4Bi9fqJ0y5r5MJq0QLmDEyk3QBfmTfY4e82c/57jy0/kd4E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b99041cd-c83b-4deb-f9ac-08d599e6d2e4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2718;
x-ms-traffictypediagnostic: SN2PR05MB2718:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB27182A64C42E9421836C07ADD0A40@SN2PR05MB2718.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR05MB2718;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2718;
x-forefront-prvs: 0632519F33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(199004)(189003)(53936002)(6246003)(4326008)(46003)(186003)(6506007)(6436002)(36756003)(6116002)(14454004)(2906002)(486006)(102836004)(305945005)(6512007)(316002)(478600001)(82746002)(83716003)(106356001)(25786009)(7736002)(68736007)(5660300001)(7416002)(476003)(86362001)(97736004)(2900100001)(5250100002)(33656002)(105586002)(99286004)(76176011)(229853002)(8936002)(54906003)(6916009)(8676002)(3280700002)(2616005)(446003)(11346002)(81156014)(81166006)(6486002)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2718;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Syt8ZeR7X+KMXud3OIhVBpVReUtE+NO+EmXch0zdIcnAjPlO+o7riT0d66wwCQvZSrgLGx14NF8FPjMn9F59kOPIVmWklpJAsG/cxNUxVYwMiNWry8CVOq11Pp/d/zuZo8rWYcJmWPHHSK8xQZaLNSe1tEFQQ55plDn9PYsF8WVRijlqp3Cw7hyO0bYT7mCQsgeEQRXZdN33n6i56yDNkKwQRcg73lfDNpa2xBsQNUhHfisQSvSECVn3weBneuqKLqESCyEo5/5UQCMV76zIeR2VZpskyrXqF16jFnnUW7BDtD2XJt6XJC6AReUTQT/jU4QVM2ynWXl3JvxyW1sQWqDr91c3otTHfCbToAdIHISY1vBk/MWGH2iShKCcs68ePc7fJRLeiqj0mHNbcEtFdYI+sfP9iq09AMcx+m9gbC0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <300A969C8CDA014D8CC252058F38C16F@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99041cd-c83b-4deb-f9ac-08d599e6d2e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2018 04:45:00.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2718
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w344jRfE012811

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The entry/exit text and cpu_entry_area are mapped into userspace and
> the kernel.  But, they are not _PAGE_GLOBAL.  This creates unnecessary
> TLB misses.
> 
> Add the _PAGE_GLOBAL flag for these areas.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <keescook@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Cc: Nadav Amit <namit@vmware.com>
> ---
> 
> b/arch/x86/mm/cpu_entry_area.c |   10 +++++++++-
> b/arch/x86/mm/pti.c            |   14 +++++++++++++-
> 2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff -puN arch/x86/mm/cpu_entry_area.c~kpti-why-no-global arch/x86/mm/cpu_entry_area.c
> --- a/arch/x86/mm/cpu_entry_area.c~kpti-why-no-global	2018-04-02 16:41:17.157605167 -0700
> +++ b/arch/x86/mm/cpu_entry_area.c	2018-04-02 16:41:17.162605167 -0700
> @@ -27,8 +27,16 @@ EXPORT_SYMBOL(get_cpu_entry_area);
> void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
> {
> 	unsigned long va = (unsigned long) cea_vaddr;
> +	pte_t pte = pfn_pte(pa >> PAGE_SHIFT, flags);
> 
> -	set_pte_vaddr(va, pfn_pte(pa >> PAGE_SHIFT, flags));
> +	/*
> +	 * The cpu_entry_area is shared between the user and kernel
> +	 * page tables.  All of its ptes can safely be global.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_PGE))
> +		pte = pte_set_flags(pte, _PAGE_GLOBAL);

I think it would be safer to check that the PTE is indeed present before
setting _PAGE_GLOBAL. For example, percpu_setup_debug_store() sets PAGE_NONE
for non-present entries. In this case, since PAGE_NONE and PAGE_GLOBAL use
the same bit, everything would be fine, but it might cause bugs one day.

> +
> +	set_pte_vaddr(va, pte);
> }
> 
> static void __init
> diff -puN arch/x86/mm/pti.c~kpti-why-no-global arch/x86/mm/pti.c
> --- a/arch/x86/mm/pti.c~kpti-why-no-global	2018-04-02 16:41:17.159605167 -0700
> +++ b/arch/x86/mm/pti.c	2018-04-02 16:41:17.163605167 -0700
> @@ -300,6 +300,18 @@ pti_clone_pmds(unsigned long start, unsi
> 			return;
> 
> 		/*
> +		 * Setting 'target_pmd' below creates a mapping in both
> +		 * the user and kernel page tables.  It is effectively
> +		 * global, so set it as global in both copies.  Note:
> +		 * the X86_FEATURE_PGE check is not _required_ because
> +		 * the CPU ignores _PAGE_GLOBAL when PGE is not
> +		 * supported.  The check keeps consistentency with
> +		 * code that only set this bit when supported.
> +		 */
> +		if (boot_cpu_has(X86_FEATURE_PGE))
> +			*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);

Same here.
