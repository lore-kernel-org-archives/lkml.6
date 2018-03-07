Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934397AbeCGXCU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:02:20 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:47472 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934303AbeCGXCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:02:18 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Thread-Topic: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Thread-Index: AQHTtjxt4t52sdgOE0CgfWgnpWKg2aPFYiQAgAAOmYA=
Date: Wed, 7 Mar 2018 23:02:12 +0000
Message-ID: <1520466429.2693.43.camel@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
         <20180307183227.17983-2-toshi.kani@hpe.com>
         <20180307145454.d3df4bed6d6431c52bcf271e@linux-foundation.org>
In-Reply-To: <20180307145454.d3df4bed6d6431c52bcf271e@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1091;7:s1FqF8UZO1qrnnJFZ2mr72K2tzrylKHknoc/6F84B3pNvXcSawBz5gctmIti+GRLQtHkrJjIZzKe0oId42T8H4aIrecrTAojjpqXxVhNrY4eLn56oD1UGeI3RSRlMprvKREO3GFMEh/gOM8XK9wuXsU4sZx59mKsRAZ//hhVq/29PAK4VEAaGHlFNX0VCz2GggPa19JOCdDoejPlQU08dd6kDJXboMKwLFo5fFrZiuYondGZdnYS6Gf70JW7k/q5
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb81cf8a-9e93-4138-8ee8-08d5847f76c9
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1091;
x-ms-traffictypediagnostic: AT5PR8401MB1091:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB10918B8A3AD53BE85FE667BC82D80@AT5PR8401MB1091.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AT5PR8401MB1091;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1091;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(377424004)(189003)(199004)(8676002)(81166006)(5640700003)(2906002)(2900100001)(14454004)(5250100002)(36756003)(54906003)(53936002)(3280700002)(2501003)(106356001)(6246003)(2351001)(3660700001)(7416002)(103116003)(25786009)(6512007)(305945005)(5660300001)(7736002)(6116002)(1730700003)(4326008)(6486002)(81156014)(3846002)(66066001)(6436002)(8936002)(102836004)(316002)(6506007)(68736007)(6916009)(76176011)(2950100002)(186003)(26005)(478600001)(97736004)(86362001)(99286004)(59450400001)(229853002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1091;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Wez6cZMqUzdiogLdf2kdc5eUaZxYMjOgrsVCzfx7Re26OE540S1aUf4Lvxo6umbJn0TRnfow0AvYICXl/4zq3IwQgJZhfnQn8JWvIhR2s+pXMPpm5ex6VCDyNERwcnP/l/iNQ0RI7rApIfZqd4Kgp15u40JyUmlAOGfx67Ta+IiCzgx4MZLvwA547VEKtZO1gKTcJoZlDHJlPTUme3KSh0xsU0p5er7RvITgAcrfMV9dbRkM95Fy0MJT+HYSm/gvD0YO4RlpIISQATRixjPkWUOG6IpZwUL+QacjJ6aRjvHwEJYDQQEkJYwNArojK18Fn/gepHEvCBWkKvZh6n1Lzw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <485C8B4D88DC1740BFEF56BD935DAF5C@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb81cf8a-9e93-4138-8ee8-08d5847f76c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 23:02:13.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1091
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27N2Rjn008405

On Wed, 2018-03-07 at 14:54 -0800, Andrew Morton wrote:
> On Wed,  7 Mar 2018 11:32:26 -0700 Toshi Kani <toshi.kani@hpe.com> wrote:
> 
> > On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap()
> > may create pud/pmd mappings.  Kernel panic was observed on arm64
> > systems with Cortex-A75 in the following steps as described by
> > Hanjun Guo.
> > 
> > 1. ioremap a 4K size, valid page table will build,
> > 2. iounmap it, pte0 will set to 0;
> > 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
> >    then set the a new value for pmd;
> > 4. pte0 is leaked;
> > 5. CPU may meet exception because the old pmd is still in TLB,
> >    which will lead to kernel panic.
> > 
> > This panic is not reproducible on x86.  INVLPG, called from iounmap,
> > purges all levels of entries associated with purged address on x86.
> > x86 still has memory leak.
> > 
> > Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(),
> > which clear a given pud/pmd entry and free up a page for the lower
> > level entries.
> > 
> > This patch implements their stub functions on x86 and arm64, which
> > work as workaround.
> > 
> > index 004abf9ebf12..942f4fa341f1 100644
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -702,4 +702,24 @@ int pmd_clear_huge(pmd_t *pmd)
> >  
> >  	return 0;
> >  }
> > +
> > +/**
> > + * pud_free_pmd_page - clear pud entry and free pmd page
> > + *
> > + * Returns 1 on success and 0 on failure (pud not cleared).
> > + */
> > +int pud_free_pmd_page(pud_t *pud)
> > +{
> > +	return pud_none(*pud);
> > +}
> > +
> > +/**
> > + * pmd_free_pte_page - clear pmd entry and free pte page
> > + *
> > + * Returns 1 on success and 0 on failure (pmd not cleared).
> > + */
> > +int pmd_free_pte_page(pmd_t *pmd)
> > +{
> > +	return pmd_none(*pmd);
> > +}
> 
> Are these functions well named?  I mean, the comment says "clear pud
> entry and free pmd page" but the implementatin does neither of those
> things.  The name implies that the function frees a pmd_page but the
> callsites use the function as a way of querying state.

This patch 1/2 only implements stubs.  Patch 2/2 implements what is
described here.

> Also, as this fixes an arm64 kernel panic, should we be using
> cc:stable?

Right.

Thanks,
-Toshi
