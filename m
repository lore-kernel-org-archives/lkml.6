Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935779AbeCHTa2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:30:28 -0500
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:34219 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeCHTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:30:26 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "will.deacon@arm.com" <will.deacon@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Thread-Topic: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Thread-Index: AQHTtjxt4t52sdgOE0CgfWgnpWKg2aPGo2qAgAAkdwA=
Date: Thu, 8 Mar 2018 19:30:23 +0000
Message-ID: <1520540118.2693.103.camel@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
         <20180307183227.17983-2-toshi.kani@hpe.com>
         <20180308180446.GF14918@arm.com>
In-Reply-To: <20180308180446.GF14918@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0818;6:9Nm5DoCNcRQQpch9KePnPeLSTR8afEmJ0DgKjhIaC7NVLPwS8iRF+Gk1W+mHuVT8tbg5+2QSFkX7LN+N4GW7F06ciq6bCYRszchXplIUhHfPdsg4gvpt5X2zpwDN4xPDYwyHTookeCRVRY8oqqwhOBs0MUeLGLj1Spo6SmC/BLKSUunrPerYz79TsVy+9c1kt2OekEs3gl3h+A94wHltMifZNQPK+mNnPSOyTroL2fQlGDOiiCvVGY9bthl2hZbWbPrIn27KYjxz6z4stK+peCNxH/ntidv2oS22MQQNquiV6y5QPiDyF0wKoP11TQfaW+lOfQVGSd9vxe32HmSX9JyCcfrUbfFI8zcL7W6+GV4Xp6C/OBc0924IdyIut0a8;5:4bD+PDZDpMqWoxNbEu9nTnyh+k7CJBmvKWmaedvMRHqWrSBT++Xj813pOHlxAaUucGAVXjMWHpq382ZAE/Ylfukj1bKka2JoUhN0/KLaPtVu0jpS3RZqEtPvGNhhL2Otj26nRR/L7kpthPuxKljW8XtN/KO/BRf/aGGWCNuHyYM=;24:/taPnARyYz3i4T1V84k8tNf0sGDyPP+pp2lCQW/7drD2AlNgSD1C0GaQqc2IadAGETcuazVMRvDsDSCnOrYSnMSRy1rOqGdWBH6xxgSY2CI=;7:U7fYobLUuMeRkJXBeKPGRGQZczkucUo15ruwzvvu15UMvinWHkYcGETkF+QfjhssmUc+rA/sbCUYql/qmcbFUqxjifLQKM5BhWjRSDgNzFfRvQLkeLIEg75T1fSwUadpQqMEAWenoiDDKcLCSzCcgYA9c8vzsF+MaiBsYXgW68x4SniFzOr9d0e+GeFZqI1G6tFOuQUd6tTiUNsJXYjN8mDER9Ic9VJM9KnlTvQ2INhGT3tUG6fen5ypsXrBssxu
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 40d7e1d1-4289-456c-68c8-08d5852b098b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0818;
x-ms-traffictypediagnostic: AT5PR8401MB0818:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB081837E617642C8BB49872AB82DF0@AT5PR8401MB0818.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AT5PR8401MB0818;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0818;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(39380400002)(376002)(366004)(377424004)(189003)(199004)(5250100002)(59450400001)(6506007)(97736004)(7416002)(68736007)(54906003)(229853002)(2900100001)(53936002)(6512007)(6246003)(478600001)(3280700002)(2906002)(14454004)(4326008)(36756003)(186003)(25786009)(305945005)(26005)(7736002)(5640700003)(86362001)(102836004)(5660300001)(2501003)(76176011)(99286004)(81156014)(8936002)(8676002)(6116002)(316002)(6486002)(3846002)(3660700001)(103116003)(81166006)(6436002)(2950100002)(105586002)(6916009)(2351001)(106356001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0818;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: yWYJ/9e+y0MlGxQA9WJHbh9mrtxvSgddT6B6P5ouOGtPvQ6h4UU+ZeHWfJMzRqQmmW9R0BNqdisfPLxNLgotsfhq3Itmn508HPe1GpVJBUj/n81mrbVl1txeL4rmxlRBwXKAZkYpmNxyQOXBI8TcrTyJqbRWD7jUBmymmBaUL9vgkp6KQ0JKE4wg3k4QCpjI3mV3w69jkjx4jtF9IwLs+7f6w47JCzNsfFZxQdnm4vmU4lK3rZoOe/vhKAO8FSAgBmLiiOE0NE7CoB96JuaX5uuvTqLNNBoZGE2f6H5QsfYGU3iv4NmlkuNyJYLQuB5FQb6s+eZBvYrD3gMCdmRsxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F44F0EB15826948A3A7A51792F1AC7A@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d7e1d1-4289-456c-68c8-08d5852b098b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 19:30:23.1671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0818
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28JUZAa001651

On Thu, 2018-03-08 at 18:04 +0000, Will Deacon wrote:
 :
> > diff --git a/lib/ioremap.c b/lib/ioremap.c
> > index b808a390e4c3..54e5bbaa3200 100644
> > --- a/lib/ioremap.c
> > +++ b/lib/ioremap.c
> > @@ -91,7 +91,8 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
> >  
> >  		if (ioremap_pmd_enabled() &&
> >  		    ((next - addr) == PMD_SIZE) &&
> > -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> > +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> > +		    pmd_free_pte_page(pmd)) {
> 
> I find it a bit weird that we're postponing this to the subsequent map. If
> we want to address the break-before-make issue that was causing a panic on
> arm64, then I think it would be better to do this on the unmap path to avoid
> duplicating TLB invalidation.

Hi Will,

Yes, I started looking into doing it the unmap path, but found the
following issues:

 - The iounmap() path is shared with vunmap().  Since vmap() only
supports pte mappings, making vunmap() to free pte pages is an overhead
for regular vmap users as they do not need pte pages freed up.
 - Checking to see if all entries in a pte page are cleared in the unmap
path is racy, and serializing this check is expensive.
 - The unmap path calls free_vmap_area_noflush() to do lazy TLB purges.
Clearing a pud/pmd entry before the lazy TLB purges needs extra TLB
purge.

Hence, I decided to postpone and do it in the ioremap path when a
pud/pmd mapping is set.  The "break" on arm64 happens when you update a
pmd entry without purging it.  So, the unmap path is not broken.  I
understand that arm64 may need extra TLB purge in pmd_free_pte_page(),
but it limits this overhead only when it sets up a pud/pmd mapping.

Thanks,
-Toshi
