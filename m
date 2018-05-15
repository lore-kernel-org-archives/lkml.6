Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEOWOQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:14:16 -0400
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:21472
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751104AbeEOWON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:14:13 -0400
From: Nadav Amit <namit@vmware.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 0/8] Improving compiler inlining decisions
Thread-Topic: [RFC 0/8] Improving compiler inlining decisions
Thread-Index: AQHT7JNaBX0TIj5NlUyn2mGKiojEhaQxWu6A
Date: Tue, 15 May 2018 22:14:08 +0000
Message-ID: <C571168E-D627-4D32-B504-DCD56D50D5C5@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
In-Reply-To: <20180515141124.84254-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2767;7:dXlPZfk2WhTlXJ0QG/vNovgvTZWK5mdbHqxr/od5wy6t9yrxbWKgBlejrAGwf9lPwWYSlaMPr/MSkoukFPES/wRfnF/5THzkKSi8RqnJJMa6ZtTt76TIU7eBD2xo3SsHQjQ3/Jb5E8hb1/8niawzU30X55glUBhnKr0XwpIZcTZHd9dlhs+bdEJVkpHgQNnsXl8JyWTbIe8f0bskFDOnLayh2YD/1Zal9wh4HD27DN0oMlCBL0T1C7ev9ocmydEB;20:5/ue5/ezuYGd2mh3yVzvPRtZ59QQhcHObo1j0ogdFLkLw6cFbvoJfTdvlvnXsbt4NLnZETRCEmEOj+cfx2axclsPU81byAMU2Efqj3wBpLm1te/SwFqi5koYDtJPT+6zSKprjNLlt/Wojn9Ep3Yor+w5oZ09u/x9By4ywK5IfIs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(2900100001)(66066001)(102836004)(53936002)(6916009)(6246003)(14454004)(6512007)(5640700003)(186003)(2501003)(6506007)(4326008)(68736007)(106356001)(2906002)(26005)(105586002)(2351001)(36756003)(76176011)(478600001)(82746002)(5250100002)(5660300001)(6486002)(6436002)(7416002)(229853002)(83716003)(54906003)(86362001)(305945005)(81166006)(81156014)(33656002)(7736002)(11346002)(25786009)(3846002)(6116002)(316002)(97736004)(486006)(8676002)(446003)(3280700002)(476003)(3660700001)(2616005)(8936002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2767;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2767;
x-ms-traffictypediagnostic: SN2PR05MB2767:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB2767482DCBEA139757231C6AD0930@SN2PR05MB2767.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR05MB2767;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2767;
x-forefront-prvs: 0673F5BE31
x-microsoft-antispam-message-info: C34yRgdYA6l/vqDAZGo4FEctbx/f6KG8gScrFtZrGl7g/OxV2PliEw71V8ZjXXKjelTolUjaloVm1O4+wPrQhIatDDr8VAPnFP7PhwHxZt9tjjmQtGkRcgSaN9nQ1+E3oqP1mBjeoEdFP5d+jW7kHvJu7xqJaAa8ZNVMoM2Ba1yJWg3/1j3IkOA0Q6S6TQcv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AC4BC090489D04AA61B53FA42BF2395@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bf35aba4-e06b-4ce6-9661-08d5bab12e79
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf35aba4-e06b-4ce6-9661-08d5bab12e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 22:14:09.2789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2767
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4FMELlH029183

Nadav Amit <namit@vmware.com> wrote:

> This patch-set deals with an interesting yet stupid problem: code that
> does not get inlined despite its simplicity.
> 
> I find 5 classes of causes:
> 
> 1. Inline assembly blocks in which code and data are added to
> alternative sections. The compiler is oblivious to the content of the
> blocks and assumes their cost in space and time is proportional to the
> number of the perceived assembly "instruction", according to the number
> of newlines and semicolons. Alternatives, paravirt and other mechanisms
> are affected.
> 
> 2. Inline assembly with redundant new-lines and semicolons. Similarly to
> (1) this code is considered "heavier" than it actually is.
> 
> 3. Code with constant value optimizations. Quite a few parts of the
> kernel check whether a variable is constant (using
> __builtin_constant_p()) and perform heavy computations in that case.
> These computations are eventually optimized out so they do not land in
> the binary. However, the cost of these computations is also associated
> with the calling function, which might prevent inlining of the calling
> function. ilog2() is an example for such case.
> 
> 4. Code that is marked with the "cold" attribute, including all the
> __init functions. Some may consider it the desired behavior.
> 
> 5. Code that is marked with a different optimization levels. This
> affects for example vmx_vcpu_run(), inducing overheads of up to 10% on
> exit.
> 
> 
> This patch-set deals with some instances of first 3 classes. 
> 
> For (1) we insert an assembly macro, and call it from the inline
> assembly block.  As a result, the compiler sees a single "instruction"
> and assigns the more appropriate cost to the code.
> 
> For (2) the solution is trivial: just remove the newlines.
> 
> (3) is somewhat tricky. The proposed solution is to use
> __builtin_choose_expr() to check whether a variable is actually constant
> instead of using an if-condition or the C ternary operator.
> __builtin_choose_expr() is evaluated earlier in the compilation, so it
> allows the compiler to associate the right cost for the variable case
> before the inlining decisions take place.  So far so good.
> 
> Still, there is a drawback. Since __builtin_choose_expr() is evaluated
> earlier, it can fail to recognize constants, which an if-condition would
> recognize correctly.  As a result, this patch-set only applies it to the
> simplest cases.
> 
> Overall this patch-set slightly increases the kernel size (my build was
> done using localmodconfig + localyesconfig for the record):
> 
>   text    data     bss     dec     hex filename
> 18126699 10066728 2936832 31130259 1db0293 ./vmlinux before
> 18149210 10064048 2936832 31150090 1db500a ./vmlinux after (+0.06%)
> 
> The patch-set eliminates many of the static text symbols:
> Before: 40033
> After:  39632   (-10%)

Oops. Should be -1%... 
