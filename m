Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751496AbeEROWp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:22:45 -0400
Received: from mail-sn1nam02on0043.outbound.protection.outlook.com ([104.47.36.43]:46601
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751184AbeEROWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:22:44 -0400
From: Nadav Amit <namit@vmware.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Topic: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgABrOoA=
Date: Fri, 18 May 2018 14:22:41 +0000
Message-ID: <B7EA94A4-5AFD-4ED6-BD90-9A5E417FCECB@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
In-Reply-To: <20180518075853.GD12217@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2670;7:bab/SgtaPaUhkgtKn9wlixvV+8I9b6EcNVBh0b89kJvx0ulcKIjjvBN87jDGI//5sPIDiGseTupkGtRkdi9Z6SCX17tq4XkoV9BZ/Z9JLHYQTvRGczD0KGH68NR9EP7VR+xDjtw+i1slE3JxWpnMvQwhB+8Pw2EO1uyQX/ynl1S06eHejDtibYHJrsKXngYH//fYtcVturWsboApnu5bFJZSZt9XQUwEosizfXyHRKlRgvaZi1ce6kZz2K/ytBAc;20:1WA45+sJokXvqOLwrPZ1Gb3KTFCh4p1i9tD2tC9Efy3qU62mbL5WDxs1Jh3APfjyNfPYZliuwO4c6C7u3dZWtNojhaS0V9uwwgaUKpA7setPhDoJ4ast5zW5N4JkUvGwCK9PN+VFY7/WpoxxMv2Yxb5uKQvFQkrQXy12cJam4Sk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2670;
x-ms-traffictypediagnostic: SN2PR05MB2670:
x-microsoft-antispam-prvs: <SN2PR05MB2670517B0BB48EBABF02F61BD0900@SN2PR05MB2670.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2670;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2670;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(199004)(189003)(6486002)(476003)(11346002)(97736004)(2616005)(6436002)(486006)(54906003)(229853002)(3846002)(6116002)(25786009)(6246003)(478600001)(316002)(99286004)(5660300001)(8936002)(33656002)(81156014)(81166006)(446003)(83716003)(2900100001)(14454004)(82746002)(2906002)(305945005)(66066001)(6916009)(106356001)(186003)(3280700002)(68736007)(8676002)(76176011)(6506007)(4326008)(86362001)(5250100002)(7736002)(36756003)(26005)(6512007)(105586002)(102836004)(3660700001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2670;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UsGiwhdN5Caa1JUGo+dFvVvwR7eIv9HOFq+0XSMg9G5vTdWte0qkx14Xf3mu7E3qqbMhy/zbE1sdTJ/nE6cAQt9OMouYSc9LWGb5dcFzIog41UewePhB4G73UKvlKAxBBiBVkBe92karrrRkU/lCXv6h5aVWh8URkzF0WSull3czk2texLktSMTLWc6832Ch
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC2B675763207B499FA1A8721E6256F7@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0017d673-34f5-4e12-e692-08d5bccad099
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0017d673-34f5-4e12-e692-08d5bccad099
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 14:22:41.0237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2670
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IEMoiM025618

Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, May 17, 2018 at 09:13:58AM -0700, Nadav Amit wrote:
>> +asm(".macro __BUG_FLAGS ins:req file:req line:req flags:req size:req\n"
>> +    "1:\t \\ins\n\t"
>> +    ".pushsection __bug_table,\"aw\"\n"
>> +    "2:\t "__BUG_REL(1b)		"\t# bug_entry::bug_addr\n\t"
>> +    __BUG_REL(\\file)			"\t# bug_entry::file\n\t"
>> +    ".word \\line"			"\t# bug_entry::line\n\t"
>> +    ".word \\flags"			"\t# bug_entry::flags\n\t"
>> +    ".org 2b+\\size\n\t"
>> +    ".popsection\n\t"
>> +    ".endm");
>> +
>> +#define _BUG_FLAGS(ins, flags)                                          \
>> do {									\
>> +	asm volatile("__BUG_FLAGS \"" ins "\" %c0 %c1 %c2 %c3"		\
>> +		     : : "i" (__FILE__), "i" (__LINE__),                \
>> +			 "i" (flags),                                   \
>> 			 "i" (sizeof(struct bug_entry)));		\
>> } while (0)
> 
> This is an awesome hack, but is there really nothing we can do to make
> it more readable? Esp, that global asm doing the macro definition is a
> pain to read.
> 
> Also, can we pretty please used named operands in 'new' code?

It is hard to make the code readable in C, readable in the generated asm,
and to follow the coding style imposed by checkpatch (e.g., no space between
the newline and the asm argument before it).

I considered wrapping the asm macro in a C macro, but AFAIK C macros cannot
emit backslashes.

I thought of suggesting to change “ins” into a vararg and removing the
escaped double-quotes in the C macro, but you ask to use named operands.

So I am out of ideas. Do you have anything else in mind?

Thanks,
Nadav
