Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeCHVnb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 16:43:31 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:58958 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbeCHVna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 16:43:30 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gratian.crisan@ni.com" <gratian.crisan@ni.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "julia.cartwright@ni.com" <julia.cartwright@ni.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>, "bp@suse.de" <bp@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "gratian@gmail.com" <gratian@gmail.com>
Subject: Re: Kernel page fault in vmalloc_fault() after a preempted ioremap
Thread-Topic: Kernel page fault in vmalloc_fault() after a preempted ioremap
Thread-Index: AQHTtxziQtlM51KvoU6CmjuDs6qNDKPG602A
Date: Thu, 8 Mar 2018 21:43:25 +0000
Message-ID: <1520548101.2693.106.camel@hpe.com>
References: <87a7vi1f3h.fsf@kerf.amer.corp.natinst.com>
In-Reply-To: <87a7vi1f3h.fsf@kerf.amer.corp.natinst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0529;7:hDQg42/X8cr9tgJX0/iTcMLqDqgmG2aTeAVq37QgKk198L1G7lPmnSIpyJLaU/DB/d7q7tEzb9f/2i9oqb02Pzzu8dj8FeJAqnwC5SXQFkRgXPFGBuU3yMSKwQGglDmqndDyDGhvqv129lYrzOFphpW8RXO+AtmCMR7VpU3MpPkcI1oGzi1nn281biAolLbsi1teR2HuzZaMaM1+jJtkUb7B+cN0k3EUOferLomKad/SyRDu51Wmrz4M/8AdJsFx
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41f91c84-2092-486c-893c-08d5853d9f8e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0529;
x-ms-traffictypediagnostic: AT5PR8401MB0529:
x-microsoft-antispam-prvs: <AT5PR8401MB052912C8F15CB6A56029D19682DF0@AT5PR8401MB0529.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AT5PR8401MB0529;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0529;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39380400002)(376002)(39860400002)(51914003)(189003)(53754006)(199004)(377424004)(103116003)(7736002)(5250100002)(2906002)(3660700001)(66066001)(305945005)(3280700002)(106356001)(59450400001)(5660300001)(39060400002)(478600001)(76176011)(2501003)(25786009)(6506007)(186003)(102836004)(68736007)(26005)(4326008)(7416002)(2900100001)(81166006)(54906003)(105586002)(86362001)(99286004)(36756003)(6436002)(8936002)(2201001)(6486002)(316002)(2950100002)(110136005)(14454004)(97736004)(3846002)(81156014)(8676002)(6246003)(6512007)(229853002)(6116002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0529;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: OdAgat2MhXy5VdK8JujrW+Zfirnwf8CVI4qqNqdx+Q4ghp2IrdwgPXEWYUdPk+LcuykKk37yxBvQXeg2NaFy/wra7nDCizAM6IdwsHBmB06ei60yirKpiBYYDkkS4yDqP5YdqJ2+Fm5Wi/NYfuVCsoJfJm0yDsW+kVGaVo54GKZaz9ZZAMPUj+bTSGPLb/nm/UtH0Wbc3uh0l4KM7cTHtEMT2ZYyU9xjCc3DyuV98C8XEtwnx5FRy13EQtg9KErg93uZY+c2vb+nueqW5oK8LRgmni3ZpDLKsqC2va9Q64eNc6RtzOaAYjV4ihw2dpw8wz0MUbmyHI7Im/OE+u4UoQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EBA0F41A309834582FD857C62A122CA@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f91c84-2092-486c-893c-08d5853d9f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 21:43:25.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0529
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28LhcC8027816

On Thu, 2018-03-08 at 14:34 -0600, Gratian Crisan wrote:
> Hi all,
> 
> We are seeing kernel page faults happening on module loads with certain
> drivers like the i915 video driver[1]. This was initially discovered on
> a 4.9 PREEMPT_RT kernel. It takes 5 days on average to reproduce using a
> simple reboot loop test. Looking at the code paths involved I believe
> the issue is still present in the latest vanilla kernel.
> 
> Some relevant points are:
> 
>   * x86_64 CPU: Intel Atom E3940
> 
>   * CONFIG_HUGETLBFS is not set (which also gates CONFIG_HUGETLB_PAGE)
> 
> Based on function traces I was able to gather the sequence of events is:
> 
>   1. Driver starts a ioremap operation for a region that is PMD_SIZE in
>   size (or PUD_SIZE).
> 
>   2. The ioremap() operation is preempted while it's in the middle of
>   setting up the page mappings:
>   ioremap_page_range->...->ioremap_pmd_range->pmd_set_huge <<preempted>>
> 
>   3. Unrelated tasks run. Traces also include some cross core scheduling
>   IPI calls.
> 
>   4. Driver resumes execution finishes the ioremap operation and tries to
>   access the newly mapped IO region. This triggers a vmalloc fault.
> 
>   5. The vmalloc_fault() function hits a kernel page fault when trying to
>   dereference a non-existent *pte_ref.
> 
> The reason this happens is the code paths called from ioremap_page_range()
> make different assumptions about when a large page (pud/pmd) mapping can be
> used versus the code paths in vmalloc_fault().
> 
> Using the PMD sized ioremap case as an example (the PUD case is similar):
> ioremap_pmd_range() calls ioremap_pmd_enabled() which is gated by
> CONFIG_HAVE_ARCH_HUGE_VMAP. On x86_64 this will return true unless the
> "nohugeiomap" kernel boot parameter is passed in.
> 
> On the other hand, in the rare case when a page fault happens in the
> ioremap'ed region, vmalloc_fault() calls the pmd_huge() function to check
> if a PMD page is marked huge or if it should go on and get a reference to
> the PTE. However pmd_huge() is conditionally compiled based on the user
> configured CONFIG_HUGETLB_PAGE selected by CONFIG_HUGETLBFS. If the
> CONFIG_HUGETLBFS option is not enabled pmd_huge() is always defined to be
> 0.
> 
> The end result is an OOPS in vmalloc_fault() when the non-existent pte_ref
> is dereferenced because the test for pmd_huge() failed.
> 
> Commit f4eafd8bcd52 ("x86/mm: Fix vmalloc_fault() to handle large pages
> properly") attempted to fix the mismatch between ioremap() and
> vmalloc_fault() with regards to huge page handling but it missed this use
> case.
> 
> I am working on a simpler reproducing case however so far I've been
> unsuccessful in re-creating the conditions that trigger the vmalloc fault
> in the first place. Adding explicit scheduling points in
> ioremap_pmd_range/pmd_set_huge doesn't seem to be sufficient. Ideas
> appreciated.
> 
> Any thoughts on what a correct fix would look like? Should the ioremap
> code paths respect the HUGETLBFS config or would it be better for the
> vmalloc fault code paths to match the tests used in ioremap and not rely
> on the HUGETLBFS option being enabled?

Thanks for the report and analysis!  I believe pud_large() and
pmd_large() should have been used here.  I will try to reproduce the
issue and verify the fix.

-Toshi
