Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeE3Pjq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:39:46 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:56600 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753474AbeE3Pjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:39:42 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "joro@8bytes.org" <joro@8bytes.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>
Subject: Re: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
Thread-Topic: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
Thread-Index: AQHT7W5Q6qzHG3nfSE+qaMtuTJE19KRG3EYAgAAXkYCAANdEgIAAsmGA
Date: Wed, 30 May 2018 15:39:20 +0000
Message-ID: <1527694673.14039.106.camel@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
         <20180516233207.1580-4-toshi.kani@hpe.com>
         <20180529144438.GM18595@8bytes.org> <1527610139.14039.58.camel@hpe.com>
         <20180530045927.GP18595@8bytes.org>
In-Reply-To: <20180530045927.GP18595@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0866;7:khcvJ6I5Je7uqNMuNEB8xKoWaktlmcNoNFBtwgIo1kMxjTvKZ+WB/5V4rutU10Z2DCbHrdor2SjK9l8E41pkGtR/ZXeAbBBczMJxHeHzJXYhFAZ7y4Hirg28G1JWA8e6Ibhv9daGnvGb7dA0dMdUtGf1hIalLAT3WPCD0P2tnyrqrxk3mMsrnFuInGSODk+wdmCeb2eJaR3StiqBSm2xIhnKu3vcPvWUkZB4HDr/ZAdOKM/oD9+gp60XftrWaSVp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0866;
x-ms-traffictypediagnostic: AT5PR8401MB0866:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0866749257451B535BE52210826C0@AT5PR8401MB0866.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0866;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0866;
x-forefront-prvs: 0688BF9B46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(366004)(39380400002)(199004)(189003)(5640700003)(8676002)(3846002)(6116002)(476003)(2616005)(446003)(86362001)(478600001)(305945005)(7736002)(5660300001)(99286004)(186003)(316002)(54906003)(2501003)(6506007)(76176011)(59450400001)(93886005)(102836004)(6436002)(6916009)(7416002)(11346002)(66066001)(486006)(8936002)(1730700003)(81156014)(81166006)(5250100002)(6486002)(26005)(229853002)(53936002)(3280700002)(106356001)(2351001)(97736004)(103116003)(3660700001)(2900100001)(6246003)(4326008)(6512007)(36756003)(25786009)(14454004)(105586002)(68736007)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0866;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /HCMNvvmmwnZTlqnYSS31WyGr+8lh7h2KMbeq+lXA2IQrEg7KCSDPZOHZyamuAxgzEjG/IEE66i4AoaPV1wId2frCIY/ZiHRmL4aSrRLiUYHcrQ5vKkEePP41RlaIh7soUEcFoU2ycpemr06TbBkMnRHg9pA07yAcEgFod+XwOQkDnZ/qxsO37QTRKMA+MSu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ADD97029483FF44A342DDC6835343AD@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 490f5ed3-7e57-400f-b664-08d5c6438344
X-MS-Exchange-CrossTenant-Network-Message-Id: 490f5ed3-7e57-400f-b664-08d5c6438344
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2018 15:39:20.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0866
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4UFe198027818

On Wed, 2018-05-30 at 06:59 +0200, joro@8bytes.org wrote:
> On Tue, May 29, 2018 at 04:10:24PM +0000, Kani, Toshi wrote:
> > Can you explain why you think allocating a page here is a major problem?
> 
> Because a larger allocation is more likely to fail. And if you fail the
> allocation, you also fail to free more pages, which _is_ a problem. So
> better avoid any allocations in code paths that are about freeing
> memory.

It only allocates a single page.  If it fails to allocate a single page,
this pud mapping request simply falls to pmd mappings, which is only as
bad as your suggested plain revert always does for both pud and pmd
mappings.  Also, this func is called from ioremap() when a driver
initializes its mapping.  If the system does not have a single page to
allocate, the driver has a much bigger issue to deal with than its
request falling back to pmd mappings.  Please also note that this func
is not called from free-memory path.

> > If we just revert, please apply patch 1/3 first.  This patch address the
> > BUG_ON issue on PAE.  This is a real issue that needs a fix ASAP.
> 
> It does not address the problem of dirty page-walk caches on x86-64.

This patch 3/3 fixes it.  Hope my explanation above clarified.

> > The page-directory cache issue on x64, which is addressed by patch 3/3,
> > is a theoretical issue that I could not hit by putting ioremap() calls
> > into a loop for a whole day.  Nobody hit this issue, either.
> 
> How do you know you didn't hit that issue? It might cause silent data
> corruption, which might not be easily detected.

If the test hit that issue, it would have caused a kernel page fault
(freed & cleared pte page still unmapped, or this page reused and
attribute data invalid) or MCE (pte page reused and phys addr invalid)
when it accessed to ioremap'd address.

Causing silent data corruption requires that this freed & cleared pte
page to be reused and re-initialized with a valid pte entry data.  While
this case is possible, the chance of my test only hitting this case
without ever hitting much more likely cases of page fault or MCE is
basically zero.

> > The simple revert patch Joerg posted a while ago causes
> > pmd_free_pte_page() to fail on x64.  This causes multiple pmd mappings
> > to fall into pte mappings on my test systems.  This can be seen as a
> > degradation, and I am afraid that it is more harmful than good.
> 
> The plain revert just removes all the issues with the dirty TLB that the
> original patch introduced and prevents huge mappings from being
> established when there have been smaller mappings before. This is not
> ideal, but at least its is consistent and does not leak pages and leaves
> no dirty TLBs. So this is the easiest and most reliable fix for this
> stage in the release process.

If you think the page directory issue needs a fix ASAP, I believe taking
patch 3/3 is much better option than the plain revert, which will
introduce the fall-back issue I explained.

Thanks,
-Toshi
