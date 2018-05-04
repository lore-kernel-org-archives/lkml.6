Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeEDI1z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:27:55 -0400
Received: from mail-he1eur01on0108.outbound.protection.outlook.com ([104.47.0.108]:56756
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751059AbeEDI1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:27:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Fri, 4 May 2018 01:27:33 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mhocko@suse.com, linux-mm@kvack.org,
        mgorman@techsingularity.net, mingo@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, fengguang.wu@intel.com, dennisszhou@gmail.com
Subject: Re: [v2] mm: access to uninitialized struct page
Message-ID: <20180504082731.GA2782@outlook.office365.com>
References: <20180426202619.2768-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20180426202619.2768-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: MWHPR1301CA0001.namprd13.prod.outlook.com
 (2603:10b6:301:29::14) To AM6PR08MB3256.eurprd08.prod.outlook.com
 (2603:10a6:209:47::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3256;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;3:pBLsTN5+mfKJyOVeq7iJ/rajpGP35FKux0Chxl4MLYmdli6NcaqjQOYTCMip/LRzLdO2fq7JurlH0ggWZm85/zjJ4qKjW6PLIMFv3sIdNET1SCg7pinnxDQAEliyIw2x9ssn0QC1uWoFXtZPKBU/EbSHza2wjot+tZbrXLZ7TY3LLxi/VjZAfMHhtd0l/b1v4uacKES80pTiR3c0iReq/pk7kbdhVjcCea7HxptA4uev2vDgd3qwGN6oIcBTItNx;25:sdkKFStWDU1nLJ4kzWDIcTf7vYP0milbUKza9LtYfPcjblSvYlQ/CkUFGuZfoZw3XFlqSn+kCEPqaDdDfLre78WgnHJ8v9EFXlVptcaCMT+nZPm91JAbY4S/0FjDXjRwROa8mZ7ymnCUI6mkivbCPUOeVjD9QFrlemee/x7ktPupItqGkH1fmlt7XPRyzAN/cuKvrVZetygO/HpT04m65ZTXaJfOYPJNCt5IQLbBCoPzUxUROxW8DPmW+YkL6/ehY1CHAeYZvCLH1XDQ+Eh2xLjfaw+FIZTkbOw3TjnzqsAxqwaM7hzynSSjQZlmKRVAhfhx4RL1gyagf63SAVw9IQ==;31:tegCsESVCapFiB4MYQNTDnNZOE5tkjJTVzy+NDLKaAmjAqkKDhmLOkVym7CGQlz3c1CXjY8BIWkHKz17wJWyXZ+Lf86eNlcMwRtc6Ra9C3tiy7KvOLmmBRZlC6S0zvHceNW6/iCHBjkqu3YPkwXfSUkWxjIwZaEs/IX8v3s5C9fFMTvrvwT9lVwLY5A8+qSiHgBkt0t/VMuO7ZOk6R5vCiSb/Wlo/5Q1Fw/JHM/UYc0=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3256:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;20:bSI8eVuHYpbwcmupa9CIPgWtbseXNQx3C33z870hIqilSUyFmnN0XCyOBzaxzdVMulYQlCBiqKUpv04vcGoRe8fDfi6pT3ZOaMmndymYJX8yeEJwLXwbDrmQGMUPEPDRVIqL1nJHZpAmSfTLTQA/QuWhQY6uL/D3adhcerxhIVeMQzaUuVmWK5jrOWQpPgU976ndWzBLPGaHwsVoPZUanuLmd9qY5RK8I4l9QHefScbU38U4bycRMrYixgWctX/PnmOSoELK4h/RGiKIjhN5Pxsf9nUQlr/E/LqwFi8wsE8lWRUkbFjxRmfIi0jBlzoPCQhq9VPAMeCNoRkQgHCuyve+ZOsqP/gWSMAYM9hbHeeaf1uHhqP1BXBtKf1dfeQwuFBw7B/X6DXr3enLph3O5pwwXmaLaQw0Ln1cpt7DhxoA9+fMUV1Ed5mdjt/FejrRhTpVqprQvfTfHQLfPv3kVeBPElDfSRSosyikDp2Dqz00FPUav/ZXuGTxMegKvPeM;4:qH2W/iijSUpx7GS5uAMoyRoueZltWKbkV7CHp+4kT4VhAjUqVH35M7dQIdDSvUvkEaFjEYb6hrFSpD9sGZI5YIGFG0HGD41NZsAP4yjvbs+3YNDAGHJZRj3tMdyhh1voy4EYGD/+nytKaYrPHJ3A80Jr14l4658HxNsjarUIxldT7WF/pT/pE/hWV8Yva5bQN20spwJi0F5oGvbop6vohCFHB7KSdWaD3YHklEYIo8hGUHCSUlhwMtDRO121Wdbopz3L4F0Qq1loxVwVCw31tulELsK3Wx41e/vmPGEjdjVecDnNIF9Y62D+X2BRQC+tEwgIoh+94+sC+zRPSNkwy2SXEVYknWnbGKTblLbG6s9L/1vbtRAQD/h6Ao9oFyHZ
X-Microsoft-Antispam-PRVS: <AM6PR08MB3256A07D294B6F8A155FE357CF860@AM6PR08MB3256.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42068640409301)(146099531331640)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3256;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3256;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39850400004)(346002)(199004)(189003)(106356001)(86362001)(6916009)(23686003)(3846002)(486006)(7736002)(305945005)(68736007)(6116002)(55016002)(2906002)(575784001)(9686003)(6666003)(25786009)(1076002)(229853002)(33656002)(81156014)(81166006)(53416004)(8936002)(5660300001)(97736004)(6306002)(8676002)(105586002)(966005)(4326008)(39060400002)(7416002)(69596002)(59450400001)(47776003)(386003)(26005)(16586007)(316002)(58126008)(16526019)(476003)(186003)(6506007)(956004)(50466002)(11346002)(6246003)(446003)(66066001)(76176011)(7696005)(52116002)(478600001)(53936002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3256;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM6PR08MB3256;23:i0PjldjYYFwLXFKtdQfbGa90IaesE0wPBU/Q4759cwr?=
 =?koi8-r?Q?XK09BWIxGlek4Y/gKXRwPjwSXASID7iCz92XBNgehNhZZbqNKg23IXo8u4a5qp?=
 =?koi8-r?Q?+raGWDZ2i6Ffi7mcwmkzQCV2M7M68zXYAUv8CsMbfSNwlXa7IpE9R2FwEBODCH?=
 =?koi8-r?Q?uwzSy1FODKnB8UzK89Ou3HVIH+c/QYGUt3OdDk67VP+uaxUcbTUCYarYVKpvBa?=
 =?koi8-r?Q?tZ/dYsAVzAnN7SaPy7zHez+rCUPEwdhdQXTvI25F3qo45/CeNhAKUhz5QGeUKD?=
 =?koi8-r?Q?dcHMgSuUQ9SkdkufS0L+fRmwvzx/93apZUoeOfFPMHOi5kIRokBAij7EU4mKsZ?=
 =?koi8-r?Q?JwtCNcBW1wc/EsiKZkGZXaEtIB6DW0Tj3FN2MJFrx4DszXIb4PGBY8kUzLAHtP?=
 =?koi8-r?Q?WzzTr2Mg7NELziBZeZG6Ora7LcHf0Y9pI/GsYUrxKQpUbGn4nt/o3I6fjaul34?=
 =?koi8-r?Q?uQ0DrCosFRY1A9dULm3um98xCz9IbnTNf/z1jjeTuG2RxaaOAsvZE24yPsNTKV?=
 =?koi8-r?Q?Or/Ouz4r8pDsU58Co3QF59kdPdoNHq+gyPv1OdUo6jWWfar4XKPAcsV5Q4kAey?=
 =?koi8-r?Q?iIvT88GVnftbtu3SfqgGg/8XUhN0TXV9adAyYibSiEO/FhUhPCZDT5UhJgmJKW?=
 =?koi8-r?Q?GxFmXlnMXpBv7YscK/G/otPuhghfqNXS1icR0lIuuNgf1eZbsD7v8g4MO+loks?=
 =?koi8-r?Q?50QBXrbCKxncTmfMfbvOZeCJWnQdjEkqBx4bL5StNwOFd9rm6T0ylLYnDi7AJn?=
 =?koi8-r?Q?sUW69sbHmbMy++nSyAKNJPBBCm8N+4zy4Q5fELVHG6rYMVSu6x4jyhLzkyNaL7?=
 =?koi8-r?Q?SwR/RzQPTjCdLIiRphaW6Nzc9qrA5PwMrodm8Jd5Y5WkHuYonTHwO5abrh1mbJ?=
 =?koi8-r?Q?EB7jYQB3aNJJ/nLzyTmvtnMDnWoKGgKzxFUGS2cvOKqDZEgliH6nsgb1LR9NTu?=
 =?koi8-r?Q?5MFZ/Trh2LXGYmkHlX+AMyeZQq5+ESYj+jNJhYLKMqlgh+pqAY7f+hAxhRqcmn?=
 =?koi8-r?Q?q/pkZmYJ5AvIXBRcD7gB9rPjr6iBhWDO7MgARg+qlcgZ4Bw+VwsVke0RmcHw4b?=
 =?koi8-r?Q?I+rbi0LJ690ApVP9/BYqk2D7BrfKWTWUWTCE9ftWlggRPrSPEJJ9jVTMrkfwTw?=
 =?koi8-r?Q?O8GdoddRcc/Bv5HKosp822FhwNQuCEL+nELqIWk2gcPF8tzdo3c/ETCwTNpOig?=
 =?koi8-r?Q?dDs+rH9hJLLBTIplXMTCSQscTgIKLHiUpukjiG2/L72NbxQKNx0aWtua6fclZw?=
 =?koi8-r?Q?oO0uN0EPsd/EaGQz0aV2IbImpxw9bNofK3H/hs9VN2mO9kwLsl43QkvW1bIFQt?=
 =?koi8-r?Q?h4lh/l8yJIFCT+IOeUTt4PQo/7tOVnOYDMM2rGY7qgLkE5rv8CqoRp3DDP1d3P?=
 =?koi8-r?Q?48afPaciecQ9jwDqt8XoKGQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: rmN42LTOypNGVAxW3bhXNCdeTQMq02u0iy/VBaChKp4PWEhu37psOAnFM4T2KiFxNvBcJOSeQOJlWCyVRYOexk7EY3ZAUnToNGuI2mVRPyYz4nSASb9l/weCApA01M84W4luvtFXv0ReHHO5evjwXkTbZQLw8APY/yFcfEwqzV/RA4T+siGJP3hU+Au9ia/d
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;6:43vT2BXDLq5bsCMC2OHfEBrRHiNR6jB/V/zR+SbYH1ulweTRnR0gH7xJz2Hlqh7erG2PRAkLoSJicEQvWHZ45yHn0RwAjF9JYG0wy1UJnDhoLi8mKQJBAMXpG2lS42imGD/Xk2/S+fUU1VU7NJAj5SYZ/3MSqgZJ5iKBGd49fdoDD5qKZKPjcp3Eg5dCMrDpxfNYaRhWOeeou/C4VQpLdH3bv22DvvqT8ZPG5SSYxnC7KoaLcish3X2BMGeEuGAZ7GdBQl5Vaw7HCaeggU5N6qAybPx3SNj54jzeZXou2SMZkJi8Wxbx7nCypiq/qzdk3AfSn7x2W+GsOGwq2D1xHCXEjxLoem7R3jEeBqqF4n+pqtU6jYpevlfKGPDyjeNzRBrykguvw7TApeoALYm+TtuAV+uwvDi4jIiu+aENzGguMRldsY47baWxAyTDXcJkiHgAvkZASNx4XKVUAyx8Hw==;5:hbTQnwi6xdsTL4kFU2yZDthPQN5e4wrZ8by0dTMlpZgEdxi1P2m1tHY1uLF+23oXqkohe/KLjHbulKbIX3j1RnmTJkXxRBNIl50xexzGiJ2zTL6Sv46hEI8FAEQfQdt9IFs9M6UFzXHAIpH+ZloffbS3/N7q2G3zryUt0I84XAE=;24:w5wnAmL36y3lk3D0imQZjLFV/g2ukMxJKDlEcScCeC4cjGwMqC41o1Ar8UQfbwtTXV6xajPUaHFroM0Mej+k+91EexkV9xV7khBAXe7bM7g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3256;7:6HN556JiL1NXGeDigqhijbAWL/kNIkGrp8TEWgUydUEoVKd8g0D6Ua2oolVzHHh81EvwBmeMVm+K5wBajSzQkic1TvUH4N2weXQ55WBK5RVm98tqe9GQvFifrXiQE8yLBvALMcrvt2cwlEwAkd/mHViQ0jRBHnjUogv5QbWnFpRKfDGDtkIuZ+vIgrcUMHPjZFwmGgAil2Ihr+l7Mkx13wQubRzh+SGRLBoJPqJL+opdQT+uHEH9kFzFqfCRCJf/;20:vZzlDbwCaAQg/AtGRAwEzhWHV7FpGFEvMUsahP6IPjeXVVQ4a9XVfgalZL5lsQizecZTudfgt3kdxKGWpKMBIPYRFdxPvFcyzjdZNX7KJVgOZgnBoWASS8kAMiWjPPArO5dFsZiLEAMd13ooWch5Z9vCKOxslXO79rICLl6Sfzs=
X-MS-Office365-Filtering-Correlation-Id: c4a36823-20b9-4b21-f73e-08d5b198ec0f
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 08:27:46.9219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a36823-20b9-4b21-f73e-08d5b198ec0f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a robot which runs criu tests on linux-next kernels.

All tests passed on 4.17.0-rc3-next-20180502.

But the 4.17.0-rc3-next-20180504 kernel didn't boot.

git bisect points on this patch.

On Thu, Apr 26, 2018 at 04:26:19PM -0400, Pavel Tatashin wrote:
> The following two bugs were reported by Fengguang Wu:
> 
> kernel reboot-without-warning in early-boot stage, last printk:
> early console in setup code
> 
> http://lkml.kernel.org/r/20180418135300.inazvpxjxowogyge@wfg-t540p.sh.intel.com

The problem looks similar with this one.

[    5.596975] devtmpfs: mounted
[    5.855754] Freeing unused kernel memory: 1704K
[    5.858162] Write protecting the kernel read-only data: 18432k
[    5.860772] Freeing unused kernel memory: 2012K
[    5.861838] Freeing unused kernel memory: 160K
[    5.862572] rodata_test: all tests were successful
[    5.866857] random: fast init done
early console in setup code
[    0.000000] Linux version 4.17.0-rc3-00023-g7c4cc2d022a1
(avagin@laptop) (gcc version 8.0.1 20180324 (Red Hat 8.0.1-0.20) (GCC))
#13 SMP Fri May 4 01:10:51 PDT 2018
[    0.000000] Command line: root=/dev/vda2 ro debug
console=ttyS0,115200 LANG=en_US.UTF-8 slub_debug=FZP raid=noautodetect
selinux=0 earlyprintk=serial,ttyS0,115200
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds
registers'

$ git describe HEAD
v4.17-rc3-23-g7c4cc2d022a1

[avagin@laptop linux-next]$ git log --pretty=oneline  | head -n 1
7c4cc2d022a1fd56eb2ee555533b8666bc780f1e mm: access to uninitialized struct page


> 
> And, also:
> [per_cpu_ptr_to_phys] PANIC: early exception 0x0d
> IP 10:ffffffffa892f15f error 0 cr2 0xffff88001fbff000
> 
> http://lkml.kernel.org/r/20180419013128.iurzouiqxvcnpbvz@wfg-t540p.sh.intel.com
> 
> Both of the problems are due to accessing uninitialized struct page from
> trap_init(). We must first do mm_init() in order to initialize allocated
> struct pages, and than we can access fields of any struct page that belongs
> to memory that's been allocated.
> 
> Below is explanation of the root cause.
> 
> The issue arises in this stack:
> 
> start_kernel()
>  trap_init()
>   setup_cpu_entry_areas()
>    setup_cpu_entry_area(cpu)
>     get_cpu_gdt_paddr(cpu)
>      per_cpu_ptr_to_phys(addr)
>       pcpu_addr_to_page(addr)
>        virt_to_page(addr)
>         pfn_to_page(__pa(addr) >> PAGE_SHIFT)
> The returned "struct page" is sometimes uninitialized, and thus
> failing later when used. It turns out sometimes is because it depends
> on KASLR.
> 
> When boot is failing we have this when  pfn_to_page() is called:
> kasrl: 0x000000000d600000
>  addr: ffffffff83e0d000
>     pa: 1040d000
>    pfn: 1040d
> page: ffff88001f113340
> page->flags ffffffffffffffff <- Uninitialized!
> 
> When boot is successful:
> kaslr: 0x000000000a800000
>  addr: ffffffff83e0d000
>      pa: d60d000
>     pfn: d60d
>  page: ffff88001f05b340
> page->flags 280000000000 <- Initialized!
> 
> Here are physical addresses that BIOS provided to us:
> e820: BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x000000001ffdffff] usable
> BIOS-e820: [mem 0x000000001ffe0000-0x000000001fffffff] reserved
> BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> 
> In both cases, working and non-working the real physical address is
> the same:
> 
> pa - kasrl = 0x2E0D000
> 
> The only thing that is different is PFN.
> 
> We initialize struct pages in four places:
> 
> 1. Early in boot a small set of struct pages is initialized to fill
> the first section, and lower zones.
> 2. During mm_init() we initialize "struct pages" for all the memory
> that is allocated, i.e reserved in memblock.
> 3. Using on-demand logic when pages are allocated after mm_init call
> 4. After smp_init() when the rest free deferred pages are initialized.
> 
> The above path happens before deferred memory is initialized, and thus
> it must be covered either by 1, 2 or 3.
> 
> So, lets check what PFNs are initialized after (1).
> 
> memmap_init_zone() is called for pfn ranges:
> 1 - 1000, and 1000 - 1ffe0, but it quits after reaching pfn 0x10000,
> as it leaves the rest to be initialized as deferred pages.
> 
> In the working scenario pfn ended up being below 1000, but in the
> failing scenario it is above. Hence, we must initialize this page in
> (2). But trap_init() is called before mm_init().
> 
> The bug was introduced by "mm: initialize pages on demand during boot"
> because we lowered amount of pages that is initialized in the step
> (1). But, it still could happen, because the number of initialized
> pages was a guessing.
> 
> The current fix moves trap_init() to be called after mm_init, but as
> alternative, we could increase pgdat->static_init_pgcnt:
> In free_area_init_node we can increase:
>        pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
>                                         pgdat->node_spanned_pages);
> Instead of one PAGES_PER_SECTION, set several, so the text is
> covered for all KASLR offsets. But, this would still be guessing.
> Therefore, I prefer the current fix.
> 
> Fixes: c9e97a1997fb ("mm: initialize pages on demand during boot")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index b795aa341a3a..870f75581cea 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -585,8 +585,8 @@ asmlinkage __visible void __init start_kernel(void)
>  	setup_log_buf(0);
>  	vfs_caches_init_early();
>  	sort_main_extable();
> -	trap_init();
>  	mm_init();
> +	trap_init();
>  
>  	ftrace_init();
>  
