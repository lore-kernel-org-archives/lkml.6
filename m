Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbeCHXIk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:08:40 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:31817 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:08:38 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "luto@kernel.org" <luto@kernel.org>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "julia.cartwright@ni.com" <julia.cartwright@ni.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>, "bp@suse.de" <bp@suse.de>,
        "gratian.crisan@ni.com" <gratian.crisan@ni.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "gratian@gmail.com" <gratian@gmail.com>
Subject: Re: Kernel page fault in vmalloc_fault() after a preempted ioremap
Thread-Topic: Kernel page fault in vmalloc_fault() after a preempted ioremap
Thread-Index: AQHTtxziQtlM51KvoU6CmjuDs6qNDKPG602AgAAC2ACAABTxgA==
Date: Thu, 8 Mar 2018 23:08:34 +0000
Message-ID: <1520553209.2693.110.camel@hpe.com>
References: <87a7vi1f3h.fsf@kerf.amer.corp.natinst.com>
         <1520548101.2693.106.camel@hpe.com>
         <CALCETrUB0brd92Tuv_cgakTgBo8yXxaAC1eLUMePMNsoWPK+mw@mail.gmail.com>
In-Reply-To: <CALCETrUB0brd92Tuv_cgakTgBo8yXxaAC1eLUMePMNsoWPK+mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.211.195.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6SPR00MB237;7:vSgJcMsdy78IUcHgekZEE8HOS9vuiPi4PNcYE8yrVnx/wEHuaYdAuB7divKAQ0tP8VsHDsiP6MKZgZez06Qn8lKeQZCZe6SAW6SPvRoXgvL6KUBe4ym7P6BRpWkoAtY6LLL6Gzq/dOlP3DTdmdSITpZG0bRghkIhOnOxfDiiois4BDE1iaI/ZEj3fr7Yomc3cBbezAx9jZDjnWttxD6dOIzz3iJiIZs9WTFYzVOT8tRfbxRxK+BFR+SEphTl1rr9
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94ef9049-e6a9-4733-a448-08d5854984a2
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:BN6SPR00MB237;
x-ms-traffictypediagnostic: BN6SPR00MB237:
x-microsoft-antispam-prvs: <BN6SPR00MB237E1B41D799C7CBB92B95182DF0@BN6SPR00MB237.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040518)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041306)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6SPR00MB237;BCL:0;PCL:0;RULEID:;SRVR:BN6SPR00MB237;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39380400002)(39860400002)(366004)(51444003)(377424004)(199004)(51914003)(189003)(76104003)(6436002)(2351001)(81166006)(81156014)(5640700003)(39060400002)(2501003)(2950100002)(4326008)(6916009)(6486002)(7736002)(305945005)(5660300001)(97736004)(478600001)(7416002)(1730700003)(14454004)(5250100002)(25786009)(36756003)(229853002)(106356001)(66066001)(53936002)(6246003)(103116003)(8936002)(8676002)(2900100001)(53546011)(2906002)(6512007)(6506007)(68736007)(86362001)(26005)(54906003)(76176011)(6116002)(59450400001)(105586002)(3846002)(102836004)(186003)(3660700001)(99286004)(316002)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6SPR00MB237;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: P+TFRnQw6Tvk/7Sk+234nQ9YQbA5Kcv5bl+UAhDLLa+DX0VyCgsXyladdaTTrVjSfsy5JAPD9s37+naOUYv5P2Zhrq/MEQL8rTyPbKNlyiujfV5TXgPIXbYRtQBMBXXfXx9LEiaw4+EYbQ9Xv2L1j7YACt33+0roXeyd7cJ0aAvDIeyc0O9TlqnANpGBZuLHhubXxskxwHSfuCx502UjSoDE+FVMNJqkdHRWSEzO/xXBX8ww6xMfzNLxx13hpoCIu3hldWhWtFBhhyDlEanxFmGNxswWxayJ3BLjviu7iyEQuNACaJs+p0CHrp4wgeSphqIfyyNEin0iEOQqC69fxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A124B64618EF047B87038BE93DAC2AD@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef9049-e6a9-4733-a448-08d5854984a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 23:08:34.6270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6SPR00MB237
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28N8hX3022153

On Thu, 2018-03-08 at 22:38 +0000, Andy Lutomirski wrote:
> On Thu, Mar 8, 2018 at 9:43 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> > On Thu, 2018-03-08 at 14:34 -0600, Gratian Crisan wrote:
 :
> > 
> > Thanks for the report and analysis!  I believe pud_large() and
> > pmd_large() should have been used here.  I will try to reproduce the
> > issue and verify the fix.
> 
> Indeed.  I find myself wondering why pud_huge() exists at all.
> 
> While you're at it, I think there may be more bugs in there.
> Specifically, the code walks the reference and current tables at the
> same time without any synchronization and without READ_ONCE()
> protection.  I think that all of the BUG() calls below the comment:
> 
>         /*
>          * Below here mismatches are bugs because these lower tables
>          * are shared:
>          */
> 
> are bogus and could be hit due to races.  I also think they're
> pointless -- we've already asserted that the reference and loaded
> tables are literally the same pointers.  I think the right fix is to
> remove pud_ref, pmd_ref and pte_ref entirely and to get rid of those
> BUG() calls.
> 
> What do you think?

I agree that these BUG() checks are pointless.  I will remove them in
this opportunity.

Thanks,
-Toshi
