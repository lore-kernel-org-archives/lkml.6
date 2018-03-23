Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeCWTMz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:12:55 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:20899
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752105AbeCWTMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:12:53 -0400
From: Nadav Amit <namit@vmware.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 09/11] x86/pti: enable global pages for shared areas
Thread-Topic: [PATCH 09/11] x86/pti: enable global pages for shared areas
Thread-Index: AQHTws71NUJeW1FkN0SdPdI31gfiM6PeMD+A
Date: Fri, 23 Mar 2018 19:12:50 +0000
Message-ID: <7B08037D-1682-406D-90F1-C2B5B1899F7F@vmware.com>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <20180323174500.64BD3D36@viggo.jf.intel.com>
In-Reply-To: <20180323174500.64BD3D36@viggo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2718;7:m7rBtsiLC5eKNqI5zIsE3iKN9FaY0SXutJReNt6jJ7XKEt5V3BE4IjnLJL4ofNafz4Rv5o5ALUmsX7ggtVpvtm5GRthfCL1umVPbYTJ3VDa7iMUIs7ZKitP6fL49fy449WlZuLYTST8+SfPVCbWCXALejAo4mc/MuDxtY/vZ+1nFnvLBqI3iynyPiOeVgighdkwh1BcdHh4tPAb1ksnQwRttObdOf1jyTFPAguoCGxD/TGf8bCWtvOjjf9VrnSIW;20:yZszk/jHi9hIVh+n51hkUr8i0rWq7zaOsFqQPkNtdxGwsMYjf8divIAkowulv66BM0sakcf9lpzJFL+EDodTN1mNwC+y8zBFNzvGGjSQ68qNoXs4eWJ1urx10VtMnojw11vxR+h7/MajA7EYKwpZVmvtO29o9lFvj5UlZk7SRJg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2f146f53-425b-4979-2f34-08d590f2128a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2718;
x-ms-traffictypediagnostic: SN2PR05MB2718:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB271887F772E9B7B2BB8E698DD0A80@SN2PR05MB2718.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR05MB2718;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2718;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(376002)(396003)(346002)(39860400002)(199004)(189003)(81156014)(82746002)(2906002)(81166006)(25786009)(97736004)(106356001)(99286004)(316002)(102836004)(86362001)(478600001)(54906003)(6246003)(2616005)(3846002)(76176011)(6506007)(6116002)(8676002)(3660700001)(5250100002)(6916009)(4326008)(7416002)(66066001)(6512007)(26005)(2900100001)(33656002)(186003)(68736007)(3280700002)(305945005)(6436002)(229853002)(105586002)(14454004)(8936002)(11346002)(7736002)(6486002)(5660300001)(36756003)(53936002)(83716003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2718;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: SAK52YB/82nqjCR0G4OE0v9ZOyPGFQpC07a4vE3H8JE8JQeOs6GzcvsefpM5cjy/p6efFrE42L0uq6cUZKMdg0ZuyqCYo0yN9GxOS65yJ6jfFL3bA65GBQUKQYBJWGlnqwAUTOokJb+CQw7H1QLnTmhnhIHJrGWhSZd2HkZ1+vZ6tTA9wkdXNR+RsGKUCi+d8KPArvCU2VedfpyO8bksRQEYuTBwGFVLrxp/CFBXjgBO0gVwZc1JGZSAvVVboqE9jk9hoQ2O9sTxhXvHyBVhICAYN+g/XYSlxcAPaIlEiItjOsjhsFtHQYDyBUcUjmUM/g4k08F4/6zQPrFlmq5tPA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68D286D9C7305E439D4DBD5FE5AAAEFC@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f146f53-425b-4979-2f34-08d590f2128a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 19:12:50.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2718
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2NJD1GQ000774

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The entry/exit text and cpu_entry_area are mapped into userspace and
> the kernel.  But, they are not _PAGE_GLOBAL.  This creates unnecessary
> TLB misses.
> 
> Add the _PAGE_GLOBAL flag for these areas.
> 
> static void __init
> diff -puN arch/x86/mm/pti.c~kpti-why-no-global arch/x86/mm/pti.c
> --- a/arch/x86/mm/pti.c~kpti-why-no-global	2018-03-21 16:32:00.799192311 -0700
> +++ b/arch/x86/mm/pti.c	2018-03-21 16:32:00.803192311 -0700
> @@ -300,6 +300,13 @@ pti_clone_pmds(unsigned long start, unsi
> 			return;
> 
> 		/*
> +		 * Setting 'target_pmd' below creates a mapping in both
> +		 * the user and kernel page tables.  It is effectively
> +		 * global, so set it as global in both copies.
> +		 */
> +		*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
if (boot_cpu_has(X86_FEATURE_PGE)) ?
