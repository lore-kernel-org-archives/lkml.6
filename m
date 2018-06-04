Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbeFDT4K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:56:10 -0400
Received: from mail-dm3nam03on0087.outbound.protection.outlook.com ([104.47.41.87]:60306
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750985AbeFDT4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:56:08 -0400
From: Nadav Amit <namit@vmware.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <JBeulich@suse.com>, Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/9] x86: macrofying inline asm for better compilation
Thread-Topic: [PATCH v2 0/9] x86: macrofying inline asm for better compilation
Thread-Index: AQHT/DL0eparP/eyC0SR2jvhohModaRQdbcAgAAOBYA=
Date: Mon, 4 Jun 2018 19:56:04 +0000
Message-ID: <AC3A577C-3DB6-4F12-8392-A67F0461CBCB@vmware.com>
References: <20180604112131.59100-1-namit@vmware.com>
 <20180604190552.hm5e6zcabeyxt26u@treble>
In-Reply-To: <20180604190552.hm5e6zcabeyxt26u@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2461;7:8qSTTrjpMo/tv3ibQKxva9PbsLiW2jI7ZKZXjD/x6GIG8hOEHkS5J1XWMVWBpjWa0HbRuQCIP3l8k9xOKGg6sH7YtFiscjGvQcsBzslJlFgkP5yXOZfTfc+wcV/qXoy+uLeCq4hVnP1WrQGIP08zM0lyMN6pl7aRCAO5O6drB3ErfWb5c2SleyJX9WPluXDie5OSIIb7voj7omBY07BhWpM49+vqy9X3+e4t3kBaeMgwB2zTy/0d51ang/YL5kyb;20:jkXuF87J1QY6cQyzljM61oJKs/Hi9IvCYdiHRXDOqAcxueSOs0JT9IUZ3NKy23bArYUSkcuCgBeVEIoAGtx14LDzC2+0Q6Q9xwgJRZmmQR2afYCCzuehpsdSYWB5frVxAhPUD9qQFaBUwQ4M7/HLhVc9FdMLnAZQe6BIeLED+0o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2461;
x-ms-traffictypediagnostic: SN2PR05MB2461:
x-microsoft-antispam-prvs: <SN2PR05MB2461BEFDAE2F49A7B27E7F4CD0670@SN2PR05MB2461.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2461;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2461;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(25786009)(5660300001)(83716003)(6506007)(316002)(3280700002)(7416002)(66066001)(6116002)(3846002)(6512007)(33656002)(6916009)(6246003)(186003)(99286004)(53936002)(2900100001)(229853002)(476003)(6436002)(446003)(6486002)(86362001)(36756003)(2616005)(76176011)(11346002)(68736007)(14454004)(4326008)(26005)(2906002)(105586002)(7736002)(106356001)(102836004)(81166006)(81156014)(305945005)(3660700001)(5250100002)(54906003)(486006)(97736004)(8676002)(82746002)(478600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2461;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qqDz9JWvgTbk26tkjTXD9IAdIOczLZqH9vbGyf/NHW2lOeZdW5zD+2iz0noKpczvuYakvPC6y3Xic5u1zuxShR1Ih105EZIBKs16FAOQz/ItaPGLRvzv6UzKWmcFrCi/hb3kg6mVpYZHCqdiq0H7H9ysKqxICVFno/wsQtQpJoTo0Av+plQzpTkwr9wv+Ba9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4F97654ADEEF2488222902D198D21B3@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 26c89de9-9afb-4d74-4b9a-08d5ca553457
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c89de9-9afb-4d74-4b9a-08d5ca553457
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 19:56:04.0529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2461
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w54JuEST010745

Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Jun 04, 2018 at 04:21:22AM -0700, Nadav Amit wrote:
>> This patch-set deals with an interesting yet stupid problem: kernel code
>> that does not get inlined despite its simplicity. There are several
>> causes for this behavior: "cold" attribute on __init, different function
>> optimization levels; conditional constant computations based on
>> __builtin_constant_p(); and finally large inline assembly blocks.
>> 
>> This patch-set deals with the inline assembly problem. I separated these
>> patches from the others (that were sent in the RFC) for easier
>> inclusion. I also separated the removal of unnecessary new-lines which
>> would be sent separately.
>> 
>> The problem with inline assembly is that inline assembly is often used
>> by the kernel for things that are other than code - for example,
>> assembly directives and data. GCC however is oblivious to the content of
>> the blocks and assumes their cost in space and time is proportional to
>> the number of the perceived assembly "instruction", according to the
>> number of newlines and semicolons. Alternatives, paravirt and other
>> mechanisms are affected, causing code not to be inlined, and degrading
>> compilation quality in general.
>> 
>> The solution that this patch-set carries for this problem is to create
>> an assembly macro, and then call it from the inline assembly block.  As
>> a result, the compiler sees a single "instruction" and assigns the more
>> appropriate cost to the code.
>> 
>> To avoid uglification of the code, as many noted, the macros are first
>> precompiled into an assembly file, which is later assembled together
>> with the the C files. This also enables to avoid duplicate
>> implementation that was set before for the asm and C code. This can be
>> seen in the exception table changes.
>> 
>> Overall this patch-set slightly increases the kernel size (my build was
>> done using my Ubuntu 18.04 config + localyesconfig for the record):
>> 
>>   text	   data	    bss	    dec	    hex	filename
>> 18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
>> 18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+0.1%)
>> 
>> The number of static functions in the image is reduced by 379, but
>> actually inlining is even better, which does not always shows in these
>> numbers: a function may be inlined causing the calling function not to
>> be inlined.
>> 
>> The Makefile stuff may not be too clean. Ideas for improvements are
>> welcome.
>> 
>> v1->v2:	* Compiling the macros into a separate .s file, improving
>> 	  readability (Linus)
>> 	* Improving assembly formatting, applying most of the comments
>> 	  according to my judgment (Jan)
>> 	* Adding exception-table, cpufeature and jump-labels
>> 	* Removing new-line cleanup; to be submitted separately
> 
> How did you find these issues?  Is there some way to find them
> automatically in the future?  Perhaps with a GCC plugin?

Initially I found it while developing something unrelated and seeing the
disassembly going crazy for no good reason.

One way to see problematic functions is finding duplicate static functions,
which mostly happens when inline function in a header is not inlined:

	nm ./vmlinux | grep ' t ' | cut -d' ' -f3 | uniq -c | sort | \
	grep -v '      1’ 

But due to all kind of reasons (duplicate function names, inlined functions
which are being set a function pointers), it still requires manual work to
filter the false-positive.

Another way is to look on small functions, doing something like:
	nm --print-size ./vmlinux | grep ' t ' | cut -d' ' -f2- | sort | \
	head -n 10000

But again, there are many false-positives so I only looked at functions that
I know or only considered those that are marked as “inline”.

I don’t know how this process can be fully automated.

Regards,
Nadav
