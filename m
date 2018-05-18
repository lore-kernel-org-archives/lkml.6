Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEROae (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:30:34 -0400
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:26719
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeEROab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:30:31 -0400
From: Nadav Amit <namit@vmware.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Topic: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgAAEMwCAAGkzAA==
Date: Fri, 18 May 2018 14:30:28 +0000
Message-ID: <5C4B73C8-7BFC-4473-9ABD-6E23DD79A09A@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <20180518081354.GA11379@gmail.com>
In-Reply-To: <20180518081354.GA11379@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2526;7:ihLU4vygxYsydX642mV9Su2Qsbkf3atG4tDSlZWBPVpXt6xNS5u00h+5qyPDmT20Gb04gjxcDp3DqnnfPXZ/N6qvtkWnQRb9bH71LwUBG+CIMawMgOYbHkBZBevHB+K2qnAhDNnIqmP9MzR9pJQQThniLToN7QQdJntdSKYdz8NPmOPbZEXzTag7oeS9M7AO78eH+rkDIGpOk7YmyXnzkf6nHC1acEcm/FUtbLI1M1JcH3q/2N8zyb+1DG/kl2a9;20:Z/1HUtcggxX3Q84VuTyutOPlnP2BubPoUCuwMd3BfeHLWrmdbkGg8jPu9P2YS4wpAz33uO0sPcuux3MozklIyBEigcmWd5RtJz+rtQzs8cshhnH9Xz5YkduFk4O6zCnQku/QvmRBbOHWmyrm7pSx9ik0exJYNPqXfXkMbXfXI8k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2526;
x-ms-traffictypediagnostic: SN2PR05MB2526:
x-microsoft-antispam-prvs: <SN2PR05MB25267BFB5536D742939AAB05D0900@SN2PR05MB2526.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(35073007944872);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2526;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2526;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(39380400002)(376002)(189003)(199004)(97736004)(83716003)(14454004)(5250100002)(316002)(54906003)(82746002)(93886005)(6486002)(486006)(25786009)(6436002)(36756003)(2616005)(476003)(229853002)(86362001)(11346002)(446003)(26005)(186003)(478600001)(68736007)(106356001)(76176011)(6506007)(4326008)(5660300001)(7416002)(81156014)(8676002)(81166006)(102836004)(3846002)(6116002)(3660700001)(6916009)(105586002)(3280700002)(33656002)(99286004)(305945005)(66066001)(8936002)(2906002)(6246003)(7736002)(6512007)(2900100001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2526;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: JORIxAaDnekBC+wUO6ApaYmBtaG01/Y9LSuQwcQ/CyQdUptqfFQx1OuaOWerF44ey6XaucFZRr3QuAXyAK/97sRMHjtZvRBa9VuixiLCVGM/vgO5A5ZA47QpNhBGK9ESMe5K9hc1jn359ikPcmwRGUF/1kg1hLk6ay7NwTqqdGu3TOWunZCbzHN+bPVB+btj
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DD1DEC0553BF54ABC8CC19B7C2AFA9E@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a5cfca2f-b36b-4ad6-5bef-08d5bccbe71f
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cfca2f-b36b-4ad6-5bef-08d5bccbe71f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 14:30:28.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2526
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IEUdgk025715

Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Thu, May 17, 2018 at 09:13:58AM -0700, Nadav Amit wrote:
>>> +asm(".macro __BUG_FLAGS ins:req file:req line:req flags:req size:req\n"
>>> +    "1:\t \\ins\n\t"
>>> +    ".pushsection __bug_table,\"aw\"\n"
>>> +    "2:\t "__BUG_REL(1b)		"\t# bug_entry::bug_addr\n\t"
>>> +    __BUG_REL(\\file)			"\t# bug_entry::file\n\t"
>>> +    ".word \\line"			"\t# bug_entry::line\n\t"
>>> +    ".word \\flags"			"\t# bug_entry::flags\n\t"
>>> +    ".org 2b+\\size\n\t"
>>> +    ".popsection\n\t"
>>> +    ".endm");
>>> +
>>> +#define _BUG_FLAGS(ins, flags)                                          \
>>> do {									\
>>> +	asm volatile("__BUG_FLAGS \"" ins "\" %c0 %c1 %c2 %c3"		\
>>> +		     : : "i" (__FILE__), "i" (__LINE__),                \
>>> +			 "i" (flags),                                   \
>>> 			 "i" (sizeof(struct bug_entry)));		\
>>> } while (0)
>> 
>> This is an awesome hack, but is there really nothing we can do to make
>> it more readable? Esp, that global asm doing the macro definition is a
>> pain to read.
>> 
>> Also, can we pretty please used named operands in 'new' code?
> 
> Yes, that's my main worry too about all these inlining changes:
> the very, very marked reduction in the readability of assembly code.
> 
> It's bad to an extent that I'm questioning the wisdom of pandering to a compiler 
> limitation to begin with?
> 
> How about asking GCC for an attribute where we can specify the inlined size of an 
> asm() function? Even if we'll just approximate it due to some vagaries of actual 
> code generation related to how arguments interact with GCC, an explicit byte value 
> will do a heck of a better job of it than some sort of implied, vague 'number of 
> newlines' heuristics ...

If it were to become a GCC feature, I think it is best to be a builtin that
says: consider the enclosed expression as “free”. The problem of poor
inlining decisions is not specific to inline asm. As I mentioned in the RFC,
when there are two code paths for constants and variables based on
__builtin_constant_p(), you can get the “cost” of the constant path for
variables.

It is not hard to add such a feature to GCC, but I don’t know how easy it is
to get new features into the compiler.
