Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbeCGXW3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:22:29 -0500
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:2785 "EHLO
        g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbeCGXW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:22:27 -0500
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
Subject: Re: [PATCH 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Topic: [PATCH 2/2] x86/mm: implement free pmd/pte page interfaces
Thread-Index: AQHTtjxkR+Kxy4Y+B0KrmJJxJNoFJ6PFY/iAgAASaoA=
Date: Wed, 7 Mar 2018 23:22:24 +0000
Message-ID: <1520467641.2693.52.camel@hpe.com>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
         <20180307183227.17983-3-toshi.kani@hpe.com>
         <20180307150127.1e09e9826e0f2c80ce42fa4d@linux-foundation.org>
In-Reply-To: <20180307150127.1e09e9826e0f2c80ce42fa4d@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0660;7:aBk9Ew6lCThvJN53jcyOXUhigL70WrmKfLwm+M3fs1VYGxSAabr7Bo+RDHurIhGdTxOpSa0sgdBzRpNrdmA/JXCGeQgpC9PgHiu64VS3rOHSlRO9kOhRVC2NSmShM/vcrwi4EaoHOyOy02Wj7jSV5IOd4e8sX/BCS7EsN4YGnxjwSZrH8ZAHPA4fv4bXYofZD+xcQQxK3KBVCsKzAXV0HdR9hBl+GmYpsbwtshLjh+jncdzPpouf+GUpnnkI3eDt
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc60f149-afc5-44d8-d1a6-08d5848248dd
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0660;
x-ms-traffictypediagnostic: AT5PR8401MB0660:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0660755D66A17B39A7E7FED382D80@AT5PR8401MB0660.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AT5PR8401MB0660;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0660;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39380400002)(39860400002)(376002)(189003)(377424004)(199004)(99286004)(6506007)(66066001)(14454004)(76176011)(6916009)(2950100002)(7736002)(305945005)(1730700003)(8936002)(81156014)(105586002)(2906002)(102836004)(54906003)(3280700002)(26005)(81166006)(8676002)(2900100001)(316002)(478600001)(5660300001)(186003)(7416002)(86362001)(36756003)(6246003)(106356001)(25786009)(3846002)(6116002)(2501003)(4326008)(6486002)(68736007)(2351001)(5250100002)(6436002)(229853002)(53936002)(5640700003)(6512007)(3660700001)(103116003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0660;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: j3tK1+f+/CjGsJdJYP6xVGkxy5bvz8DqbRlVaX7rcl0BmejQVMCdV0YUQc7Lfk1oXE5BXTIYG5SI9/ujapXDMgNnUBP4RMOxgcPJQmuRPo0r5LkFqAYitAN7+gx/c/QdhiuF1p3EoMEgOJuBwoXMS01X/ixb/+wpiV3F+pdzZDkJK9z/Wz3vpxpMNcFa/d3OSW9YepLWoRQGgt12aC5FrCjrzhqsHPkGoggaXTRvKLdCMVa9KS01i0n8tY6M5ahOJOvpFoxMx2/sphrF42CM1kMBGqfKnqxSFS72lvEWJmSV2ajpSNL/+QVV1AB6G8bdV6U3KK23xLnRCzZcuwLYTg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <245FF568C40EC84CA7A33723FC319F6F@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fc60f149-afc5-44d8-d1a6-08d5848248dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 23:22:24.3813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0660
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27NMaoF010408

On Wed, 2018-03-07 at 15:01 -0800, Andrew Morton wrote:
> On Wed,  7 Mar 2018 11:32:27 -0700 Toshi Kani <toshi.kani@hpe.com> wrote:
> 
> > Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
> > clear a given pud/pmd entry and free up lower level page table(s).
> > Address range associated with the pud/pmd entry must have been purged
> > by INVLPG.
> 
> OK, now we have implementations which match the naming ;) Again, is a
> cc:stable warranted?

Right. This patch 2/2 fixes the memory leak on x86.

Fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")

Patch 1/2 fixes the panic on arm64.

Fixes: 324420bf91f60 ("arm64: add support for ioremap() block mappings")

> Do you have any preferences/suggestions as to which tree these should
> be merged through?  You're hitting core, arm and x86.

No, I do not have any preference.

Thanks,
-Toshi
