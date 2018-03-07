Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933706AbeCGRdS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:33:18 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10938 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933278AbeCGRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:33:15 -0500
X-IronPort-AV: E=Sophos;i="5.47,436,1515427200";
   d="scan'208";a="73657148"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tursulin@ursulin.net" <tursulin@ursulin.net>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
Subject: Re: [PATCH 6/6] lib/scatterlist: Drop order argument from
 sgl_free_n_order
Thread-Topic: [PATCH 6/6] lib/scatterlist: Drop order argument from
 sgl_free_n_order
Thread-Index: AQHTthJ6KXzzpEGpZE+JXaJ5GDOoGKPE9SWAgAAQsICAAAK/AA==
Date: Wed, 7 Mar 2018 17:33:12 +0000
Message-ID: <1520443990.2890.30.camel@wdc.com>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
         <20180307124712.14963-7-tvrtko.ursulin@linux.intel.com>
         <1520439817.2890.21.camel@wdc.com>
         <37786476-a4e8-ce70-abff-35d99413fa68@ursulin.net>
In-Reply-To: <37786476-a4e8-ce70-abff-35d99413fa68@ursulin.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0846;7:qybpUuyYvFi9NpjKSmRsafyNP01LoVCGAoLYSE0msR2eaSbf/nueER59F8cxm13fagu93oVWFJ+wfrwIVzWaRrShoipFnrP9ZphMpvGcAlzAUi0YjtJ9PLdAqjXXjjhaXsGsL9qvYNhP5wJE+vVof49G4gfftHzWdRMYPHIVHA8yigNfKIm3NrB19a3xEOubz+zuJ9i9YbnjuNUm//UAXkDi0pUQqn5W1iQ+jfS6928FuGpORmyLFaMmXnBhrVKy;20:usIRSJWWtuepKmC6gNwr0cHY16/5bZTtPCCXOLfaCixCa8d2T7yVS+4NJUaTA4XOnhAxXzROUBVVm8aOSvW4Gr++UnqprUtwMXAI+RcJh8Fs3fr6K6kObq3ZQvxH5HdSnOtjSMDtYPaKgY81fugwC8NFsadoOn/yNU7YOUjpCWA=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41d19072-9c84-49a3-55de-08d58451808e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0846;
x-ms-traffictypediagnostic: MWHPR04MB0846:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0846BA1EB533722F67E14F7498D80@MWHPR04MB0846.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0846;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0846;
x-forefront-prvs: 0604AFA86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(376002)(396003)(346002)(199004)(189003)(377424004)(36756003)(2950100002)(7736002)(8936002)(97736004)(68736007)(103116003)(305945005)(106356001)(81166006)(2906002)(81156014)(26005)(8676002)(5250100002)(6116002)(2501003)(3846002)(186003)(14454004)(25786009)(478600001)(72206003)(99286004)(76176011)(316002)(3280700002)(105586002)(93886005)(54906003)(110136005)(102836004)(59450400001)(3660700001)(66066001)(53936002)(6436002)(6512007)(6506007)(6486002)(229853002)(86362001)(5660300001)(6246003)(4326008)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0846;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 1DAWV+heS4w1HkTMX24L8g+JLz9y/Ebx+2td5ZhLL4ZYPIgzZQCg61LyWBkHtgQ4pcNLo1KYjCAa3SuV8TClBWp3R2npuwSV283hB6kVMkkQVm8FQHgE5ql/KgAJxo7Z1awy24lV6XWvRuyRMi794SKS8VzwBqwkTJVhffRjqllNZfyb6LsfQqTU356kaSGpTxSuVnRAfPW831BxjkBOpY75NKqKAw1gRX2jBnOAiu4u6mfhWBs44stwy/HKn8oAknsW/+Ytw+Ejnbo8H9FNsDurQbDcLpS3lhWiT/ZDwbrgOVDPcO37exSxz8ryLkze9NMKDJjIRAp8QTlpddxMtA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <716F71403F90FA419317DEE404AFB44D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d19072-9c84-49a3-55de-08d58451808e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 17:33:12.5572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0846
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w27HXMsn018181

On Wed, 2018-03-07 at 17:23 +0000, Tvrtko Ursulin wrote:
> Ok I guess my main questions are the ones from the cover letter - where 
> is this API going and why did it get in a bit of a funky state? Because 
> it doesn't look fully thought through and tested to me.

Funky state? Not fully tested? Except for the error paths and upper length
limits the sgl allocation and freeing functions have been tested thoroughly.

> My motivation is that I would like to extend it to add 
> sgl_alloc_order_min_max, which takes min order and max order, and 
> allocates as large chunks as it can given those constraints. This is 
> something we have in i915 and could then drop our implementation and use 
> the library function.

That sounds useful to me.

> But I also wanted to refactor sgl_alloc_order to benefit from the 
> existing chained struct scatterlist allocator. But SGL API does not 
> embed into struct sg_table, neither it carries explicitly the number of 
> nents allocated, making it impossible to correctly free with existing 
> sg_free_table.

It is on purpose that sgl_alloc_order() returns a struct scatterlist
instead of any structure built on top of struct scatterlist. If you have
a look at the sgl_alloc*() callers then you will see that nontrivial
changes in these callers are required to make them use something else than
a struct scatterlist pointer. But if you would like to rework those callers
that's fine with me. I can help with reviewing the code I'm familiar with.

> Also I am not sure if a single gfp argument to sgl_alloc_order is the 
> right thing to do. I have a feeling you either need to ignore it for 
> kmalloc_array, or pass in two gfp_t arguments to be used for metadata 
> and backing storage respectively.

If there is a caller that needs this feel free to make this change. But
please don't make this change before there is a caller that needs it.

Thanks,

Bart.
