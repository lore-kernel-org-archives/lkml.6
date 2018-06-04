Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeFDWUy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 18:20:54 -0400
Received: from mail-sn1nam02on0089.outbound.protection.outlook.com ([104.47.36.89]:27643
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751232AbeFDWUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 18:20:53 -0400
From: Nadav Amit <namit@vmware.com>
To: Kees Cook <keescook@chromium.org>
CC: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2 3/9] x86: refcount: prevent gcc distortions
Thread-Topic: [PATCH v2 3/9] x86: refcount: prevent gcc distortions
Thread-Index: AQHT/DL1Ah8J0lG8pkqi5s7tpY4moKRQqB2AgAAEEwA=
Date: Mon, 4 Jun 2018 22:20:50 +0000
Message-ID: <BB35D478-3BB6-4C95-9BB0-D49E3C501D37@vmware.com>
References: <20180604112131.59100-1-namit@vmware.com>
 <20180604112131.59100-4-namit@vmware.com>
 <CAGXu5jJFUMsQFhxeZivbQZwQRPwdJr6gD8EkKfzasWr2SBoggQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJFUMsQFhxeZivbQZwQRPwdJr6gD8EkKfzasWr2SBoggQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2525;7:bDYJIuYjAC3LcRmZVasYdQQBhOPu+mo/2IYfIFC6n6GZI4+3GluIcqp8VAcdf/PH7mRWMKDZMJA6uge2QxbbaWDD4+9o6kAdEasSDEkaiP8tJWoIkyBUF/l2JX+U4vH35jSHt8TqEuqCHUkYBa3mctZfs5gnHlNBUwbnv0HMh0aSFUSOHO46nea676BUApSSFsyLOFAFR5hjL5ivnyN2D9h5nr+BPmARYhkkqEhyu53bLu3FRjciQqcnh5uTD7MB;20:t3Bp402AlV1sShgh+KH2p9ogDEFSem0Iu2gWYTqsmcWPRaNG/gxGyOPcn/UQPXbxw5O66efX7FKF7o7rmVuv9hM+OV8XgorWPP4flZpl9uZEmJt2ldJHmTDes6qh8uzXf8Zgje82Hsw3RtJYoWlj/J4ydSw0m0pM6k/H0YDzZKM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2525;
x-ms-traffictypediagnostic: SN2PR05MB2525:
x-microsoft-antispam-prvs: <SN2PR05MB25250778AC0CCD98E7B31D33D0670@SN2PR05MB2525.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2525;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2525;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(39380400002)(199004)(189003)(99286004)(33656002)(6436002)(25786009)(54906003)(14454004)(4326008)(305945005)(7736002)(6246003)(8936002)(6486002)(229853002)(83716003)(6512007)(59450400001)(316002)(53936002)(68736007)(5250100002)(97736004)(81156014)(66066001)(82746002)(76176011)(81166006)(86362001)(8676002)(446003)(2906002)(105586002)(2900100001)(2616005)(6916009)(476003)(11346002)(53546011)(6506007)(478600001)(102836004)(36756003)(106356001)(486006)(186003)(5660300001)(6116002)(3846002)(26005)(3660700001)(3280700002)(87944003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2525;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: G5m0i5wNnG7HoYTtWHViQ243Ziwg/S5UkjufM3TwW84zFyyeNCGA8EwRPm42r6ne6x7Ig/BpYicmGVw/hj4Nc4EoENKh/tReJKpA5O7j1Btn8ksACq23i7Ime6vs7LUGm33wpD7TDrl5WK+GglI14V44NB9mrMrclQgp2xfiQlQfKlktWwA1gX3+40hvjHh5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF2EBDA44FB45C46BD2C511E70C6FD3D@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4d4fe2a8-9b1e-4ba7-6134-08d5ca696e05
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4fe2a8-9b1e-4ba7-6134-08d5ca696e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 22:20:50.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2525
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w54MKxWx018893

Kees Cook <keescook@chromium.org> wrote:

> On Mon, Jun 4, 2018 at 4:21 AM, Nadav Amit <namit@vmware.com> wrote:
>> GCC considers the number of statements in inlined assembly blocks,
>> according to new-lines and semicolons, as an indication to the cost of
>> the block in time and space. This data is distorted by the kernel code,
>> which puts information in alternative sections. As a result, the
>> compiler may perform incorrect inlining and branch optimizations.
>> 
>> The solution is to set an assembly macro and call it from the inlined
>> assembly block. As a result GCC considers the inline assembly block as
>> a single instruction.
>> 
>> This patch allows to inline functions such as __get_seccomp_filter().
>> Interestingly, this allows more aggressive inlining while reducing the
>> kernel size.
>> 
>>   text    data     bss     dec     hex filename
>> 18140970 10225412 2957312 31323694 1ddf62e ./vmlinux before
>> 18140140 10225284 2957312 31322736 1ddf270 ./vmlinux after (-958)
>> 
>> Static text symbols:
>> Before: 40302
>> After:  40286   (-16)
>> 
>> Functions such as kref_get(), free_user(), fuse_file_get() now get
>> inlined.
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Jan Beulich <JBeulich@suse.com>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> 
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> arch/x86/include/asm/refcount.h | 73 ++++++++++++++++++++-------------
>> arch/x86/kernel/macros.S        |  1 +
>> 2 files changed, 45 insertions(+), 29 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
>> index 4cf11d88d3b3..53462f32b58e 100644
>> --- a/arch/x86/include/asm/refcount.h
>> +++ b/arch/x86/include/asm/refcount.h
>> @@ -4,6 +4,9 @@
>>  * x86-specific implementation of refcount_t. Based on PAX_REFCOUNT from
>>  * PaX/grsecurity.
>>  */
>> +
>> +#ifndef __ASSEMBLY__
> 
> Can you swap the order here, so that the asm macros are visible first
> in the file?
> 
> #ifdef __ASSEMBLY__
> ...macros
> #else
> ....C
> #endif

Done. I also noticed that I forgot in one instance (REFCOUNT_CHECK_LT_ZERO)
to explicitly mark the parameter name (“counter=\counter”), so I’ll fix it
as well in the next version.
