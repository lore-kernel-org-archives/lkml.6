Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965381AbeCHP4f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:56:35 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:49562 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934950AbeCHP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:56:33 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "willy@infradead.org" <willy@infradead.org>
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
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Thread-Topic: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Thread-Index: AQHTtjxt4t52sdgOE0CgfWgnpWKg2aPFt3UAgADUqoA=
Date: Thu, 8 Mar 2018 15:56:30 +0000
Message-ID: <1520527285.2693.56.camel@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
         <20180307183227.17983-2-toshi.kani@hpe.com>
         <20180308040016.GB9082@bombadil.infradead.org>
In-Reply-To: <20180308040016.GB9082@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0322;7:BTOLGE9KoNmtc5zyGLwd1ltdJJbLW3z7sst/Szn8VgX+Bm/NDbxL9b8ZUrlvsvy7rQGy3vZNAWGZ12dk7/eKE8L15L27zyMDqWuXj8um0onHXOuAQ7QI9Jz69Eqvx+/2xAXTUSHEep74mTg+sbVw16JDg1RzzGA8UMmFDiz8+ij+kyXTdWQow1kst2DWn1K85++MmAUtt40rhsf0cR/DvS1pVGSuMzpNmBsT1qwnoEaQ1gZgpq+jyFmLF1PAojA7
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: ea8fd5aa-ec3f-427b-5c8a-08d5850d2866
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0322;
x-ms-traffictypediagnostic: AT5PR8401MB0322:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0322B53019794E17BB653B9882DF0@AT5PR8401MB0322.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:AT5PR8401MB0322;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0322;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(396003)(366004)(346002)(377424004)(199004)(189003)(2900100001)(2351001)(105586002)(99286004)(86362001)(2501003)(6246003)(54906003)(2906002)(106356001)(478600001)(316002)(5250100002)(7416002)(2950100002)(6916009)(76176011)(3280700002)(14454004)(3660700001)(6486002)(66066001)(229853002)(5660300001)(186003)(26005)(6436002)(6116002)(8936002)(53936002)(6512007)(4326008)(102836004)(3846002)(97736004)(68736007)(7736002)(36756003)(81156014)(103116003)(81166006)(25786009)(59450400001)(305945005)(8676002)(5640700003)(6506007)(1730700003);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0322;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: u9PPe9ch+ZYasEB/UDMgl3TuB3+1ofQuRPtXG8mZXqAyEmjev7iAv3cQlmRkVO6iM/4kC6vg12iQWASm+JJT1DXCR0MjIQogaC0p0CSJmtFg8/1JPd6lDRFDox4Xq64COPNolDk2X/UyIT3omVNPXCNI48B1qmbupOOwCEvdljjqswwJrbaHDG0xi9QlCr7JOLVCoThBeb5vXqQP39WhFG+NJxe/sWJLygYD6RWx9V3OX2IePfYAmwftPZuh1sLMZ0mFkBfxEBxmA5bWdJsXxTcZvkne5YZGTaMwaiA47qdimVbmwvoaBUY619twdFO43LdYDcB67mDTcsX269Q4iA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <07566710C6CDB64EB527EA8B1AD27212@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8fd5aa-ec3f-427b-5c8a-08d5850d2866
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 15:56:30.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0322
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28Fugiq009095

On Wed, 2018-03-07 at 20:00 -0800, Matthew Wilcox wrote:
> On Wed, Mar 07, 2018 at 11:32:26AM -0700, Toshi Kani wrote:
> > +/**
> > + * pud_free_pmd_page - clear pud entry and free pmd page
> > + *
> > + * Returns 1 on success and 0 on failure (pud not cleared).
> > + */
> > +int pud_free_pmd_page(pud_t *pud)
> > +{
> > +	return pud_none(*pud);
> > +}
> 
> Wouldn't it be clearer if you returned 'bool' instead of 'int' here?

I thought about it and decided to use 'int' since all other pud/pmd/pte
interfaces, such as pud_none() above, use 'int'.

> Also you didn't document the pud parameter, nor use the approved form
> for documenting the return type, nor the calling context.  So I would
> have written it out like this:
> 
> /**
>  * pud_free_pmd_page - Clear pud entry and free pmd page.
>  * @pud: Pointer to a PUD.
>  *
>  * Context: Caller should hold mmap_sem write-locked.
>  * Return: %true if clearing the entry succeeded.
>  */

Will do.

Thanks!
-Toshi
