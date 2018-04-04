Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeDDQJO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:09:14 -0400
Received: from mail-bn3nam01on0045.outbound.protection.outlook.com ([104.47.33.45]:39150
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751648AbeDDQJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:09:11 -0400
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
Thread-Index: AQHTy7IQ+1o1PSI8zEeC82uK+3UGdqPwB/uAgAC6iYCAAASbAA==
Date: Wed, 4 Apr 2018 16:09:07 +0000
Message-ID: <2D4AE288-DD01-416B-9633-1BC9B6A20BFF@vmware.com>
References: <20180404010946.6186729B@viggo.jf.intel.com>
 <20180404011007.A381CC8A@viggo.jf.intel.com>
 <5DEE9F6E-535C-4DBF-A513-69D9FD5C0235@vmware.com>
 <50385d91-58a9-4b14-06bc-2340b99933c3@linux.intel.com>
In-Reply-To: <50385d91-58a9-4b14-06bc-2340b99933c3@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2639;7:uNBDD/KNqBtG9FGVQx89dMlUjPTODu5UrgeYmtnsjkXzA5V82QGJexQu2zIxm8rOaOUd1R3Ww3lSXvfkm+n0G0sAQiuS0BYngfggjgoBMvTFJKI9m4eK5/zPMqXPduOlADlxuuir9by2+Ja/I1fuz7BqhAFVWjgoahDISkusiHHXv/eQxYTyQVwh6yEXjTamF8B4CiOs9o9mhnLtHwnoc8deOVJNfiT8QFTLiT/O05C4KRAh5F11Ol4X57bBh4YI;20:epflMlZASNMvcAx45HK1vUPBQHfzSVZY8CEpwedXbH9l3EgCeLizgEvpopn6pWe2XOO7zcsWMl29FArOCjOL/U+ljoc3oHaHOv1g/oyhsT2yRaWFjW08bVOwPuZxk74SPNQVGHxm1U7SBqYuE6FIAemSapavM1KzzwxM54wyqUk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fb05c883-c6c4-4b88-127c-08d59a466548
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2639;
x-ms-traffictypediagnostic: SN2PR05MB2639:
x-microsoft-antispam-prvs: <SN2PR05MB263978A51E22E34562E53072D0A40@SN2PR05MB2639.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(211936372134217)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR05MB2639;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2639;
x-forefront-prvs: 0632519F33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39380400002)(396003)(39860400002)(189003)(199004)(7416002)(86362001)(478600001)(102836004)(68736007)(11346002)(476003)(26005)(446003)(53546011)(186003)(2616005)(6506007)(105586002)(4326008)(106356001)(7736002)(6116002)(66066001)(3846002)(6916009)(25786009)(83716003)(36756003)(54906003)(305945005)(8936002)(6486002)(53936002)(81166006)(5660300001)(6246003)(8676002)(229853002)(97736004)(81156014)(6436002)(3280700002)(6512007)(33656002)(2906002)(3660700001)(93886005)(82746002)(5250100002)(76176011)(99286004)(486006)(14454004)(316002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2639;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 5Lo5+lNEcai31Kf+Z3L3UaRoYHUq1r5LS91XVFclOE3hP6FhJdGGkQuVsb1TLGnuKJDTJfpON0OVdgC4DFQNL+21bdKzqhyLGBkQ4knzDEyntxs6kti9tX4zRt2+MfUAEC7bjR2KKaV0I4igL0cn5CWcf2qoNp3CNK48CUcmNJshgtU5tAXyqrhfhwAXBSjf3Sg/6jT9fgAHYjtr6MdTsJs00WtfCWEXnnf3sPzapF+w/LHi/O6eBv86iu2KcClnJRu2EeEL4tN9LEMiibBBlgzi3iO+VK2SGBVbnzSl9/itgZqshLa4i4LmqiB0PdQKFfOyNwvZxkQa8/c4K11svpMO1dBqfEApjq7enSgo2ysmYFh43Xf8/p+B2sPRg/es1xKdRnVC5tGINOc1wmb6g47i+WeCOT4xxdfg+b5jcbI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05255EB8D8517549915D5EB3357BD3D9@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05c883-c6c4-4b88-127c-08d59a466548
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2018 16:09:07.8997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2639
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34G9L1l029143

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 04/03/2018 09:45 PM, Nadav Amit wrote:
>> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>> 
>>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>> 
>>> The entry/exit text and cpu_entry_area are mapped into userspace and
>>> the kernel.  But, they are not _PAGE_GLOBAL.  This creates unnecessary
>>> TLB misses.
>>> 
>>> Add the _PAGE_GLOBAL flag for these areas.
>>> 
>>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Cc: Kees Cook <keescook@google.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Juergen Gross <jgross@suse.com>
>>> Cc: x86@kernel.org
>>> Cc: Nadav Amit <namit@vmware.com>
>>> ---
>>> 
>>> b/arch/x86/mm/cpu_entry_area.c |   10 +++++++++-
>>> b/arch/x86/mm/pti.c            |   14 +++++++++++++-
>>> 2 files changed, 22 insertions(+), 2 deletions(-)
>>> 
>>> diff -puN arch/x86/mm/cpu_entry_area.c~kpti-why-no-global arch/x86/mm/cpu_entry_area.c
>>> --- a/arch/x86/mm/cpu_entry_area.c~kpti-why-no-global	2018-04-02 16:41:17.157605167 -0700
>>> +++ b/arch/x86/mm/cpu_entry_area.c	2018-04-02 16:41:17.162605167 -0700
>>> @@ -27,8 +27,16 @@ EXPORT_SYMBOL(get_cpu_entry_area);
>>> void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
>>> {
>>> 	unsigned long va = (unsigned long) cea_vaddr;
>>> +	pte_t pte = pfn_pte(pa >> PAGE_SHIFT, flags);
>>> 
>>> -	set_pte_vaddr(va, pfn_pte(pa >> PAGE_SHIFT, flags));
>>> +	/*
>>> +	 * The cpu_entry_area is shared between the user and kernel
>>> +	 * page tables.  All of its ptes can safely be global.
>>> +	 */
>>> +	if (boot_cpu_has(X86_FEATURE_PGE))
>>> +		pte = pte_set_flags(pte, _PAGE_GLOBAL);
>> 
>> I think it would be safer to check that the PTE is indeed present before
>> setting _PAGE_GLOBAL. For example, percpu_setup_debug_store() sets PAGE_NONE
>> for non-present entries. In this case, since PAGE_NONE and PAGE_GLOBAL use
>> the same bit, everything would be fine, but it might cause bugs one day.
> 
> That's a reasonable safety thing to add, I think.
> 
> But, looking at it, I am wondering why we did this in
> percpu_setup_debug_store():
> 
>        for (; npages; npages--, cea += PAGE_SIZE)
>                cea_set_pte(cea, 0, PAGE_NONE);
> 
> Did we really want that to be PAGE_NONE, or was it supposed to create a
> PTE that returns true for pte_none()?

I yield it to others to answer...

> 
>>> /*
>>> +		 * Setting 'target_pmd' below creates a mapping in both
>>> +		 * the user and kernel page tables.  It is effectively
>>> +		 * global, so set it as global in both copies.  Note:
>>> +		 * the X86_FEATURE_PGE check is not _required_ because
>>> +		 * the CPU ignores _PAGE_GLOBAL when PGE is not
>>> +		 * supported.  The check keeps consistentency with
>>> +		 * code that only set this bit when supported.
>>> +		 */
>>> +		if (boot_cpu_has(X86_FEATURE_PGE))
>>> +			*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
>> 
>> Same here.
> 
> Is there  a reason that the pmd_none() check above this does not work?

For any practical reasons, right now, it should be fine. But pmd_none() will
not save us if _PAGE_PROTNONE ever changes, for example. Note that the check
is with pmd_none() and not pmd_protnone().
