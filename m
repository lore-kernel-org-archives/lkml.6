Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964894AbeE2QKe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:10:34 -0400
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:22883 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935546AbeE2QK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:10:29 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>
Subject: Re: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
Thread-Topic: [PATCH v3 3/3] x86/mm: add TLB purge to free pmd/pte page
 interfaces
Thread-Index: AQHT7W5Q6qzHG3nfSE+qaMtuTJE19KRG3EYAgAAXkYA=
Date: Tue, 29 May 2018 16:10:24 +0000
Message-ID: <1527610139.14039.58.camel@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
         <20180516233207.1580-4-toshi.kani@hpe.com>
         <20180529144438.GM18595@8bytes.org>
In-Reply-To: <20180529144438.GM18595@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5SPR00MB04;7:TgHJ6ZLZHBO5eNaFqT4+g7mJq7CDQhNzKTIDHe1GBvKDA2APiemfkymr0UXuqpMjL+TbIBxr72gJOUaU3qsAKBeb0sKDHL80fARw3Q3ymcuNAnJjMnssnQMqrk5a5+DyBzkTV3YcnIG/cmVqACKllG063NnHdvuUc824pucVswhxtQ1KrNpLi8/I0FkzljBPjV/Zdbcp0QJ2xIZUejUJZ6tZ0UtrlmDe455zEelfrIds0+0eSdn28dQHCZzRcVpV
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5SPR00MB04;
x-ms-traffictypediagnostic: AT5SPR00MB04:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5SPR00MB04589465E14F25427A609B826D0@AT5SPR00MB04.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AT5SPR00MB04;BCL:0;PCL:0;RULEID:;SRVR:AT5SPR00MB04;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(377424004)(25786009)(8676002)(36756003)(105586002)(106356001)(316002)(110136005)(97736004)(54906003)(81166006)(81156014)(76176011)(6512007)(3280700002)(8936002)(305945005)(99286004)(6486002)(7416002)(2501003)(5250100002)(103116003)(14454004)(68736007)(2906002)(478600001)(102836004)(6506007)(7736002)(186003)(2900100001)(26005)(3660700001)(2201001)(6436002)(229853002)(6246003)(5660300001)(11346002)(486006)(476003)(4326008)(2616005)(6116002)(446003)(66066001)(3846002)(53936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5SPR00MB04;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rMTU3XR8cEOZZvQXBqA2wEv9qJHmw4OgybyXFNZEbxOqYYj6JBv/M5hxaBBht/47HDnjBt7YMAH/Sz8YdgZP+pC1ek8y9lQLlK6TWTaJzpZIfE2MVJtFERcBPpDlXqTDM782LwtMgNdcGrTK62h9DVoTTf7p5owJVgspHeUSdG+gkAgxrP/enXLDGYYpJksi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE68D1B24EC864AB1AB93BAB88D0146@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a30e496b-5b66-4608-41b6-08d5c57eaff4
X-MS-Exchange-CrossTenant-Network-Message-Id: a30e496b-5b66-4608-41b6-08d5c57eaff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 16:10:24.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5SPR00MB04
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4TGAkP1005036

On Tue, 2018-05-29 at 16:44 +0200, Joerg Roedel wrote:
> On Wed, May 16, 2018 at 05:32:07PM -0600, Toshi Kani wrote:
> >  	pmd = (pmd_t *)pud_page_vaddr(*pud);
> > +	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
> > +	if (!pmd_sv)
> > +		return 0;
> 
> So your code still needs to allocate a full page where a simple
> list_head on the stack would do the same job.

Can you explain why you think allocating a page here is a major problem?
 
As I explained before, pud_free_pmd_page() covers an extremely rare case
 which I could not even hit with a huge number of ioremap() calls until
I instrumented alloc_vmap_area() to force this case to happen.  I do not
think pages should be listed for such a rare case.

> Ingo, Thomas, can you please just revert the original broken patch for
> now until there is proper fix?

If we just revert, please apply patch 1/3 first.  This patch address the
BUG_ON issue on PAE.  This is a real issue that needs a fix ASAP.

The page-directory cache issue on x64, which is addressed by patch 3/3,
is a theoretical issue that I could not hit by putting ioremap() calls
into a loop for a whole day.  Nobody hit this issue, either.

The simple revert patch Joerg posted a while ago causes
pmd_free_pte_page() to fail on x64.  This causes multiple pmd mappings
to fall into pte mappings on my test systems.  This can be seen as a
degradation, and I am afraid that it is more harmful than good.

Thanks,
-Toshi
