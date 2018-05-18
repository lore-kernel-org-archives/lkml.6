Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeEROPr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:15:47 -0400
Received: from mail-co1nam03on0060.outbound.protection.outlook.com ([104.47.40.60]:53382
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750841AbeEROPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:15:42 -0400
From: Nadav Amit <namit@vmware.com>
To: David Laight <David.Laight@ACULAB.COM>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 0/6] Macrofying inline assembly for better compilation
Thread-Topic: [PATCH 0/6] Macrofying inline assembly for better compilation
Thread-Index: AQHT7jbPfAk8nn2e60WOiAkb9cKy1KQ1NowAgABSZwA=
Date: Fri, 18 May 2018 14:15:38 +0000
Message-ID: <4F1E3042-CF9A-423C-BDB2-80ACD1B98488@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <8737d8d4c7e84c47938e9b1aaeae16b9@AcuMS.aculab.com>
In-Reply-To: <8737d8d4c7e84c47938e9b1aaeae16b9@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2527;7:pf0FLetl9cJmIkAMSccKx6KBo1v0F6UqP3Vg7Xk0Y2vb+yvxgzkrhJlCX4udvg5EPNz/8etsNbspKqJw3lobmTIDDZLGygAKAe5Mm7X9xvkCryYQw5MDpdrouKGoEjKgjm8IBsbXDwyTTAqpDHLqUFVntazkEvKg/88cZF1PPED7aX8w0mdPILICBfJ4BD1IjE/unkxkf1FBCNabZoKRB2ycvRW9lXUTjHUSn8QWsa9UGu+UJ9kmtAxWA2L5zGm0;20:pCsvqSG29LpoUyERzeBlJBbU1C4gNsNz3ebttlo9Uj3ImEuiTBG1DMXOYNrOh+cEl6lk20CONCzSrsdsWY3S0yoq1gmkt8niS1Cr47jYuaRamojxxzSDsHXal0lxjveZG0ohq0e5u2UPYzhmnfNin3HRucIlqja/2GwiygXMC7w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39380400002)(39860400002)(199004)(189003)(486006)(6512007)(476003)(305945005)(7736002)(76176011)(86362001)(14454004)(25786009)(6116002)(3846002)(6246003)(446003)(53936002)(54906003)(7416002)(6916009)(2616005)(8936002)(33656002)(5250100002)(11346002)(4326008)(81156014)(81166006)(8676002)(2906002)(102836004)(186003)(3660700001)(82746002)(36756003)(316002)(26005)(106356001)(105586002)(5660300001)(97736004)(3280700002)(6506007)(66066001)(2900100001)(6436002)(68736007)(83716003)(6486002)(99286004)(229853002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2527;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2527;
x-ms-traffictypediagnostic: SN2PR05MB2527:
x-microsoft-antispam-prvs: <SN2PR05MB252762EE3B0CC9E7883045A1D0900@SN2PR05MB2527.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2527;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2527;
x-forefront-prvs: 0676F530A9
x-microsoft-antispam-message-info: zU3rQ7QIAopeYKLWwLPDY8pmEguyFJTD5uPx5EnSp8ruWmsY6WNlQCHh9meUulCThvot/AzVm90fEZ+RbF8kFbFvAG7IELPeY1x6IB3Cx9ZP2g/bnsCmKWVr6XioeSyY/tb9TTP53dyLGko2CqxirhevZxqg0ZwEKFZlf2UkqyH5Iggtm1Caw9k2fjJgN4VN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <15A30C300624144496C77D6FAE6DF4F0@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0fd9c8d9-cd1d-4807-5f24-08d5bcc9d47e
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd9c8d9-cd1d-4807-5f24-08d5bcc9d47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 14:15:38.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2527
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IEFrgc025555

David Laight <David.Laight@ACULAB.COM> wrote:

> From: Nadav Amit
>> Sent: 17 May 2018 17:14
>> This patch-set deals with an interesting yet stupid problem: kernel code
>> that does not get inlined despite its simplicity. There are several
>> causes for this behavior: "cold" attribute on __init, different function
>> optimization levels; conditional constant computations based on
>> __builtin_constant_p(); and finally large inline assembly blocks.
>> 
>> This patch-set deals with the inline assembly problem. I separated these
>> patches from the others (that were sent in the RFC) for easier
>> inclusion.
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
>> appropriate cost to the code. In addition, this patch-set removes
>> unneeded new-lines from common x86 inline asm's, which "confuse" GCC
>> heuristics.
> 
> Can't you get the same effect by using always_inline ?

I wanted and forgot to mention in the cover-letter why always_inline is not
a proper solution:

1. It is not easy to go over 400 functions and mark them as __always_inline.
   Maintaining it afterwards (i.e., removing the __always_inline if the
   function is changed and becomes “heavier") is even harder.

2. The kernel can be configured in a many ways, which would make
   functions more “cheaper” or more “expensive”, so you cannot always
   predetermine whether a function should be inlined.

3. If you mark a function __always_inline you can just cause the calling
   function not to be inlined (when it should be inlined as well). It becomes
   a whack-a-mole.

4. It is not only about inlining. The compiler also makes branch decisions
   based on the perceived cost of the code, including inlined function.

Regards,
Nadav
