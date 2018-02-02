Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeBBIRR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 03:17:17 -0500
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:28000
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbeBBIRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 03:17:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Fri, 2 Feb 2018 11:16:50 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>, Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>, Chris Metcalf <cmetcalf@ezchip.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Florian Weimer <fweimer@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan_Lynch@mentor.com,
        Prasun.Kapoor@caviumnetworks.com,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Alexander Graf <agraf@suse.de>, Mark Brown <broonie@kernel.org>,
        christoph.muellner@theobroma-systems.com, davem@davemloft.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexey Klimov <klimov.linux@gmail.com>, linyongting@huawei.com,
        manuel.montezelo@gmail.com, philipp.tomsich@theobroma-systems.com,
        schwidefsky@de.ibm.com, szabolcs.nagy@arm.com,
        zhouchengming1@huawei.com
Subject: Re: [PATCH v8 00/20] ILP32 for ARM64
Message-ID: <20180202081650.k3lrxravxicorfyo@yury-thinkpad>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [42.106.228.158]
X-ClientProxiedBy: VI1PR0701CA0032.eurprd07.prod.outlook.com (10.173.77.18) To
 CY4PR07MB2902.namprd07.prod.outlook.com (10.169.252.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a054ad62-1674-416e-6bc6-08d56a155798
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR07MB2902;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2902;3:6unnBLR23crlGCyjUfShL1tRt74K0tN8aJ+cU39qJs5dhoYaq9fbEpEtUBR1vbHrpW22/tOi5+/heFfkf+j1TBApoGmwqHNggaLSLlLEpuFb+netm5ksXlcjphCZaWsEjeTzeBKqNk1M7uM+aQfRYWMUlx0yU/ODkJKc+7QI30pfqSekYCAgJnPI5aWyEltK2XXDganib1fE4rZtmg/n5ROqy8g/gfw6noc4NPgMp7WYKpcjIcd6zGfTmFPDcxuU;25:V+uBdxB3bawmx3FHif4KvYo/m2w8QCdq3eIEK3rZYjUIvomK1BOgSgKRryReF0925wFeHd2CRv9NwiKaXAxgTJ9mq2jCfAA1v1jGdVYsqBynmexxGlPedBurm/Te69wBa/C6fgw8qjXWryxPaDU+58/iIO/VgL0vwlj4wRi72baBtU7L6p6N11fplBYKbLZJa0q1+QIJui8a/wPm8/JYsN7k6ZvJcv8ix+NSS9xCDuUbp2/IdjV+r0OYR3eSGBbBu/t6t5rd9fvHMxBD+krAeGS9OlxR9X4DUUfSd0ZkFL4+MgzjC90l1zvGWhSYBTKsDC08hm7E2SZsCWq58YTgIQ==;31:eZ/vOFYpXjvbM0yGbYf9VOkARBpngW+dWhm/JHhf9KGIqaVSs1a3Ci5Ou4ER0QrayHCCzdB6HdSXbD0JrBltTsSKPWYNLYPw/WXPpwv+gMrH/EZmcoa7gB8lAGZTb8+71AerTqc4YhPEZYW6FtL+9poo2leVqwSQu/oa+PCwnUX/kScajMWl7h789KtwtEU3Yd7uo0Viy1YUwEV7Y3As88E4kQmEY6VIIoYj1wgGe54=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2902:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2902;20:JHlNU8HN4fkAWY96lwwzjAtEINJ3JjiefLQPggttiDxVYlBKW8XHkBQXAfCjz/FNmEoofBucBHgXNUrElT9tdJeUQd/GRhSXVx1XavmoXrz2Lhbwyq+k7yL5A+AeB3QNMuDXnSk+GG1e/LRvUQiiljxad/dKO97YGcZACJSkwVc2nHganb9g7Y97HrVVsBNnkUv2+Dmbtgkvk8a80c6G6yxyzgON1Grt0K4t8iLMrWyeJiYViFMG/JTetGonB9YVY9pwZJk9fiS0Wamy7eyVD6hxtf0xRlFmdpqaRgwwmF6vSaGtcNKV+XeeAFl0l2L7BLgzV9cTm0eqIiliwdAx/hUFIsVen30b5Qjc0TH5TxaXZhMrXzBfPYTCacuGNzWQR/EifYo6gSSR4YZpv2S3D5DoKkqPHUN8+fFDqi427azSvxfL1b4ntHmiqhPM6Fd2vmaUWo8sknSY7u/W4zcGr2jiIY4mhIjxEtkzh9Ic04dkrrhFngK6N+h/STgC8E3pSY9x3eCImyZRrALomHG8aDpd2GJ1sDgyLjrLoeEMl2mqPwiyqgh2ifhxbQjPgWY82QzW8Sb/CPOG0Q2vVswDlOyUNfX24gRGmYGX2PbDaic=;4:wPdv9gouRGxhPMFNJ9tYuT9qjgRV2h8HefL/0zt7U5hVdT5ZGhqPd+vEHu9F5CCoJZAZbY/TgmID8WEWX+X8fAQOJXQiabpD6mZx+i+HK19gO96FwDdjImwRZRRWjRc7+V+sal0XxJi1uyHjDy0KoUGVFMWznQOTGtx7nG88eljDiEnizLUu3Y1d82zOm1IDuML03ZMnGKGP8201LY6IbIp2zIxVf8L34dwwJhVarMprRyQcWhhIAmxG8BYSzVnWa+sapLwvnG+b7WTD/gIwdXBhenethJQQqR0DpjRRE4e9nxq0CmfHb4BgsqNMXFUO
X-Microsoft-Antispam-PRVS: <CY4PR07MB2902EC7AD7F124A70A2C9527E3F90@CY4PR07MB2902.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6041288)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR07MB2902;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2902;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(366004)(376002)(396003)(346002)(39860400002)(39380400002)(189003)(199004)(25786009)(76176011)(5660300001)(47776003)(39060400002)(229853002)(478600001)(52116002)(6116002)(97736004)(6496006)(23726003)(3846002)(7416002)(7406005)(105586002)(106356001)(110136005)(16586007)(966005)(58126008)(4326008)(386003)(316002)(33896004)(83506002)(1076002)(6486002)(7736002)(6666003)(33716001)(6246003)(66066001)(42882006)(54906003)(2950100002)(59450400001)(72206003)(76506005)(305945005)(2906002)(50466002)(8936002)(8676002)(81166006)(81156014)(9686003)(16526019)(186003)(5009440100003)(26005)(68736007)(6306002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2902;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2902;23:zwi4ZS0zilfv78GfPLAOTAqyvgxk4SCWAGXKMZfTU?=
 =?us-ascii?Q?WWR2NKODQ2ah9dk/jCon9hM0Zs7XPlP0/bidKrP1hgxMnbrfsV1KitRt9zep?=
 =?us-ascii?Q?ikY1MW4//msxGdzc2zDyUY3Nn/LjpZ1CY92p4Vv7EQ39iGW+icsids+CGx2g?=
 =?us-ascii?Q?ZiWdXyHh5vPy0uIDhcqGaDb0HFH078s/PjJarm7xhpcXy6IMbqvTa5bSQxKm?=
 =?us-ascii?Q?uFnrk4G4okrTxArYs/LKFuyaX5b1N9OqlN+whadqnJhZlEw2DGUPSEb0h9v9?=
 =?us-ascii?Q?31AGmWwQxHgkkFXUCnRTeIReAExekJqdHvJdlXA2CgNc19VFMlXTZClmFdmR?=
 =?us-ascii?Q?58JJmC9JZ0myxdQ4+uYyDxPY9UVwy4lc2W6CTCsY5mZDtkZkuTSltwzh2JE4?=
 =?us-ascii?Q?HGGmlJWK0AhGKoKGzY6xKBvvTt9NEf7zW7dpJZ/V6vplhLDqTJO2NkUK6yjW?=
 =?us-ascii?Q?874SB6Ta6ScDwa/dPqcTSrHbmKsGnTIkxxRRzFdP09CRZkTsNqCQ/1paCpfy?=
 =?us-ascii?Q?5MlO0KkJlMKJkLeRkAcyMPgaqzNC1HnryRB1KKRxwg+Pao80jKUbn07g07A+?=
 =?us-ascii?Q?ic1DQySLg7sBDILhljsmHvGZ8dS0ppiWNGgZMUMWUsLquxKAT+y31PNY7evw?=
 =?us-ascii?Q?T9fLFOEFgMjeQ8HgBWq4Ifd9qOflJwiQe6RaR4RfwGL5FKDYoH73wfAP6rF9?=
 =?us-ascii?Q?seoHsWpaNiAp8QV/fE0i0Kj5QFIm7W7lFoLBRsS0avOlpbyNsICx2lhZPRti?=
 =?us-ascii?Q?5WDH3akP7oqvozdVipoYdl7AqUJAzwXYB7cjSjssnhlp+22cGU14ZLSZkU0F?=
 =?us-ascii?Q?fEXMSW4VE8IdVPITRAOt9a5kukQwE2OJkQbRAbEynaufmgffC+MrJ9fmiRP0?=
 =?us-ascii?Q?CrPQO8eVQxRGluNC6VVGJ3D3w+CUnekD+gNxhoqKq2zVps2k08vFAS09E+3p?=
 =?us-ascii?Q?XAQ5IaFAXuvCjyQmQKzmwBI7pgFWR9Cn7vCiJVYt9+W7UDsZpAt9nCOZ9viP?=
 =?us-ascii?Q?X/nGbmM2MhHtJK1cjEgQw3pVsTruoDRDLGgm+76IrCgCjEIzE6PULBtkHJVs?=
 =?us-ascii?Q?BlZflOWmEIn6kYIdNJOD5CkJBh1JPdxvKZqCotO16Pu0EsoapgitLYl84ZnS?=
 =?us-ascii?Q?TJZESZXIR1dKpGtK/yK5YH1fqgXeGBaLKV6ntetVOH9A2Pg7ySuJwmyBfYxg?=
 =?us-ascii?Q?sIaj/wJCJxWy5NIkAaun3u5tOnyhfMrVsnWxEvm/1kt7xvRRv59lx8Q/IB3q?=
 =?us-ascii?Q?7TfDBLaX+r/xJfn/lGuEcwK1KC1H0kxlh1i+E/7K+znkZhDk0GHwEEiz03EZ?=
 =?us-ascii?Q?e6cPBXB4FkERDkQuAha08NMY8yx+aEWmMtVdJjnUzm9A81rKZEUCsGbVGqT/?=
 =?us-ascii?Q?VeDBP0P3RdG8qwNFQqZ99HLkOw3Q8kMPpXTLUVJxHw+rjo+osxG2+THrQah3?=
 =?us-ascii?Q?93e/Y5b3Y/UcT9+dZHcuMyOjNPG2XU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2902;6:GNwf2+l8YvO/zLYUt1264LUbWyMZw6kafFJ4fr+iTuxd2/D1R1N4ZY4/D1Vn0QN9jtTAkGek9S7Df4cQGH46JQ8YJ0bXpmCW9EsOG4GGcBcESZ6TQtgfdXa36m5Ov5Vt5c52rNGTv1Pj+BY0nlI0fXus8zYCdsbbkU5ngrCv2LLUSUchDAwK+TZqTDGfDAN9T6CByiooJy8kaSyCpRh/O0TE+b90x0da1vqAkb3tPGFCTQhhjHTfW97eIn+qUd/kxqi9wi0+jl6mtIidddEM/l13pkDrRoNbh0tGGpqm+Za8DLhmsP4Z8Uyj2wKWy4HpKfqHznkkmgVv+fIfNSq8azclsktcg8fWhZSLzS2UBD4=;5:1VLXLr/3gNsGwIt3nxfYIiu+th6DsQPIzcGitHnt94BGXthT+hAbakz5bFwDq30IckRGnEuv6WK/To5jP/Igra3OC+tyB3+CNbcZqW8+b2gZdE7U6qhgTZzSsbKNR7qcIKBke4OSPWcjH9AbKVvCP4n5vKCotSi0+/PhtzgEvVU=;24:YAm+22fv70iJsSsHz0/gRfzGuSZA22Q/PR/B8u0/99ZSAi63JfXbe+ORZB0DU2rd8S6CMpTVKHoz8TyhsCHsL3+EbDiyKlSKHsp9h/8H5H8=;7:Qil5d7BAIJVcqn1bLTwdSDvembPStwoE0livfiAex/EwUGFzmZDoXCD6ClY6y2igcJceXBS7cz/71SrtvbygYV/CdNTwsC5ulKH4Z93kh63ymc3VW7sl2vENARI5SHZ9d0MTeuy3geioTQhNWQrSfLTOG5HBtn5SwKYNWQak+frJVVGXcktYLILG95UN9U1IgELiy5sZdAxRwnFyGqKc4sBcHRRrahFDBoGpHUQOD3yM/oaikDl1djs01CvuvRb0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 08:17:03.1288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a054ad62-1674-416e-6bc6-08d56a155798
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2902
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin, all

(Exclude Bamvor as his email became invalid)

This is 4.15-based kernel.
https://github.com/norov/linux/commits/ilp32-4.15

I tested it with LTP, no regressions found.

Kernel v4.15 incorporates SVE series from Dave Martin, so I updated ILP32
patches to agree with it. SVE-related changes are mostly in patches:
arm64: ilp32: introduce ilp32-specific handlers for sigframe and ucontext
arm64: signal32: move ilp32 and aarch32 common code to separated file
arm64: signal: share lp64 signal structures and routines to ilp32
arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it

Dave kindly reviewed that patches and proposed improvements:
https://www.spinics.net/lists/arm-kernel/msg629221.html

There's no ABI-related changes proposed, or urgent fixes; so I'll rework
signal subsystem during 4.16 cycle.

Are there any news with upstreaming this series?

Thanks,
Yury

On Mon, Jun 19, 2017 at 06:49:43PM +0300, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> This version is based on linux-next from 2017-06-16. It works with
> glibc-2.25, and tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> Patches 1, 2, 3 and 8 are general, and may be applied separately.
> 
> Kernel, GLIBC and OpenSUSE-based distro:
> https://github.com/norov/linux/tree/ilp32-20170616.0
> https://github.com/norov/glibc/tree/dev9
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> (GLIBC patches are managed by Steve Ellcey, so my tree is only for
> reference.)
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: - off_t referred in patches 2 and 13 stands for userspace type which is
>       underlined in corresponding patch comments and ARCH_32BIT_OFF_T config
>       option description;
>     - __IGNORE_getrlimit and __IGNORE_setrlimit are added to
>       scripts/checksyscalls.sh (patch 3);
>     - for CONFIG_COMPAT, bool changed to def_bool y and 'select COMPAT' is
>       dropped for AARCH32_EL0 and ARM64_ILP32 optiond (patches 5 and 20);
>     - x19 register is used to load TSK_TI_FLAGS in svc path in
>       arch/arm64/kernel/entry.S to avoid register clobbering (patch 14).
>     - ilp32 vdso-related files are syncronized wirh lp64 ones, mostly Makefiles
>       (patch 19);
>     - in arch/arm64/mm/mmap.c, arch_mmap_rnd() swithed to use is_compat_task()
>       (patch 9);
>     - rebased on next-20170616.
> 
> Andrew Pinski (6):
>   arm64: rename COMPAT to AARCH32_EL0 in Kconfig
>   arm64: ensure the kernel is compiled for LP64
>   arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
>   arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
>     it
>   arm64: ilp32: introduce ilp32-specific handlers for sigframe and
>     ucontext
>   arm64:ilp32: add ARM64_ILP32 to Kconfig
> 
> Philipp Tomsich (1):
>   arm64:ilp32: add vdso-ilp32 and use for signal return
> 
> Yury Norov (13):
>   compat ABI: use non-compat openat and open_by_handle_at variants
>   32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
>   asm-generic: Drop getrlimit and setrlimit syscalls from default list
>   arm64: ilp32: add documentation on the ILP32 ABI for ARM64
>   thread: move thread bits accessors to separated file
>   arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
>   arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
>   arm64: introduce binfmt_elf32.c
>   arm64: ilp32: introduce binfmt_ilp32.c
>   arm64: ilp32: share aarch32 syscall handlers
>   arm64: signal: share lp64 signal routines to ilp32
>   arm64: signal32: move ilp32 and aarch32 common code to separated file
>   arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
> 
>  Documentation/arm64/ilp32.txt                 |  45 +++++++
>  arch/Kconfig                                  |  15 +++
>  arch/arc/Kconfig                              |   1 +
>  arch/arc/include/uapi/asm/unistd.h            |   1 +
>  arch/arm/Kconfig                              |   1 +
>  arch/arm64/Kconfig                            |  17 ++-
>  arch/arm64/Makefile                           |   8 ++
>  arch/arm64/include/asm/compat.h               |  19 +--
>  arch/arm64/include/asm/elf.h                  |  40 ++----
>  arch/arm64/include/asm/fpsimd.h               |   2 +-
>  arch/arm64/include/asm/ftrace.h               |   2 +-
>  arch/arm64/include/asm/hwcap.h                |   6 +-
>  arch/arm64/include/asm/is_compat.h            |  90 ++++++++++++++
>  arch/arm64/include/asm/memory.h               |   5 +-
>  arch/arm64/include/asm/processor.h            |  11 +-
>  arch/arm64/include/asm/ptrace.h               |   2 +-
>  arch/arm64/include/asm/seccomp.h              |   2 +-
>  arch/arm64/include/asm/signal32.h             |   9 +-
>  arch/arm64/include/asm/signal32_common.h      |  27 ++++
>  arch/arm64/include/asm/signal_common.h        |  33 +++++
>  arch/arm64/include/asm/signal_ilp32.h         |  38 ++++++
>  arch/arm64/include/asm/syscall.h              |   2 +-
>  arch/arm64/include/asm/thread_info.h          |   4 +-
>  arch/arm64/include/asm/unistd.h               |   6 +-
>  arch/arm64/include/asm/vdso.h                 |   6 +
>  arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
>  arch/arm64/include/uapi/asm/unistd.h          |  13 ++
>  arch/arm64/kernel/Makefile                    |   8 +-
>  arch/arm64/kernel/asm-offsets.c               |   9 +-
>  arch/arm64/kernel/binfmt_elf32.c              |  37 ++++++
>  arch/arm64/kernel/binfmt_ilp32.c              |  85 +++++++++++++
>  arch/arm64/kernel/cpufeature.c                |   8 +-
>  arch/arm64/kernel/cpuinfo.c                   |   8 +-
>  arch/arm64/kernel/entry.S                     |  34 +++++-
>  arch/arm64/kernel/entry32.S                   |  80 ------------
>  arch/arm64/kernel/entry32_common.S            | 107 ++++++++++++++++
>  arch/arm64/kernel/entry_ilp32.S               |  22 ++++
>  arch/arm64/kernel/head.S                      |   2 +-
>  arch/arm64/kernel/hw_breakpoint.c             |   8 +-
>  arch/arm64/kernel/perf_regs.c                 |   2 +-
>  arch/arm64/kernel/process.c                   |   7 +-
>  arch/arm64/kernel/ptrace.c                    |  80 ++++++++++--
>  arch/arm64/kernel/signal.c                    | 102 ++++++++++------
>  arch/arm64/kernel/signal32.c                  | 107 ----------------
>  arch/arm64/kernel/signal32_common.c           | 135 ++++++++++++++++++++
>  arch/arm64/kernel/signal_ilp32.c              | 170 ++++++++++++++++++++++++++
>  arch/arm64/kernel/sys_ilp32.c                 | 100 +++++++++++++++
>  arch/arm64/kernel/traps.c                     |   5 +-
>  arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
>  arch/arm64/kernel/vdso-ilp32/Makefile         |  80 ++++++++++++
>  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 +++++
>  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 ++++++++++++++
>  arch/arm64/kernel/vdso.c                      |  63 ++++++++--
>  arch/arm64/kernel/vdso/gettimeofday.S         |  20 ++-
>  arch/arm64/kernel/vdso/vdso.S                 |   6 +-
>  arch/arm64/mm/mmap.c                          |   2 +-
>  arch/blackfin/Kconfig                         |   1 +
>  arch/c6x/include/uapi/asm/unistd.h            |   1 +
>  arch/cris/Kconfig                             |   1 +
>  arch/frv/Kconfig                              |   1 +
>  arch/h8300/Kconfig                            |   1 +
>  arch/h8300/include/uapi/asm/unistd.h          |   1 +
>  arch/hexagon/Kconfig                          |   1 +
>  arch/hexagon/include/uapi/asm/unistd.h        |   1 +
>  arch/m32r/Kconfig                             |   1 +
>  arch/m68k/Kconfig                             |   1 +
>  arch/metag/Kconfig                            |   1 +
>  arch/metag/include/uapi/asm/unistd.h          |   1 +
>  arch/microblaze/Kconfig                       |   1 +
>  arch/mips/Kconfig                             |   1 +
>  arch/mn10300/Kconfig                          |   1 +
>  arch/nios2/Kconfig                            |   1 +
>  arch/nios2/include/uapi/asm/unistd.h          |   1 +
>  arch/openrisc/Kconfig                         |   1 +
>  arch/openrisc/include/uapi/asm/unistd.h       |   1 +
>  arch/parisc/Kconfig                           |   1 +
>  arch/powerpc/Kconfig                          |   1 +
>  arch/score/Kconfig                            |   1 +
>  arch/score/include/uapi/asm/unistd.h          |   1 +
>  arch/sh/Kconfig                               |   1 +
>  arch/sparc/Kconfig                            |   1 +
>  arch/tile/Kconfig                             |   1 +
>  arch/tile/include/uapi/asm/unistd.h           |   1 +
>  arch/tile/kernel/compat.c                     |   3 +
>  arch/unicore32/Kconfig                        |   1 +
>  arch/unicore32/include/uapi/asm/unistd.h      |   1 +
>  arch/x86/Kconfig                              |   1 +
>  arch/x86/um/Kconfig                           |   1 +
>  arch/xtensa/Kconfig                           |   1 +
>  drivers/clocksource/arm_arch_timer.c          |   2 +-
>  include/linux/fcntl.h                         |   2 +-
>  include/linux/thread_bits.h                   |  63 ++++++++++
>  include/linux/thread_info.h                   |  65 ++--------
>  include/uapi/asm-generic/unistd.h             |  10 +-
>  scripts/checksyscalls.sh                      |   5 +
>  95 files changed, 1606 insertions(+), 407 deletions(-)
>  create mode 100644 Documentation/arm64/ilp32.txt
>  create mode 100644 arch/arm64/include/asm/is_compat.h
>  create mode 100644 arch/arm64/include/asm/signal32_common.h
>  create mode 100644 arch/arm64/include/asm/signal_common.h
>  create mode 100644 arch/arm64/include/asm/signal_ilp32.h
>  create mode 100644 arch/arm64/kernel/binfmt_elf32.c
>  create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
>  create mode 100644 arch/arm64/kernel/entry32_common.S
>  create mode 100644 arch/arm64/kernel/entry_ilp32.S
>  create mode 100644 arch/arm64/kernel/signal32_common.c
>  create mode 100644 arch/arm64/kernel/signal_ilp32.c
>  create mode 100644 arch/arm64/kernel/sys_ilp32.c
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
>  create mode 100644 include/linux/thread_bits.h
> 
> -- 
> 2.11.0
