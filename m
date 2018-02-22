Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeBVWVj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 17:21:39 -0500
Received: from mail-dm3nam03on0045.outbound.protection.outlook.com ([104.47.41.45]:4097
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751694AbeBVWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 17:21:37 -0500
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC][PATCH 03/10] x86/mm: introduce "default" kernel PTE mask
Thread-Topic: [RFC][PATCH 03/10] x86/mm: introduce "default" kernel PTE mask
Thread-Index: AQHTrBzoSfVo0zVcj0Ol7arbW6MACKOw/sOA
Date: Thu, 22 Feb 2018 22:21:34 +0000
Message-ID: <57A9625E-3F25-402B-8B54-129A68449C48@vmware.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203656.25C9B4EC@viggo.jf.intel.com>
In-Reply-To: <20180222203656.25C9B4EC@viggo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR05MB224;7:gPbUPSckaN3UQG7sIVo/n3z+/iPzN3FuRil3ptDKC1qEaH4suq+nhapKTndQVZxU6vBDrAxduwoVYj6FxdHnYsqdE2/CVEa05ftp0OdgMGasGOQfxhRBqttsbFcKj5JIjbXRIM7JoHCda0VivMUpRzW92XhdCyzzXVg9QcIbhiP2Krv57lfvus6K56Xc6oOM+N0rtRe0hgqbnB3RqVtDnD7GMX7BEOTVtV/QTlU8LndPXm8c6kpvAqmcF+dqFpYZ;20:tih1lOSJIDcD4z3qo/qShowG+u4nQgFNFYfMp4Akwzwkn+FF/iKR2dQoew+WnXqMdsmfsuFrqyl2TrC5NigjfB/pskDuoNf/cl8KeCxPhwoPwCRX4GwzV/0U6iwuavW7BdUVPppDannbUUw9A+ftNgjlSHYpdM5W/3wQZ6Zu33w=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 06f01773-6089-469a-3c37-08d57a42a227
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BY2PR05MB224;
x-ms-traffictypediagnostic: BY2PR05MB224:
x-microsoft-antispam-prvs: <BY2PR05MB22476C471B955E6E5C96E2AD0CD0@BY2PR05MB224.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231166)(944501161)(52105095)(3002001)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR05MB224;BCL:0;PCL:0;RULEID:;SRVR:BY2PR05MB224;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(199004)(189003)(2906002)(6486002)(97736004)(54906003)(86362001)(316002)(82746002)(6436002)(36756003)(66066001)(81156014)(478600001)(33656002)(8676002)(99286004)(2900100001)(5660300001)(8936002)(14454004)(81166006)(105586002)(106356001)(6916009)(53936002)(83716003)(2950100002)(3280700002)(6116002)(4326008)(102836004)(6246003)(3660700001)(25786009)(229853002)(6506007)(3846002)(6346003)(186003)(26005)(77096007)(6512007)(68736007)(7736002)(76176011)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR05MB224;H:BY2PR05MB2215.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-message-info: yIP2hVSgynOyMww3mw3Dkohf7dmauv70ZnTfRVK2mFS5kVP2T6no8Di5719axFyMDqiBMc4y6D+v0kC7PZASJRa1WTzB13OlZ0HFPe/U2YNUrujKkNgpSGixwRt85yXWrP8aKjVwaw8vziw9Te76f3EE3pDKvMfsJ93atAkScWs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A47247B49C5AF4B8C656B3C613E318A@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f01773-6089-469a-3c37-08d57a42a227
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 22:21:34.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR05MB224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MMLsqq009933

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The __PAGE_KERNEL_* page permissions are "raw".  They contain bits
> that may or may not be supported on the current processor.  They
> need to be filtered by a mask (currently __supported_pte_mask) to
> turn them into a value that we can actually set in a PTE.
> 
> These __PAGE_KERNEL_* values all contain _PAGE_GLOBAL.  But, with
> PTI, we want to be able to support _PAGE_GLOBAL (have the bit set
> in __supported_pte_mask) but not have it appear in any of these
> masks by default.

There might be a potential issue with this approach. __supported_pte_mask is
exported, so out-of-tree modules might use it. They therefore can
unknowingly use this value to set PTEs with _PAGE_GLOBAL set.

I do not know if it is a real issue, but leaving __supported_pte_mask as it
is now (with _PAGE_GLOBAL masked), and using a different variable for with
_PAGE_GLOBAL unmasked (i.e., the real “__supported_pte_mask”) can solve it.
