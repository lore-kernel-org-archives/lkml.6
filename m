Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBVV1g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:27:36 -0500
Received: from mail-sn1nam02on0058.outbound.protection.outlook.com ([104.47.36.58]:65034
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750776AbeBVV1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:27:35 -0500
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC][PATCH 04/10] x86/espfix: use kernel-default PTE mask
Thread-Topic: [RFC][PATCH 04/10] x86/espfix: use kernel-default PTE mask
Thread-Index: AQHTrBzppP06ODhzzkSqFbT0POLSXKOw76qA
Date: Thu, 22 Feb 2018 21:27:31 +0000
Message-ID: <93613F56-C778-4EA0-8945-A0B8ABC1A5FD@vmware.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203658.80705136@viggo.jf.intel.com>
In-Reply-To: <20180222203658.80705136@viggo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR05MB661;20:SXlwyYNfqJEpjp/FmXehge16nRqZnvk5mPbPXc/mQ+ajiZ+metp/kXTc84onOuFupiVpuUFl4Xl4hhUiU3LEuXZsOFVQ8RxPjfliyQkuPDEjt3lkg9LsovAVrtU1YjYzlc90AFjrpn/Gj8jELm2btriv/9E086wr6iK3KMXHEvo=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: f2577062-77dd-4a03-8e6e-08d57a3b1503
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:BY2PR05MB661;
x-ms-traffictypediagnostic: BY2PR05MB661:
x-microsoft-antispam-prvs: <BY2PR05MB6616233B85A4E3D96C220BFD0CD0@BY2PR05MB661.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231166)(944501161)(52105095)(3002001)(6041288)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR05MB661;BCL:0;PCL:0;RULEID:;SRVR:BY2PR05MB661;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(396003)(346002)(39380400002)(366004)(189003)(199004)(2950100002)(3660700001)(14454004)(6116002)(4326008)(6486002)(26005)(99286004)(33656002)(105586002)(106356001)(229853002)(25786009)(102836004)(3846002)(5660300001)(6346003)(6436002)(86362001)(83716003)(77096007)(6506007)(6512007)(68736007)(53936002)(36756003)(2906002)(305945005)(7736002)(3280700002)(186003)(6916009)(316002)(76176011)(6246003)(2900100001)(66066001)(82746002)(81166006)(81156014)(97736004)(478600001)(54906003)(8936002)(8676002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR05MB661;H:BY2PR05MB2215.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: yov885qzC+H8B2L51HF+Lt+Asgo86Fb1DGsZ3t0azj9RVQNehQVcyosf91j5/+E4nAsb2qaFhrWRQjJYIUR+xBM4sPhS0MoUhqfRH2YzYo1ZBgCz5+MtegN3Wmocno29g13V5bWghJJkjwpA3Hw8WE/887iwrYLpEazDAOAoJJI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <606C13CC94DCAC45B5B64D63B3C506E4@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2577062-77dd-4a03-8e6e-08d57a3b1503
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 21:27:31.5600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR05MB661
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1MLRgj1020605

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> In creating its page tables, the espfix code masks its PGTABLE_PROT
> value with the supported mask: __supported_pte_mask.  This ensures
> that unsupported bits are not set in the final PTE.  But, it also
> sets _PAGE_GLOBAL which we do not want for PTE.  Use
> __default_kernel_pte_mask instead which clears _PAGE_GLOBAL for PTI.

Can you please explain what is your concern? Exposing more gadgets for
speculative ROP attacks?

Or is it a general rule of not exposing any kernel code &data more than
absolutely necessary?
