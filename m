Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeCHX1i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:27:38 -0500
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:33051 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeCHX1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:27:37 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Thread-Topic: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Thread-Index: AQHTtjxt4t52sdgOE0CgfWgnpWKg2aPFt3UAgADUqoCAAFsBAIAAIuoA
Date: Thu, 8 Mar 2018 23:27:10 +0000
Message-ID: <1520554326.2693.122.camel@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
         <20180307183227.17983-2-toshi.kani@hpe.com>
         <20180308040016.GB9082@bombadil.infradead.org>
         <1520527285.2693.56.camel@hpe.com>
         <20180308220708.GA29073@bombadil.infradead.org>
In-Reply-To: <20180308220708.GA29073@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0898;7:l7wg153hUj5K9a2GJkwMGSaxCQ8Wt3XBniUTpe/ICBxyvS6bb5Vwl4NF1Nd6sIKqKkf9oIDvwpZdM9Psbl7mx2apwLFIqZAgUKiLL1OPkq2AZALn4Vzs0Z6+F6L0IjV71YqFqliEreUVJYTRhd6zTH2scl2OdTS3WXk2E1WKSvHTSwx0KaAgiMsVfiAW3vCVpMnODgrGcsu/cknGs3EBvdJZPrIh508BIDY3BSKxwidlESSj/3Fs+WOe61kSwY/j
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c7ac16f-c693-4b11-8666-08d5854c1e09
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0898;
x-ms-traffictypediagnostic: AT5PR8401MB0898:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB089836A87167D41C7606182382DF0@AT5PR8401MB0898.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040519)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041307)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AT5PR8401MB0898;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0898;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(396003)(366004)(39380400002)(377424004)(189003)(199004)(6506007)(5660300001)(478600001)(316002)(2906002)(93886005)(1730700003)(103116003)(68736007)(14454004)(81166006)(8676002)(76176011)(97736004)(81156014)(25786009)(3846002)(6486002)(59450400001)(2351001)(4326008)(105586002)(8936002)(3660700001)(6116002)(36756003)(99286004)(66066001)(106356001)(2501003)(53936002)(3280700002)(6436002)(5640700003)(5250100002)(6512007)(186003)(7736002)(7416002)(26005)(305945005)(229853002)(2900100001)(54906003)(6246003)(2950100002)(86362001)(6916009)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0898;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: zxxdH+AsnAQwotPuFX24J6zxPa0eDGoxH5DoAhnSjDN7jX+qQ/ztiNtWr6kxtFuyVYrbCH5tI+Q1YssKOTkBDteHa4w+/a2er8hZF3gtGF33HmRZ6hvF7E5B2XxGPML+t5XP6rdiMOsdnINjmyHvKjVrFrjhmBGSzYVxyPka/fUNWySYEqdqDE9GVi4O3YWqX7y7ZiN5CEJfQ3FUkD8NtbNGoTKl1owLhcRKBRkRtfGipDSCTiPotHX9n+7zCIdnNXwvgafREFnRFky1qemFav/rUOPKBTaog/O7rUtIE7XNfO0M8fBP6xWdk7AJMpqPSjMwzZ7ThfWNxiBBjy9Z5g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F01D6BD9CA7BAF4DA5EA152F91C9C4C6@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ac16f-c693-4b11-8666-08d5854c1e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 23:27:10.9611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0898
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28NRhvi024061

On Thu, 2018-03-08 at 14:07 -0800, Matthew Wilcox wrote:
> On Thu, Mar 08, 2018 at 03:56:30PM +0000, Kani, Toshi wrote:
> > On Wed, 2018-03-07 at 20:00 -0800, Matthew Wilcox wrote:
> > > On Wed, Mar 07, 2018 at 11:32:26AM -0700, Toshi Kani wrote:
> > > > +/**
> > > > + * pud_free_pmd_page - clear pud entry and free pmd page
> > > > + *
> > > > + * Returns 1 on success and 0 on failure (pud not cleared).
> > > > + */
> > > > +int pud_free_pmd_page(pud_t *pud)
> > > > +{
> > > > +	return pud_none(*pud);
> > > > +}
> > > 
> > > Wouldn't it be clearer if you returned 'bool' instead of 'int' here?
> > 
> > I thought about it and decided to use 'int' since all other pud/pmd/pte
> > interfaces, such as pud_none() above, use 'int'.
> 
> These interfaces were introduced before we had bool ... I suspect nobody's
> taken the time to go through and convert them all.

I see.  Since this patchset already changes core, arm and x86, and will
be back ported to stables.  So, if you do not mind, I'd like to leave it
consistent with others with 'int', and make the footstep minimum.

Thanks,
-Toshi
