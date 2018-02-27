Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeB0Ttt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 14:49:49 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:23571 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeB0Ttr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 14:49:47 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "will.deacon@arm.com" <will.deacon@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <mhocko@suse.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Subject: =?utf-8?B?UmU6IOetlOWkjTogW1JGQyBwYXRjaF0gaW9yZW1hcDogZG9uJ3Qgc2V0IHVw?=
 =?utf-8?Q?_huge_I/O_mappings_when_p4d/pud/pmd_is_zero?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUkZDIHBhdGNoXSBpb3JlbWFwOiBkb24ndCBzZXQgdXAgaHVn?=
 =?utf-8?Q?e_I/O_mappings_when_p4d/pud/pmd_is_zero?=
Thread-Index: AQHTf8/DU6Bn0QH47UWdTrAB037o0qOtWaOAgAEK4wCAAGk/AIAASQkAgAfKtwCAAAH3AIAAHm+AgAITRAA=
Date: Tue, 27 Feb 2018 19:49:42 +0000
Message-ID: <1519763686.2693.2.camel@hpe.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
         <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
         <1519175992.16384.121.camel@hpe.com>
         <etPan.5a8d2180.1dbfd272.49b8@localhost> <20180221115758.GA7614@arm.com>
         <32c9b1c3-086b-ba54-f9e9-aefa50066730@huawei.com>
         <20180226110422.GD8736@arm.com>
         <a80e540f-f3bd-53da-185d-7fffe801f10c@huawei.com>
In-Reply-To: <a80e540f-f3bd-53da-185d-7fffe801f10c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0435;7:f4T1nheyJbXqygqTntZ6UZFTIXxN24crjyWD9BJCnZh2H5m53rlr2h14qqAHzBB3iQAhf1LzRcBK3691t1B4E6yrkhrwimiH46tpz9MY7QynyXxYSUKMrT+943IbAG29Iirxs3zeVDcAXliXJIOSOxsq9Us3YMzuMClkgB9pz8hEknDrTBK8tHxUZfC+9p1+ukznDzxUfRI1L/D7sm1tiaw0tADIQr4ije8KvMs5WkhswlJC8hreJNWnWSJfTajd
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd263d1f-ce77-4059-3b6f-08d57e1b3f0d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AT5PR8401MB0435;
x-ms-traffictypediagnostic: AT5PR8401MB0435:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0435061C142ED364FF7EE13282C00@AT5PR8401MB0435.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501161)(52105095)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:AT5PR8401MB0435;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0435;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(396003)(376002)(346002)(189003)(199004)(52314003)(55674003)(377424004)(102836004)(14454004)(6506007)(2900100001)(86362001)(53546011)(575784001)(93886005)(99286004)(59450400001)(6246003)(4326008)(97736004)(26005)(478600001)(5250100002)(53936002)(105586002)(3846002)(3280700002)(68736007)(2906002)(7736002)(2501003)(6116002)(305945005)(966005)(186003)(54906003)(76176011)(7416002)(25786009)(316002)(8936002)(103116003)(6512007)(106356001)(6306002)(6436002)(36756003)(3660700001)(81166006)(66066001)(6486002)(224303003)(5660300001)(110136005)(229853002)(2950100002)(81156014)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0435;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: n570DIM+WWA7mKyQ+kekq8DOHniEBfzDmhc9Qu/+4+pjEeFELyxu34UWBfz6V3txZBeSc/SZeAM2JRavt46iTBJSuyRuQ8wPfYqqCnFbvuSb6NotFnaV2JEQPAwdwwsbq7XQMNvKPzxbBH0suicOfsSHDvaqJ8aB2ojXaEFr9gc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <29A967BA55147B45AC689AF729FCB186@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cd263d1f-ce77-4059-3b6f-08d57e1b3f0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 19:49:42.9373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0435
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RJnshv026087

On Mon, 2018-02-26 at 20:53 +0800, Hanjun Guo wrote:
> On 2018/2/26 19:04, Will Deacon wrote:
> > On Mon, Feb 26, 2018 at 06:57:20PM +0800, Hanjun Guo wrote:
> > > On 2018/2/21 19:57, Will Deacon wrote:
> > > > [sorry, trying to deal with top-posting here]
> > > > 
> > > > On Wed, Feb 21, 2018 at 07:36:34AM +0000, Wangxuefeng (E) wrote:
> > > > >      The old flow of reuse the 4k page as 2M page does not follow the BBM flow
> > > > > for page table reconstruction，not only the memory leak problems.  If BBM flow
> > > > > is not followed，the speculative prefetch of tlb will made false tlb entries
> > > > > cached in MMU, the false address will be got， panic will happen.
> > > > 
> > > > If I understand Toshi's suggestion correctly, he's saying that the PMD can
> > > > be cleared when unmapping the last PTE (like try_to_free_pte_page). In this
> > > > case, there's no issue with the TLB because this is exactly BBM -- the PMD
> > > > is cleared and TLB invalidation is issued before the PTE table is freed. A
> > > > subsequent 2M map request will see an empty PMD and put down a block
> > > > mapping.
> > > > 
> > > > The downside is that freeing becomes more expensive as the last level table
> > > > becomes more sparsely populated and you need to ensure you don't have any
> > > > concurrent maps going on for the same table when you're unmapping. I also
> > > > can't see a neat way to fit this into the current vunmap code. Perhaps we
> > > > need an iounmap_page_range.
> > > > 
> > > > In the meantime, the code in lib/ioremap.c looks totally broken so I think
> > > > we should deselect CONFIG_HAVE_ARCH_HUGE_VMAP on arm64 until it's fixed.
> > > 
> > > Simply do something below at now (before the broken code is fixed)?
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index b2b95f7..a86148c 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -84,7 +84,6 @@ config ARM64
> > >         select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> > >         select HAVE_ARCH_AUDITSYSCALL
> > >         select HAVE_ARCH_BITREVERSE
> > > -   select HAVE_ARCH_HUGE_VMAP
> > >         select HAVE_ARCH_JUMP_LABEL
> > >         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> > >         select HAVE_ARCH_KGDB
> > 
> > No, that actually breaks with the use of block mappings for the kernel
> > text. Anyway, see:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15122ee2c515a253b0c66a3e618bc7ebe35105eb
> 
> Sorry, just back from holidays and didn't catch up with all the emails,
> thanks for taking care of this.

I will work on a fix for the common/x86 code.

Thanks,
-Toshi
